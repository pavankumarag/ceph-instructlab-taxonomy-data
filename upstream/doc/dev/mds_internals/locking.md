# Ceph MDS Locker

## Why use locks?

Locking infrastructure in MDS is (obviously) to protect the state of
various metadata. MDS has different locks covering different portions of
inode and dentry. Moreover, MDS uses different kinds of locks since
different metadata (in inode and dentry) have different behaviour in
different situations. The MDS cache is distributed across multiple MDS
ranks and across all clients. The locking infrastructure serves to
ensure that all ranks and clients are consistent in their view of the
file system.

Data managed by the MDS can be very large to practically have the entire
data set in the memory of a single metadata server. This also results in
a single point of failure. The MDS therefore has a concept of
Distributed Subtree Partition. A directory tree can be divided into
smaller sub-trees. This is done by recording heat (access frequency) of
each node in the directory tree. When a sub-tree heat reaches a
configured threshold, the MDS divides the sub-tree by splitting the
directory fragment. Each fragment is responsible for a part of the
original directory, however, there will be a single authority node for
these fragments. Each MDS can bear the read and write requests after
fragmentation. If a file is very frequently accessed, the MDS will
generate multiple copies distributed across active MDSs to satisfy
concurrent I/Os. Typically, there are multiple clients reading and
writing to files. The MDS defines locking rules for the associated
metadata, e.g., metadata which is rarely modified concurrently such as
UID/GID for an inode, a shared read and exclusive write access rule
would suffice. However, statistics of a directory may need to be updated
by multiple clients at the same time. This large directory may have been
divided (fragmented) into multiple shards and different clients could
write to different shards. These shards can share the read and also
support simultaneous writes.

Therefore, in addition to different lock types that cover different
metadata pieces for an inode, the MDS has lock classes that define
access rules for a particular lock type. Lock types and classes are
explained further in this document.

## Lock Types

MDS defines a handful of lock types associated with different metadata
for an inode or dentry. Lock type protecting metadata for an inode and
dentry are as follows:

    CEPH_LOCK_DN       - dentry
    CEPH_LOCK_DVERSION - dentry version
    CEPH_LOCK_IQUIESCE - inode quiesce lock (a type of superlock)
    CEPH_LOCK_IVERSION - inode version
    CEPH_LOCK_IAUTH    - mode, uid, gid
    CEPH_LOCK_ILINK    - nlink
    CEPH_LOCK_IDFT     - dirfragtree, frags
    CEPH_LOCK_IFILE    - mtime, atime, size, truncate_seq, truncate_size, client_ranges, inline_data
    CEPH_LOCK_INEST    - rstats
    CEPH_LOCK_IXATTR   - xattrs
    CEPH_LOCK_ISNAP    - snaps
    CEPH_LOCK_IFLOCK   - file locks
    CEPH_LOCK_IPOLICY  - layout, quota, export_pin, ephemeral_*

:::: note
::: title
Note
:::

Locking rules when modifying [ctime]{.title-ref} is a bit different -
either under [versionlock]{.title-ref} or under no specific lock at all
(i.e., it can be modified with other locks held, e.g., when modifying
(say) uid/gid under [CEPH_LOCK_IAUTH]{.title-ref}).
::::

## Lock Classes

Lock classes define locking behaviour for the associated lock type
necessary for handling distributed locks. The MDS defines 3 lock
classes:

    LocalLock   - Used for data that does not require distributed locking such as inode or dentry version information. Local locks are versioned locks.

    SimpleLock  - Used for data that requires shared read and mutually exclusive write. This lock class is also the base class for other lock classes and specifies most of the locking behaviour for implementing distributed locks.

    ScatterLock - Used for data that requires shared read and shared write. Typical use is where an MDS can delegate some authority to other MDS replicas, e.g., replica MDSs can satisfy read capabilities for clients.

:::: note
::: title
Note
:::

In addition, MDS defines FileLock which is a special case of ScatterLock
used for data that requires shared read and shared write, but also for
protecting other pieces of metadata that require shared read and
mutually exclusive write.
::::

Classification of lock types are as follows:

    SimpleLock
      CEPH_LOCK_DN
      CEPH_LOCK_IAUTH
      CEPH_LOCK_ILINK
      CEPH_LOCK_IXATTR
      CEPH_LOCK_ISNAP
      CEPH_LOCK_IFLOCK
      CEPH_LOCK_IPOLICY

    ScatterLock
      CEPH_LOCK_INEST
      CEPH_LOCK_IDFT

    FileLock
      CEPH_LOCK_IFILE

    LocalLock
      CEPH_LOCK_DVERSION
      CEPH_LOCK_IVERSION

## Read, Write and Exclusive Locks

There are 3 modes in which a lock can be acquired:

    rdlock - shared read lock
    wrlock - shared write lock
    xlock  - exclusive lock

[rdlock]{.title-ref} and [xlock]{.title-ref} are self explanatory.

[wrlock]{.title-ref} is special since it allows concurrent writers and
is valid for [ScatterLock]{.title-ref} and [FileLock]{.title-ref} class.
From the earlier section it can be seen that [INEST]{.title-ref} and
[IDFT]{.title-ref} are of [ScatterLock]{.title-ref} class.
[wrlock]{.title-ref} allows multiple writers at the same time, .e.g.,
when a (large) directory is split into multiple shards (after
fragmentation) and each shard is \"assigned\" to an active MDS. When new
files are created under these directories, the recursive stats are
independently updated on the active MDSs. Later, to fetch the updated
stats, the \"scattered\" data is aggregated (\"gathered\") on the auth
MDS (of the inode); which typically happens when a [rdlock]{.title-ref}
is requested on this lock type.

:::: note
::: title
Note
:::

MDS also defines [remote_wrlock]{.title-ref} which is primarily used
during rename operations when the destination dentry is on another
(active) MDS than the source MDS.
::::

## Lock States and Lock State Machine

MDS defines various lock states (defined in
[src/mds/locks.h]{.title-ref} source). Not all lock states are valid for
a given lock class. Each lock class defines its own lock transition
rules and are organized as Lock State Machines. The lock states
([LOCK\_\*]{.title-ref}) are not locks themselves, but control if a lock
is allowed to be taken. Each state follows [LOCK\_\<STATE\>]{.title-ref}
or [LOCK\_\<FROM_STATE\>\_\<TO_STATE\>]{.title-ref} naming terminology
and can be summed up as:

    LOCK_SYNC  - anybody (ANY) can read lock, no one can write lock and exclusive lock
    LOCK_LOCK  - no one can read lock, only primary (AUTH) mds can write lock or exclusive lock
    LOCK_MIX   - anybody (ANY) can write lock, no one can read lock or exclusive lock
    LOCK_XLOCK - someone (client) is holding a exclusive lock

The Lock Transition table (section) use the following notions:

    ANY  - Auth or Replica MDS
    AUTH - Auth MDS
    XCL  - Auth MDS or Exclusive client

Other lock states (such as [LOCK_XSYN]{.title-ref},
[LOCK_TSYN]{.title-ref}, etc..) are additional states that are defined
as an optimization for certain client behaviour ([LOCK_XSYN]{.title-ref}
allows clients to keep the buffered writes and not flush it to the OSDs
and temporarily pausing writes).

Intermediate lock states
([LOCK\_\<FROM_STATE\>\_\<TO_STATE\>]{.title-ref}) denote transition of
a lock from one state ([\<FROM_STATE\>]{.title-ref}) to another
([\<TO_STATE\>]{.title-ref}).

Each lock class defines its own Lock State Machine and can be found in
[src/mds/locks.c]{.title-ref} source. The state machines are explained
when discussing Lock Transition in the section below.

## Lock Transition

Transition of lock from one state to another is mostly prompted by a
(client) request or a change that the MDS is undergoing, such as tree
migration. Let\'s consider a simple case of two clients: One client does
a [stat()]{.title-ref} ([getattr()]{.title-ref} or
[lookup()]{.title-ref}) to fetch UID/GID of a inode, and the other
client does a [setattr()]{.title-ref} to change the UID/GID of the same
inode. The first client (most likely) has [As]{.title-ref} (iauth
shared) caps issued to it by the MDS. Now, when the other client does a
[setattr()]{.title-ref} call to the MDS, the MDS adds a
[xlock]{.title-ref} to the inodes\' [authlock]{.title-ref}
([CEPH_LOCK_IAUTH]{.title-ref}):

    Server::handle_client_setattr()
        if (mask & (CEPH_SETATTR_MODE|CEPH_SETATTR_UID|CEPH_SETATTR_GID|CEPH_SETATTR_BTIME|CEPH_SETATTR_KILL_SGUID))
          lov.add_xlock(&cur->authlock);

Note that the MDS adds a bunch of other locks for this inode, but for
now let\'s only work on IAUTH. Now, [CEPH_LOCK_IAUTH]{.title-ref} is a
[SimpleLock]{.title-ref} class, and its lock transition state machine
is:

    // stable     loner  rep state  r     rp   rd   wr   fwr  l    x    caps,other
    [LOCK_SYNC]      = { 0,         false, LOCK_SYNC, ANY,  0,   ANY, 0,   0,   ANY, 0,   CEPH_CAP_GSHARED,0,0,CEPH_CAP_GSHARED },
    [LOCK_LOCK_SYNC] = { LOCK_SYNC, false, LOCK_LOCK, AUTH, XCL, XCL, 0,   0,   XCL, 0,   0,0,0,0 },
    [LOCK_EXCL_SYNC] = { LOCK_SYNC, true,  LOCK_LOCK, 0,    0,   0,   0,   XCL, 0,   0,   0,CEPH_CAP_GSHARED,0,0 },
    [LOCK_SNAP_SYNC] = { LOCK_SYNC, false, LOCK_LOCK, 0,    0,   0,   0,   AUTH,0,   0,   0,0,0,0 },

    [LOCK_LOCK]      = { 0,         false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   0,0,0,0 },
    [LOCK_SYNC_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, ANY,  0,   0,   0,   0,   0,   0,   0,0,0,0 },
    [LOCK_EXCL_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   XCL, 0,   0,   0,0,0,0 },

    [LOCK_PREXLOCK]  = { LOCK_LOCK, false, LOCK_LOCK, 0,    XCL, 0,   0,   0,   0,   ANY, 0,0,0,0 },
    [LOCK_XLOCK]     = { LOCK_SYNC, false, LOCK_LOCK, 0,    XCL, 0,   0,   0,   0,   0,   0,0,0,0 },
    [LOCK_XLOCKDONE] = { LOCK_SYNC, false, LOCK_LOCK, XCL,  XCL, XCL, 0,   0,   XCL, 0,   0,0,CEPH_CAP_GSHARED,0 },
    [LOCK_LOCK_XLOCK]= { LOCK_PREXLOCK,false,LOCK_LOCK,0,   XCL, 0,   0,   0,   0,   XCL, 0,0,0,0 },

    [LOCK_EXCL]      = { 0,         true,  LOCK_LOCK, 0,    0,   REQ, XCL, 0,   0,   0,   0,CEPH_CAP_GEXCL|CEPH_CAP_GSHARED,0,0 },
    [LOCK_SYNC_EXCL] = { LOCK_EXCL, true,  LOCK_LOCK, ANY,  0,   0,   0,   0,   0,   0,   0,CEPH_CAP_GSHARED,0,0 },
    [LOCK_LOCK_EXCL] = { LOCK_EXCL, false, LOCK_LOCK, AUTH, 0,   0,   0,   0,   0,   0,   CEPH_CAP_GSHARED,0,0,0 },

    [LOCK_REMOTEXLOCK]={ LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   0,   0,   0,   0,0,0,0 },

The state transition entries are of type [sm_state_t]{.title-ref} from
[src/mds/locks.h]{.title-ref} source. TODO: Describe these in detail.

We reach a point where the MDS fills in [LockOpVec]{.title-ref} and
invokes [Locker::acquire_locks()]{.title-ref}, which according to the
lock type and the mode ([rdlock]{.title-ref}, etc..) tries to acquire
that particular lock. Starting state for the lock is
[LOCK_SYNC]{.title-ref} (this may not always be the case, but consider
this for simplicity). To acquire [xlock]{.title-ref} for
[iauth]{.title-ref}, the MDS refers to the state transition table. If
the current state allows the lock to be acquired, the MDS grabs the lock
(which is just incrementing a counter). The current state
([LOCK_SYNC]{.title-ref}) does not allow [xlock]{.title-ref} to be
acquired (column [x]{.title-ref} in [LOCK_SYNC]{.title-ref} state),
thereby requiring a lock state switch. At this point, the MDS switches
to an intermediate state [LOCK_SYNC_LOCK]{.title-ref} - signifying
transitioning from [LOCK_SYNC]{.title-ref} to [LOCK_LOCK]{.title-ref}
state. The intermediate state has a couple of purposes - a. The
intermediate state defines what caps are allowed to be held by clients
thereby revoking caps that are not allowed be held in this state, and b.
preventing new locks to be acquired. At this point the MDS sends cap
revoke messages to clients:

    2021-11-22T07:18:20.040-0500 7fa66a3bd700  7 mds.0.locker: issue_caps allowed=pLsXsFscrl, xlocker allowed=pLsXsFscrl on [inode 0x10000000003 [2,head] /testfile auth v142 ap=1 DIRTYPARENT s=0 n(v0 rc2021-11-22T06:21:45.015746-0500 1=1+0) (iauth sync->lock) (iversion lock) caps={94134=pAsLsXsFscr/-@1,94138=pLsXsFscr/-@1} | request=1 lock=1 caps=1 dirtyparent=1 dirty=1 authpin=1 0x5633ffdac000]
    2021-11-22T07:18:20.040-0500 7fa66a3bd700 20 mds.0.locker: client.94134 pending pAsLsXsFscr allowed pLsXsFscrl wanted -
    2021-11-22T07:18:20.040-0500 7fa66a3bd700  7 mds.0.locker: sending MClientCaps to client.94134 seq 2 new pending pLsXsFscr was pAsLsXsFscr

As seen above, [client.94134]{.title-ref} has [As]{.title-ref} caps,
which are getting revoked by the MDS. After the caps have been revoked,
the MDS can continue to transition to further states:
[LOCK_SYNC_LOCK]{.title-ref} to [LOCK_LOCK]{.title-ref}. Since the goal
is to acquire [xlock]{.title-ref}, the state transition continues (as
per the lock transition state machine):

    LOCK_LOCK -> LOCK_LOCK_XLOCK
    LOCK_LOCK_XLOCK -> LOCK_PREXLOCK
    LOCK_PREXLOCK -> LOCK_XLOCK

finally, acquiring [xlock]{.title-ref} on [iauth]{.title-ref}.

TODO: Explain locking order and path traversal locking.

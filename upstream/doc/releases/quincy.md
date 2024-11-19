# Quincy

Quincy is the 17th stable release of Ceph. It is named after Squidward
Quincy Tentacles from Spongebob Squarepants.

## v17.2.7 Quincy

This is the seventh backport release in the Quincy series. We recommend
that all users update to this release.

### Notable Changes

-   [ceph mgr dump]{.title-ref} command now displays the name of the
    Manager module that registered a RADOS client in the
    [name]{.title-ref} field added to elements of the
    [active_clients]{.title-ref} array. Previously, only the address of
    a module\'s RADOS client was shown in the
    [active_clients]{.title-ref} array.
-   mClock Scheduler: The mClock scheduler (default scheduler in Quincy)
    has undergone significant usability and design improvements to
    address the slow backfill issue. Some important changes are:
    -   The \'balanced\' profile is set as the default mClock profile
        because it represents a compromise between prioritizing client
        IO or recovery IO. Users can then choose either the
        \'high_client_ops\' profile to prioritize client IO or the
        \'high_recovery_ops\' profile to prioritize recovery IO.
    -   QoS parameters including reservation and limit are now specified
        in terms of a fraction (range: 0.0 to 1.0) of the OSD\'s IOPS
        capacity.
    -   The cost parameters ([osd_mclock_cost_per_io_usec]()\* and
        [osd_mclock_cost_per_byte_usec]()\*) have been removed. The cost
        of an operation is now determined using the random IOPS and
        maximum sequential bandwidth capability of the OSD\'s underlying
        device.
    -   Degraded object recovery is given higher priority when compared
        to misplaced object recovery because degraded objects present a
        data safety issue not present with objects that are merely
        misplaced. Therefore, backfilling operations with the
        \'balanced\' and \'high_client_ops\' mClock profiles may
        progress slower than what was seen with the
        \'WeightedPriorityQueue\' (WPQ) scheduler.
    -   The QoS allocations in all mClock profiles are optimized based
        on the above fixes and enhancements.
    -   For more detailed information see:
        <https://docs.ceph.com/en/quincy/rados/configuration/mclock-config-ref/>
-   RGW: S3 multipart uploads using Server-Side Encryption now replicate
    correctly in multi-site. Previously, the replicas of such objects
    were corrupted on decryption. A new tool,
    `radosgw-admin bucket resync encrypted multipart`, can be used to
    identify these original multipart uploads. The `LastModified`
    timestamp of any identified object is incremented by 1 nanosecond to
    cause peer zones to replicate it again. For multi-site deployments
    that make any use of Server-Side Encryption, we recommended running
    this command against every bucket in every zone after all zones have
    upgraded.
-   CephFS: MDS evicts clients which are not advancing their request
    tids which causes a large buildup of session metadata resulting in
    the MDS going read-only due to the RADOS operation exceeding the
    size threshold. [mds_session_metadata_threshold]{.title-ref} config
    controls the maximum size that a (encoded) session metadata can
    grow.
-   CephFS: After recovering a Ceph File System post following the
    disaster recovery procedure, the recovered files under
    [lost+found]{.title-ref} directory can now be deleted.
-   Dashboard: There is a new Dashboard page with an improved layout.
    Active alerts and some important charts are now displayed inside
    cards. This new dashboard can be disabled and the older layout
    brought back by setting `ceph dashboard feature disable dashboard`.

### Changelog

-   .github: Clarify checklist details
    ([pr#54131](https://github.com/ceph/ceph/pull/54131), Anthony
    D\'Atri)
-   .github: Give folks 30 seconds to fill out the checklist
    ([pr#51944](https://github.com/ceph/ceph/pull/51944), David
    Galloway)
-   \[CVE-2023-43040\] rgw: Fix bucket validation against POST policies
    ([pr#53757](https://github.com/ceph/ceph/pull/53757), Joshua
    Baergen)
-   backport commit 70425c7 \-- client/fuse: set max_idle_threads to the
    correct value (critical, ceph-fuse with libfuse3 is nearly useless
    without it) ([pr#50668](https://github.com/ceph/ceph/pull/50668),
    Zhansong Gao)
-   blk/kernel: Add O_EXCL for block devices
    ([pr#53566](https://github.com/ceph/ceph/pull/53566), Adam Kupczyk)
-   blk/kernel: Fix error code mapping in KernelDevice::read
    ([pr#49984](https://github.com/ceph/ceph/pull/49984), Joshua
    Baergen)
-   blk/KernelDevice: Modify the rotational and discard check log
    message ([pr#50323](https://github.com/ceph/ceph/pull/50323),
    Vikhyat Umrao)
-   Bluestore: fix bluestore collection_list latency perf counter
    ([pr#52951](https://github.com/ceph/ceph/pull/52951), Wangwenjuan)
-   build: make it possible to build w/o ceph-mgr
    ([pr#54132](https://github.com/ceph/ceph/pull/54132), J. Eric
    Ivancich)
-   build: Remove ceph-libboost\* packages in install-deps
    ([pr#52564](https://github.com/ceph/ceph/pull/52564), Nizamudeen A,
    Adam Emerson)
-   ceph-volume/cephadm: support lv devices in inventory
    ([pr#53287](https://github.com/ceph/ceph/pull/53287), Guillaume
    Abrioux)
-   ceph-volume: add \--osd-id option to raw prepare
    ([pr#52929](https://github.com/ceph/ceph/pull/52929), Guillaume
    Abrioux)
-   ceph-volume: fix a bug in [get_lvm_fast_allocs()]{.title-ref}
    (batch) ([pr#52062](https://github.com/ceph/ceph/pull/52062),
    Guillaume Abrioux)
-   ceph-volume: fix batch refactor issue
    ([pr#51206](https://github.com/ceph/ceph/pull/51206), Guillaume
    Abrioux)
-   ceph-volume: fix drive-group issue that expects the batch_args to be
    a string ([pr#51210](https://github.com/ceph/ceph/pull/51210), Mohan
    Sharma)
-   ceph-volume: fix inventory with device arg
    ([pr#48125](https://github.com/ceph/ceph/pull/48125), Guillaume
    Abrioux)
-   ceph-volume: fix issue with fast device allocs when there are
    multiple PVs per VG
    ([pr#50879](https://github.com/ceph/ceph/pull/50879), Cory Snyder)
-   ceph-volume: fix mpath device support
    ([pr#53540](https://github.com/ceph/ceph/pull/53540), Guillaume
    Abrioux)
-   ceph-volume: fix raw list for lvm devices
    ([pr#52620](https://github.com/ceph/ceph/pull/52620), Guillaume
    Abrioux)
-   ceph-volume: quick fix in zap.py
    ([pr#51195](https://github.com/ceph/ceph/pull/51195), Guillaume
    Abrioux)
-   ceph-volume: set lvm membership for mpath type devices
    ([pr#52079](https://github.com/ceph/ceph/pull/52079), Guillaume
    Abrioux)
-   ceph-volume: update the OS before deploying Ceph (quincy)
    ([pr#50995](https://github.com/ceph/ceph/pull/50995), Guillaume
    Abrioux)
-   ceph: allow xlock state to be LOCK_PREXLOCK when putting it
    ([pr#53663](https://github.com/ceph/ceph/pull/53663), Xiubo Li)
-   ceph_volume: support encrypted volumes for lvm
    new-db/new-wal/migrate commands
    ([pr#52874](https://github.com/ceph/ceph/pull/52874), Igor Fedotov)
-   cephadm: eliminate duplication of sections
    ([pr#51432](https://github.com/ceph/ceph/pull/51432), Rongqi Sun)
-   cephadm: fix call timeout argument
    ([pr#52909](https://github.com/ceph/ceph/pull/52909), John Mulligan)
-   cephadm: handle exceptions applying extra services during bootstrap
    ([pr#50904](https://github.com/ceph/ceph/pull/50904), Adam King)
-   cephadm: mount host /etc/hosts for daemon containers in podman
    deployments ([pr#50902](https://github.com/ceph/ceph/pull/50902),
    Adam King, Ilya Dryomov)
-   cephadm: reschedule haproxy from an offline host
    ([pr#51216](https://github.com/ceph/ceph/pull/51216), Michael
    Fritch)
-   cephadm: set \--ulimit nofiles with Docker
    ([pr#50890](https://github.com/ceph/ceph/pull/50890), Michal
    Nasiadka)
-   cephadm: Split multicast interface and unicast_ip in keepalived.conf
    ([pr#53098](https://github.com/ceph/ceph/pull/53098), Luis
    Domingues)
-   cephadm: using ip instead of short hostname for prometheus urls
    ([pr#50905](https://github.com/ceph/ceph/pull/50905), Redouane
    Kachach)
-   cephfs-journal-tool: disambiguate usage of all keyword (in tool
    help) ([pr#53285](https://github.com/ceph/ceph/pull/53285), Manish M
    Yathnalli)
-   cephfs-mirror: do not run concurrent C_RestartMirroring context
    ([issue#62072](http://tracker.ceph.com/issues/62072),
    [pr#53639](https://github.com/ceph/ceph/pull/53639), Venky Shankar)
-   cephfs-top: check the minimum compatible python version
    ([pr#51354](https://github.com/ceph/ceph/pull/51354), Jos Collin)
-   cephfs-top: dump values to stdout and -d \[\--delay\] option fix
    ([pr#50717](https://github.com/ceph/ceph/pull/50717), Jos Collin,
    Neeraj Pratap Singh, wangxinyu, Rishabh Dave)
-   cephfs-top: Handle [METRIC_TYPE_NONE]{.title-ref} fields for sorting
    ([pr#50595](https://github.com/ceph/ceph/pull/50595), Neeraj Pratap
    Singh)
-   cephfs-top: include the missing fields in \--dump output
    ([pr#53454](https://github.com/ceph/ceph/pull/53454), Jos Collin)
-   cephfs-top: navigate to home screen when no fs
    ([pr#50731](https://github.com/ceph/ceph/pull/50731), Jos Collin)
-   cephfs-top: Some fixes in [choose_field()]{.title-ref} for sorting
    ([pr#50365](https://github.com/ceph/ceph/pull/50365), Neeraj Pratap
    Singh)
-   cephfs_mirror: correctly set top level dir permissions
    ([pr#50528](https://github.com/ceph/ceph/pull/50528), Milind
    Changire)
-   client: clear the suid/sgid in fallocate path
    ([pr#50989](https://github.com/ceph/ceph/pull/50989), Lucian Petrut,
    Xiubo Li)
-   client: do not send metrics until the MDS rank is ready
    ([pr#52502](https://github.com/ceph/ceph/pull/52502), Xiubo Li)
-   client: force sending cap revoke ack always
    ([pr#52508](https://github.com/ceph/ceph/pull/52508), Xiubo Li)
-   client: issue a cap release immediately if no cap exists
    ([pr#52851](https://github.com/ceph/ceph/pull/52851), Xiubo Li)
-   client: move the Inode to new auth mds session when changing auth
    cap ([pr#53664](https://github.com/ceph/ceph/pull/53664), Xiubo Li)
-   client: only wait for write MDS OPs when unmounting
    ([pr#52303](https://github.com/ceph/ceph/pull/52303), Xiubo Li)
-   client: trigger to flush the buffer when making snapshot
    ([pr#52498](https://github.com/ceph/ceph/pull/52498), Xiubo Li)
-   client: use deep-copy when setting permission during make_request
    ([pr#51486](https://github.com/ceph/ceph/pull/51486), Mer Xuanyi)
-   client: wait rename to finish
    ([pr#52503](https://github.com/ceph/ceph/pull/52503), Xiubo Li)
-   common: avoid redefining clock type on Windows
    ([pr#50573](https://github.com/ceph/ceph/pull/50573), Lucian Petrut)
-   Consider setting \"bulk\" autoscale pool flag when automatically
    creating a data pool for CephFS
    ([pr#52902](https://github.com/ceph/ceph/pull/52902), Leonid Usov)
-   debian: install cephfs-mirror systemd unit files and man page
    ([pr#52074](https://github.com/ceph/ceph/pull/52074), Jos Collin)
-   doc,test: clean up crush rule min/max_size leftovers
    ([pr#52169](https://github.com/ceph/ceph/pull/52169), Ilya Dryomov)
-   doc/architecture.rst - edit a sentence
    ([pr#53373](https://github.com/ceph/ceph/pull/53373), Zac Dover)
-   doc/architecture.rst - edit up to \"Cluster Map\"
    ([pr#53367](https://github.com/ceph/ceph/pull/53367), Zac Dover)
-   doc/architecture: \"Edit HA Auth\"
    ([pr#53620](https://github.com/ceph/ceph/pull/53620), Zac Dover)
-   doc/architecture: \"Edit HA Auth\" (one of several)
    ([pr#53586](https://github.com/ceph/ceph/pull/53586), Zac Dover)
-   doc/architecture: \"Edit HA Auth\" (one of several)
    ([pr#53492](https://github.com/ceph/ceph/pull/53492), Zac Dover)
-   doc/architecture: edit \"Calculating PG IDs\"
    ([pr#53749](https://github.com/ceph/ceph/pull/53749), Zac Dover)
-   doc/architecture: edit \"Cluster Map\"
    ([pr#53435](https://github.com/ceph/ceph/pull/53435), Zac Dover)
-   doc/architecture: edit \"Data Scrubbing\"
    ([pr#53731](https://github.com/ceph/ceph/pull/53731), Zac Dover)
-   doc/architecture: Edit \"HA Auth\"
    ([pr#53489](https://github.com/ceph/ceph/pull/53489), Zac Dover)
-   doc/architecture: edit \"HA Authentication\"
    ([pr#53633](https://github.com/ceph/ceph/pull/53633), Zac Dover)
-   doc/architecture: edit \"High Avail. Monitors\"
    ([pr#53452](https://github.com/ceph/ceph/pull/53452), Zac Dover)
-   doc/architecture: edit \"OSD Membership and Status\"
    ([pr#53728](https://github.com/ceph/ceph/pull/53728), Zac Dover)
-   doc/architecture: edit \"OSDs service clients directly\"
    ([pr#53687](https://github.com/ceph/ceph/pull/53687), Zac Dover)
-   doc/architecture: edit \"Peering and Sets\"
    ([pr#53872](https://github.com/ceph/ceph/pull/53872), Zac Dover)
-   doc/architecture: edit \"Replication\"
    ([pr#53739](https://github.com/ceph/ceph/pull/53739), Zac Dover)
-   doc/architecture: edit \"SDEH\"
    ([pr#53660](https://github.com/ceph/ceph/pull/53660), Zac Dover)
-   doc/architecture: edit several sections
    ([pr#53743](https://github.com/ceph/ceph/pull/53743), Zac Dover)
-   doc/architecture: repair RBD sentence
    ([pr#53878](https://github.com/ceph/ceph/pull/53878), Zac Dover)
-   doc/cephadm: add ssh note to install.rst
    ([pr#53200](https://github.com/ceph/ceph/pull/53200), Zac Dover)
-   doc/cephadm: edit \"Adding Hosts\" in install.rst
    ([pr#53226](https://github.com/ceph/ceph/pull/53226), Zac Dover)
-   doc/cephadm: edit sentence in mgr.rst
    ([pr#53165](https://github.com/ceph/ceph/pull/53165), Zac Dover)
-   doc/cephadm: fix typo in cephadm initial crush location section
    ([pr#52888](https://github.com/ceph/ceph/pull/52888), John Mulligan)
-   doc/cephfs: add note to isolate metadata pool osds
    ([pr#52464](https://github.com/ceph/ceph/pull/52464), Patrick
    Donnelly)
-   doc/cephfs: edit fs-volumes.rst (1 of x)
    ([pr#51466](https://github.com/ceph/ceph/pull/51466), Zac Dover)
-   doc/cephfs: explain cephfs data and metadata set
    ([pr#51236](https://github.com/ceph/ceph/pull/51236), Zac Dover)
-   doc/cephfs: fix prompts in fs-volumes.rst
    ([pr#51435](https://github.com/ceph/ceph/pull/51435), Zac Dover)
-   doc/cephfs: Improve fs-volumes.rst
    ([pr#50831](https://github.com/ceph/ceph/pull/50831), Anthony
    D\'Atri)
-   doc/cephfs: line-edit \"Mirroring Module\"
    ([pr#51543](https://github.com/ceph/ceph/pull/51543), Zac Dover)
-   doc/cephfs: rectify prompts in fs-volumes.rst
    ([pr#51459](https://github.com/ceph/ceph/pull/51459), Zac Dover)
-   doc/cephfs: repairing inaccessible FSes
    ([pr#51372](https://github.com/ceph/ceph/pull/51372), Zac Dover)
-   doc/cephfs: write cephfs commands fully in docs
    ([pr#53401](https://github.com/ceph/ceph/pull/53401), Rishabh Dave)
-   doc/configuration: edit \"bg\" in mon-config-ref.rst
    ([pr#53348](https://github.com/ceph/ceph/pull/53348), Zac Dover)
-   doc/dev/encoding.txt: update per std::optional
    ([pr#51398](https://github.com/ceph/ceph/pull/51398), Radoslaw
    Zarzynski)
-   doc/dev: backport deduplication.rst to Quincy
    ([pr#53533](https://github.com/ceph/ceph/pull/53533), Zac Dover)
-   doc/dev: fix \"deploying dev cluster\" link
    ([pr#52035](https://github.com/ceph/ceph/pull/52035), Zac Dover)
-   doc/dev: Fix typos in files cephfs-mirroring.rst and
    deduplication.rst
    ([pr#53541](https://github.com/ceph/ceph/pull/53541), Daniel Parkes)
-   doc/dev: format command in cephfs-mirroring
    ([pr#51108](https://github.com/ceph/ceph/pull/51108), Zac Dover)
-   doc/dev: remove seqdiag assets
    ([pr#52310](https://github.com/ceph/ceph/pull/52310), Zac Dover)
-   doc/foundation: Updating foundation members for July 2023
    ([pr#54064](https://github.com/ceph/ceph/pull/54064), Mike Perez)
-   doc/glossary: add \"Hybrid Storage\"
    ([pr#51097](https://github.com/ceph/ceph/pull/51097), Zac Dover)
-   doc/glossary: add \"primary affinity\" to glossary
    ([pr#53428](https://github.com/ceph/ceph/pull/53428), Zac Dover)
-   doc/glossary: add \"Scrubbing\"
    ([pr#50702](https://github.com/ceph/ceph/pull/50702), Zac Dover)
-   doc/glossary: add \"User\"
    ([pr#50672](https://github.com/ceph/ceph/pull/50672), Zac Dover)
-   doc/glossary: improve \"CephX\" entry
    ([pr#51064](https://github.com/ceph/ceph/pull/51064), Zac Dover)
-   doc/glossary: link to CephX Config ref
    ([pr#50708](https://github.com/ceph/ceph/pull/50708), Zac Dover)
-   doc/glossary: update bluestore entry
    ([pr#51694](https://github.com/ceph/ceph/pull/51694), Zac Dover)
-   doc/man/8: improve radosgw-admin.rst
    ([pr#53268](https://github.com/ceph/ceph/pull/53268), Anthony
    D\'Atri)
-   doc/man: radosgw-admin.rst typo
    ([pr#53316](https://github.com/ceph/ceph/pull/53316), Zac Dover)
-   doc/man: remove docs about support for unix domain sockets
    ([pr#53313](https://github.com/ceph/ceph/pull/53313), Zac Dover)
-   doc/mgr/ceph_api: Promptify example commands in index.rst
    ([pr#52696](https://github.com/ceph/ceph/pull/52696), Ville Ojamo)
-   doc/mgr/dashboard: fix a typo
    ([pr#52142](https://github.com/ceph/ceph/pull/52142), Guido
    Santella)
-   doc/mgr/prometheus: fix confval reference
    ([pr#51093](https://github.com/ceph/ceph/pull/51093), Piotr
    Parczewski)
-   doc/mgr/rgw.rst: add missing \"ceph\" command in cli specification
    ([pr#52487](https://github.com/ceph/ceph/pull/52487), Ville Ojamo)
-   doc/mgr/rgw.rst: multisite typed wrong
    ([pr#52479](https://github.com/ceph/ceph/pull/52479), Ville Ojamo)
-   doc/mgr: edit \"leaderboard\" in telemetry.rst
    ([pr#51721](https://github.com/ceph/ceph/pull/51721), Zac Dover)
-   doc/mgr: update prompts in prometheus.rst
    ([pr#51310](https://github.com/ceph/ceph/pull/51310), Zac Dover)
-   doc/msgr2: update dual stack status
    ([pr#50800](https://github.com/ceph/ceph/pull/50800), Dan van der
    Ster)
-   doc/operations: fix prompt in bluestore-migration
    ([pr#50662](https://github.com/ceph/ceph/pull/50662), Zac Dover)
-   doc/rados/config: edit auth-config-ref
    ([pr#50950](https://github.com/ceph/ceph/pull/50950), Zac Dover)
-   doc/rados/configuration: add links to MON DNS
    ([pr#52613](https://github.com/ceph/ceph/pull/52613), Ville Ojamo)
-   doc/rados/configuration: Avoid repeating \"support\" in msgr2.rst
    ([pr#52999](https://github.com/ceph/ceph/pull/52999), Ville Ojamo)
-   doc/rados/operations: Acting Set question
    ([pr#51740](https://github.com/ceph/ceph/pull/51740), Zac Dover)
-   doc/rados/operations: edit monitoring.rst
    ([pr#51036](https://github.com/ceph/ceph/pull/51036), Zac Dover)
-   doc/rados/operations: Fix erasure-code-jerasure.rst fix
    ([pr#51743](https://github.com/ceph/ceph/pull/51743), Anthony
    D\'Atri)
-   doc/rados/operations: fix typo in balancer.rst
    ([pr#51938](https://github.com/ceph/ceph/pull/51938), Pierre Riteau)
-   doc/rados/operations: Fix typo in erasure-code.rst
    ([pr#50752](https://github.com/ceph/ceph/pull/50752), Sainithin
    Artham)
-   doc/rados/operations: Improve formatting in crush-map.rst
    ([pr#52140](https://github.com/ceph/ceph/pull/52140), Anthony
    D\'Atri)
-   doc/rados/ops: add ceph-medic documentation
    ([pr#50853](https://github.com/ceph/ceph/pull/50853), Zac Dover)
-   doc/rados/ops: add hyphen to mon-osd-pg.rst
    ([pr#50960](https://github.com/ceph/ceph/pull/50960), Zac Dover)
-   doc/rados/ops: edit health checks.rst (5 of x)
    ([pr#50967](https://github.com/ceph/ceph/pull/50967), Zac Dover)
-   doc/rados/ops: edit health-checks.rst (1 of x)
    ([pr#50797](https://github.com/ceph/ceph/pull/50797), Zac Dover)
-   doc/rados/ops: edit health-checks.rst (2 of x)
    ([pr#50912](https://github.com/ceph/ceph/pull/50912), Zac Dover)
-   doc/rados/ops: edit health-checks.rst (3 of x)
    ([pr#50953](https://github.com/ceph/ceph/pull/50953), Zac Dover)
-   doc/rados/ops: edit health-checks.rst (4 of x)
    ([pr#50956](https://github.com/ceph/ceph/pull/50956), Zac Dover)
-   doc/rados/ops: edit health-checks.rst (6 of x)
    ([pr#50970](https://github.com/ceph/ceph/pull/50970), Zac Dover)
-   doc/rados/ops: edit monitoring-osd-pg.rst (1 of x)
    ([pr#50865](https://github.com/ceph/ceph/pull/50865), Zac Dover)
-   doc/rados/ops: edit monitoring-osd-pg.rst (2 of x)
    ([pr#50946](https://github.com/ceph/ceph/pull/50946), Zac Dover)
-   doc/rados/ops: edit user-management.rst (3 of x)
    ([pr#51240](https://github.com/ceph/ceph/pull/51240), Zac Dover)
-   doc/rados/ops: line-edit operating.rst
    ([pr#50934](https://github.com/ceph/ceph/pull/50934), Zac Dover)
-   doc/rados/ops: remove ceph-medic from monitoring
    ([pr#51088](https://github.com/ceph/ceph/pull/51088), Zac Dover)
-   doc/rados: add bulk flag to pools.rst
    ([pr#53318](https://github.com/ceph/ceph/pull/53318), Zac Dover)
-   doc/rados: add link to ops/health-checks.rst
    ([pr#50762](https://github.com/ceph/ceph/pull/50762), Zac Dover)
-   doc/rados: add math markup to placement-groups.rst
    ([pr#52038](https://github.com/ceph/ceph/pull/52038), Zac Dover)
-   doc/rados: clean up ops/bluestore-migration.rst
    ([pr#50678](https://github.com/ceph/ceph/pull/50678), Zac Dover)
-   doc/rados: edit add-or-rm-osds (1 of x)
    ([pr#52384](https://github.com/ceph/ceph/pull/52384), Zac Dover)
-   doc/rados: edit add-or-rm-osds (2 of x)
    ([pr#52451](https://github.com/ceph/ceph/pull/52451), Zac Dover)
-   doc/rados: edit balancer.rst
    ([pr#51825](https://github.com/ceph/ceph/pull/51825), Zac Dover)
-   doc/rados: edit bluestore-config-ref.rst (1 of x)
    ([pr#51790](https://github.com/ceph/ceph/pull/51790), Zac Dover)
-   doc/rados: edit bluestore-config-ref.rst (2 of x)
    ([pr#51793](https://github.com/ceph/ceph/pull/51793), Zac Dover)
-   doc/rados: edit ceph-conf.rst
    ([pr#52449](https://github.com/ceph/ceph/pull/52449), Zac Dover)
-   doc/rados: edit ceph-conf.rst (2 of x)
    ([pr#52471](https://github.com/ceph/ceph/pull/52471), Zac Dover)
-   doc/rados: edit ceph-conf.rst (3 of x)
    ([pr#52589](https://github.com/ceph/ceph/pull/52589), Zac Dover)
-   doc/rados: edit ceph-conf.rst (4 of x)
    ([pr#52594](https://github.com/ceph/ceph/pull/52594), Zac Dover)
-   doc/rados: edit change-mon-elections
    ([pr#51999](https://github.com/ceph/ceph/pull/51999), Zac Dover)
-   doc/rados: edit control.rst (1 of x)
    ([pr#52153](https://github.com/ceph/ceph/pull/52153), Zac Dover)
-   doc/rados: edit crush-map-edits (2 of x)
    ([pr#52312](https://github.com/ceph/ceph/pull/52312), Zac Dover)
-   doc/rados: edit crush-map-edits.rst (1 of x)
    ([pr#52180](https://github.com/ceph/ceph/pull/52180), Zac Dover)
-   doc/rados: edit crush-map.rst (1 of x)
    ([pr#52031](https://github.com/ceph/ceph/pull/52031), Zac Dover)
-   doc/rados: edit crush-map.rst (2 of x)
    ([pr#52070](https://github.com/ceph/ceph/pull/52070), Zac Dover)
-   doc/rados: edit crush-map.rst (3 of x)
    ([pr#52094](https://github.com/ceph/ceph/pull/52094), Zac Dover)
-   doc/rados: edit crush-map.rst (4 of x)
    ([pr#52099](https://github.com/ceph/ceph/pull/52099), Zac Dover)
-   doc/rados: edit data-placement.rst
    ([pr#51596](https://github.com/ceph/ceph/pull/51596), Zac Dover)
-   doc/rados: edit devices.rst
    ([pr#51478](https://github.com/ceph/ceph/pull/51478), Zac Dover)
-   doc/rados: edit filestore-config-ref.rst
    ([pr#51752](https://github.com/ceph/ceph/pull/51752), Zac Dover)
-   doc/rados: edit firefly tunables section
    ([pr#52103](https://github.com/ceph/ceph/pull/52103), Zac Dover)
-   doc/rados: edit log-and-debug.rst (1 of x)
    ([pr#51903](https://github.com/ceph/ceph/pull/51903), Zac Dover)
-   doc/rados: edit log-and-debug.rst (2 of x)
    ([pr#51907](https://github.com/ceph/ceph/pull/51907), Zac Dover)
-   doc/rados: edit memory-profiling.rst
    ([pr#53933](https://github.com/ceph/ceph/pull/53933), Zac Dover)
-   doc/rados: edit operations/add-or-rm-mons (1 of x)
    ([pr#52890](https://github.com/ceph/ceph/pull/52890), Zac Dover)
-   doc/rados: edit operations/add-or-rm-mons (2 of x)
    ([pr#52826](https://github.com/ceph/ceph/pull/52826), Zac Dover)
-   doc/rados: edit operations/bs-migration (1 of x)
    ([pr#50587](https://github.com/ceph/ceph/pull/50587), Zac Dover)
-   doc/rados: edit operations/bs-migration (2 of x)
    ([pr#50590](https://github.com/ceph/ceph/pull/50590), Zac Dover)
-   doc/rados: edit ops/control.rst (1 of x)
    ([pr#53812](https://github.com/ceph/ceph/pull/53812), zdover23, Zac
    Dover)
-   doc/rados: edit ops/control.rst (2 of x)
    ([pr#53816](https://github.com/ceph/ceph/pull/53816), Zac Dover)
-   doc/rados: edit ops/monitoring.rst (1 of 3)
    ([pr#50823](https://github.com/ceph/ceph/pull/50823), Zac Dover)
-   doc/rados: edit ops/monitoring.rst (2 of 3)
    ([pr#50849](https://github.com/ceph/ceph/pull/50849), Zac Dover)
-   doc/rados: edit placement-groups.rst (1 of x)
    ([pr#51985](https://github.com/ceph/ceph/pull/51985), Zac Dover)
-   doc/rados: edit placement-groups.rst (2 of x)
    ([pr#51997](https://github.com/ceph/ceph/pull/51997), Zac Dover)
-   doc/rados: edit placement-groups.rst (3 of x)
    ([pr#52002](https://github.com/ceph/ceph/pull/52002), Zac Dover)
-   doc/rados: edit pools.rst (1 of x)
    ([pr#51913](https://github.com/ceph/ceph/pull/51913), Zac Dover)
-   doc/rados: edit pools.rst (2 of x)
    ([pr#51940](https://github.com/ceph/ceph/pull/51940), Zac Dover)
-   doc/rados: edit pools.rst (3 of x)
    ([pr#51957](https://github.com/ceph/ceph/pull/51957), Zac Dover)
-   doc/rados: edit pools.rst (4 of x)
    ([pr#51971](https://github.com/ceph/ceph/pull/51971), Zac Dover)
-   doc/rados: edit stretch-mode procedure
    ([pr#51290](https://github.com/ceph/ceph/pull/51290), Zac Dover)
-   doc/rados: edit stretch-mode.rst
    ([pr#51338](https://github.com/ceph/ceph/pull/51338), Zac Dover)
-   doc/rados: edit stretch-mode.rst
    ([pr#51303](https://github.com/ceph/ceph/pull/51303), Zac Dover)
-   doc/rados: edit troubleshooting-mon.rst (1 of x)
    ([pr#51905](https://github.com/ceph/ceph/pull/51905), Zac Dover)
-   doc/rados: edit troubleshooting-mon.rst (2 of x)
    ([pr#52840](https://github.com/ceph/ceph/pull/52840), Zac Dover)
-   doc/rados: edit troubleshooting-mon.rst (3 of x)
    ([pr#53880](https://github.com/ceph/ceph/pull/53880), Zac Dover)
-   doc/rados: edit troubleshooting-mon.rst (4 of x)
    ([pr#53898](https://github.com/ceph/ceph/pull/53898), Zac Dover)
-   doc/rados: edit troubleshooting-osd (1 of x)
    ([pr#53983](https://github.com/ceph/ceph/pull/53983), Zac Dover)
-   doc/rados: Edit troubleshooting-osd (2 of x)
    ([pr#54001](https://github.com/ceph/ceph/pull/54001), Zac Dover)
-   doc/rados: Edit troubleshooting-osd (3 of x)
    ([pr#54027](https://github.com/ceph/ceph/pull/54027), Zac Dover)
-   doc/rados: edit troubleshooting-pg (2 of x)
    ([pr#54115](https://github.com/ceph/ceph/pull/54115), Zac Dover)
-   doc/rados: edit troubleshooting-pg.rst (1 of x)
    ([pr#54074](https://github.com/ceph/ceph/pull/54074), Zac Dover)
-   doc/rados: edit troubleshooting.rst
    ([pr#53838](https://github.com/ceph/ceph/pull/53838), Zac Dover)
-   doc/rados: edit troubleshooting/community.rst
    ([pr#53882](https://github.com/ceph/ceph/pull/53882), Zac Dover)
-   doc/rados: edit user-management (2 of x)
    ([pr#51156](https://github.com/ceph/ceph/pull/51156), Zac Dover)
-   doc/rados: edit user-management.rst (1 of x)
    ([pr#50641](https://github.com/ceph/ceph/pull/50641), Zac Dover)
-   doc/rados: fix link in common.rst
    ([pr#51756](https://github.com/ceph/ceph/pull/51756), Zac Dover)
-   doc/rados: fix list in crush-map.rst
    ([pr#52066](https://github.com/ceph/ceph/pull/52066), Zac Dover)
-   doc/rados: fix typos in pg-repair.rst
    ([pr#51898](https://github.com/ceph/ceph/pull/51898), Zac Dover)
-   doc/rados: introduce emdash
    ([pr#52382](https://github.com/ceph/ceph/pull/52382), Zac Dover)
-   doc/rados: line edit mon-lookup-dns top matter
    ([pr#50582](https://github.com/ceph/ceph/pull/50582), Zac Dover)
-   doc/rados: line-edit common.rst
    ([pr#50943](https://github.com/ceph/ceph/pull/50943), Zac Dover)
-   doc/rados: line-edit devices.rst
    ([pr#51577](https://github.com/ceph/ceph/pull/51577), Zac Dover)
-   doc/rados: line-edit erasure-code.rst
    ([pr#50619](https://github.com/ceph/ceph/pull/50619), Zac Dover)
-   doc/rados: line-edit pg-repair.rst
    ([pr#50803](https://github.com/ceph/ceph/pull/50803), Zac Dover)
-   doc/rados: line-edit upmap.rst
    ([pr#50566](https://github.com/ceph/ceph/pull/50566), Zac Dover)
-   doc/rados: m-config-ref: edit \"background\"
    ([pr#51273](https://github.com/ceph/ceph/pull/51273), Zac Dover)
-   doc/rados: pools.rst: \"decreaesed\"
    ([pr#51920](https://github.com/ceph/ceph/pull/51920), Zac Dover)
-   doc/rados: remove git tag in placement-groups in q
    ([pr#51990](https://github.com/ceph/ceph/pull/51990), Zac Dover)
-   doc/rados: stretch-mode.rst (other commands)
    ([pr#51390](https://github.com/ceph/ceph/pull/51390), Zac Dover)
-   doc/rados: stretch-mode: stretch cluster issues
    ([pr#51378](https://github.com/ceph/ceph/pull/51378), Zac Dover)
-   doc/rados: update monitoring-osd-pg.rst
    ([pr#52959](https://github.com/ceph/ceph/pull/52959), Zac Dover)
-   doc/radosgw: Add missing space to date option spec in admin.rst
    ([pr#52694](https://github.com/ceph/ceph/pull/52694), Ville Ojamo)
-   doc/radosgw: add Zonegroup policy explanation
    ([pr#52362](https://github.com/ceph/ceph/pull/52362), Zac Dover)
-   doc/radosgw: add Zonegroup purpose
    ([pr#52349](https://github.com/ceph/ceph/pull/52349), Zac Dover)
-   doc/radosgw: correct emphasis in rate limit section
    ([pr#52713](https://github.com/ceph/ceph/pull/52713), Piotr
    Parczewski)
-   doc/radosgw: edit \"Basic Workflow\" in s3select.rst
    ([pr#52263](https://github.com/ceph/ceph/pull/52263), Zac Dover)
-   doc/radosgw: edit \"Overview\" in s3select.rst
    ([pr#52220](https://github.com/ceph/ceph/pull/52220), Zac Dover)
-   doc/radosgw: explain multisite dynamic sharding
    ([pr#51586](https://github.com/ceph/ceph/pull/51586), Zac Dover)
-   doc/radosgw: fix command error blank
    ([pr#53656](https://github.com/ceph/ceph/pull/53656), stevenhua)
-   doc/radosgw: format part of s3select
    ([pr#51117](https://github.com/ceph/ceph/pull/51117), Cole Mitchell)
-   doc/radosgw: format part of s3select
    ([pr#51105](https://github.com/ceph/ceph/pull/51105), Cole Mitchell)
-   doc/radosgw: Improve language and formatting in config-ref.rst
    ([pr#52836](https://github.com/ceph/ceph/pull/52836), Ville Ojamo)
-   doc/radosgw: multisite - edit \"migrating a single-site\"
    ([pr#53262](https://github.com/ceph/ceph/pull/53262), Qi Tao)
-   doc/radosgw: rabbitmq - push-endpoint edit
    ([pr#51306](https://github.com/ceph/ceph/pull/51306), Zac Dover)
-   doc/radosgw: refine \"Zones\" in multisite.rst
    ([pr#52282](https://github.com/ceph/ceph/pull/52282), Zac Dover)
-   doc/radosgw: remove pipes from s3select.rst
    ([pr#52188](https://github.com/ceph/ceph/pull/52188), Zac Dover)
-   doc/radosgw: remove pipes from s3select.rst
    ([pr#52184](https://github.com/ceph/ceph/pull/52184), Zac Dover)
-   doc/radosgw: s/s3select/S3 Select/
    ([pr#52279](https://github.com/ceph/ceph/pull/52279), Zac Dover)
-   doc/radosgw: update rate limit management
    ([pr#52911](https://github.com/ceph/ceph/pull/52911), Zac Dover)
-   doc/README.md - edit \"Building Ceph\"
    ([pr#53058](https://github.com/ceph/ceph/pull/53058), Zac Dover)
-   doc/README.md - improve \"Running a test cluster\"
    ([pr#53259](https://github.com/ceph/ceph/pull/53259), Zac Dover)
-   doc/rgw/lua: add info uploading a script in cephadm deployment
    ([pr#52299](https://github.com/ceph/ceph/pull/52299), Yuval
    Lifshitz)
-   doc/rgw: refine \"Setting a Zonegroup\"
    ([pr#51072](https://github.com/ceph/ceph/pull/51072), Zac Dover)
-   doc/rgw: several response headers are supported
    ([pr#52804](https://github.com/ceph/ceph/pull/52804), Casey Bodley)
-   doc/start/os-recommendations: drop 4.14 kernel and reword guidance
    ([pr#51490](https://github.com/ceph/ceph/pull/51490), Ilya Dryomov)
-   doc/start: documenting-ceph - add squash procedure
    ([pr#50740](https://github.com/ceph/ceph/pull/50740), Zac Dover)
-   doc/start: edit first 150 lines of documenting-ceph
    ([pr#51182](https://github.com/ceph/ceph/pull/51182), Zac Dover)
-   doc/start: edit os-recommendations.rst
    ([pr#53180](https://github.com/ceph/ceph/pull/53180), Zac Dover)
-   doc/start: fix \"Planet Ceph\" link
    ([pr#51420](https://github.com/ceph/ceph/pull/51420), Zac Dover)
-   doc/start: format procedure in documenting-ceph
    ([pr#50788](https://github.com/ceph/ceph/pull/50788), Zac Dover)
-   doc/start: KRBD feature flag support note
    ([pr#51503](https://github.com/ceph/ceph/pull/51503), Zac Dover)
-   doc/start: Modernize and clarify hardware-recommendations.rst
    ([pr#54072](https://github.com/ceph/ceph/pull/54072), Anthony
    D\'Atri)
-   doc/start: rewrite intro paragraph
    ([pr#51221](https://github.com/ceph/ceph/pull/51221), Zac Dover)
-   doc/start: update \"notify us\" section
    ([pr#50770](https://github.com/ceph/ceph/pull/50770), Zac Dover)
-   doc/start: update linking conventions
    ([pr#52913](https://github.com/ceph/ceph/pull/52913), Zac Dover)
-   doc/start: update linking conventions
    ([pr#52842](https://github.com/ceph/ceph/pull/52842), Zac Dover)
-   doc/troubleshooting: edit cpu-profiling.rst
    ([pr#53060](https://github.com/ceph/ceph/pull/53060), Zac Dover)
-   doc: Add a note on possible deadlock on volume deletion
    ([pr#52947](https://github.com/ceph/ceph/pull/52947), Kotresh HR)
-   doc: add information on expediting MDS recovery
    ([pr#52368](https://github.com/ceph/ceph/pull/52368), Patrick
    Donnelly)
-   doc: add link to \"documenting ceph\" to index.rst
    ([pr#51470](https://github.com/ceph/ceph/pull/51470), Zac Dover)
-   doc: Add missing [ceph]{.title-ref} command in documentation section
    [REPLACING A... (\`pr#51620
    \<https://github.com/ceph/ceph/pull/51620\>]{.title-ref}\_,
    Alexander Proschek)
-   doc: add note for removing (automatic) partitioning policy
    ([pr#53570](https://github.com/ceph/ceph/pull/53570), Venky Shankar)
-   doc: Add warning on manual CRUSH rule removal
    ([pr#53421](https://github.com/ceph/ceph/pull/53421), Alvin Owyong)
-   doc: deprecate the cache tiering
    ([pr#51653](https://github.com/ceph/ceph/pull/51653), Radosław
    Zarzyński)
-   doc: Documentation about main Ceph metrics
    ([pr#54112](https://github.com/ceph/ceph/pull/54112), Juan Miguel
    Olmo Martínez)
-   doc: edit README.md - contributing code
    ([pr#53050](https://github.com/ceph/ceph/pull/53050), Zac Dover)
-   doc: expand and consolidate mds placement
    ([pr#53147](https://github.com/ceph/ceph/pull/53147), Patrick
    Donnelly)
-   doc: explain cephfs mirroring [peer_add]{.title-ref} step in detail
    ([pr#51521](https://github.com/ceph/ceph/pull/51521), Venky Shankar)
-   doc: Fix doc for mds cap acquisition throttle
    ([pr#53025](https://github.com/ceph/ceph/pull/53025), Kotresh HR)
-   doc: for EC we recommend K+1
    ([pr#52780](https://github.com/ceph/ceph/pull/52780), Dan van der
    Ster)
-   doc: governance.rst - update D Orman
    ([pr#52573](https://github.com/ceph/ceph/pull/52573), Zac Dover)
-   doc: improve doc/dev/encoding.rst
    ([pr#52759](https://github.com/ceph/ceph/pull/52759), Radosław
    Zarzyński)
-   doc: improve submodule update command - README.md
    ([pr#53001](https://github.com/ceph/ceph/pull/53001), Zac Dover)
-   doc: remove egg fragment from
    dev/developer_guide/running-tests-locally
    ([pr#53854](https://github.com/ceph/ceph/pull/53854), Dhairya
    Parmar)
-   doc: Update jerasure.org references
    ([pr#51726](https://github.com/ceph/ceph/pull/51726), Anthony
    D\'Atri)
-   doc: Update mClock QOS documentation to discard
    osd_mclock_cost_per\_\*
    ([pr#54080](https://github.com/ceph/ceph/pull/54080), tanchangzhi)
-   doc: update multisite doc
    ([pr#51401](https://github.com/ceph/ceph/pull/51401), parth-gr)
-   doc: update rados.cc
    ([pr#52968](https://github.com/ceph/ceph/pull/52968), Zac Dover)
-   doc: update README.md
    ([pr#52642](https://github.com/ceph/ceph/pull/52642), Zac Dover)
-   doc: update README.md install procedure
    ([pr#52680](https://github.com/ceph/ceph/pull/52680), Zac Dover)
-   doc: update test cluster commands in README.md
    ([pr#53350](https://github.com/ceph/ceph/pull/53350), Zac Dover)
-   doc: Use [ceph osd crush tree]{.title-ref} command to display weight
    set weights ([pr#51350](https://github.com/ceph/ceph/pull/51350),
    James Lakin)
-   docs: fix nfs cluster create syntax
    ([pr#52424](https://github.com/ceph/ceph/pull/52424), Paul Cuzner)
-   docs: Update the Prometheus endpoint info
    ([pr#51287](https://github.com/ceph/ceph/pull/51287), Paul Cuzner)
-   Fix FTBFS on gcc 13
    ([pr#52120](https://github.com/ceph/ceph/pull/52120), Tim Serong)
-   install-deps: remove the legacy resolver flags
    ([pr#53706](https://github.com/ceph/ceph/pull/53706), Nizamudeen A)
-   kv/RocksDBStore: Add CompactOnDeletion support
    ([pr#50893](https://github.com/ceph/ceph/pull/50893), Mark Nelson)
-   kv/RocksDBStore: cumulative backport for rm_range_keys and around
    ([pr#50636](https://github.com/ceph/ceph/pull/50636), Igor Fedotov)
-   kv/RocksDBStore: don\'t use real wholespace iterator for prefixed
    access ([pr#50495](https://github.com/ceph/ceph/pull/50495), Igor
    Fedotov)
-   libcephsqlite: fill 0s in unread portion of buffer
    ([pr#53102](https://github.com/ceph/ceph/pull/53102), Patrick
    Donnelly)
-   librados: aio operate functions can set times
    ([pr#52118](https://github.com/ceph/ceph/pull/52118), Casey Bodley)
-   librbd/managed_lock/GetLockerRequest: Fix no valid lockers case
    ([pr#52288](https://github.com/ceph/ceph/pull/52288), Ilya Dryomov,
    Matan Breizman)
-   librbd: avoid decrementing iterator before first element
    ([pr#51854](https://github.com/ceph/ceph/pull/51854), Lucian Petrut)
-   librbd: avoid object map corruption in snapshots taken under I/O
    ([pr#52286](https://github.com/ceph/ceph/pull/52286), Ilya Dryomov)
-   librbd: don\'t wait for a watch in send_acquire_lock() if client is
    blocklisted ([pr#50920](https://github.com/ceph/ceph/pull/50920),
    Ilya Dryomov, Christopher Hoffman)
-   librbd: fix wrong attribute for rbd_quiesce_complete api
    ([pr#50873](https://github.com/ceph/ceph/pull/50873), Dongsheng
    Yang)
-   librbd: kick ExclusiveLock state machine on client being blocklisted
    when waiting for lock
    ([pr#53294](https://github.com/ceph/ceph/pull/53294), Ramana Raja)
-   librbd: kick ExclusiveLock state machine stalled waiting for lock
    from reacquire_lock()
    ([pr#53920](https://github.com/ceph/ceph/pull/53920), Ramana Raja)
-   librbd: localize snap_remove op for mirror snapshots
    ([pr#51428](https://github.com/ceph/ceph/pull/51428), Christopher
    Hoffman)
-   librbd: make CreatePrimaryRequest remove any unlinked mirror
    snapshots ([pr#53275](https://github.com/ceph/ceph/pull/53275), Ilya
    Dryomov)
-   librbd: remove previous incomplete primary snapshot after
    successfully creating a new one
    ([pr#51173](https://github.com/ceph/ceph/pull/51173), Ilya Dryomov,
    Prasanna Kumar Kalever)
-   librbd: report better errors when failing to enable mirroring on an
    image ([pr#50837](https://github.com/ceph/ceph/pull/50837), Prasanna
    Kumar Kalever)
-   log: writes to stderr (pipe) may not be atomic
    ([pr#50777](https://github.com/ceph/ceph/pull/50777), Lucian Petrut,
    Patrick Donnelly)
-   MDS imported_inodes metric is not updated
    ([pr#51697](https://github.com/ceph/ceph/pull/51697), Yongseok Oh)
-   mds/FSMap: allow upgrades if no up mds
    ([pr#53852](https://github.com/ceph/ceph/pull/53852), Patrick
    Donnelly)
-   mds/Server: mark a cap acquisition throttle event in the request
    ([pr#53167](https://github.com/ceph/ceph/pull/53167), Leonid Usov)
-   mds: acquire inode snaplock in open
    ([pr#53184](https://github.com/ceph/ceph/pull/53184), Patrick
    Donnelly)
-   mds: add event for batching getattr/lookup
    ([pr#53557](https://github.com/ceph/ceph/pull/53557), Patrick
    Donnelly)
-   mds: allow unlink from lost+found directory
    ([issue#59569](http://tracker.ceph.com/issues/59569),
    [pr#51689](https://github.com/ceph/ceph/pull/51689), Venky Shankar)
-   mds: blocklist clients with \"bloated\" session metadata
    ([issue#61947](http://tracker.ceph.com/issues/61947),
    [issue#62873](http://tracker.ceph.com/issues/62873),
    [pr#53330](https://github.com/ceph/ceph/pull/53330), Venky Shankar)
-   mds: catch damage to CDentry\'s first member before persisting
    ([issue#58482](http://tracker.ceph.com/issues/58482),
    [pr#50779](https://github.com/ceph/ceph/pull/50779), Patrick
    Donnelly)
-   mds: display sane hex value (0x0) for empty feature bit
    ([pr#52127](https://github.com/ceph/ceph/pull/52127), Jos Collin)
-   mds: do not send split_realms for CEPH_SNAP_OP_UPDATE msg
    ([pr#52849](https://github.com/ceph/ceph/pull/52849), Xiubo Li)
-   mds: do not take the ino which has been used
    ([pr#51507](https://github.com/ceph/ceph/pull/51507), Xiubo Li)
-   mds: drop locks and retry when lock set changes
    ([pr#53242](https://github.com/ceph/ceph/pull/53242), Patrick
    Donnelly)
-   mds: fix stray evaluation using scrub and introduce new option
    ([pr#50815](https://github.com/ceph/ceph/pull/50815), Dhairya
    Parmar)
-   mds: Fix the linkmerge assert check
    ([pr#52725](https://github.com/ceph/ceph/pull/52725), Kotresh HR)
-   mds: force replay sessionmap version
    ([pr#50724](https://github.com/ceph/ceph/pull/50724), Xiubo Li)
-   mds: make num_fwd and num_retry to \_\_u32
    ([pr#50732](https://github.com/ceph/ceph/pull/50732), Xiubo Li)
-   mds: MDLog::\_recovery_thread: handle the errors gracefully
    ([pr#52514](https://github.com/ceph/ceph/pull/52514), Jos Collin)
-   mds: rdlock_path_xlock_dentry supports returning auth target inode
    ([pr#51688](https://github.com/ceph/ceph/pull/51688), Zhansong Gao)
-   mds: record and dump last tid for trimming completed requests (or
    flushes) ([issue#57985](http://tracker.ceph.com/issues/57985),
    [pr#50785](https://github.com/ceph/ceph/pull/50785), Venky Shankar)
-   mds: session ls command appears twice in command listing
    ([pr#52516](https://github.com/ceph/ceph/pull/52516), Neeraj Pratap
    Singh)
-   mds: skip forwarding request if the session were removed
    ([pr#52845](https://github.com/ceph/ceph/pull/52845), Xiubo Li)
-   mds: update mdlog perf counters during replay
    ([pr#52683](https://github.com/ceph/ceph/pull/52683), Patrick
    Donnelly)
-   mds: wait for unlink operation to finish
    ([pr#50985](https://github.com/ceph/ceph/pull/50985), Xiubo Li)
-   mds: wait reintegrate to finish when unlinking
    ([pr#51685](https://github.com/ceph/ceph/pull/51685), Xiubo Li)
-   mgr/cephadm: add commands to set services to managed/unmanaged
    ([pr#50897](https://github.com/ceph/ceph/pull/50897), Adam King)
-   mgr/cephadm: add more aggressive force flag for host maintenance
    enter ([pr#50901](https://github.com/ceph/ceph/pull/50901), Adam
    King)
-   mgr/cephadm: allow configuring anonymous access for grafana
    ([pr#51617](https://github.com/ceph/ceph/pull/51617), Adam King)
-   mgr/cephadm: allow setting mon crush locations through mon service
    spec ([pr#51217](https://github.com/ceph/ceph/pull/51217), Adam
    King)
-   mgr/cephadm: also don\'t write client files/tuned profiles to
    maintenance hosts
    ([pr#53705](https://github.com/ceph/ceph/pull/53705), Adam King)
-   mgr/cephadm: asyncio based universal timeout for ssh/cephadm
    commands ([pr#51218](https://github.com/ceph/ceph/pull/51218), Adam
    King)
-   mgr/cephadm: be aware of host\'s shortname and FQDN
    ([pr#50888](https://github.com/ceph/ceph/pull/50888), Adam King)
-   mgr/cephadm: don\'t add mgr into iscsi trusted_ip_list if it\'s
    already there ([pr#50521](https://github.com/ceph/ceph/pull/50521),
    Mykola Golub)
-   mgr/cephadm: handle HostConnectionError when checking for valid addr
    ([pr#50900](https://github.com/ceph/ceph/pull/50900), Adam King)
-   mgr/cephadm: increasing container stop timeout for OSDs
    ([pr#50903](https://github.com/ceph/ceph/pull/50903), Redouane
    Kachach)
-   mgr/cephadm: make upgrade respect use_repo_digest
    ([pr#50898](https://github.com/ceph/ceph/pull/50898), Adam King)
-   mgr/cephadm: support for nfs backed by VIP
    ([pr#51616](https://github.com/ceph/ceph/pull/51616), Adam King)
-   mgr/cephadm: update monitoring stack versions
    ([pr#51356](https://github.com/ceph/ceph/pull/51356), Nizamudeen A)
-   mgr/cephadm: use a dedicated cephadm tmp dir to copy remote files
    ([pr#50906](https://github.com/ceph/ceph/pull/50906), Redouane
    Kachach)
-   mgr/dashboard CRUD component backport
    ([pr#51367](https://github.com/ceph/ceph/pull/51367), Pedro Gonzalez
    Gomez, Pere Diaz Bou, Nizamudeen A, Ernesto Puerta)
-   mgr/dashboard: Add more decimals in latency graph
    ([pr#52728](https://github.com/ceph/ceph/pull/52728), Pedro Gonzalez
    Gomez)
-   mgr/dashboard: add popover to cluster status card
    ([pr#52027](https://github.com/ceph/ceph/pull/52027), Nizamudeen A)
-   mgr/dashboard: align charts of landing page
    ([pr#53544](https://github.com/ceph/ceph/pull/53544), Pedro Gonzalez
    Gomez)
-   mgr/dashboard: allow PUT in CORS
    ([pr#52706](https://github.com/ceph/ceph/pull/52706), Nizamudeen A)
-   mgr/dashboard: batch backport hackathon prs
    ([pr#51768](https://github.com/ceph/ceph/pull/51768), Nizamudeen A,
    Pedro Gonzalez Gomez, Ankush Behl, Pere Diaz Bou, Aashish Sharma,
    avanthakkar)
-   mgr/dashboard: bump moment from 2.29.3 to 2.29.4 in
    /src/pybind/mgr/dashboard/frontend
    ([pr#51358](https://github.com/ceph/ceph/pull/51358),
    dependabot\[bot\])
-   mgr/dashboard: disable promote on mirroring not enabled
    ([pr#52537](https://github.com/ceph/ceph/pull/52537), Pedro Gonzalez
    Gomez)
-   mgr/dashboard: disable protect if layering is not enabled on the
    image ([pr#53174](https://github.com/ceph/ceph/pull/53174),
    avanthakkar)
-   mgr/dashboard: enable protect option if layering enabled
    ([pr#53796](https://github.com/ceph/ceph/pull/53796), avanthakkar)
-   mgr/dashboard: expose more grafana configs in service form
    ([pr#51112](https://github.com/ceph/ceph/pull/51112), Nizamudeen A)
-   mgr/dashboard: fix a bug where data would plot wrongly
    ([pr#52332](https://github.com/ceph/ceph/pull/52332), Pedro Gonzalez
    Gomez)
-   mgr/dashboard: fix cephadm e2e expression changed error
    ([pr#51079](https://github.com/ceph/ceph/pull/51079), Nizamudeen A)
-   mgr/dashboard: fix CephPGImbalance alert
    ([pr#51252](https://github.com/ceph/ceph/pull/51252), Aashish
    Sharma)
-   mgr/dashboard: fix create osd default selected as recommended not
    working ([pr#51007](https://github.com/ceph/ceph/pull/51007),
    Nizamudeen A)
-   mgr/dashboard: fix displaying mirror image progress
    ([pr#50871](https://github.com/ceph/ceph/pull/50871), Pere Diaz Bou)
-   mgr/dashboard: fix eviction of all FS clients
    ([pr#51011](https://github.com/ceph/ceph/pull/51011), Pere Diaz Bou)
-   mgr/dashboard: fix image columns naming
    ([pr#53253](https://github.com/ceph/ceph/pull/53253), Pedro Gonzalez
    Gomez)
-   mgr/dashboard: fix issues with read-only user on landing page
    ([pr#51809](https://github.com/ceph/ceph/pull/51809), Pedro Gonzalez
    Gomez, Nizamudeen A)
-   mgr/dashboard: Fix rbd snapshot creation
    ([pr#51076](https://github.com/ceph/ceph/pull/51076), Aashish
    Sharma)
-   mgr/dashboard: fix regression caused by cephPgImabalance alert
    ([pr#51525](https://github.com/ceph/ceph/pull/51525), Aashish
    Sharma)
-   mgr/dashboard: fix rgw page issues when hostname not resolvable
    ([pr#53216](https://github.com/ceph/ceph/pull/53216), Nizamudeen A)
-   mgr/dashboard: fix test_dashboard_e2e.sh failure
    ([pr#51866](https://github.com/ceph/ceph/pull/51866), Nizamudeen A)
-   mgr/dashboard: fix the rbd mirroring configure check
    ([pr#51325](https://github.com/ceph/ceph/pull/51325), Nizamudeen A)
-   mgr/dashboard: fix the rgw roles page
    ([pr#51867](https://github.com/ceph/ceph/pull/51867), Nizamudeen A)
-   mgr/dashboard: force TLS 1.3
    ([pr#50526](https://github.com/ceph/ceph/pull/50526), Ernesto
    Puerta)
-   mgr/dashboard: hide notification on force promote
    ([pr#51164](https://github.com/ceph/ceph/pull/51164), Pedro Gonzalez
    Gomez)
-   mgr/dashboard: images -\> edit -\> disable checkboxes for layering
    and deef-flatten
    ([pr#53387](https://github.com/ceph/ceph/pull/53387), avanthakkar)
-   mgr/dashboard: Landing page v3
    ([pr#50608](https://github.com/ceph/ceph/pull/50608), Pedro Gonzalez
    Gomez, Nizamudeen A, bryanmontalvan)
-   mgr/dashboard: move cephadm e2e cleanup to jenkins job config
    ([pr#52388](https://github.com/ceph/ceph/pull/52388), Nizamudeen A)
-   mgr/dashboard: n/a entries behind primary snapshot mode
    ([pr#53225](https://github.com/ceph/ceph/pull/53225), Pere Diaz Bou)
-   mgr/dashboard: paginate hosts
    ([pr#52917](https://github.com/ceph/ceph/pull/52917), Pere Diaz Bou)
-   mgr/dashboard: rbd-mirror force promotion
    ([pr#51057](https://github.com/ceph/ceph/pull/51057), Pedro Gonzalez
    Gomez)
-   mgr/dashboard: remove unncessary hyperlink in landing page
    ([pr#51119](https://github.com/ceph/ceph/pull/51119), Nizamudeen A)
-   mgr/dashboard: remove used and total used columns in favor of usage
    bar ([pr#53303](https://github.com/ceph/ceph/pull/53303), Pedro
    Gonzalez Gomez)
-   mgr/dashboard: set CORS header for unauthorized access
    ([pr#53203](https://github.com/ceph/ceph/pull/53203), Nizamudeen A)
-   mgr/dashboard: skip Create OSDs step in Cluster expansion
    ([pr#51149](https://github.com/ceph/ceph/pull/51149), Nizamudeen A)
-   mgr/dashboard: SSO error: AttributeError: \'str\' object has no
    attribute \'decode\'
    ([pr#51952](https://github.com/ceph/ceph/pull/51952), Volker Theile)
-   mgr/nfs: disallow non-existent paths when creating export
    ([pr#50807](https://github.com/ceph/ceph/pull/50807), Dhairya
    Parmar)
-   mgr/orchestrator: allow deploying raw mode OSDs with
    \--all-available-devices
    ([pr#50891](https://github.com/ceph/ceph/pull/50891), Adam King)
-   mgr/orchestrator: fix device size in [orch device ls]{.title-ref}
    output ([pr#50899](https://github.com/ceph/ceph/pull/50899), Adam
    King)
-   mgr/prometheus: avoid duplicates and deleted entries for
    rbd_stats_pools
    ([pr#48523](https://github.com/ceph/ceph/pull/48523), Avan Thakkar)
-   mgr/prometheus: fix pool_objects_repaired and daemon_health_metrics
    format ([pr#51671](https://github.com/ceph/ceph/pull/51671),
    banuchka)
-   mgr/rbd_support: add user-friendly stderr message when module is not
    ready ([pr#52189](https://github.com/ceph/ceph/pull/52189), Ramana
    Raja)
-   mgr/rbd_support: recover from \"double blocklisting\"
    ([pr#51758](https://github.com/ceph/ceph/pull/51758), Ramana Raja)
-   mgr/rbd_support: recover from rados client blocklisting
    ([pr#51455](https://github.com/ceph/ceph/pull/51455), Ramana Raja)
-   mgr/rgw: initial multisite deployment work
    ([pr#50887](https://github.com/ceph/ceph/pull/50887), Redouane
    Kachach)
-   mgr/snap_schedule: add debug log for paths failing snapshot creation
    ([pr#50780](https://github.com/ceph/ceph/pull/50780), Milind
    Changire)
-   mgr/snap_schedule: allow retention spec \'n\' to be user defined
    ([pr#52749](https://github.com/ceph/ceph/pull/52749), Milind
    Changire, Jakob Haufe)
-   mgr/snap_schedule: catch all exceptions for cli
    ([pr#52752](https://github.com/ceph/ceph/pull/52752), Milind
    Changire)
-   mgr/telemetry: compile all channels and collections in selftest
    ([pr#51761](https://github.com/ceph/ceph/pull/51761), Laura Flores)
-   mgr/telemetry: fixed log exceptions as \"exception\" instead of
    \"error\" ([pr#51244](https://github.com/ceph/ceph/pull/51244),
    Vonesha Frost)
-   mgr/telemetry: make sure histograms are formatted in
    [all]{.title-ref} commands
    ([pr#50480](https://github.com/ceph/ceph/pull/50480), Laura Flores)
-   mgr/volumes: avoid returning -ESHUTDOWN back to cli
    ([issue#58651](http://tracker.ceph.com/issues/58651),
    [pr#50786](https://github.com/ceph/ceph/pull/50786), Venky Shankar)
-   mgr/volumes: Fix pending_subvolume_deletions in volume info
    ([pr#53573](https://github.com/ceph/ceph/pull/53573), Kotresh HR)
-   mgr: Add one finisher thread per module
    ([pr#51044](https://github.com/ceph/ceph/pull/51044), Kotresh HR,
    Patrick Donnelly)
-   mgr: add urllib3==1.26.15 to mgr/requirements.txt
    ([pr#51335](https://github.com/ceph/ceph/pull/51335), Laura Flores)
-   mgr: register OSDs in ms_handle_accept
    ([pr#53188](https://github.com/ceph/ceph/pull/53188), Patrick
    Donnelly)
-   mgr: store names of modules that register RADOS clients in the
    MgrMap ([pr#50964](https://github.com/ceph/ceph/pull/50964), Ramana
    Raja)
-   MgrMonitor: batch commit OSDMap and MgrMap mutations
    ([pr#50979](https://github.com/ceph/ceph/pull/50979), Patrick
    Donnelly, Kefu Chai, Radosław Zarzyński)
-   mon, qa: issue pool application warning even if pool is empty
    ([pr#53042](https://github.com/ceph/ceph/pull/53042), Prashant D)
-   mon/ConfigMonitor: update crush_location from osd entity
    ([pr#52467](https://github.com/ceph/ceph/pull/52467), Didier Gazen)
-   mon/MDSMonitor: batch last_metadata update with pending
    ([pr#52228](https://github.com/ceph/ceph/pull/52228), Patrick
    Donnelly)
-   mon/MDSMonitor: check fscid in pending exists in current
    ([pr#52234](https://github.com/ceph/ceph/pull/52234), Patrick
    Donnelly)
-   mon/MDSMonitor: do not propose on error in prepare_update
    ([pr#52239](https://github.com/ceph/ceph/pull/52239), Patrick
    Donnelly)
-   mon/MDSMonitor: ignore extraneous up:boot messages
    ([pr#52243](https://github.com/ceph/ceph/pull/52243), Patrick
    Donnelly)
-   mon/MDSMonitor: plug paxos when maybe manipulating osdmap
    ([pr#52983](https://github.com/ceph/ceph/pull/52983), Patrick
    Donnelly)
-   mon/MonClient: before complete auth with error, reopen session
    ([pr#52134](https://github.com/ceph/ceph/pull/52134), Nitzan
    Mordechai)
-   mon/MonClient: resurrect original client_mount_timeout handling
    ([pr#52534](https://github.com/ceph/ceph/pull/52534), Ilya Dryomov)
-   mon/Monitor.cc: exit function if !osdmon()-\>is_writeable() &&
    mon/OSDMonitor: Added extra check before
    mon.go_recovery_stretch_mode()
    ([pr#51413](https://github.com/ceph/ceph/pull/51413), Kamoltat)
-   mon: avoid exception when setting require-osd-release more than 2
    ([pr#51102](https://github.com/ceph/ceph/pull/51102), Igor Fedotov)
-   mon: block osd pool mksnap for fs pools
    ([pr#52398](https://github.com/ceph/ceph/pull/52398), Milind
    Changire)
-   mon: Fix ceph versions command
    ([pr#52161](https://github.com/ceph/ceph/pull/52161), Prashant D)
-   mon: fix iterator mishandling in PGMap::apply_incremental
    ([pr#52553](https://github.com/ceph/ceph/pull/52553), Oliver
    Schmidt)
-   msg/async: don\'t abort when public addrs mismatch bind addrs
    ([pr#50575](https://github.com/ceph/ceph/pull/50575), Radosław
    Zarzyński)
-   orchestrator: add [\--no-destroy]{.title-ref} arg to [ceph orch osd
    rm]{.title-ref}
    ([pr#51215](https://github.com/ceph/ceph/pull/51215), Guillaume
    Abrioux)
-   orchestrator: improvements to the orch host ls command
    ([pr#50889](https://github.com/ceph/ceph/pull/50889), Paul Cuzner)
-   os/bluestore/bluefs: fix dir_link might add link that already exists
    in compact log ([pr#51002](https://github.com/ceph/ceph/pull/51002),
    ethanwu, Adam Kupczyk)
-   os/bluestore: Add bluefs write op count metrics
    ([pr#51777](https://github.com/ceph/ceph/pull/51777), Joshua
    Baergen)
-   os/bluestore: allow \'fit_to_fast\' selector for single-volume osd
    ([pr#51412](https://github.com/ceph/ceph/pull/51412), Igor Fedotov)
-   os/bluestore: do not signal deleted dirty file to bluefs log
    ([pr#48171](https://github.com/ceph/ceph/pull/48171), Igor Fedotov)
-   os/bluestore: don\'t require bluestore_db_block_size when attaching
    new ([pr#52941](https://github.com/ceph/ceph/pull/52941), Igor
    Fedotov)
-   os/bluestore: fix no metadata update on truncate+fsync
    ([pr#48169](https://github.com/ceph/ceph/pull/48169), Igor Fedotov)
-   os/bluestore: fix spillover alert
    ([pr#50931](https://github.com/ceph/ceph/pull/50931), Igor Fedotov)
-   os/bluestore: log before assert in AvlAllocator
    ([pr#50319](https://github.com/ceph/ceph/pull/50319), Igor Fedotov)
-   os/bluestore: proper locking for Allocators\' dump methods
    ([pr#48170](https://github.com/ceph/ceph/pull/48170), Igor Fedotov)
-   os/bluestore: proper override rocksdb::WritableFile::Allocate
    ([pr#51774](https://github.com/ceph/ceph/pull/51774), Igor Fedotov)
-   os/bluestore: report min_alloc_size through \"ceph osd metadata\"
    ([pr#50505](https://github.com/ceph/ceph/pull/50505), Igor Fedotov)
-   os/bluestore: use direct write in BlueStore::\_write_bdev_label
    ([pr#48279](https://github.com/ceph/ceph/pull/48279), luo rixin)
-   osd, mon: add pglog dups length
    ([pr#47840](https://github.com/ceph/ceph/pull/47840), Nitzan
    Mordechai)
-   osd/OpRequest: Add detailed description for delayed op in osd log
    file ([pr#53690](https://github.com/ceph/ceph/pull/53690), Yite Gu)
-   osd/OSDCap: allow rbd.metadata_list method under rbd-read-only
    profile ([pr#51877](https://github.com/ceph/ceph/pull/51877), Ilya
    Dryomov)
-   osd/PeeringState: fix missed [recheck_readable]{.title-ref} from
    laggy ([pr#49304](https://github.com/ceph/ceph/pull/49304), 胡玮文)
-   osd/scheduler/mClockScheduler: Use same profile and client ids for
    all clients to ensure allocated QoS limit consumption
    ([pr#53092](https://github.com/ceph/ceph/pull/53092), Sridhar
    Seshasayee)
-   osd/scheduler: Reset ephemeral changes to mClock built-in profile
    ([pr#51664](https://github.com/ceph/ceph/pull/51664), Sridhar
    Seshasayee)
-   osd/scrub: verify SnapMapper consistency
    ([pr#52256](https://github.com/ceph/ceph/pull/52256), Ronen
    Friedman, Tim Serong, Kefu Chai, Adam C. Emerson)
-   osd: bring the missed fmt::formatter for snapid_t to address FTBFS
    ([pr#54175](https://github.com/ceph/ceph/pull/54175), Radosław
    Zarzyński)
-   osd: Change scrub cost in case of mClock scheduler
    ([pr#51728](https://github.com/ceph/ceph/pull/51728), Aishwarya
    Mathuria)
-   OSD: during test start, not all osds started due to consum map hang
    ([pr#51807](https://github.com/ceph/ceph/pull/51807), Nitzan
    Mordechai)
-   OSD: Fix check_past_interval_bounds()
    ([pr#51512](https://github.com/ceph/ceph/pull/51512), Matan
    Breizman, Samuel Just)
-   osd: fix: slow scheduling when item_cost is large
    ([pr#53860](https://github.com/ceph/ceph/pull/53860), Jrchyang Yu)
-   osd: mClock recovery/backfill cost fixes
    ([pr#49973](https://github.com/ceph/ceph/pull/49973), Sridhar
    Seshasayee, Samuel Just)
-   osd: set per_pool_stats true when OSD has no PG
    ([pr#48249](https://github.com/ceph/ceph/pull/48249), jindengke,
    lmgdlmgd)
-   PendingReleaseNotes: Document mClock scheduler fixes and
    enhancements ([pr#51978](https://github.com/ceph/ceph/pull/51978),
    Sridhar Seshasayee)
-   pybind/argparse: blocklist ip validation
    ([pr#51811](https://github.com/ceph/ceph/pull/51811), Nitzan
    Mordechai)
-   pybind/mgr/devicehealth: do not crash if db not ready
    ([pr#52215](https://github.com/ceph/ceph/pull/52215), Patrick
    Donnelly)
-   pybind/mgr/pg_autoscaler: fix warn when not too few pgs
    ([pr#53675](https://github.com/ceph/ceph/pull/53675), Kamoltat)
-   pybind/mgr/pg_autoscaler: noautoscale flag retains individual pool
    configs ([pr#53677](https://github.com/ceph/ceph/pull/53677),
    Kamoltat)
-   pybind/mgr/pg_autoscaler: Reorderd if statement for the func:
    \_maybe_adjust ([pr#50693](https://github.com/ceph/ceph/pull/50693),
    Kamoltat)
-   pybind/mgr/pg_autoscaler: Use bytes_used for actual_raw_used
    ([pr#53725](https://github.com/ceph/ceph/pull/53725), Kamoltat)
-   pybind: drop GIL during library callouts
    ([pr#52322](https://github.com/ceph/ceph/pull/52322), Ilya Dryomov,
    Patrick Donnelly)
-   python-common: drive_selection: fix KeyError when osdspec_affinity
    is not set ([pr#53158](https://github.com/ceph/ceph/pull/53158),
    Guillaume Abrioux)
-   qa/cephfs: add \'rhel\' to family of RH OS in xfstest_dev.py
    ([pr#52585](https://github.com/ceph/ceph/pull/52585), Rishabh Dave)
-   qa/rgw: add new POOL_APP_NOT_ENABLED failures to log-ignorelist
    ([pr#53895](https://github.com/ceph/ceph/pull/53895), Casey Bodley)
-   qa/smoke,rados,perf-basic: add POOL_APP_NOT_ENABLED to ignorelist
    ([pr#54065](https://github.com/ceph/ceph/pull/54065), Prashant D)
-   qa/standalone/osd/divergent-prior.sh: Divergent test 3 with
    pg_autoscale_mode on pick divergent osd
    ([pr#52722](https://github.com/ceph/ceph/pull/52722), Nitzan
    Mordechai)
-   qa/suites/krbd: stress test for recovering from watch errors
    ([pr#53785](https://github.com/ceph/ceph/pull/53785), Ilya Dryomov)
-   qa/suites/rados: remove rook coverage from the rados suite
    ([pr#52016](https://github.com/ceph/ceph/pull/52016), Laura Flores)
-   qa/suites/rados: whitelist POOL_APP_NOT_ENABLED for cls tests
    ([pr#52137](https://github.com/ceph/ceph/pull/52137), Laura Flores)
-   qa/suites/rbd: install qemu-utils in addition to qemu-block-extra on
    Ubuntu ([pr#51060](https://github.com/ceph/ceph/pull/51060), Ilya
    Dryomov)
-   qa/suites/upgrade/octopus-x: skip TestClsRbd.mirror_snapshot test
    ([pr#52992](https://github.com/ceph/ceph/pull/52992), Ilya Dryomov)
-   qa/suites/upgrade/quincy-p2p: skip TestClsRbd.mirror_snapshot test
    ([pr#53338](https://github.com/ceph/ceph/pull/53338), Ilya Dryomov)
-   qa/suites/{rbd,krbd}: disable POOL_APP_NOT_ENABLED health check
    ([pr#53598](https://github.com/ceph/ceph/pull/53598), Ilya Dryomov)
-   qa/tasks: Changing default mClock profile to high_recovery_ops
    ([pr#51568](https://github.com/ceph/ceph/pull/51568), Aishwarya
    Mathuria)
-   qa/upgrade/quincy-p2p: remove s3tests
    ([pr#54078](https://github.com/ceph/ceph/pull/54078), Casey Bodley)
-   qa/upgrade: consistently use the tip of the branch as the start
    version ([pr#50747](https://github.com/ceph/ceph/pull/50747), Yuri
    Weinstein)
-   qa/workunits/rados/test_dedup_tool.sh: reset dedup tier during tests
    ([pr#51780](https://github.com/ceph/ceph/pull/51780), Myoungwon Oh)
-   qa: add [POOL_APP_NOT_ENABLED]{.title-ref} to ignorelist for cephfs
    tests ([issue#62508](http://tracker.ceph.com/issues/62508),
    [issue#62482](http://tracker.ceph.com/issues/62482),
    [pr#53863](https://github.com/ceph/ceph/pull/53863), Venky Shankar,
    Patrick Donnelly)
-   qa: check each fs for health
    ([pr#52241](https://github.com/ceph/ceph/pull/52241), Patrick
    Donnelly)
-   qa: cleanup volumes on unwind
    ([pr#50766](https://github.com/ceph/ceph/pull/50766), Patrick
    Donnelly)
-   qa: enable kclient test for newop test
    ([pr#50991](https://github.com/ceph/ceph/pull/50991), Xiubo Li,
    Dhairya Parmar)
-   qa: fix cephfs-mirror unwinding and \'fs volume create/rm\' order
    ([pr#52653](https://github.com/ceph/ceph/pull/52653), Jos Collin)
-   qa: ignore expected cluster warning from damage tests
    ([pr#53485](https://github.com/ceph/ceph/pull/53485), Patrick
    Donnelly)
-   qa: ignore expected scrub error
    ([pr#50774](https://github.com/ceph/ceph/pull/50774), Patrick
    Donnelly)
-   qa: ignore MDS_TRIM warnings when osd thrashing
    ([pr#50768](https://github.com/ceph/ceph/pull/50768), Patrick
    Donnelly)
-   qa: output higher debugging for cephfs-journal-tool/cephfs-data-scan
    ([pr#50772](https://github.com/ceph/ceph/pull/50772), Patrick
    Donnelly)
-   qa: run scrub post file system recovery
    ([issue#59527](http://tracker.ceph.com/issues/59527),
    [pr#51690](https://github.com/ceph/ceph/pull/51690), Venky Shankar)
-   qa: test_rebuild_simple checks status on wrong file system
    ([pr#50922](https://github.com/ceph/ceph/pull/50922), Patrick
    Donnelly)
-   qa: test_recovery_pool uses wrong recovery procedure
    ([pr#50767](https://github.com/ceph/ceph/pull/50767), Patrick
    Donnelly)
-   qa: use parallel gzip for compressing logs
    ([pr#52952](https://github.com/ceph/ceph/pull/52952), Patrick
    Donnelly)
-   qa: wait for file to have correct size
    ([pr#52743](https://github.com/ceph/ceph/pull/52743), Patrick
    Donnelly)
-   qa: wait for MDSMonitor tick to replace daemons
    ([pr#52236](https://github.com/ceph/ceph/pull/52236), Patrick
    Donnelly)
-   radosgw-admin: try reshard even if bucket is resharding
    ([pr#51835](https://github.com/ceph/ceph/pull/51835), Casey Bodley)
-   rbd-mirror: fix image replayer shut down description on force
    promote ([pr#52879](https://github.com/ceph/ceph/pull/52879),
    Prasanna Kumar Kalever)
-   rbd-mirror: fix race preventing local image deletion
    ([pr#52626](https://github.com/ceph/ceph/pull/52626), N
    Balachandran)
-   rbd-wnbd: improve image map error message
    ([pr#52289](https://github.com/ceph/ceph/pull/52289), Lucian Petrut)
-   RGW - Fix NoSuchTagSet error
    ([pr#50103](https://github.com/ceph/ceph/pull/50103), Daniel
    Gryniewicz)
-   RGW - Use correct multipart upload time
    ([pr#51834](https://github.com/ceph/ceph/pull/51834), Daniel
    Gryniewicz)
-   rgw multisite: complete fix for metadata sync issue
    ([pr#51496](https://github.com/ceph/ceph/pull/51496), Shilpa
    Jagannath, gengjichao)
-   rgw/admin: \'bucket stats\' displays non-empty time
    ([pr#50485](https://github.com/ceph/ceph/pull/50485), Casey Bodley)
-   rgw/lua: allow bucket name override in pre request
    ([pr#51300](https://github.com/ceph/ceph/pull/51300), Yuval
    Lifshitz)
-   rgw/notifications: send mtime in complete multipart upload event
    ([pr#50962](https://github.com/ceph/ceph/pull/50962), yuval
    Lifshitz)
-   rgw/notifications: sending metadata in COPY and
    CompleteMultipartUpload
    ([pr#49808](https://github.com/ceph/ceph/pull/49808), yuval
    Lifshitz)
-   rgw/rados: check_quota() uses real bucket owner
    ([pr#51329](https://github.com/ceph/ceph/pull/51329), Mykola Golub,
    Casey Bodley)
-   rgw/swift: check position of first slash in slo manifest files
    ([pr#51598](https://github.com/ceph/ceph/pull/51598), Marcio Roberto
    Starke)
-   rgw/sync-policy: Correct \"sync status\" & \"sync group\" commands
    ([pr#53396](https://github.com/ceph/ceph/pull/53396), Soumya Koduri)
-   rgw: add radosgw-admin bucket check olh/unlinked commands
    ([pr#53821](https://github.com/ceph/ceph/pull/53821), Cory Snyder)
-   rgw: avoid string_view to temporary in RGWBulkUploadOp
    ([pr#52158](https://github.com/ceph/ceph/pull/52158), Casey Bodley)
-   rgw: concurrency for multi object deletes
    ([pr#50208](https://github.com/ceph/ceph/pull/50208), Casey Bodley,
    Cory Snyder)
-   rgw: D3N cache objects which oid contains slash
    ([pr#52320](https://github.com/ceph/ceph/pull/52320), Mark Kogan)
-   rgw: fetch_remote_obj() preserves original part lengths for
    BlockDecrypt ([pr#52818](https://github.com/ceph/ceph/pull/52818),
    Casey Bodley)
-   rgw: fix 2 null versionID after convert_plain_entry_to_versioned
    ([pr#53399](https://github.com/ceph/ceph/pull/53399), rui ma, zhuo
    li)
-   rgw: fix consistency bug with OLH objects
    ([pr#52538](https://github.com/ceph/ceph/pull/52538), Cory Snyder)
-   rgw: fix FP error when calculating enteries per bi shard
    ([pr#53592](https://github.com/ceph/ceph/pull/53592), J. Eric
    Ivancich)
-   rgw: fix rgw rate limiting RGWRateLimitInfo class decode_json
    max_rea... ([pr#53766](https://github.com/ceph/ceph/pull/53766),
    xiangrui meng)
-   rgw: fix SignatureDoesNotMatch when extra headers start with
    \'x-amz\' ([pr#53771](https://github.com/ceph/ceph/pull/53771), rui
    ma)
-   rgw: fix unwatch crash at radosgw startup
    ([pr#53761](https://github.com/ceph/ceph/pull/53761), lichaochao)
-   rgw: handle http options CORS with v4 auth
    ([pr#53414](https://github.com/ceph/ceph/pull/53414), Tobias Urdin)
-   rgw: improve buffer list utilization in the chunkupload scenario
    ([pr#53774](https://github.com/ceph/ceph/pull/53774), liubingrun)
-   rgw: LDAP fix resource leak with wrong credentials
    ([pr#50562](https://github.com/ceph/ceph/pull/50562), Johannes
    Liebl, Johannes)
-   rgw: optimizations for handling ECANCELED errors from within
    get_obj_state ([pr#50892](https://github.com/ceph/ceph/pull/50892),
    Cory Snyder)
-   rgw: pick http_date in case of http_x_amz_date absence
    ([pr#53441](https://github.com/ceph/ceph/pull/53441), Seena Fallah,
    Mohamed Awnallah)
-   rgw: retry metadata cache notifications with INVALIDATE_OBJ
    ([pr#52799](https://github.com/ceph/ceph/pull/52799), Casey Bodley)
-   rgw: rgw_parse_url_bucket() rejects empty bucket names after
    \'tenant:\' ([pr#50625](https://github.com/ceph/ceph/pull/50625),
    Casey Bodley)
-   rgw: s3website doesn\'t prefetch for web_dir() check
    ([pr#53768](https://github.com/ceph/ceph/pull/53768), Casey Bodley)
-   rgw: set keys from from master zone on admin api user create
    ([pr#51601](https://github.com/ceph/ceph/pull/51601), Ali Maredia)
-   rgw: swift : check for valid key in POST forms
    ([pr#52739](https://github.com/ceph/ceph/pull/52739), Abhishek
    Lekshmanan)
-   rgw: under fips & openssl 3.x allow md5 usage in select rgw ops
    ([pr#51269](https://github.com/ceph/ceph/pull/51269), Mark Kogan)
-   rgwlc: prevent lc for one bucket from exceeding time budget
    ([pr#53561](https://github.com/ceph/ceph/pull/53561), Matt Benjamin)
-   test/cli-integration/rbd: iSCSI REST API responses aren\'t
    pretty-printed anymore
    ([pr#52283](https://github.com/ceph/ceph/pull/52283), Ilya Dryomov)
-   test: correct osd pool default size
    ([pr#51804](https://github.com/ceph/ceph/pull/51804), Nitzan
    Mordechai)
-   test: monitor thrasher wait until quorum
    ([pr#51801](https://github.com/ceph/ceph/pull/51801), Nitzan
    Mordechai)
-   tools/ceph-dencoder: Fix incorrect type define for trash_watcher
    ([pr#51779](https://github.com/ceph/ceph/pull/51779), Chen Yuanrun)
-   tools/cephfs-data-scan: support for multi-datapool
    ([pr#50522](https://github.com/ceph/ceph/pull/50522), Mykola Golub)
-   tools/cephfs: add basic detection/cleanup tool for dentry first
    damage ([pr#52245](https://github.com/ceph/ceph/pull/52245), Patrick
    Donnelly)
-   tools/cephfs: include lost+found in scan_links
    ([pr#50783](https://github.com/ceph/ceph/pull/50783), Patrick
    Donnelly)
-   vstart: check mgr status after starting mgr
    ([pr#51603](https://github.com/ceph/ceph/pull/51603), Rongqi Sun)
-   vstart: fix text format
    ([pr#51124](https://github.com/ceph/ceph/pull/51124), Rongqi Sun)
-   win32_deps_build: avoid pip
    ([pr#51129](https://github.com/ceph/ceph/pull/51129), Lucian Petrut,
    Ken Dreyer)
-   Wip doc 2023 04 23 backport 51178 to quincy
    ([pr#51185](https://github.com/ceph/ceph/pull/51185), Zac Dover)
-   Wip nitzan fixing few rados/test.sh
    ([pr#49938](https://github.com/ceph/ceph/pull/49938), Nitzan
    Mordechai)
-   Wip nitzan pglog ec getattr error
    ([pr#49936](https://github.com/ceph/ceph/pull/49936), Nitzan
    Mordechai)

## v17.2.6 Quincy

This is the sixth backport release in the Quincy series. We recommend
that all users update to this release.

### Notable Changes

-   [ceph mgr dump]{.title-ref} command now outputs
    [last_failure_osd_epoch]{.title-ref} and
    [active_clients]{.title-ref} fields at the top level. Previously,
    these fields were output under [always_on_modules]{.title-ref}
    field.
-   telemetry: Added new metrics to the \'basic\' channel to report
    per-pool bluestore compression metrics. See a sample report with
    [ceph telemetry preview]{.title-ref}. Opt-in with [ceph telemetry
    on]{.title-ref}.

### Changelog

-   msg/async: don\'t abort when public addrs mismatch bind addrs
    ([pr#50575](https://github.com/ceph/ceph/pull/50575), Radoslaw
    Zarzynski)
-   rgw: rgw_parse_url_bucket() rejects empty bucket names after
    \'tenant:\' ([pr#50625](https://github.com/ceph/ceph/pull/50625),
    Casey Bodley)
-   os/bluestore: Improve deferred write decision
    ([pr#49333](https://github.com/ceph/ceph/pull/49333), Adam Kupczyk,
    Igor Fedotov)
-   rgw/cloud-transition: Fix issues with MCG endpoint
    ([pr#49061](https://github.com/ceph/ceph/pull/49061), Soumya Koduri)
-   Add per OSD crush_device_class definition
    ([pr#50444](https://github.com/ceph/ceph/pull/50444), Francesco
    Pantano)
-   ceph-crash: drop privileges to run as \"ceph\" user, rather than
    root (CVE-2022-3650)
    ([pr#48805](https://github.com/ceph/ceph/pull/48805), Tim Serong,
    Guillaume Abrioux)
-   ceph-dencoder: Add erasure_code to denc-mod-osd\'s
    target_link_libraries
    ([pr#48028](https://github.com/ceph/ceph/pull/48028), Tim Serong)
-   ceph-mixing: fix ceph_hosts variable
    ([pr#48934](https://github.com/ceph/ceph/pull/48934), Tatjana
    Dehler)
-   ceph-volume/tests: add allowlist_externals to tox.ini
    ([pr#49788](https://github.com/ceph/ceph/pull/49788), Guillaume
    Abrioux)
-   ceph-volume/tests: fix lvm centos8-filestore-create job
    ([pr#48122](https://github.com/ceph/ceph/pull/48122), Guillaume
    Abrioux)
-   ceph-volume: add a retry in util.disk.remove_partition
    ([pr#47989](https://github.com/ceph/ceph/pull/47989), Guillaume
    Abrioux)
-   ceph-volume: do not raise RuntimeError in util.lsblk
    ([pr#50144](https://github.com/ceph/ceph/pull/50144), Guillaume
    Abrioux)
-   ceph-volume: fix a bug in get_all_devices_vgs()
    ([pr#49453](https://github.com/ceph/ceph/pull/49453), Guillaume
    Abrioux)
-   ceph-volume: fix a bug in lsblk_all()
    ([pr#49868](https://github.com/ceph/ceph/pull/49868), Guillaume
    Abrioux)
-   ceph-volume: legacy_encrypted() shouldn\'t call lsblk() when device
    is \'tmpfs\' ([pr#50161](https://github.com/ceph/ceph/pull/50161),
    Guillaume Abrioux)
-   ceph.spec.in: disable system_pmdk on s390x for SUSE distros
    ([pr#48522](https://github.com/ceph/ceph/pull/48522), Tim Serong)
-   ceph.spec.in: Replace %usrmerged macro with regular version check
    ([pr#49831](https://github.com/ceph/ceph/pull/49831), Tim Serong)
-   ceph.spec.in: Use gcc11-c++ on openSUSE Leap 15.x
    ([pr#48058](https://github.com/ceph/ceph/pull/48058), Tim Serong)
-   ceph_fuse: retry the test_dentry_handling if fails
    ([pr#49942](https://github.com/ceph/ceph/pull/49942), Xiubo Li)
-   cephadm: add [ip_nonlocal_bind]{.title-ref} to haproxy deployment
    ([pr#48211](https://github.com/ceph/ceph/pull/48211), Michael
    Fritch)
-   cephadm: Adding poststop actions and setting TimeoutStartSec to 200s
    ([pr#50447](https://github.com/ceph/ceph/pull/50447), Redouane
    Kachach)
-   cephadm: consider stdout to get container version
    ([pr#48208](https://github.com/ceph/ceph/pull/48208), Tatjana
    Dehler)
-   cephadm: don\'t overwrite cluster logrotate file
    ([pr#49849](https://github.com/ceph/ceph/pull/49849), Adam King)
-   cephadm: Fix disk size calculation
    ([pr#47945](https://github.com/ceph/ceph/pull/47945), Paul Cuzner)
-   cephadm: only pull host info from applied spec, don\'t try to parse
    yaml ([pr#49854](https://github.com/ceph/ceph/pull/49854), Adam
    King)
-   cephadm: pin flake8 to 5.0.4
    ([pr#49059](https://github.com/ceph/ceph/pull/49059), Kefu Chai)
-   cephadm: run tests as root
    ([pr#48434](https://github.com/ceph/ceph/pull/48434), Kefu Chai)
-   cephadm: set pids-limit unlimited for all ceph daemons
    ([pr#50448](https://github.com/ceph/ceph/pull/50448), Adam King,
    Teoman ONAY)
-   cephadm: support quotes around public/cluster network in config
    passed to bootstrap
    ([pr#47660](https://github.com/ceph/ceph/pull/47660), Adam King)
-   cephadm: using short hostname to create the initial mon and mgr
    ([pr#50445](https://github.com/ceph/ceph/pull/50445), Redouane
    Kachach)
-   cephfs-data-scan: make scan_links more verbose
    ([pr#48442](https://github.com/ceph/ceph/pull/48442), Mykola Golub)
-   cephfs-top, mgr/stats: multiple file system support with UI
    ([pr#47820](https://github.com/ceph/ceph/pull/47820), Neeraj Pratap
    Singh)
-   cephfs-top: addition of sort feature and limit option
    ([pr#50151](https://github.com/ceph/ceph/pull/50151), Neeraj Pratap
    Singh, Jos Collin)
-   cephfs-top: make cephfs-top display scrollable
    ([pr#48677](https://github.com/ceph/ceph/pull/48677), Jos Collin)
-   client: abort the client if we couldn\'t invalidate dentry caches
    ([pr#48110](https://github.com/ceph/ceph/pull/48110), Xiubo Li)
-   client: do not uninline data for read
    ([pr#48132](https://github.com/ceph/ceph/pull/48132), Xiubo Li)
-   client: fix incorrectly showing the .snap size for stat
    ([pr#48414](https://github.com/ceph/ceph/pull/48414), Xiubo Li)
-   client: stop the remount_finisher thread in the Client::unmount()
    ([pr#48107](https://github.com/ceph/ceph/pull/48107), Xiubo Li)
-   client: use parent directory POSIX ACLs for snapshot dir
    ([issue#57084](http://tracker.ceph.com/issues/57084),
    [pr#48563](https://github.com/ceph/ceph/pull/48563), Venky Shankar)
-   cls/queue: use larger read chunks in queue_list_entries
    ([pr#49902](https://github.com/ceph/ceph/pull/49902), Igor Fedotov)
-   cls/rbd: update last_read in group::snap_list
    ([pr#49196](https://github.com/ceph/ceph/pull/49196), Ilya Dryomov,
    Prasanna Kumar Kalever)
-   cls/rgw: remove index entry after cancelling last racing delete op
    ([pr#50241](https://github.com/ceph/ceph/pull/50241), Casey Bodley)
-   cmake: bump node version to 14
    ([pr#50231](https://github.com/ceph/ceph/pull/50231), Nizamudeen A)
-   cmake: re-enable TCMalloc and allocator related cleanups
    ([pr#47927](https://github.com/ceph/ceph/pull/47927), Kefu Chai)
-   CODEOWNERS: assign qa/workunits/windows to RBD
    ([pr#50304](https://github.com/ceph/ceph/pull/50304), Ilya Dryomov)
-   common/ceph_context: leak some memory fail to show in valgrind
    ([pr#47933](https://github.com/ceph/ceph/pull/47933), Nitzan
    Mordechai)
-   common: fix build with GCC 13 (missing \<cstdint\> include)
    ([pr#48719](https://github.com/ceph/ceph/pull/48719), Sam James)
-   common: notify all when max backlog reached in OutputDataSocket
    ([pr#47233](https://github.com/ceph/ceph/pull/47233), Shu Yu)
-   compressor: fix rpmbuild on RHEL-8
    ([pr#48314](https://github.com/ceph/ceph/pull/48314), Andriy
    Tkachuk)
-   doc/\_static: add scroll-margin-top to custom.css
    ([pr#49644](https://github.com/ceph/ceph/pull/49644), Zac Dover)
-   doc/architecture: correct PDF link
    ([pr#48795](https://github.com/ceph/ceph/pull/48795), Zac Dover)
-   doc/ceph-volume: add A. D\'Atri\'s suggestions
    ([pr#48645](https://github.com/ceph/ceph/pull/48645), Zac Dover)
-   doc/ceph-volume: fix cephadm references
    ([pr#50115](https://github.com/ceph/ceph/pull/50115), Piotr
    Parczewski)
-   doc/ceph-volume: improve prepare.rst
    ([pr#48668](https://github.com/ceph/ceph/pull/48668), Zac Dover)
-   doc/ceph-volume: refine \"bluestore\" section
    ([pr#48634](https://github.com/ceph/ceph/pull/48634), Zac Dover)
-   doc/ceph-volume: refine \"filestore\" section
    ([pr#48636](https://github.com/ceph/ceph/pull/48636), Zac Dover)
-   doc/ceph-volume: refine \"prepare\" top matter
    ([pr#48651](https://github.com/ceph/ceph/pull/48651), Zac Dover)
-   doc/ceph-volume: refine encryption.rst
    ([pr#49792](https://github.com/ceph/ceph/pull/49792), Zac Dover)
-   doc/ceph-volume: refine Filestore docs
    ([pr#48670](https://github.com/ceph/ceph/pull/48670), Zac Dover)
-   doc/ceph-volume: update LUKS docs
    ([pr#49757](https://github.com/ceph/ceph/pull/49757), Zac Dover)
-   doc/cephadm - remove \"danger\" admonition
    ([pr#49169](https://github.com/ceph/ceph/pull/49169), Zac Dover)
-   doc/cephadm/host-management: add service spec link
    ([pr#50254](https://github.com/ceph/ceph/pull/50254), thomas)
-   doc/cephadm/troubleshooting: remove word repeat
    ([pr#50222](https://github.com/ceph/ceph/pull/50222), thomas)
-   doc/cephadm: add airgapped install procedure
    ([pr#49145](https://github.com/ceph/ceph/pull/49145), Zac Dover)
-   doc/cephadm: add info about \--no-overwrite to note about
    tuned-profiles ([pr#47954](https://github.com/ceph/ceph/pull/47954),
    Adam King)
-   doc/cephadm: add prompts to host-management.rst
    ([pr#48589](https://github.com/ceph/ceph/pull/48589), Zac Dover)
-   doc/cephadm: alphabetize external tools list
    ([pr#48725](https://github.com/ceph/ceph/pull/48725), Zac Dover)
-   doc/cephadm: arrange \"listing hosts\" section
    ([pr#48723](https://github.com/ceph/ceph/pull/48723), Zac Dover)
-   doc/cephadm: clean colons in host-management.rst
    ([pr#48603](https://github.com/ceph/ceph/pull/48603), Zac Dover)
-   doc/cephadm: correct version staggered upgrade got in pacific
    ([pr#48055](https://github.com/ceph/ceph/pull/48055), Adam King)
-   doc/cephadm: document recommended syntax for mounting files with ECA
    ([pr#48068](https://github.com/ceph/ceph/pull/48068), Adam King)
-   doc/cephadm: fix grammar in compatibility.rst
    ([pr#48714](https://github.com/ceph/ceph/pull/48714), Zac Dover)
-   doc/cephadm: fix tuned-profile add/rm-setting syntax example
    ([pr#48094](https://github.com/ceph/ceph/pull/48094), Adam King)
-   doc/cephadm: format airgap install procedure
    ([pr#49148](https://github.com/ceph/ceph/pull/49148), Zac Dover)
-   doc/cephadm: grammar / syntax in install.rst
    ([pr#49948](https://github.com/ceph/ceph/pull/49948), Piotr
    Parczewski)
-   doc/cephadm: improve airgapping procedure grammar
    ([pr#49157](https://github.com/ceph/ceph/pull/49157), Zac Dover)
-   doc/cephadm: improve front matter
    ([pr#48606](https://github.com/ceph/ceph/pull/48606), Zac Dover)
-   doc/cephadm: improve grammar in \"listing hosts\"
    ([pr#49164](https://github.com/ceph/ceph/pull/49164), Zac Dover)
-   doc/cephadm: improve lone sentence
    ([pr#48737](https://github.com/ceph/ceph/pull/48737), Zac Dover)
-   doc/cephadm: Redd up compatibility.rst
    ([pr#50367](https://github.com/ceph/ceph/pull/50367), Anthony
    D\'Atri)
-   doc/cephadm: refine \"os tuning\" in h. management
    ([pr#48573](https://github.com/ceph/ceph/pull/48573), Zac Dover)
-   doc/cephadm: refine \"Removing Hosts\"
    ([pr#49706](https://github.com/ceph/ceph/pull/49706), Zac Dover)
-   doc/cephadm: s/osd/OSD/ where appropriate
    ([pr#49717](https://github.com/ceph/ceph/pull/49717), Zac Dover)
-   doc/cephadm: s/ssh/SSH/ in doc/cephadm (complete)
    ([pr#48611](https://github.com/ceph/ceph/pull/48611), Zac Dover)
-   doc/cephadm: s/ssh/SSH/ in troubleshooting.rst
    ([pr#48601](https://github.com/ceph/ceph/pull/48601), Zac Dover)
-   doc/cephadm: update cephadm compatability and stability page
    ([pr#50336](https://github.com/ceph/ceph/pull/50336), Adam King)
-   doc/cephadm: update install.rst
    ([pr#48594](https://github.com/ceph/ceph/pull/48594), Zac Dover)
-   doc/cephfs - s/yet to here/yet to hear/ posix.rst
    ([pr#49448](https://github.com/ceph/ceph/pull/49448), Zac Dover)
-   doc/cephfs: add note about CephFS extended attributes and getfattr
    ([pr#50068](https://github.com/ceph/ceph/pull/50068), Zac Dover)
-   doc/cephfs: describe conf opt \"client quota df\" in quota doc
    ([pr#50252](https://github.com/ceph/ceph/pull/50252), Rishabh Dave)
-   doc/cephfs: fix \"e.g.\" in posix.rst
    ([pr#49450](https://github.com/ceph/ceph/pull/49450), Zac Dover)
-   doc/cephfs: s/all of there are/all of these are/
    ([pr#49446](https://github.com/ceph/ceph/pull/49446), Zac Dover)
-   doc/css: add \"span\" padding to custom.css
    ([pr#49693](https://github.com/ceph/ceph/pull/49693), Zac Dover)
-   doc/css: add scroll-margin-top to dt elements
    ([pr#49639](https://github.com/ceph/ceph/pull/49639), Zac Dover)
-   doc/css: Add scroll-margin-top to h2 html element
    ([pr#49661](https://github.com/ceph/ceph/pull/49661), Zac Dover)
-   doc/css: add top-bar padding for h3 html element
    ([pr#49701](https://github.com/ceph/ceph/pull/49701), Zac Dover)
-   doc/dev/cephadm: fix host maintenance enter/exit syntax
    ([pr#49646](https://github.com/ceph/ceph/pull/49646), Ranjini
    Mandyam Narasiodeyar)
-   doc/dev/developer_guide/testing_integration_tests: Add Upgrade
    Testin... ([pr#49909](https://github.com/ceph/ceph/pull/49909),
    Matan Breizman)
-   doc/dev/developer_guide/tests-unit-tests: Add unit test caveat
    ([pr#49012](https://github.com/ceph/ceph/pull/49012), Matan
    Breizman)
-   doc/dev: add explanation of how to use deduplication
    ([pr#48567](https://github.com/ceph/ceph/pull/48567), Myoungwon Oh)
-   doc/dev: add full stop to sentence in basic-wo
    ([pr#50400](https://github.com/ceph/ceph/pull/50400), Zac Dover)
-   doc/dev: add git branch management commands
    ([pr#49738](https://github.com/ceph/ceph/pull/49738), Zac Dover)
-   doc/dev: add Slack to Dev Guide essentials
    ([pr#49874](https://github.com/ceph/ceph/pull/49874), Zac Dover)
-   doc/dev: add submodule-update link to dev guide
    ([pr#48479](https://github.com/ceph/ceph/pull/48479), Zac Dover)
-   doc/dev: alphabetize EC glossary
    ([pr#48685](https://github.com/ceph/ceph/pull/48685), Zac Dover)
-   doc/dev: fix graphviz diagram
    ([pr#48922](https://github.com/ceph/ceph/pull/48922), Zac Dover)
-   doc/dev: improve Basic Workflow wording
    ([pr#49077](https://github.com/ceph/ceph/pull/49077), Zac Dover)
-   doc/dev: improve EC glossary
    ([pr#48675](https://github.com/ceph/ceph/pull/48675), Zac Dover)
-   doc/dev: improve lone sentence
    ([pr#48740](https://github.com/ceph/ceph/pull/48740), Zac Dover)
-   doc/dev: improve presentation of note (git remote)
    ([pr#48237](https://github.com/ceph/ceph/pull/48237), Zac Dover)
-   doc/dev: link to Dot User\'s Manual
    ([pr#48925](https://github.com/ceph/ceph/pull/48925), Zac Dover)
-   doc/dev: refine erasure_coding.rst
    ([pr#48700](https://github.com/ceph/ceph/pull/48700), Zac Dover)
-   doc/dev: remove deduplication.rst from quincy
    ([pr#48570](https://github.com/ceph/ceph/pull/48570), Zac Dover)
-   doc/dev: use underscores in config vars
    ([pr#49892](https://github.com/ceph/ceph/pull/49892), Ville Ojamo)
-   doc/glosary.rst: add \"Ceph Block Device\" term
    ([pr#48746](https://github.com/ceph/ceph/pull/48746), Zac Dover)
-   doc/glossary - add \"secrets\"
    ([pr#49397](https://github.com/ceph/ceph/pull/49397), Zac Dover)
-   doc/glossary.rst: add \"Ceph Dashboard\" term
    ([pr#48748](https://github.com/ceph/ceph/pull/48748), Zac Dover)
-   doc/glossary.rst: alphabetize glossary terms
    ([pr#48338](https://github.com/ceph/ceph/pull/48338), Zac Dover)
-   doc/glossary.rst: define \"Ceph Manager\"
    ([pr#48764](https://github.com/ceph/ceph/pull/48764), Zac Dover)
-   doc/glossary.rst: remove duplicates
    ([pr#48357](https://github.com/ceph/ceph/pull/48357), Zac Dover)
-   doc/glossary.rst: remove old front matter
    ([pr#48754](https://github.com/ceph/ceph/pull/48754), Zac Dover)
-   doc/glossary: add \"application\" to the glossary
    ([pr#50258](https://github.com/ceph/ceph/pull/50258), Zac Dover)
-   doc/glossary: add \"BlueStore\"
    ([pr#48777](https://github.com/ceph/ceph/pull/48777), Zac Dover)
-   doc/glossary: add \"Bucket\"
    ([pr#50224](https://github.com/ceph/ceph/pull/50224), Zac Dover)
-   doc/glossary: add \"ceph monitor\" entry
    ([pr#48447](https://github.com/ceph/ceph/pull/48447), Zac Dover)
-   doc/glossary: add \"Ceph Object Store\"
    ([pr#49030](https://github.com/ceph/ceph/pull/49030), Zac Dover)
-   doc/glossary: add \"client\" to glossary
    ([pr#50262](https://github.com/ceph/ceph/pull/50262), Zac Dover)
-   doc/glossary: add \"Dashboard Module\"
    ([pr#49137](https://github.com/ceph/ceph/pull/49137), Zac Dover)
-   doc/glossary: add \"FQDN\" entry
    ([pr#49424](https://github.com/ceph/ceph/pull/49424), Zac Dover)
-   doc/glossary: add \"mds\" term
    ([pr#48871](https://github.com/ceph/ceph/pull/48871), Zac Dover)
-   doc/glossary: add \"Period\" to glossary
    ([pr#50155](https://github.com/ceph/ceph/pull/50155), Zac Dover)
-   doc/glossary: add \"RADOS Cluster\"
    ([pr#49134](https://github.com/ceph/ceph/pull/49134), Zac Dover)
-   doc/glossary: add \"RADOS\" definition
    ([pr#48950](https://github.com/ceph/ceph/pull/48950), Zac Dover)
-   doc/glossary: add \"realm\" to glossary
    ([pr#50134](https://github.com/ceph/ceph/pull/50134), Zac Dover)
-   doc/glossary: Add \"zone\" to glossary.rst
    ([pr#50271](https://github.com/ceph/ceph/pull/50271), Zac Dover)
-   doc/glossary: add AWS/OpenStack bucket info
    ([pr#50247](https://github.com/ceph/ceph/pull/50247), Zac Dover)
-   doc/glossary: add DAS
    ([pr#49254](https://github.com/ceph/ceph/pull/49254), Zac Dover)
-   doc/glossary: add matter to \"RBD\"
    ([pr#49265](https://github.com/ceph/ceph/pull/49265), Zac Dover)
-   doc/glossary: add oxford comma to \"Cluster Map\"
    ([pr#48992](https://github.com/ceph/ceph/pull/48992), Zac Dover)
-   doc/glossary: beef up \"Ceph Block Storage\"
    ([pr#48964](https://github.com/ceph/ceph/pull/48964), Zac Dover)
-   doc/glossary: capitalize \"DAS\" correctly
    ([pr#49603](https://github.com/ceph/ceph/pull/49603), Zac Dover)
-   doc/glossary: clean OSD id-related entries
    ([pr#49589](https://github.com/ceph/ceph/pull/49589), Zac Dover)
-   doc/glossary: Clean up \"Ceph Object Storage\"
    ([pr#49667](https://github.com/ceph/ceph/pull/49667), Zac Dover)
-   doc/glossary: collate \"releases\" entries
    ([pr#49600](https://github.com/ceph/ceph/pull/49600), Zac Dover)
-   doc/glossary: Define \"Ceph Node\"
    ([pr#48994](https://github.com/ceph/ceph/pull/48994), Zac Dover)
-   doc/glossary: define \"Ceph Object Gateway\"
    ([pr#48901](https://github.com/ceph/ceph/pull/48901), Zac Dover)
-   doc/glossary: define \"Ceph OSD\"
    ([pr#48770](https://github.com/ceph/ceph/pull/48770), Zac Dover)
-   doc/glossary: define \"Ceph Storage Cluster\"
    ([pr#49002](https://github.com/ceph/ceph/pull/49002), Zac Dover)
-   doc/glossary: define \"OSD\"
    ([pr#48759](https://github.com/ceph/ceph/pull/48759), Zac Dover)
-   doc/glossary: define \"RGW\"
    ([pr#48960](https://github.com/ceph/ceph/pull/48960), Zac Dover)
-   doc/glossary: disambiguate \"OSD\"
    ([pr#48790](https://github.com/ceph/ceph/pull/48790), Zac Dover)
-   doc/glossary: disambiguate clauses
    ([pr#49574](https://github.com/ceph/ceph/pull/49574), Zac Dover)
-   doc/glossary: fix \"Ceph Client\"
    ([pr#49032](https://github.com/ceph/ceph/pull/49032), Zac Dover)
-   doc/glossary: improve \"Ceph Manager Dashboard\"
    ([pr#48824](https://github.com/ceph/ceph/pull/48824), Zac Dover)
-   doc/glossary: improve \"Ceph Manager\" term
    ([pr#48811](https://github.com/ceph/ceph/pull/48811), Zac Dover)
-   doc/glossary: improve \"Ceph Point Release\" entry
    ([pr#48890](https://github.com/ceph/ceph/pull/48890), Zac Dover)
-   doc/glossary: improve \"ceph\" term
    ([pr#48820](https://github.com/ceph/ceph/pull/48820), Zac Dover)
-   doc/glossary: improve wording
    ([pr#48751](https://github.com/ceph/ceph/pull/48751), Zac Dover)
-   doc/glossary: link to \"Ceph Manager\"
    ([pr#49063](https://github.com/ceph/ceph/pull/49063), Zac Dover)
-   doc/glossary: link to OSD material
    ([pr#48779](https://github.com/ceph/ceph/pull/48779), zdover23, Zac
    Dover)
-   doc/glossary: redirect entries to \"Ceph OSD\"
    ([pr#48833](https://github.com/ceph/ceph/pull/48833), Zac Dover)
-   doc/glossary: remove \"Ceph System\"
    ([pr#49072](https://github.com/ceph/ceph/pull/49072), Zac Dover)
-   doc/glossary: remove \"Ceph Test Framework\"
    ([pr#48841](https://github.com/ceph/ceph/pull/48841), Zac Dover)
-   doc/glossary: rewrite \"Ceph File System\"
    ([pr#48917](https://github.com/ceph/ceph/pull/48917), Zac Dover)
-   doc/glossary: s/an/each/ where it\'s needed
    ([pr#49595](https://github.com/ceph/ceph/pull/49595), Zac Dover)
-   doc/glossary: s/Ceph System/Ceph Cluster/
    ([pr#49080](https://github.com/ceph/ceph/pull/49080), Zac Dover)
-   doc/glossary: s/comprising/consisting of/
    ([pr#49018](https://github.com/ceph/ceph/pull/49018), Zac Dover)
-   doc/glossary: update \"Cluster Map\"
    ([pr#48797](https://github.com/ceph/ceph/pull/48797), Zac Dover)
-   doc/glossary: update \"pool/pools\"
    ([pr#48857](https://github.com/ceph/ceph/pull/48857), Zac Dover)
-   doc/index: remove \"uniquely\" from landing page
    ([pr#50477](https://github.com/ceph/ceph/pull/50477), Zac Dover)
-   doc/install: clone-source.rst s/master/main
    ([pr#48380](https://github.com/ceph/ceph/pull/48380), Zac Dover)
-   doc/install: improve updating submodules procedure
    ([pr#48464](https://github.com/ceph/ceph/pull/48464), Zac Dover)
-   doc/install: link to \"cephadm installing ceph\"
    ([pr#49781](https://github.com/ceph/ceph/pull/49781), Zac Dover)
-   doc/install: refine index.rst
    ([pr#50435](https://github.com/ceph/ceph/pull/50435), Zac Dover)
-   doc/install: update \"Official Releases\" sources
    ([pr#49038](https://github.com/ceph/ceph/pull/49038), Zac Dover)
-   doc/install: update clone-source.rst
    ([pr#49377](https://github.com/ceph/ceph/pull/49377), Zac Dover)
-   doc/install: update index.rst
    ([pr#50432](https://github.com/ceph/ceph/pull/50432), Zac Dover)
-   doc/man/ceph-rbdnamer: remove obsolete udev rule
    ([pr#49697](https://github.com/ceph/ceph/pull/49697), Ilya Dryomov)
-   doc/man: define \--num-rep, \--min-rep and \--max-rep
    ([pr#49659](https://github.com/ceph/ceph/pull/49659), Zac Dover)
-   doc/man: disambiguate \"user\" in a command
    ([pr#48954](https://github.com/ceph/ceph/pull/48954), Zac Dover)
-   doc/mgr: name data source in \"Man Install & Config\"
    ([pr#48370](https://github.com/ceph/ceph/pull/48370), Zac Dover)
-   doc/monitoring: add min vers of apps in mon stack
    ([pr#48063](https://github.com/ceph/ceph/pull/48063), Zac Dover,
    Himadri Maheshwari)
-   doc/osd: Fixes the introduction for writeback mode of cache tier
    ([pr#48882](https://github.com/ceph/ceph/pull/48882), Mingyuan
    Liang)
-   doc/rados/operations: Fix double prompt
    ([pr#49898](https://github.com/ceph/ceph/pull/49898), Ville Ojamo)
-   doc/rados/operations: Fix indentation
    ([pr#49895](https://github.com/ceph/ceph/pull/49895), Ville Ojamo)
-   doc/rados/operations: Improve wording, capitalization, formatting
    ([pr#50453](https://github.com/ceph/ceph/pull/50453), Anthony
    D\'Atri)
-   doc/rados: add prompts to add-or-remove-osds
    ([pr#49070](https://github.com/ceph/ceph/pull/49070), Zac Dover)
-   doc/rados: add prompts to add-or-rm-prompts.rst
    ([pr#48985](https://github.com/ceph/ceph/pull/48985), Zac Dover)
-   doc/rados: add prompts to add-or-rm-prompts.rst
    ([pr#48979](https://github.com/ceph/ceph/pull/48979), Zac Dover)
-   doc/rados: add prompts to auth-config-ref.rst
    ([pr#49515](https://github.com/ceph/ceph/pull/49515), Zac Dover)
-   doc/rados: add prompts to balancer.rst
    ([pr#49111](https://github.com/ceph/ceph/pull/49111), Zac Dover)
-   doc/rados: add prompts to bluestore-config-ref.rst
    ([pr#49535](https://github.com/ceph/ceph/pull/49535), Zac Dover)
-   doc/rados: add prompts to bluestore-migration.rst
    ([pr#49122](https://github.com/ceph/ceph/pull/49122), Zac Dover)
-   doc/rados: add prompts to cache-tiering.rst
    ([pr#49124](https://github.com/ceph/ceph/pull/49124), Zac Dover)
-   doc/rados: add prompts to ceph-conf.rst
    ([pr#49492](https://github.com/ceph/ceph/pull/49492), Zac Dover)
-   doc/rados: add prompts to change-mon-elections.rst
    ([pr#49129](https://github.com/ceph/ceph/pull/49129), Zac Dover)
-   doc/rados: add prompts to control.rst
    ([pr#49126](https://github.com/ceph/ceph/pull/49126), Zac Dover)
-   doc/rados: add prompts to crush-map.rst
    ([pr#49183](https://github.com/ceph/ceph/pull/49183), Zac Dover)
-   doc/rados: add prompts to devices.rst
    ([pr#49187](https://github.com/ceph/ceph/pull/49187), Zac Dover)
-   doc/rados: add prompts to erasure-code-clay.rst
    ([pr#49205](https://github.com/ceph/ceph/pull/49205), Zac Dover)
-   doc/rados: add prompts to erasure-code-isa
    ([pr#49207](https://github.com/ceph/ceph/pull/49207), Zac Dover)
-   doc/rados: add prompts to erasure-code-jerasure.rst
    ([pr#49209](https://github.com/ceph/ceph/pull/49209), Zac Dover)
-   doc/rados: add prompts to erasure-code-lrc.rst
    ([pr#49218](https://github.com/ceph/ceph/pull/49218), Zac Dover)
-   doc/rados: add prompts to erasure-code-shec.rst
    ([pr#49220](https://github.com/ceph/ceph/pull/49220), Zac Dover)
-   doc/rados: add prompts to health-checks (1 of 5)
    ([pr#49222](https://github.com/ceph/ceph/pull/49222), Zac Dover)
-   doc/rados: add prompts to health-checks (2 of 5)
    ([pr#49224](https://github.com/ceph/ceph/pull/49224), Zac Dover)
-   doc/rados: add prompts to health-checks (3 of 5)
    ([pr#49226](https://github.com/ceph/ceph/pull/49226), Zac Dover)
-   doc/rados: add prompts to health-checks (4 of 5)
    ([pr#49228](https://github.com/ceph/ceph/pull/49228), Zac Dover)
-   doc/rados: add prompts to health-checks (5 of 5)
    ([pr#49230](https://github.com/ceph/ceph/pull/49230), Zac Dover)
-   doc/rados: add prompts to librados-intro.rst
    ([pr#49551](https://github.com/ceph/ceph/pull/49551), Zac Dover)
-   doc/rados: add prompts to monitoring-osd-pg.rst
    ([pr#49239](https://github.com/ceph/ceph/pull/49239), Zac Dover)
-   doc/rados: add prompts to monitoring.rst
    ([pr#49244](https://github.com/ceph/ceph/pull/49244), Zac Dover)
-   doc/rados: add prompts to msgr2.rst
    ([pr#49511](https://github.com/ceph/ceph/pull/49511), Zac Dover)
-   doc/rados: add prompts to pg-repair.rst
    ([pr#49246](https://github.com/ceph/ceph/pull/49246), Zac Dover)
-   doc/rados: add prompts to placement-groups.rst
    ([pr#49273](https://github.com/ceph/ceph/pull/49273), Zac Dover)
-   doc/rados: add prompts to placement-groups.rst
    ([pr#49271](https://github.com/ceph/ceph/pull/49271), Zac Dover)
-   doc/rados: add prompts to placement-groups.rst (3)
    ([pr#49275](https://github.com/ceph/ceph/pull/49275), Zac Dover)
-   doc/rados: add prompts to pools.rst
    ([pr#48061](https://github.com/ceph/ceph/pull/48061), Zac Dover)
-   doc/rados: add prompts to stretch-mode.rst
    ([pr#49369](https://github.com/ceph/ceph/pull/49369), Zac Dover)
-   doc/rados: add prompts to upmap.rst
    ([pr#49371](https://github.com/ceph/ceph/pull/49371), Zac Dover)
-   doc/rados: add prompts to user-management.rst
    ([pr#49384](https://github.com/ceph/ceph/pull/49384), Zac Dover)
-   doc/rados: clarify default EC pool from simplest
    ([pr#49468](https://github.com/ceph/ceph/pull/49468), Zac Dover)
-   doc/rados: cleanup \"erasure code profiles\"
    ([pr#49050](https://github.com/ceph/ceph/pull/49050), Zac Dover)
-   doc/rados: correct typo in python.rst
    ([pr#49559](https://github.com/ceph/ceph/pull/49559), Zac Dover)
-   doc/rados: fix grammar in configuration/index.rst
    ([pr#48884](https://github.com/ceph/ceph/pull/48884), Zac Dover)
-   doc/rados: fix prompts in erasure-code.rst
    ([pr#48334](https://github.com/ceph/ceph/pull/48334), Zac Dover)
-   doc/rados: improve pools.rst
    ([pr#48867](https://github.com/ceph/ceph/pull/48867), Zac Dover)
-   doc/rados: link to cephadm replacing osd section
    ([pr#49680](https://github.com/ceph/ceph/pull/49680), Zac Dover)
-   doc/rados: move colon
    ([pr#49704](https://github.com/ceph/ceph/pull/49704), Zac Dover)
-   doc/rados: refine ceph-conf.rst
    ([pr#49832](https://github.com/ceph/ceph/pull/49832), Zac Dover)
-   doc/rados: refine English in crush-map-edits.rst
    ([pr#48365](https://github.com/ceph/ceph/pull/48365), Zac Dover)
-   doc/rados: refine pool-pg-config-ref.rst
    ([pr#49821](https://github.com/ceph/ceph/pull/49821), Zac Dover)
-   doc/rados: remove prompt from php.ini line
    ([pr#49561](https://github.com/ceph/ceph/pull/49561), Zac Dover)
-   doc/rados: reword part of cache-tiering.rst
    ([pr#48887](https://github.com/ceph/ceph/pull/48887), Zac Dover)
-   doc/rados: rewrite EC intro
    ([pr#48323](https://github.com/ceph/ceph/pull/48323), Zac Dover)
-   doc/rados: s/backend/back end/
    ([pr#48781](https://github.com/ceph/ceph/pull/48781), Zac Dover)
-   doc/rados: update \"Pools\" material
    ([pr#48855](https://github.com/ceph/ceph/pull/48855), Zac Dover)
-   doc/rados: update OSD_BACKFILLFULL description
    ([pr#50218](https://github.com/ceph/ceph/pull/50218), Ponnuvel
    Palaniyappan)
-   doc/rados: update prompts in crush-map-edits.rst
    ([pr#48363](https://github.com/ceph/ceph/pull/48363), Zac Dover)
-   doc/rados: update prompts in network-config-ref
    ([pr#48159](https://github.com/ceph/ceph/pull/48159), Zac Dover)
-   doc/radosgw/STS: sts_key and user capabilities
    ([pr#47324](https://github.com/ceph/ceph/pull/47324), Tobias
    Bossert)
-   doc/radosgw: add prompts to multisite.rst
    ([pr#48659](https://github.com/ceph/ceph/pull/48659), Zac Dover)
-   doc/radosgw: add push_endpoint for rabbitmq
    ([pr#48487](https://github.com/ceph/ceph/pull/48487), Zac Dover)
-   doc/radosgw: format admonitions
    ([pr#50356](https://github.com/ceph/ceph/pull/50356), Zac Dover)
-   doc/radosgw: improve \"Ceph Object Gateway\" text
    ([pr#48863](https://github.com/ceph/ceph/pull/48863), Zac Dover)
-   doc/radosgw: improve grammar - notifications.rst
    ([pr#48494](https://github.com/ceph/ceph/pull/48494), Zac Dover)
-   doc/radosgw: multisite - edit \"functional changes\"
    ([pr#50277](https://github.com/ceph/ceph/pull/50277), Zac Dover)
-   doc/radosgw: refine \"bucket notifications\"
    ([pr#48560](https://github.com/ceph/ceph/pull/48560), Zac Dover)
-   doc/radosgw: refine \"Maintenance\" in multisite.rst
    ([pr#50025](https://github.com/ceph/ceph/pull/50025), Zac Dover)
-   doc/radosgw: refine \"notification reliability\"
    ([pr#48529](https://github.com/ceph/ceph/pull/48529), Zac Dover)
-   doc/radosgw: refine \"notifications\" and \"events\"
    ([pr#48579](https://github.com/ceph/ceph/pull/48579), Zac Dover)
-   doc/radosgw: refine notifications.rst - top part
    ([pr#48502](https://github.com/ceph/ceph/pull/48502), Zac Dover)
-   doc/radosgw: s/execute/run/ in multisite.rst
    ([pr#50173](https://github.com/ceph/ceph/pull/50173), Zac Dover)
-   doc/radosgw: s/zone group/zonegroup/g et alia
    ([pr#50297](https://github.com/ceph/ceph/pull/50297), Zac Dover)
-   doc/radosgw: update notifications.rst - grammar
    ([pr#48499](https://github.com/ceph/ceph/pull/48499), Zac Dover)
-   doc/radosw: improve radosgw text
    ([pr#48966](https://github.com/ceph/ceph/pull/48966), Zac Dover)
-   doc/radowsgw: add prompts to notifications.rst
    ([pr#48535](https://github.com/ceph/ceph/pull/48535), Zac Dover)
-   doc/rbd/rbd-exclusive-locks: warn about automatic lock transitions
    ([pr#49806](https://github.com/ceph/ceph/pull/49806), Ilya Dryomov)
-   doc/rbd: format iscsi-initiator-linux.rbd better
    ([pr#49749](https://github.com/ceph/ceph/pull/49749), Zac Dover)
-   doc/rbd: improve grammar in \"immutable object\...\"
    ([pr#48969](https://github.com/ceph/ceph/pull/48969), Zac Dover)
-   doc/rbd: refine \"Create a Block Device Pool\"
    ([pr#49307](https://github.com/ceph/ceph/pull/49307), Zac Dover)
-   doc/rbd: refine \"Create a Block Device User\"
    ([pr#49318](https://github.com/ceph/ceph/pull/49318), Zac Dover)
-   doc/rbd: refine \"Create a Block Device User\"
    ([pr#49300](https://github.com/ceph/ceph/pull/49300), Zac Dover)
-   doc/rbd: refine \"Creating a Block Device Image\"
    ([pr#49346](https://github.com/ceph/ceph/pull/49346), Zac Dover)
-   doc/rbd: refine \"Listing Block Device Images\"
    ([pr#49348](https://github.com/ceph/ceph/pull/49348), Zac Dover)
-   doc/rbd: refine \"Removing a Block Device Image\"
    ([pr#49356](https://github.com/ceph/ceph/pull/49356), Zac Dover)
-   doc/rbd: refine \"Resizing a Block Device Image\"
    ([pr#49352](https://github.com/ceph/ceph/pull/49352), Zac Dover)
-   doc/rbd: refine \"Restoring a Block Device Image\"
    ([pr#49354](https://github.com/ceph/ceph/pull/49354), Zac Dover)
-   doc/rbd: refine \"Retrieving Image Information\"
    ([pr#49350](https://github.com/ceph/ceph/pull/49350), Zac Dover)
-   doc/rbd: refine rbd-exclusive-locks.rst
    ([pr#49597](https://github.com/ceph/ceph/pull/49597), Zac Dover)
-   doc/rbd: refine rbd-snapshot.rst
    ([pr#49484](https://github.com/ceph/ceph/pull/49484), Zac Dover)
-   doc/rbd: remove typo and ill-formed command
    ([pr#49365](https://github.com/ceph/ceph/pull/49365), Zac Dover)
-   doc/rbd: s/wuold/would/ in rados-rbd-cmds.rst
    ([pr#49591](https://github.com/ceph/ceph/pull/49591), Zac Dover)
-   doc/rbd: update iSCSI gateway info
    ([pr#49068](https://github.com/ceph/ceph/pull/49068), Zac Dover)
-   doc/releases: improve grammar in pacific.rst
    ([pr#48424](https://github.com/ceph/ceph/pull/48424), Zac Dover)
-   doc/rgw - fix grammar in table in s3.rst
    ([pr#50388](https://github.com/ceph/ceph/pull/50388), Zac Dover)
-   doc/rgw: \"Migrating Single Site to Multi-Site\"
    ([pr#50093](https://github.com/ceph/ceph/pull/50093), Zac Dover)
-   doc/rgw: caption a diagram
    ([pr#50293](https://github.com/ceph/ceph/pull/50293), Zac Dover)
-   doc/rgw: clarify multisite.rst top matter
    ([pr#50204](https://github.com/ceph/ceph/pull/50204), Zac Dover)
-   doc/rgw: clean zone-sync.svg
    ([pr#50362](https://github.com/ceph/ceph/pull/50362), Zac Dover)
-   doc/rgw: fix caption
    ([pr#50395](https://github.com/ceph/ceph/pull/50395), Zac Dover)
-   doc/rgw: improve diagram caption
    ([pr#50331](https://github.com/ceph/ceph/pull/50331), Zac Dover)
-   doc/rgw: multisite ref. top matter cleanup
    ([pr#50189](https://github.com/ceph/ceph/pull/50189), Zac Dover)
-   doc/rgw: refine \"Configuring Secondary Zones\"
    ([pr#50074](https://github.com/ceph/ceph/pull/50074), Zac Dover)
-   doc/rgw: refine \"Failover and Disaster Recovery\"
    ([pr#50078](https://github.com/ceph/ceph/pull/50078), Zac Dover)
-   doc/rgw: refine \"Multi-site Config Ref\" (1 of x)
    ([pr#50117](https://github.com/ceph/ceph/pull/50117), Zac Dover)
-   doc/rgw: refine \"Realms\" section
    ([pr#50139](https://github.com/ceph/ceph/pull/50139), Zac Dover)
-   doc/rgw: refine \"Zones\" in multisite.rst
    ([pr#49982](https://github.com/ceph/ceph/pull/49982), Zac Dover)
-   doc/rgw: refine 1-50 of multisite.rst
    ([pr#49995](https://github.com/ceph/ceph/pull/49995), Zac Dover)
-   doc/rgw: refine keycloak.rst
    ([pr#50378](https://github.com/ceph/ceph/pull/50378), Zac Dover)
-   doc/rgw: refine multisite to \"config 2ndary zones\"
    ([pr#50031](https://github.com/ceph/ceph/pull/50031), Zac Dover)
-   doc/rgw: refine \~50-\~140 of multisite.rst
    ([pr#50008](https://github.com/ceph/ceph/pull/50008), Zac Dover)
-   doc/rgw: remove \"tertiary\", link to procedure
    ([pr#50287](https://github.com/ceph/ceph/pull/50287), Zac Dover)
-   doc/rgw: s/\[Zz\]one \[Gg\]roup/zonegroup/g
    ([pr#50136](https://github.com/ceph/ceph/pull/50136), Zac Dover)
-   doc/rgw: session-tags.rst - fix link to keycloak
    ([pr#50187](https://github.com/ceph/ceph/pull/50187), Zac Dover)
-   doc/security: improve grammar in CVE-2022-0670.rst
    ([pr#48430](https://github.com/ceph/ceph/pull/48430), Zac Dover)
-   doc/start: add Anthony D\'Atri\'s suggestions
    ([pr#49615](https://github.com/ceph/ceph/pull/49615), Zac Dover)
-   doc/start: add link-related metadocumentation
    ([pr#49608](https://github.com/ceph/ceph/pull/49608), Zac Dover)
-   doc/start: add RST escape character rules for bold
    ([pr#49751](https://github.com/ceph/ceph/pull/49751), Zac Dover)
-   doc/start: improve documenting-ceph.rst
    ([pr#49565](https://github.com/ceph/ceph/pull/49565), Zac Dover)
-   doc/start: refine \"Quirks of RST\"
    ([pr#49610](https://github.com/ceph/ceph/pull/49610), Zac Dover)
-   doc/start: update documenting-ceph.rst
    ([pr#49570](https://github.com/ceph/ceph/pull/49570), Zac Dover)
-   doc/various: update link to CRUSH pdf
    ([pr#48402](https://github.com/ceph/ceph/pull/48402), Zac Dover)
-   doc: add releases links to toc
    ([pr#48945](https://github.com/ceph/ceph/pull/48945), Patrick
    Donnelly)
-   doc: add the damage types that scrub can repair
    ([pr#49932](https://github.com/ceph/ceph/pull/49932), Neeraj Pratap
    Singh)
-   doc: Change \'ReST\' to \'REST\' in doc/radosgw/layout.rst
    ([pr#48653](https://github.com/ceph/ceph/pull/48653), wangyingbin)
-   doc: document debugging for libcephsqlite
    ([pr#50035](https://github.com/ceph/ceph/pull/50035), Patrick
    Donnelly)
-   doc: document the relevance of mds_namespace mount option
    ([pr#49689](https://github.com/ceph/ceph/pull/49689), Jos Collin)
-   doc: fix a couple grammatical things
    ([pr#49621](https://github.com/ceph/ceph/pull/49621), Brad
    Fitzpatrick)
-   doc: fix a typo
    ([pr#49683](https://github.com/ceph/ceph/pull/49683), Brad
    Fitzpatrick)
-   doc: Fix disaster recovery doc
    ([pr#48343](https://github.com/ceph/ceph/pull/48343), Kotresh HR)
-   doc: Install graphviz
    ([pr#48904](https://github.com/ceph/ceph/pull/48904), David
    Galloway)
-   doc: point to main branch for release info
    ([pr#48800](https://github.com/ceph/ceph/pull/48800), Patrick
    Donnelly)
-   doc: preen cephadm/troubleshooting.rst and radosgw/placement.rst
    ([pr#50228](https://github.com/ceph/ceph/pull/50228), Anthony
    D\'Atri)
-   docs: correct add system user to the master zone command
    ([pr#48655](https://github.com/ceph/ceph/pull/48655), Salar
    Nosrati-Ershad)
-   drive_group: fix limit filter in drive_selection.selector
    ([pr#50370](https://github.com/ceph/ceph/pull/50370), Guillaume
    Abrioux)
-   exporter: avoid stoi for empty pid_str
    ([pr#48206](https://github.com/ceph/ceph/pull/48206), Avan Thakkar)
-   exporter: don\'t skip loop if pid path is empty
    ([pr#48225](https://github.com/ceph/ceph/pull/48225), Avan Thakkar)
-   Fix chown to unlink
    ([pr#49794](https://github.com/ceph/ceph/pull/49794), Daniel
    Gryniewicz)
-   fsmap: switch to using iterator based loop
    ([pr#48268](https://github.com/ceph/ceph/pull/48268), Aliaksei
    Makarau)
-   librbd/cache/pwl: fix clean vs bytes_dirty cache state inconsistency
    ([pr#49055](https://github.com/ceph/ceph/pull/49055), Yin Congmin)
-   librbd: avoid EUCLEAN error after \"rbd rm\" is interrupted
    ([pr#50130](https://github.com/ceph/ceph/pull/50130), weixinwei)
-   librbd: call apply_changes() after setting librados_thread_count
    ([pr#50292](https://github.com/ceph/ceph/pull/50292), Ilya Dryomov)
-   librbd: compare-and-write fixes and vector C API
    ([pr#48474](https://github.com/ceph/ceph/pull/48474), Ilya Dryomov,
    Jonas Pfefferle)
-   librbd: Fix local rbd mirror journals growing forever
    ([pr#50159](https://github.com/ceph/ceph/pull/50159), Ilya Dryomov,
    Josef Johansson)
-   make-dist: don\'t set Release tag in ceph.spec for SUSE distros
    ([pr#48613](https://github.com/ceph/ceph/pull/48613), Tim Serong,
    Nathan Cutler)
-   mds/client: fail the request if the peer MDS doesn\'t support
    getvxattr op ([pr#47890](https://github.com/ceph/ceph/pull/47890),
    Zack Cerza, Xiubo Li)
-   mds/PurgeQueue: don\'t consider filer_max_purge_ops when
    \_calculate_ops
    ([pr#49655](https://github.com/ceph/ceph/pull/49655), haoyixing)
-   mds/Server: Do not abort MDS on unknown messages
    ([pr#48252](https://github.com/ceph/ceph/pull/48252), Dhairya
    Parmar, Dhairy Parmar)
-   mds: account for snapshot items when deciding to split or merge a
    directory ([issue#55215](http://tracker.ceph.com/issues/55215),
    [pr#49673](https://github.com/ceph/ceph/pull/49673), Venky Shankar)
-   mds: avoid \~mdsdir\'s scrubbing and reporting damage health status
    ([pr#49473](https://github.com/ceph/ceph/pull/49473), Neeraj Pratap
    Singh)
-   mds: damage table only stores one dentry per dirfrag
    ([pr#48261](https://github.com/ceph/ceph/pull/48261), Patrick
    Donnelly)
-   mds: do not acquire xlock in xlockdone state
    ([pr#49539](https://github.com/ceph/ceph/pull/49539), Igor Fedotov)
-   mds: fix and skip submitting invalid osd request
    ([pr#49939](https://github.com/ceph/ceph/pull/49939), Xiubo Li)
-   mds: fix scan_stray_dir not reset next.frag on each run of stray
    inode ([pr#49670](https://github.com/ceph/ceph/pull/49670), ethanwu)
-   mds: md_log_replay thread blocks waiting to be woken up
    ([pr#49672](https://github.com/ceph/ceph/pull/49672), zhikuodu)
-   mds: switch submit_mutex to fair mutex for MDLog
    ([pr#49633](https://github.com/ceph/ceph/pull/49633), Xiubo Li)
-   mds: wait unlink to finish to avoid conflict when creating same
    entries ([pr#48452](https://github.com/ceph/ceph/pull/48452), Xiubo
    Li)
-   mgr/cephadm: add ingress support for ssl rgw service
    ([pr#49865](https://github.com/ceph/ceph/pull/49865), Frank
    Ederveen)
-   mgr/cephadm: allow setting prometheus retention time
    ([pr#47943](https://github.com/ceph/ceph/pull/47943), Redouane
    Kachach, Adam King)
-   mgr/cephadm: call iscsi post_remove from serve loop
    ([pr#49847](https://github.com/ceph/ceph/pull/49847), Adam King)
-   mgr/cephadm: don\'t say migration in progress if migration current
    \> migration last
    ([pr#49861](https://github.com/ceph/ceph/pull/49861), Adam King)
-   mgr/cephadm: don\'t use \"sudo\" in commands if user is root
    ([pr#48079](https://github.com/ceph/ceph/pull/48079), Adam King)
-   mgr/cephadm: fix backends service in haproxy config with multiple
    nfs of same rank
    ([pr#50446](https://github.com/ceph/ceph/pull/50446), Adam King)
-   mgr/cephadm: fix check for if devices have changed
    ([pr#49864](https://github.com/ceph/ceph/pull/49864), Adam King)
-   mgr/cephadm: fix handling of mgr upgrades with 3 or more mgrs
    ([pr#49859](https://github.com/ceph/ceph/pull/49859), Adam King)
-   mgr/cephadm: fix removing offline hosts with ingress daemons
    ([pr#49850](https://github.com/ceph/ceph/pull/49850), Adam King)
-   mgr/cephadm: fix tuned profiles getting removed if name has dashes
    ([pr#48077](https://github.com/ceph/ceph/pull/48077), Adam King)
-   mgr/cephadm: improve offline host handling, mostly around upgrade
    ([pr#49856](https://github.com/ceph/ceph/pull/49856), Adam King)
-   mgr/cephadm: increase ingress timeout values
    ([pr#49853](https://github.com/ceph/ceph/pull/49853), Frank
    Ederveen)
-   mgr/cephadm: iscsi username and password defaults to admin
    ([pr#49309](https://github.com/ceph/ceph/pull/49309), Nizamudeen A)
-   mgr/cephadm: make logging refresh metadata to debug logs
    configurable ([pr#49857](https://github.com/ceph/ceph/pull/49857),
    Adam King)
-   mgr/cephadm: make setting \--cgroups=split configurable
    ([pr#48075](https://github.com/ceph/ceph/pull/48075), Adam King)
-   mgr/cephadm: reconfig iscsi daemons if trusted_ip_list changes
    ([pr#48076](https://github.com/ceph/ceph/pull/48076), Adam King)
-   mgr/cephadm: save host cache data after scheduling daemon action
    ([pr#49863](https://github.com/ceph/ceph/pull/49863), Adam King)
-   mgr/cephadm: some master -\> main cleanup
    ([pr#49284](https://github.com/ceph/ceph/pull/49284), Adam King)
-   mgr/cephadm: specify ports for iscsi
    ([pr#49862](https://github.com/ceph/ceph/pull/49862), Adam King)
-   mgr/cephadm: support for extra entrypoint args
    ([pr#49851](https://github.com/ceph/ceph/pull/49851), Adam King)
-   mgr/cephadm: try to avoid pull when getting container image info
    ([pr#50170](https://github.com/ceph/ceph/pull/50170), Mykola Golub,
    Adam King)
-   mgr/cephadm: validating tuned profile specification
    ([pr#48078](https://github.com/ceph/ceph/pull/48078), Redouane
    Kachach)
-   mgr/cephadm: write client files after applying services
    ([pr#49860](https://github.com/ceph/ceph/pull/49860), Adam King)
-   mgr/dashboard: Add a Silence button shortcut to alert notifications
    ([pr#48065](https://github.com/ceph/ceph/pull/48065), Nizamudeen A,
    Aashish Sharma)
-   mgr/dashboard: Add details to the modal which displays the
    [safe-to-d... (\`pr#48177
    \<https://github.com/ceph/ceph/pull/48177\>]{.title-ref}\_,
    Francesco Torchia)
-   mgr/dashboard: Add metric relative to osd blocklist
    ([pr#49501](https://github.com/ceph/ceph/pull/49501), Aashish
    Sharma)
-   mgr/dashboard: add option to resolve ip addr
    ([pr#48219](https://github.com/ceph/ceph/pull/48219), Tatjana
    Dehler)
-   mgr/dashboard: add server side encryption to rgw/s3
    ([pr#48441](https://github.com/ceph/ceph/pull/48441), Aashish
    Sharma)
-   mgr/dashboard: Add text to empty life expectancy column
    ([pr#48271](https://github.com/ceph/ceph/pull/48271), Francesco
    Torchia)
-   mgr/dashboard: add tooltip mirroring pools table
    ([pr#49504](https://github.com/ceph/ceph/pull/49504), Pedro Gonzalez
    Gomez)
-   mgr/dashboard: allow cross origin when the url is set
    ([pr#49150](https://github.com/ceph/ceph/pull/49150), Avan Thakkar,
    Nizamudeen A)
-   mgr/dashboard: backport of all accessibility changes
    ([pr#49727](https://github.com/ceph/ceph/pull/49727), nsedrickm)
-   mgr/dashboard: bug fixes for rbd mirroring edit and
    promotion/demotion
    ([pr#48807](https://github.com/ceph/ceph/pull/48807), Pedro Gonzalez
    Gomez)
-   mgr/dashboard: cephadm dashboard e2e fixes
    ([pr#50450](https://github.com/ceph/ceph/pull/50450), Nizamudeen A)
-   mgr/dashboard: custom image for kcli bootstrap script
    ([pr#50459](https://github.com/ceph/ceph/pull/50459), Nizamudeen A)
-   mgr/dashboard: display real health in rbd mirroring pools
    ([pr#49518](https://github.com/ceph/ceph/pull/49518), Pere Diaz Bou)
-   mgr/dashboard: fix \"can\'t read .ssh/known_hosts: No such file or
    directory ([pr#47957](https://github.com/ceph/ceph/pull/47957),
    Nizamudeen A)
-   mgr/dashboard: Fix broken Fedora image URL
    ([pr#48340](https://github.com/ceph/ceph/pull/48340), Zack Cerza,
    Nizamudeen A)
-   mgr/dashboard: fix bucket encryption checkbox
    ([pr#49776](https://github.com/ceph/ceph/pull/49776), Aashish
    Sharma)
-   mgr/dashboard: fix CephPGImbalance alert
    ([pr#49476](https://github.com/ceph/ceph/pull/49476), Aashish
    Sharma)
-   mgr/dashboard: Fix CephPoolGrowthWarning alert
    ([pr#49475](https://github.com/ceph/ceph/pull/49475), Aashish
    Sharma)
-   mgr/dashboard: fix constraints.txt
    ([pr#50234](https://github.com/ceph/ceph/pull/50234), Ernesto
    Puerta)
-   mgr/dashboard: fix Expected to find element: [cd-modal .badge but
    never found it (\`pr#48141
    \<https://github.com/ceph/ceph/pull/48141\>]{.title-ref}\_,
    Nizamudeen A)
-   mgr/dashboard: fix openapi-check
    ([pr#48046](https://github.com/ceph/ceph/pull/48046), Pere Diaz Bou)
-   mgr/dashboard: fix rbd mirroring daemon health status
    ([pr#50125](https://github.com/ceph/ceph/pull/50125), Nizamudeen A)
-   mgr/dashboard: fix rgw connect when using ssl
    ([issue#56970](http://tracker.ceph.com/issues/56970),
    [pr#48188](https://github.com/ceph/ceph/pull/48188), Henry Hirsch)
-   mgr/dashboard: fix server side encryption config error
    ([pr#49481](https://github.com/ceph/ceph/pull/49481), Aashish
    Sharma)
-   mgr/dashboard: fix snapshot creation with duplicate name
    ([pr#48047](https://github.com/ceph/ceph/pull/48047), Aashish
    Sharma)
-   mgr/dashboard: fix weird data in osd details
    ([pr#48433](https://github.com/ceph/ceph/pull/48433), Pedro Gonzalez
    Gomez, Nizamudeen A)
-   mgr/dashboard: handle the cephfs permission issue in nfs exports
    ([pr#48315](https://github.com/ceph/ceph/pull/48315), Nizamudeen A)
-   mgr/dashboard: move service_instances logic to backend
    ([pr#50451](https://github.com/ceph/ceph/pull/50451), Nizamudeen A)
-   mgr/dashboard: osd form preselect db/wal device filters
    ([pr#48115](https://github.com/ceph/ceph/pull/48115), Nizamudeen A)
-   mgr/dashboard: paginate services
    ([pr#48788](https://github.com/ceph/ceph/pull/48788), Melissa Li,
    Pere Diaz Bou)
-   mgr/dashboard: rbd-mirror improvements
    ([pr#49499](https://github.com/ceph/ceph/pull/49499), Aashish
    Sharma)
-   mgr/dashboard: refactor dashboard cephadm e2e tests
    ([pr#48432](https://github.com/ceph/ceph/pull/48432), Nizamudeen A)
-   mgr/dashboard: Replace vonage-status-panel with native grafana stat
    panel ([pr#50043](https://github.com/ceph/ceph/pull/50043), Aashish
    Sharma)
-   mgr/dashboard: rgw server side encryption config values set to wrong
    daemon ([pr#49724](https://github.com/ceph/ceph/pull/49724), Aashish
    Sharma)
-   mgr/dashboard: Unable to change rgw subuser permission
    ([pr#48440](https://github.com/ceph/ceph/pull/48440), Aashish
    Sharma)
-   mgr/dashboard: upgrade to angular 13, bootstrap 5 and jest 28
    ([pr#50124](https://github.com/ceph/ceph/pull/50124), Nizamudeen A,
    Bryan Montalvan)
-   mgr/nfs: add sectype option
    ([pr#48531](https://github.com/ceph/ceph/pull/48531), John Mulligan)
-   mgr/nfs: handle bad cluster name during info command
    ([pr#49654](https://github.com/ceph/ceph/pull/49654), Dhairya
    Parmar)
-   mgr/orchestrator: fix upgrade status help message
    ([pr#49855](https://github.com/ceph/ceph/pull/49855), Adam King)
-   mgr/prometheus: change pg_repaired_objects name to
    pool_repaired_objects
    ([pr#48438](https://github.com/ceph/ceph/pull/48438), Pere Diaz Bou)
-   mgr/prometheus: export zero valued pg state metrics
    ([pr#49787](https://github.com/ceph/ceph/pull/49787), Avan Thakkar)
-   mgr/prometheus: expose daemon health metrics
    ([pr#49519](https://github.com/ceph/ceph/pull/49519), Pere Diaz Bou)
-   mgr/prometheus: expose repaired pgs metrics
    ([pr#48204](https://github.com/ceph/ceph/pull/48204), Pere Diaz Bou)
-   mgr/prometheus: fix module crash when trying to collect OSDs metrics
    ([pr#49930](https://github.com/ceph/ceph/pull/49930), Redouane
    Kachach)
-   mgr/prometheus: use vendored \"packaging\" instead
    ([pr#49698](https://github.com/ceph/ceph/pull/49698), Kefu Chai,
    Matan Breizman)
-   mgr/rbd_support: avoid wedging the task queue if pool is removed
    ([pr#49057](https://github.com/ceph/ceph/pull/49057), Ilya Dryomov)
-   mgr/rbd_support: remove localized schedule option during module
    startup ([pr#49649](https://github.com/ceph/ceph/pull/49649), Ramana
    Raja)
-   mgr/rook: Device inventory
    ([pr#49877](https://github.com/ceph/ceph/pull/49877), Juan Miguel
    Olmo Martínez)
-   mgr/rook:NFSRados constructor expects type of rados as a parameter
    instead of MgrModule
    ([pr#48830](https://github.com/ceph/ceph/pull/48830), Ben Gao)
-   mgr/snap_schedule: remove subvol interface
    ([pr#48222](https://github.com/ceph/ceph/pull/48222), Milind
    Changire)
-   mgr/telemetry: add [basic_pool_options_bluestore]{.title-ref}
    collection ([pr#49414](https://github.com/ceph/ceph/pull/49414),
    Laura Flores)
-   mgr/telemetry: handle daemons with complex ids
    ([pr#48283](https://github.com/ceph/ceph/pull/48283), Laura Flores)
-   mgr/volumes: Add human-readable flag to volume info command
    ([pr#48466](https://github.com/ceph/ceph/pull/48466), Neeraj Pratap
    Singh)
-   mgr: Fix prettytable pinning to restore python3.6
    ([pr#48297](https://github.com/ceph/ceph/pull/48297), Zack Cerza)
-   mon, osd: rework the public_bind_addr support. Bring it to OSD
    ([pr#50153](https://github.com/ceph/ceph/pull/50153), Radosław
    Zarzyński, Radoslaw Zarzynski)
-   mon,auth,cephadm: support auth key rotation
    ([pr#48093](https://github.com/ceph/ceph/pull/48093), Adam King,
    Radoslaw Zarzynski, Sage Weil)
-   mon/Elector.cc: Compress peer \>= rank_size sanity check into
    send_peer_ping ([pr#49433](https://github.com/ceph/ceph/pull/49433),
    Kamoltat)
-   mon/Elector: Added sanity check when pinging a peer monitor
    ([pr#48321](https://github.com/ceph/ceph/pull/48321), Kamoltat)
-   mon/Elector: Change how we handle removed_ranks and
    notify_rank_removed()
    ([pr#49311](https://github.com/ceph/ceph/pull/49311), Kamoltat)
-   mon/LogMonitor: Fix log last
    ([pr#50407](https://github.com/ceph/ceph/pull/50407), Prashant D)
-   mon/MgrMap: dump last_failure_osd_epoch and active_clients at top
    level ([pr#50306](https://github.com/ceph/ceph/pull/50306), Ilya
    Dryomov)
-   mon/MonCommands: Support dump_historic_slow_ops
    ([pr#49232](https://github.com/ceph/ceph/pull/49232), Matan
    Breizman)
-   mon/OSDMointor: Simplify check_pg_num()
    ([pr#50327](https://github.com/ceph/ceph/pull/50327), Matan
    Breizman, Anthony D\'Atri, Tongliang Deng, Jerry Luo)
-   mon: bail from handle_command() if \_generate_command_map() fails
    ([pr#48845](https://github.com/ceph/ceph/pull/48845), Nikhil
    Kshirsagar)
-   mon: disable snap id allocation for fsmap pools
    ([pr#50090](https://github.com/ceph/ceph/pull/50090), Milind
    Changire)
-   mon: Fix condition to check for ceph version mismatch
    ([pr#49989](https://github.com/ceph/ceph/pull/49989), Prashant D)
-   Monitor: forward report command to leader
    ([pr#47928](https://github.com/ceph/ceph/pull/47928), Dan van der
    Ster)
-   monitoring/ceph-mixin: add RGW host to label info
    ([pr#48034](https://github.com/ceph/ceph/pull/48034), Tatjana
    Dehler)
-   mount: fix mount failure with old kernels
    ([pr#49404](https://github.com/ceph/ceph/pull/49404), Xiubo Li)
-   os/bluesore: cumulative backport for Onode stuff and more
    ([pr#50048](https://github.com/ceph/ceph/pull/50048), Igor Fedotov,
    Adam Kupczyk)
-   os/bluestore: BlueFS: harmonize log read and writes modes
    ([pr#50474](https://github.com/ceph/ceph/pull/50474), Adam Kupczyk)
-   os/bluestore: enable 4K allocation unit for BlueFS
    ([pr#49884](https://github.com/ceph/ceph/pull/49884), Igor Fedotov)
-   os/memstore: Fix memory leak
    ([pr#50091](https://github.com/ceph/ceph/pull/50091), Adam Kupczyk)
-   osd: add created_at meta
    ([pr#49159](https://github.com/ceph/ceph/pull/49159), Alex
    Marangone)
-   osd: add scrub duration for scrubs after recovery
    ([pr#47926](https://github.com/ceph/ceph/pull/47926), Aishwarya
    Mathuria)
-   osd: Implement Context based completion for mon cmd to set a config
    option ([pr#47983](https://github.com/ceph/ceph/pull/47983), Sridhar
    Seshasayee)
-   osd: mds: suggest clock skew when failing to obtain rotating service
    keys ([pr#50405](https://github.com/ceph/ceph/pull/50405), Greg
    Farnum)
-   osd: Randomize osd bench buffer data before submitting to
    objectstore ([pr#49323](https://github.com/ceph/ceph/pull/49323),
    Sridhar Seshasayee)
-   osd: Reduce backfill/recovery default limits for mClock and other
    optimizations ([pr#49437](https://github.com/ceph/ceph/pull/49437),
    Sridhar Seshasayee)
-   osd: remove invalid put on message
    ([pr#48039](https://github.com/ceph/ceph/pull/48039), Nitzan
    Mordechai)
-   osd: Reset mClock\'s OSD capacity config option for inactive device
    type ([pr#49281](https://github.com/ceph/ceph/pull/49281), Sridhar
    Seshasayee)
-   osd: Restore defaults of mClock built-in profiles upon modification
    ([pr#50097](https://github.com/ceph/ceph/pull/50097), Sridhar
    Seshasayee)
-   osd: shut down the MgrClient before osd_fast_shutdown
    ([pr#49881](https://github.com/ceph/ceph/pull/49881), Laura Flores,
    Brad Hubbard)
-   osd/scrub: use the actual active set when requesting replicas...
    ([pr#48543](https://github.com/ceph/ceph/pull/48543), Ronen
    Friedman)
-   PendingReleaseNotes: document online and offline trimming of PG
    Log\'s... ([pr#48019](https://github.com/ceph/ceph/pull/48019),
    Radoslaw Zarzynski)
-   pybind/mgr/autoscaler: Do not show NEW PG_NUM value if autoscaler is
    not on ([pr#47925](https://github.com/ceph/ceph/pull/47925),
    Prashant D)
-   pybind/mgr: check for empty metadata mgr_module:get_metadata()
    ([issue#57072](http://tracker.ceph.com/issues/57072),
    [pr#49967](https://github.com/ceph/ceph/pull/49967), Venky Shankar)
-   pybind/mgr: fix tox autopep8 args flake8
    ([pr#49505](https://github.com/ceph/ceph/pull/49505), Aashish
    Sharma)
-   pybind/mgr: fixup after upgrading tox versions
    ([pr#49361](https://github.com/ceph/ceph/pull/49361), Kefu Chai,
    Adam King)
-   pybind/mgr: object_format.py decorator updates & docs
    ([pr#47979](https://github.com/ceph/ceph/pull/47979), John Mulligan)
-   pybind/mgr: tox and test fixes
    ([pr#49508](https://github.com/ceph/ceph/pull/49508), Kefu Chai)
-   pybind/mgr: use memory temp_store for sqlite3 db
    ([pr#50286](https://github.com/ceph/ceph/pull/50286), Patrick
    Donnelly)
-   pybind/rados: notify callback reconnect
    ([pr#48113](https://github.com/ceph/ceph/pull/48113), Nitzan
    Mordechai)
-   python-common: Add \'KB\' to supported suffixes in SizeMatcher
    ([pr#48242](https://github.com/ceph/ceph/pull/48242), Tim Serong)
-   qa/cephadm: remove fsid dir before bootstrap in test_cephadm.sh
    ([pr#47949](https://github.com/ceph/ceph/pull/47949), Adam King)
-   qa/suites/rbd: fix sporadic \"rx-only direction\" test failures
    ([pr#50113](https://github.com/ceph/ceph/pull/50113), Ilya Dryomov)
-   qa/suites/rgw: fix and update tempest and barbican tests
    ([pr#50002](https://github.com/ceph/ceph/pull/50002), Tobias Urdin)
-   qa/tasks/cephadm.py: fix pulling cephadm from git.ceph.com
    ([pr#49858](https://github.com/ceph/ceph/pull/49858), Adam King)
-   qa/tasks/kubeadm: set up tigera resources via kubectl create
    ([pr#48080](https://github.com/ceph/ceph/pull/48080), John Mulligan)
-   qa/tasks/rbd_fio: bump default to fio 3.32
    ([pr#48386](https://github.com/ceph/ceph/pull/48386), Ilya Dryomov)
-   qa/tests: added quincy client upgrade =\> reef
    ([pr#50353](https://github.com/ceph/ceph/pull/50353), Yuri
    Weinstein)
-   qa/tests: initial draft for quincy p2p tests
    ([pr#46896](https://github.com/ceph/ceph/pull/46896), Yuri
    Weinstein, Laura Flores)
-   qa/workunits/rados: specify redirect in curl command
    ([pr#49140](https://github.com/ceph/ceph/pull/49140), Laura Flores)
-   qa/workunits/windows: backport rbd-wnbd tests
    ([pr#49883](https://github.com/ceph/ceph/pull/49883), Lucian Petrut)
-   qa: Fix test_subvolume_group_ls_filter_internal_directories
    ([pr#48327](https://github.com/ceph/ceph/pull/48327), Kotresh HR)
-   qa: Fix test_subvolume_snapshot_info_if_orphan_clone
    ([pr#48325](https://github.com/ceph/ceph/pull/48325), Kotresh HR)
-   qa: ignore disk quota exceeded failure in test
    ([pr#48164](https://github.com/ceph/ceph/pull/48164), Nikhilkumar
    Shelke)
-   qa: switch back to git protocol for qemu-xfstests
    ([pr#49544](https://github.com/ceph/ceph/pull/49544), Ilya Dryomov)
-   qa: switch to https protocol for repos\' server
    ([pr#49471](https://github.com/ceph/ceph/pull/49471), Xiubo Li)
-   qa: wait for scrub to finish
    ([pr#49459](https://github.com/ceph/ceph/pull/49459), Milind
    Changire)
-   rbd-mirror: add information about the last snapshot sync to image
    status ([pr#50266](https://github.com/ceph/ceph/pull/50266),
    Divyansh Kamboj)
-   rbd-mirror: fix syncing_percent calculation logic in
    get_replay_status()
    ([pr#50180](https://github.com/ceph/ceph/pull/50180), N
    Balachandran)
-   rbd: add \--snap-id option to \"rbd device map\" to allow mapping
    arbitrary snapshots
    ([pr#49197](https://github.com/ceph/ceph/pull/49197), Ilya Dryomov,
    Prasanna Kumar Kalever)
-   rbd: device map/unmap \--namespace handling fixes
    ([pr#48458](https://github.com/ceph/ceph/pull/48458), Ilya Dryomov,
    Stefan Chivu)
-   RGW - Make sure PostObj set bucket on s-\>object
    ([pr#49641](https://github.com/ceph/ceph/pull/49641), Daniel
    Gryniewicz)
-   rgw multisite: replicate metadata for iam roles
    ([pr#48030](https://github.com/ceph/ceph/pull/48030), Pritha
    Srivastava, Abhishek Lekshmanan)
-   rgw/beast: fix interaction between keepalive and 100-continue
    ([pr#49840](https://github.com/ceph/ceph/pull/49840), Casey Bodley)
-   rgw/beast: StreamIO remembers connection errors for graceful
    shutdown ([pr#50239](https://github.com/ceph/ceph/pull/50239), Casey
    Bodley)
-   rgw/coroutine: check for null stack on wakeup
    ([pr#49096](https://github.com/ceph/ceph/pull/49096), Casey Bodley)
-   rgw: \"reshard cancel\" errors with \"invalid argument\"
    ([pr#49090](https://github.com/ceph/ceph/pull/49090), J. Eric
    Ivancich)
-   rgw: add \'inline_data\' zone placement info option
    ([pr#50209](https://github.com/ceph/ceph/pull/50209), Cory Snyder)
-   rgw: adding BUCKET_REWRITE and OBJECT_REWRITE OPS to
    ([pr#49094](https://github.com/ceph/ceph/pull/49094), Pritha
    Srivastava)
-   rgw: address bug where object puts could write to decommissioned
    shard ([pr#49795](https://github.com/ceph/ceph/pull/49795), J. Eric
    Ivancich)
-   rgw: Backport of issue 57562 to Quincy
    ([pr#49679](https://github.com/ceph/ceph/pull/49679), Adam C.
    Emerson)
-   rgw: bucket list operation slow down in special scenario
    ([pr#49085](https://github.com/ceph/ceph/pull/49085), zealot)
-   rgw: default-initialize delete_multi_obj_op_meta
    ([pr#50184](https://github.com/ceph/ceph/pull/50184), Casey Bodley)
-   rgw: fix bool/int logic error when calling get_obj_head_ioctx
    ([pr#48231](https://github.com/ceph/ceph/pull/48231), J. Eric
    Ivancich)
-   rgw: fix bug where variable referenced after data moved out
    ([pr#48228](https://github.com/ceph/ceph/pull/48228), J. Eric
    Ivancich)
-   rgw: fix data corruption due to network jitter
    ([pr#48273](https://github.com/ceph/ceph/pull/48273), Shasha Lu)
-   rgw: Fix segfault due to concurrent socket use at timeout
    ([pr#50240](https://github.com/ceph/ceph/pull/50240), Yixin Jin)
-   rgw: fix segfault in UserAsyncRefreshHandler::init_fetch
    ([pr#49083](https://github.com/ceph/ceph/pull/49083), Cory Snyder)
-   rgw: fix the problem of duplicate idx when bi list
    ([pr#49828](https://github.com/ceph/ceph/pull/49828), wangtengfei)
-   rgw: Fix truncated ListBuckets response
    ([pr#49525](https://github.com/ceph/ceph/pull/49525), Joshua
    Baergen)
-   rgw: log deletion status of individual objects in multi object
    delete request ([pr#49084](https://github.com/ceph/ceph/pull/49084),
    Cory Snyder)
-   rgw: prevent spurious/lost notifications in the index completion
    thread ([pr#49092](https://github.com/ceph/ceph/pull/49092), Casey
    Bodley, Yuval Lifshitz)
-   rgw: remove guard_reshard in bucket_index_read_olh_log
    ([pr#49775](https://github.com/ceph/ceph/pull/49775), Mingyuan
    Liang)
-   rgw: RGWPutLC does not require Content-MD5
    ([pr#49088](https://github.com/ceph/ceph/pull/49088), Casey Bodley)
-   rgw: splitting gc chains into smaller parts to prevent
    ([pr#48239](https://github.com/ceph/ceph/pull/48239), Pritha
    Srivastava)
-   rgw: x-amz-date change breaks certain cases of aws sig v4
    ([pr#48312](https://github.com/ceph/ceph/pull/48312), Marcus Watts)
-   src/crush: extra logging to debug CPU burn in test_with_fork()
    ([pr#50406](https://github.com/ceph/ceph/pull/50406), Deepika
    Upadhyay)
-   src/mds: increment directory inode\'s change attr by one
    ([pr#48520](https://github.com/ceph/ceph/pull/48520), Ramana Raja)
-   src/pybind/cephfs: fix grammar
    ([pr#48981](https://github.com/ceph/ceph/pull/48981), Zac Dover)
-   src/pybind: fix typo in cephfs.pyx
    ([pr#48952](https://github.com/ceph/ceph/pull/48952), Zac Dover)
-   src/valgrind.supp: Adding know leaks unrelated to ceph
    ([pr#49522](https://github.com/ceph/ceph/pull/49522), Nitzan
    Mordechai)
-   tests: remove pubsub tests from multisite
    ([pr#48914](https://github.com/ceph/ceph/pull/48914), Yuval
    Lifshitz)
-   v17.2.5 ([pr#48519](https://github.com/ceph/ceph/pull/48519), Ceph
    Release Team, Laura Flores, Guillaume Abrioux, Juan Miguel Olmo
    Martínez)
-   Wip doc 2022 11 21 backport 48975 to quincy
    ([pr#48976](https://github.com/ceph/ceph/pull/48976), Zac Dover)

## v17.2.5 Quincy

This is a hotfix release that addresses missing commits in the 17.2.4
release. We recommend that all users update to this release.

Related tracker: <https://tracker.ceph.com/issues/57858>

### Notable Changes

-   A ceph-volume regression introduced in bea9f4b that makes the
    activate process take a very long time to complete has been fixed.

    Related tracker: <https://tracker.ceph.com/issues/57627>

-   An exception that occurs with some NFS commands in Rook clusters has
    been fixed.

    Related tracker: <https://tracker.ceph.com/issues/55605>

-   A crash in the Telemetry module that may affect some users opted
    into the perf channel has been fixed.

    Related tracker: <https://tracker.ceph.com/issues/57700>

### Changelog

-   ceph-volume: fix regression in activate
    ([pr#48201](https://github.com/ceph/ceph/pull/48201), Guillaume
    Abrioux)
-   mgr/rook: fix error when trying to get the list of nfs services
    ([pr#48199](https://github.com/ceph/ceph/pull/48199), Juan Miguel
    Olmo)
-   mgr/telemetry: handle daemons with complex ids
    ([pr#48283](https://github.com/ceph/ceph/pull/48283), Laura Flores)
-   Revert PR 47901
    ([pr#48104](https://github.com/ceph/ceph/pull/48104), Laura Flores)

## v17.2.4 Quincy

This is the fourth backport release in the Quincy series. We recommend
that all users update to this release.

### Notable Changes

-   Cephfs: The `AT_NO_ATTR_SYNC` macro is deprecated, please use the
    standard `AT_STATX_DONT_SYNC` macro. The `AT_NO_ATTR_SYNC` macro
    will be removed in the future.
-   OSD: The issue of high CPU utilization during recovery/backfill
    operations has been fixed. For more details see:
    <https://tracker.ceph.com/issues/56530>.
-   Trimming of PGLog dups is now controlled by size instead of the
    version. This fixes the PGLog inflation issue that was happening
    when online (in OSD) trimming jammed after a PG split operation.
    Also, a new offline mechanism has been added:
    `ceph-objectstore-tool` now has a `trim-pg-log-dups` op that targets
    situations where an OSD is unable to boot due to those inflated
    dups. If that is the case, in OSD logs the \"You can be hit by THE
    DUPS BUG\" warning will be visible. Relevant tracker:
    <https://tracker.ceph.com/issues/53729>
-   OSD: Octopus modified the SnapMapper key format from
    `<LEGACY_MAPPING_PREFIX><snapid>_<shardid>_<hobject_t::to_str()>` to
    `<MAPPING_PREFIX><pool>_<snapid>_<shardid>_<hobject_t::to_str()>`.
    When this change was introduced,
    [94ebe0e](https://github.com/ceph/ceph/commit/94ebe0eab968068c29fdffa1bfe68c72122db633)
    also introduced a conversion with a crucial bug which essentially
    destroyed legacy keys by mapping them to
    `<MAPPING_PREFIX><poolid>_<snapid>_` without the object-unique
    suffix. The conversion is fixed in this release. Relevant tracker:
    <https://tracker.ceph.com/issues/56147>

### Changelog

-   .readthedocs.yml: Always build latest doc/releases pages
    ([pr#47442](https://github.com/ceph/ceph/pull/47442), David
    Galloway)
-   Add mapping for ernno:13 and adding path in error msg in
    opendir()/cephfs.pyx
    ([pr#46647](https://github.com/ceph/ceph/pull/46647), Sarthak0702)
-   admin: Fix check if PR or release branch docs build
    ([pr#47739](https://github.com/ceph/ceph/pull/47739), David
    Galloway)
-   bdev: fix FTBFS on FreeBSD, keep the huge paged read buffers
    ([pr#44641](https://github.com/ceph/ceph/pull/44641), Radoslaw
    Zarzynski)
-   build: Silence deprecation warnings from OpenSSL 3
    ([pr#47585](https://github.com/ceph/ceph/pull/47585), Kefu Chai,
    Adam C. Emerson)
-   Catch exception if thrown by \_\_generate_command_map()
    ([pr#45892](https://github.com/ceph/ceph/pull/45892), Nikhil
    Kshirsagar)
-   ceph-fuse: add dedicated snap stag map for each directory
    ([pr#46948](https://github.com/ceph/ceph/pull/46948), Xiubo Li)
-   ceph-mixin: backport of recent cleanups
    ([pr#46548](https://github.com/ceph/ceph/pull/46548), Arthur
    Outhenin-Chalandre)
-   ceph-volume: avoid unnecessary subprocess calls
    ([pr#46968](https://github.com/ceph/ceph/pull/46968), Guillaume
    Abrioux)
-   ceph-volume: decrease number of [pvs]{.title-ref} calls in [lvm
    list]{.title-ref}
    ([pr#46966](https://github.com/ceph/ceph/pull/46966), Guillaume
    Abrioux)
-   ceph-volume: do not call get_device_vgs() per devices
    ([pr#47348](https://github.com/ceph/ceph/pull/47348), Guillaume
    Abrioux)
-   ceph-volume: do not log sensitive details
    ([pr#46728](https://github.com/ceph/ceph/pull/46728), Guillaume
    Abrioux)
-   ceph-volume: fix [simple scan]{.title-ref}
    ([pr#47149](https://github.com/ceph/ceph/pull/47149), Guillaume
    Abrioux)
-   ceph-volume: fix fast device alloc size on mulitple device
    ([pr#47293](https://github.com/ceph/ceph/pull/47293), Arthur
    Outhenin-Chalandre)
-   ceph-volume: fix regression in activate
    ([pr#48201](https://github.com/ceph/ceph/pull/48201), Guillaume
    Abrioux)
-   ceph-volume: make is_valid() optional
    ([pr#46730](https://github.com/ceph/ceph/pull/46730), Guillaume
    Abrioux)
-   ceph-volume: only warn when config file isn\'t found
    ([pr#46070](https://github.com/ceph/ceph/pull/46070), Guillaume
    Abrioux)
-   ceph-volume: Quincy backports
    ([pr#47406](https://github.com/ceph/ceph/pull/47406), Guillaume
    Abrioux, Zack Cerza, Michael Fritch)
-   ceph-volume: system.get_mounts() refactor
    ([pr#47536](https://github.com/ceph/ceph/pull/47536), Guillaume
    Abrioux)
-   ceph-volume/tests: fix test_exception_returns_default
    ([pr#47435](https://github.com/ceph/ceph/pull/47435), Guillaume
    Abrioux)
-   ceph.spec.in backports
    ([pr#47549](https://github.com/ceph/ceph/pull/47549), David
    Galloway, Kefu Chai, Tim Serong, Casey Bodley, Radoslaw Zarzynski,
    Radosław Zarzyński)
-   ceph.spec.in: disable system_pmdk on s390x
    ([pr#47251](https://github.com/ceph/ceph/pull/47251), Ken Dreyer)
-   ceph.spec.in: openSUSE: require gcc11-c++, disable parquet
    ([pr#46155](https://github.com/ceph/ceph/pull/46155), Tim Serong)
-   ceph.spec: fixing cephadm build deps
    ([pr#47069](https://github.com/ceph/ceph/pull/47069), Redouane
    Kachach)
-   cephadm/ceph-volume: fix rm-cluster \--zap
    ([pr#47626](https://github.com/ceph/ceph/pull/47626), Guillaume
    Abrioux)
-   cephadm/mgr: adding logic to handle \--no-overwrite for tuned
    profiles ([pr#47944](https://github.com/ceph/ceph/pull/47944),
    Redouane Kachach)
-   cephadm: add \"su root root\" to cephadm.log logrotate config
    ([pr#47314](https://github.com/ceph/ceph/pull/47314), Adam King)
-   cephadm: add \'is_paused\' field in orch status output
    ([pr#46569](https://github.com/ceph/ceph/pull/46569), Guillaume
    Abrioux)
-   Cephadm: Allow multiple virtual IP addresses for keepalived and
    haproxy ([pr#47610](https://github.com/ceph/ceph/pull/47610), Luis
    Domingues)
-   cephadm: change default keepalived/haproxy container images
    ([pr#46714](https://github.com/ceph/ceph/pull/46714), Guillaume
    Abrioux)
-   cephadm: fix incorrect warning
    ([pr#47608](https://github.com/ceph/ceph/pull/47608), Guillaume
    Abrioux)
-   cephadm: fix osd adoption with custom cluster name
    ([pr#46551](https://github.com/ceph/ceph/pull/46551), Adam King)
-   cephadm: Fix repo_gpgkey should return 2 vars
    ([pr#47374](https://github.com/ceph/ceph/pull/47374), Laurent Barbe)
-   cephadm: improve message when removing osd
    ([pr#47071](https://github.com/ceph/ceph/pull/47071), Guillaume
    Abrioux)
-   cephadm: preserve cephadm user during RPM upgrade
    ([pr#46790](https://github.com/ceph/ceph/pull/46790), Scott
    Shambarger)
-   cephadm: reduce spam to cephadm.log
    ([pr#47313](https://github.com/ceph/ceph/pull/47313), Adam King)
-   cephadm: Remove duplicated process args in promtail and loki
    ([pr#47654](https://github.com/ceph/ceph/pull/47654), jinhong.kim)
-   cephadm: return nonzero exit code when applying spec fails in
    bootstrap ([pr#47952](https://github.com/ceph/ceph/pull/47952), Adam
    King)
-   cephadm: support for Oracle Linux 8
    ([pr#47656](https://github.com/ceph/ceph/pull/47656), Adam King)
-   cephfs-shell: move source to separate subdirectory
    ([pr#47400](https://github.com/ceph/ceph/pull/47400), Tim Serong)
-   cephfs-top: display average read/write/metadata latency
    ([issue#48619](http://tracker.ceph.com/issues/48619),
    [pr#47977](https://github.com/ceph/ceph/pull/47977), Venky Shankar)
-   cephfs-top: fix the rsp/wsp display
    ([pr#47648](https://github.com/ceph/ceph/pull/47648), Jos Collin)
-   client/fuse: Fix directory DACs overriding for root
    ([pr#46595](https://github.com/ceph/ceph/pull/46595), Kotresh HR)
-   client: allow overwrites to file with size greater than the
    max_file_size ([pr#47971](https://github.com/ceph/ceph/pull/47971),
    Tamar Shacked)
-   client: always return ESTALE directly in handle_reply
    ([pr#46558](https://github.com/ceph/ceph/pull/46558), Xiubo Li)
-   client: choose auth MDS for getxattr with the Xs caps
    ([pr#46800](https://github.com/ceph/ceph/pull/46800), Xiubo Li)
-   client: do not release the global snaprealm until unmounting
    ([pr#46495](https://github.com/ceph/ceph/pull/46495), Xiubo Li)
-   client: Inode::hold_caps_until is time from monotonic clock now
    ([pr#46563](https://github.com/ceph/ceph/pull/46563), Laura Flores,
    Neeraj Pratap Singh)
-   client: switch AT_NO_ATTR_SYNC to AT_STATX_DONT_SYNC
    ([pr#46680](https://github.com/ceph/ceph/pull/46680), Xiubo Li)
-   cmake: disable LTO when building pmdk
    ([pr#47619](https://github.com/ceph/ceph/pull/47619), Kefu Chai)
-   cmake: pass -Wno-error when building PMDK
    ([pr#46623](https://github.com/ceph/ceph/pull/46623), Ilya Dryomov)
-   cmake: remove spaces in macro used for compiling cython code
    ([pr#47483](https://github.com/ceph/ceph/pull/47483), Kefu Chai)
-   cmake: set \$PATH for tests using jsonnet tools
    ([pr#47625](https://github.com/ceph/ceph/pull/47625), Kefu Chai)
-   common/bl: fix FTBFS on C++11 due to C++17\'s if-with-initializer
    ([pr#46005](https://github.com/ceph/ceph/pull/46005), Radosław
    Zarzyński)
-   common/win32,dokan: include bcrypt.h for NTSTATUS
    ([pr#48016](https://github.com/ceph/ceph/pull/48016), Lucian Petrut,
    Kefu Chai)
-   common: fix FTBFS due to dout & need_dynamic on GCC-12
    ([pr#46214](https://github.com/ceph/ceph/pull/46214), Radoslaw
    Zarzynski)
-   common: use boost::shared_mutex on Windows
    ([pr#47493](https://github.com/ceph/ceph/pull/47493), Lucian Petrut)
-   crash: pthread_mutex_lock()
    ([pr#47683](https://github.com/ceph/ceph/pull/47683), Patrick
    Donnelly)
-   crimson: fixes for compiling with fmtlib v8
    ([pr#47603](https://github.com/ceph/ceph/pull/47603), Adam C.
    Emerson, Kefu Chai)
-   doc, crimson: document installing crimson with cephadm
    ([pr#47283](https://github.com/ceph/ceph/pull/47283), Radoslaw
    Zarzynski)
-   doc/cephadm/services: fix example for specifying rgw placement
    ([pr#47947](https://github.com/ceph/ceph/pull/47947), Redouane
    Kachach)
-   doc/cephadm/services: the config section of service specs
    ([pr#47068](https://github.com/ceph/ceph/pull/47068), Redouane
    Kachach)
-   doc/cephadm: add note about OSDs being recreated to OSD removal
    section ([pr#47102](https://github.com/ceph/ceph/pull/47102), Adam
    King)
-   doc/cephadm: Add post-upgrade section
    ([pr#47077](https://github.com/ceph/ceph/pull/47077), Redouane
    Kachach)
-   doc/cephadm: document the new per-fsid cephadm conf location
    ([pr#47076](https://github.com/ceph/ceph/pull/47076), Redouane
    Kachach)
-   doc/cephadm: enhancing daemon operations documentation
    ([pr#47074](https://github.com/ceph/ceph/pull/47074), Redouane
    Kachach)
-   doc/cephadm: fix example for specifying networks for rgw
    ([pr#47806](https://github.com/ceph/ceph/pull/47806), Adam King)
-   doc/dev: add context note to dev guide config
    ([pr#46818](https://github.com/ceph/ceph/pull/46818), Zac Dover)
-   doc/dev: add Dependabot section to essentials.rst
    ([pr#47042](https://github.com/ceph/ceph/pull/47042), Zac Dover)
-   doc/dev: add IRC registration instructions
    ([pr#46940](https://github.com/ceph/ceph/pull/46940), Zac Dover)
-   doc/dev: edit delayed-delete.rst
    ([pr#47051](https://github.com/ceph/ceph/pull/47051), Zac Dover)
-   doc/dev: Elaborate on boost .deb creation
    ([pr#47415](https://github.com/ceph/ceph/pull/47415), David
    Galloway)
-   doc/dev: s/github/GitHub/ in essentials.rst
    ([pr#47048](https://github.com/ceph/ceph/pull/47048), Zac Dover)
-   doc/dev: s/master/main/ essentials.rst dev guide
    ([pr#46661](https://github.com/ceph/ceph/pull/46661), Zac Dover)
-   doc/dev: s/master/main/ in basic workflow
    ([pr#46703](https://github.com/ceph/ceph/pull/46703), Zac Dover)
-   doc/dev: s/master/main/ in title
    ([pr#46721](https://github.com/ceph/ceph/pull/46721), Zac Dover)
-   doc/dev: s/the the/the/ in basic-workflow.rst
    ([pr#46935](https://github.com/ceph/ceph/pull/46935), Zac Dover)
-   doc/dev_guide: s/master/main in merging.rst
    ([pr#46709](https://github.com/ceph/ceph/pull/46709), Zac Dover)
-   doc/index.rst: add link to Dev Guide basic workfl
    ([pr#46904](https://github.com/ceph/ceph/pull/46904), Zac Dover)
-   doc/man/rbd: Mention changed [bluestore_min_alloc_size]{.title-ref}
    ([pr#47579](https://github.com/ceph/ceph/pull/47579), Niklas
    Hambüchen)
-   doc/mgr: add prompt directives to dashboard.rst
    ([pr#47822](https://github.com/ceph/ceph/pull/47822), Zac Dover)
-   doc/mgr: edit orchestrator.rst
    ([pr#47780](https://github.com/ceph/ceph/pull/47780), Zac Dover)
-   doc/mgr: update prompts in dboard.rst includes
    ([pr#47869](https://github.com/ceph/ceph/pull/47869), Zac Dover)
-   doc/rados/operations: add prompts to operating.rst
    ([pr#47586](https://github.com/ceph/ceph/pull/47586), Zac Dover)
-   doc/radosgw: Uppercase s3
    ([pr#47359](https://github.com/ceph/ceph/pull/47359), Anthony
    D\'Atri)
-   doc/start: alphabetize hardware-recs links
    ([pr#46339](https://github.com/ceph/ceph/pull/46339), Zac Dover)
-   doc/start: make OSD and MDS structures parallel
    ([pr#46655](https://github.com/ceph/ceph/pull/46655), Zac Dover)
-   doc/start: Polish network section of hardware-recommendations.rst
    ([pr#46665](https://github.com/ceph/ceph/pull/46665), Anthony
    D\'Atri)
-   doc/start: rewrite CRUSH para
    ([pr#46658](https://github.com/ceph/ceph/pull/46658), Zac Dover)
-   doc/start: rewrite hardware-recs networks section
    ([pr#46652](https://github.com/ceph/ceph/pull/46652), Zac Dover)
-   doc/start: update documenting-ceph branch names
    ([pr#47955](https://github.com/ceph/ceph/pull/47955), Zac Dover)
-   doc/start: update hardware recs
    ([pr#47123](https://github.com/ceph/ceph/pull/47123), Zac Dover)
-   doc: update docs for centralized logging
    ([pr#46946](https://github.com/ceph/ceph/pull/46946), Aashish
    Sharma)
-   doc: Update release process doc to accurately reflect current
    process ([pr#47837](https://github.com/ceph/ceph/pull/47837), David
    Galloway)
-   docs: fix doc link pointing to master in dashboard.rst
    ([pr#47789](https://github.com/ceph/ceph/pull/47789), Nizamudeen A)
-   exporter: per node metric exporter
    ([pr#47629](https://github.com/ceph/ceph/pull/47629), Pere Diaz Bou,
    Avan Thakkar)
-   include/buffer: include \<memory\>
    ([pr#47694](https://github.com/ceph/ceph/pull/47694), Kefu Chai)
-   install-deps.sh: do not install libpmem from chacra
    ([pr#46900](https://github.com/ceph/ceph/pull/46900), Kefu Chai)
-   install-deps: script exit on /ValueError: in centos_stream8
    ([pr#47892](https://github.com/ceph/ceph/pull/47892), Nizamudeen A)
-   libcephfs: define AT_NO_ATTR_SYNC back for backward compatibility
    ([pr#47861](https://github.com/ceph/ceph/pull/47861), Xiubo Li)
-   libcephsqlite: ceph-mgr crashes when compiled with gcc12
    ([pr#47270](https://github.com/ceph/ceph/pull/47270), Ganesh Maharaj
    Mahalingam)
-   librados: rados_ioctx_destroy check for initialized ioctx
    ([pr#47452](https://github.com/ceph/ceph/pull/47452), Nitzan
    Mordechai)
-   librbd/cache/pwl: narrow the scope of m_lock in
    write_image_cache_state()
    ([pr#47940](https://github.com/ceph/ceph/pull/47940), Ilya Dryomov,
    Yin Congmin)
-   librbd: bail from schedule_request_lock() if already lock owner
    ([pr#47162](https://github.com/ceph/ceph/pull/47162), Christopher
    Hoffman)
-   librbd: retry ENOENT in V2_REFRESH_PARENT as well
    ([pr#47996](https://github.com/ceph/ceph/pull/47996), Ilya Dryomov)
-   librbd: tweak misleading \"image is still primary\" error message
    ([pr#47248](https://github.com/ceph/ceph/pull/47248), Ilya Dryomov)
-   librbd: unlink newest mirror snapshot when at capacity, bump
    capacity ([pr#46594](https://github.com/ceph/ceph/pull/46594), Ilya
    Dryomov)
-   librbd: update progress for non-existent objects on deep-copy
    ([pr#46910](https://github.com/ceph/ceph/pull/46910), Ilya Dryomov)
-   librbd: use actual monitor addresses when creating a peer bootstrap
    token ([pr#47912](https://github.com/ceph/ceph/pull/47912), Ilya
    Dryomov)
-   mds: clear MDCache::rejoin\_\*\_q queues before recovering file
    inodes ([pr#46681](https://github.com/ceph/ceph/pull/46681), Xiubo
    Li)
-   mds: do not assert early on when issuing client leases
    ([issue#54701](http://tracker.ceph.com/issues/54701),
    [pr#46566](https://github.com/ceph/ceph/pull/46566), Venky Shankar)
-   mds: Don\'t blocklist clients in any replay state
    ([pr#47110](https://github.com/ceph/ceph/pull/47110), Kotresh HR)
-   mds: fix crash when exporting unlinked dir
    ([pr#47181](https://github.com/ceph/ceph/pull/47181), 胡玮文)
-   mds: flush mdlog if locked and still has wanted caps not satisfied
    ([pr#46494](https://github.com/ceph/ceph/pull/46494), Xiubo Li)
-   mds: notify the xattr_version to replica MDSes
    ([pr#47057](https://github.com/ceph/ceph/pull/47057), Xiubo Li)
-   mds: skip fetching the dirfrags if not a directory
    ([pr#47432](https://github.com/ceph/ceph/pull/47432), Xiubo Li)
-   mds: standby-replay daemon always removed in
    MDSMonitor::prepare_beacon
    ([pr#47281](https://github.com/ceph/ceph/pull/47281), Patrick
    Donnelly)
-   mds: switch to use projected inode instead
    ([pr#47058](https://github.com/ceph/ceph/pull/47058), Xiubo Li)
-   mgr, mon: Keep upto date metadata with mgr for MONs
    ([pr#46559](https://github.com/ceph/ceph/pull/46559), Laura Flores,
    Prashant D)
-   mgr/cephadm: Add disk rescan feature to the orchestrator
    ([pr#47311](https://github.com/ceph/ceph/pull/47311), Adam King,
    Paul Cuzner)
-   mgr/cephadm: add parsing for config on osd specs
    ([pr#47268](https://github.com/ceph/ceph/pull/47268), Luis
    Domingues)
-   mgr/cephadm: Adding logic to store grafana cert/key per node
    ([pr#47950](https://github.com/ceph/ceph/pull/47950), Redouane
    Kachach)
-   mgr/cephadm: allow binding to loopback for rgw daemons
    ([pr#47951](https://github.com/ceph/ceph/pull/47951), Redouane
    Kachach)
-   mgr/cephadm: capture exception when not able to list upgrade tags
    ([pr#46783](https://github.com/ceph/ceph/pull/46783), Redouane
    Kachach)
-   mgr/cephadm: check for events key before accessing it
    ([pr#47317](https://github.com/ceph/ceph/pull/47317), Redouane
    Kachach)
-   mgr/cephadm: check if a service exists before trying to restart it
    ([pr#46789](https://github.com/ceph/ceph/pull/46789), Redouane
    Kachach)
-   mgr/cephadm: clear error message when resuming upgrade
    ([pr#47373](https://github.com/ceph/ceph/pull/47373), Adam King)
-   mgr/cephadm: don\'t try to write client/os tuning profiles to known
    offline hosts ([pr#47953](https://github.com/ceph/ceph/pull/47953),
    Adam King)
-   mgr/cephadm: fix handling of draining hosts with explicit placement
    specs ([pr#47657](https://github.com/ceph/ceph/pull/47657), Adam
    King)
-   mgr/cephadm: Fix how we check if a host belongs to public network
    ([pr#47946](https://github.com/ceph/ceph/pull/47946), Redouane
    Kachach)
-   mgr/cephadm: fix the loki address in grafana, promtail configuration
    files ([pr#47171](https://github.com/ceph/ceph/pull/47171),
    jinhong.kim)
-   mgr/cephadm: fixing scheduler consistent hashing
    ([pr#47073](https://github.com/ceph/ceph/pull/47073), Redouane
    Kachach)
-   mgr/cephadm: limiting ingress/keepalived pass to 8 chars
    ([pr#47070](https://github.com/ceph/ceph/pull/47070), Redouane
    Kachach)
-   mgr/cephadm: recreate osd config when redeploy/reconfiguring
    ([pr#47659](https://github.com/ceph/ceph/pull/47659), Adam King)
-   mgr/cephadm: set dashboard grafana-api-password when user provides
    one ([pr#47658](https://github.com/ceph/ceph/pull/47658), Adam King)
-   mgr/cephadm: store device info separately from rest of host cache
    ([pr#46791](https://github.com/ceph/ceph/pull/46791), Adam King)
-   mgr/cephadm: support for miscellaneous config files for daemons
    ([pr#47312](https://github.com/ceph/ceph/pull/47312), Adam King)
-   mgr/cephadm: support for os tuning profiles
    ([pr#47316](https://github.com/ceph/ceph/pull/47316), Adam King)
-   mgr/cephadm: try to get FQDN for active instance
    ([pr#46793](https://github.com/ceph/ceph/pull/46793), Tatjana
    Dehler)
-   mgr/cephadm: use host shortname for osd memory autotuning
    ([pr#47075](https://github.com/ceph/ceph/pull/47075), Adam King)
-   mgr/dashboard: Add daemon logs tab to Logs component
    ([pr#46807](https://github.com/ceph/ceph/pull/46807), Aashish
    Sharma)
-   mgr/dashboard: add flag to automatically deploy loki/promtail
    service at bootstrap
    ([pr#47623](https://github.com/ceph/ceph/pull/47623), Aashish
    Sharma)
-   mgr/dashboard: add required validation for frontend and monitor port
    ([pr#47356](https://github.com/ceph/ceph/pull/47356), Avan Thakkar)
-   mgr/dashboard: added pattern validaton for form input
    ([pr#47329](https://github.com/ceph/ceph/pull/47329), Pedro Gonzalez
    Gomez)
-   mgr/dashboard: BDD approach for the dashboard cephadm e2e
    ([pr#46528](https://github.com/ceph/ceph/pull/46528), Nizamudeen A)
-   mgr/dashboard: bump moment from 2.29.1 to 2.29.3 in
    /src/pybind/mgr/dashboard/frontend
    ([pr#46718](https://github.com/ceph/ceph/pull/46718),
    dependabot\[bot\])
-   mgr/dashboard: bump up teuthology
    ([pr#47498](https://github.com/ceph/ceph/pull/47498), Kefu Chai)
-   mgr/dashboard: dashboard help command showing wrong syntax for
    login-banner ([pr#46809](https://github.com/ceph/ceph/pull/46809),
    Sarthak0702)
-   mgr/dashboard: display helpfull message when the iframe-embedded
    Grafana dashboard failed to load
    ([pr#47007](https://github.com/ceph/ceph/pull/47007), Ngwa Sedrick
    Meh)
-   mgr/dashboard: do not recommend throughput for ssd\'s only cluster
    ([pr#47156](https://github.com/ceph/ceph/pull/47156), Nizamudeen A)
-   mgr/dashboard: don\'t log tracebacks on 404s
    ([pr#47094](https://github.com/ceph/ceph/pull/47094), Ernesto
    Puerta)
-   mgr/dashboard: enable addition of custom Prometheus alerts
    ([pr#47942](https://github.com/ceph/ceph/pull/47942), Patrick
    Seidensal)
-   mgr/dashboard: ensure limit 0 returns 0 images
    ([pr#47887](https://github.com/ceph/ceph/pull/47887), Pere Diaz Bou)
-   mgr/dashboard: Feature 54330 osd creation workflow
    ([pr#46686](https://github.com/ceph/ceph/pull/46686), Pere Diaz Bou,
    Nizamudeen A, Sarthak0702)
-   mgr/dashboard: fix \_rbd_image_refs caching
    ([pr#47635](https://github.com/ceph/ceph/pull/47635), Pere Diaz Bou)
-   mgr/dashboard: fix nfs exports form issues with squash field
    ([pr#47961](https://github.com/ceph/ceph/pull/47961), Nizamudeen A)
-   mgr/dashboard: fix unmanaged service creation
    ([pr#48025](https://github.com/ceph/ceph/pull/48025), Nizamudeen A)
-   mgr/dashboard: grafana frontend e2e testing and update cypress
    ([pr#47703](https://github.com/ceph/ceph/pull/47703), Nizamudeen A)
-   mgr/dashboard: Hide maintenance option on expand cluster
    ([pr#47724](https://github.com/ceph/ceph/pull/47724), Nizamudeen A)
-   mgr/dashboard: host list tables doesn\'t show all services deployed
    ([pr#47453](https://github.com/ceph/ceph/pull/47453), Avan Thakkar)
-   mgr/dashboard: Improve monitoring tabs content
    ([pr#46990](https://github.com/ceph/ceph/pull/46990), Aashish
    Sharma)
-   mgr/dashboard: ingress backend service should list all supported
    services ([pr#47085](https://github.com/ceph/ceph/pull/47085), Avan
    Thakkar)
-   mgr/dashboard: iops optimized option enabled
    ([pr#46819](https://github.com/ceph/ceph/pull/46819), Pere Diaz Bou)
-   mgr/dashboard: iterate through copy of items
    ([pr#46871](https://github.com/ceph/ceph/pull/46871), Pedro Gonzalez
    Gomez)
-   mgr/dashboard: prevent alert redirect
    ([pr#47146](https://github.com/ceph/ceph/pull/47146), Tatjana
    Dehler)
-   mgr/dashboard: rbd image pagination
    ([pr#47104](https://github.com/ceph/ceph/pull/47104), Pere Diaz Bou,
    Nizamudeen A)
-   mgr/dashboard: rbd striping setting pre-population and pop-over
    ([pr#47409](https://github.com/ceph/ceph/pull/47409), Vrushal
    Chaudhari)
-   mgr/dashboard: rbd-mirror batch backport
    ([pr#46532](https://github.com/ceph/ceph/pull/46532), Pedro Gonzalez
    Gomez, Pere Diaz Bou, Nizamudeen A, Melissa Li, Sarthak0702, Avan
    Thakkar, Aashish Sharma)
-   mgr/dashboard: remove token logging
    ([pr#47430](https://github.com/ceph/ceph/pull/47430), Pere Diaz Bou)
-   mgr/dashboard: Show error on creating service with duplicate service
    id ([pr#47403](https://github.com/ceph/ceph/pull/47403), Aashish
    Sharma)
-   mgr/dashboard: stop polling when page is not visible
    ([pr#46672](https://github.com/ceph/ceph/pull/46672), Sarthak0702)
-   mgr/dashboard:Get different storage class metrics in Prometheus
    dashboard ([pr#47201](https://github.com/ceph/ceph/pull/47201),
    Aashish Sharma)
-   mgr/nfs: validate virtual_ip parameter
    ([pr#46794](https://github.com/ceph/ceph/pull/46794), Redouane
    Kachach)
-   mgr/orchestrator/tests: don\'t match exact whitespace in table
    output ([pr#47858](https://github.com/ceph/ceph/pull/47858), Adam
    King)
-   mgr/rook: fix error when trying to get the list of nfs services
    [pr#48199](https://github.com/ceph/ceph/pull/48199), Juan Miguel
    Olmo)
-   mgr/snap_schedule: replace .snap with the client configured snap dir
    name ([pr#47734](https://github.com/ceph/ceph/pull/47734), Milind
    Changire, Venky Shankar, Neeraj Pratap Singh)
-   mgr/snap_schedule: Use rados.Ioctx.remove_object() instead of
    remove() ([pr#48013](https://github.com/ceph/ceph/pull/48013),
    Andreas Teuchert)
-   mgr/telemetry: add [perf_memory_metrics]{.title-ref} collection to
    telemetry ([pr#47826](https://github.com/ceph/ceph/pull/47826),
    Laura Flores)
-   mgr/telemetry: handle daemons with complex ids
    ([pr#48283](https://github.com/ceph/ceph/pull/48283), Laura Flores)
-   mgr/telemetry: reset health warning after re-opting-in
    ([pr#47289](https://github.com/ceph/ceph/pull/47289), Yaarit Hatuka)
-   mgr/volumes: add interface to check the presence of
    subvolumegroups/subvolumes
    ([pr#47474](https://github.com/ceph/ceph/pull/47474), Neeraj Pratap
    Singh)
-   mgr/volumes: Add volume info command
    ([pr#47768](https://github.com/ceph/ceph/pull/47768), Neeraj Pratap
    Singh)
-   mgr/volumes: Few mgr volumes backports
    ([pr#47894](https://github.com/ceph/ceph/pull/47894), Rishabh Dave,
    Kotresh HR, Nikhilkumar Shelke)
-   mgr/volumes: filter internal directories in \'subvolumegroup ls\'
    command ([pr#47511](https://github.com/ceph/ceph/pull/47511),
    Nikhilkumar Shelke)
-   mgr/volumes: Fix subvolume creation in FIPS enabled system
    ([pr#47368](https://github.com/ceph/ceph/pull/47368), Kotresh HR)
-   mgr/volumes: prevent intermittent ParsingError failure in \"clone
    cancel\" ([pr#47747](https://github.com/ceph/ceph/pull/47747), John
    Mulligan)
-   mgr/volumes: remove incorrect \'size\' from output of \'snapshot
    info\' ([pr#46804](https://github.com/ceph/ceph/pull/46804),
    Nikhilkumar Shelke)
-   mgr/volumes: subvolume ls command crashes if groupname as
    \'\_nogroup\' ([pr#46805](https://github.com/ceph/ceph/pull/46805),
    Nikhilkumar Shelke)
-   mgr/volumes: subvolumegroup quotas
    ([pr#46667](https://github.com/ceph/ceph/pull/46667), Kotresh HR)
-   mgr: Define PY_SSIZE_T_CLEAN ahead of every Python.h
    ([pr#47616](https://github.com/ceph/ceph/pull/47616), Pete Zaitcev,
    Kefu Chai)
-   mgr: relax \"pending_service_map.epoch \> service_map.epoch\" assert
    ([pr#46738](https://github.com/ceph/ceph/pull/46738), Mykola Golub)
-   mirror snapshot schedule and trash purge schedule fixes
    ([pr#46781](https://github.com/ceph/ceph/pull/46781), Ilya Dryomov)
-   mon/ConfigMonitor: fix config get key with whitespace
    ([pr#47381](https://github.com/ceph/ceph/pull/47381), Nitzan
    Mordechai)
-   mon/Elector: notify_rank_removed erase rank from both live_pinging
    and dead_pinging sets for highest ranked MON
    ([pr#47086](https://github.com/ceph/ceph/pull/47086), Kamoltat)
-   mon/MDSMonitor: fix standby-replay mds being removed from MDSMap
    unexpectedly ([pr#47902](https://github.com/ceph/ceph/pull/47902),
    胡玮文)
-   mon/OSDMonitor: Ensure kvmon() is writeable before handling \"osd
    new\" cmd ([pr#46689](https://github.com/ceph/ceph/pull/46689),
    Sridhar Seshasayee)
-   monitoring/ceph-mixin: OSD overview typo fix
    ([pr#47387](https://github.com/ceph/ceph/pull/47387), Tatjana
    Dehler)
-   monitoring: ceph mixin backports
    ([pr#47867](https://github.com/ceph/ceph/pull/47867), Aswin Toni,
    Arthur Outhenin-Chalandre, Anthony D\'Atri, Tatjana Dehler)
-   msg: fix deadlock when handling existing but closed v2 connection
    ([pr#47930](https://github.com/ceph/ceph/pull/47930), Radosław
    Zarzyński)
-   msg: Fix Windows IPv6 support
    ([pr#47302](https://github.com/ceph/ceph/pull/47302), Lucian Petrut)
-   msg: Log at higher level when Throttle::get_or_fail() fails
    ([pr#47765](https://github.com/ceph/ceph/pull/47765), Brad Hubbard)
-   msg: reset ProtocolV2\'s frame assembler in appropriate thread
    ([pr#47931](https://github.com/ceph/ceph/pull/47931), Radoslaw
    Zarzynski)
-   os/bluestore: fix AU accounting in bluestore_cache_other mempool
    ([pr#47339](https://github.com/ceph/ceph/pull/47339), Igor Fedotov)
-   os/bluestore: Fix collision between BlueFS and BlueStore deferred
    writes ([pr#47297](https://github.com/ceph/ceph/pull/47297), Adam
    Kupczyk)
-   osd, mds: fix the \"heap\" admin cmd printing always to error stream
    ([pr#47825](https://github.com/ceph/ceph/pull/47825), Radoslaw
    Zarzynski)
-   osd, tools, kv: non-aggressive, on-line trimming of accumulated dups
    ([pr#47688](https://github.com/ceph/ceph/pull/47688), Radoslaw
    Zarzynski, Nitzan Mordechai)
-   osd/scrub: do not start scrubbing if the PG is snap-trimming
    ([pr#46498](https://github.com/ceph/ceph/pull/46498), Ronen
    Friedman)
-   osd/scrub: late-arriving reservation grants are not an error
    ([pr#46872](https://github.com/ceph/ceph/pull/46872), Ronen
    Friedman)
-   osd/scrub: Reintroduce scrub starts message
    ([pr#47621](https://github.com/ceph/ceph/pull/47621), Prashant D)
-   osd/scrubber/pg_scrubber.cc: fix bug where scrub machine gets stuck
    ([pr#46844](https://github.com/ceph/ceph/pull/46844), Cory Snyder)
-   osd/SnapMapper: fix legacy key conversion in snapmapper class
    ([pr#47133](https://github.com/ceph/ceph/pull/47133), Manuel Lausch,
    Matan Breizman)
-   osd: Handle oncommits and wait for future work items from mClock
    queue ([pr#47490](https://github.com/ceph/ceph/pull/47490), Sridhar
    Seshasayee)
-   osd: return ENOENT if pool information is invalid during tier-flush
    ([pr#47929](https://github.com/ceph/ceph/pull/47929), Myoungwon Oh)
-   osd: Set initial mClock QoS params at CONF_DEFAULT level
    ([pr#47020](https://github.com/ceph/ceph/pull/47020), Sridhar
    Seshasayee)
-   PendingReleaseNotes: Note the fix for high CPU utilization during
    recovery ([pr#48004](https://github.com/ceph/ceph/pull/48004),
    Sridhar Seshasayee)
-   pybind/mgr/cephadm/serve: don\'t remove ceph.conf which leads to qa
    failure ([pr#47072](https://github.com/ceph/ceph/pull/47072),
    Dhairya Parmar)
-   pybind/mgr/dashboard: do not use distutils.version.StrictVersion
    ([pr#47602](https://github.com/ceph/ceph/pull/47602), Kefu Chai)
-   pybind/mgr/pg_autoscaler: change overlapping roots to warning
    ([pr#47519](https://github.com/ceph/ceph/pull/47519), Kamoltat)
-   pybind/mgr: ceph osd status crash with ZeroDivisionError
    ([pr#46697](https://github.com/ceph/ceph/pull/46697), Nitzan
    Mordechai)
-   pybind/mgr: fix flake8
    ([pr#47391](https://github.com/ceph/ceph/pull/47391), Avan Thakkar)
-   python-common: allow crush device class to be set from osd service
    spec ([pr#46792](https://github.com/ceph/ceph/pull/46792), Cory
    Snyder)
-   qa/cephadm: specify using container host distros for workunits
    ([pr#47910](https://github.com/ceph/ceph/pull/47910), Adam King)
-   qa/cephfs: fallback to older way of get_op_read_count
    ([pr#46899](https://github.com/ceph/ceph/pull/46899), Dhairya
    Parmar)
-   qa/suites/rbd/pwl-cache: ensure recovery is actually tested
    ([pr#47129](https://github.com/ceph/ceph/pull/47129), Ilya Dryomov,
    Yin Congmin)
-   qa/suites/rbd: disable workunit timeout for
    dynamic_features_no_cache
    ([pr#47159](https://github.com/ceph/ceph/pull/47159), Ilya Dryomov)
-   qa/suites/rbd: place cache file on tmpfs for xfstests
    ([pr#46598](https://github.com/ceph/ceph/pull/46598), Ilya Dryomov)
-   qa/tasks/ceph_manager.py: increase test_pool_min_size timeout
    ([pr#47445](https://github.com/ceph/ceph/pull/47445), Kamoltat)
-   qa/workunits/cephadm: update test_repos master -\> main
    ([pr#47315](https://github.com/ceph/ceph/pull/47315), Adam King)
-   qa: wait rank 0 to become up:active state before mounting fuse
    client ([pr#46801](https://github.com/ceph/ceph/pull/46801), Xiubo
    Li)
-   quincy \-- sse s3 changes
    ([pr#46467](https://github.com/ceph/ceph/pull/46467), Casey Bodley,
    Marcus Watts, Priya Sehgal)
-   rbd-fuse: librados will filter out -r option from command-line
    ([pr#46954](https://github.com/ceph/ceph/pull/46954), wanwencong)
-   rbd-mirror: don\'t prune non-primary snapshot when restarting delta
    sync ([pr#46591](https://github.com/ceph/ceph/pull/46591), Ilya
    Dryomov)
-   rbd-mirror: generally skip replay/resync if remote image is not
    primary ([pr#46814](https://github.com/ceph/ceph/pull/46814), Ilya
    Dryomov)
-   rbd-mirror: remove bogus completed_non_primary_snapshots_exist check
    ([pr#47126](https://github.com/ceph/ceph/pull/47126), Ilya Dryomov)
-   rbd-mirror: resume pending shutdown on error in snapshot replayer
    ([pr#47914](https://github.com/ceph/ceph/pull/47914), Ilya Dryomov)
-   rbd: don\'t default empty pool name unless namespace is specified
    ([pr#47144](https://github.com/ceph/ceph/pull/47144), Ilya Dryomov)
-   rbd: find_action() should sort actions first
    ([pr#47584](https://github.com/ceph/ceph/pull/47584), Ilya Dryomov)
-   RGW - Swift retarget needs bucket set on object
    ([pr#46719](https://github.com/ceph/ceph/pull/46719), Daniel
    Gryniewicz)
-   rgw/backport/quincy: Fix crashes with Sync policy APIs
    ([pr#47993](https://github.com/ceph/ceph/pull/47993), Soumya Koduri)
-   rgw/dbstore: Fix build errors on centos9
    ([pr#46915](https://github.com/ceph/ceph/pull/46915), Soumya Koduri)
-   rgw: Avoid segfault when OPA authz is enabled
    ([pr#46107](https://github.com/ceph/ceph/pull/46107), Benoît Knecht)
-   rgw: better tenant id from the uri on anonymous access
    ([pr#47342](https://github.com/ceph/ceph/pull/47342), Rafał
    Wądołowski, Marcus Watts)
-   rgw: check object storage_class when check_disk_state
    ([pr#46580](https://github.com/ceph/ceph/pull/46580), Huber-ming)
-   rgw: data sync uses yield_spawn_window()
    ([pr#45714](https://github.com/ceph/ceph/pull/45714), Casey Bodley)
-   rgw: Fix data race in ChangeStatus
    ([pr#47195](https://github.com/ceph/ceph/pull/47195), Adam C.
    Emerson)
-   rgw: Guard against malformed bucket URLs
    ([pr#47191](https://github.com/ceph/ceph/pull/47191), Adam C.
    Emerson)
-   rgw: log access key id in ops logs
    ([pr#46624](https://github.com/ceph/ceph/pull/46624), Cory Snyder)
-   rgw: reopen ops log file on sighup
    ([pr#46625](https://github.com/ceph/ceph/pull/46625), Cory Snyder)
-   rgw_rest_user_policy: Fix GetUserPolicy & ListUserPolicies responses
    ([pr#47235](https://github.com/ceph/ceph/pull/47235), Sumedh A.
    Kulkarni)
-   rgwlc: fix segfault resharding during lc
    ([pr#46742](https://github.com/ceph/ceph/pull/46742), Mark Kogan)
-   script/build-integration-branch: add quincy to the list of releases
    ([pr#46361](https://github.com/ceph/ceph/pull/46361), Yuri
    Weinstein)
-   SimpleRADOSStriper: Avoid moving bufferlists by using deque in
    read() ([pr#47909](https://github.com/ceph/ceph/pull/47909), Matan
    Breizman)
-   src/mgr/DaemonServer.cc: fix typo in output gap \>=
    max_pg_num_change
    ([pr#47210](https://github.com/ceph/ceph/pull/47210), Kamoltat)
-   test/lazy-omap-stats: Various enhancements
    ([pr#47932](https://github.com/ceph/ceph/pull/47932), Brad Hubbard)
-   test/{librbd, rgw}: increase delay between and number of bind
    attempts ([pr#48023](https://github.com/ceph/ceph/pull/48023), Ilya
    Dryomov)
-   test/{librbd, rgw}: retry when bind fail with port 0
    ([pr#47980](https://github.com/ceph/ceph/pull/47980), Kefu Chai)
-   tooling: Change mrun to use bash
    ([pr#46076](https://github.com/ceph/ceph/pull/46076), Adam C.
    Emerson)
-   tools: ceph-objectstore-tool is able to trim pg log dups\' entries
    ([pr#46706](https://github.com/ceph/ceph/pull/46706), Radosław
    Zarzyński)
-   win32_deps_build.sh: master -\> main for wnbd
    ([pr#46763](https://github.com/ceph/ceph/pull/46763), Ilya Dryomov)

## v17.2.3 Quincy

This is a hotfix release that addresses a libcephsqlite crash in the
mgr.

### Notable Changes

-   A libcephsqlite bug that caused the mgr to crash repeatedly and die
    is now fixed. The bug was exposed due to 17.2.2 being built with gcc
    8.5.0-14, which contains a new patch to check for invalid regex.
    17.2.1 was built using gcc 8.5.0-13, which does not contain the
    invalid regex patch.

    Relevant tracker: <https://tracker.ceph.com/issues/55304>

    Relevant BZ: <https://bugzilla.redhat.com/show_bug.cgi?id=2110797>

### Changelog

-   libcephsqlite: ceph-mgr crashes when compiled with gcc12
    ([pr#47270](https://github.com/ceph/ceph/pull/47270), Ganesh Maharaj
    Mahalingam)

## v17.2.2 Quincy

This is a hotfix release that resolves two security flaws.

### Notable Changes

-   Users who were running OpenStack Manila to export native CephFS, who
    upgraded their Ceph cluster from Nautilus (or earlier) to a later
    major version, were vulnerable to an attack by malicious users. The
    vulnerability allowed users to obtain access to arbitrary portions
    of the CephFS filesystem hierarchy, instead of being properly
    restricted to their own subvolumes. The vulnerability is due to a
    bug in the \"volumes\" plugin in Ceph Manager. This plugin is
    responsible for managing Ceph File System subvolumes which are used
    by OpenStack Manila services as a way to provide shares to Manila
    users.

    With this hotfix, the vulnerability is fixed. Administrators who are
    concerned they may have been impacted should audit the CephX keys in
    their cluster for proper path restrictions.

    Again, this vulnerability only impacts OpenStack Manila clusters
    which provided native CephFS access to their users.

-   A regression made it possible to dereference a null pointer for for
    s3website requests that don\'t refer to a bucket resulting in an RGW
    segfault.

### Changelog

-   mgr/volumes: Fix subvolume discover during upgrade
    (`CVE-2022-0670`{.interpreted-text role="ref"}, Kotresh HR)
-   mgr/volumes: V2 Fix for
    test_subvolume_retain_snapshot_invalid_recreate
    (`CVE-2022-0670`{.interpreted-text role="ref"}, Kotresh HR)
-   qa: validate subvolume discover on upgrade (Kotresh HR)
-   rgw: s3website check for bucket before retargeting (Seena Fallah)

## v17.2.1 Quincy

This is the first bugfix release of Ceph Quincy.

### Notable Changes

-   The \"BlueStore zero block detection\" feature (first introduced to
    Quincy in <https://github.com/ceph/ceph/pull/43337>) has been turned
    off by default with a new global option called
    [bluestore_zero_block_detection]{.title-ref}. This feature, intended
    for large-scale synthetic testing, does not interact well with some
    RBD and CephFS features. Any side effects experienced in previous
    Quincy versions would no longer occur, provided that the config
    option remains set to false. Relevant tracker:
    <https://tracker.ceph.com/issues/55521>

-   telemetry: Added new Rook metrics to the \'basic\' channel to report
    Rook\'s version, Kubernetes version, node metrics, etc. See a sample
    report with [ceph telemetry preview]{.title-ref}. Opt-in with [ceph
    telemetry on]{.title-ref}.

    For more details, see:

    <https://docs.ceph.com/en/latest/mgr/telemetry/>

-   Add offline dup op trimming ability in the ceph-objectstore-tool.
    Relevant tracker: <https://tracker.ceph.com/issues/53729>

-   Fixes a bug with cluster logs not being populated after log
    rotation. Relevant tracker: <https://tracker.ceph.com/issues/55383>

### Changelog

-   .github/CODEOWNERS: tag core devs on core PRs
    ([pr#46519](https://github.com/ceph/ceph/pull/46519), Neha Ojha)
-   .github: continue on error and reorder milestone step
    ([pr#46447](https://github.com/ceph/ceph/pull/46447), Ernesto
    Puerta)
-   \[quincy\] mgr/alerts: Add Message-Id and Date header to sent emails
    ([pr#46311](https://github.com/ceph/ceph/pull/46311), Lorenz Bausch)
-   ceph-fuse: ignore fuse mount failure if path is already mounted
    ([pr#45939](https://github.com/ceph/ceph/pull/45939), Nikhilkumar
    Shelke)
-   ceph.in: clarify the usage of [\--format]{.title-ref} in the ceph
    command ([pr#46246](https://github.com/ceph/ceph/pull/46246), Laura
    Flores)
-   ceph.spec.in: disable annobin plugin if compile with gcc-toolset
    ([pr#46377](https://github.com/ceph/ceph/pull/46377), Kefu Chai)
-   ceph.spec.in: remove build directory at end of %install
    ([pr#45697](https://github.com/ceph/ceph/pull/45697), Tim Serong)
-   ceph.spec.in: Use libthrift-devel on SUSE distros
    ([pr#45700](https://github.com/ceph/ceph/pull/45700), Tim Serong)
-   ceph.spec: make ninja-build package install always
    ([pr#45875](https://github.com/ceph/ceph/pull/45875), Deepika
    Upadhyay)
-   Cephadm Batch Backport April
    ([pr#46055](https://github.com/ceph/ceph/pull/46055), Adam King,
    Lukas Mayer, Ken Dreyer, Redouane Kachach, Aashish Sharma, Avan
    Thakkar, Moritz Röhrich, Teoman ONAY, Melissa Li, Christoph
    Glaubitz, Guillaume Abrioux, wangyunqing, Joseph Sawaya, Matan
    Breizman, Pere Diaz Bou, Michael Fritch, Patrick C. F. Ernzer)
-   Cephadm Batch Backport May
    ([pr#46360](https://github.com/ceph/ceph/pull/46360), John Mulligan,
    Adam King, Prashant D, Redouane Kachach, Aashish Sharma, Ramana
    Raja, Ville Ojamo)
-   cephadm: infer the default container image during pull
    ([pr#45568](https://github.com/ceph/ceph/pull/45568), Michael
    Fritch)
-   cephadm: preserve [authorized_keys]{.title-ref} file during upgrade
    ([pr#45359](https://github.com/ceph/ceph/pull/45359), Michael
    Fritch)
-   cephadm: prometheus: The generatorURL in alerts is only using
    hostname ([pr#46353](https://github.com/ceph/ceph/pull/46353),
    Volker Theile)
-   cephfs-shell: fix put and get cmd
    ([pr#46300](https://github.com/ceph/ceph/pull/46300), Dhairya
    Parmar, dparmar18)
-   cephfs-top: Multiple filesystem support
    ([pr#46147](https://github.com/ceph/ceph/pull/46147), Neeraj Pratap
    Singh)
-   client: add option to disable collecting and sending metrics
    ([pr#46476](https://github.com/ceph/ceph/pull/46476), Xiubo Li)
-   cls/rgw: rgw_dir_suggest_changes detects race with completion
    ([pr#45901](https://github.com/ceph/ceph/pull/45901), Casey Bodley)
-   cmake/modules: always use the python3 specified in command line
    ([pr#45966](https://github.com/ceph/ceph/pull/45966), Kefu Chai)
-   cmake/rgw: add missing dependency on Arrow::Arrow
    ([pr#46144](https://github.com/ceph/ceph/pull/46144), Casey Bodley)
-   cmake: resurrect mutex debugging in all Debug builds
    ([pr#45913](https://github.com/ceph/ceph/pull/45913), Ilya Dryomov)
-   cmake: WITH_SYSTEM_UTF8PROC defaults to OFF
    ([pr#45766](https://github.com/ceph/ceph/pull/45766), Casey Bodley)
-   CODEOWNERS: add RBD team
    ([pr#46542](https://github.com/ceph/ceph/pull/46542), Ilya Dryomov)
-   debian: include the new object_format.py file
    ([pr#46409](https://github.com/ceph/ceph/pull/46409), John Mulligan)
-   doc/cephfs/add-remove-mds: added cephadm note, refined \"Adding an
    MDS\" ([pr#45879](https://github.com/ceph/ceph/pull/45879), Dhairya
    Parmar)
-   doc/dev: update basic-workflow.rst
    ([pr#46287](https://github.com/ceph/ceph/pull/46287), Zac Dover)
-   doc/mgr/dashboard: Fix typo and double slash missing from URL
    ([pr#46075](https://github.com/ceph/ceph/pull/46075), Ville Ojamo)
-   doc/start: add testing support information
    ([pr#45988](https://github.com/ceph/ceph/pull/45988), Zac Dover)
-   doc/start: s/3/three/ in intro.rst
    ([pr#46325](https://github.com/ceph/ceph/pull/46325), Zac Dover)
-   doc/start: update \"memory\" in hardware-recs.rst
    ([pr#46449](https://github.com/ceph/ceph/pull/46449), Zac Dover)
-   Implement CIDR blocklisting
    ([pr#46469](https://github.com/ceph/ceph/pull/46469), Jos Collin,
    Greg Farnum)
-   librbd/cache/pwl: fix bit field endianness issue
    ([pr#46094](https://github.com/ceph/ceph/pull/46094), Yin Congmin)
-   mds: add a perf counter to record slow replies
    ([pr#46156](https://github.com/ceph/ceph/pull/46156), haoyixing)
-   mds: include encoded stray inode when sending dentry unlink message
    to replicas ([issue#54046](http://tracker.ceph.com/issues/54046),
    [pr#46184](https://github.com/ceph/ceph/pull/46184), Venky Shankar)
-   mds: reset heartbeat when fetching or committing entries
    ([pr#46181](https://github.com/ceph/ceph/pull/46181), Xiubo Li)
-   mds: trigger to flush the mdlog in handle_find_ino()
    ([pr#46497](https://github.com/ceph/ceph/pull/46497), Xiubo Li)
-   mgr/cephadm: Adding python natsort module
    ([pr#46065](https://github.com/ceph/ceph/pull/46065), Redouane
    Kachach)
-   mgr/cephadm: try to get FQDN for configuration files
    ([pr#45665](https://github.com/ceph/ceph/pull/45665), Tatjana
    Dehler)
-   mgr/dashboard: don\'t log 3xx as errors
    ([pr#46453](https://github.com/ceph/ceph/pull/46453), Ernesto
    Puerta)
-   mgr/dashboard: Compare values of MTU alert by device
    ([pr#45814](https://github.com/ceph/ceph/pull/45814), Aashish
    Sharma, Patrick Seidensal)
-   mgr/dashboard: Creating and editing Prometheus AlertManager silences
    is buggy ([pr#46278](https://github.com/ceph/ceph/pull/46278),
    Volker Theile)
-   mgr/dashboard: customizable log-in page text/banner
    ([pr#46342](https://github.com/ceph/ceph/pull/46342), Sarthak0702)
-   mgr/dashboard: datatable in Cluster Host page hides wrong column on
    selection ([pr#45862](https://github.com/ceph/ceph/pull/45862),
    Sarthak0702)
-   mgr/dashboard: extend daemon actions to host details
    ([pr#45722](https://github.com/ceph/ceph/pull/45722), Aashish
    Sharma, Nizamudeen A)
-   mgr/dashboard: fix columns in host table with NaN Undefined
    ([pr#46446](https://github.com/ceph/ceph/pull/46446), Avan Thakkar)
-   mgr/dashboard: fix ssl cert validation for ingress service creation
    ([pr#46203](https://github.com/ceph/ceph/pull/46203), Avan Thakkar)
-   mgr/dashboard: fix wrong pg status processing
    ([pr#46229](https://github.com/ceph/ceph/pull/46229), Ernesto
    Puerta)
-   mgr/dashboard: form field validation icons overlap with other icons
    ([pr#46380](https://github.com/ceph/ceph/pull/46380), Sarthak0702)
-   mgr/dashboard: highlight the search text in cluster logs
    ([pr#45679](https://github.com/ceph/ceph/pull/45679), Sarthak0702)
-   mgr/dashboard: Imrove error message of \'/api/grafana/validation\'
    API endpoint ([pr#45957](https://github.com/ceph/ceph/pull/45957),
    Volker Theile)
-   mgr/dashboard: introduce memory and cpu usage for daemons
    ([pr#46220](https://github.com/ceph/ceph/pull/46220), Aashish
    Sharma, Avan Thakkar)
-   mgr/dashboard: Language dropdown box is partly hidden on login page
    ([pr#45619](https://github.com/ceph/ceph/pull/45619), Volker Theile)
-   mgr/dashboard: RGW users and buckets tables are empty if the
    selected gateway is down
    ([pr#45867](https://github.com/ceph/ceph/pull/45867), Volker Theile)
-   mgr/dashboard: Table columns hiding fix
    ([issue#51119](http://tracker.ceph.com/issues/51119),
    [pr#45724](https://github.com/ceph/ceph/pull/45724), Daniel Persson)
-   mgr/dashboard: unselect rows in datatables
    ([pr#46323](https://github.com/ceph/ceph/pull/46323), Sarthak0702)
-   mgr/dashboard: WDC multipath bug fixes
    ([pr#46455](https://github.com/ceph/ceph/pull/46455), Nizamudeen A)
-   mgr/stats: be resilient to offline MDS rank-0
    ([pr#45291](https://github.com/ceph/ceph/pull/45291), Jos Collin)
-   mgr/telemetry: add Rook data
    ([pr#46486](https://github.com/ceph/ceph/pull/46486), Yaarit Hatuka)
-   mgr/volumes: Fix idempotent subvolume rm
    ([pr#46140](https://github.com/ceph/ceph/pull/46140), Kotresh HR)
-   mgr/volumes: set, get, list and remove metadata of snapshot
    ([pr#46508](https://github.com/ceph/ceph/pull/46508), Nikhilkumar
    Shelke)
-   mgr/volumes: set, get, list and remove metadata of subvolume
    ([pr#45994](https://github.com/ceph/ceph/pull/45994), Nikhilkumar
    Shelke)
-   mgr/volumes: Show clone failure reason in clone status command
    ([pr#45927](https://github.com/ceph/ceph/pull/45927), Kotresh HR)
-   mon/LogMonitor: reopen log files on SIGHUP
    ([pr#46374](https://github.com/ceph/ceph/pull/46374), 胡玮文)
-   mon/OSDMonitor: properly set last_force_op_resend in stretch mode
    ([pr#45871](https://github.com/ceph/ceph/pull/45871), Ilya Dryomov)
-   mount/conf: Fix IPv6 parsing
    ([pr#46113](https://github.com/ceph/ceph/pull/46113), Matan
    Breizman)
-   os/bluestore: set upper and lower bounds on rocksdb omap iterators
    ([pr#46175](https://github.com/ceph/ceph/pull/46175), Adam Kupczyk,
    Cory Snyder)
-   os/bluestore: turn [bluestore zero block detection]{.title-ref} off
    by default ([pr#46468](https://github.com/ceph/ceph/pull/46468),
    Laura Flores)
-   osd/PGLog.cc: Trim duplicates by number of entries
    ([pr#46251](https://github.com/ceph/ceph/pull/46251), Nitzan
    Mordechai)
-   osd/scrub: ignoring unsolicited DigestUpdate events
    ([pr#45595](https://github.com/ceph/ceph/pull/45595), Ronen
    Friedman)
-   osd/scrub: restart snap trimming after a failed scrub
    ([pr#46418](https://github.com/ceph/ceph/pull/46418), Ronen
    Friedman)
-   osd: return appropriate error if the object is not manifest
    ([pr#46061](https://github.com/ceph/ceph/pull/46061), Myoungwon Oh)
-   qa/suites/rados/thrash-erasure-code-big/thrashers: add [osd max
    backfills]{.title-ref} setting to mapgap and pggrow
    ([pr#46384](https://github.com/ceph/ceph/pull/46384), Laura Flores)
-   qa/tasks/cephadm_cases: increase timeouts in test_cli.py
    ([pr#45625](https://github.com/ceph/ceph/pull/45625), Adam King)
-   qa: add filesystem/file sync stuck test support
    ([pr#46496](https://github.com/ceph/ceph/pull/46496), Xiubo Li)
-   qa: fix teuthology master branch ref
    ([pr#46503](https://github.com/ceph/ceph/pull/46503), Ernesto
    Puerta)
-   qa: remove .teuthology_branch file
    ([pr#46491](https://github.com/ceph/ceph/pull/46491), Jeff Layton)
-   Quincy: client: stop forwarding the request when exceeding 256 times
    ([pr#46178](https://github.com/ceph/ceph/pull/46178), Xiubo Li)
-   Quincy: Wip doc backport quincy release notes to quincy branch 2022
    05 24 ([pr#46381](https://github.com/ceph/ceph/pull/46381), Neha
    Ojha, David Galloway, Josh Durgin, Ilya Dryomov, Ernesto Puerta,
    Sridhar Seshasayee, Zac Dover, Yaarit Hatuka)
-   rbd persistent cache UX improvements (status report, metrics, flush
    command) ([pr#45896](https://github.com/ceph/ceph/pull/45896), Ilya
    Dryomov, Yin Congmin)
-   rgw: OpsLogFile::stop() signals under mutex
    ([pr#46038](https://github.com/ceph/ceph/pull/46038), Casey Bodley)
-   rgw: remove rgw_rados_pool_pg_num_min and its use on pool creation
    use the cluster defaults for pg_num_min
    ([pr#46234](https://github.com/ceph/ceph/pull/46234), Casey Bodley)
-   rgw: RGWCoroutine::set_sleeping() checks for null stack
    ([pr#46041](https://github.com/ceph/ceph/pull/46041), Or Friedmann,
    Casey Bodley)
-   rgw_reshard: drop olh entries with empty name
    ([pr#45846](https://github.com/ceph/ceph/pull/45846), Dan van der
    Ster)
-   rocksdb: build with rocksdb-7.y.z
    ([pr#46492](https://github.com/ceph/ceph/pull/46492), Kaleb S.
    KEITHLEY)
-   rpm: use system libpmem on Centos 9 Stream
    ([pr#46212](https://github.com/ceph/ceph/pull/46212), Ilya Dryomov)
-   run-make-check.sh: enable RBD persistent caches
    ([pr#45992](https://github.com/ceph/ceph/pull/45992), Ilya Dryomov)
-   test/rbd_mirror: grab timer lock before calling add_event_after()
    ([pr#45905](https://github.com/ceph/ceph/pull/45905), Ilya Dryomov)
-   test: fix TierFlushDuringFlush to wait until dedup_tier is set on
    base pool ([issue#53855](http://tracker.ceph.com/issues/53855),
    [pr#45624](https://github.com/ceph/ceph/pull/45624), Sungmin Lee)
-   test: No direct use of nose
    ([pr#46254](https://github.com/ceph/ceph/pull/46254), Steve Kowalik)
-   Wip doc pr 46109 backport to quincy
    ([pr#46116](https://github.com/ceph/ceph/pull/46116), Ville Ojamo)

## v17.2.0 Quincy

This is the first stable release of Ceph Quincy.

### Major Changes from Pacific

#### General

-   Filestore has been deprecated in Quincy. BlueStore is Ceph\'s
    default object store.

-   The [ceph-mgr-modules-core]{.title-ref} debian package no longer
    recommends [ceph-mgr-rook]{.title-ref}. [ceph-mgr-rook]{.title-ref}
    depends on [python3-numpy]{.title-ref}, which cannot be imported in
    different Python sub-interpreters multiple times when the version of
    [python3-numpy]{.title-ref} is older than 1.19. Because
    [apt-get]{.title-ref} installs the [Recommends]{.title-ref} packages
    by default, [ceph-mgr-rook]{.title-ref} was always installed along
    with the [ceph-mgr]{.title-ref} debian package as an indirect
    dependency. If your workflow depends on this behavior, you might
    want to install [ceph-mgr-rook]{.title-ref} separately.

-   The `device_health_metrics` pool has been renamed `.mgr`. It is now
    used as a common store for all `ceph-mgr` modules. After upgrading
    to Quincy, the `device_health_metrics` pool will be renamed to
    `.mgr` on existing clusters.

-   The `ceph pg dump` command now prints three additional columns:
    [LAST_SCRUB_DURATION]{.title-ref} shows the duration (in seconds) of
    the last completed scrub; [SCRUB_SCHEDULING]{.title-ref} conveys
    whether a PG is scheduled to be scrubbed at a specified time,
    whether it is queued for scrubbing, or whether it is being scrubbed;
    [OBJECTS_SCRUBBED]{.title-ref} shows the number of objects scrubbed
    in a PG after a scrub begins.

-   A health warning is now reported if the `require-osd-release` flag
    is not set to the appropriate release after a cluster upgrade.

-   LevelDB support has been removed. `WITH_LEVELDB` is no longer a
    supported build option. Users *should* migrate their monitors and
    OSDs to RocksDB before upgrading to Quincy.

-   Cephadm: `osd_memory_target_autotune` is enabled by default, which
    sets `mgr/cephadm/autotune_memory_target_ratio` to `0.7` of total
    RAM. This is unsuitable for hyperconverged infrastructures. For
    hyperconverged Ceph, please refer to the documentation or set
    `mgr/cephadm/autotune_memory_target_ratio` to `0.2`.

-   telemetry: Improved the opt-in flow so that users can keep sharing
    the same data, even when new data collections are available. A new
    \'perf\' channel that collects various performance metrics is now
    available for operators to opt into with: [ceph telemetry
    on]{.title-ref} [ceph telemetry enable channel perf]{.title-ref} See
    a sample report with [ceph telemetry preview]{.title-ref}. Note that
    generating a telemetry report with \'perf\' channel data might take
    a few moments in big clusters. For more details, see:
    <https://docs.ceph.com/en/quincy/mgr/telemetry/>

-   MGR: The progress module disables the pg recovery event by default
    since the event is expensive and has interrupted other services when
    there are OSDs being marked in/out from the cluster. However, the
    user can still enable this event anytime. For more detail, see:

    <https://docs.ceph.com/en/quincy/mgr/progress/>

-   <https://tracker.ceph.com/issues/55383> is a known issue -to
    continue to log cluster log messages to file, run [ceph config set
    mon mon_cluster_log_to_file true]{.title-ref} after every log
    rotation.

### Cephadm

-   SNMP Support
-   Colocation of Daemons (mgr, mds, rgw)
-   osd memory autotuning
-   Integration with new NFS mgr module
-   Ability to zap osds as they are removed
-   cephadm agent for increased performance/scalability

#### Dashboard

-   Day 1: the new \"Cluster Expansion Wizard\" will guide users through
    post-install steps: adding new hosts, storage devices or services.

-   NFS: the Dashboard now allows users to fully manage all NFS exports
    from a single place.

-   New mgr module (feedback): users can quickly report Ceph tracker
    issues or suggestions directly from the Dashboard or the CLI.

-   New \"Message of the Day\": cluster admins can publish a custom
    message in a banner.

-   

    Cephadm integration improvements:

    :   -   Host management: maintenance, specs and labelling,
        -   Service management: edit and display logs,
        -   Daemon management (start, stop, restart, reload),
        -   New services supported: ingress (HAProxy) and SNMP-gateway.

-   

    Monitoring and alerting:

    :   -   43 new alerts have been added (totalling 68) improving
            observability of events affecting: cluster health, monitors,
            storage devices, PGs and CephFS.
        -   Alerts can now be sent externally as SNMP traps via the new
            SNMP gateway service (the MIB is provided).
        -   Improved integrated full/nearfull event notifications.
        -   Grafana Dashboards now use grafonnet format (though they\'re
            still available in JSON format).
        -   Stack update: images for monitoring containers have been
            updated. Grafana 8.3.5, Prometheus 2.33.4, Alertmanager
            0.23.0 and Node Exporter 1.3.1. This reduced exposure to
            several Grafana vulnerabilities (CVE-2021-43798,
            CVE-2021-39226, CVE-2021-43798, CVE-2020-29510,
            CVE-2020-29511).

#### RADOS

-   OSD: Ceph now uses [mclock_scheduler]{.title-ref} for BlueStore OSDs
    as its default [osd_op_queue]{.title-ref} to provide QoS. The
    \'mclock_scheduler\' is not supported for Filestore OSDs. Therefore,
    the default \'osd_op_queue\' is set to [wpq]{.title-ref} for
    Filestore OSDs and is enforced even if the user attempts to change
    it. For more details on configuring mclock see,

    <https://docs.ceph.com/en/quincy/rados/configuration/mclock-config-ref/>

    An outstanding issue exists during runtime where the mclock config
    options related to reservation, weight and limit cannot be modified
    after switching to the [custom]{.title-ref} mclock profile using the
    [ceph config set \...]{.title-ref} command. This is tracked by:
    <https://tracker.ceph.com/issues/55153>. Until the issue is fixed,
    users are advised to avoid using the \'custom\' profile or use the
    workaround mentioned in the tracker.

-   MGR: The pg_autoscaler can now be turned [on]{.title-ref} and
    [off]{.title-ref} globally with the [noautoscale]{.title-ref} flag.
    By default, it is set to [on]{.title-ref}, but this flag can come in
    handy to prevent rebalancing triggered by autoscaling during cluster
    upgrade and maintenance. Pools can now be created with the
    [\--bulk]{.title-ref} flag, which allows the autoscaler to allocate
    more PGs to such pools. This can be useful to get better out of the
    box performance for data-heavy pools.

    For more details about autoscaling, see:
    <https://docs.ceph.com/en/quincy/rados/operations/placement-groups/>

-   OSD: Support for on-wire compression for osd-osd communication,
    [off]{.title-ref} by default.

    For more details about compression modes, see:
    <https://docs.ceph.com/en/quincy/rados/configuration/msgr2/#compression-modes>

-   OSD: Concise reporting of slow operations in the cluster log. The
    old and more verbose logging behavior can be regained by setting
    [osd_aggregated_slow_ops_logging]{.title-ref} to false.

-   the \"kvs\" Ceph object class is not packaged anymore. The \"kvs\"
    Ceph object class offers a distributed flat b-tree key-value store
    that is implemented on top of the librados objects omap. Because
    there are no existing internal users of this object class, it is not
    packaged anymore.

#### RBD block storage

-   rbd-nbd: [rbd device attach]{.title-ref} and [rbd device
    detach]{.title-ref} commands added, these allow for safe reattach
    after [rbd-nbd]{.title-ref} daemon is restarted since Linux kernel
    5.14.

-   rbd-nbd: [notrim]{.title-ref} map option added to support
    thick-provisioned images, similar to krbd.

-   Large stabilization effort for client-side persistent caching on SSD
    devices, also available in 16.2.8. For details on usage, see:

    <https://docs.ceph.com/en/quincy/rbd/rbd-persistent-write-log-cache/>

-   Several bug fixes in diff calculation when using fast-diff image
    feature + whole object (inexact) mode. In some rare cases these
    long-standing issues could cause an incorrect [rbd
    export]{.title-ref}. Also fixed in 15.2.16 and 16.2.8.

-   Fix for a potential performance degradation when running Windows VMs
    on krbd. For details, see [rxbounce]{.title-ref} map option
    description:

    <https://docs.ceph.com/en/quincy/man/8/rbd/#kernel-rbd-krbd-options>

#### RGW object storage

-   RGW now supports rate limiting by user and/or by bucket. With this
    feature it is possible to limit user and/or bucket, the total
    operations and/or bytes per minute can be delivered. This feature
    allows the admin to limit only READ operations and/or WRITE
    operations. The rate-limiting configuration could be applied on all
    users and all buckets by using global configuration.
-   [radosgw-admin realm delete]{.title-ref} has been renamed to
    [radosgw-admin realm rm]{.title-ref}. This is consistent with the
    help message.
-   S3 bucket notification events now contain an [eTag]{.title-ref} key
    instead of [etag]{.title-ref}, and eventName values no longer carry
    the [s3:]{.title-ref} prefix, fixing deviations from the message
    format that is observed on AWS.
-   It is possible to specify ssl options and ciphers for beast frontend
    now. The default ssl options setting is
    \"no_sslv2:no_sslv3:no_tlsv1:no_tlsv1_1\". If you want to return to
    the old behavior, add \'ssl_options=\' (empty) to the
    `rgw frontends` configuration.
-   The behavior for Multipart Upload was modified so that only
    CompleteMultipartUpload notification is sent at the end of the
    multipart upload. The POST notification at the beginning of the
    upload and the PUT notifications that were sent on each part are no
    longer sent.

#### CephFS distributed file system

-   fs: A file system can be created with a specific ID (\"fscid\").
    This is useful in certain recovery scenarios (for example, when a
    monitor database has been lost and rebuilt, and the restored file
    system is expected to have the same ID as before).
-   fs: A file system can be renamed using the [fs rename]{.title-ref}
    command. Any cephx credentials authorized for the old file system
    name will need to be reauthorized to the new file system name. Since
    the operations of the clients using these re-authorized IDs may be
    disrupted, this command requires the \"\--yes-i-really-mean-it\"
    flag. Also, mirroring is expected to be disabled on the file system.
-   MDS upgrades no longer require all standby MDS daemons to be stoped
    before upgrading a file systems\'s sole active MDS.
-   CephFS: Failure to replay the journal by a standby-replay daemon now
    causes the rank to be marked \"damaged\".

### Upgrading from Octopus or Pacific

Quincy does not support LevelDB. Please migrate your OSDs and monitors
to RocksDB before upgrading to Quincy.

Before starting, make sure your cluster is stable and healthy (no down
or recovering OSDs). (This is optional, but recommended.) You can
disable the autoscaler for all pools during the upgrade using the
noautoscale flag.

:::: note
::: title
Note
:::

You can monitor the progress of your upgrade at each stage with the
`ceph versions` command, which will tell you what ceph version(s) are
running for each type of daemon.
::::

#### Upgrading cephadm clusters

If your cluster is deployed with cephadm (first introduced in Octopus),
then the upgrade process is entirely automated. To initiate the upgrade,

> ::: prompt
> bash \#
>
> ceph orch upgrade start \--ceph-version 17.2.0
> :::

The same process is used to upgrade to future minor releases.

Upgrade progress can be monitored with `ceph -s` (which provides a
simple progress bar) or more verbosely with

> ::: prompt
> bash \#
>
> ceph -W cephadm
> :::

The upgrade can be paused or resumed with

> ::: prompt
> bash \#
>
> ceph orch upgrade pause \# to pause ceph orch upgrade resume \# to
> resume
> :::

or canceled with

> ::: prompt
> bash \#
>
> ceph orch upgrade stop
> :::

Note that canceling the upgrade simply stops the process; there is no
ability to downgrade back to Octopus or Pacific.

#### Upgrading non-cephadm clusters

:::: note
::: title
Note
:::

If you cluster is running Octopus (15.2.x) or later, you might choose to
first convert it to use cephadm so that the upgrade to Quincy is
automated (see above). For more information, see
`cephadm-adoption`{.interpreted-text role="ref"}.
::::

1.  Set the `noout` flag for the duration of the upgrade. (Optional, but
    recommended.):

    ::: prompt
    bash \#

    ceph osd set noout
    :::

2.  Upgrade monitors by installing the new packages and restarting the
    monitor daemons. For example, on each monitor host,:

    ::: prompt
    bash \#

    systemctl restart ceph-mon.target
    :::

    Once all monitors are up, verify that the monitor upgrade is
    complete by looking for the `quincy` string in the mon map. The
    command:

    ::: prompt
    bash \#

    ceph mon dump \| grep min_mon_release
    :::

    should report:

        min_mon_release 17 (quincy)

    If it doesn\'t, that implies that one or more monitors hasn\'t been
    upgraded and restarted and/or the quorum does not include all
    monitors.

3.  Upgrade `ceph-mgr` daemons by installing the new packages and
    restarting all manager daemons. For example, on each manager host,:

    ::: prompt
    bash \#

    systemctl restart ceph-mgr.target
    :::

    Verify the `ceph-mgr` daemons are running by checking `ceph -s`:

    ::: prompt
    bash \#

    ceph -s
    :::

        ...
          services:
           mon: 3 daemons, quorum foo,bar,baz
           mgr: foo(active), standbys: bar, baz
        ...

4.  Upgrade all OSDs by installing the new packages and restarting the
    ceph-osd daemons on all OSD hosts:

    ::: prompt
    bash \#

    systemctl restart ceph-osd.target
    :::

5.  Upgrade all CephFS MDS daemons. For each CephFS file system,

    1.  Disable standby_replay. Before executing, note the current value
        so that it may be re-enabled after the upgrade (if currently
        enabled):

        ::: prompt
        bash \#
        :::

    > ceph fs get \<fs_name\> \| grep allow_standby_replay ceph fs set
    > \<fs_name\> allow_standby_replay false

    1.  Reduce the number of ranks to 1. (Make note of the original
        number of MDS daemons first if you plan to restore it later.):

        ::: prompt
        bash \#
        :::

    > ceph fs status ceph fs set \<fs_name\> max_mds 1

    1.  Wait for the cluster to deactivate any non-zero ranks by
        periodically checking the status:

        ::: prompt
        bash \#
        :::

    > ceph fs status

    1.  Take all standby MDS daemons offline on the appropriate hosts
        with:

        ::: prompt
        bash \#
        :::

    > systemctl stop ceph-mds@\<daemon_name\>

    1.  Confirm that only one MDS is online and is rank 0 for your FS:

        ::: prompt
        bash \#
        :::

    > ceph fs status

    1.  Upgrade the last remaining MDS daemon by installing the new
        packages and restarting the daemon:

        ::: prompt
        bash \#

        systemctl restart ceph-mds.target
        :::

    2.  Restart all standby MDS daemons that were taken offline:

        ::: prompt
        bash \#
        :::

    > systemctl start ceph-mds.target

    1.  Restore the original value of `max_mds` for the volume:

        ::: prompt
        bash \#
        :::

    > ceph fs set \<fs_name\> max_mds \<original_max_mds\>
    >
    > #\. Restore the original value of `allow_standby_replay` for the volume if
    >
    > :   it was `true`:
    >
    >     ::: prompt
    >     bash \#
    >     :::
    >
    > ceph fs set \<fs_name\> allow_standby_replay true

6.  Upgrade all radosgw daemons by upgrading packages and restarting
    daemons on all hosts:

    ::: prompt
    bash \#

    systemctl restart ceph-radosgw.target
    :::

7.  Complete the upgrade by disallowing pre-Quincy OSDs and enabling all
    new Quincy-only functionality:

    ::: prompt
    bash \#

    ceph osd require-osd-release quincy
    :::

8.  If you set `noout` at the beginning, be sure to clear it with:

    ::: prompt
    bash \#

    ceph osd unset noout
    :::

9.  Consider transitioning your cluster to use the cephadm deployment
    and orchestration framework to simplify cluster management and
    future upgrades. For more information on converting an existing
    cluster to cephadm, see `cephadm-adoption`{.interpreted-text
    role="ref"}.

#### Post-upgrade

1.  Verify the cluster is healthy with `ceph health`. If your cluster is
    running Filestore, a deprecation warning is expected. This warning
    can be temporarily muted using the following command:

    ::: prompt
    bash \#

    ceph health mute OSD_FILESTORE
    :::

2.  If you are upgrading from Mimic, or did not already do so when you
    upgraded to Nautilus, we recommend you enable the new `v2
    network protocol <msgr2>`{.interpreted-text role="ref"}, issue the
    following command:

    ::: prompt
    bash \#

    ceph mon enable-msgr2
    :::

    This will instruct all monitors that bind to the old default port
    6789 for the legacy v1 protocol to also bind to the new 3300 v2
    protocol port. To see if all monitors have been updated, run this:

    ::: prompt
    bash \#

    ceph mon dump
    :::

    and verify that each monitor has both a `v2:` and `v1:` address
    listed.

3.  Consider enabling the
    `telemetry module <telemetry>`{.interpreted-text role="ref"} to send
    anonymized usage statistics and crash information to the Ceph
    upstream developers. To see what would be reported (without actually
    sending any information to anyone),:

    ::: prompt
    bash \#

    ceph telemetry preview-all
    :::

    If you are comfortable with the data that is reported, you can
    opt-in to automatically report the high-level cluster metadata with:

    ::: prompt
    bash \#

    ceph telemetry on
    :::

    The public dashboard that aggregates Ceph telemetry can be found at
    <https://telemetry-public.ceph.com/>.

    For more information about the telemetry module, see `the
    documentation <telemetry>`{.interpreted-text role="ref"}.

### Upgrading from pre-Octopus releases (like Nautilus)

You *must* first upgrade to Octopus (15.2.z) or Pacific (16.2.z) before
upgrading to Quincy.

# `zfs` {#ceph-volume-zfs}

Implements the functionality needed to deploy OSDs from the `zfs`
subcommand: `ceph-volume zfs`

The current implementation only works for ZFS on FreeBSD

**Command Line Subcommands**

-   `ceph-volume-zfs-inventory`{.interpreted-text role="ref"}

**Internal functionality**

There are other aspects of the `zfs` subcommand that are internal and
not exposed to the user, these sections explain how these pieces work
together, clarifying the workflows of the tool.

`zfs <ceph-volume-zfs-api>`{.interpreted-text role="ref"}

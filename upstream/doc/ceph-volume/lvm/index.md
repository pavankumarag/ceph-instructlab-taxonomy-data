# `lvm` {#ceph-volume-lvm}

Implements the functionality needed to deploy OSDs from the `lvm`
subcommand: `ceph-volume lvm`

**Command Line Subcommands**

-   `ceph-volume-lvm-prepare`{.interpreted-text role="ref"}
-   `ceph-volume-lvm-activate`{.interpreted-text role="ref"}
-   `ceph-volume-lvm-create`{.interpreted-text role="ref"}
-   `ceph-volume-lvm-list`{.interpreted-text role="ref"}
-   `ceph-volume-lvm-migrate`{.interpreted-text role="ref"}
-   `ceph-volume-lvm-newdb`{.interpreted-text role="ref"}
-   `ceph-volume-lvm-newwal`{.interpreted-text role="ref"}

**Internal functionality**

There are other aspects of the `lvm` subcommand that are internal and
not exposed to the user, these sections explain how these pieces work
together, clarifying the workflows of the tool.

`Systemd Units <ceph-volume-lvm-systemd>`{.interpreted-text role="ref"}
\| `lvm <ceph-volume-lvm-api>`{.interpreted-text role="ref"}

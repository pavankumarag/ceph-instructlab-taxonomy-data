# ceph-volume

Deploy OSDs with different device technologies like lvm or physical
disks using pluggable tools (`lvm/index`{.interpreted-text role="doc"}
itself is treated like a plugin) and trying to follow a predictable, and
robust way of preparing, activating, and starting OSDs.

`Overview <ceph-volume-overview>`{.interpreted-text role="ref"} \|
`Plugin Guide <ceph-volume-plugins>`{.interpreted-text role="ref"} \|

**Command Line Subcommands**

There is currently support for `lvm`, and plain disks (with GPT
partitions) that may have been deployed with `ceph-disk`.

`zfs` support is available for running a FreeBSD cluster.

-   `ceph-volume-lvm`{.interpreted-text role="ref"}
-   `ceph-volume-simple`{.interpreted-text role="ref"}
-   `ceph-volume-zfs`{.interpreted-text role="ref"}

**Node inventory**

The `ceph-volume-inventory`{.interpreted-text role="ref"} subcommand
provides information and metadata about a nodes physical disk inventory.

## Migrating

Starting on Ceph version 13.0.0, `ceph-disk` is deprecated. Deprecation
warnings will show up that will link to this page. It is strongly
suggested that users start consuming `ceph-volume`. There are two paths
for migrating:

1.  Keep OSDs deployed with `ceph-disk`: The
    `ceph-volume-simple`{.interpreted-text role="ref"} command provides
    a way to take over the management while disabling `ceph-disk`
    triggers.
2.  Redeploy existing OSDs with `ceph-volume`: This is covered in depth
    on `rados-replacing-an-osd`{.interpreted-text role="ref"}

For details on why `ceph-disk` was removed please see the `Why was
ceph-disk replaced? <ceph-disk-replaced>`{.interpreted-text role="ref"}
section.

### New deployments

For new deployments, `ceph-volume-lvm`{.interpreted-text role="ref"} is
recommended, it can use any logical volume as input for data OSDs, or it
can setup a minimal/naive logical volume from a device.

### Existing OSDs

If the cluster has OSDs that were provisioned with `ceph-disk`, then
`ceph-volume` can take over the management of these with
`ceph-volume-simple`{.interpreted-text role="ref"}. A scan is done on
the data device or OSD directory, and `ceph-disk` is fully disabled.
Encryption is fully supported.

::: {.toctree hidden="" maxdepth="3" caption="Contents:"}
intro systemd inventory drive-group lvm/index lvm/activate lvm/batch
lvm/encryption lvm/prepare lvm/create lvm/scan lvm/systemd lvm/list
lvm/zap lvm/migrate lvm/newdb lvm/newwal simple/index simple/activate
simple/scan simple/systemd zfs/index zfs/inventory
:::

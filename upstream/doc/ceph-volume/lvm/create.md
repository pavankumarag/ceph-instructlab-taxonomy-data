# `create` {#ceph-volume-lvm-create}

This subcommand wraps the two-step process to provision a new osd
(calling `prepare` first and then `activate`) into a single one. The
reason to prefer `prepare` and then `activate` is to gradually introduce
new OSDs into a cluster, and avoiding large amounts of data being
rebalanced.

The single-call process unifies exactly what
`ceph-volume-lvm-prepare`{.interpreted-text role="ref"} and
`ceph-volume-lvm-activate`{.interpreted-text role="ref"} do, with the
convenience of doing it all at once.

There is nothing different to the process except the OSD will become up
and in immediately after completion.

The backing objectstore can be specified with:

-   `--bluestore <ceph-volume-lvm-prepare_bluestore>`{.interpreted-text
    role="ref"}

All command line flags and options are the same as
`ceph-volume lvm prepare`. Please refer to
`ceph-volume-lvm-prepare`{.interpreted-text role="ref"} for details.

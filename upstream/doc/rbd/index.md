# Ceph Block Device

::: index
Ceph Block Device; introduction
:::

A block is a sequence of bytes (often 512). Block-based storage
interfaces are a mature and common way to store data on media including
HDDs, SSDs, CDs, floppy disks, and even tape. The ubiquity of block
device interfaces is a perfect fit for interacting with mass data
storage including Ceph.

Ceph block devices are thin-provisioned, resizable, and store data
striped over multiple OSDs. Ceph block devices leverage
`RADOS (Reliable Autonomic Distributed Object Store)`{.interpreted-text
role="abbr"} capabilities including snapshotting, replication and strong
consistency. Ceph block storage clients communicate with Ceph clusters
through kernel modules or the `librbd` library.

::: ditaa
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ \| Kernel Module \| \|
librbd \|
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+-+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| RADOS Protocol \|
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+-+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
\| OSDs \| \| Monitors \|
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
:::

:::: note
::: title
Note
:::

Kernel modules can use Linux page caching. For `librbd`-based
applications, Ceph supports [RBD Caching](./rbd-config-ref/).
::::

Ceph\'s block devices deliver high performance with vast scalability to
[kernel modules](./rbd-ko/), or to
`KVMs (kernel virtual machines)`{.interpreted-text role="abbr"} such as
[QEMU](./qemu-rbd/), and cloud-based computing systems like
[OpenStack](./rbd-openstack),
[OpenNebula](https://docs.opennebula.io/stable/open_cluster_deployment/storage_setup/ceph_ds.html)
and [CloudStack](./rbd-cloudstack) that rely on libvirt and QEMU to
integrate with Ceph block devices. You can use the same cluster to
operate the `Ceph RADOS Gateway <object-gateway>`{.interpreted-text
role="ref"}, the `Ceph File System <ceph-file-system>`{.interpreted-text
role="ref"}, and Ceph block devices simultaneously.

:::: important
::: title
Important
:::

To use Ceph Block Devices, you must have access to a running Ceph
cluster.
::::

::: {.toctree maxdepth="1"}
Basic Commands \<rados-rbd-cmds\>
:::

::: {.toctree maxdepth="2"}
Operations \<rbd-operations\>
:::

::: {.toctree maxdepth="2"}
Integrations \<rbd-integrations\>
:::

::: {.toctree maxdepth="2"}
Manpages \<man/index\>
:::

::: {.toctree maxdepth="2"}
APIs \<api/index\>
:::

# Ceph Storage Cluster {#rados-index}

The `Ceph Storage Cluster`{.interpreted-text role="term"} is the
foundation for all Ceph deployments. Based upon
`RADOS (Reliable Autonomic Distributed Object Store)`{.interpreted-text
role="abbr"}, Ceph Storage Clusters consist of several types of daemons:

> 1.  a `Ceph OSD Daemon`{.interpreted-text role="term"} (OSD) stores
>     data as objects on a storage node
> 2.  a `Ceph Monitor`{.interpreted-text role="term"} (MON) maintains a
>     master copy of the cluster map.
> 3.  a `Ceph Manager`{.interpreted-text role="term"} manager daemon

A Ceph Storage Cluster might contain thousands of storage nodes. A
minimal system has at least one Ceph Monitor and two Ceph OSD Daemons
for data replication.

The Ceph File System, Ceph Object Storage and Ceph Block Devices read
data from and write data to the Ceph Storage Cluster.

::::::::::: {.container .columns-3}
:::: {.container .column}
<h3>Config and Deploy</h3>

Ceph Storage Clusters have a few required settings, but most
configuration settings have default values. A typical deployment uses a
deployment tool to define a cluster and bootstrap a monitor. See
`cephadm`{.interpreted-text role="ref"} for details.

::: {.toctree maxdepth="2"}
Configuration \<configuration/index\>
:::
::::

:::::: {.container .column}
<h3>Operations</h3>

Once you have deployed a Ceph Storage Cluster, you may begin operating
your cluster.

::: {.toctree maxdepth="2"}
Operations \<operations/index\>
:::

::: {.toctree maxdepth="1"}
Man Pages \<man/index\>
:::

::: {.toctree hidden=""}
troubleshooting/index
:::
::::::

:::: {.container .column}
<h3>APIs</h3>

Most Ceph deployments use [Ceph Block Devices](../rbd/), [Ceph Object
Storage](../radosgw/) and/or the [Ceph File System](../cephfs/). You may
also develop applications that talk directly to the Ceph Storage
Cluster.

::: {.toctree maxdepth="2"}
APIs \<api/index\>
:::
::::
:::::::::::

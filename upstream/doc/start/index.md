# Intro to Ceph

Ceph can be used to provide `Ceph Object Storage`{.interpreted-text
role="term"} to `Cloud
Platforms`{.interpreted-text role="term"} and Ceph can be used to
provide `Ceph Block Device`{.interpreted-text role="term"} services to
`Cloud Platforms`{.interpreted-text role="term"}. Ceph can be used to
deploy a `Ceph File
System`{.interpreted-text role="term"}. All
`Ceph Storage Cluster`{.interpreted-text role="term"} deployments begin
with setting up each `Ceph Node`{.interpreted-text role="term"} and then
setting up the network.

A Ceph Storage Cluster requires the following: at least one Ceph Monitor
and at least one Ceph Manager, and at least as many `Ceph Object Storage
Daemon<Ceph OSD>`{.interpreted-text role="term"}s (OSDs) as there are
copies of a given object stored in the Ceph cluster (for example, if
three copies of a given object are stored in the Ceph cluster, then at
least three OSDs must exist in that Ceph cluster).

The Ceph Metadata Server is necessary to run Ceph File System clients.

:::: note
::: title
Note
:::

It is a best practice to have a Ceph Manager for each Monitor, but it is
not necessary.
::::

::: ditaa
+\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ +\-\-\-\-\-\-\-\-\-\-\--+
+\-\-\-\-\-\-\-\-\-\-\--+ +\-\-\-\-\-\-\-\-\-\-\-\-\-\--+ \| OSDs \| \|
Monitors \| \| Managers \| \| MDSs \| +\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
+\-\-\-\-\-\-\-\-\-\-\--+ +\-\-\-\-\-\-\-\-\-\-\--+
+\-\-\-\-\-\-\-\-\-\-\-\-\-\--+
:::

-   **Monitors**: A `Ceph Monitor`{.interpreted-text role="term"}
    (`ceph-mon`) maintains maps of the cluster state, including the
    `monitor map<display-mon-map>`{.interpreted-text role="ref"},
    manager map, the OSD map, the MDS map, and the CRUSH map. These maps
    are critical cluster state required for Ceph daemons to coordinate
    with each other. Monitors are also responsible for managing
    authentication between daemons and clients. At least three monitors
    are normally required for redundancy and high availability.
-   **Managers**: A `Ceph Manager`{.interpreted-text role="term"} daemon
    (`ceph-mgr`) is responsible for keeping track of runtime metrics and
    the current state of the Ceph cluster, including storage
    utilization, current performance metrics, and system load. The Ceph
    Manager daemons also host python-based modules to manage and expose
    Ceph cluster information, including a web-based
    `mgr-dashboard`{.interpreted-text role="ref"} and [REST
    API](../../mgr/restful). At least two managers are normally required
    for high availability.
-   **Ceph OSDs**: An Object Storage Daemon
    (`Ceph OSD`{.interpreted-text role="term"}, `ceph-osd`) stores data,
    handles data replication, recovery, rebalancing, and provides some
    monitoring information to Ceph Monitors and Managers by checking
    other Ceph OSD Daemons for a heartbeat. At least three Ceph OSDs are
    normally required for redundancy and high availability.
-   **MDSs**: A `Ceph Metadata Server`{.interpreted-text role="term"}
    (MDS, `ceph-mds`) stores metadata for the
    `Ceph File System`{.interpreted-text role="term"}. Ceph Metadata
    Servers allow CephFS users to run basic commands (like `ls`, `find`,
    etc.) without placing a burden on the Ceph Storage Cluster.

Ceph stores data as objects within logical storage pools. Using the
`CRUSH`{.interpreted-text role="term"} algorithm, Ceph calculates which
placement group (PG) should contain the object, and which OSD should
store the placement group. The CRUSH algorithm enables the Ceph Storage
Cluster to scale, rebalance, and recover dynamically.

::::::: {.container .columns-2}
:::: {.container .column}
<h3>Recommendations</h3>

To begin using Ceph in production, you should review our hardware
recommendations and operating system recommendations.

::: {.toctree maxdepth="2"}
Beginner\'s Guide \<beginners-guide\> Hardware Recommendations
\<hardware-recommendations\> OS Recommendations \<os-recommendations\>
:::
::::

:::: {.container .column}
<h3>Get Involved</h3>

You can avail yourself of help or contribute documentation, source code
or bugs by getting involved in the Ceph community.

::: {.toctree maxdepth="2"}
get-involved documenting-ceph
:::
::::
:::::::

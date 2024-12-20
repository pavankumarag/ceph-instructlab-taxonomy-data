# Ceph Storage Cluster APIs {#rados api}

The `Ceph Storage Cluster`{.interpreted-text role="term"} has a
messaging layer protocol that enables clients to interact with a
`Ceph Monitor`{.interpreted-text role="term"} and a
`Ceph OSD Daemon`{.interpreted-text role="term"}. `librados` provides
this functionality to `Ceph Client`{.interpreted-text role="term"}s in
the form of a library. All Ceph Clients either use `librados` or the
same functionality encapsulated in `librados` to interact with the
object store. For example, `librbd` and `libcephfs` leverage this
functionality. You may use `librados` to interact with Ceph directly
(e.g., an application that talks to Ceph, your own interface to Ceph,
etc.).

::: {.toctree maxdepth="2"}
Introduction to librados \<librados-intro\> librados (C) \<librados\>
librados (C++) \<libradospp\> librados (Python) \<python\> libcephsqlite
(SQLite) \<libcephsqlite\> object class \<objclass-sdk\>
:::

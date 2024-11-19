# Block Device Quick Start

Ensure your `Ceph Storage Cluster`{.interpreted-text role="term"} is in
an `active + clean` state before working with the
`Ceph Block Device`{.interpreted-text role="term"}.

:::: note
::: title
Note
:::

The Ceph Block Device is also known as `RBD`{.interpreted-text
role="term"} or `RADOS`{.interpreted-text role="term"} Block Device.
::::

::: ditaa
/\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-- /\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\|
Admin Node \| \| ceph-client \| \| +\-\-\-\-\-\-\--\>+ cCCC \| \|
ceph-deploy \| \| ceph \| \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--/
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--/
:::

You may use a virtual machine for your `ceph-client` node, but do not
execute the following procedures on the same physical node as your Ceph
Storage Cluster nodes (unless you use a VM). See
[FAQ](http://wiki.ceph.com/How_Can_I_Give_Ceph_a_Try) for details.

## Create a Block Device Pool

1.  On the admin node, use the `ceph` tool to [create a
    pool](../../rados/operations/pools/#create-a-pool) (we recommend the
    name \'rbd\').

2.  On the admin node, use the `rbd` tool to initialize the pool for use
    by RBD:

        rbd pool init <pool-name>

## Configure a Block Device

1.  On the `ceph-client` node, create a block device image. :

        rbd create foo --size 4096 --image-feature layering [-m {mon-IP}] [-k /path/to/ceph.client.admin.keyring] [-p {pool-name}]

2.  On the `ceph-client` node, map the image to a block device. :

        sudo rbd map foo --name client.admin [-m {mon-IP}] [-k /path/to/ceph.client.admin.keyring] [-p {pool-name}]

3.  Use the block device by creating a file system on the `ceph-client`
    node. :

        sudo mkfs.ext4 -m0 /dev/rbd/{pool-name}/foo

        This may take a few moments.

4.  Mount the file system on the `ceph-client` node. :

        sudo mkdir /mnt/ceph-block-device
        sudo mount /dev/rbd/{pool-name}/foo /mnt/ceph-block-device
        cd /mnt/ceph-block-device

5.  Optionally configure the block device to be automatically mapped and
    mounted at boot (and unmounted/unmapped at shutdown) - see the
    [rbdmap manpage](../../man/8/rbdmap).

See [block devices](../../rbd) for additional details.

orphan

:   

# ceph-rbdnamer \-- udev helper to name RBD devices

::: program
ceph-rbdnamer
:::

## Synopsis

| **ceph-rbdnamer** *num*

## Description

**ceph-rbdnamer** prints the pool, namespace, image and snapshot names
for a given RBD device to stdout. It is used by [udev]{.title-ref}
device manager to set up RBD device symlinks. The appropriate
[udev]{.title-ref} rules are provided in a file named
[50-rbd.rules]{.title-ref}.

## Availability

**ceph-rbdnamer** is part of Ceph, a massively scalable, open-source,
distributed storage system. Please refer to the Ceph documentation at
<https://docs.ceph.com> for more information.

## See also

`rbd <rbd>`{.interpreted-text role="doc"}(8),
`ceph <ceph>`{.interpreted-text role="doc"}(8)

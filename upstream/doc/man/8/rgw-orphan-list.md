orphan

:   

# rgw-orphan-list \-- list rados objects that are not indexed by rgw

::: program
rgw-orphan-list
:::

## Synopsis

| **rgw-orphan-list**

## Description

`rgw-orphan-list`{.interpreted-text role="program"} is an *EXPERIMENTAL*
RADOS gateway user administration utility. It produces a listing of
rados objects that are not directly or indirectly referenced through the
bucket indexes on a pool. It places the results and intermediate files
on the local filesystem rather than on the ceph cluster itself, and
therefore will not itself consume additional cluster storage.

In theory orphans should not exist. However because ceph evolves
rapidly, bugs do crop up, and they may result in orphans that are left
behind.

In its current form this utility does not take any command-line
arguments or options. It will list the available pools and prompt the
user to enter the pool they would like to list orphans for.

Behind the scenes it runs [rados ls]{.title-ref} and [radosgw-admin
bucket radoslist \...]{.title-ref} and produces a list of those entries
that appear in the former but not the latter. Those entries are presumed
to be the orphans.

## Warnings

This utility is currently considered *EXPERIMENTAL*.

This utility will produce false orphan entries for unindexed buckets
since such buckets have no bucket indices that can provide the starting
point for tracing.

## Options

At present there are no options.

## Examples

Launch the tool:

    $ rgw-orphan-list

## Availability

`radosgw-admin`{.interpreted-text role="program"} is part of Ceph, a
massively scalable, open-source, distributed storage system. Please
refer to the Ceph documentation at <https://docs.ceph.com> for more
information.

## See also

`radosgw-admin <radosgw-admin>`{.interpreted-text role="doc"}(8)
`ceph-diff-sorted <ceph-diff-sorted>`{.interpreted-text role="doc"}(8)

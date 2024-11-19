# Librbd (Python) {#rbd api py}

The [rbd]{.title-ref} python module provides file-like access to RBD
images.

## Example: Creating and writing to an image

To use [rbd]{.title-ref}, you must first connect to RADOS and open an IO
context:

``` python
cluster = rados.Rados(conffile='my_ceph.conf')
cluster.connect()
ioctx = cluster.open_ioctx('mypool')
```

Then you instantiate an :class:rbd.RBD object, which you use to create
the image:

``` python
rbd_inst = rbd.RBD()
size = 4 * 1024**3  # 4 GiB
rbd_inst.create(ioctx, 'myimage', size)
```

To perform I/O on the image, you instantiate an :class:rbd.Image object:

``` python
image = rbd.Image(ioctx, 'myimage')
data = b'foo' * 200
image.write(data, 0)
```

This writes \'foo\' to the first 600 bytes of the image. Note that data
cannot be :type:unicode - [Librbd]{.title-ref} does not know how to deal
with characters wider than a :c:type:char.

In the end, you will want to close the image, the IO context and the
connection to RADOS:

``` python
image.close()
ioctx.close()
cluster.shutdown()
```

To be safe, each of these calls would need to be in a separate :finally
block:

``` python
cluster = rados.Rados(conffile='my_ceph_conf')
try:
    cluster.connect()
    ioctx = cluster.open_ioctx('my_pool')
    try:
        rbd_inst = rbd.RBD()
        size = 4 * 1024**3  # 4 GiB
        rbd_inst.create(ioctx, 'myimage', size)
        image = rbd.Image(ioctx, 'myimage')
        try:
            data = b'foo' * 200
            image.write(data, 0)
        finally:
            image.close()
    finally:
        ioctx.close()
finally:
    cluster.shutdown()
```

This can be cumbersome, so the `Rados`{.interpreted-text role="class"},
`Ioctx`{.interpreted-text role="class"}, and `Image`{.interpreted-text
role="class"} classes can be used as context managers that
close/shutdown automatically (see `343`{.interpreted-text role="pep"}).
Using them as context managers, the above example becomes:

``` python
with rados.Rados(conffile='my_ceph.conf') as cluster:
    with cluster.open_ioctx('mypool') as ioctx:
        rbd_inst = rbd.RBD()
        size = 4 * 1024**3  # 4 GiB
        rbd_inst.create(ioctx, 'myimage', size)
        with rbd.Image(ioctx, 'myimage') as image:
            data = b'foo' * 200
            image.write(data, 0)
```

## API Reference

::: {.automodule members="RBD, Image, SnapIterator"}
rbd
:::

# Librados (C)

[librados]{.title-ref} provides low-level access to the RADOS service.
For an overview of RADOS, see `../../architecture`{.interpreted-text
role="doc"}.

## Example: connecting and writing an object

To use [Librados]{.title-ref}, you instantiate a
`rados_t`{.interpreted-text role="c:type"} variable (a cluster handle)
and call `rados_create()`{.interpreted-text role="c:func"} with a
pointer to it:

``` c
int err;
rados_t cluster;

err = rados_create(&cluster, NULL);
if (err < 0) {
    fprintf(stderr, "%s: cannot create a cluster handle: %s\n", argv[0], strerror(-err));
    exit(1);
}
```

Then you configure your `rados_t`{.interpreted-text role="c:type"} to
connect to your cluster, either by setting individual values
(`rados_conf_set()`{.interpreted-text role="c:func"}), using a
configuration file (`rados_conf_read_file()`{.interpreted-text
role="c:func"}), using command line options
(`rados_conf_parse_argv`{.interpreted-text role="c:func"}), or an
environment variable (`rados_conf_parse_env()`{.interpreted-text
role="c:func"}):

``` c
err = rados_conf_read_file(cluster, "/path/to/myceph.conf");
if (err < 0) {
    fprintf(stderr, "%s: cannot read config file: %s\n", argv[0], strerror(-err));
    exit(1);
}
```

Once the cluster handle is configured, you can connect to the cluster
with `rados_connect()`{.interpreted-text role="c:func"}:

``` c
err = rados_connect(cluster);
if (err < 0) {
    fprintf(stderr, "%s: cannot connect to cluster: %s\n", argv[0], strerror(-err));
    exit(1);
}
```

Then you open an \"IO context\", a `rados_ioctx_t`{.interpreted-text
role="c:type"}, with `rados_ioctx_create()`{.interpreted-text
role="c:func"}:

``` c
rados_ioctx_t io;
char *poolname = "mypool";

err = rados_ioctx_create(cluster, poolname, &io);
if (err < 0) {
    fprintf(stderr, "%s: cannot open rados pool %s: %s\n", argv[0], poolname, strerror(-err));
    rados_shutdown(cluster);
    exit(1);
}
```

Note that the pool you try to access must exist.

Then you can use the RADOS data manipulation functions, for example
write into an object called `greeting` with
`rados_write_full()`{.interpreted-text role="c:func"}:

``` c
err = rados_write_full(io, "greeting", "hello", 5);
if (err < 0) {
    fprintf(stderr, "%s: cannot write pool %s: %s\n", argv[0], poolname, strerror(-err));
    rados_ioctx_destroy(io);
    rados_shutdown(cluster);
    exit(1);
}
```

In the end, you will want to close your IO context and connection to
RADOS with `rados_ioctx_destroy()`{.interpreted-text role="c:func"} and
`rados_shutdown()`{.interpreted-text role="c:func"}:

``` c
rados_ioctx_destroy(io);
rados_shutdown(cluster);
```

## Asynchronous IO

When doing lots of IO, you often don\'t need to wait for one operation
to complete before starting the next one. [Librados]{.title-ref}
provides asynchronous versions of several operations:

-   `rados_aio_write`{.interpreted-text role="c:func"}
-   `rados_aio_append`{.interpreted-text role="c:func"}
-   `rados_aio_write_full`{.interpreted-text role="c:func"}
-   `rados_aio_read`{.interpreted-text role="c:func"}

For each operation, you must first create a
`rados_completion_t`{.interpreted-text role="c:type"} that represents
what to do when the operation is safe or complete by calling
`rados_aio_create_completion`{.interpreted-text role="c:func"}. If you
don\'t need anything special to happen, you can pass NULL:

``` c
rados_completion_t comp;
err = rados_aio_create_completion(NULL, NULL, NULL, &comp);
if (err < 0) {
    fprintf(stderr, "%s: could not create aio completion: %s\n", argv[0], strerror(-err));
    rados_ioctx_destroy(io);
    rados_shutdown(cluster);
    exit(1);
}
```

Now you can call any of the aio operations, and wait for it to be in
memory or on disk on all replicas:

``` c
err = rados_aio_write(io, "foo", comp, "bar", 3, 0);
if (err < 0) {
    fprintf(stderr, "%s: could not schedule aio write: %s\n", argv[0], strerror(-err));
    rados_aio_release(comp);
    rados_ioctx_destroy(io);
    rados_shutdown(cluster);
    exit(1);
}
rados_aio_wait_for_complete(comp); // in memory
rados_aio_wait_for_safe(comp); // on disk
```

Finally, we need to free the memory used by the completion with
`rados_aio_release`{.interpreted-text role="c:func"}:

``` c
rados_aio_release(comp);
```

You can use the callbacks to tell your application when writes are
durable, or when read buffers are full. For example, if you wanted to
measure the latency of each operation when appending to several objects,
you could schedule several writes and store the ack and commit time in
the corresponding callback, then wait for all of them to complete using
`rados_aio_flush`{.interpreted-text role="c:func"} before analyzing the
latencies:

``` c
typedef struct {
    struct timeval start;
    struct timeval ack_end;
    struct timeval commit_end;
} req_duration;

void ack_callback(rados_completion_t comp, void *arg) {
    req_duration *dur = (req_duration *) arg;
    gettimeofday(&dur->ack_end, NULL);
}

void commit_callback(rados_completion_t comp, void *arg) {
    req_duration *dur = (req_duration *) arg;
    gettimeofday(&dur->commit_end, NULL);
}

int output_append_latency(rados_ioctx_t io, const char *data, size_t len, size_t num_writes) {
    req_duration times[num_writes];
    rados_completion_t comps[num_writes];
    for (size_t i = 0; i < num_writes; ++i) {
        gettimeofday(&times[i].start, NULL);
        int err = rados_aio_create_completion((void*) &times[i], ack_callback, commit_callback, &comps[i]);
        if (err < 0) {
            fprintf(stderr, "Error creating rados completion: %s\n", strerror(-err));
            return err;
        }
        char obj_name[100];
        snprintf(obj_name, sizeof(obj_name), "foo%ld", (unsigned long)i);
        err = rados_aio_append(io, obj_name, comps[i], data, len);
        if (err < 0) {
            fprintf(stderr, "Error from rados_aio_append: %s", strerror(-err));
            return err;
        }
    }
    // wait until all requests finish *and* the callbacks complete
    rados_aio_flush(io);
    // the latencies can now be analyzed
    printf("Request # | Ack latency (s) | Commit latency (s)\n");
    for (size_t i = 0; i < num_writes; ++i) {
        // don't forget to free the completions
        rados_aio_release(comps[i]);
        struct timeval ack_lat, commit_lat;
        timersub(&times[i].ack_end, &times[i].start, &ack_lat);
        timersub(&times[i].commit_end, &times[i].start, &commit_lat);
        printf("%9ld | %8ld.%06ld | %10ld.%06ld\n", (unsigned long) i, ack_lat.tv_sec, ack_lat.tv_usec, commit_lat.tv_sec, commit_lat.tv_usec);
    }
    return 0;
}
```

Note that all the `rados_completion_t`{.interpreted-text role="c:type"}
must be freed with `rados_aio_release`{.interpreted-text role="c:func"}
to avoid leaking memory.

## API calls

> ::: autodoxygenfile
> rados_types.h
> :::
>
> ::: autodoxygenfile
> librados.h
> :::

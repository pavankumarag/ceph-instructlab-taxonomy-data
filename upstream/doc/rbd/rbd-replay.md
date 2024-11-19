# RBD Replay

::: index
Ceph Block Device; RBD Replay
:::

RBD Replay is a set of tools for capturing and replaying RADOS Block
Device (RBD) workloads. To capture an RBD workload, `lttng-tools` must
be installed on the client, and `librbd` on the client must be the v0.87
(Giant) release or later. To replay an RBD workload, `librbd` on the
client must be the Giant release or later.

Capture and replay takes three steps:

1.  Capture the trace. Make sure to capture `pthread_id` context:

        mkdir -p traces
        lttng create -o traces librbd
        lttng enable-event -u 'librbd:*'
        lttng add-context -u -t pthread_id
        lttng start
        # run RBD workload here
        lttng stop

2.  Process the trace with
    [rbd-replay-prep](../../man/8/rbd-replay-prep):

        rbd-replay-prep traces/ust/uid/*/* replay.bin

3.  Replay the trace with [rbd-replay](../../man/8/rbd-replay). Use
    read-only until you know it\'s doing what you want:

        rbd-replay --read-only replay.bin

:::: important
::: title
Important
:::

`rbd-replay` will destroy data by default. Do not use against an image
you wish to keep, unless you use the `--read-only` option.
::::

The replayed workload does not have to be against the same RBD image or
even the same cluster as the captured workload. To account for
differences, you may need to use the `--pool` and `--map-image` options
of `rbd-replay`.

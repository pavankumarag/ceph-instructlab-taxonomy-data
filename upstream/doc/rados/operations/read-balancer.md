# Operating the Read (Primary) Balancer {#read_balancer}

You might be wondering: How can I improve performance in my Ceph
cluster? One important data point you can check is the
`read_balance_score` on each of your replicated pools.

This metric, available via `ceph osd pool ls detail` (see
`rados_pools`{.interpreted-text role="ref"} for more details) indicates
read performance, or how balanced the primaries are for each replicated
pool. In most cases, if a `read_balance_score` is above 1 (for instance,
1.5), this means that your pool has unbalanced primaries and that you
may want to try improving your read performance with the read balancer.

## Online Optimization

### Enabling

To enable automatic read balancing, you must turn on the *balancer
module* (enabled by default in new clusters) and set the mode to `read`
or `upmap-read`:

::: prompt
bash \$

ceph balancer on ceph balancer mode \<read\|upmap-read\>
:::

Both `read` and `upmap-read` mode make use of `pg-upmap-primary`. In
order to use `pg-upmap-primary`, the cluster cannot have any pre-Reef
clients.

If you want to use a different balancer or if you want to make your own
custom `pg-upmap-primary` entries, you might want to turn off the
balancer in order to avoid conflict:

::: prompt
bash \$

ceph balancer off
:::

To allow use of the new feature on an existing cluster, you must
restrict the cluster to supporting only Reef (and newer) clients. To do
so, run the following command:

::: prompt
bash \$

ceph osd set-require-min-compat-client reef
:::

This command will fail if any pre-Reef clients or daemons are connected
to the monitors. To see which client versions are in use, run the
following command:

::: prompt
bash \$

ceph features
:::

### Balancer Module

The [balancer]{.title-ref} module for `ceph-mgr` will automatically
balance the number of primary PGs per OSD if set to `read` or
`upmap-read` mode. See `balancer`{.interpreted-text role="ref"} for more
information.

## Offline Optimization

Primaries are updated with an offline optimizer that is built into the
`osdmaptool`{.interpreted-text role="ref"}.

1.  Grab the latest copy of your osdmap:

    ::: prompt
    bash \$

    ceph osd getmap -o om
    :::

2.  Run the optimizer:

    ::: prompt
    bash \$

    osdmaptool om \--read out.txt \--read-pool \<pool name\>
    \[\--vstart\]
    :::

    It is highly recommended that you run the capacity balancer before
    running the balancer to ensure optimal results. See
    `upmap`{.interpreted-text role="ref"} for details on how to balance
    capacity in a cluster.

3.  Apply the changes:

    ::: prompt
    bash \$

    source out.txt
    :::

    In the above example, the proposed changes are written to the output
    file `out.txt`. The commands in this procedure are normal Ceph CLI
    commands that can be run in order to apply the changes to the
    cluster.

    If you are working in a vstart cluster, you may pass the `--vstart`
    parameter as shown above so the CLI commands are formatted with the
    [./bin/]{.title-ref} prefix.

    Note that any time the number of pgs changes (for instance, if the
    pg autoscaler \[`pg-autoscaler`{.interpreted-text role="ref"}\]
    kicks in), you should consider rechecking the scores and rerunning
    the balancer if needed.

To see some details about what the tool is doing, you can pass
`--debug-osd 10` to `osdmaptool`. To see even more details, pass
`--debug-osd 20` to `osdmaptool`.

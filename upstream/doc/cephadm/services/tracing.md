# Tracing Services

## Jaeger Tracing {#cephadm-tracing}

Ceph uses Jaeger as the tracing backend. in order to use tracing, we
need to deploy those services.

Further details on tracing in ceph:

[Ceph Tracing
documentation](https://docs.ceph.com/en/latest/jaegertracing/#jaeger-distributed-tracing/)

## Deployment

Jaeger services consist of 3 services:

1.  Jaeger Agent
2.  Jaeger Collector
3.  Jaeger Query

Jaeger requires a database for the traces. we use ElasticSearch (version
6) by default.

To deploy jaeger tracing service, when not using your own ElasticSearch:

1.  Deploy jaeger services, with a new elasticsearch container:

    > ::: prompt
    > bash \#
    >
    > ceph orch apply jaeger
    > :::

2.  Deploy jaeger services, with existing elasticsearch cluster and
    existing jaeger query (deploy agents and collectors):

    > ::: prompt
    > bash \#
    >
    > ceph orch apply jaeger \--without-query \--es_nodes=ip:port,..
    > :::

orphan

:   

# ceph-monstore-tool \-- ceph monstore manipulation tool

::: program
ceph-monstore-tool
:::

## Synopsis

| **ceph-monstore-tool** \<store path\> \<cmd\> \[args\|options\]

## Description

`ceph-monstore-tool`{.interpreted-text role="program"} is used to
manipulate MonitorDBStore\'s data (monmap, osdmap, etc.) offline. It is
similar to [ceph-kvstore-tool]{.title-ref}.

Note:

:   Ceph-specific options take the format
    [\--option-name=VAL]{.title-ref} DO NOT FORGET THE EQUALS SIGN.
    (\'=\') for example, [dump-keys \--debug-rocksdb=0]{.title-ref}

    Command-specific options must be passed after a [\--]{.title-ref}
    for example, [get monmap \-- \--version 10 \--out
    /tmp/foo]{.title-ref}

## Commands

`ceph-monstore-tool`{.interpreted-text role="program"} uses many
commands for debugging purposes:

`store-copy <path>`{.interpreted-text role="command"}

:   Copy the store to PATH.

`get monmap [-- options]`{.interpreted-text role="command"}

:   Get monmap (version VER if specified) (default: last committed).

`get osdmap [-- options]`{.interpreted-text role="command"}

:   Get osdmap (version VER if specified) (default: last committed).

`get msdmap [-- options]`{.interpreted-text role="command"}

:   Get msdmap (version VER if specified) (default: last committed).

`get mgr [-- options]`{.interpreted-text role="command"}

:   Get mgrmap (version VER if specified) (default: last committed).

`get crushmap [-- options]`{.interpreted-text role="command"}

:   Get crushmap (version VER if specified) (default: last committed).

`get-key <prefix> <key> [-- options]`{.interpreted-text role="command"}

:   Get key to FILE (default: stdout).

`remove-key <prefix> <key> [-- options]`{.interpreted-text role="command"}

:   Remove key.

`dump-keys`{.interpreted-text role="command"}

:   Dump store keys to FILE (default: stdout).

`dump-paxos [-- options]`{.interpreted-text role="command"}

:   Dump Paxos transactions (\-- \-- help for more info).

`dump-trace FILE  [-- options]`{.interpreted-text role="command"}

:   Dump contents of trace file FILE (\-- \--help for more info).

`replay-trace FILE  [-- options]`{.interpreted-text role="command"}

:   Replay trace from FILE (\-- \--help for more info).

`random-gen [-- options]`{.interpreted-text role="command"}

:   Add randomly genererated ops to the store (\-- \--help for more
    info).

`rewrite-crush [-- options]`{.interpreted-text role="command"}

:   Add a rewrite commit to the store

`rebuild`{.interpreted-text role="command"}

:   Rebuild store.

## Availability

**ceph-monstore-tool** is part of Ceph, a massively scalable,
open-source, distributed storage system. See the Ceph documentation at
<https://docs.ceph.com> for more information.

## See also

`ceph <ceph>`{.interpreted-text role="doc"}(8)

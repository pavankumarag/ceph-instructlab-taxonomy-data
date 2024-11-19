# config-key layout

*config-key* is a general-purpose key/value storage service offered by
the mons. Generally speaking, you can put whatever you want there.
Current in-tree users should be captured here with their key layout
schema.

## OSD dm-crypt keys

Key:

    dm-crypt/osd/$OSD_UUID/luks = <json string>

The JSON payload has the form:

    { "dm-crypt": <secret> }

where the secret is a base64 encoded LUKS key.

Created by the \'osd new\' command (see OSDMonitor.cc).

Consumed by ceph-volume, and similar tools. Normally access to the
dm-crypt/osd/\$OSD_UUID prefix is allowed by a
client.osd-lockbox.\$OSD_UUID cephx key, such that only the appropriate
host can retrieve the LUKS key (which in turn decrypts the actual raw
key, also stored on the device itself).

## ceph-mgr modules

The convention for keys is:

    mgr/$MODULE/$option = $value

or:

    mgr/$MODULE/$MGRID/$option = $value

For example,:

    mgr/dashboard/server_port = 80
    mgr/dashboard/foo/server_addr = 1.2.3.4
    mgr/dashboard/bar/server_addr = 1.2.3.5

## Configuration

Configuration options for clients and daemons are also stored in
config-key.

Keys take the form:

    config/$option = $value
    config/$type/$option = $value
    config/$type.$id/$option = $value
    config/$type.$id/$mask[/$mask2...]/$option = $value

Where

-   [type]{.title-ref} is a daemon type ([osd]{.title-ref},
    [mon]{.title-ref}, [mds]{.title-ref}, [mgr]{.title-ref},
    [client]{.title-ref})
-   [id]{.title-ref} is a daemon id (e.g., [0]{.title-ref},
    [foo]{.title-ref}), such that [\$type.\$id]{.title-ref} is something
    like [osd.123]{.title-ref} or [mds.foo]{.title-ref})
-   [mask]{.title-ref} restricts who the option applies to, and can take
    two forms:
    1.  [\$crush_type:\$crush_value]{.title-ref}. For example,
        [rack:foorack]{.title-ref}
    2.  [class:\$classname]{.title-ref}, in reference to CRUSH device
        classes (e.g., [ssd]{.title-ref})

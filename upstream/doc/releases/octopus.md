# Octopus

Octopus is the 15th stable release of Ceph. It is named after an order
of 8-limbed cephalopods.

## v15.2.17 Octopus

This is the 17th and final backport release in the Octopus series. We
recommend all users update to this release.

### Notable Changes

-   Octopus modified the SnapMapper key format from
    \<LEGACY_MAPPING_PREFIX\>\<snapid\>\_\<shardid\>\_\<hobject_t::to_str()\>
    to
    \<MAPPING_PREFIX\>\<pool\>\_\<snapid\>\_\<shardid\>\_\<hobject_t::to_str()\>
    When this change was introduced, 94ebe0e also introduced a
    conversion with a crucial bug which essentially destroyed legacy
    keys by mapping them to \<MAPPING_PREFIX\>\<poolid\>\_\<snapid\>\_
    without the object-unique suffix. The conversion is fixed in this
    release. Relevant tracker: <https://tracker.ceph.com/issues/5614>

-   The ability to blend all RBD pools together into a single view by
    invoking \"rbd perf image iostat\" or \"rbd perf image iotop\"
    commands without any options or positional arguments is resurrected.
    Such invocations accidentally became limited to just the default
    pool (`rbd_default_pool`) in v15.2.14.

-   Users who were running OpenStack Manila to export native CephFS, who
    upgraded their Ceph cluster from Nautilus (or earlier) to a later
    major version, were vulnerable to an attack by malicious users
    (`CVE-2022-0670`{.interpreted-text role="ref"}). The vulnerability
    allowed users to obtain access to arbitrary portions of the CephFS
    filesystem hierarchy, instead of being properly restricted to their
    own subvolumes. The vulnerability is due to a bug in the \"volumes\"
    plugin in Ceph Manager. This plugin is responsible for managing Ceph
    File System subvolumes which are used by OpenStack Manila services
    as a way to provide shares to Manila users.

    With this release, the vulnerability is fixed. Administrators who
    are concerned they may have been impacted should audit the CephX
    keys in their cluster for proper path restrictions.

    Again, this vulnerability only impacts OpenStack Manila clusters
    which provided native CephFS access to their users.

### Changelog

-   admin/doc-requirements: bump sphinx to 4.4.0
    ([pr#45972](https://github.com/ceph/ceph/pull/45972), Kefu Chai)
-   backport qemu-iotests fixup for centos stream 8
    ([pr#45206](https://github.com/ceph/ceph/pull/45206), Ken Dreyer,
    Ilya Dryomov)
-   Catch exception if thrown by \_\_generate_command_map()
    ([pr#45891](https://github.com/ceph/ceph/pull/45891), Nikhil
    Kshirsagar)
-   ceph-volume: abort when passed devices have partitions
    ([pr#45147](https://github.com/ceph/ceph/pull/45147), Guillaume
    Abrioux)
-   ceph-volume: fix error \'KeyError\' with inventory
    ([pr#44883](https://github.com/ceph/ceph/pull/44883), Guillaume
    Abrioux)
-   ceph-volume: fix tags dict output in [lvm list]{.title-ref}
    ([pr#44768](https://github.com/ceph/ceph/pull/44768), Guillaume
    Abrioux)
-   ceph-volume: zap osds in rollback_osd()
    ([pr#44770](https://github.com/ceph/ceph/pull/44770), Guillaume
    Abrioux)
-   ceph/admin: s/master/main
    ([pr#46219](https://github.com/ceph/ceph/pull/46219), Zac Dover)
-   cephadm: infer the default container image during pull
    ([pr#45570](https://github.com/ceph/ceph/pull/45570), Michael
    Fritch)
-   cephadm: preserve [authorized_keys]{.title-ref} file during upgrade
    ([pr#45356](https://github.com/ceph/ceph/pull/45356), Michael
    Fritch)
-   client: do not dump mds twice in Inode::dump()
    ([pr#45162](https://github.com/ceph/ceph/pull/45162), Xue Yantao)
-   cls/rbd: GroupSnapshotNamespace comparator violates ordering rules
    ([pr#45076](https://github.com/ceph/ceph/pull/45076), Ilya Dryomov)
-   cls/rgw: rgw_dir_suggest_changes detects race with completion
    ([pr#45902](https://github.com/ceph/ceph/pull/45902), Casey Bodley)
-   cmake: pass RTE_DEVEL_BUILD=n when building dpdk
    ([pr#45261](https://github.com/ceph/ceph/pull/45261), Kefu Chai)
-   common: avoid pthread_mutex_unlock twice
    ([pr#45465](https://github.com/ceph/ceph/pull/45465), Dai Zhiwei)
-   common: replace BitVector::NoInitAllocator with wrapper struct
    ([pr#45180](https://github.com/ceph/ceph/pull/45180), Casey Bodley)
-   crush: cancel upmaps with up set size != pool size
    ([pr#43416](https://github.com/ceph/ceph/pull/43416), huangjun)
-   doc/dev: update basic-workflow.rst
    ([pr#46308](https://github.com/ceph/ceph/pull/46308), Zac Dover)
-   doc/start: s/3/three/ in intro.rst
    ([pr#46328](https://github.com/ceph/ceph/pull/46328), Zac Dover)
-   doc/start: update \"memory\" in hardware-recs.rst
    ([pr#46451](https://github.com/ceph/ceph/pull/46451), Zac Dover)
-   Fixes for make check
    ([pr#46230](https://github.com/ceph/ceph/pull/46230), Kefu Chai,
    Adam C. Emerson)
-   krbd: return error when no initial monitor address found
    ([pr#45004](https://github.com/ceph/ceph/pull/45004), Burt Holzman)
-   librados: check latest osdmap on ENOENT in pool_reverse_lookup()
    ([pr#45587](https://github.com/ceph/ceph/pull/45587), Ilya Dryomov)
-   librbd: bail from schedule_request_lock() if already lock owner
    ([pr#47160](https://github.com/ceph/ceph/pull/47160), Christopher
    Hoffman)
-   librbd: fix use-after-free on ictx in list_descendants()
    ([pr#45000](https://github.com/ceph/ceph/pull/45000), Ilya Dryomov,
    Wang ShuaiChao)
-   librbd: honor FUA op flag for write_same() in write-around cache
    ([pr#44992](https://github.com/ceph/ceph/pull/44992), Ilya Dryomov)
-   librbd: readv/writev fix iovecs length computation overflow
    ([pr#45560](https://github.com/ceph/ceph/pull/45560), Jonas
    Pfefferle)
-   librbd: track complete async operation requests
    ([pr#45019](https://github.com/ceph/ceph/pull/45019), Mykola Golub)
-   librbd: unlink newest mirror snapshot when at capacity, bump
    capacity ([pr#46592](https://github.com/ceph/ceph/pull/46592), Ilya
    Dryomov)
-   librbd: update progress for non-existent objects on deep-copy
    ([pr#46912](https://github.com/ceph/ceph/pull/46912), Ilya Dryomov)
-   librgw: make rgw file handle versioned
    ([pr#45496](https://github.com/ceph/ceph/pull/45496), Xuehan Xu)
-   mds: add heartbeat_reset() in start_files_to_reover()
    ([pr#45157](https://github.com/ceph/ceph/pull/45157), Yongseok Oh)
-   mds: check rejoin_ack_gather before enter rejoin_gather_finish
    ([pr#45161](https://github.com/ceph/ceph/pull/45161), chencan)
-   mds: directly return just after responding the link request
    ([pr#44624](https://github.com/ceph/ceph/pull/44624), Xiubo Li)
-   mds: ensure that we send the btime in cap messages
    ([pr#45164](https://github.com/ceph/ceph/pull/45164), Jeff Layton)
-   mds: fix possible mds_lock not locked assert
    ([pr#45156](https://github.com/ceph/ceph/pull/45156), Xiubo Li)
-   mds: fix seg fault in expire_recursive
    ([pr#45055](https://github.com/ceph/ceph/pull/45055), 胡玮文)
-   mds: ignore unknown client op when tracking op latency
    ([pr#44976](https://github.com/ceph/ceph/pull/44976), Venky Shankar)
-   mds: mds_oft_prefetch_dirfrags default to false
    ([pr#45015](https://github.com/ceph/ceph/pull/45015), Dan van der
    Ster)
-   mds: progress the recover queue immediately after the inode is
    enqueued ([pr#45158](https://github.com/ceph/ceph/pull/45158),
    \"Yan, Zheng\", Xiubo Li)
-   mds: reset the return value for heap command
    ([pr#45155](https://github.com/ceph/ceph/pull/45155), Xiubo Li)
-   mds: skip directory size checks for reintegration
    ([pr#44668](https://github.com/ceph/ceph/pull/44668), Patrick
    Donnelly)
-   mgr/cephadm: fix and improve osd draining
    ([pr#46645](https://github.com/ceph/ceph/pull/46645), Sage Weil)
-   mgr/cephadm: try to get FQDN for active instance
    ([pr#46787](https://github.com/ceph/ceph/pull/46787), Tatjana
    Dehler)
-   mgr/cephadm: try to get FQDN for configuration files
    ([pr#45621](https://github.com/ceph/ceph/pull/45621), Tatjana
    Dehler)
-   mgr/dashboard: dashboard turns telemetry off when configuring report
    ([pr#45110](https://github.com/ceph/ceph/pull/45110), Sarthak0702,
    Aaryan Porwal)
-   mgr/dashboard: fix \"NullInjectorError: No provider for I18n
    ([pr#45613](https://github.com/ceph/ceph/pull/45613), Nizamudeen A)
-   mgr/dashboard: fix Grafana OSD/host panels
    ([pr#44924](https://github.com/ceph/ceph/pull/44924), Patrick
    Seidensal)
-   mgr/dashboard: Notification banners at the top of the UI have fixed
    height ([pr#44763](https://github.com/ceph/ceph/pull/44763), Waad
    AlKhoury)
-   mgr/dashboard: Table columns hiding fix
    ([issue#51119](http://tracker.ceph.com/issues/51119),
    [pr#45726](https://github.com/ceph/ceph/pull/45726), Daniel Persson)
-   mgr/devicehealth: fix missing timezone from time delta calculation
    ([pr#45287](https://github.com/ceph/ceph/pull/45287), Yaarit Hatuka)
-   mgr/prometheus: Added [avail_raw]{.title-ref} field for Pools DF
    Prometheus mgr module
    ([pr#45238](https://github.com/ceph/ceph/pull/45238), Konstantin
    Shalygin)
-   mgr/rbd_support: cast pool_id from int to str when collecting
    LevelSpec ([pr#45530](https://github.com/ceph/ceph/pull/45530), Ilya
    Dryomov)
-   mgr/rbd_support: fix schedule remove
    ([pr#45006](https://github.com/ceph/ceph/pull/45006), Sunny Kumar)
-   mgr/telemetry: fix waiting for mgr to warm up
    ([pr#45772](https://github.com/ceph/ceph/pull/45772), Yaarit Hatuka)
-   mgr/volumes: A few volumes plugin backport
    ([issue#51271](http://tracker.ceph.com/issues/51271),
    [pr#44800](https://github.com/ceph/ceph/pull/44800), Kotresh HR,
    Venky Shankar, Jan Fajerski)
-   mgr/volumes: Fix permission during subvol creation with mode
    ([pr#43224](https://github.com/ceph/ceph/pull/43224), Kotresh HR)
-   mgr/volumes: Fix subvolume discover during upgrade
    ([pr#47236](https://github.com/ceph/ceph/pull/47236), Kotresh HR)
-   mgr: limit changes to pg_num
    ([pr#44541](https://github.com/ceph/ceph/pull/44541), Sage Weil)
-   mirror snapshot schedule and trash purge schedule fixes
    ([pr#46777](https://github.com/ceph/ceph/pull/46777), Ilya Dryomov)
-   mon/MonCommands.h: fix target_size_ratio range
    ([pr#45398](https://github.com/ceph/ceph/pull/45398), Kamoltat)
-   mon: Abort device health when device not found
    ([pr#44960](https://github.com/ceph/ceph/pull/44960), Benoît Knecht)
-   octopus rgw: on FIPS enabled, fix segfault performing s3 multipart
    PUT ([pr#46701](https://github.com/ceph/ceph/pull/46701), Mark
    Kogan)
-   octopus rgw: under fips, set flag to allow md5 in select rgw ops
    ([pr#44806](https://github.com/ceph/ceph/pull/44806), Mark Kogan)
-   os/bluestore: Always update the cursor position in AVL near-fit
    search ([pr#46687](https://github.com/ceph/ceph/pull/46687), Mark
    Nelson)
-   osd/OSD: Log aggregated slow ops detail to cluster logs
    ([pr#45154](https://github.com/ceph/ceph/pull/45154), Prashant D)
-   osd/OSD: osd_fast_shutdown_notify_mon not quite right
    ([pr#45655](https://github.com/ceph/ceph/pull/45655), Nitzan
    Mordechai, Satoru Takeuchi)
-   osd/OSDMap: Add health warning if \'require-osd-release\' != current
    release ([pr#44260](https://github.com/ceph/ceph/pull/44260),
    Sridhar Seshasayee)
-   osd/OSDMapMapping: fix spurious threadpool timeout errors
    ([pr#44546](https://github.com/ceph/ceph/pull/44546), Sage Weil)
-   osd/PGLog.cc: Trim duplicates by number of entries
    ([pr#46253](https://github.com/ceph/ceph/pull/46253), Nitzan
    Mordechai)
-   osd/PrimaryLogPG.cc: CEPH_OSD_OP_OMAPRMKEYRANGE should mark omap
    dirty ([pr#45593](https://github.com/ceph/ceph/pull/45593), Neha
    Ojha)
-   osd/SnapMapper: fix pacific legacy key conversion and introduce test
    ([pr#47108](https://github.com/ceph/ceph/pull/47108), Manuel Lausch,
    Matan Breizman)
-   osd: log the number of \'dups\' entries in a PG Log
    ([pr#46609](https://github.com/ceph/ceph/pull/46609), Radoslaw
    Zarzynski)
-   osd: require osd_pg_max_concurrent_snap_trims \> 0
    ([pr#45324](https://github.com/ceph/ceph/pull/45324), Dan van der
    Ster)
-   qa/rgw: add failing tempest test to blocklist
    ([pr#45437](https://github.com/ceph/ceph/pull/45437), Casey Bodley)
-   qa/rgw: update apache-maven mirror for rgw/hadoop-s3a
    ([pr#45446](https://github.com/ceph/ceph/pull/45446), Casey Bodley)
-   qa/suites/rados/thrash-erasure-code-big/thrashers: add [osd max
    backfills]{.title-ref} setting to mapgap and pggrow
    ([pr#46392](https://github.com/ceph/ceph/pull/46392), Laura Flores)
-   qa/suites: clean up client-upgrade-octopus-pacific test
    ([pr#45334](https://github.com/ceph/ceph/pull/45334), Ilya Dryomov)
-   qa/tasks/qemu: make sure block-rbd.so is installed
    ([pr#45071](https://github.com/ceph/ceph/pull/45071), Ilya Dryomov)
-   qa/tasks: teuthology octopus backport
    ([pr#46149](https://github.com/ceph/ceph/pull/46149), Kefu Chai,
    Shraddha Agrawal)
-   qa/tests: added upgrade-clients/client-upgrade-octopus-quincy tests
    ([pr#45282](https://github.com/ceph/ceph/pull/45282), Yuri
    Weinstein)
-   qa: always format the pgid in hex
    ([pr#45159](https://github.com/ceph/ceph/pull/45159), Xiubo Li)
-   qa: check mounts attribute in ctx
    ([pr#45633](https://github.com/ceph/ceph/pull/45633), Jos Collin)
-   qa: remove .teuthology_branch file
    ([pr#46489](https://github.com/ceph/ceph/pull/46489), Jeff Layton)
-   radosgw-admin: \'reshard list\' doesn\'t log ENOENT errors
    ([pr#45452](https://github.com/ceph/ceph/pull/45452), Casey Bodley)
-   radosgw-admin: \'sync status\' is not behind if there are no mdlog
    entries ([pr#45443](https://github.com/ceph/ceph/pull/45443), Casey
    Bodley)
-   radosgw-admin: skip GC init on read-only admin ops
    ([pr#45423](https://github.com/ceph/ceph/pull/45423), Mark Kogan)
-   rbd-fuse: librados will filter out -r option from command-line
    ([pr#46952](https://github.com/ceph/ceph/pull/46952), wanwencong)
-   rbd-mirror: don\'t prune non-primary snapshot when restarting delta
    sync ([pr#46589](https://github.com/ceph/ceph/pull/46589), Ilya
    Dryomov)
-   rbd-mirror: generally skip replay/resync if remote image is not
    primary ([pr#46812](https://github.com/ceph/ceph/pull/46812), Ilya
    Dryomov)
-   rbd-mirror: make mirror properly detect pool replayer needs restart
    ([pr#45169](https://github.com/ceph/ceph/pull/45169), Mykola Golub)
-   rbd-mirror: remove bogus completed_non_primary_snapshots_exist check
    ([pr#47117](https://github.com/ceph/ceph/pull/47117), Ilya Dryomov)
-   rbd-mirror: synchronize with in-flight stop in ImageReplayer::stop()
    ([pr#45177](https://github.com/ceph/ceph/pull/45177), Ilya Dryomov)
-   rbd: don\'t default empty pool name unless namespace is specified
    ([pr#47142](https://github.com/ceph/ceph/pull/47142), Ilya Dryomov)
-   rbd: mark optional positional arguments as such in help output
    ([pr#45009](https://github.com/ceph/ceph/pull/45009), Ilya Dryomov,
    Jason Dillaman)
-   rbd: recognize rxbounce map option
    ([pr#45001](https://github.com/ceph/ceph/pull/45001), Ilya Dryomov)
-   Revert \"rocksdb: do not use non-zero recycle_log_file_num setting\"
    ([pr#47053](https://github.com/ceph/ceph/pull/47053), Laura Flores)
-   revert of #46253, add tools: ceph-objectstore-tool is able to trim
    solely pg log dups\' entries
    ([pr#46611](https://github.com/ceph/ceph/pull/46611), Radosław
    Zarzyński, Radoslaw Zarzynski)
-   rgw/amqp: add default case to silence compiler warning
    ([pr#45479](https://github.com/ceph/ceph/pull/45479), Casey Bodley)
-   rgw: add the condition of lock mode conversion to PutObjRentention
    ([pr#45441](https://github.com/ceph/ceph/pull/45441), wangzhong)
-   rgw: bucket chown bad memory usage
    ([pr#45492](https://github.com/ceph/ceph/pull/45492), Mohammad
    Fatemipour)
-   rgw: change order of xml elements in ListRoles response
    ([pr#45449](https://github.com/ceph/ceph/pull/45449), Casey Bodley)
-   rgw: cls_bucket_list_unordered() might return one redundent entry
    every time is_truncated is true
    ([pr#45458](https://github.com/ceph/ceph/pull/45458), Peng Zhang)
-   rgw: document rgw_lc_debug_interval configuration option
    ([pr#45454](https://github.com/ceph/ceph/pull/45454), J. Eric
    Ivancich)
-   rgw: document S3 bucket replication support
    ([pr#45485](https://github.com/ceph/ceph/pull/45485), Matt Benjamin)
-   rgw: Dump Object Lock Retain Date as ISO 8601
    ([pr#43656](https://github.com/ceph/ceph/pull/43656), Preben Berg)
-   rgw: fix leak of RGWBucketList memory (octopus only)
    ([pr#45283](https://github.com/ceph/ceph/pull/45283), Casey Bodley)
-   rgw: fix md5 not match for RGWBulkUploadOp upload when enable rgw
    com... ([pr#45433](https://github.com/ceph/ceph/pull/45433),
    yuliyang_yewu)
-   rgw: fix segfault in UserAsyncRefreshHandler::init_fetch
    ([pr#45412](https://github.com/ceph/ceph/pull/45412), Cory Snyder)
-   rgw: have \"bucket check \--fix\" fix pool ids correctly
    ([pr#45456](https://github.com/ceph/ceph/pull/45456), J. Eric
    Ivancich)
-   rgw: init bucket index only if putting bucket instance info succeeds
    ([pr#45481](https://github.com/ceph/ceph/pull/45481), Huber-ming)
-   rgw: parse tenant name out of rgwx-bucket-instance
    ([pr#45523](https://github.com/ceph/ceph/pull/45523), Casey Bodley)
-   rgw: resolve empty ordered bucket listing results w/ CLS filtering
    \*and\* bucket index list produces incorrect result when non-ascii
    entries ([pr#45088](https://github.com/ceph/ceph/pull/45088), J.
    Eric Ivancich)
-   rgw: return OK on consecutive complete-multipart reqs
    ([pr#45488](https://github.com/ceph/ceph/pull/45488), Mark Kogan)
-   rgw: RGWCoroutine::set_sleeping() checks for null stack
    ([pr#46042](https://github.com/ceph/ceph/pull/46042), Or Friedmann,
    Casey Bodley)
-   rgw: RGWPostObj::execute() may lost data
    ([pr#45503](https://github.com/ceph/ceph/pull/45503), Lei Zhang)
-   rgw: url_decode before parsing copysource in copyobject
    ([issue#43259](http://tracker.ceph.com/issues/43259),
    [pr#45431](https://github.com/ceph/ceph/pull/45431), Paul Reece)
-   rgw:When KMS encryption is used and the key does not exist, we
    should... ([pr#45462](https://github.com/ceph/ceph/pull/45462),
    wangyingbin)
-   rgwlc: fix segfault resharding during lc
    ([pr#46745](https://github.com/ceph/ceph/pull/46745), Mark Kogan)
-   rocksdb: do not use non-zero recycle_log_file_num setting
    ([pr#45040](https://github.com/ceph/ceph/pull/45040), Igor Fedotov)
-   src/rgw: Fix for malformed url
    ([pr#45460](https://github.com/ceph/ceph/pull/45460), Kalpesh
    Pandya)
-   test/bufferlist: ensure rebuild_aligned_size_and_memory() always
    rebuilds ([pr#46216](https://github.com/ceph/ceph/pull/46216),
    Radoslaw Zarzynski)
-   test/librbd: add test to verify diff_iterate size
    ([pr#45554](https://github.com/ceph/ceph/pull/45554), Christopher
    Hoffman)
-   test: fix wrong alarm (HitSetWrite)
    ([pr#45320](https://github.com/ceph/ceph/pull/45320), Myoungwon Oh)
-   tools/rbd: expand where option rbd_default_map_options can be set
    ([pr#45182](https://github.com/ceph/ceph/pull/45182), Christopher
    Hoffman, Ilya Dryomov)

## v15.2.16 Octopus

This is the 16th backport release in the Octopus series. We recommend
all users update to this release.

### Notable Changes

-   Fix in the read lease logic to prevent PGs from going into WAIT
    state after OSD restart.
-   Several bug fixes in BlueStore, including a fix for object listing
    bug, which could cause stat mismatch scrub errors.

### Changelog

-   Fix data corruption in bluefs truncate()
    ([pr#44860](https://github.com/ceph/ceph/pull/44860), Adam Kupczyk)
-   Octopus: mds: just respawn mds daemon when osd op requests timeout
    ([pr#43785](https://github.com/ceph/ceph/pull/43785), Xiubo Li)
-   admin/doc-requirements.txt: pin Sphinx at 3.5.4
    ([pr#43758](https://github.com/ceph/ceph/pull/43758), Casey Bodley,
    Kefu Chai, Nizamudeen A, Varsha Rao)
-   backport diff-iterate include_parent tests
    ([pr#44673](https://github.com/ceph/ceph/pull/44673), Ilya Dryomov)
-   ceph-volume: [get_first_lv()]{.title-ref} refactor
    ([pr#43959](https://github.com/ceph/ceph/pull/43959), Guillaume
    Abrioux)
-   ceph-volume: don\'t use MultiLogger in find_executable_on_host()
    ([pr#44766](https://github.com/ceph/ceph/pull/44766), Guillaume
    Abrioux)
-   ceph-volume: fix a typo causing AttributeError
    ([pr#43950](https://github.com/ceph/ceph/pull/43950), Taha Jahangir)
-   ceph-volume: fix bug with miscalculation of required db/wal slot
    size for VGs with multiple PVs
    ([pr#43947](https://github.com/ceph/ceph/pull/43947), Guillaume
    Abrioux, Cory Snyder)
-   ceph-volume: fix regression introcuded via #43536
    ([pr#44757](https://github.com/ceph/ceph/pull/44757), Guillaume
    Abrioux)
-   ceph-volume: honour osd_dmcrypt_key_size option
    ([pr#44974](https://github.com/ceph/ceph/pull/44974), Guillaume
    Abrioux)
-   ceph-volume: human_readable_size() refactor
    ([pr#44210](https://github.com/ceph/ceph/pull/44210), Guillaume
    Abrioux)
-   ceph-volume: improve mpath devices support
    ([pr#44791](https://github.com/ceph/ceph/pull/44791), Guillaume
    Abrioux)
-   ceph-volume: make it possible to skip needs_root()
    ([pr#44320](https://github.com/ceph/ceph/pull/44320), Guillaume
    Abrioux)
-   ceph-volume: show RBD devices as not available
    ([pr#44709](https://github.com/ceph/ceph/pull/44709), Michael
    Fritch)
-   ceph-volume: util/prepare fix osd_id_available()
    ([pr#43952](https://github.com/ceph/ceph/pull/43952), Guillaume
    Abrioux)
-   cephadm/ceph-volume: do not use lvm binary in containers
    ([pr#43953](https://github.com/ceph/ceph/pull/43953), Guillaume
    Abrioux)
-   cephadm: Fix iscsi client caps (allow mgr \<service status\> calls)
    ([pr#43822](https://github.com/ceph/ceph/pull/43822), Juan Miguel
    Olmo Martínez)
-   cephfs: client: Fix executeable access check for the root user
    ([pr#41295](https://github.com/ceph/ceph/pull/41295), Kotresh HR)
-   cls/journal: skip disconnected clients when calculating
    min_commit_position
    ([pr#44689](https://github.com/ceph/ceph/pull/44689), Mykola Golub)
-   common/PriorityCache: low perf counters priorities for submodules
    ([pr#44176](https://github.com/ceph/ceph/pull/44176), Igor Fedotov)
-   doc: Use older mistune
    ([pr#44227](https://github.com/ceph/ceph/pull/44227), David
    Galloway)
-   doc: prerequisites fix for cephFS mount
    ([pr#44271](https://github.com/ceph/ceph/pull/44271), Nikhilkumar
    Shelke)
-   librbd/object_map: rbd diff between two snapshots lists entire image
    content ([pr#43806](https://github.com/ceph/ceph/pull/43806), Sunny
    Kumar)
-   librbd: diff-iterate reports incorrect offsets in fast-diff mode
    ([pr#44548](https://github.com/ceph/ceph/pull/44548), Ilya Dryomov)
-   mds: Add new flag to MClientSession
    ([pr#43252](https://github.com/ceph/ceph/pull/43252), Kotresh HR)
-   mds: PurgeQueue.cc fix for 32bit compilation
    ([pr#44169](https://github.com/ceph/ceph/pull/44169), Duncan
    Bellamy)
-   mds: do not trim stray dentries during opening the root
    ([pr#43816](https://github.com/ceph/ceph/pull/43816), Xiubo Li)
-   mds: skip journaling blocklisted clients when in
    [replay]{.title-ref} state
    ([pr#43842](https://github.com/ceph/ceph/pull/43842), Venky Shankar)
-   mgr/dashboard/api: set a UTF-8 locale when running pip
    ([pr#43607](https://github.com/ceph/ceph/pull/43607), Kefu Chai)
-   mgr/dashboard: all pyfakefs must be pinned on same version
    ([pr#44159](https://github.com/ceph/ceph/pull/44159), Rishabh Dave)
-   mgr/dashboard: upgrade Cypress to the latest stable version
    ([pr#44373](https://github.com/ceph/ceph/pull/44373), Alfonso
    Martínez)
-   mgr: Add check to prevent mgr from crashing
    ([pr#43446](https://github.com/ceph/ceph/pull/43446), Aswin Toni)
-   mgr: fix locking for MetadataUpdate::finish
    ([pr#44720](https://github.com/ceph/ceph/pull/44720), Sage Weil)
-   mgr: set debug_mgr=2/5 (so INFO goes to mgr log by default)
    ([pr#42677](https://github.com/ceph/ceph/pull/42677), Sage Weil)
-   mon/MgrStatMonitor: do not spam subscribers (mgr) with service_map
    ([pr#44722](https://github.com/ceph/ceph/pull/44722), Sage Weil)
-   mon/MgrStatMonitor: ignore MMgrReport from non-active mgr
    ([pr#43861](https://github.com/ceph/ceph/pull/43861), Sage Weil)
-   mon/OSDMonitor: avoid null dereference if stats are not available
    ([pr#44700](https://github.com/ceph/ceph/pull/44700), Josh Durgin)
-   mon: prevent new sessions during shutdown
    ([pr#44544](https://github.com/ceph/ceph/pull/44544), Sage Weil)
-   msg/async: allow connection reaping to be tuned; fix cephfs test
    ([pr#43310](https://github.com/ceph/ceph/pull/43310), Sage Weil,
    Gerald Yang)
-   msgr/async: fix unsafe access in unregister_conn()
    ([pr#43325](https://github.com/ceph/ceph/pull/43325), Sage Weil,
    Gerald Yang)
-   os/bluestore/AvlAllocator: introduce bluestore_avl_alloc_ff_max\_\*
    options ([pr#43747](https://github.com/ceph/ceph/pull/43747), Kefu
    Chai, Mauricio Faria de Oliveira, Adam Kupczyk, Xue Yantao)
-   os/bluestore: \_do_write_small fix head_pad
    ([pr#43757](https://github.com/ceph/ceph/pull/43757), dheart)
-   os/bluestore: avoid premature onode release
    ([pr#44724](https://github.com/ceph/ceph/pull/44724), Igor Fedotov)
-   os/bluestore: cap omap naming scheme upgrade transactoin
    ([pr#42958](https://github.com/ceph/ceph/pull/42958), Adam Kupczyk,
    Igor Fedotov)
-   os/bluestore: fix additional errors during missed shared blob repair
    ([pr#43887](https://github.com/ceph/ceph/pull/43887), Igor Fedotov)
-   os/bluestore: fix writing to invalid offset when repairing
    ([pr#43885](https://github.com/ceph/ceph/pull/43885), Igor Fedotov)
-   os/bluestore: list obj which equals to pend
    ([pr#44978](https://github.com/ceph/ceph/pull/44978), Mykola Golub,
    Kefu Chai)
-   os/bluestore: make shared blob fsck much less RAM-greedy
    ([pr#44614](https://github.com/ceph/ceph/pull/44614), Igor Fedotov)
-   os/bluestore: use proper prefix when removing undecodable Share Blob
    ([pr#43883](https://github.com/ceph/ceph/pull/43883), Igor Fedotov)
-   osd/OSDMap.cc: clean up pg_temp for nonexistent pgs
    ([pr#44097](https://github.com/ceph/ceph/pull/44097), Cory Snyder)
-   osd/PeeringState: separate history\'s pruub from pg\'s
    ([pr#44585](https://github.com/ceph/ceph/pull/44585), Sage Weil)
-   osd: fix \'ceph osd stop \<osd.nnn\>\' doesn\'t take effect
    ([pr#43962](https://github.com/ceph/ceph/pull/43962), tan changzhi)
-   osd: fix partial recovery become whole object recovery after restart
    osd ([pr#44165](https://github.com/ceph/ceph/pull/44165), Jianwei
    Zhang)
-   osd: re-cache peer_bytes on every peering state activate
    ([pr#43438](https://github.com/ceph/ceph/pull/43438), Mykola Golub)
-   osd: set r only if succeed in FillInVerifyExtent
    ([pr#44174](https://github.com/ceph/ceph/pull/44174), yanqiang-ux)
-   osdc: add set_error in BufferHead, when split set_error to right
    ([pr#44726](https://github.com/ceph/ceph/pull/44726), jiawd)
-   pybind/mgr/balancer: define Plan.{dump,show}()
    ([pr#43965](https://github.com/ceph/ceph/pull/43965), Kefu Chai)
-   qa/ceph-ansible: Bump OS version for centos
    ([pr#43658](https://github.com/ceph/ceph/pull/43658), Brad Hubbard)
-   qa/ceph-ansible: Pin to last compatible stable release
    ([pr#43557](https://github.com/ceph/ceph/pull/43557), Brad Hubbard)
-   qa/distros: Remove stale kubic distros
    ([pr#43788](https://github.com/ceph/ceph/pull/43788), Sebastian
    Wagner)
-   qa/mgr/dashboard/test_pool: don\'t check HEALTH_OK
    ([pr#43441](https://github.com/ceph/ceph/pull/43441), Ernesto
    Puerta)
-   qa/rgw: Fix vault token file access.case
    ([issue#51539](http://tracker.ceph.com/issues/51539),
    [pr#43963](https://github.com/ceph/ceph/pull/43963), Marcus Watts)
-   qa/rgw: bump tempest version to resolve dependency issue
    ([pr#43967](https://github.com/ceph/ceph/pull/43967), Casey Bodley)
-   qa/rgw: octopus branch targets ceph-octopus branch of java_s3tests
    ([pr#43810](https://github.com/ceph/ceph/pull/43810), Casey Bodley)
-   qa/run-tox-mgr-dashboard: Do not write to
    /tmp/test_sanitize_password...
    ([pr#44728](https://github.com/ceph/ceph/pull/44728), Kevin Zhao)
-   qa/run_xfstests_qemu.sh: stop reporting success without actually
    running any tests
    ([pr#44595](https://github.com/ceph/ceph/pull/44595), Ilya Dryomov)
-   qa/suites/rados/cephadm: use centos 8.stream
    ([pr#44929](https://github.com/ceph/ceph/pull/44929), Adam King,
    Sage Weil)
-   qa: account for split of the kclient \"metrics\" debugfs file
    ([pr#44270](https://github.com/ceph/ceph/pull/44270), Jeff Layton,
    Xiubo Li)
-   qa: miscellaneous perf suite fixes
    ([pr#44254](https://github.com/ceph/ceph/pull/44254), Neha Ojha)
-   qa: remove centos8 from supported distros
    ([pr#44864](https://github.com/ceph/ceph/pull/44864), Casey Bodley,
    Sage Weil)
-   rbd-mirror: fix mirror image removal
    ([pr#43663](https://github.com/ceph/ceph/pull/43663), Arthur
    Outhenin-Chalandre)
-   rbd-mirror: fix races in snapshot-based mirroring deletion
    propagation ([pr#44753](https://github.com/ceph/ceph/pull/44753),
    Ilya Dryomov)
-   rbd: add missing switch arguments for recognition by
    get_command_spec()
    ([pr#44741](https://github.com/ceph/ceph/pull/44741), Ilya Dryomov)
-   rgw/beast: optimizations for request timeout
    ([pr#43961](https://github.com/ceph/ceph/pull/43961), Mark Kogan,
    Casey Bodley)
-   rgw/rgw_rados: make RGW request IDs non-deterministic
    ([pr#43696](https://github.com/ceph/ceph/pull/43696), Cory Snyder)
-   rgw: clear buckets before calling list_buckets()
    ([pr#43381](https://github.com/ceph/ceph/pull/43381), Nikhil
    Kshirsagar)
-   rgw: disable prefetch in rgw_file to fix 3x read amplification
    ([pr#44170](https://github.com/ceph/ceph/pull/44170), Kajetan
    Janiak)
-   rgw: fix [bi put]{.title-ref} not using right bucket index shard
    ([pr#44167](https://github.com/ceph/ceph/pull/44167), J. Eric
    Ivancich)
-   rgw: fix bucket purge incomplete multipart uploads
    ([pr#43863](https://github.com/ceph/ceph/pull/43863), J. Eric
    Ivancich)
-   rgw: user stats showing 0 value for \"size_utilized\" and
    \"size_kb_utilized\" fields
    ([pr#44172](https://github.com/ceph/ceph/pull/44172), J. Eric
    Ivancich)
-   rgwlc: remove lc entry on bucket delete
    ([pr#44730](https://github.com/ceph/ceph/pull/44730), Matt Benjamin)
-   rpm, debian: move smartmontools and nvme-cli to ceph-base
    ([pr#44177](https://github.com/ceph/ceph/pull/44177), Yaarit Hatuka)

## v15.2.15 Octopus

This is the 15th backport release in the Octopus series. We recommend
all users update to this release.

### Notable Changes

-   The default value of [osd_client_message_cap]{.title-ref} has been
    set to 256, to provide better flow control by limiting maximum
    number of in-flight client requests.
-   A new ceph-erasure-code-tool has been added to help manually recover
    an object from a damaged PG.

### Changelog

-   auth,mon: don\'t log \"unable to find a keyring\" error when key is
    given ([pr#43312](https://github.com/ceph/ceph/pull/43312), Ilya
    Dryomov)
-   ceph-monstore-tool: use a large enough paxos/{first,last}\_committed
    ([issue#38219](http://tracker.ceph.com/issues/38219),
    [pr#43263](https://github.com/ceph/ceph/pull/43263), Kefu Chai)
-   ceph-volume/tests: retry when destroying osd
    ([pr#42547](https://github.com/ceph/ceph/pull/42547), Guillaume
    Abrioux)
-   ceph-volume: disable cache for blkid calls
    ([pr#41115](https://github.com/ceph/ceph/pull/41115), Rafał
    Wądołowski)
-   ceph-volume: fix batch report and respect ceph.conf config values
    ([pr#41715](https://github.com/ceph/ceph/pull/41715), Andrew Schoen)
-   ceph-volume: fix lvm activate \--all \--no-systemd
    ([pr#43268](https://github.com/ceph/ceph/pull/43268), Dimitri
    Savineau)
-   ceph-volume: fix lvm activate arguments
    ([pr#43117](https://github.com/ceph/ceph/pull/43117), Dimitri
    Savineau)
-   ceph-volume: fix lvm migrate without args
    ([pr#43111](https://github.com/ceph/ceph/pull/43111), Dimitri
    Savineau)
-   ceph-volume: fix raw list with logical partition
    ([pr#43088](https://github.com/ceph/ceph/pull/43088), Guillaume
    Abrioux, Dimitri Savineau)
-   ceph-volume: lvm batch: fast_allocations(): avoid ZeroDivisionError
    ([pr#42494](https://github.com/ceph/ceph/pull/42494), Jonas Zeiger)
-   ceph-volume: pvs \--noheadings replace pvs \--no-heading
    ([pr#43077](https://github.com/ceph/ceph/pull/43077), FengJiankui)
-   ceph-volume: remove \--all ref from deactivate help
    ([pr#43097](https://github.com/ceph/ceph/pull/43097), Dimitri
    Savineau)
-   ceph-volume: support no_systemd with lvm migrate
    ([pr#43092](https://github.com/ceph/ceph/pull/43092), Dimitri
    Savineau)
-   ceph-volume: work around phantom atari partitions
    ([pr#42752](https://github.com/ceph/ceph/pull/42752), Blaine
    Gardner)
-   ceph.spec: selinux scripts respect CEPH_AUTO_RESTART_ON_UPGRADE
    ([pr#43234](https://github.com/ceph/ceph/pull/43234), Dan van der
    Ster)
-   cephadm: add thread ident to log messages
    ([pr#43133](https://github.com/ceph/ceph/pull/43133), Michael
    Fritch)
-   cephadm: default to quay.io, not docker.io
    ([pr#42533](https://github.com/ceph/ceph/pull/42533), Sage Weil)
-   cephadm: use quay, not docker
    ([pr#43094](https://github.com/ceph/ceph/pull/43094), Sage Weil,
    Juan Miguel Olmo Martínez)
-   cmake: Replace boost download url
    ([pr#42694](https://github.com/ceph/ceph/pull/42694), Rafał
    Wądołowski)
-   cmake: s/Python_EXECUTABLE/Python3_EXECUTABLE/
    ([pr#43265](https://github.com/ceph/ceph/pull/43265), Michael
    Fritch)
-   common/buffer: fix SIGABRT in rebuild_aligned_size_and_memory
    ([pr#42975](https://github.com/ceph/ceph/pull/42975), Yin Congmin)
-   common/options: Set osd_client_message_cap to 256
    ([pr#42616](https://github.com/ceph/ceph/pull/42616), Mark Nelson)
-   doc/ceph-volume: add lvm migrate/new-db/new-wal
    ([pr#43090](https://github.com/ceph/ceph/pull/43090), Dimitri
    Savineau)
-   Don\'t persist report data
    ([pr#42670](https://github.com/ceph/ceph/pull/42670), Brad Hubbard)
-   krbd: escape udev_enumerate_add_match_sysattr values
    ([pr#42968](https://github.com/ceph/ceph/pull/42968), Ilya Dryomov)
-   mgr/cephadm: pass \--container-init to cephadm if specified
    ([pr#42666](https://github.com/ceph/ceph/pull/42666), Tim Serong)
-   mgr/dashboard: cephadm e2e start script: add \--expanded option
    ([pr#42794](https://github.com/ceph/ceph/pull/42794), Alfonso
    Martínez)
-   mgr/dashboard: deprecated variable usage in Grafana dashboards
    ([pr#43189](https://github.com/ceph/ceph/pull/43189), Patrick
    Seidensal)
-   mgr/dashboard: Incorrect MTU mismatch warning
    ([pr#43186](https://github.com/ceph/ceph/pull/43186), Aashish
    Sharma)
-   mgr/dashboard: stats=false not working when listing buckets
    ([pr#42892](https://github.com/ceph/ceph/pull/42892), Avan Thakkar)
-   mgr/influx: use \"N/A\" for unknown hostname
    ([pr#43369](https://github.com/ceph/ceph/pull/43369), Kefu Chai)
-   mgr/prometheus: Fix metric types from gauge to counter
    ([pr#42674](https://github.com/ceph/ceph/pull/42674), Patrick
    Seidensal)
-   mon/OSDMonitor: account for PG merging in epoch_by_pg accounting
    ([pr#42837](https://github.com/ceph/ceph/pull/42837), Dan van der
    Ster)
-   mon/PGMap: remove DIRTY field in [ceph df detail]{.title-ref} when
    cache tiering is not in use
    ([pr#42862](https://github.com/ceph/ceph/pull/42862), Deepika
    Upadhyay)
-   mon: return -EINVAL when handling unknown option in \'ceph osd pool
    get\' ([pr#43266](https://github.com/ceph/ceph/pull/43266), Zhao
    Cuicui)
-   monitoring/grafana/cluster: use per-unit max and limit values
    ([pr#42675](https://github.com/ceph/ceph/pull/42675), David Caro)
-   monitoring: fix Physical Device Latency unit
    ([pr#42676](https://github.com/ceph/ceph/pull/42676), Seena Fallah)
-   os/bluestore: accept undecodable multi-block bluefs transactions on
    log ([pr#43024](https://github.com/ceph/ceph/pull/43024), Igor
    Fedotov)
-   os/bluestore: fix bluefs migrate command
    ([pr#43140](https://github.com/ceph/ceph/pull/43140), Igor Fedotov)
-   os/bluestore: fix using incomplete bluefs log when dumping it
    ([pr#43008](https://github.com/ceph/ceph/pull/43008), Igor Fedotov)
-   osd/OSD: mkfs need wait for transcation completely finish
    ([pr#43418](https://github.com/ceph/ceph/pull/43418), Chen Fan)
-   pybind/rbd: fix mirror_image_get_status
    ([pr#42971](https://github.com/ceph/ceph/pull/42971), Ilya Dryomov,
    Will Smith)
-   qa/mgr/dashboard: add extra wait to test
    ([pr#43352](https://github.com/ceph/ceph/pull/43352), Ernesto
    Puerta)
-   qa/suites/rados: use centos_8.3_container_tools_3.0.yaml
    ([pr#43102](https://github.com/ceph/ceph/pull/43102), Sebastian
    Wagner)
-   qa/tests: advanced version to 15.2.14 to match the latest release
    ([pr#42761](https://github.com/ceph/ceph/pull/42761), Yuri
    Weinstein)
-   qa/workunits/mon/test_mon_config_key: use subprocess.run() instead
    of proc.communicate()
    ([pr#42498](https://github.com/ceph/ceph/pull/42498), Kefu Chai)
-   rbd-mirror: add perf counters to snapshot replayed
    ([pr#42986](https://github.com/ceph/ceph/pull/42986), Arthur
    Outhenin-Chalandre)
-   rbd-mirror: fix potential async op tracker leak in
    start_image_replayers
    ([pr#42978](https://github.com/ceph/ceph/pull/42978), Mykola Golub)
-   rbd-mirror: unbreak one-way snapshot-based mirroring
    ([pr#43314](https://github.com/ceph/ceph/pull/43314), Ilya Dryomov)
-   rgw : add check for tenant provided in RGWCreateRole
    ([pr#43270](https://github.com/ceph/ceph/pull/43270), caolei)
-   rgw: avoid infinite loop when deleting a bucket
    ([issue#49206](http://tracker.ceph.com/issues/49206),
    [pr#43272](https://github.com/ceph/ceph/pull/43272), Jeegn Chen)
-   rgw: fail as expected when set/delete-bucket-website attempted on a
    non-exis... ([pr#43424](https://github.com/ceph/ceph/pull/43424),
    xiangrui meng)
-   rgw: fix sts memory leak
    ([pr#43349](https://github.com/ceph/ceph/pull/43349), yuliyang_yewu)
-   rgw: remove quota soft threshold
    ([pr#43271](https://github.com/ceph/ceph/pull/43271), Zulai Wang)
-   rgw: when deleted obj removed in versioned bucket, extra del-marker
    added ([pr#43273](https://github.com/ceph/ceph/pull/43273), J. Eric
    Ivancich)
-   run-make-check.sh: Increase failure output log size
    ([pr#42849](https://github.com/ceph/ceph/pull/42849), David
    Galloway)
-   tools/erasure-code: new tool to encode/decode files
    ([pr#43407](https://github.com/ceph/ceph/pull/43407), Mykola Golub)

## v15.2.14 Octopus

This is the 14th backport release in the Octopus series. We recommend
all users update to this release.

### Notable Changes

-   RGW: It is possible to specify ssl options and ciphers for beast
    frontend now. The default ssl options setting is
    \"no_sslv2:no_sslv3:no_tlsv1:no_tlsv1_1\". If you want to return
    back the old behavior add \'ssl_options=\' (empty) to
    `rgw frontends` configuration.
-   CephFS: old clusters (pre-Jewel) that did not use CephFS have legacy
    data structures in the ceph-mon stores. These structures are not
    understood by Pacific monitors. With Octopus v15.2.14, the monitors
    have been taught to flush and trim these old structures out in
    preparation for an upgrade to Pacific or Quincy. For more
    information, see [Issue 51673
    \<https://tracker.ceph.com/issues/51673\>]{.title-ref}.
-   [ceph-mgr-modules-core]{.title-ref} debian package does not
    recommend [ceph-mgr-rook]{.title-ref} anymore. As the latter depends
    on [python3-numpy]{.title-ref} which cannot be imported in different
    Python sub-interpreters multi-times if the version of
    [python3-numpy]{.title-ref} is older than 1.19. Since
    [apt-get]{.title-ref} installs the [Recommends]{.title-ref} packages
    by default, [ceph-mgr-rook]{.title-ref} was always installed along
    with [ceph-mgr]{.title-ref} debian package as an indirect
    dependency. If your workflow depends on this behavior, you might
    want to install [ceph-mgr-rook]{.title-ref} separately.
-   Several bug fixes in BlueStore, including a fix for an unexpected
    ENOSPC bug in Avl/Hybrid allocators.
-   Includes a fix for a bug that affects recovery below *min_size* for
    EC pools.

### Changelog

-   bind on loopback address if no other addresses are available
    ([pr#42478](https://github.com/ceph/ceph/pull/42478), Kefu Chai,
    Matthew Oliver)
-   bluestore: use string_view and strip trailing slash for dir listing
    ([pr#41757](https://github.com/ceph/ceph/pull/41757), Jonas Jelten,
    Kefu Chai)
-   ceph-volume/tests: update ansible environment variables in tox
    ([pr#42491](https://github.com/ceph/ceph/pull/42491), Dimitri
    Savineau)
-   ceph-volume: Consider /dev/root as mounted
    ([pr#41584](https://github.com/ceph/ceph/pull/41584), David Caro)
-   ceph-volume: implement bluefs volume migration
    ([pr#42377](https://github.com/ceph/ceph/pull/42377), Igor Fedotov,
    Kefu Chai)
-   ceph: ignore BrokenPipeError when printing help
    ([pr#41586](https://github.com/ceph/ceph/pull/41586), Ernesto
    Puerta)
-   cephadm: fix escaping/quoting of stderr-prefix arg for ceph daemons
    ([pr#40948](https://github.com/ceph/ceph/pull/40948), Michael
    Fritch, Sage Weil)
-   cephadm: fix port_in_use when IPv6 is disabled
    ([pr#41602](https://github.com/ceph/ceph/pull/41602), Patrick
    Seidensal)
-   cephfs: client: add ability to lookup snapped inodes by inode number
    ([pr#40768](https://github.com/ceph/ceph/pull/40768), Jeff Layton,
    Xiubo Li)
-   cls/rgw: look for plain entries in non-ascii plain namespace too
    ([pr#41775](https://github.com/ceph/ceph/pull/41775), Mykola Golub)
-   cmake: build static libs if they are internal ones
    ([pr#39904](https://github.com/ceph/ceph/pull/39904), Kefu Chai)
-   crush/crush: ensure alignof(crush_work_bucket) is 1
    ([pr#41622](https://github.com/ceph/ceph/pull/41622), Kefu Chai)
-   debian/control: ceph-mgr-modules-core does not Recommend
    ceph-mgr-rook ([pr#41878](https://github.com/ceph/ceph/pull/41878),
    Kefu Chai)
-   doc/rados/operations: s/max_misplaced/target_max_misplaced_ratio/
    ([pr#41624](https://github.com/ceph/ceph/pull/41624), Kefu Chai)
-   librbd: don\'t stop at the first unremovable image when purging
    ([pr#41663](https://github.com/ceph/ceph/pull/41663), Ilya Dryomov)
-   librbd: global config overrides do not apply to in-use images
    ([pr#41763](https://github.com/ceph/ceph/pull/41763), Jason
    Dillaman)
-   make-dist: refuse to run if script path contains a colon
    ([pr#41087](https://github.com/ceph/ceph/pull/41087), Nathan Cutler)
-   mds: avoid journaling overhead for setxattr(\"ceph.dir.subvolume\")
    for no-op case ([pr#41996](https://github.com/ceph/ceph/pull/41996),
    Patrick Donnelly)
-   mds: completed_requests -\> num_completed_requests and dump
    num_completed_flushes
    ([pr#41625](https://github.com/ceph/ceph/pull/41625), Dan van der
    Ster)
-   mds: fix cpu_profiler asok crash
    ([pr#41767](https://github.com/ceph/ceph/pull/41767), liu shi)
-   mds: place the journaler pointer under the mds_lock
    ([pr#41626](https://github.com/ceph/ceph/pull/41626), Xiubo Li)
-   MDSMonitor: monitor crash after upgrade from ceph 15.2.13 to 16.2.4
    ([pr#42537](https://github.com/ceph/ceph/pull/42537), Patrick
    Donnelly)
-   mds: reject lookup ino requests for mds dirs
    ([pr#40782](https://github.com/ceph/ceph/pull/40782), Xiubo Li,
    Patrick Donnelly)
-   mgr/DaemonServer.cc: prevent mgr crashes caused by integer underflow
    that is triggered by large increases to pg_num/pgp_num
    ([pr#41764](https://github.com/ceph/ceph/pull/41764), Cory Snyder)
-   mgr/DaemonServer: skip redundant update of pgp_num_actual
    ([pr#42420](https://github.com/ceph/ceph/pull/42420), Dan van der
    Ster)
-   mgr/Dashboard: Remove erroneous elements in hosts-overview Grafana
    dashboard ([pr#41649](https://github.com/ceph/ceph/pull/41649),
    Malcolm Holmes)
-   mgr/cephadm: fix prometheus alerts
    ([pr#41660](https://github.com/ceph/ceph/pull/41660), Paul Cuzner,
    Sage Weil, Patrick Seidensal)
-   mgr/dashboard: Add configurable MOTD or wall notification
    ([pr#42412](https://github.com/ceph/ceph/pull/42412), Volker Theile)
-   mgr/dashboard: Fix bucket name input allowing space in the value
    ([pr#42241](https://github.com/ceph/ceph/pull/42241), Nizamudeen A)
-   mgr/dashboard: RGW buckets async validator performance enhancement
    and name constraints
    ([pr#42123](https://github.com/ceph/ceph/pull/42123), Nizamudeen A)
-   mgr/dashboard: User database migration has been cut out
    ([pr#42142](https://github.com/ceph/ceph/pull/42142), Volker Theile)
-   mgr/dashboard: disable NFSv3 support in dashboard
    ([pr#41199](https://github.com/ceph/ceph/pull/41199), Volker Theile)
-   mgr/dashboard: fix API docs link
    ([pr#41508](https://github.com/ceph/ceph/pull/41508), Avan Thakkar)
-   mgr/dashboard: fix OSD out count
    ([pr#42154](https://github.com/ceph/ceph/pull/42154), 胡玮文)
-   mgr/dashboard: fix OSDs Host details/overview grafana graphs
    ([issue#49769](http://tracker.ceph.com/issues/49769),
    [pr#41530](https://github.com/ceph/ceph/pull/41530), Alfonso
    Martínez, Michael Wodniok)
-   mgr/dashboard: fix bucket objects and size calculations
    ([pr#41647](https://github.com/ceph/ceph/pull/41647), Avan Thakkar)
-   mgr/dashboard: fix for right sidebar nav icon not clickable
    ([pr#42015](https://github.com/ceph/ceph/pull/42015), Aaryan Porwal)
-   mgr/dashboard: run cephadm-backend e2e tests with KCLI
    ([pr#42243](https://github.com/ceph/ceph/pull/42243), Alfonso
    Martínez)
-   mgr/dashboard: show partially deleted RBDs
    ([pr#41887](https://github.com/ceph/ceph/pull/41887), Tatjana
    Dehler)
-   mgr/telemetry: pass leaderboard flag even w/o ident
    ([pr#41870](https://github.com/ceph/ceph/pull/41870), Sage Weil)
-   mgr: do not load disabled modules
    ([pr#41617](https://github.com/ceph/ceph/pull/41617), Kefu Chai)
-   mon/MonClient: tolerate a rotating key that is slightly out of date
    ([pr#41449](https://github.com/ceph/ceph/pull/41449), Ilya Dryomov)
-   mon/OSDMonitor: drop stale failure_info even if can_mark_down()
    ([pr#41618](https://github.com/ceph/ceph/pull/41618), Kefu Chai)
-   mon: load stashed map before mkfs monmap
    ([pr#41621](https://github.com/ceph/ceph/pull/41621), Dan van der
    Ster)
-   os/bluestore: Remove possibility of replay log and file
    inconsistency ([pr#42374](https://github.com/ceph/ceph/pull/42374),
    Adam Kupczyk)
-   os/bluestore: compact db after bulk omap naming upgrade
    ([pr#42375](https://github.com/ceph/ceph/pull/42375), Igor Fedotov)
-   os/bluestore: fix erroneous SharedBlob record removal during repair
    ([pr#42373](https://github.com/ceph/ceph/pull/42373), Igor Fedotov)
-   os/bluestore: fix unexpected ENOSPC in Avl/Hybrid allocators
    ([pr#41658](https://github.com/ceph/ceph/pull/41658), Igor Fedotov)
-   os/bluestore: introduce multithireading sync for bluestore\'s
    repairer ([pr#41613](https://github.com/ceph/ceph/pull/41613), Igor
    Fedotov)
-   os/bluestore: tolerate zero length for allocators\'
    init\_\[add/rm\]\_free()
    ([pr#41612](https://github.com/ceph/ceph/pull/41612), Igor Fedotov)
-   osd/PG.cc: handle removal of pgmeta object
    ([pr#41623](https://github.com/ceph/ceph/pull/41623), Neha Ojha)
-   osd/PeeringState: fix acting_set_writeable min_size check
    ([pr#41609](https://github.com/ceph/ceph/pull/41609), Samuel Just)
-   osd/osd_type: use f-\>dump_unsigned() when appropriate
    ([pr#42257](https://github.com/ceph/ceph/pull/42257), Kefu Chai)
-   osd: clear data digest when write_trunc
    ([pr#41620](https://github.com/ceph/ceph/pull/41620), Zengran Zhang)
-   osd: fix scrub reschedule bug
    ([pr#41972](https://github.com/ceph/ceph/pull/41972), wencong wan)
-   osd: log snaptrim message to dout
    ([pr#42484](https://github.com/ceph/ceph/pull/42484), Arthur
    Outhenin-Chalandre)
-   osd: move down peers out from peer_purged
    ([pr#42239](https://github.com/ceph/ceph/pull/42239), Mykola Golub)
-   pacific: pybind/ceph_volume_client: stat on empty string
    ([pr#42161](https://github.com/ceph/ceph/pull/42161), Patrick
    Donnelly)
-   qa/\*/test_envlibrados_for_rocksdb.sh: install libarchive-3.3.3
    ([pr#42421](https://github.com/ceph/ceph/pull/42421), Neha Ojha)
-   qa/cephadm/upgrade: use v15.2.9 for cephadm tests
    ([pr#41568](https://github.com/ceph/ceph/pull/41568), Deepika
    Upadhyay)
-   qa/config/rados: add dispatch delay testing params
    ([pr#42180](https://github.com/ceph/ceph/pull/42180), Deepika
    Upadhyay)
-   qa/distros: move to latest version on supported distro\'s
    ([pr#41478](https://github.com/ceph/ceph/pull/41478), Josh Durgin,
    Yuri Weinstein, Deepika Upadhyay, Sage Weil, Kefu Chai, Patrick
    Donnelly, rakeshgm)
-   qa/suites/rados/perf: pin to 18.04
    ([pr#41922](https://github.com/ceph/ceph/pull/41922), Neha Ojha)
-   qa/suites/rados: add simultaneous scrubs to the thrasher
    ([pr#42422](https://github.com/ceph/ceph/pull/42422), Ronen
    Friedman)
-   qa/tasks/qemu: precise repos have been archived
    ([pr#41642](https://github.com/ceph/ceph/pull/41642), Ilya Dryomov)
-   qa/upgrade: disable update_features test_notify with older client as
    lockowner ([pr#41511](https://github.com/ceph/ceph/pull/41511),
    Deepika Upadhyay)
-   qa/workunits/rbd: use bionic version of qemu-iotests for focal
    ([pr#42025](https://github.com/ceph/ceph/pull/42025), Ilya Dryomov)
-   rbd-mirror: fix segfault in snapshot replayer shutdown
    ([pr#41502](https://github.com/ceph/ceph/pull/41502), Arthur
    Outhenin-Chalandre)
-   rbd: retrieve global config overrides from the MONs
    ([pr#41836](https://github.com/ceph/ceph/pull/41836), Ilya Dryomov,
    Jason Dillaman)
-   rgw : add check empty for sync url
    ([pr#41766](https://github.com/ceph/ceph/pull/41766), caolei)
-   rgw/amqp/kafka: prevent concurrent shutdowns from happening
    ([pr#40381](https://github.com/ceph/ceph/pull/40381), Yuval
    Lifshitz)
-   rgw/amqp/test: fix mock prototype for librabbitmq-0.11.0
    ([pr#41418](https://github.com/ceph/ceph/pull/41418), Yuval
    Lifshitz)
-   rgw/notifications: delete bucket notification object when empty
    ([pr#41412](https://github.com/ceph/ceph/pull/41412), Yuval
    Lifshitz)
-   rgw/rgw_file: Fix the return value of read() and readlink()
    ([pr#41416](https://github.com/ceph/ceph/pull/41416), Dai zhiwei,
    luo rixin)
-   rgw/sts: read_obj_policy() consults iam_user_policies on ENOENT
    ([pr#41415](https://github.com/ceph/ceph/pull/41415), Casey Bodley)
-   rgw: Backport 51674 to Octopus
    ([pr#42347](https://github.com/ceph/ceph/pull/42347), Adam C.
    Emerson)
-   rgw: Improve error message on email id reuse
    ([pr#41784](https://github.com/ceph/ceph/pull/41784), Ponnuvel
    Palaniyappan)
-   rgw: allow rgw-orphan-list to process multiple data pools
    ([pr#41417](https://github.com/ceph/ceph/pull/41417), J. Eric
    Ivancich)
-   rgw: allow to set ssl options and ciphers for beast frontend
    ([pr#42368](https://github.com/ceph/ceph/pull/42368), Mykola Golub)
-   rgw: check object locks in multi-object delete
    ([issue#47586](http://tracker.ceph.com/issues/47586),
    [pr#41031](https://github.com/ceph/ceph/pull/41031), Mark Houghton)
-   rgw: fix bucket object listing when marker matches prefix
    ([pr#41413](https://github.com/ceph/ceph/pull/41413), J. Eric
    Ivancich)
-   rgw: fix segfault related to explicit object manifest handling
    ([pr#41420](https://github.com/ceph/ceph/pull/41420), Mark Kogan)
-   rgw: limit rgw_gc_max_objs to RGW_SHARDS_PRIME_1
    ([pr#40383](https://github.com/ceph/ceph/pull/40383), Rafał
    Wądołowski)
-   rgw: qa/tasks/barbican.py: fix year2021 problem
    ([pr#40385](https://github.com/ceph/ceph/pull/40385), Marcus Watts)
-   rgw: radoslist incomplete multipart parts marker
    ([pr#40820](https://github.com/ceph/ceph/pull/40820), J. Eric
    Ivancich)
-   rgw: require bucket name in bucket chown
    ([pr#41765](https://github.com/ceph/ceph/pull/41765), Zulai Wang)
-   rgw: send headers of quota settings
    ([pr#41419](https://github.com/ceph/ceph/pull/41419), Or Friedmann)
-   rpm: drop use of \$FIRST_ARG in ceph-immutable-object-cache
    ([pr#42509](https://github.com/ceph/ceph/pull/42509), Nathan Cutler)
-   rpm: three spec file cleanups
    ([pr#42440](https://github.com/ceph/ceph/pull/42440), Nathan Cutler,
    Franck Bui)
-   test: bump DecayCounter.steady acceptable error
    ([pr#41619](https://github.com/ceph/ceph/pull/41619), Patrick
    Donnelly)

## v15.2.13 Octopus

This is the 13th backport release in the Octopus series. We recommend
all users update to this release.

### Notable Changes

-   RADOS: Ability to dynamically adjust trimming rate in the monitor
    and several other bug fixes.
-   A long-standing bug that prevented 32-bit and 64-bit client/server
    interoperability under msgr v2 has been fixed. In particular, mixing
    armv7l (armhf) and x86_64 or aarch64 servers in the same cluster now
    works.

### Changelog

-   blk/kernel: fix io_uring got (4) Interrupted system call
    ([pr#39899](https://github.com/ceph/ceph/pull/39899), Yanhu Cao)
-   ceph.spec.in: Enable tcmalloc on IBM Power and Z
    ([pr#39487](https://github.com/ceph/ceph/pull/39487), Nathan Cutler,
    Yaakov Selkowitz)
-   cephadm: [cephadm ls]{.title-ref} broken for SUSE downstream
    alertmanager container
    ([pr#39802](https://github.com/ceph/ceph/pull/39802), Patrick
    Seidensal)
-   cephadm: Allow to use paths in all \<\_devices\> drivegroup sections
    ([pr#40838](https://github.com/ceph/ceph/pull/40838), Juan Miguel
    Olmo Martínez)
-   cephadm: add docker.service dependency in systemd units
    ([pr#39804](https://github.com/ceph/ceph/pull/39804), Sage Weil)
-   cephadm: allow redeploy of daemons in error state if container
    running ([pr#39717](https://github.com/ceph/ceph/pull/39717), Adam
    King)
-   cephadm: fix failure when using \--apply-spec and \--shh-user
    ([pr#40737](https://github.com/ceph/ceph/pull/40737), Daniel
    Pivonka)
-   cephadm: run containers using [\--init]{.title-ref}
    ([pr#39914](https://github.com/ceph/ceph/pull/39914), Michael
    Fritch, Sage Weil)
-   cephfs: client: only check pool permissions for regular files
    ([pr#40779](https://github.com/ceph/ceph/pull/40779), Xiubo Li)
-   cephfs: client: wake up the front pos waiter
    ([pr#40771](https://github.com/ceph/ceph/pull/40771), Xiubo Li)
-   client: fire the finish_cap_snap() after buffer being flushed
    ([pr#40778](https://github.com/ceph/ceph/pull/40778), Xiubo Li)
-   cmake: build static libs if they are internal ones
    ([pr#40789](https://github.com/ceph/ceph/pull/40789), Kefu Chai)
-   cmake: define BOOST_ASIO_USE_TS_EXECUTOR_AS_DEFAULT globaly
    ([pr#40784](https://github.com/ceph/ceph/pull/40784), Kefu Chai)
-   common/buffer: adjust align before calling posix_memalign()
    ([pr#41247](https://github.com/ceph/ceph/pull/41247), Ilya Dryomov)
-   common/ipaddr: Allow binding on lo
    ([pr#39343](https://github.com/ceph/ceph/pull/39343), Thomas
    Goirand)
-   common/ipaddr: skip loopback interfaces named \'lo\' and test it
    ([pr#40424](https://github.com/ceph/ceph/pull/40424), Dan van der
    Ster)
-   common/mempool: Improve mempool shard selection
    ([pr#39978](https://github.com/ceph/ceph/pull/39978), singuliere,
    Adam Kupczyk)
-   common/options/global.yaml.in: increase default value of
    bluestore_cache_trim_max_skip_pinned
    ([pr#40919](https://github.com/ceph/ceph/pull/40919), Neha Ojha)
-   common/options: bluefs_buffered_io=true by default
    ([pr#40392](https://github.com/ceph/ceph/pull/40392), Dan van der
    Ster)
-   common: Fix assertion when disabling and re-enabling
    clog_to_monitors
    ([pr#39935](https://github.com/ceph/ceph/pull/39935), Gerald Yang)
-   common: remove log_early configuration option
    ([pr#40550](https://github.com/ceph/ceph/pull/40550), Changcheng
    Liu)
-   crush/CrushLocation: do not print logging message in constructor
    ([pr#40791](https://github.com/ceph/ceph/pull/40791), Alex Wu)
-   crush/CrushWrapper: update shadow trees on update_item()
    ([pr#39919](https://github.com/ceph/ceph/pull/39919), Sage Weil)
-   debian/ceph-common.postinst: do not chown cephadm log dirs
    ([pr#40275](https://github.com/ceph/ceph/pull/40275), Sage Weil)
-   doc/cephfs/nfs: Add note about cephadm NFS-Ganesha daemon port
    ([pr#40777](https://github.com/ceph/ceph/pull/40777), Varsha Rao)
-   doc/cephfs/nfs: Add rook pod restart note, export and log block
    example ([pr#40766](https://github.com/ceph/ceph/pull/40766), Varsha
    Rao)
-   doc: snap-schedule documentation
    ([pr#40775](https://github.com/ceph/ceph/pull/40775), Jan Fajerski)
-   install-deps.sh: remove existing ceph-libboost of different version
    ([pr#40286](https://github.com/ceph/ceph/pull/40286), Kefu Chai)
-   krbd: make sure the device node is accessible after the mapping
    ([pr#39968](https://github.com/ceph/ceph/pull/39968), Ilya Dryomov)
-   librbd/api: avoid retrieving more than max mirror image info records
    ([pr#39964](https://github.com/ceph/ceph/pull/39964), Jason
    Dillaman)
-   librbd/io: conditionally disable move optimization
    ([pr#39958](https://github.com/ceph/ceph/pull/39958), Jason
    Dillaman)
-   librbd/io: send alloc_hint when compression hint is set
    ([pr#40386](https://github.com/ceph/ceph/pull/40386), Jason
    Dillaman)
-   librbd/mirror/snapshot: avoid UnlinkPeerRequest with a unlinked peer
    ([pr#41302](https://github.com/ceph/ceph/pull/41302), Arthur
    Outhenin-Chalandre)
-   librbd: allow interrupted trash move request to be restarted
    ([pr#40387](https://github.com/ceph/ceph/pull/40387), Jason
    Dillaman)
-   librbd: explicitly disable readahead for writearound cache
    ([pr#39962](https://github.com/ceph/ceph/pull/39962), Jason
    Dillaman)
-   librbd: refuse to release exclusive lock when removing
    ([pr#39966](https://github.com/ceph/ceph/pull/39966), Ilya Dryomov)
-   mds: fix race of fetching large dirfrag
    ([pr#40774](https://github.com/ceph/ceph/pull/40774), Erqi Chen)
-   mds: trim cache regularly for standby-replay
    ([pr#40743](https://github.com/ceph/ceph/pull/40743), Xiubo Li,
    Patrick Donnelly)
-   mds: update defaults for recall configs
    ([pr#40764](https://github.com/ceph/ceph/pull/40764), Patrick
    Donnelly)
-   mgr/PyModule: put mgr_module_path before Py_GetPath()
    ([pr#40534](https://github.com/ceph/ceph/pull/40534), Kefu Chai)
-   mgr/cephadm: alias rgw-nfs -\> nfs
    ([pr#40009](https://github.com/ceph/ceph/pull/40009), Michael
    Fritch)
-   mgr/cephadm: on ssh connection error, advice chmod 0600
    ([pr#40823](https://github.com/ceph/ceph/pull/40823), Sebastian
    Wagner)
-   mgr/dashboard: Add badge to the Label column in Host List
    ([pr#40433](https://github.com/ceph/ceph/pull/40433), Nizamudeen A)
-   mgr/dashboard: Device health status is not getting listed under
    hosts section ([pr#40495](https://github.com/ceph/ceph/pull/40495),
    Aashish Sharma)
-   mgr/dashboard: Fix for alert notification message being undefined
    ([pr#40589](https://github.com/ceph/ceph/pull/40589), Nizamudeen A)
-   mgr/dashboard: Fix for broken User management role cloning
    ([pr#40399](https://github.com/ceph/ceph/pull/40399), Nizamudeen A)
-   mgr/dashboard: OSDs placement text is unreadable
    ([pr#41124](https://github.com/ceph/ceph/pull/41124), Aashish
    Sharma)
-   mgr/dashboard: Remove redundant pytest requirement
    ([pr#40657](https://github.com/ceph/ceph/pull/40657), Kefu Chai)
-   mgr/dashboard: Remove username and password from request body
    ([pr#41057](https://github.com/ceph/ceph/pull/41057), Nizamudeen A)
-   mgr/dashboard: Remove username, password fields from Manager
    Modules/dashboard,influx
    ([pr#40491](https://github.com/ceph/ceph/pull/40491), Aashish
    Sharma)
-   mgr/dashboard: Revoke read-only user\'s access to Manager modules
    ([pr#40649](https://github.com/ceph/ceph/pull/40649), Nizamudeen A)
-   mgr/dashboard: Splitting tenant\$user when creating rgw user
    ([pr#40297](https://github.com/ceph/ceph/pull/40297), Nizamudeen A)
-   mgr/dashboard: additional logging to SMART data retrieval
    ([pr#37972](https://github.com/ceph/ceph/pull/37972), Kiefer Chang,
    Patrick Seidensal)
-   mgr/dashboard: allow getting fresh inventory data from the
    orchestrator ([pr#41387](https://github.com/ceph/ceph/pull/41387),
    Kiefer Chang)
-   mgr/dashboard: debug nodeenv hangs
    ([pr#40816](https://github.com/ceph/ceph/pull/40816), Ernesto
    Puerta)
-   mgr/dashboard: filesystem pool size should use stored stat
    ([pr#41020](https://github.com/ceph/ceph/pull/41020), Avan Thakkar)
-   mgr/dashboard: fix base-href: revert it to previous approach
    ([pr#41252](https://github.com/ceph/ceph/pull/41252), Avan Thakkar)
-   mgr/dashboard: fix dashboard instance ssl certificate functionality
    ([pr#40001](https://github.com/ceph/ceph/pull/40001), Avan Thakkar)
-   mgr/dashboard: improve telemetry opt-in reminder notification
    message ([pr#40894](https://github.com/ceph/ceph/pull/40894), Waad
    Alkhoury)
-   mgr/dashboard: test prometheus rules through promtool
    ([pr#39987](https://github.com/ceph/ceph/pull/39987), Aashish
    Sharma, Kefu Chai)
-   mgr/progress: ensure progress stays between \[0,1\]
    ([pr#41311](https://github.com/ceph/ceph/pull/41311), Dan van der
    Ster)
-   mgr/rook: Add timezone info
    ([pr#39716](https://github.com/ceph/ceph/pull/39716), Varsha Rao)
-   mgr/telemetry: check if \'ident\' channel is active
    ([pr#39922](https://github.com/ceph/ceph/pull/39922), Sage Weil,
    Yaarit Hatuka)
-   mgr/volumes: Retain suid guid bits in clone
    ([pr#40268](https://github.com/ceph/ceph/pull/40268), Kotresh HR)
-   mgr: fix deadlock in ActivePyModules::get_osdmap()
    ([pr#39341](https://github.com/ceph/ceph/pull/39341), peng jiaqi)
-   mgr: relax osd ok-to-stop condition on degraded pgs
    ([pr#39887](https://github.com/ceph/ceph/pull/39887), Xuehan Xu)
-   mgr: update mon metadata when monmap is updated
    ([pr#39219](https://github.com/ceph/ceph/pull/39219), Kefu Chai)
-   mon/ConfigMap: fix stray option leak
    ([pr#40298](https://github.com/ceph/ceph/pull/40298), Sage Weil)
-   mon/MgrMonitor: populate available_modules from promote_standby()
    ([pr#40757](https://github.com/ceph/ceph/pull/40757), Sage Weil)
-   mon/MonClient: reset authenticate_err in \_reopen_session()
    ([pr#41017](https://github.com/ceph/ceph/pull/41017), Ilya Dryomov)
-   mon/OSDMonitor: drop stale failure_info after a grace period
    ([pr#40558](https://github.com/ceph/ceph/pull/40558), Kefu Chai)
-   mon/OSDMonitor: fix safety/idempotency of {set,rm}-device-class
    ([pr#40276](https://github.com/ceph/ceph/pull/40276), Sage Weil)
-   mon: Modifying trim logic to change paxos_service_trim_max
    dynamically ([pr#40699](https://github.com/ceph/ceph/pull/40699),
    Aishwarya Mathuria)
-   mon: check mdsmap is resizeable before promoting standby-replay
    ([pr#40783](https://github.com/ceph/ceph/pull/40783), Patrick
    Donnelly)
-   monmaptool: Don\'t call set_port on an invalid address
    ([pr#40758](https://github.com/ceph/ceph/pull/40758), Brad Hubbard,
    Kefu Chai)
-   mount.ceph: collect v2 addresses for non-legacy ms_mode options
    ([pr#40763](https://github.com/ceph/ceph/pull/40763), Jeff Layton)
-   os/FileStore: don\'t propagate split/merge error to
    \"create\"/\"remove\"
    ([pr#40988](https://github.com/ceph/ceph/pull/40988), Mykola Golub)
-   os/FileStore: fix to handle readdir error correctly
    ([pr#41237](https://github.com/ceph/ceph/pull/41237), Misono
    Tomohiro)
-   os/bluestore/BlueFS: do not \_flush_range deleted files
    ([pr#40793](https://github.com/ceph/ceph/pull/40793), weixinwei)
-   os/bluestore/BlueFS: use iterator_impl::copy instead of
    bufferlist::c_str() to avoid bufferlist rebuild
    ([pr#39884](https://github.com/ceph/ceph/pull/39884), weixinwei)
-   os/bluestore: Make Onode::put/get resiliant to split_cache
    ([pr#40441](https://github.com/ceph/ceph/pull/40441), Igor Fedotov,
    Adam Kupczyk)
-   os/bluestore: be more verbose in \_open_super_meta by default
    ([pr#41061](https://github.com/ceph/ceph/pull/41061), Igor Fedotov)
-   osd/OSDMap: An empty bucket or OSD is not an error
    ([pr#39970](https://github.com/ceph/ceph/pull/39970), Brad Hubbard)
-   osd: add osd_fast_shutdown_notify_mon option (default false)
    ([issue#46978](http://tracker.ceph.com/issues/46978),
    [pr#40013](https://github.com/ceph/ceph/pull/40013), Mauricio Faria
    de Oliveira)
-   osd: compute OSD\'s space usage ratio via raw space utilization
    ([pr#41112](https://github.com/ceph/ceph/pull/41112), Igor Fedotov)
-   osd: do not dump an osd multiple times
    ([pr#40788](https://github.com/ceph/ceph/pull/40788), Xue Yantao)
-   osd: don\'t assert in-flight backfill is always in recovery list
    ([pr#41321](https://github.com/ceph/ceph/pull/41321), Mykola Golub)
-   osd: fix potential null pointer dereference when sending ping
    ([pr#40277](https://github.com/ceph/ceph/pull/40277), Mykola Golub)
-   osd: propagate base pool application_metadata to tiers
    ([pr#40274](https://github.com/ceph/ceph/pull/40274), Sage Weil)
-   packaging: require ceph-common for immutable object cache daemon
    ([pr#40666](https://github.com/ceph/ceph/pull/40666), Ilya Dryomov)
-   pybind/ceph_argparse.py: use a safe value for timeout
    ([pr#40476](https://github.com/ceph/ceph/pull/40476), Kefu Chai)
-   pybind/cephfs: DT_REG and DT_LNK values are wrong
    ([pr#40770](https://github.com/ceph/ceph/pull/40770), Varsha Rao)
-   pybind/mgr/balancer/module.py: assign weight-sets to all buckets
    before balancing
    ([pr#40127](https://github.com/ceph/ceph/pull/40127), Neha Ojha)
-   pybind/mgr/dashboard: bump flake8 to 3.9.0
    ([pr#40492](https://github.com/ceph/ceph/pull/40492), Kefu Chai,
    Volker Theile)
-   qa/\*/thrash_cache_writeback_proxy_none.yaml: disable writeback
    overlay tests ([pr#39578](https://github.com/ceph/ceph/pull/39578),
    Neha Ojha)
-   qa/ceph-ansible: Update ansible version and ceph_stable_release
    ([pr#40945](https://github.com/ceph/ceph/pull/40945), Brad Hubbard)
-   qa/suites/krbd: address recent issues caused by newer kernels
    ([pr#40065](https://github.com/ceph/ceph/pull/40065), Ilya Dryomov)
-   qa/suites/rados/cephadm/upgrade: change starting version by distro
    ([pr#40364](https://github.com/ceph/ceph/pull/40364), Sage Weil)
-   qa/suites/rados/cephadm: rm ubuntu_18.04_podman
    ([pr#39949](https://github.com/ceph/ceph/pull/39949), Sebastian
    Wagner)
-   qa/suites/rados/singletone: whitelist MON_DOWN when injecting msgr
    errors ([pr#40138](https://github.com/ceph/ceph/pull/40138), Sage
    Weil)
-   qa/tasks/mgr/test_progress.py: remove calling of
    \_osd_in_out_completed_events_count()
    ([pr#40225](https://github.com/ceph/ceph/pull/40225), Kamoltat)
-   qa/tasks/mgr/test_progress: fix wait_until_equal
    ([pr#39360](https://github.com/ceph/ceph/pull/39360), Kamoltat)
-   qa/tasks/vstart_runner.py: start max required mgrs
    ([pr#40792](https://github.com/ceph/ceph/pull/40792), Alfonso
    Martínez)
-   qa/tests: advanced octopus initial version to 15.2.10
    ([pr#41228](https://github.com/ceph/ceph/pull/41228), Yuri
    Weinstein)
-   qa: add sleep for blocklisting to take effect
    ([pr#40773](https://github.com/ceph/ceph/pull/40773), Patrick
    Donnelly)
-   qa: bump osd heartbeat grace for ffsb workload
    ([pr#40767](https://github.com/ceph/ceph/pull/40767), Patrick
    Donnelly)
-   qa: delete all fs during tearDown
    ([pr#40772](https://github.com/ceph/ceph/pull/40772), Patrick
    Donnelly)
-   qa: for the latest kclient it will also return EIO
    ([pr#40765](https://github.com/ceph/ceph/pull/40765), Xiubo Li)
-   qa: krbd_blkroset.t: update for separate hw and user read-only flags
    ([pr#40211](https://github.com/ceph/ceph/pull/40211), Ilya Dryomov)
-   rbd-mirror: bad state and crashes in snapshot-based mirroring
    ([pr#39961](https://github.com/ceph/ceph/pull/39961), Jason
    Dillaman)
-   rbd-mirror: delay update snapshot mirror image state
    ([pr#39967](https://github.com/ceph/ceph/pull/39967), Jason
    Dillaman)
-   rbd-mirror: fix UB while registering perf counters
    ([pr#40790](https://github.com/ceph/ceph/pull/40790), Arthur
    Outhenin-Chalandre)
-   rbd/bench: include used headers
    ([pr#40388](https://github.com/ceph/ceph/pull/40388), Kefu Chai)
-   rgw/amqp: fix race condition in amqp manager initialization
    ([pr#40382](https://github.com/ceph/ceph/pull/40382), Yuval
    Lifshitz)
-   rgw/http: add timeout to http client
    ([pr#40384](https://github.com/ceph/ceph/pull/40384), Yuval
    Lifshitz)
-   rgw/notification: support GetTopicAttributes API
    ([pr#40812](https://github.com/ceph/ceph/pull/40812), Yuval
    Lifshitz)
-   rgw/notification: trigger notifications on changes from any user
    ([pr#40029](https://github.com/ceph/ceph/pull/40029), Yuval
    Lifshitz)
-   rgw: Use correct bucket info when put or get large object with swift
    ([pr#40296](https://github.com/ceph/ceph/pull/40296), zhiming zhang,
    yupeng chen)
-   rgw: add MD5 in forward_request
    ([pr#39758](https://github.com/ceph/ceph/pull/39758), caolei)
-   rgw: allow rgw-orphan-list to handle intermediate files w/ binary
    data ([pr#39766](https://github.com/ceph/ceph/pull/39766), J. Eric
    Ivancich)
-   rgw: catch non int exception
    ([pr#39746](https://github.com/ceph/ceph/pull/39746), caolei)
-   rgw: during reshard lock contention, adjust logging
    ([pr#41157](https://github.com/ceph/ceph/pull/41157), J. Eric
    Ivancich)
-   rgw: fix sts get_session_token duration check failed
    ([pr#39954](https://github.com/ceph/ceph/pull/39954), yuliyang_yewu)
-   rgw: multisite: fix single-part-MPU object etag misidentify problem
    ([pr#39611](https://github.com/ceph/ceph/pull/39611), Yang Honggang)
-   rgw: objectlock: improve client error messages
    ([pr#40755](https://github.com/ceph/ceph/pull/40755), Matt Benjamin)
-   rgw: return error when trying to copy encrypted object without key
    ([pr#40672](https://github.com/ceph/ceph/pull/40672), Ilsoo Byun)
-   rgw: tooling to locate rgw objects with missing rados components
    ([pr#39785](https://github.com/ceph/ceph/pull/39785), Michael
    Kidd, J. Eric Ivancich)
-   run-make-check.sh: let ctest generate XML output
    ([pr#40406](https://github.com/ceph/ceph/pull/40406), Kefu Chai)
-   src/global/signal_handler.h: fix preprocessor logic for alpine
    ([pr#39940](https://github.com/ceph/ceph/pull/39940), Duncan
    Bellamy)
-   test/rbd-mirror: fix broken ceph_test_rbd_mirror_random_write
    ([pr#39965](https://github.com/ceph/ceph/pull/39965), Jason
    Dillaman)
-   test/rgw: test_datalog_autotrim filters out new entries
    ([pr#40673](https://github.com/ceph/ceph/pull/40673), Casey Bodley)
-   test: cancelling both noscrub \*and\* nodeep-scrub
    ([pr#40278](https://github.com/ceph/ceph/pull/40278), Ronen
    Friedman)
-   test: reduce number of threads to 32 in LibCephFS.ShutdownRace
    ([pr#40776](https://github.com/ceph/ceph/pull/40776), Jeff Layton)
-   test: use std::atomic\<bool\> instead of volatile for cb_done var
    ([pr#40708](https://github.com/ceph/ceph/pull/40708), Jeff Layton)
-   tests: ceph_test_rados_api_watch_notify: Allow for reconnect
    ([pr#40756](https://github.com/ceph/ceph/pull/40756), Brad Hubbard)
-   tools/cephfs: don\'t bind to public_addr
    ([pr#40762](https://github.com/ceph/ceph/pull/40762), \"Yan,
    Zheng\")
-   vstart.sh: disable \"auth_allow_insecure_global_id_reclaim\"
    ([pr#40958](https://github.com/ceph/ceph/pull/40958), Kefu Chai)

## v15.2.12 Octopus

This is a hotfix release addressing a number of security issues and
regressions. We recommend all users update to this release.

### Changelog

-   mgr/dashboard: fix base-href: revert it to previous approach
    ([issue#50684](https://tracker.ceph.com/issues/50684), Avan Thakkar)
-   mgr/dashboard: fix cookie injection issue
    (`CVE-2021-3509`{.interpreted-text role="ref"}, Ernesto Puerta)
-   rgw: RGWSwiftWebsiteHandler::is_web_dir checks empty subdir_name
    (`CVE-2021-3531`{.interpreted-text role="ref"}, Felix Huettner)
-   rgw: sanitize r in s3 CORSConfiguration\'s ExposeHeader
    (`CVE-2021-3524`{.interpreted-text role="ref"}, Sergey Bobrov, Casey
    Bodley)

## v15.2.11 Octopus

This is the 11th bugfix release in the Octopus stable series. It
addresses a security vulnerability in the Ceph authentication framework.

We recommend all Octopus users upgrade.

### Security fixes

-   This release includes a security fix that ensures the global_id
    value (a numeric value that should be unique for every authenticated
    client or daemon in the cluster) is reclaimed after a network
    disconnect or ticket renewal in a secure fashion. Two new health
    alerts may appear during the upgrade indicating that there are
    clients or daemons that are not yet patched with the appropriate
    fix.

    To temporarily mute the health alerts around insecure clients for
    the duration of the upgrade, you may want to:

        ceph health mute AUTH_INSECURE_GLOBAL_ID_RECLAIM 1h
        ceph health mute AUTH_INSECURE_GLOBAL_ID_RECLAIM_ALLOWED 1h

    For more information, see `CVE-2021-20288`{.interpreted-text
    role="ref"}.

## v15.2.10 Octopus

This is the 10th backport release in the Octopus series. We recommend
all users update to this release.

### Notable Changes

-   The containers include an updated tcmalloc that avoids crashes seen
    on 15.2.9. See [issue#49618](https://tracker.ceph.com/issues/49618)
    for details.

-   RADOS: BlueStore handling of huge(\>4GB) writes from RocksDB to
    BlueFS has been fixed.

-   When upgrading from a previous cephadm release, systemctl may hang
    when trying to start or restart the monitoring containers. (This is
    caused by a change in the systemd unit to use `type=forking`.) After
    the upgrade, please run:

        ceph orch redeploy nfs
        ceph orch redeploy iscsi
        ceph orch redeploy node-exporter
        ceph orch redeploy prometheus
        ceph orch redeploy grafana
        ceph orch redeploy alertmanager

### Changelog

-   octopus: .github: add workflow for adding label and milestone
    ([pr#39890](https://github.com/ceph/ceph/pull/39890), Kefu Chai,
    Ernesto Puerta)
-   octopus: ceph-volume: Fix usage of is_lv
    ([pr#39220](https://github.com/ceph/ceph/pull/39220), Michał
    Nasiadka)
-   octopus: ceph-volume: Update batch.py
    ([pr#39469](https://github.com/ceph/ceph/pull/39469), shenjiatong)
-   octopus: ceph-volume: add some flexibility to bytes_to_extents
    ([pr#39271](https://github.com/ceph/ceph/pull/39271), Jan Fajerski)
-   octopus: ceph-volume: pass \--filter-for-batch from drive-group
    subcommand ([pr#39523](https://github.com/ceph/ceph/pull/39523), Jan
    Fajerski)
-   octopus: cephadm: Delete the unnecessary error line in open_ports
    ([pr#39633](https://github.com/ceph/ceph/pull/39633), Donggyu Park)
-   octopus: cephadm: fix \'inspect\' and \'pull\'
    ([pr#39715](https://github.com/ceph/ceph/pull/39715), Sage Weil)
-   octopus: cephfs: pybind/ceph_volume_client: Update the \'volumes\'
    key to \'subvolumes\' in auth-metadata file
    ([pr#39906](https://github.com/ceph/ceph/pull/39906), Kotresh HR)
-   octopus: cmake: boost\>=1.74 adds
    BOOST_ASIO_USE_TS_EXECUTOR_AS_DEFAULT to radosgw
    ([pr#39885](https://github.com/ceph/ceph/pull/39885), Casey Bodley)
-   octopus: librbd: allow disabling journaling for snapshot based
    mirroring image
    ([pr#39864](https://github.com/ceph/ceph/pull/39864), Mykola Golub)
-   octopus: librbd: correct incremental deep-copy object-map
    inconsistencies
    ([pr#39577](https://github.com/ceph/ceph/pull/39577), Mykola Golub,
    Jason Dillaman)
-   octopus: librbd: don\'t log error if get mirror status fails due to
    mirroring disabled
    ([pr#39862](https://github.com/ceph/ceph/pull/39862), Mykola Golub)
-   octopus: librbd: use on-disk image name when storing mirror snapshot
    state ([pr#39866](https://github.com/ceph/ceph/pull/39866), Mykola
    Golub)
-   octopus: mgr/dashboard/monitoring: upgrade Grafana version due to
    CVE-2020-13379 ([pr#39306](https://github.com/ceph/ceph/pull/39306),
    Alfonso Martínez)
-   octopus: mgr/dashboard: CLI commands: read passwords from file
    ([pr#39436](https://github.com/ceph/ceph/pull/39436), Ernesto
    Puerta, Alfonso Martínez, Juan Miguel Olmo Martínez)
-   octopus: mgr/dashboard: Fix for incorrect validation in rgw user
    form ([pr#39027](https://github.com/ceph/ceph/pull/39027),
    Nizamudeen A)
-   octopus: mgr/dashboard: Fix missing root path of each session for
    CephFS ([pr#39868](https://github.com/ceph/ceph/pull/39868),
    Yongseok Oh)
-   octopus: mgr/dashboard: Monitoring alert badge includes suppressed
    alerts ([pr#39512](https://github.com/ceph/ceph/pull/39512), Aashish
    Sharma)
-   octopus: mgr/dashboard: add ssl verify option for prometheus and
    alert manager ([pr#39872](https://github.com/ceph/ceph/pull/39872),
    Jean \"henyxia\" Wasilewski)
-   octopus: mgr/dashboard: avoid using document.write()
    ([pr#39527](https://github.com/ceph/ceph/pull/39527), Avan Thakkar)
-   octopus: mgr/dashboard: delete EOF when reading passwords from file
    ([pr#40155](https://github.com/ceph/ceph/pull/40155), Alfonso
    Martínez)
-   octopus: mgr/dashboard: fix MTU Mismatch alert
    ([pr#39854](https://github.com/ceph/ceph/pull/39854), Aashish
    Sharma)
-   octopus: mgr/dashboard: fix issues related with PyJWT versions
    \>=2.0.0 ([pr#39836](https://github.com/ceph/ceph/pull/39836),
    Alfonso Martínez)
-   octopus: mgr/dashboard: fix tooltip for Provisioned/Total
    Provisioned fields
    ([pr#39645](https://github.com/ceph/ceph/pull/39645), Avan Thakkar)
-   octopus: mgr/dashboard: prometheus alerting: add some leeway for
    package drops and errors
    ([pr#39507](https://github.com/ceph/ceph/pull/39507), Patrick
    Seidensal)
-   octopus: mgr/dashboard: report mgr fsid
    ([pr#39852](https://github.com/ceph/ceph/pull/39852), Ernesto
    Puerta)
-   octopus: mgr/dashboard: set security headers
    ([pr#39627](https://github.com/ceph/ceph/pull/39627), Avan Thakkar)
-   octopus: mgr/dashboard: trigger alert if some nodes have a MTU
    different than the median value
    ([pr#39103](https://github.com/ceph/ceph/pull/39103), Aashish
    Sharma)
-   octopus: mgr/dashboard:minimize console log traces of Ceph backend
    API tests ([pr#39545](https://github.com/ceph/ceph/pull/39545),
    Aashish Sharma)
-   octopus: mgr/rbd_support: create mirror snapshots asynchronously
    ([pr#39376](https://github.com/ceph/ceph/pull/39376), Mykola Golub,
    Kefu Chai)
-   octopus: mgr/rbd_support: mirror snapshot schedule should skip
    non-primary images
    ([pr#39863](https://github.com/ceph/ceph/pull/39863), Mykola Golub)
-   octopus: mgr/volume: subvolume auth_id management and few bug fixes
    ([pr#39390](https://github.com/ceph/ceph/pull/39390), Rishabh Dave,
    Patrick Donnelly, Kotresh HR, Ramana Raja)
-   octopus: mgr/zabbix: format ceph.\[{#POOL},percent_used as float
    ([pr#39235](https://github.com/ceph/ceph/pull/39235), Kefu Chai)
-   octopus: os/bluestore: Add option to check BlueFS reads
    ([pr#39754](https://github.com/ceph/ceph/pull/39754), Adam Kupczyk)
-   octopus: os/bluestore: fix huge reads/writes at BlueFS
    ([pr#39701](https://github.com/ceph/ceph/pull/39701), Jianpeng Ma,
    Igor Fedotov)
-   octopus: os/bluestore: introduce bluestore_rocksdb_options_annex
    config parame...
    ([pr#39325](https://github.com/ceph/ceph/pull/39325), Igor Fedotov)
-   octopus: qa/suites/rados/dashboard: whitelist TELEMETRY_CHANGED
    ([pr#39704](https://github.com/ceph/ceph/pull/39704), Sage Weil)
-   octopus: qa/suites/upgrade: s/whitelist/ignorelist for octopus
    specific tests ([pr#40074](https://github.com/ceph/ceph/pull/40074),
    Deepika Upadhyay)
-   octopus: qa: use normal build for valgrind
    ([pr#39583](https://github.com/ceph/ceph/pull/39583), Sage Weil)
-   octopus: rbd-mirror: reset update_status_task pointer in timer
    thread ([pr#39867](https://github.com/ceph/ceph/pull/39867), Mykola
    Golub)
-   octopus: rgw: fix trailing null in object names of multipart
    reuploads ([pr#39277](https://github.com/ceph/ceph/pull/39277),
    Casey Bodley)
-   octopus: rgw: radosgw-admin: clarify error when email address
    already in use ([pr#39662](https://github.com/ceph/ceph/pull/39662),
    Matthew Vernon)
-   octopus: whitelist -\> ignorelist for qa/\* only
    ([pr#39534](https://github.com/ceph/ceph/pull/39534), Neha Ojha,
    Sage Weil)
-   qa/tests: fixed branch entry
    ([pr#39819](https://github.com/ceph/ceph/pull/39819), Yuri
    Weinstein)

## v15.2.9 Octopus

This is the 9th backport release in the Octopus series. We recommend all
users update to this release.

### Notable Changes

-   MGR: progress module can now be turned on/off, using the commands:
    `ceph progress on` and `ceph progress off`.
-   OSD: PG removal has been optimized in this release.

### Changelog

-   octopus: Do not add sensitive information in Ceph log files
    ([pr#38620](https://github.com/ceph/ceph/pull/38620), Neha Ojha)
-   octopus: PendingReleaseNotes: mgr/pg_autoscaler
    ([pr#39393](https://github.com/ceph/ceph/pull/39393), Kamoltat)
-   octopus: Revert \"mgr/pg_autoscaler: avoid scale-down until there is
    pressure\" ([pr#39560](https://github.com/ceph/ceph/pull/39560),
    Neha Ojha)
-   octopus: bluestore: Make mempool assignment same after bufferlist
    rebuild ([pr#38429](https://github.com/ceph/ceph/pull/38429), Adam
    Kupczyk)
-   octopus: bluestore: Support flock retry
    ([pr#37860](https://github.com/ceph/ceph/pull/37860), wanghongxu)
-   octopus: bluestore: attach csum for compressed blobs
    ([pr#37861](https://github.com/ceph/ceph/pull/37861), Igor Fedotov)
-   octopus: bluestore: fix \"end reached\" check in
    collection_list_legacy
    ([pr#38098](https://github.com/ceph/ceph/pull/38098), Mykola Golub)
-   octopus: bluestore: provide a different name for fallback allocator
    ([pr#37794](https://github.com/ceph/ceph/pull/37794), Igor Fedotov)
-   octopus: build/ops: doc: pass \--use-feature=2020-resolver to pip
    ([pr#37859](https://github.com/ceph/ceph/pull/37859), Kefu Chai)
-   octopus: ceph-volume: lvm/create.py: fix a typo in the help message
    ([pr#38425](https://github.com/ceph/ceph/pull/38425), ZhenLiu94)
-   octopus: cephadm: Don\'t make sysctl spam the log file
    ([pr#39020](https://github.com/ceph/ceph/pull/39020), Sebastian
    Wagner)
-   octopus: cephadm: Revert \"spec: Podman (temporarily) requires
    apparmor-abstractions on suse\"
    ([pr#37766](https://github.com/ceph/ceph/pull/37766), Nathan Cutler)
-   octopus: cephadm: Various properties like \'last_refresh\' do not
    contain timezone
    ([pr#39059](https://github.com/ceph/ceph/pull/39059), Volker Theile)
-   octopus: cephadm: batch backport January (1)
    ([pr#38782](https://github.com/ceph/ceph/pull/38782), Ricardo
    Marques, Patrick Donnelly, Ken Dreyer, Paul Cuzner, Daniel-Pivonka,
    Juan Miguel Olmo Martínez, Volker Theile, Sebastian Wagner, Varsha
    Rao, Adam King, Patrick Seidensal, Michael Fritch, Dan Mick)
-   octopus: cephadm: fix rgw osd cap tag
    ([pr#39170](https://github.com/ceph/ceph/pull/39170), Patrick
    Donnelly)
-   octopus: cephadm: make \"ceph orch {restart\|\...}\" asynchronous
    ([pr#39018](https://github.com/ceph/ceph/pull/39018), Sebastian
    Wagner)
-   octopus: cephadm: silence \"Failed to evict container\" log msg
    ([pr#39166](https://github.com/ceph/ceph/pull/39166), Sebastian
    Wagner, Sage Weil)
-   octopus: cephadm: use [apt-get]{.title-ref} for package
    install/update ([pr#39297](https://github.com/ceph/ceph/pull/39297),
    Michael Fritch)
-   octopus: cephfs: client: add ceph.{cluster_fsid/client_id} vxattrs
    suppport ([pr#39000](https://github.com/ceph/ceph/pull/39000), Xiubo
    Li)
-   octopus: cephfs: client: check rdonly file handle on truncate
    ([pr#38424](https://github.com/ceph/ceph/pull/38424), Patrick
    Donnelly)
-   octopus: cephfs: client: do not use g_conf().get_val\<\>() in
    libcephfs ([pr#38466](https://github.com/ceph/ceph/pull/38466),
    Xiubo Li)
-   octopus: cephfs: client: ensure we take Fs caps when fetching
    directory link count from cached inode
    ([pr#38949](https://github.com/ceph/ceph/pull/38949), Jeff Layton)
-   octopus: cephfs: client: increment file position on \_read_sync near
    eof ([pr#37989](https://github.com/ceph/ceph/pull/37989), Patrick
    Donnelly)
-   octopus: cephfs: client: set CEPH_STAT_RSTAT mask for dir in
    readdir_r_cb ([pr#38947](https://github.com/ceph/ceph/pull/38947),
    chencan)
-   octopus: cephfs: mds: dir-\>mark_new() should together with
    dir-\>mark_dirty()
    ([pr#38352](https://github.com/ceph/ceph/pull/38352), \"Yan,
    Zheng\")
-   octopus: cephfs: mds: move start_files_to_recover() to recovery_done
    ([pr#37985](https://github.com/ceph/ceph/pull/37985), Simon Gao)
-   octopus: cephfs: osdc: restart read on truncate/discard
    ([pr#37987](https://github.com/ceph/ceph/pull/37987), Patrick
    Donnelly)
-   octopus: cephfs: release client dentry_lease before send caps
    release to mds ([pr#38349](https://github.com/ceph/ceph/pull/38349),
    Wei Qiaomiao)
-   octopus: client: dump which fs is used by client for multiple-fs
    ([pr#38551](https://github.com/ceph/ceph/pull/38551), Zhi Zhang)
-   octopus: cmake: add empty RPATH to ceph-diff-sorted
    ([pr#38847](https://github.com/ceph/ceph/pull/38847), Nathan Cutler)
-   octopus: cmake: define BOOST_ASIO_USE_TS_EXECUTOR_AS_DEFAULT for
    Boost.Asio users
    ([pr#38759](https://github.com/ceph/ceph/pull/38759), Kefu Chai)
-   octopus: cmake: detect and use sigdescr_np() if available
    ([pr#38951](https://github.com/ceph/ceph/pull/38951), David
    Disseldorp)
-   octopus: do_cmake.sh: use python-3.9 with fedora version 33
    ([pr#38943](https://github.com/ceph/ceph/pull/38943), Sunny Kumar)
-   octopus: doc: document MDS cache configuration
    ([pr#38202](https://github.com/ceph/ceph/pull/38202), Patrick
    Donnelly)
-   octopus: global: reexpand conf meta in child process
    ([pr#38340](https://github.com/ceph/ceph/pull/38340), Xiubo Li)
-   octopus: install-deps.sh: Make powertools repo case insensitive
    ([pr#38808](https://github.com/ceph/ceph/pull/38808), Brad Hubbard)
-   octopus: krbd: add support for msgr2 (kernel 5.11)
    ([pr#39203](https://github.com/ceph/ceph/pull/39203), Ilya Dryomov)
-   octopus: librbd: clear implicitly enabled feature bits when creating
    images ([pr#39122](https://github.com/ceph/ceph/pull/39122), Jason
    Dillaman)
-   octopus: librbd: fix regression in object map diff request
    ([pr#38455](https://github.com/ceph/ceph/pull/38455), Mykola Golub,
    Jason Dillaman)
-   octopus: librbd: update hidden global config when removing pool
    config override
    ([pr#38343](https://github.com/ceph/ceph/pull/38343), Jason
    Dillaman)
-   octopus: mds: dump granular cap info in mds_sessions
    ([pr#37362](https://github.com/ceph/ceph/pull/37362), Yanhu Cao)
-   octopus: mds: provide altrenatives to increase the total cephfs
    subvolume snapshot counts to greater than the current 400 across a
    Cephfs volume ([pr#38553](https://github.com/ceph/ceph/pull/38553),
    \"Yan, Zheng\")
-   octopus: mds: throttle cap acquisition via readdir
    ([pr#38095](https://github.com/ceph/ceph/pull/38095), Kotresh HR)
-   octopus: mgr/ActivePyModules.cc: always release GIL before
    attempting to acquire a lock
    ([pr#38801](https://github.com/ceph/ceph/pull/38801), Cory Snyder)
-   octopus: mgr/balancer: fix available pgs sent to calc_pg_upmaps
    ([pr#38337](https://github.com/ceph/ceph/pull/38337), Dan van der
    Ster)
-   octopus: mgr/cephadm: fix host refresh
    ([pr#39532](https://github.com/ceph/ceph/pull/39532), Sage Weil)
-   octopus: mgr/cephadm: lock multithreaded access to OSDRemovalQueue
    ([pr#39019](https://github.com/ceph/ceph/pull/39019), Sebastian
    Wagner)
-   octopus: mgr/cephadm: raise HEALTH_WARN when cephadm daemon in
    \'error\' state
    ([pr#39169](https://github.com/ceph/ceph/pull/39169), Sage Weil)
-   octopus: mgr/cephadm: tolerate old host inventory without
    \'hostname\' key
    ([pr#39167](https://github.com/ceph/ceph/pull/39167), Sage Weil)
-   octopus: mgr/cephadm: try again calling ceph-volume without
    \--filter-for-batch
    ([pr#39300](https://github.com/ceph/ceph/pull/39300), Sebastian
    Wagner)
-   octopus: mgr/crash: Serialize command handling
    ([pr#38592](https://github.com/ceph/ceph/pull/38592), Boris Ranto)
-   octopus: mgr/dashboard: Add clay plugin support
    ([pr#38489](https://github.com/ceph/ceph/pull/38489), Stephan
    Müller)
-   octopus: mgr/dashboard: Create Ceph services via Orchestrator by
    using ServiceSpec
    ([pr#38888](https://github.com/ceph/ceph/pull/38888), Volker Theile)
-   octopus: mgr/dashboard: Display a warning message in Dashboard when
    debug mode is enabled
    ([pr#38798](https://github.com/ceph/ceph/pull/38798), Volker Theile)
-   octopus: mgr/dashboard: Drop invalid RGW client instances, improve
    logging ([pr#38583](https://github.com/ceph/ceph/pull/38583), Volker
    Theile)
-   octopus: mgr/dashboard: Fix CRUSH map viewer VirtualScroll
    ([pr#38607](https://github.com/ceph/ceph/pull/38607), Avan Thakkar)
-   octopus: mgr/dashboard: Fix for misleading \"Orchestrator is not
    available\" error
    ([pr#38598](https://github.com/ceph/ceph/pull/38598), Nizamudeen A)
-   octopus: mgr/dashboard: Fixing dashboard logs e2e test
    ([pr#38797](https://github.com/ceph/ceph/pull/38797), Nizamudeen A)
-   octopus: mgr/dashboard: Prevent table items from getting selected
    while expanding
    ([pr#37930](https://github.com/ceph/ceph/pull/37930), Nizamudeen A)
-   octopus: mgr/dashboard: RGW User Form is validating disabled fields
    ([pr#38594](https://github.com/ceph/ceph/pull/38594), Aashish
    Sharma)
-   octopus: mgr/dashboard: Temporary User Lockout if 10 Invalid Login
    attempts ([pr#38810](https://github.com/ceph/ceph/pull/38810),
    Nizamudeen A)
-   octopus: mgr/dashboard: The /rgw/status endpoint does not check for
    running service
    ([pr#38770](https://github.com/ceph/ceph/pull/38770), Volker Theile)
-   octopus: mgr/dashboard: Updating the inbuilt ssl providers error
    ([pr#38508](https://github.com/ceph/ceph/pull/38508), Nizamudeen A)
-   octopus: mgr/dashboard: Use secure cookies to store JWT Token
    ([pr#39120](https://github.com/ceph/ceph/pull/39120), Avan Thakkar,
    Aashish Sharma)
-   octopus: mgr/dashboard: add [\--ssl]{.title-ref} to [ng
    serve]{.title-ref}
    ([pr#38973](https://github.com/ceph/ceph/pull/38973), Tatjana
    Dehler)
-   octopus: mgr/dashboard: adjust refresh intervals of Services and
    Daemons ([pr#38597](https://github.com/ceph/ceph/pull/38597), Kiefer
    Chang)
-   octopus: mgr/dashboard: allow selecting all daemons for Orchestrator
    NFS clusters ([pr#38496](https://github.com/ceph/ceph/pull/38496),
    Kiefer Chang)
-   octopus: mgr/dashboard: assign flags to single OSDs
    ([pr#38469](https://github.com/ceph/ceph/pull/38469), Tatjana
    Dehler)
-   octopus: mgr/dashboard: disable cluster selection in NFS export
    editing form ([pr#37969](https://github.com/ceph/ceph/pull/37969),
    Kiefer Chang)
-   octopus: mgr/dashboard: display placement column in service table
    ([pr#38336](https://github.com/ceph/ceph/pull/38336), Volker Theile)
-   octopus: mgr/dashboard: enable different URL for users of browser to
    Grafana ([pr#38761](https://github.com/ceph/ceph/pull/38761),
    Patrick Seidensal)
-   octopus: mgr/dashboard: fix Reads/Writes ratio of Clients IOPS donut
    chart ([pr#38867](https://github.com/ceph/ceph/pull/38867), Kiefer
    Chang)
-   octopus: mgr/dashboard: remove pyOpenSSL version pinning
    ([pr#38503](https://github.com/ceph/ceph/pull/38503), Kiefer Chang)
-   octopus: mgr/dashboard: test_standby\*
    (tasks.mgr.test_dashboard.TestDashboard) failed locally
    ([pr#38526](https://github.com/ceph/ceph/pull/38526), Volker Theile)
-   octopus: mgr/pg_autoscaler: avoid scale-down until there is pressure
    ([pr#39248](https://github.com/ceph/ceph/pull/39248), Kamoltat)
-   octopus: mgr/progress: introduce turn off/on feature
    ([pr#39289](https://github.com/ceph/ceph/pull/39289), kamoltat)
-   octopus: mgr/prometheus: Fix \'pool filling up\' with \>50% usage
    ([pr#38593](https://github.com/ceph/ceph/pull/38593), Daniël Vos)
-   octopus: mgr/prometheus: Sync and backport prometheus fixes
    ([pr#38333](https://github.com/ceph/ceph/pull/38333), Paul Cuzner,
    Boris Ranto, Kefu Chai, Ken Dreyer)
-   octopus: mgr/rbd_support: store global schedule without localized
    prefix ([pr#38342](https://github.com/ceph/ceph/pull/38342), Mykola
    Golub)
-   octopus: mgr/restful: fix TypeError occurring in \_gather_osds()
    ([issue#48488](http://tracker.ceph.com/issues/48488),
    [pr#38595](https://github.com/ceph/ceph/pull/38595), Jerry Pu)
-   octopus: mgr/volumes: Add a per subvolume trash
    ([pr#38612](https://github.com/ceph/ceph/pull/38612), Venky Shankar,
    Shyamsundar Ranganathan)
-   octopus: mgr/volumes: Implement subvolume version v2
    ([pr#36803](https://github.com/ceph/ceph/pull/36803), Shyamsundar
    Ranganathan)
-   octopus: mgr: Fix for dashboard/prometheus failure due to laggy pg
    state ([pr#38596](https://github.com/ceph/ceph/pull/38596),
    Alexander Sushko)
-   octopus: mgr: don\'t update osd stat which is already out
    ([pr#38353](https://github.com/ceph/ceph/pull/38353), Zhi Zhang)
-   octopus: mon: paxos: Delete logger in destructor
    ([pr#39161](https://github.com/ceph/ceph/pull/39161), Brad Hubbard)
-   octopus: mon: validate crush-failure-domain
    ([pr#38347](https://github.com/ceph/ceph/pull/38347), Prashant
    Dhange)
-   octopus: monitoring: Use null yaxes min for OSD read latency
    ([pr#37960](https://github.com/ceph/ceph/pull/37960), Seena Fallah)
-   octopus: msg/async/ProtocolV2: allow rxbuf/txbuf get bigger in
    testing, again ([pr#38267](https://github.com/ceph/ceph/pull/38267),
    Ilya Dryomov)
-   octopus: ocf: add support for mapping images within an RBD namespace
    ([pr#39046](https://github.com/ceph/ceph/pull/39046), Jason
    Dillaman)
-   octopus: os/bluestore: detect and fix \"zombie\" spanning blobs
    using fsck ([pr#39256](https://github.com/ceph/ceph/pull/39256),
    Igor Fedotov)
-   octopus: os/bluestore: fix huge (\>4GB) bluefs reads
    ([pr#39253](https://github.com/ceph/ceph/pull/39253), Igor Fedotov)
-   octopus: os/bluestore: fix inappropriate ENOSPC from avl/hybrid
    allocator ([pr#38474](https://github.com/ceph/ceph/pull/38474), Igor
    Fedotov)
-   octopus: os/bluestore: fix segfault on out-of-bound offset provided
    to claim_free_to_right() call
    ([pr#38428](https://github.com/ceph/ceph/pull/38428), Igor Fedotov)
-   octopus: os/bluestore: fixing onode pinning and more
    ([pr#39230](https://github.com/ceph/ceph/pull/39230), Adam Kupczyk,
    Igor Fedotov)
-   octopus: osd: fix bluestore bitmap allocator calculate wrong
    last_pos with hint
    ([pr#38430](https://github.com/ceph/ceph/pull/38430), Xue Yantao)
-   octopus: osd: optimize PG removal (part1)
    ([pr#38477](https://github.com/ceph/ceph/pull/38477), Igor Fedotov)
-   octopus: pybind/cephfs: fix missing terminating NULL char in
    readlink()\'s C string
    ([pr#38893](https://github.com/ceph/ceph/pull/38893), Tuan Hoang)
-   octopus: pybind/mgr/rbd_support: delay creation of progress module
    events ([pr#38344](https://github.com/ceph/ceph/pull/38344), Jason
    Dillaman)
-   octopus: python-common/drivegroups: avoid dropping \"rotational: 0\"
    from Device Selection
    ([issue#49014](http://tracker.ceph.com/issues/49014),
    [pr#39171](https://github.com/ceph/ceph/pull/39171), Lukas Stockner)
-   octopus: python-common: fix test_datetime_to_str_2 on non-UTC hosts
    ([pr#39296](https://github.com/ceph/ceph/pull/39296), Sage Weil)
-   octopus: qa/cephadm: Add yaml output to smoke test
    ([pr#39168](https://github.com/ceph/ceph/pull/39168), Sebastian
    Wagner)
-   octopus: qa/mgr: mgr_test_case: raise SkipTest instead of calling
    skipTest() ([pr#38165](https://github.com/ceph/ceph/pull/38165),
    Rishabh Dave)
-   octopus: qa/tasks/cephfs/nfs: Check if host ip is in cluster info
    output ([pr#39004](https://github.com/ceph/ceph/pull/39004), Varsha
    Rao)
-   octopus: qa/tasks/mgr/test_progress: update test suite to check for
    specific progress events
    ([pr#38555](https://github.com/ceph/ceph/pull/38555), Kamoltat)
-   octopus: qa/tasks/vstart_runner: do not teardown test_path if
    \"create-cluster-only\"
    ([pr#39540](https://github.com/ceph/ceph/pull/39540), Kefu Chai)
-   octopus: qa/workunits/rbd: fix permission issue when removing mirror
    peer ([pr#38341](https://github.com/ceph/ceph/pull/38341), Jason
    Dillaman)
-   octopus: qa: accept timeout argument in run_shell
    ([pr#38550](https://github.com/ceph/ceph/pull/38550), Patrick
    Donnelly)
-   octopus: qa: ignore evicted client warnings
    ([pr#38422](https://github.com/ceph/ceph/pull/38422), Patrick
    Donnelly)
-   octopus: qa: ignore logrotate state rename error
    ([pr#37690](https://github.com/ceph/ceph/pull/37690), Patrick
    Donnelly)
-   octopus: qa: krbd_stable_pages_required.sh: move to stable_writes
    attribute ([pr#39321](https://github.com/ceph/ceph/pull/39321), Ilya
    Dryomov)
-   octopus: qa: tox failures
    ([pr#38626](https://github.com/ceph/ceph/pull/38626), Patrick
    Donnelly)
-   octopus: qa: unmount volumes before removal
    ([pr#38688](https://github.com/ceph/ceph/pull/38688), Patrick
    Donnelly)
-   octopus: rgw/multisite: Verify if the synced object is identical to
    source ([pr#38981](https://github.com/ceph/ceph/pull/38981), Prasad
    Krishnan, Casey Bodley)
-   octopus: rgw/rgw-admin: fixes BucketInfo for missing buckets
    ([pr#38184](https://github.com/ceph/ceph/pull/38184), Nick Janus,
    caolei)
-   octopus: rgw: S3 Put Bucket Policy should return 204 on success
    ([pr#38420](https://github.com/ceph/ceph/pull/38420), Matthew
    Oliver)
-   octopus: rgw: adding user related web token claims to ops log
    ([pr#38970](https://github.com/ceph/ceph/pull/38970), Pritha
    Srivastava)
-   octopus: rgw: avoid expiration early triggering caused by overflow
    ([pr#38421](https://github.com/ceph/ceph/pull/38421), jiahuizeng)
-   octopus: rgw: cls/rgw/cls_rgw.cc: fix multiple lastest version
    problem ([pr#38086](https://github.com/ceph/ceph/pull/38086), Yang
    Honggang, Ruan Zitao)
-   octopus: rgw: cls/user: set from_index for reset stats calls
    ([pr#38821](https://github.com/ceph/ceph/pull/38821), Mykola Golub,
    Abhishek Lekshmanan)
-   octopus: rgw: distribute cache for exclusive put
    ([pr#38971](https://github.com/ceph/ceph/pull/38971), Or Friedmann)
-   octopus: rgw: fix bucket limit check fill_status warnings
    ([issue#40255](http://tracker.ceph.com/issues/40255),
    [pr#38826](https://github.com/ceph/ceph/pull/38826), Paul Emmerich)
-   octopus: rgw: fix invalid payload issue when serving s3website error
    page ([pr#38339](https://github.com/ceph/ceph/pull/38339), Ilsoo
    Byun)
-   octopus: rgw: keep syncstopped flag when copying bucket shard
    headers ([pr#38338](https://github.com/ceph/ceph/pull/38338), Ilsoo
    Byun)
-   octopus: rgw: lc: correctly dimension lc shard index vector
    ([pr#38824](https://github.com/ceph/ceph/pull/38824), Matt Benjamin)
-   octopus: rgw_file: return common_prefixes in lexical order
    ([pr#38829](https://github.com/ceph/ceph/pull/38829), Matt Benjamin)
-   octopus: rpm,deb: change sudoers file mode to 440
    ([pr#38427](https://github.com/ceph/ceph/pull/38427), David Turner)
-   octopus: rpm: require smartmontools on SUSE
    ([pr#38755](https://github.com/ceph/ceph/pull/38755), Nathan Cutler)
-   octopus: test/run-cli-tests: use cram from github
    ([pr#39071](https://github.com/ceph/ceph/pull/39071), Kefu Chai)
-   octopus: tests: qa/task/cephadm: run cephadm only on
    bootstrap_remote
    ([pr#38040](https://github.com/ceph/ceph/pull/38040), Kyr Shatskyy)

## v15.2.8 Octopus

This is the 8th backport release in the Octopus series. This release
fixes a security flaw in CephFS and includes a number of bug fixes. We
recommend users to update to this release.

### Notable Changes

-   CVE-2020-27781 : OpenStack Manila use of ceph_volume_client.py
    library allowed tenant access to any Ceph credential\'s secret.
    (Kotresh Hiremath Ravishankar, Ramana Raja)
-   ceph-volume: The `lvm batch` subcommand received a major rewrite.
    This closed a number of bugs and improves usability in terms of size
    specification and calculation, as well as idempotency behaviour and
    disk replacement process. Please refer to
    <https://docs.ceph.com/en/latest/ceph-volume/lvm/batch/> for more
    detailed information.
-   MON: The cluster log now logs health detail every
    `mon_health_to_clog_interval`, which has been changed from 1hr to
    10min. Logging of health detail will be skipped if there is no
    change in health summary since last known.
-   The `ceph df` command now lists the number of pgs in each pool.
-   The `bluefs_preextend_wal_files` option has been removed.
-   It is now possible to specify the initial monitor to contact for
    Ceph tools and daemons using the `mon_host_override` config option
    or `--mon-host-override <ip>` command-line switch. This generally
    should only be used for debugging and only affects initial
    communication with Ceph\'s monitor cluster.

### Changelog

-   pybind/ceph_volume_client: disallow authorize on existing auth ids
    (Kotresh Hiremath Ravishankar, Ramana Raja)
-   Enable per-RBD image monitoring
    ([pr#37697](https://github.com/ceph/ceph/pull/37697), Patrick
    Seidensal)
-   \[ceph-volume\]: remove unneeded call to get_devices()
    ([pr#37412](https://github.com/ceph/ceph/pull/37412), Marc Gariepy)
-   bluestore: fix collection_list ordering
    ([pr#37048](https://github.com/ceph/ceph/pull/37048), Mykola Golub)
-   bluestore: mempool\'s finer granularity + adding missed structs
    ([pr#37264](https://github.com/ceph/ceph/pull/37264), Deepika
    Upadhyay, Igor Fedotov, Adam Kupczyk)
-   bluestore: remove preextended WAL support
    ([pr#37373](https://github.com/ceph/ceph/pull/37373), Igor Fedotov)
-   ceph-volume batch: reject partitions in argparser
    ([pr#38280](https://github.com/ceph/ceph/pull/38280), Jan Fajerski)
-   ceph-volume inventory: make libstoragemgmt data retrieval optional
    ([pr#38299](https://github.com/ceph/ceph/pull/38299), Jan Fajerski)
-   ceph-volume: add libstoragemgmt support
    ([pr#36852](https://github.com/ceph/ceph/pull/36852), Paul Cuzner,
    Satoru Takeuchi)
-   ceph-volume: add no-systemd argument to zap
    ([pr#37722](https://github.com/ceph/ceph/pull/37722), wanghongxu)
-   ceph-volume: avoid format strings for now
    ([pr#37345](https://github.com/ceph/ceph/pull/37345), Jan Fajerski)
-   ceph-volume: consume mount opt in simple activate
    ([pr#38014](https://github.com/ceph/ceph/pull/38014), Dimitri
    Savineau)
-   ceph-volume: fix filestore/dmcrypt activate
    ([pr#38199](https://github.com/ceph/ceph/pull/38199), Guillaume
    Abrioux)
-   ceph-volume: fix journal size argument not work
    ([pr#37344](https://github.com/ceph/ceph/pull/37344), wanghongxu)
-   ceph-volume: fix lvm batch auto with full SSDs
    ([pr#38045](https://github.com/ceph/ceph/pull/38045), Dimitri
    Savineau, Guillaume Abrioux)
-   ceph-volume: fix simple activate when legacy osd
    ([pr#37194](https://github.com/ceph/ceph/pull/37194), Guillaume
    Abrioux)
-   ceph-volume: implement the \--log-level flag
    ([pr#38426](https://github.com/ceph/ceph/pull/38426), Andrew Schoen)
-   ceph-volume: major batch refactor
    ([pr#37520](https://github.com/ceph/ceph/pull/37520), Jan Fajerski,
    Joshua Schmid)
-   ceph-volume: prepare: use \*-slots arguments for implicit sizing
    ([pr#38205](https://github.com/ceph/ceph/pull/38205), Jan Fajerski)
-   ceph-volume: remove mention of dmcache from docs and help text
    ([pr#38047](https://github.com/ceph/ceph/pull/38047), Dimitri
    Savineau, Andrew Schoen)
-   ceph-volume: retry when acquiring lock fails
    ([pr#36925](https://github.com/ceph/ceph/pull/36925), Sébastien Han)
-   ceph-volume: simple scan should ignore tmpfs
    ([pr#36953](https://github.com/ceph/ceph/pull/36953), Andrew Schoen)
-   ceph-volume: support for mpath devices
    ([pr#36928](https://github.com/ceph/ceph/pull/36928), Jan Fajerski)
-   ceph.in: ignore failures to flush stdout
    ([pr#37225](https://github.com/ceph/ceph/pull/37225), Dan van der
    Ster)
-   ceph.spec, debian: add smartmontools, nvme-cli dependencies
    ([pr#37257](https://github.com/ceph/ceph/pull/37257), Yaarit Hatuka)
-   cephadm batch backport November
    ([pr#38155](https://github.com/ceph/ceph/pull/38155), Ricardo
    Marques, Sebastian Wagner, Kyr Shatskyy, Dan Williams, Volker
    Theile, Varsha Rao, Tim Serong, Adam King, Dimitri Savineau, Patrick
    Seidensal, Dan Mick, Michael Fritch, Joshua Schmid)
-   cephadm batch backport September (1)
    ([pr#36975](https://github.com/ceph/ceph/pull/36975), Stephan
    Müller, Matthew Oliver, Sebastian Wagner, Paul Cuzner, Adam King,
    Patrick Seidensal, Shraddha Agrawal, Michael Fritch, Dan Mick)
-   cephadm batch backport September (2)
    ([pr#37436](https://github.com/ceph/ceph/pull/37436), Varsha Rao,
    Kiefer Chang, Patrick Donnelly, Sebastian Wagner, Kefu Chai,
    Guillaume Abrioux, Juan Miguel Olmo Martínez, Paul Cuzner, Volker
    Theile, Tim Serong, Zac Dover, Adam King, Michael Fritch, Joshua
    Schmid)
-   cephfs-journal-tool: fix incorrect read_offset when finding missing
    objects ([pr#37854](https://github.com/ceph/ceph/pull/37854), Xue
    Yantao)
-   cephfs: client: fix directory inode can not call release callback
    ([pr#37017](https://github.com/ceph/ceph/pull/37017), sepia-liu)
-   cephfs: client: fix extra open ref decrease
    ([pr#37249](https://github.com/ceph/ceph/pull/37249), Xiubo Li)
-   cephfs: client: fix inode ll_ref reference count leak
    ([pr#37839](https://github.com/ceph/ceph/pull/37839), sepia-liu)
-   cephfs: client: handle readdir reply without Fs cap
    ([pr#37370](https://github.com/ceph/ceph/pull/37370), \"Yan,
    Zheng\")
-   cephfs: client: make Client::open() pass proper cap mask to
    path_walk ([pr#37369](https://github.com/ceph/ceph/pull/37369),
    \"Yan, Zheng\")
-   cephfs: client: use non-static dirent for thread-safety
    ([pr#37351](https://github.com/ceph/ceph/pull/37351), Patrick
    Donnelly)
-   cephfs: libcephfs: ignore restoring the open files limit
    ([pr#37358](https://github.com/ceph/ceph/pull/37358), Xiubo Li)
-   cephfs: osdc/Journaler: do not call onsafe-\>complete() if onsafe is
    0 ([pr#37368](https://github.com/ceph/ceph/pull/37368), Xiubo Li)
-   common/admin_socket: always validate the parameters
    ([pr#37341](https://github.com/ceph/ceph/pull/37341), Kefu Chai)
-   compressor: Add a config option to specify Zstd compression level
    ([pr#37253](https://github.com/ceph/ceph/pull/37253), Bryan
    Stillwell)
-   core: include/encoding: Fix encode/decode of float types on
    big-endian systems
    ([pr#37032](https://github.com/ceph/ceph/pull/37032), Ulrich
    Weigand)
-   debian: Add missing Python dependency for ceph-mgr
    ([pr#37422](https://github.com/ceph/ceph/pull/37422), Johannes M.
    Scheuermann)
-   doc/PendingReleaseNotes: mention bluefs_preextend_wal_files
    ([pr#37549](https://github.com/ceph/ceph/pull/37549), Nathan Cutler)
-   doc/mgr/orchestrator: Add hints related to custom containers to the
    docs ([pr#37962](https://github.com/ceph/ceph/pull/37962), Volker
    Theile)
-   doc: cephfs: improve documentation of \"ceph nfs cluster create\"
    and \"ceph fs volume create\" commands
    ([pr#37691](https://github.com/ceph/ceph/pull/37691), Nathan Cutler)
-   doc: enable Read the Docs
    ([pr#37201](https://github.com/ceph/ceph/pull/37201), Kefu Chai)
-   erasure-code: enable isa-l EC for aarch64 platform
    ([pr#37504](https://github.com/ceph/ceph/pull/37504), luo rixin,
    Hang Li)
-   krbd: optionally skip waiting for udev events
    ([pr#37285](https://github.com/ceph/ceph/pull/37285), Ilya Dryomov)
-   librbd: ensure that thread pool lock is held when processing
    throttled IOs ([pr#37116](https://github.com/ceph/ceph/pull/37116),
    Jason Dillaman)
-   librbd: handle DNE from immutable-object-cache
    ([pr#36860](https://github.com/ceph/ceph/pull/36860), Feng Hualong,
    Mykola Golub, Yin Congmin, Jason Dillaman)
-   librbd: using migration abort can result in the loss of data
    ([pr#37164](https://github.com/ceph/ceph/pull/37164), Jason
    Dillaman)
-   mds/CInode: Optimize only pinned by subtrees check
    ([pr#37248](https://github.com/ceph/ceph/pull/37248), Mark Nelson)
-   mds: account for closing sessions in hit_session
    ([pr#37856](https://github.com/ceph/ceph/pull/37856), Dan van der
    Ster)
-   mds: add request to batch_op before taking auth pins and locks
    ([pr#37022](https://github.com/ceph/ceph/pull/37022), \"Yan,
    Zheng\")
-   mds: do not raise \"client failing to respond to cap release\" when
    client working set is reasonable
    ([pr#37353](https://github.com/ceph/ceph/pull/37353), Patrick
    Donnelly)
-   mds: do not submit omap_rm_keys if the dir is the basedir of merge
    ([pr#37034](https://github.com/ceph/ceph/pull/37034), \"Yan,
    Zheng\", Chencan)
-   mds: don\'t recover files after normal session close
    ([pr#37334](https://github.com/ceph/ceph/pull/37334), \"Yan,
    Zheng\")
-   mds: fix \'forward loop\' when forward_all_requests_to_auth is set
    ([pr#37360](https://github.com/ceph/ceph/pull/37360), \"Yan,
    Zheng\")
-   mds: fix hang issue when accessing a file under a lost parent
    directory ([pr#37020](https://github.com/ceph/ceph/pull/37020), Zhi
    Zhang)
-   mds: fix kcephfs parse dirfrag\'s ndist is always 0
    ([pr#37357](https://github.com/ceph/ceph/pull/37357), Yanhu Cao)
-   mds: fix mds forwarding request \'no_available_op_found\'
    ([pr#37240](https://github.com/ceph/ceph/pull/37240), Yanhu Cao)
-   mds: fix nullptr dereference in MDCache::finish_rollback
    ([pr#37243](https://github.com/ceph/ceph/pull/37243), \"Yan,
    Zheng\")
-   mds: fix purge_queue\'s \_calculate_ops is inaccurate
    ([pr#37372](https://github.com/ceph/ceph/pull/37372), Yanhu Cao)
-   mds: make threshold for MDS_TRIM configurable
    ([pr#36970](https://github.com/ceph/ceph/pull/36970), Paul Emmerich)
-   mds: optimize random threshold lookup for dentry load
    ([pr#37247](https://github.com/ceph/ceph/pull/37247), Patrick
    Donnelly)
-   mds: place MDSGatherBuilder on the stack
    ([pr#37354](https://github.com/ceph/ceph/pull/37354), Patrick
    Donnelly)
-   mds: reduce memory usage of open file table prefetch #37382
    ([pr#37383](https://github.com/ceph/ceph/pull/37383), \"Yan,
    Zheng\")
-   mds: resolve SIGSEGV in waiting for uncommitted fragments
    ([pr#37355](https://github.com/ceph/ceph/pull/37355), Patrick
    Donnelly)
-   mds: revert the decode version
    ([pr#37356](https://github.com/ceph/ceph/pull/37356), Jos Collin)
-   mds: send scrub status to ceph-mgr only when scrub is running
    ([issue#45349](http://tracker.ceph.com/issues/45349),
    [pr#36047](https://github.com/ceph/ceph/pull/36047), Kefu Chai,
    Venky Shankar)
-   mds: standy-replay mds remained in the \"resolve\" state after
    resta... ([pr#37363](https://github.com/ceph/ceph/pull/37363), Wei
    Qiaomiao)
-   messages,mds: Fix decoding of enum types on big-endian systems
    ([pr#36813](https://github.com/ceph/ceph/pull/36813), Ulrich
    Weigand)
-   mgr/dashboard/api: move/create OSD histogram in separate endpoint
    ([pr#37973](https://github.com/ceph/ceph/pull/37973), Aashish
    Sharma)
-   mgr/dashboard: Add short descriptions to the telemetry report
    preview ([pr#37597](https://github.com/ceph/ceph/pull/37597),
    Nizamudeen A)
-   mgr/dashboard: Allow editing iSCSI targets with initiators logged-in
    ([pr#37277](https://github.com/ceph/ceph/pull/37277), Tiago Melo)
-   mgr/dashboard: Auto close table column dropdown on click outside
    ([pr#36862](https://github.com/ceph/ceph/pull/36862), Tiago Melo)
-   mgr/dashboard: Copy to clipboard does not work in Firefox
    ([pr#37493](https://github.com/ceph/ceph/pull/37493), Volker Theile)
-   mgr/dashboard: Datatable catches select events from other datatables
    ([pr#36899](https://github.com/ceph/ceph/pull/36899), Volker Theile,
    Tiago Melo)
-   mgr/dashboard: Disable TLS 1.0 and 1.1
    ([pr#38331](https://github.com/ceph/ceph/pull/38331), Volker Theile)
-   mgr/dashboard: Disable autocomplete on user form
    ([pr#36901](https://github.com/ceph/ceph/pull/36901), Volker Theile)
-   mgr/dashboard: Disable sso without python3-saml
    ([pr#38405](https://github.com/ceph/ceph/pull/38405), Kevin Meijer)
-   mgr/dashboard: Disabling the form inputs for the read_only modals
    ([pr#37239](https://github.com/ceph/ceph/pull/37239), Nizamudeen)
-   mgr/dashboard: Fix bugs in a unit test and i18n translation
    ([pr#36991](https://github.com/ceph/ceph/pull/36991), Volker Theile)
-   mgr/dashboard: Fix for CrushMap viewer items getting compressed
    vertically ([pr#36871](https://github.com/ceph/ceph/pull/36871),
    Nizamudeen A)
-   mgr/dashboard: Fix many-to-many issue in host-details Grafana
    dashboard ([pr#37299](https://github.com/ceph/ceph/pull/37299),
    Patrick Seidensal)
-   mgr/dashboard: Fix npm package\'s vulnerabilities
    ([pr#36921](https://github.com/ceph/ceph/pull/36921), Tiago Melo)
-   mgr/dashboard: Hide table action input field if limit=0
    ([pr#36872](https://github.com/ceph/ceph/pull/36872), Volker Theile)
-   mgr/dashboard: Host delete action should be disabled if not managed
    by Orchestrator
    ([pr#36874](https://github.com/ceph/ceph/pull/36874), Volker Theile)
-   mgr/dashboard: Improve notification badge
    ([pr#37090](https://github.com/ceph/ceph/pull/37090), Aashish
    Sharma)
-   mgr/dashboard: Landing Page improvements
    ([pr#37390](https://github.com/ceph/ceph/pull/37390), Tiago Melo,
    Alfonso Martínez)
-   mgr/dashboard: Merge disable and disableDesc
    ([pr#37763](https://github.com/ceph/ceph/pull/37763), Tiago Melo)
-   mgr/dashboard: Proper format iSCSI target portals
    ([pr#36870](https://github.com/ceph/ceph/pull/36870), Volker Theile)
-   mgr/dashboard: REST API returns 500 when no Content-Type is
    specified ([pr#37308](https://github.com/ceph/ceph/pull/37308), Avan
    Thakkar)
-   mgr/dashboard: Remove useless tab in monitoring/alerts datatable
    details ([pr#36875](https://github.com/ceph/ceph/pull/36875), Volker
    Theile)
-   mgr/dashboard: Show warning when replicated size is 1
    ([pr#37578](https://github.com/ceph/ceph/pull/37578), Sebastian
    Krah)
-   mgr/dashboard: The performance \'Client Read/Write\' widget shows
    incorrect write values
    ([pr#38189](https://github.com/ceph/ceph/pull/38189), Volker Theile)
-   mgr/dashboard: Update datatable only when necessary
    ([pr#37331](https://github.com/ceph/ceph/pull/37331), Volker Theile)
-   mgr/dashboard: Use pipe instead of calling function within template
    ([pr#38094](https://github.com/ceph/ceph/pull/38094), Volker Theile)
-   mgr/dashboard: cluster \> manager modules
    ([pr#37434](https://github.com/ceph/ceph/pull/37434), Avan Thakkar)
-   mgr/dashboard: display devices\' health information within a tabset
    ([pr#37784](https://github.com/ceph/ceph/pull/37784), Kiefer Chang)
-   mgr/dashboard: fix error when typing existing paths in the Ganesha
    form ([pr#37688](https://github.com/ceph/ceph/pull/37688), Kiefer
    Chang)
-   mgr/dashboard: fix perf. issue when listing large amounts of buckets
    ([pr#37405](https://github.com/ceph/ceph/pull/37405), Alfonso
    Martínez)
-   mgr/dashboard: fix security scopes of some NFS-Ganesha endpoints
    ([pr#37450](https://github.com/ceph/ceph/pull/37450), Kiefer Chang)
-   mgr/dashboard: fix the error when exporting CephFS path \"/\" in NFS
    exports ([pr#37686](https://github.com/ceph/ceph/pull/37686), Kiefer
    Chang)
-   mgr/dashboard: get rgw daemon zonegroup name from mgr
    ([pr#37620](https://github.com/ceph/ceph/pull/37620), Alfonso
    Martinez)
-   mgr/dashboard: increase Grafana iframe height to avoid scroll bar
    ([pr#37182](https://github.com/ceph/ceph/pull/37182), Ngwa Sedrick
    Meh)
-   mgr/dashboard: log in non-admin users successfully if the telemetry
    notification is shown
    ([pr#37452](https://github.com/ceph/ceph/pull/37452), Tatjana
    Dehler)
-   mgr/dashboard: support Orchestrator and user-defined Ganesha cluster
    ([pr#37885](https://github.com/ceph/ceph/pull/37885), Kiefer Chang)
-   mgr/dashboard: table detail rows overflow
    ([pr#37332](https://github.com/ceph/ceph/pull/37332), Aashish
    Sharma)
-   mgr/devicehealth: device_health_metrics pool gets created even
    without any OSDs in the cluster
    ([pr#37533](https://github.com/ceph/ceph/pull/37533), Sunny Kumar)
-   mgr/insights: Test environment requires \'six\'
    ([pr#38396](https://github.com/ceph/ceph/pull/38396), Brad Hubbard)
-   mgr/prometheus: add pool compression stats
    ([pr#37562](https://github.com/ceph/ceph/pull/37562), Paul Cuzner)
-   mgr/telemetry: fix device id splitting when anonymizing serial
    ([pr#37302](https://github.com/ceph/ceph/pull/37302), Yaarit Hatuka)
-   mgr/volumes/nfs: Check if orchestrator spec service_id is valid
    ([pr#37371](https://github.com/ceph/ceph/pull/37371), Varsha Rao)
-   mgr/volumes/nfs: Fix wrong error message for pseudo path
    ([pr#37855](https://github.com/ceph/ceph/pull/37855), Varsha Rao)
-   mgr/volumes: Make number of cloner threads configurable
    ([pr#37671](https://github.com/ceph/ceph/pull/37671), Kotresh HR)
-   mgr/zabbix: indent the output of \"zabbix config-show\"
    ([pr#37128](https://github.com/ceph/ceph/pull/37128), Kefu Chai)
-   mgr: PyModuleRegistry::unregister_client() can run endlessly
    ([issue#47329](http://tracker.ceph.com/issues/47329),
    [pr#37217](https://github.com/ceph/ceph/pull/37217), Venky Shankar)
-   mgr: don\'t update pending service map epoch on receiving map from
    mon ([pr#37180](https://github.com/ceph/ceph/pull/37180), Mykola
    Golub)
-   mon scrub testing
    ([pr#38361](https://github.com/ceph/ceph/pull/38361), Brad Hubbard)
-   mon/MDSMonitor do not ignore mds\'s down:dne request
    ([pr#37858](https://github.com/ceph/ceph/pull/37858), chencan)
-   mon/MDSMonitor: divide mds identifier and mds real name with dot
    ([pr#37857](https://github.com/ceph/ceph/pull/37857), Zhi Zhang)
-   mon/MonMap: fix unconditional failure for init_with_hosts
    ([pr#37817](https://github.com/ceph/ceph/pull/37817), Nathan Cutler,
    Patrick Donnelly)
-   mon/PGMap: add pg count for pools in the ceph df command
    ([pr#36945](https://github.com/ceph/ceph/pull/36945), Vikhyat Umrao)
-   mon: Log \"ceph health detail\" periodically in cluster log
    ([pr#38345](https://github.com/ceph/ceph/pull/38345), Prashant
    Dhange)
-   mon: deleting a CephFS and its pools causes MONs to crash
    ([pr#37256](https://github.com/ceph/ceph/pull/37256), Patrick
    Donnelly)
-   mon: have \'mon stat\' output json as well
    ([pr#37705](https://github.com/ceph/ceph/pull/37705), Joao Eduardo
    Luis)
-   mon: mark pgtemp messages as no_reply more consistenly in
    preprocess\_...
    ([pr#37347](https://github.com/ceph/ceph/pull/37347), Greg Farnum)
-   mon: set session_timeout when adding to session_map
    ([pr#37553](https://github.com/ceph/ceph/pull/37553), Ilya Dryomov)
-   mon: store mon updates in ceph context for future MonMap
    instantiation ([pr#36705](https://github.com/ceph/ceph/pull/36705),
    Patrick Donnelly, Shyamsundar Ranganathan)
-   msg/async/ProtocolV2: allow rxbuf/txbuf get bigger in testing
    ([pr#37080](https://github.com/ceph/ceph/pull/37080), Ilya Dryomov)
-   os/bluestore: enable more flexible bluefs space management by
    default ([pr#37092](https://github.com/ceph/ceph/pull/37092), Igor
    Fedotov)
-   osd/osd-rep-recov-eio.sh: TEST_rados_repair_warning: return 1
    ([pr#37853](https://github.com/ceph/ceph/pull/37853), David Zafman)
-   osd: Check for nosrub/nodeep-scrub in between chunks, to avoid races
    ([pr#38359](https://github.com/ceph/ceph/pull/38359), David Zafman)
-   osdc/ObjectCacher: overwrite might cause stray read request
    callbacks ([pr#37674](https://github.com/ceph/ceph/pull/37674),
    Jason Dillaman)
-   osdc: add timeout configs for mons/osds
    ([pr#37530](https://github.com/ceph/ceph/pull/37530), Patrick
    Donnelly)
-   prometheus: Properly split the port off IPv6 addresses
    ([pr#36985](https://github.com/ceph/ceph/pull/36985), Matthew
    Oliver)
-   pybind/cephfs: add special values for not reading conffile
    ([pr#37724](https://github.com/ceph/ceph/pull/37724), Kefu Chai)
-   pybind/cephfs: fix custom exception raised by cephfs.pyx
    ([pr#37350](https://github.com/ceph/ceph/pull/37350), Ramana Raja)
-   pybind/mgr/volumes: add global lock debug
    ([pr#37366](https://github.com/ceph/ceph/pull/37366), Patrick
    Donnelly)
-   qa/\*/mon/mon-last-epoch-clean.sh: mark osd out instead of down
    ([pr#37349](https://github.com/ceph/ceph/pull/37349), Neha Ojha)
-   qa/cephfs: add session_timeout option support
    ([pr#37841](https://github.com/ceph/ceph/pull/37841), Xiubo Li)
-   qa/tasks/nfs: Test mounting of export created with nfs command
    ([pr#37365](https://github.com/ceph/ceph/pull/37365), Varsha Rao)
-   qa/tasks/{ceph,ceph_manager}: drop py2 support
    ([pr#37863](https://github.com/ceph/ceph/pull/37863), Kefu Chai)
-   qa/tests: added rhel 8.2
    ([pr#38287](https://github.com/ceph/ceph/pull/38287), Yuri
    Weinstein)
-   qa/tests: use bionic only for old clients in
    rados/thrash-old-clients
    ([pr#36931](https://github.com/ceph/ceph/pull/36931), Yuri
    Weinstein)
-   qa/workunits/mon: fixed excessively large pool PG count
    ([pr#37346](https://github.com/ceph/ceph/pull/37346), Jason
    Dillaman)
-   qa: Enable debug_client for mgr tests
    ([pr#37270](https://github.com/ceph/ceph/pull/37270), Brad Hubbard)
-   qa: Fix traceback during fs cleanup between tests
    ([pr#36713](https://github.com/ceph/ceph/pull/36713), Kotresh HR)
-   qa: add debugging for volumes plugin use of libcephfs
    ([pr#37352](https://github.com/ceph/ceph/pull/37352), Patrick
    Donnelly)
-   qa: drop hammer branch qa tests
    ([pr#37728](https://github.com/ceph/ceph/pull/37728), Neha Ojha,
    Deepika Upadhyay)
-   qa: ignore expected mds failover message
    ([pr#37367](https://github.com/ceph/ceph/pull/37367), Patrick
    Donnelly)
-   rbd-mirror: peer setup can still race and fail creation of peer
    ([pr#37342](https://github.com/ceph/ceph/pull/37342), Jason
    Dillaman)
-   rbd: include RADOS namespace in krbd symlinks
    ([pr#37343](https://github.com/ceph/ceph/pull/37343), Ilya Dryomov)
-   rbd: journal: possible race condition between flush and append
    callback ([pr#37850](https://github.com/ceph/ceph/pull/37850), Jason
    Dillaman)
-   rbd: librbd: ignore -ENOENT error when disabling object-map
    ([pr#37852](https://github.com/ceph/ceph/pull/37852), Jason
    Dillaman)
-   rbd: librbd: update AioCompletion return value before evaluating
    pending count ([pr#37851](https://github.com/ceph/ceph/pull/37851),
    Jason Dillaman)
-   rbd: make common options override krbd-specific options
    ([pr#37408](https://github.com/ceph/ceph/pull/37408), Ilya Dryomov)
-   rbd: rbd-nbd: don\'t ignore namespace when unmapping by image spec
    ([pr#37812](https://github.com/ceph/ceph/pull/37812), Mykola Golub)
-   rgw/gc: fix for incrementing the perf counter \'gc_retire_object\'
    ([pr#37847](https://github.com/ceph/ceph/pull/37847), Pritha
    Srivastava)
-   rgw/gc: fixing the condition when marker for a queue is
    ([pr#37846](https://github.com/ceph/ceph/pull/37846), Pritha
    Srivastava)
-   rgw/rgw_file: Fix the incorrect lru object eviction
    ([pr#37672](https://github.com/ceph/ceph/pull/37672), luo rixin)
-   rgw: Add bucket name to bucket stats error logging
    ([pr#37335](https://github.com/ceph/ceph/pull/37335), Seena Fallah)
-   rgw: Add request timeout to beast
    ([pr#37809](https://github.com/ceph/ceph/pull/37809), Adam C.
    Emerson, Or Friedmann)
-   rgw: RGWObjVersionTracker tracks version over increments
    ([pr#37337](https://github.com/ceph/ceph/pull/37337), Casey Bodley)
-   rgw: Swift API anonymous access should 401
    ([pr#37339](https://github.com/ceph/ceph/pull/37339), Matthew
    Oliver)
-   rgw: adds code for creating and managing oidc provider entities in
    rgw and for offline validation of OpenID Connect Access and ID Token
    ([pr#37640](https://github.com/ceph/ceph/pull/37640), Pritha
    Srivastava, Casey Bodley)
-   rgw: allow rgw-orphan-list to note when rados objects are in
    namespace ([pr#37800](https://github.com/ceph/ceph/pull/37800), J.
    Eric Ivancich)
-   rgw: dump transitions in RGWLifecycleConfiguration::dump()
    ([pr#36812](https://github.com/ceph/ceph/pull/36812), Shengming
    Zhang)
-   rgw: during GC defer, prevent new GC enqueue
    ([pr#38249](https://github.com/ceph/ceph/pull/38249), Casey
    Bodley, J. Eric Ivancich)
-   rgw: fix expiration header returned even if there is only one tag in
    the object the same as the rule
    ([pr#37807](https://github.com/ceph/ceph/pull/37807), Or Friedmann)
-   rgw: fix setting of namespace in ordered and unordered bucket
    listing ([pr#37673](https://github.com/ceph/ceph/pull/37673), J.
    Eric Ivancich)
-   rgw: fix user stats iterative increment
    ([pr#37779](https://github.com/ceph/ceph/pull/37779), Mark Kogan)
-   rgw: fix: S3 API KeyCount incorrect return
    ([pr#37849](https://github.com/ceph/ceph/pull/37849), 胡玮文)
-   rgw: log resharding events at level 1 (formerly 20)
    ([pr#36840](https://github.com/ceph/ceph/pull/36840), Or Friedmann)
-   rgw: radosgw-admin should paginate internally when listing bucket
    ([pr#37803](https://github.com/ceph/ceph/pull/37803), J. Eric
    Ivancich)
-   rgw: radosgw-admin: period pull command is not always a
    raw_storage_op ([pr#37336](https://github.com/ceph/ceph/pull/37336),
    Casey Bodley)
-   rgw: replace \'+\' with \"%20\" in canonical query string for s3 v4
    auth ([pr#37338](https://github.com/ceph/ceph/pull/37338),
    yuliyang_yewu)
-   rgw: rgw_file: avoid long-ish delay on shutdown
    ([pr#37551](https://github.com/ceph/ceph/pull/37551), Matt Benjamin)
-   rgw: s3: mark bucket encryption as not implemented
    ([pr#36691](https://github.com/ceph/ceph/pull/36691), Abhishek
    Lekshmanan)
-   rgw: urlencode bucket name when forwarding request
    ([pr#37340](https://github.com/ceph/ceph/pull/37340), caolei)
-   rgw: use yum rather than dnf for teuthology testing of
    rgw-orphan-list
    ([pr#37845](https://github.com/ceph/ceph/pull/37845), J. Eric
    Ivancich)
-   rpm,deb: drop /etc/sudoers.d/cephadm
    ([pr#37401](https://github.com/ceph/ceph/pull/37401), Nathan Cutler)
-   run-make-check.sh: Don\'t run tests if build fails
    ([pr#38294](https://github.com/ceph/ceph/pull/38294), Brad Hubbard)
-   systemd: Support Graceful Reboot for AIO Node
    ([pr#37300](https://github.com/ceph/ceph/pull/37300), Wong Hoi Sing
    Edison)
-   test/librados: fix endian bugs in checksum test cases
    ([pr#37604](https://github.com/ceph/ceph/pull/37604), Ulrich
    Weigand)
-   test/rbd-mirror: pool watcher registration error might result in
    race ([pr#37208](https://github.com/ceph/ceph/pull/37208), Jason
    Dillaman)
-   test/store_test: use \'threadsafe\' style for death tests
    ([pr#37819](https://github.com/ceph/ceph/pull/37819), Igor Fedotov)
-   tools/osdmaptool.cc: add ability to clean_temps
    ([pr#37348](https://github.com/ceph/ceph/pull/37348), Neha Ojha)
-   tools/rados: flush formatter periodically during json output of
    \"rados ls\"
    ([pr#37835](https://github.com/ceph/ceph/pull/37835), J. Eric
    Ivancich)
-   vstart.sh: fix fs set max_mds bug
    ([pr#37837](https://github.com/ceph/ceph/pull/37837), Jinmyeong Lee)

## v15.2.7 Octopus

This is the 7th backport release in the Octopus series. This release
fixes a serious bug in RGW that has been shown to cause data loss when a
read of a large RGW object (i.e., one with at least one tail segment)
takes longer than one half the time specified in the configuration
option `rgw_gc_obj_min_wait`. The bug causes the tail segments of that
read object to be added to the RGW garbage collection queue, which will
in turn cause them to be deleted after a period of time.

### Changelog

-   rgw: during GC defer, prevent new GC enqueue
    ([issue#47866](https://tracker.ceph.com/issues/47866),
    [pr#38249](https://github.com/ceph/ceph/pull/38249), Eric Ivancich,
    Casey Bodley)

## v15.2.6 Octopus

This is the 6th backport release in the Octopus series. This release
fixes a security flaw affecting Messenger v1 & v2. We recommend users to
update to this release.

### Notable Changes

-   CVE 2020-25660: CEPHX_V2 replay attack protection lost, for
    Messenger v1 & v2 (Ilya Dryomov)

### Changelog

-   mon/MonClient: bring back CEPHX_V2 authorizer challenges (Ilya
    Dryomov)

## v15.2.5 Octopus

This is the fifth release of the Ceph Octopus stable release series.
This release brings a range of fixes across all components. We recommend
that all Octopus users upgrade to this release.

### Notable Changes

-   CephFS: Automatic static subtree partitioning policies may now be
    configured using the new distributed and random ephemeral pinning
    extended attributes on directories. See the documentation for more
    information: <https://docs.ceph.com/docs/master/cephfs/multimds/>
-   Monitors now have a config option `mon_osd_warn_num_repaired`, 10 by
    default. If any OSD has repaired more than this many I/O errors in
    stored data a `OSD_TOO_MANY_REPAIRS` health warning is generated.
-   Now when noscrub and/or no deep-scrub flags are set globally or per
    pool, scheduled scrubs of the type disabled will be aborted. All
    user initiated scrubs are NOT interrupted.
-   Fix an issue with osdmaps not being trimmed in a healthy cluster (
    [issue#47297](https://tracker.ceph.com/issues/47297),
    [pr#36981](https://github.com/ceph/ceph/pull/36981))

### Changelog

-   bluestore,core: bluestore: blk:BlockDevice.cc: use pending_aios
    instead of iovec size as ios num
    ([pr#36668](https://github.com/ceph/ceph/pull/36668), weixinwei)
-   bluestore,tests: test/store_test: refactor bluestore spillover test
    ([pr#34943](https://github.com/ceph/ceph/pull/34943), Igor Fedotov)
-   bluestore,tests: tests: objectstore/store_test: kill
    ExcessiveFragmentation test case
    ([pr#36049](https://github.com/ceph/ceph/pull/36049), Igor Fedotov)
-   bluestore: bluestore: Rescue procedure for extremely large bluefs
    log ([pr#36123](https://github.com/ceph/ceph/pull/36123), Adam
    Kupczyk)
-   bluestore: octopus:os/bluestore: improve/fix bluefs stats reporting
    ([pr#35748](https://github.com/ceph/ceph/pull/35748), Igor Fedotov)
-   bluestore: os/bluestore: fix bluefs log growth
    ([pr#36621](https://github.com/ceph/ceph/pull/36621), Adam Kupczyk,
    Jianpeng Ma)
-   bluestore: os/bluestore: simplify Onode pin/unpin logic
    ([pr#36795](https://github.com/ceph/ceph/pull/36795), Igor Fedotov)
-   build/ops: Revert \"mgr/osd_support: remove module and all traces\"
    ([pr#36973](https://github.com/ceph/ceph/pull/36973), Sebastian
    Wagner)
-   build/ops: ceph-iscsi: selinux fixes
    ([pr#36302](https://github.com/ceph/ceph/pull/36302), Mike Christie)
-   build/ops: mgr/dashboard/api: reduce amount of daemon logs
    ([pr#36693](https://github.com/ceph/ceph/pull/36693), Ernesto
    Puerta)
-   ceph-volume: add dmcrypt support in raw mode
    ([pr#35830](https://github.com/ceph/ceph/pull/35830), Guillaume
    Abrioux)
-   ceph-volume: add drive-group subcommand
    ([pr#36558](https://github.com/ceph/ceph/pull/36558), Jan Fajerski,
    Sebastian Wagner)
-   ceph-volume: add tests for new functions that run LVM commands
    ([pr#36614](https://github.com/ceph/ceph/pull/36614), Rishabh Dave)
-   ceph-volume: don\'t use container classes in api/lvm.py
    ([pr#35879](https://github.com/ceph/ceph/pull/35879), Rishabh Dave,
    Guillaume Abrioux)
-   ceph-volume: fix lvm functional tests
    ([pr#36409](https://github.com/ceph/ceph/pull/36409), Jan Fajerski)
-   ceph-volume: handle idempotency with batch and explicit scenarios
    ([pr#35880](https://github.com/ceph/ceph/pull/35880), Andrew Schoen)
-   ceph-volume: remove container classes from api/lvm.py
    ([pr#36608](https://github.com/ceph/ceph/pull/36608), Rishabh Dave)
-   ceph-volume: report correct rejected reason in inventory if device
    type is invalid
    ([pr#36410](https://github.com/ceph/ceph/pull/36410), Satoru
    Takeuchi)
-   ceph-volume: run flake8 in python3
    ([pr#36588](https://github.com/ceph/ceph/pull/36588), Jan Fajerski)
-   cephfs,common: common: ignore SIGHUP prior to fork
    ([issue#46269](http://tracker.ceph.com/issues/46269),
    [pr#36195](https://github.com/ceph/ceph/pull/36195), Willem Jan
    Withagen, hzwuhongsong)
-   cephfs,core,mgr: mgr/status: metadata is fetched async
    ([pr#36630](https://github.com/ceph/ceph/pull/36630), Michael
    Fritch)
-   cephfs,core,rbd,rgw: librados: add LIBRADOS_SUPPORTS_GETADDRS
    support ([pr#36643](https://github.com/ceph/ceph/pull/36643), Xiubo
    Li)
-   cephfs,mgr: mgr/volumes/nfs: Add interface for adding user defined
    configuration ([pr#36635](https://github.com/ceph/ceph/pull/36635),
    Varsha Rao)
-   cephfs,mon: mon/MDSMonitor: copy MDS info which may be removed
    ([pr#36035](https://github.com/ceph/ceph/pull/36035), Patrick
    Donnelly)
-   cephfs,pybind: pybind/ceph_volume_client: Fix PEP-8 SyntaxWarning
    ([pr#36100](https://github.com/ceph/ceph/pull/36100), Đặng Minh
    Dũng)
-   cephfs,tests: mgr/fs/volumes: misc fixes
    ([pr#36327](https://github.com/ceph/ceph/pull/36327), Patrick
    Donnelly, Kotresh HR)
-   cephfs,tests: tests: Revert \"Revert
    \"qa/suites/rados/mgr/tasks/module_selftest: whitelist ...
    ([issue#43943](http://tracker.ceph.com/issues/43943),
    [pr#36042](https://github.com/ceph/ceph/pull/36042), Venky Shankar)
-   cephfs,tests: tests: qa/tasks/cephfs/cephfs_test_case.py: skip
    cleaning the core dumps when in program case
    ([pr#36043](https://github.com/ceph/ceph/pull/36043), Xiubo Li)
-   cephfs,tests: tests: qa/tasks: make sh() in vstart_runner.py
    identical with teuthology.orchestra.remote.sh
    ([pr#36044](https://github.com/ceph/ceph/pull/36044), Jos Collin)
-   cephfs: Update nfs-ganesha package requirements doc backport
    ([pr#36063](https://github.com/ceph/ceph/pull/36063), Varsha Rao)
-   cephfs: cephfs: client: fix setxattr for 0 size value (NULL value)
    ([pr#36045](https://github.com/ceph/ceph/pull/36045), Sidharth
    Anupkrishnan)
-   cephfs: cephfs: client: fix snap directory atime
    ([pr#36039](https://github.com/ceph/ceph/pull/36039), Luis
    Henriques)
-   cephfs: cephfs: client: release the client_lock before copying data
    in read ([pr#36046](https://github.com/ceph/ceph/pull/36046),
    Chencan)
-   cephfs: client: expose ceph.quota.max_bytes xattr within snapshots
    ([pr#36403](https://github.com/ceph/ceph/pull/36403), Shyamsundar
    Ranganathan)
-   cephfs: client: introduce timeout for client shutdown
    ([issue#44276](http://tracker.ceph.com/issues/44276),
    [pr#35962](https://github.com/ceph/ceph/pull/35962), \"Yan, Zheng\",
    Venky Shankar)
-   cephfs: mds/MDSRank: fix typo in \"unrecognized\"
    ([pr#36197](https://github.com/ceph/ceph/pull/36197), Nathan Cutler)
-   cephfs: mds: add ephemeral random and distributed export pins
    ([pr#35759](https://github.com/ceph/ceph/pull/35759), Patrick
    Donnelly, Sidharth Anupkrishnan)
-   cephfs: mds: fix filelock state when Fc is issued
    ([pr#35842](https://github.com/ceph/ceph/pull/35842), Xiubo Li)
-   cephfs: mds: reset heartbeat in EMetaBlob replay
    ([pr#36040](https://github.com/ceph/ceph/pull/36040), Yanhu Cao)
-   cephfs: mgr/nfs: Check if pseudo path is absolute path
    ([pr#36299](https://github.com/ceph/ceph/pull/36299), Varsha Rao)
-   cephfs: mgr/nfs: Update MDCACHE block in ganesha config and doc
    about nfs-cephadm in vstart
    ([pr#36224](https://github.com/ceph/ceph/pull/36224), Varsha Rao)
-   cephfs: mgr/volumes: Deprecate protect/unprotect CLI calls for
    subvolume snapshots
    ([pr#36126](https://github.com/ceph/ceph/pull/36126), Shyamsundar
    Ranganathan)
-   cephfs: mgr/volumes: fix \"ceph nfs export\" help messages
    ([pr#36220](https://github.com/ceph/ceph/pull/36220), Nathan Cutler)
-   cephfs: nfs backport
    ([pr#35499](https://github.com/ceph/ceph/pull/35499), Jeff Layton,
    Varsha Rao, Ramana Raja, Kefu Chai)
-   common,core: common, osd: add sanity checks around
    osd_scrub_max_preemptions
    ([pr#36034](https://github.com/ceph/ceph/pull/36034), xie xingguo)
-   common,rbd,tools: rbd: immutable-object-cache: fixed crashes on
    start up ([pr#36660](https://github.com/ceph/ceph/pull/36660), Jason
    Dillaman)
-   common,rbd: crush/CrushWrapper: rebuild reverse maps after
    rebuilding crush map
    ([pr#36662](https://github.com/ceph/ceph/pull/36662), Jason
    Dillaman)
-   common: common: log: fix timestap precision of log can\'t set to
    millisecond ([pr#36048](https://github.com/ceph/ceph/pull/36048),
    Guan yunfei)
-   core,mgr: mgr: decrease pool stats if pg was removed
    ([pr#36667](https://github.com/ceph/ceph/pull/36667), Aleksei
    Gutikov)
-   core,rbd: osd/OSDCap: rbd profile permits use of \"rbd_info\"
    ([pr#36414](https://github.com/ceph/ceph/pull/36414), Florian
    Florensa)
-   core,tools: tools/rados: Set locator key when exporting or importing
    a pool ([pr#36666](https://github.com/ceph/ceph/pull/36666), Iain
    Buclaw)
-   core: mon/OSDMonitor: Reset grace period if failure interval exceeds
    a threshold ([pr#35799](https://github.com/ceph/ceph/pull/35799),
    Sridhar Seshasayee)
-   core: mon/OSDMonitor: only take in osd into consideration when
    trimming osd...
    ([pr#36981](https://github.com/ceph/ceph/pull/36981), Kefu Chai)
-   core: mon: fix the \'Error ERANGE\' message when conf
    \"osd_objectstore\" is filestore
    ([pr#36665](https://github.com/ceph/ceph/pull/36665), wangyunqing)
-   core: monclient: schedule first tick using mon_client_hunt_interval
    ([pr#36633](https://github.com/ceph/ceph/pull/36633), Mykola Golub)
-   core: osd/OSD.cc: remove osd_lock for bench
    ([pr#36664](https://github.com/ceph/ceph/pull/36664), Neha Ojha,
    Adam Kupczyk)
-   core: osd/PG: fix history.same_interval_since of merge target again
    ([pr#36033](https://github.com/ceph/ceph/pull/36033), xie xingguo)
-   core: osd/PeeringState: prevent peer\'s num_objects going negative
    ([pr#36663](https://github.com/ceph/ceph/pull/36663), xie xingguo)
-   core: osd/PrimaryLogPG: don\'t populate watchers if replica
    ([pr#36029](https://github.com/ceph/ceph/pull/36029), Ilya Dryomov)
-   core: osd: Cancel in-progress scrubs (not user requested)
    ([pr#36291](https://github.com/ceph/ceph/pull/36291), David Zafman)
-   core: osd: expose osdspec_affinity to osd_metadata
    ([pr#35957](https://github.com/ceph/ceph/pull/35957), Joshua Schmid)
-   core: osd: fix crash in \_committed_osd_maps if incremental osdmap
    crc fails ([pr#36340](https://github.com/ceph/ceph/pull/36340), Neha
    Ojha, Dan van der Ster)
-   core: osd: make message cap option usable again
    ([pr#35737](https://github.com/ceph/ceph/pull/35737), Neha Ojha,
    Josh Durgin)
-   core: osd: wakeup all threads of shard rather than one thread
    ([pr#36032](https://github.com/ceph/ceph/pull/36032), Jianpeng Ma)
-   core: test: osd-backfill-stats.sh use nobackfill to avoid races in
    remainin... ([pr#36030](https://github.com/ceph/ceph/pull/36030),
    David Zafman)
-   doc: cephadm batch backport
    ([pr#36450](https://github.com/ceph/ceph/pull/36450), Varsha Rao,
    Ricardo Marques, Kiefer Chang, Matthew Oliver, Paul Cuzner, Kefu
    Chai, Daniel-Pivonka, Sebastian Wagner, Volker Theile, Adam King,
    Michael Fritch, Joshua Schmid)
-   doc: doc/mgr/crash: Add missing command in rm example
    ([pr#36690](https://github.com/ceph/ceph/pull/36690), Daniël Vos)
-   doc: doc/rados: Fix osd_scrub_during_recovery default value
    ([pr#36661](https://github.com/ceph/ceph/pull/36661), Benoît Knecht)
-   doc: doc/rbd: add rbd-target-gw enable and start
    ([pr#36416](https://github.com/ceph/ceph/pull/36416), Zac Dover)
-   doc: doc: PendingReleaseNotes: clean slate for 15.2.5
    ([pr#35753](https://github.com/ceph/ceph/pull/35753), Nathan Cutler)
-   mgr,pybind: pybind/mgr/balancer: use \"==\" and \"!=\" for comparing
    str ([pr#36036](https://github.com/ceph/ceph/pull/36036), Kefu Chai)
-   mgr,pybind: pybind/mgr/pg_autoscaler/module.py: do not update event
    if ev.pg_num== ev.pg_num_target
    ([pr#36037](https://github.com/ceph/ceph/pull/36037), Neha Ojha)
-   mgr,rbd: mgr/prometheus: automatically discover RBD pools for stats
    gathering ([pr#36411](https://github.com/ceph/ceph/pull/36411),
    Jason Dillaman)
-   mgr/dashboard/api: increase API health timeout
    ([pr#36562](https://github.com/ceph/ceph/pull/36562), Ernesto
    Puerta)
-   mgr/dashboard: Add button to copy the bootstrap token into the
    clipboard ([pr#35796](https://github.com/ceph/ceph/pull/35796),
    Ishan Rai)
-   mgr/dashboard: Add host labels in UI
    ([pr#35893](https://github.com/ceph/ceph/pull/35893), Volker Theile)
-   mgr/dashboard: Add hosts page unit tests
    ([pr#36350](https://github.com/ceph/ceph/pull/36350), Volker Theile)
-   mgr/dashboard: Allow to edit iSCSI target with active session
    ([pr#35997](https://github.com/ceph/ceph/pull/35997), Ricardo
    Marques)
-   mgr/dashboard: Always use fast angular unit tests
    ([pr#36267](https://github.com/ceph/ceph/pull/36267), Stephan
    Müller)
-   mgr/dashboard: Configure overflow of popover in health page
    ([pr#36460](https://github.com/ceph/ceph/pull/36460), Tiago Melo)
-   mgr/dashboard: Display check icon instead of true\|false in various
    datatables ([pr#35892](https://github.com/ceph/ceph/pull/35892),
    Volker Theile)
-   mgr/dashboard: Display users current bucket quota usage
    ([pr#35926](https://github.com/ceph/ceph/pull/35926), Ernesto
    Puerta, Avan Thakkar)
-   mgr/dashboard: Extract documentation link to a component
    ([pr#36587](https://github.com/ceph/ceph/pull/36587), Tiago Melo)
-   mgr/dashboard: Fix host attributes like labels are not returned
    ([pr#36678](https://github.com/ceph/ceph/pull/36678), Kiefer Chang)
-   mgr/dashboard: Hide password notification when expiration date is
    far ([pr#35975](https://github.com/ceph/ceph/pull/35975), Tiago
    Melo)
-   mgr/dashboard: Improve Summary\'s subscribe methods
    ([pr#35705](https://github.com/ceph/ceph/pull/35705), Tiago Melo)
-   mgr/dashboard: Prometheus query error in the metrics of Pools, OSDs
    and RBD images ([pr#35885](https://github.com/ceph/ceph/pull/35885),
    Avan Thakkar)
-   mgr/dashboard: Re-enable OSD\'s table autoReload
    ([pr#36226](https://github.com/ceph/ceph/pull/36226), Kiefer Chang,
    Tiago Melo)
-   mgr/dashboard: Strange iSCSI discovery auth behavior
    ([pr#36782](https://github.com/ceph/ceph/pull/36782), Volker Theile)
-   mgr/dashboard: The max. buckets field in RGW user form should be
    pre-filled ([pr#35795](https://github.com/ceph/ceph/pull/35795),
    Volker Theile)
-   mgr/dashboard: Unable to edit iSCSI logged-in client
    ([pr#36611](https://github.com/ceph/ceph/pull/36611), Ricardo
    Marques)
-   mgr/dashboard: Use right size in pool form
    ([pr#35925](https://github.com/ceph/ceph/pull/35925), Stephan
    Müller)
-   mgr/dashboard: Use same required field message accross the UI
    ([pr#36277](https://github.com/ceph/ceph/pull/36277), Volker Theile)
-   mgr/dashboard: add API team to CODEOWNERS
    ([pr#36143](https://github.com/ceph/ceph/pull/36143), Ernesto
    Puerta)
-   mgr/dashboard: allow preserving OSD IDs when deleting OSDs
    ([pr#35766](https://github.com/ceph/ceph/pull/35766), Kiefer Chang)
-   mgr/dashboard: cpu stats incorrectly displayed
    ([pr#36322](https://github.com/ceph/ceph/pull/36322), Avan Thakkar)
-   mgr/dashboard: cropped actions menu in nested details
    ([pr#35620](https://github.com/ceph/ceph/pull/35620), Avan Thakkar)
-   mgr/dashboard: fix Source column i18n issue in RBD configuration
    tables ([pr#35819](https://github.com/ceph/ceph/pull/35819), Kiefer
    Chang)
-   mgr/dashboard: fix backporting issue #35926
    ([pr#36073](https://github.com/ceph/ceph/pull/36073), Ernesto
    Puerta)
-   mgr/dashboard: fix pool usage calculation
    ([pr#36137](https://github.com/ceph/ceph/pull/36137), Ernesto
    Puerta)
-   mgr/dashboard: fix rbdmirroring dropdown menu
    ([pr#36382](https://github.com/ceph/ceph/pull/36382), Avan Thakkar)
-   mgr/dashboard: fix regression in delete OSD modal
    ([pr#36419](https://github.com/ceph/ceph/pull/36419), Kiefer Chang)
-   mgr/dashboard: fix
    tasks.mgr.dashboard.test_rbd.RbdTest.test_move_image_to_trash error
    ([pr#36563](https://github.com/ceph/ceph/pull/36563), Kiefer Chang)
-   mgr/dashboard: fix ui api endpoints
    ([pr#36160](https://github.com/ceph/ceph/pull/36160), Fabrizio
    D\'Angelo)
-   mgr/dashboard: fix wal/db slots controls in the OSD form
    ([pr#35883](https://github.com/ceph/ceph/pull/35883), Kiefer Chang)
-   mgr/dashboard: increase API test coverage in API controllers
    ([pr#36260](https://github.com/ceph/ceph/pull/36260), Kefu Chai,
    Aashish Sharma)
-   mgr/dashboard: redirect to original URL after successful login
    ([pr#36831](https://github.com/ceph/ceph/pull/36831), Avan Thakkar)
-   mgr/dashboard: remove \"This week/month/year\" and \"Today\" time
    stamps ([pr#36789](https://github.com/ceph/ceph/pull/36789), Avan
    Thakkar)
-   mgr/dashboard: remove cdCopy2ClipboardButton [formatted]{.title-ref}
    attribute ([pr#35889](https://github.com/ceph/ceph/pull/35889),
    Tatjana Dehler)
-   mgr/dashboard: remove password field if login is using SSO and fix
    error message in confirm password
    ([pr#36689](https://github.com/ceph/ceph/pull/36689), Ishan Rai)
-   mgr/dashboard: right-align dropdown menu of column filters
    ([pr#36369](https://github.com/ceph/ceph/pull/36369), Kiefer Chang)
-   mgr/dashboard: telemetry activation notification
    ([pr#35772](https://github.com/ceph/ceph/pull/35772), Tatjana
    Dehler)
-   mgr/dashboard: wait longer for health status to be cleared
    ([pr#36346](https://github.com/ceph/ceph/pull/36346), Tatjana
    Dehler)
-   mgr/k8sevents: sanitise kubernetes events
    ([pr#35684](https://github.com/ceph/ceph/pull/35684), Paul Cuzner)
-   mgr/prometheus: improve cache
    ([pr#35847](https://github.com/ceph/ceph/pull/35847), Patrick
    Seidensal)
-   mgr: avoid false alarm of MGR_MODULE_ERROR
    ([pr#35995](https://github.com/ceph/ceph/pull/35995), Kefu Chai)
-   mgr: mgr/DaemonServer.cc: make \'config show\' on fsid work
    ([pr#35793](https://github.com/ceph/ceph/pull/35793), Neha Ojha)
-   mgr: mgr/cephadm: Adapt Vagrantfile to use octopus instead of master
    repo on shaman ([pr#35988](https://github.com/ceph/ceph/pull/35988),
    Volker Theile)
-   mgr: mgr/diskprediction_local: Fix array size error
    ([pr#36577](https://github.com/ceph/ceph/pull/36577), Benoît Knecht)
-   mgr: mgr/progress: Skip pg_summary update if \_events dict is empty
    ([pr#36076](https://github.com/ceph/ceph/pull/36076), Manuel Lausch)
-   mgr: mgr/prometheus: log time it takes to collect metrics
    ([pr#36581](https://github.com/ceph/ceph/pull/36581), Patrick
    Seidensal)
-   mgr: mgr: Add missing states to PG_STATES in mgr_module.py
    ([pr#36786](https://github.com/ceph/ceph/pull/36786), Harley
    Gorrell)
-   mgr: mgr: fix race between module load and notify
    ([pr#35794](https://github.com/ceph/ceph/pull/35794), Mykola Golub)
-   mgr: mon/PGMap: do not consider changing pg stuck
    ([pr#35958](https://github.com/ceph/ceph/pull/35958), Kefu Chai)
-   monitoring: alert for pool fill up broken
    ([pr#35136](https://github.com/ceph/ceph/pull/35136), Volker Theile)
-   msgr: New msgr2 crc and secure modes (msgr2.1)
    ([pr#35720](https://github.com/ceph/ceph/pull/35720), Ilya Dryomov)
-   rbd,tests: tests/rbd_mirror: fix race on test shut down
    ([pr#36657](https://github.com/ceph/ceph/pull/36657), Mykola Golub)
-   rbd: librbd: global and pool-level config overrides require image
    refresh to apply
    ([pr#36638](https://github.com/ceph/ceph/pull/36638), Jason
    Dillaman)
-   rbd: librbd: new \'write_zeroes\' API methods to suppliment the
    [discard]{.title-ref} APIs
    ([pr#36247](https://github.com/ceph/ceph/pull/36247), Jason
    Dillaman)
-   rbd: librbd: potential race conditions handling API IO completions
    ([pr#36331](https://github.com/ceph/ceph/pull/36331), Jason
    Dillaman)
-   rbd: mgr/dashboard: work with v1 RBD images
    ([pr#35711](https://github.com/ceph/ceph/pull/35711), Ernesto
    Puerta)
-   rbd: rbd: librbd: Align rbd_write_zeroes declarations
    ([pr#36717](https://github.com/ceph/ceph/pull/36717), Corey Bryant)
-   rbd: rbd: librbd: don\'t resend async_complete if watcher is
    unregistered ([pr#36659](https://github.com/ceph/ceph/pull/36659),
    Mykola Golub)
-   rbd: rbd: librbd: flush all queued object IO from simple scheduler
    ([pr#36658](https://github.com/ceph/ceph/pull/36658), Jason
    Dillaman)
-   rbd: rbd: librbd: race when disabling object map with overlapping
    in-flight writes
    ([pr#36656](https://github.com/ceph/ceph/pull/36656), Jason
    Dillaman)
-   rbd: rbd: recognize crush_location, read_from_replica and
    compression_hint map options
    ([pr#36061](https://github.com/ceph/ceph/pull/36061), Ilya Dryomov)
-   rgw,tests: qa/tasks/ragweed: always set ragweed_repo
    ([pr#36651](https://github.com/ceph/ceph/pull/36651), Kefu Chai)
-   rgw: rgw: lc: fix Segmentation Fault when the tag of the object was
    not found ([pr#36085](https://github.com/ceph/ceph/pull/36085),
    yupeng chen, zhuo li)
-   rgw: Add subuser to OPA request
    ([pr#36023](https://github.com/ceph/ceph/pull/36023), Seena Fallah)
-   rgw: Add support wildcard subuser for bucket policy
    ([pr#36022](https://github.com/ceph/ceph/pull/36022), Seena Fallah)
-   rgw: Adding data cache and CDN capabilities
    ([pr#36646](https://github.com/ceph/ceph/pull/36646), Mark Kogan, Or
    Friedmann)
-   rgw: Empty reqs_change_state queue before unregistered_reqs
    ([pr#36650](https://github.com/ceph/ceph/pull/36650), Soumya Koduri)
-   rgw: add abort multipart date and rule-id header to init multipart
    upload response
    ([pr#36649](https://github.com/ceph/ceph/pull/36649), zhang Shaowen,
    zhangshaowen)
-   rgw: add access log to the beast frontend
    ([pr#36024](https://github.com/ceph/ceph/pull/36024), Mark Kogan)
-   rgw: add check for index entry\'s existing when adding bucket stats
    during bucket reshard
    ([pr#36025](https://github.com/ceph/ceph/pull/36025), zhang Shaowen)
-   rgw: add negative cache to the system object
    ([pr#36648](https://github.com/ceph/ceph/pull/36648), Or Friedmann)
-   rgw: add quota enforcement to CopyObj
    ([pr#36020](https://github.com/ceph/ceph/pull/36020), Casey Bodley)
-   rgw: append obj: prevent tail from being GC\'ed
    ([pr#36389](https://github.com/ceph/ceph/pull/36389), Abhishek
    Lekshmanan)
-   rgw: bucket list/stats truncates for user w/ \>1000 buckets
    ([pr#36019](https://github.com/ceph/ceph/pull/36019), J. Eric
    Ivancich)
-   rgw: cls/rgw: preserve olh entry\'s name on last unlink
    ([pr#36652](https://github.com/ceph/ceph/pull/36652), Casey Bodley)
-   rgw: cls/rgw_gc: Fixing the iterator used to access urgent data map
    ([pr#36017](https://github.com/ceph/ceph/pull/36017), Pritha
    Srivastava)
-   rgw: fix boost::asio::async_write() does not return error
    ([pr#36647](https://github.com/ceph/ceph/pull/36647), Mark Kogan)
-   rgw: fix bug where ordered bucket listing gets stuck
    ([pr#35877](https://github.com/ceph/ceph/pull/35877), J. Eric
    Ivancich)
-   rgw: fix double slash (//) killing the gateway
    ([pr#36654](https://github.com/ceph/ceph/pull/36654), Theofilos
    Mouratidis)
-   rgw: fix loop problem with swift stat on account
    ([pr#36021](https://github.com/ceph/ceph/pull/36021), Marcus Watts)
-   rgw: fix shutdown crash in RGWAsyncReadMDLogEntries
    ([pr#36653](https://github.com/ceph/ceph/pull/36653), Casey Bodley)
-   rgw: introduce safe user-reset-stats
    ([pr#36655](https://github.com/ceph/ceph/pull/36655), Yuval
    Lifshitz, Matt Benjamin)
-   rgw: lc: add lifecycle perf counters
    ([pr#36018](https://github.com/ceph/ceph/pull/36018), Mark Kogan,
    Matt Benjamin)
-   rgw: orphan list teuthology test & fully-qualified domain issue
    ([pr#36027](https://github.com/ceph/ceph/pull/36027), J. Eric
    Ivancich)
-   rgw: orphan-list timestamp fix
    ([pr#35929](https://github.com/ceph/ceph/pull/35929), J. Eric
    Ivancich)
-   rgw: policy: reuse eval_principal to evaluate the policy principal
    ([pr#36636](https://github.com/ceph/ceph/pull/36636), Abhishek
    Lekshmanan)
-   rgw: radoslist incomplete multipart uploads fix marker progression
    ([pr#36028](https://github.com/ceph/ceph/pull/36028), J. Eric
    Ivancich)
-   rgw: rgw/iam: correcting the result of get role policy
    ([pr#36645](https://github.com/ceph/ceph/pull/36645), Pritha
    Srivastava)
-   rgw: selinux: allow ceph_t amqp_port_t:tcp_socket
    ([pr#36026](https://github.com/ceph/ceph/pull/36026), Kaleb S.
    KEITHLEY, Thomas Serlin)
-   rgw: stop realm reloader before store shutdown
    ([pr#36644](https://github.com/ceph/ceph/pull/36644), Kefu Chai,
    Casey Bodley)
-   tools: tools: Add statfs operation to ceph-objecstore-tool
    ([pr#35715](https://github.com/ceph/ceph/pull/35715), David Zafman)

## v15.2.4 Octopus

This is the fourth release of the Ceph Octopus stable release series. In
addition to a security fix in RGW, this release brings a range of fixes
across all components. We recommend that all Octopus users upgrade to
this release.

### Notable Changes

-   CVE-2020-10753: rgw: sanitize newlines in s3 CORSConfiguration\'s
    ExposeHeader (William Bowling, Adam Mohammed, Casey Bodley)

-   Cephadm: There were a lot of small usability improvements and bug
    fixes:

    -   Grafana when deployed by Cephadm now binds to all network
        interfaces.
    -   `cephadm check-host` now prints all detected problems at once.
    -   Cephadm now calls
        `ceph dashboard set-grafana-api-ssl-verify false` when
        generating an SSL certificate for Grafana.
    -   The Alertmanager is now correctly pointed to the Ceph Dashboard
    -   `cephadm adopt` now supports adopting an Alertmanager
    -   `ceph orch ps` now supports filtering by service name
    -   `ceph orch host ls` now marks hosts as offline, if they are not
        accessible.

-   Cephadm can now deploy NFS Ganesha services. For example, to deploy
    NFS with a service id of mynfs, that will use the RADOS pool
    nfs-ganesha and namespace nfs-ns:

        ceph orch apply nfs mynfs nfs-ganesha nfs-ns

-   Cephadm: `ceph orch ls --export` now returns all service
    specifications in yaml representation that is consumable by
    `ceph orch apply`. In addition, the commands `orch ps` and `orch ls`
    now support `--format yaml` and `--format json-pretty`.

-   Cephadm: `ceph orch apply osd` supports a `--preview` flag that
    prints a preview of the OSD specification before deploying OSDs.
    This makes it possible to verify that the specification is correct,
    before applying it.

-   RGW: The `radosgw-admin` sub-commands dealing with orphans
    \--`radosgw-admin orphans find`, `radosgw-admin orphans finish`, and
    `radosgw-admin orphans list-jobs` \-- have been deprecated. They
    have not been actively maintained and they store intermediate
    results on the cluster, which could fill a nearly-full cluster. They
    have been replaced by a tool, currently considered experimental,
    `rgw-orphan-list`.

-   RBD: The name of the rbd pool object that is used to store rbd trash
    purge schedule is changed from \"rbd_trash_trash_purge_schedule\" to
    \"rbd_trash_purge_schedule\". Users that have already started using
    `rbd trash purge schedule` functionality and have per pool or
    namespace schedules configured should copy
    \"rbd_trash_trash_purge_schedule\" object to
    \"rbd_trash_purge_schedule\" before the upgrade and remove
    \"rbd_trash_purge_schedule\" using the following commands in every
    RBD pool and namespace where a trash purge schedule was previously
    configured:

        rados -p <pool-name> [-N namespace] cp rbd_trash_trash_purge_schedule rbd_trash_purge_schedule
        rados -p <pool-name> [-N namespace] rm rbd_trash_trash_purge_schedule

    or use any other convenient way to restore the schedule after the
    upgrade.

### Changelog

-   build/ops: address SElinux denials observed in rgw/multisite test
    run ([pr#34538](https://github.com/ceph/ceph/pull/34538), Kefu Chai,
    Kaleb S. Keithley)
-   ceph-volume: add and delete lvm tags in a single lvchange call
    ([pr#35452](https://github.com/ceph/ceph/pull/35452), Jan Fajerski)
-   ceph-volume: add ceph.osdspec_affinity tag
    ([pr#35134](https://github.com/ceph/ceph/pull/35134), Joshua Schmid)
-   cephadm: batch backport May (1)
    ([pr#34893](https://github.com/ceph/ceph/pull/34893), Michael
    Fritch, Ricardo Marques, Matthew Oliver, Sebastian Wagner, Joshua
    Schmid, Zac Dover, Varsha Rao)
-   cephadm: batch backport May (2)
    ([pr#35188](https://github.com/ceph/ceph/pull/35188), Michael
    Fritch, Sebastian Wagner, Kefu Chai, Georgios Kyratsas, Kiefer
    Chang, Joshua Schmid, Patrick Seidensal, Varsha Rao, Matthew Oliver,
    Zac Dover, Juan Miguel Olmo Martínez, Tim Serong, Alexey Miasoedov,
    Ricardo Marques, Satoru Takeuchi)
-   cephadm: batch backport June (1)
    ([pr#35347](https://github.com/ceph/ceph/pull/35347), Sebastian
    Wagner, Zac Dover, Georgios Kyratsas, Kiefer Chang, Ricardo Marques,
    Patrick Seidensal, Patrick Donnelly, Joshua Schmid, Matthew Oliver,
    Varsha Rao, Juan Miguel Olmo Martínez, Michael Fritch)
-   cephadm: batch backport June (2)
    ([pr#35475](https://github.com/ceph/ceph/pull/35475), Sebastian
    Wagner, Kiefer Chang, Joshua Schmid, Michael Fritch, shinhwagk, Kefu
    Chai, Juan Miguel Olmo Martínez, Daniel Pivonka)
-   cephfs: allow pool names with hyphen and period
    ([pr#35251](https://github.com/ceph/ceph/pull/35251), Ramana Raja)
-   cephfs: bash_completion: Do not auto complete obsolete and hidden
    cmds ([pr#34996](https://github.com/ceph/ceph/pull/34996), Kotresh
    HR)
-   cephfs: cephfs-shell: Change tox testenv name to py3
    ([pr#34998](https://github.com/ceph/ceph/pull/34998), Kefu Chai,
    Varsha Rao, Aditya Srivastava)
-   cephfs: client: expose Client::ll_register_callback via libcephfs
    ([pr#35150](https://github.com/ceph/ceph/pull/35150), Jeff Layton)
-   cephfs: client: fix Finisher assert failure
    ([pr#34999](https://github.com/ceph/ceph/pull/34999), Xiubo Li)
-   cephfs: client: only set MClientCaps::FLAG_SYNC when flushing dirty
    auth caps ([pr#34997](https://github.com/ceph/ceph/pull/34997), Jeff
    Layton)
-   cephfs: fuse: add the \'-d\' option back for libfuse
    ([pr#35449](https://github.com/ceph/ceph/pull/35449), Xiubo Li)
-   cephfs: mds: Handle blacklisted error in purge queue
    ([pr#35148](https://github.com/ceph/ceph/pull/35148), Varsha Rao)
-   cephfs: mds: preserve ESlaveUpdate logevent until receiving
    OP_FINISH ([pr#35253](https://github.com/ceph/ceph/pull/35253),
    songxinying)
-   cephfs: mds: take xlock in the order requests start locking
    ([pr#35252](https://github.com/ceph/ceph/pull/35252), \"Yan,
    Zheng\")
-   cephfs: src/client/fuse_ll: compatible with libfuse3.5 or higher
    ([pr#35450](https://github.com/ceph/ceph/pull/35450), Jeff Layton,
    Xiubo Li)
-   cephfs: vstart_runner: set mounted to True at the end of mount()
    ([pr#35447](https://github.com/ceph/ceph/pull/35447), Rishabh Dave)
-   core: bluestore: fix large (\>2GB) writes when bluefs_buffered_io =
    true ([pr#35446](https://github.com/ceph/ceph/pull/35446), Igor
    Fedotov)
-   core: bluestore: introduce hybrid allocator
    ([pr#35498](https://github.com/ceph/ceph/pull/35498), Igor Fedotov,
    Adam Kupczyk)
-   core: cls/queue: fix empty markers when listing entries
    ([pr#35241](https://github.com/ceph/ceph/pull/35241), Pritha
    Srivastava, Yuval Lifshitz)
-   core: objecter: don\'t attempt to read from non-primary on EC pools
    ([pr#35444](https://github.com/ceph/ceph/pull/35444), Ilya Dryomov)
-   core: osd: add \--osdspec-affinity flag
    ([pr#35382](https://github.com/ceph/ceph/pull/35382), Joshua Schmid)
-   core: osd: make \"missing incremental map\" a debug log message
    ([pr#35442](https://github.com/ceph/ceph/pull/35442), Nathan Cutler)
-   core: osd: prevent ShardedOpWQ suicide_grace drop when waiting for
    work ([pr#34881](https://github.com/ceph/ceph/pull/34881), Dan Hill)
-   core: rocksdb: Update to ceph-octopus-v5.8-1436
    ([pr#35036](https://github.com/ceph/ceph/pull/35036), Brad Hubbard)
-   doc: drop obsolete cache tier options
    ([pr#35105](https://github.com/ceph/ceph/pull/35105), Nathan Cutler)
-   doc: mgr/dashboard: Add troubleshooting guide
    ([pr#34947](https://github.com/ceph/ceph/pull/34947), Tatjana
    Dehler)
-   doc: rgw: document \'rgw gc max concurrent io\'
    ([pr#34987](https://github.com/ceph/ceph/pull/34987), Casey Bodley)
-   mds: cleanup uncommitted fragments before mds goes to active
    ([pr#35448](https://github.com/ceph/ceph/pull/35448), \"Yan,
    Zheng\")
-   mds: don\'t assert empty io context list when shutting down
    ([pr#34509](https://github.com/ceph/ceph/pull/34509), \"Yan,
    Zheng\")
-   mds: don\'t shallow copy when decoding xattr map
    ([pr#35147](https://github.com/ceph/ceph/pull/35147), \"Yan,
    Zheng\")
-   mds: flag backtrace scrub failures for new files as okay
    ([pr#35555](https://github.com/ceph/ceph/pull/35555), Milind
    Changire)
-   mgr/dashboard/grafana: Add rbd-image details dashboard
    ([pr#35247](https://github.com/ceph/ceph/pull/35247), Enno Gotthold)
-   mgr/dashboard: Asynchronous unique username validation for User
    Component ([pr#34849](https://github.com/ceph/ceph/pull/34849),
    Nizamudeen)
-   mgr/dashboard: ECP modal enhancement
    ([pr#35152](https://github.com/ceph/ceph/pull/35152), Stephan
    Müller)
-   mgr/dashboard: Fix HomeTest setup
    ([pr#35085](https://github.com/ceph/ceph/pull/35085), Tiago Melo)
-   mgr/dashboard: Fix e2e chromium binary validation
    ([pr#35679](https://github.com/ceph/ceph/pull/35679), Tiago Melo)
-   mgr/dashboard: Fix random E2E error in mgr-modules
    ([pr#35706](https://github.com/ceph/ceph/pull/35706), Tiago Melo)
-   mgr/dashboard: Fix redirect after changing password
    ([pr#35243](https://github.com/ceph/ceph/pull/35243), Tiago Melo)
-   mgr/dashboard: Prevent dashboard breakdown on bad pool selection
    ([pr#35135](https://github.com/ceph/ceph/pull/35135), Stephan
    Müller)
-   mgr/dashboard: Proposed About Modal box
    ([pr#35291](https://github.com/ceph/ceph/pull/35291), Ngwa Sedrick
    Meh, Tiago Melo)
-   mgr/dashboard: Reduce requests in Mirroring page
    ([pr#34992](https://github.com/ceph/ceph/pull/34992), Tiago Melo)
-   mgr/dashboard: Replace Protractor with Cypress
    ([pr#34910](https://github.com/ceph/ceph/pull/34910), Tiago Melo)
-   mgr/dashboard: Show labels in hosts page
    ([pr#35517](https://github.com/ceph/ceph/pull/35517), Volker Theile)
-   mgr/dashboard: Show table details inside the datatable
    ([pr#35270](https://github.com/ceph/ceph/pull/35270), Sebastian
    Krah)
-   mgr/dashboard: add telemetry report component
    ([pr#34850](https://github.com/ceph/ceph/pull/34850), Tatjana
    Dehler)
-   mgr/dashboard: displaying Service detail inside table
    ([pr#35269](https://github.com/ceph/ceph/pull/35269), Kiefer Chang)
-   mgr/dashboard: fix autocomplete input backgrounds in chrome and
    firefox ([pr#35718](https://github.com/ceph/ceph/pull/35718), Ishan
    Rai)
-   mgr/dashboard: grafana panels for rgw multisite sync performance
    ([pr#35693](https://github.com/ceph/ceph/pull/35693), Alfonso
    Martínez)
-   mgr/dashboard: monitoring menu entry should indicate firing alerts
    ([pr#34822](https://github.com/ceph/ceph/pull/34822), Tiago Melo,
    Volker Theile)
-   mgr/dashboard: redesign the login screen
    ([pr#35268](https://github.com/ceph/ceph/pull/35268), Ishan Rai)
-   mgr/dashboard: remove space after service name in the Hosts List
    table ([pr#35531](https://github.com/ceph/ceph/pull/35531), Kiefer
    Chang)
-   mgr/dashboard: replace hard coded telemetry URLs
    ([pr#35231](https://github.com/ceph/ceph/pull/35231), Tatjana
    Dehler)
-   mgr/rbd_support: rename \"rbd_trash_trash_purge_schedule\" oid
    ([pr#35436](https://github.com/ceph/ceph/pull/35436), Nathan Cutler,
    Mykola Golub)
-   mgr/status: Fix \"ceph fs status\" json format writing to stderr
    ([pr#34727](https://github.com/ceph/ceph/pull/34727), Kotresh HR)
-   mgr/test_orchestrator: fix \_get_ceph_daemons()
    ([pr#34979](https://github.com/ceph/ceph/pull/34979), Alfonso
    Martínez)
-   mgr/volumes: Add snapshot info command
    ([pr#35670](https://github.com/ceph/ceph/pull/35670), Kotresh HR)
-   mgr/volumes: Create subvolume with isolated rados namespace
    ([pr#35671](https://github.com/ceph/ceph/pull/35671), Kotresh HR)
-   mgr/volumes: Fix subvolume create idempotency
    ([pr#35256](https://github.com/ceph/ceph/pull/35256), Kotresh HR)
-   mgr: synchronize ClusterState\'s health and mon_status
    ([pr#34995](https://github.com/ceph/ceph/pull/34995), Radoslaw
    Zarzynski)
-   monitoring: Fix \"10% OSDs down\" alert description
    ([pr#35151](https://github.com/ceph/ceph/pull/35151), Benoît Knecht)
-   monitoring: fixing some issues in RBD detail dashboard
    ([pr#35463](https://github.com/ceph/ceph/pull/35463), Kiefer Chang)
-   rbd: librbd: Watcher should not attempt to re-watch after detecting
    blacklisting ([pr#35439](https://github.com/ceph/ceph/pull/35439),
    Jason Dillaman)
-   rbd: librbd: avoid completing mirror:DisableRequest while holding
    its lock ([pr#35126](https://github.com/ceph/ceph/pull/35126), Jason
    Dillaman)
-   rbd: librbd: copy API should not inherit v1 image format by default
    ([pr#35255](https://github.com/ceph/ceph/pull/35255), Jason
    Dillaman)
-   rbd: librbd: make rbd_read_from_replica_policy actually work
    ([pr#35438](https://github.com/ceph/ceph/pull/35438), Ilya Dryomov)
-   rbd: pybind: RBD.create() method\'s \'old_format\' parameter now
    defaults to False
    ([pr#35435](https://github.com/ceph/ceph/pull/35435), Jason
    Dillaman)
-   rbd: rbd-mirror: don\'t hold (stale) copy of local image journal
    pointer ([pr#35430](https://github.com/ceph/ceph/pull/35430), Jason
    Dillaman)
-   rbd: rbd-mirror: stop local journal replayer first during shut down
    ([pr#35440](https://github.com/ceph/ceph/pull/35440), Jason
    Dillaman, Mykola Golub)
-   rbd: rbd-mirror: wait for in-flight start/stop/restart
    ([pr#35437](https://github.com/ceph/ceph/pull/35437), Mykola Golub)
-   rgw: add \"rgw-orphan-list\" tool and \"radosgw-admin bucket
    radoslist \...\"
    ([pr#34991](https://github.com/ceph/ceph/pull/34991), J. Eric
    Ivancich)
-   rgw: amqp: fix the \"routable\" delivery mode
    ([pr#35433](https://github.com/ceph/ceph/pull/35433), Yuval
    Lifshitz)
-   rgw: anonomous swift to obj that dont exist should 401
    ([pr#35120](https://github.com/ceph/ceph/pull/35120), Matthew
    Oliver)
-   rgw: fix bug where bucket listing end marker not always set
    correctly ([pr#34993](https://github.com/ceph/ceph/pull/34993), J.
    Eric Ivancich)
-   rgw: fix rgw tries to fetch anonymous user
    ([pr#34988](https://github.com/ceph/ceph/pull/34988), Or Friedmann)
-   rgw: fix some list buckets handle leak
    ([pr#34985](https://github.com/ceph/ceph/pull/34985), Tianshan Qu)
-   rgw: gc: Clearing off urgent data in bufferlist, before
    ([pr#35434](https://github.com/ceph/ceph/pull/35434), Pritha
    Srivastava)
-   rgw: lc: enable thread-parallelism in RGWLC
    ([pr#35431](https://github.com/ceph/ceph/pull/35431), Matt Benjamin)
-   rgw: notifications: fix zero size in notifications
    ([pr#34940](https://github.com/ceph/ceph/pull/34940), J. Eric
    Ivancich, Yuval Lifshitz)
-   rgw: notifications: version id was not sent in versioned buckets
    ([pr#35254](https://github.com/ceph/ceph/pull/35254), Yuval
    Lifshitz)
-   rgw: radosgw-admin: fix infinite loops in \'datalog list\'
    ([pr#34989](https://github.com/ceph/ceph/pull/34989), Casey Bodley)
-   rgw: url: fix amqp urls with vhosts
    ([pr#35432](https://github.com/ceph/ceph/pull/35432), Yuval
    Lifshitz)
-   tests: migrate qa/ to Python3
    ([pr#35364](https://github.com/ceph/ceph/pull/35364), Kyr Shatskyy,
    Ilya Dryomov, Xiubo Li, Kefu Chai, Casey Bodley, Rishabh Dave,
    Patrick Donnelly, Sidharth Anupkrishnan, Michael Fritch)

## v15.2.3 Octopus

This is the third bug-fix release of the Ceph Octopus stable release
series. This release mainly is a workaround for a potential OSD
corruption in v15.2.2. We advise users to upgrade to v15.2.3 directly.
For users running v15.2.2 please execute the following:

    ceph config set osd bluefs_preextend_wal_files false

### Changelog

-   bluestore: remove preextended WAL support
    ([issue#45613](http://tracker.ceph.com/issues/45613), Igor Fedotov,
    Neha Ojha)

## v15.2.2 Octopus

This is the second bug-fix release of the Ceph Octopus stable release
series. This release brings a range of fixes across all components, as
well as patching a security flaw. We recommend that all Octopus users
upgrade.

### Notable Changes

-   CVE-2020-10736: Fixed an authorization bypass in mons & mgrs (Olle
    SegerDahl, Josh Durgin)

### Changelog

-   bluestore,core: common/options: Disable bluefs_buffered_io by
    default again ([pr#34353](https://github.com/ceph/ceph/pull/34353),
    Mark Nelson)
-   bluestore: os/bluestore: Don\'t pollute old journal when add new
    device ([pr#34795](https://github.com/ceph/ceph/pull/34795), Yang
    Honggang)
-   bluestore: os/bluestore: fix \'unused\' calculation
    ([pr#34793](https://github.com/ceph/ceph/pull/34793), Igor Fedotov,
    xie xingguo)
-   bluestore: os/bluestore: open DB in read-only when expanding DB/WAL
    ([pr#34610](https://github.com/ceph/ceph/pull/34610), Adam Kupczyk,
    Igor Fedotov)
-   build/ops: rpm: add python3-saml as install dependency
    ([pr#34474](https://github.com/ceph/ceph/pull/34474), Ernesto
    Puerta)
-   build/ops: rpm: drop \"is_opensuse\" conditional in SUSE-specific
    bcond block ([pr#34790](https://github.com/ceph/ceph/pull/34790),
    Nathan Cutler)
-   build/ops: spec: address some warnings raised by RPM 4.15.1
    ([pr#34526](https://github.com/ceph/ceph/pull/34526), Nathan Cutler)
-   ceph-volume/batch: check lvs list before access
    ([pr#34480](https://github.com/ceph/ceph/pull/34480), Jan Fajerski)
-   ceph-volume/batch: return success when all devices are filtered
    ([pr#34477](https://github.com/ceph/ceph/pull/34477), Jan Fajerski)
-   ceph-volume: update functional testing deploy.yml playbook
    ([pr#34886](https://github.com/ceph/ceph/pull/34886), Guillaume
    Abrioux)
-   cephadm: Fix check_ip_port to work with IPv6
    ([pr#34350](https://github.com/ceph/ceph/pull/34350), Ricardo
    Marques)
-   cephadm: Update images used
    ([pr#34686](https://github.com/ceph/ceph/pull/34686), Sebastian
    Wagner)
-   cephadm: ceph-volume: disallow concurrent execution
    ([pr#34423](https://github.com/ceph/ceph/pull/34423), Sage Weil)
-   cephadm: rm-cluster clean up /etc/ceph
    ([pr#34299](https://github.com/ceph/ceph/pull/34299),
    Daniel-Pivonka)
-   cephfs,mgr: mgr/volumes: Add interface to get subvolume metadata
    ([pr#34681](https://github.com/ceph/ceph/pull/34681), Kotresh HR)
-   cephfs,mgr: mgr: force purge normal ceph entities from service map
    ([issue#44677](http://tracker.ceph.com/issues/44677),
    [pr#34800](https://github.com/ceph/ceph/pull/34800), Venky Shankar)
-   cephfs,tools: cephfs-journal-tool: correctly parse \--dry_run
    argument ([pr#34804](https://github.com/ceph/ceph/pull/34804),
    Milind Changire)
-   cephfs,tools: tools/cephfs: add accounted_rstat/rstat when building
    file dentry ([pr#34803](https://github.com/ceph/ceph/pull/34803),
    Xiubo Li)
-   cephfs: ceph-fuse: link to libfuse3 and pass [-o
    big_writes]{.title-ref} to libfuse if libfuse \< 3.0.0
    ([pr#34769](https://github.com/ceph/ceph/pull/34769), Xiubo Li,
    \"Yan, Zheng\", Kefu Chai)
-   cephfs: client: reset requested_max_size if file write is not wanted
    ([pr#34766](https://github.com/ceph/ceph/pull/34766), \"Yan,
    Zheng\")
-   cephfs: mds: fix \'if there is lock cache on dir\' check
    ([pr#34273](https://github.com/ceph/ceph/pull/34273), \"Yan,
    Zheng\")
-   cephfs: mon/FSCommands: Fix \'add_data_pool\' command and \'fs new\'
    command ([pr#34775](https://github.com/ceph/ceph/pull/34775), Ramana
    Raja)
-   cephfs: qa: install task runs twice with double unwind causing fatal
    errors ([pr#34912](https://github.com/ceph/ceph/pull/34912), Patrick
    Donnelly)
-   core,mon: mon/OSDMonitor: allow trimming maps even if osds are down
    ([pr#34924](https://github.com/ceph/ceph/pull/34924), Joao Eduardo
    Luis)
-   core: ceph-object-corpus: update to octopus
    ([pr#34797](https://github.com/ceph/ceph/pull/34797), Josh Durgin)
-   core: mgr/DaemonServer: fetch metadata for new daemons (e.g., mons)
    ([pr#34416](https://github.com/ceph/ceph/pull/34416), Sage Weil)
-   core: mon/OSDMonitor: Always tune priority cache manager memory on
    all mons ([pr#34917](https://github.com/ceph/ceph/pull/34917),
    Sridhar Seshasayee)
-   core: mon: calculate min_size on osd pool set size
    ([pr#34528](https://github.com/ceph/ceph/pull/34528), Deepika
    Upadhyay)
-   core: osd/PeeringState: do not trim pg log past last_update_ondisk
    ([pr#34807](https://github.com/ceph/ceph/pull/34807), xie xingguo,
    Samuel Just)
-   core: osd/PrimaryLogPG: fix SPARSE_READ stat
    ([pr#34809](https://github.com/ceph/ceph/pull/34809), Yan Jun)
-   devices/simple/scan: Fix string in log statement
    ([pr#34446](https://github.com/ceph/ceph/pull/34446), Jan Fajerski)
-   doc: cephadm: Batch backport April (1)
    ([pr#34554](https://github.com/ceph/ceph/pull/34554), Matthew
    Oliver, Sage Weil, Sebastian Wagner, Michael Fritch, Tim, Jeff
    Layton, Juan Miguel Olmo Martínez, Joshua Schmid)
-   doc: cephadm: Batch backport April (2)
    ([issue#45029](http://tracker.ceph.com/issues/45029),
    [pr#34687](https://github.com/ceph/ceph/pull/34687), Maran Hidskes,
    Kiefer Chang, Matthew Oliver, Sebastian Wagner, Andreas Haase, Tim
    Serong, Zac Dover, Michael Fritch, Joshua Schmid)
-   doc: cephadm: Batch backport April (3)
    ([pr#34742](https://github.com/ceph/ceph/pull/34742), Sebastian
    Wagner, Dimitri Savineau, Michael Fritch)
-   doc: cephadm: batch backport March
    ([pr#34438](https://github.com/ceph/ceph/pull/34438), Jan Fajerski,
    Sebastian Wagner, Daniel-Pivonka, Michael Fritch, Sage Weil)
-   doc: doc/releases/nautilus: restart OSDs to make them bind to v2
    addr ([pr#34523](https://github.com/ceph/ceph/pull/34523), Nathan
    Cutler)
-   mgr/dashboard: \'Prometheus / All Alerts\' page shows progress bar
    ([pr#34631](https://github.com/ceph/ceph/pull/34631), Volker Theile)
-   mgr/dashboard: Fix ServiceDetails and PoolDetails unit tests
    ([pr#34760](https://github.com/ceph/ceph/pull/34760), Tiago Melo)
-   mgr/dashboard: Fix iSCSI\'s username and password validation
    ([pr#34547](https://github.com/ceph/ceph/pull/34547), Tiago Melo)
-   mgr/dashboard: Improve iSCSI CHAP message
    ([pr#34630](https://github.com/ceph/ceph/pull/34630), Ricardo
    Marques)
-   mgr/dashboard: Prevent iSCSI target recreation when editing controls
    ([pr#34548](https://github.com/ceph/ceph/pull/34548), Tiago Melo)
-   mgr/dashboard: RGW auto refresh is not working
    ([pr#34739](https://github.com/ceph/ceph/pull/34739), Avan Thakkar)
-   mgr/dashboard: Repair broken grafana panels
    ([pr#34495](https://github.com/ceph/ceph/pull/34495), Kristoffer
    Grönlund)
-   mgr/dashboard: Update translations on octopus
    ([pr#34309](https://github.com/ceph/ceph/pull/34309), Sebastian
    Krah)
-   mgr/dashboard: add crush rule test suite
    ([pr#34211](https://github.com/ceph/ceph/pull/34211), Tatjana
    Dehler)
-   mgr/dashboard: fix API tests to be py3 compatible
    ([pr#34759](https://github.com/ceph/ceph/pull/34759), Kefu Chai,
    Laura Paduano, Alfonso Martínez)
-   mgr/dashboard: fix errors related to frontend service subscriptions
    ([pr#34467](https://github.com/ceph/ceph/pull/34467), Alfonso
    Martínez)
-   mgr/dashboard: fix
    tasks.mgr.dashboard.test_rgw.RgwBucketTest.test_all
    ([pr#34708](https://github.com/ceph/ceph/pull/34708), Alfonso
    Martínez)
-   mgr/dashboard: lint error on plugins/debug.py
    ([pr#34625](https://github.com/ceph/ceph/pull/34625), Volker Theile)
-   mgr/dashboard: shorten \"Container ID\" and \"Container image ID\"
    in Services page
    ([pr#34648](https://github.com/ceph/ceph/pull/34648), Volker Theile)
-   mgr/dashboard: use FQDN for failover redirection
    ([pr#34498](https://github.com/ceph/ceph/pull/34498), Ernesto
    Puerta)
-   mgr: mgr/PyModule: fix missing tracebacks in handle_pyerror()
    ([pr#34626](https://github.com/ceph/ceph/pull/34626), Tim Serong)
-   mgr: mgr/telegraf: catch FileNotFoundError exception
    ([pr#34629](https://github.com/ceph/ceph/pull/34629), Kefu Chai)
-   monitoring: Fix pool capacity incorrect
    ([pr#34449](https://github.com/ceph/ceph/pull/34449), James Cheng)
-   monitoring: alert for prediction of disk and pool fill up broken
    ([pr#34395](https://github.com/ceph/ceph/pull/34395), Patrick
    Seidensal)
-   monitoring: fix decimal precision in Grafana %percentages
    ([pr#34828](https://github.com/ceph/ceph/pull/34828), Ernesto
    Puerta)
-   monitoring: root volume full alert fires false positives
    ([pr#34418](https://github.com/ceph/ceph/pull/34418), Patrick
    Seidensal)
-   pybind,rbd: pybind/rbd: ensure image is open before permitting
    operations ([pr#34425](https://github.com/ceph/ceph/pull/34425),
    Mykola Golub)
-   pybind,rbd: pybind/rbd: fix no lockers are obtained, ImageNotFound
    exception will be output
    ([pr#34387](https://github.com/ceph/ceph/pull/34387), zhangdaolong)
-   qa/suites/rados/cephadm/upgrade: start from v15.2.0
    ([pr#34440](https://github.com/ceph/ceph/pull/34440), Sage Weil)
-   qa/tasks/cephadm: add \'roleless\' mode
    ([pr#34407](https://github.com/ceph/ceph/pull/34407), Sage Weil)
-   rbd,tests: tests: update unmap.t for table spacing changes
    ([pr#34819](https://github.com/ceph/ceph/pull/34819), Ilya Dryomov)
-   rbd: rbd-mirror: improved replication statistics
    ([pr#34810](https://github.com/ceph/ceph/pull/34810), Mykola Golub,
    Jason Dillaman)
-   rbd: rbd: ignore tx-only mirror peers when adding new peers
    ([pr#34638](https://github.com/ceph/ceph/pull/34638), Jason
    Dillaman)
-   rgw: Disable prefetch of entire head object when GET request with
    range header ([pr#34826](https://github.com/ceph/ceph/pull/34826),
    Or Friedmann)
-   rgw: pubsub sync module ignores ERR_USER_EXIST
    ([pr#34825](https://github.com/ceph/ceph/pull/34825), Casey Bodley)
-   rgw: radosgw-admin: add support for \--bucket-id in bucket stats
    command ([pr#34816](https://github.com/ceph/ceph/pull/34816),
    Vikhyat Umrao)
-   rgw: reshard: skip stale bucket id entries from reshard queue
    ([pr#34734](https://github.com/ceph/ceph/pull/34734), Abhishek
    Lekshmanan)
-   rgw: use DEFER_DROP_PRIVILEGES flag unconditionally
    ([pr#34731](https://github.com/ceph/ceph/pull/34731), Casey Bodley)

## v15.2.1 Octopus

This is the first bugfix release of Ceph Octopus, we recommend all
Octopus users upgrade. This release fixes an upgrade issue and also has
2 security fixes

### Notable Changes

-   issue#44759: Fixed luminous-\>nautilus-\>octopus upgrade asserts
-   CVE-2020-1759: Fixed nonce reuse in msgr V2 secure mode
-   CVE-2020-1760: Fixed XSS due to RGW GetObject header-splitting

### Changelog

-   build/ops: fix ceph_release type to \'stable\'
    ([pr#34194](https://github.com/ceph/ceph/pull/34194), Sage Weil)
-   build/ops: vstart_runner.py: fix OSError when checking if
    non-existent path is mounted
    ([pr#34132](https://github.com/ceph/ceph/pull/34132), Alfonso
    Martínez)
-   cephadm: Add alertmanager adopt
    ([pr#34157](https://github.com/ceph/ceph/pull/34157), Eric Jackson)
-   cephadm: Add alertmanager sample
    ([pr#34158](https://github.com/ceph/ceph/pull/34158), Eric Jackson)
-   cephadm: Fix truncated output of \"ceph mgr dump\"
    ([pr#34258](https://github.com/ceph/ceph/pull/34258), Sebastian
    Wagner)
-   mgr/cephadm: Add example to run when debugging ssh failures
    ([pr#34153](https://github.com/ceph/ceph/pull/34153), Sebastian
    Wagner)
-   mgr/cephadm: DriveGroupSpec needs to support/ignore \_[unmanaged]()
    ([pr#34185](https://github.com/ceph/ceph/pull/34185), Joshua Schmid)
-   mgr/cephadm: bind grafana to all interfaces
    ([pr#34191](https://github.com/ceph/ceph/pull/34191), Sage Weil)
-   mgr/cephadm: fix \'orch ps \--refresh\'
    ([pr#34190](https://github.com/ceph/ceph/pull/34190), Sage Weil)
-   mgr/cephadm: fix \'upgrade start\' message when specifying a version
    ([pr#34186](https://github.com/ceph/ceph/pull/34186), Sage Weil)
-   mgr/cephadm: include alerts in prometheus deployment
    ([pr#34155](https://github.com/ceph/ceph/pull/34155), Sage Weil)
-   mgr/cephadm: point alertmanager at all mgr/dashboard URLs
    ([pr#34154](https://github.com/ceph/ceph/pull/34154), Sage Weil)
-   mgr/cephadm: provision nfs-ganesha via orchestrator
    ([pr#34192](https://github.com/ceph/ceph/pull/34192), Michael
    Fritch)
-   mgr/dashboard: Check for missing npm resolutions
    ([pr#34202](https://github.com/ceph/ceph/pull/34202), Tiago Melo)
-   mgr/dashboard: NoRebalance flag is added to the Dashboard
    ([pr#33939](https://github.com/ceph/ceph/pull/33939), Nizamudeen)
-   mgr/dashboard: correct Orchestrator documentation link
    ([pr#34212](https://github.com/ceph/ceph/pull/34212), Tatjana
    Dehler)
-   mgr/dashboard: do not fail on user creation (CLI)
    ([pr#34280](https://github.com/ceph/ceph/pull/34280), Tatjana
    Dehler)
-   mgr/orch: allow list daemons by service_name
    ([pr#34160](https://github.com/ceph/ceph/pull/34160), Kiefer Chang)
-   mgr/prometheus: ceph_pg\_\* metrics contains last value instead of
    sum across all reported states
    ([pr#34163](https://github.com/ceph/ceph/pull/34163), Jacek
    Suchenia)
-   mgr/rook: Blinking lights
    ([pr#34199](https://github.com/ceph/ceph/pull/34199), Juan Miguel
    Olmo Martínez)
-   osd/PeeringState: drop mimic assert
    ([pr#34204](https://github.com/ceph/ceph/pull/34204), Sage Weil)
-   osd/PeeringState: fix pending want_acting vs osd offline race
    ([pr#34123](https://github.com/ceph/ceph/pull/34123), xie xingguo)
-   pybind/mgr: fix config_notify handling of default values
    ([pr#34178](https://github.com/ceph/ceph/pull/34178), Nathan Cutler)
-   rbd: librbd: fix client backwards compatibility issues
    ([issue#39450](http://tracker.ceph.com/issues/39450),
    [issue#38834](http://tracker.ceph.com/issues/38834),
    [pr#34323](https://github.com/ceph/ceph/pull/34323), Jason Dillaman)
-   tools: ceph-backport.sh: add deprecation warning
    ([pr#34125](https://github.com/ceph/ceph/pull/34125), Nathan Cutler)

## v15.2.0 Octopus

This is the first stable release of Ceph Octopus.

### Major Changes from Nautilus

#### General

-   A new deployment tool called **cephadm** has been introduced that
    integrates Ceph daemon deployment and management via containers into
    the orchestration layer. For more information see
    `cephadm`{.interpreted-text role="ref"}.

-   Health alerts can now be muted, either temporarily or permanently.

-   Health alerts are now raised for recent Ceph daemons crashes.

-   A simple \'alerts\' module has been introduced to send email health
    alerts for clusters deployed without the benefit of an existing
    external monitoring infrastructure.

-   `Packages <packages>`{.interpreted-text role="ref"} are built for
    the following distributions:

    -   CentOS 8
    -   CentOS 7 (partial\--see below)
    -   Ubuntu 18.04 (Bionic)
    -   Debian Buster
    -   `Container image <containers>`{.interpreted-text role="ref"}
        (based on CentOS 8)

    Note that the dashboard, prometheus, and restful manager modules
    will not work on the CentOS 7 build due to Python 3 module
    dependencies that are missing in CentOS 7.

    Besides this packages built by the community will also available for
    the following distros:

    -   Fedora (33/rawhide)
    -   openSUSE (15.2, Tumbleweed)

#### Dashboard

The `mgr-dashboard`{.interpreted-text role="ref"} has gained a lot of
new features and functionality:

-   UI Enhancements
    -   New vertical navigation bar
    -   New unified sidebar: better background task and events
        notification
    -   Shows all progress mgr module notifications
    -   Multi-select on tables to perform bulk operations
-   Dashboard user account security enhancements
    -   Disabling/enabling existing user accounts
    -   Clone an existing user role
    -   Users can change their own password
    -   Configurable password policies: Minimum password
        complexity/length requirements
    -   Configurable password expiration
    -   Change password after first login

New and enhanced management of Ceph features/services:

-   OSD/device management
    -   List all disks associated with an OSD
    -   Add support for blinking enclosure LEDs via the orchestrator
    -   List all hosts known by the orchestrator
    -   List all disks and their properties attached to a node
    -   Display disk health information (health prediction and SMART
        data)
    -   Deploy new OSDs on new disks/hosts
    -   Display and allow sorting by an OSD\'s default device class in
        the OSD table
    -   Explicitly set/change the device class of an OSD, display and
        sort OSDs by device class
-   Pool management
    -   Viewing and setting pool quotas
    -   Define and change per-pool PG autoscaling mode
-   RGW management enhancements
    -   Enable bucket versioning
    -   Enable MFA support
    -   Select placement target on bucket creation
-   CephFS management enhancements
    -   CephFS client eviction
    -   CephFS snapshot management
    -   CephFS quota management
    -   Browse CephFS directory
-   iSCSI management enhancements
    -   Show iSCSI GW status on landing page
    -   Prevent deletion of IQNs with open sessions
    -   Display iSCSI \"logged in\" info
-   Prometheus alert management
    -   List configured Prometheus alerts

#### RADOS

-   Objects can now be brought in sync during recovery by copying only
    the modified portion of the object, reducing tail latencies during
    recovery.
-   Ceph will allow recovery below *min_size* for Erasure coded pools,
    wherever possible.
-   The PG autoscaler feature introduced in Nautilus is enabled for new
    pools by default, allowing new clusters to autotune *pg num* without
    any user intervention. The default values for new pools and
    RGW/CephFS metadata pools have also been adjusted to perform well
    for most users.
-   BlueStore has received several improvements and performance updates,
    including improved accounting for \"omap\" (key/value) object data
    by pool, improved cache memory management, and a reduced allocation
    unit size for SSD devices. (Note that by default, the first time
    each OSD starts after upgrading to octopus it will trigger a
    conversion that may take from a few minutes to a few hours,
    depending on the amount of stored \"omap\" data.)
-   Snapshot trimming metadata is now managed in a more efficient and
    scalable fashion.

#### RBD block storage

-   Mirroring now supports a new snapshot-based mode that no longer
    requires the journaling feature and its related impacts in exchange
    for the loss of point-in-time consistency (it remains crash
    consistent).
-   Clone operations now preserve the sparseness of the underlying RBD
    image.
-   The trash feature has been improved to (optionally) automatically
    move old parent images to the trash when their children are all
    deleted or flattened.
-   The trash can be configured to automatically purge on a defined
    schedule.
-   Images can be online re-sparsified to reduce the usage of zeroed
    extents.
-   The `rbd-nbd` tool has been improved to use more modern kernel
    interfaces.
-   Caching has been improved to be more efficient and performant.
-   `rbd-mirror` automatically adjusts its per-image memory usage based
    upon its memory target.
-   A new persistent read-only caching daemon is available to offload
    reads from shared parent images.

#### RGW object storage

-   New [Multisite Sync Policy](../../radosgw/multisite-sync-policy)
    primitives for per-bucket replication. (EXPERIMENTAL)
-   S3 feature support:
    -   Bucket Replication (EXPERIMENTAL)
    -   [Bucket Notifications](../../radosgw/notifications) via HTTP/S,
        AMQP and Kafka
    -   Bucket Tagging
    -   Object Lock
    -   Public Access Block for buckets
-   Bucket sharding:
    -   Significantly improved listing performance on buckets with many
        shards.
    -   Dynamic resharding prefers prime shard counts for improved
        distribution.
    -   Raised the default number of bucket shards to 11.
-   Added [HashiCorp Vault Integration](../../radosgw/vault) for
    SSE-KMS.
-   Added Keystone token cache for S3 requests.

#### CephFS distributed file system

-   Inline data support in CephFS has been deprecated and will likely be
    removed in a future release.
-   MDS daemons can now be assigned to manage a particular file system
    via the new `mds_join_fs` option.
-   MDS now aggressively asks idle clients to trim caps which improves
    stability when file system load changes.
-   The mgr volumes plugin has received numerous improvements to support
    CephFS via CSI, including snapshots and cloning.
-   cephfs-shell has had numerous incremental improvements and bug
    fixes.

### Upgrading from Mimic or Nautilus

:::: note
::: title
Note
:::

You can monitor the progress of your upgrade at each stage with the
`ceph versions` command, which will tell you what ceph version(s) are
running for each type of daemon.
::::

#### Instructions

1.  Make sure your cluster is stable and healthy (no down or recovering
    OSDs). (Optional, but recommended.)

2.  Set the `noout` flag for the duration of the upgrade. (Optional, but
    recommended.):

    ``` console
    # ceph osd set noout
    ```

3.  Upgrade monitors by installing the new packages and restarting the
    monitor daemons. For example, on each monitor host,:

    ``` console
    # systemctl restart ceph-mon.target
    ```

    Once all monitors are up, verify that the monitor upgrade is
    complete by looking for the `octopus` string in the mon map. The
    command:

    ``` console
    # ceph mon dump | grep min_mon_release
    ```

    should report:

    ``` console
    min_mon_release 15 (octopus)
    ```

    If it doesn\'t, that implies that one or more monitors hasn\'t been
    upgraded and restarted and/or the quorum does not include all
    monitors.

4.  Upgrade `ceph-mgr` daemons by installing the new packages and
    restarting all manager daemons. For example, on each manager host,:

    ``` console
    # systemctl restart ceph-mgr.target
    ```

    Verify the `ceph-mgr` daemons are running by checking `ceph -s`:

    ``` console
    # ceph -s

    ...
      services:
       mon: 3 daemons, quorum foo,bar,baz
       mgr: foo(active), standbys: bar, baz
    ...
    ```

5.  Upgrade all OSDs by installing the new packages and restarting the
    ceph-osd daemons on all OSD hosts:

    ``` console
    # systemctl restart ceph-osd.target
    ```

    Note that the first time each OSD starts, it will do a format
    conversion to improve the accounting for \"omap\" data. This may
    take a few minutes to as much as a few hours (for an HDD with lots
    of omap data). You can disable this automatic conversion with:

    ``` console
    # ceph config set osd bluestore_fsck_quick_fix_on_mount false
    ```

    You can monitor the progress of the OSD upgrades with the
    `ceph versions` or `ceph osd versions` commands:

    ``` console
    # ceph osd versions
    {
       "ceph version 13.2.5 (...) mimic (stable)": 12,
       "ceph version 15.2.0 (...) octopus (stable)": 22,
    }
    ```

6.  Upgrade all CephFS MDS daemons. For each CephFS file system,

    1.  Reduce the number of ranks to 1. (Make note of the original
        number of MDS daemons first if you plan to restore it later.):

    > \# ceph status \# ceph fs set \<fs_name\> max_mds 1

    1.  Wait for the cluster to deactivate any non-zero ranks by
        periodically checking the status:

    > \# ceph status

    1.  Take all standby MDS daemons offline on the appropriate hosts
        with:

    > \# systemctl stop ceph-mds@\<daemon_name\>

    1.  Confirm that only one MDS is online and is rank 0 for your FS:

    > \# ceph status

    1.  Upgrade the last remaining MDS daemon by installing the new
        packages and restarting the daemon:

        ``` console
        # systemctl restart ceph-mds.target
        ```

    2.  Restart all standby MDS daemons that were taken offline:

    > \# systemctl start ceph-mds.target

    1.  Restore the original value of `max_mds` for the volume:

    > \# ceph fs set \<fs_name\> max_mds \<original_max_mds\>

7.  Upgrade all radosgw daemons by upgrading packages and restarting
    daemons on all hosts:

    ``` console
    # systemctl restart ceph-radosgw.target
    ```

8.  Complete the upgrade by disallowing pre-Octopus OSDs and enabling
    all new Octopus-only functionality:

    ``` console
    # ceph osd require-osd-release octopus
    ```

9.  If you set `noout` at the beginning, be sure to clear it with:

    ``` console
    # ceph osd unset noout
    ```

10. Verify the cluster is healthy with `ceph health`.

    If your CRUSH tunables are older than Hammer, Ceph will now issue a
    health warning. If you see a health alert to that effect, you can
    revert this change with:

    ``` console
    ceph config set mon mon_crush_min_required_version firefly
    ```

    If Ceph does not complain, however, then we recommend you also
    switch any existing CRUSH buckets to straw2, which was added back in
    the Hammer release. If you have any \'straw\' buckets, this will
    result in a modest amount of data movement, but generally nothing
    too severe.:

    ``` console
    ceph osd getcrushmap -o backup-crushmap
    ceph osd crush set-all-straw-buckets-to-straw2
    ```

    If there are problems, you can easily revert with:

    ``` console
    ceph osd setcrushmap -i backup-crushmap
    ```

    Moving to \'straw2\' buckets will unlock a few recent features, like
    the [crush-compat]{.title-ref}
    `balancer <balancer>`{.interpreted-text role="ref"} mode added back
    in Luminous.

11. If you are upgrading from Mimic, or did not already do so when you
    upgraded to Nautlius, we recommended you enable the new `v2
    network protocol <msgr2>`{.interpreted-text role="ref"}, issue the
    following command:

    ``` console
    ceph mon enable-msgr2
    ```

    This will instruct all monitors that bind to the old default port
    6789 for the legacy v1 protocol to also bind to the new 3300 v2
    protocol port. To see if all monitors have been updated,:

    ``` console
    ceph mon dump
    ```

    and verify that each monitor has both a `v2:` and `v1:` address
    listed.

12. Consider enabling the
    `telemetry module <telemetry>`{.interpreted-text role="ref"} to send
    anonymized usage statistics and crash information to the Ceph
    upstream developers. To see what would be reported (without actually
    sending any information to anyone),:

    ``` console
    ceph mgr module enable telemetry
    ceph telemetry show
    ```

    If you are comfortable with the data that is reported, you can
    opt-in to automatically report the high-level cluster metadata with:

    ``` console
    ceph telemetry on
    ```

    For more information about the telemetry module, see `the
    documentation <telemetry>`{.interpreted-text role="ref"}.

### Upgrading from pre-Mimic releases (like Luminous)

You *must* first upgrade to Mimic (13.2.z) or Nautilus (14.2.z) before
upgrading to Octopus.

### Upgrade compatibility notes

-   Starting with Octopus, there is now a separate repository directory
    for each version on [download.ceph.com]{.title-ref} (e.g.,
    `rpm-15.2.0` and `debian-15.2.0`). The traditional package directory
    that is named after the release (e.g., `rpm-octopus` and
    `debian-octopus`) is now a symlink to the most recently bug fix
    version for that release. We no longer generate a single repository
    that combines all bug fix versions for a single named release.

-   The RGW \"num_rados_handles\" has been removed. If you were using a
    value of \"num_rados_handles\" greater than 1 multiply your current
    \"objecter_inflight_ops\" and \"objecter_inflight_op_bytes\"
    parameters by the old \"num_rados_handles\" to get the same throttle
    behavior.

-   Ceph now packages python bindings for python3.6 instead of
    python3.4, because python3 in EL7/EL8 is now using python3.6 as the
    native python3. see the
    [announcement](https://lists.fedoraproject.org/archives/list/epel-announce@lists.fedoraproject.org/message/EGUMKAIMPK2UD5VSHXM53BH2MBDGDWMO/)
    for more details on the background of this change.

-   librbd now uses a write-around cache policy be default, replacing
    the previous write-back cache policy default. This cache policy
    allows librbd to immediately complete write IOs while they are still
    in-flight to the OSDs. Subsequent flush requests will ensure all
    in-flight write IOs are completed prior to completing. The librbd
    cache policy can be controlled via a new \"rbd_cache_policy\"
    configuration option.

-   librbd now includes a simple IO scheduler which attempts to batch
    together multiple IOs against the same backing RBD data block
    object. The librbd IO scheduler policy can be controlled via a new
    \"rbd_io_scheduler\" configuration option.

-   RGW: radosgw-admin introduces two subcommands that allow the
    managing of expire-stale objects that might be left behind after a
    bucket reshard in earlier versions of RGW. One subcommand lists such
    objects and the other deletes them. Read the troubleshooting section
    of the dynamic resharding docs for details.

-   RGW: Bucket naming restrictions have changed and likely to cause
    InvalidBucketName errors. We recommend to set
    `rgw_relaxed_s3_bucket_names` option to true as a workaround.

-   In the Zabbix Mgr Module there was a typo in the key being send to
    Zabbix for PGs in backfill_wait state. The key that was sent was
    \'wait_backfill\' and the correct name is \'backfill_wait\'. Update
    your Zabbix template accordingly so that it accepts the new key
    being send to Zabbix.

-   zabbix plugin for ceph manager now includes osd and pool discovery.
    Update of zabbix_template.xml is needed to receive per-pool
    (read/write throughput, diskspace usage) and per-osd (latency,
    status, pgs) statistics

-   The format of all date + time stamps has been modified to fully
    conform to ISO 8601. The old format (`YYYY-MM-DD HH:MM:SS.ssssss`)
    excluded the `T` separator between the date and time and was
    rendered using the local time zone without any explicit indication.
    The new format includes the separator as well as a `+nnnn` or
    `-nnnn` suffix to indicate the time zone, or a `Z` suffix if the
    time is UTC. For example, `2019-04-26T18:40:06.225953+0100`.

    Any code or scripts that was previously parsing date and/or time
    values from the JSON or XML structure CLI output should be checked
    to ensure it can handle ISO 8601 conformant values. Any code parsing
    date or time values from the unstructured human-readable output
    should be modified to parse the structured output instead, as the
    human-readable output may change without notice.

-   The `bluestore_no_per_pool_stats_tolerance` config option has been
    replaced with `bluestore_fsck_error_on_no_per_pool_stats` (default:
    false). The overall default behavior has not changed: fsck will warn
    but not fail on legacy stores, and repair will convert to per-pool
    stats.

-   The disaster-recovery related \'ceph mon sync force\' command has
    been replaced with \'ceph daemon \<\...\> sync_force\'.

-   The `osd_recovery_max_active` option now has
    `osd_recovery_max_active_hdd` and `osd_recovery_max_active_ssd`
    variants, each with different default values for HDD and SSD-backed
    OSDs, respectively. By default `osd_recovery_max_active` now
    defaults to zero, which means that the OSD will conditionally use
    the HDD or SSD option values. Administrators who have customized
    this value may want to consider whether they have set this to a
    value similar to the new defaults (3 for HDDs and 10 for SSDs) and,
    if so, remove the option from their configuration entirely.

-   monitors now have a [ceph osd info]{.title-ref} command that will
    provide information on all osds, or provided osds, thus simplifying
    the process of having to parse [osd dump]{.title-ref} for the same
    information.

-   The structured output of `ceph status` or `ceph -s` is now more
    concise, particularly the [mgrmap]{.title-ref} and
    [monmap]{.title-ref} sections, and the structure of the
    [osdmap]{.title-ref} section has been cleaned up.

-   A health warning is now generated if the average osd heartbeat ping
    time exceeds a configurable threshold for any of the intervals
    computed. The OSD computes 1 minute, 5 minute and 15 minute
    intervals with average, minimum and maximum values. New
    configuration option `mon_warn_on_slow_ping_ratio` specifies a
    percentage of `osd_heartbeat_grace` to determine the threshold. A
    value of zero disables the warning. New configuration option
    `mon_warn_on_slow_ping_time` specified in milliseconds over-rides
    the computed value, causes a warning when OSD heartbeat pings take
    longer than the specified amount. New admin command
    `ceph daemon mgr.# dump_osd_network [threshold]` command will list
    all connections with a ping time longer than the specified threshold
    or value determined by the config options, for the average for any
    of the 3 intervals. New admin command
    `ceph daemon osd.# dump_osd_network [threshold]` will do the same
    but only including heartbeats initiated by the specified OSD.

-   Inline data support for CephFS has been deprecated. When setting the
    flag, users will see a warning to that effect, and enabling it now
    requires the `--yes-i-really-really-mean-it` flag. If the MDS is
    started on a filesystem that has it enabled, a health warning is
    generated. Support for this feature will be removed in a future
    release.

-   `ceph {set,unset} full` is not supported anymore. We have been using
    `full` and `nearfull` flags in OSD map for tracking the fullness
    status of a cluster back since the Hammer release, if the OSD map is
    marked `full` all write operations will be blocked until this flag
    is removed. In the Infernalis release and Linux kernel 4.7 client,
    we introduced the per-pool full/nearfull flags to track the status
    for a finer-grained control, so the clients will hold the write
    operations if either the cluster-wide `full` flag or the per-pool
    `full` flag is set. This was a compromise, as we needed to support
    the cluster with and without per-pool `full` flags support. But this
    practically defeated the purpose of introducing the per-pool flags.
    So, in the Mimic release, the new flags finally took the place of
    their cluster-wide counterparts, as the monitor started removing
    these two flags from OSD map. So the clients of Infernalis and up
    can benefit from this change, as they won\'t be blocked by the full
    pools which they are not writing to. In this release,
    `ceph {set,unset} full` is now considered as an invalid command. And
    the clients will continue honoring both the cluster-wide and
    per-pool flags to be backward compatible with pre-infernalis
    clusters.

-   The telemetry module now reports more information.

    First, there is a new \'device\' channel, enabled by default, that
    will report anonymized hard disk and SSD health metrics to
    telemetry.ceph.com in order to build and improve device failure
    prediction algorithms. If you are not comfortable sharing device
    metrics, you can disable that channel first before re-opting-in:

    ``` console
    ceph config set mgr mgr/telemetry/channel_device false
    ```

    Second, we now report more information about CephFS file systems,
    including:

    -   how many MDS daemons (in total and per file system)
    -   which features are (or have been) enabled
    -   how many data pools
    -   approximate file system age (year + month of creation)
    -   how many files, bytes, and snapshots
    -   how much metadata is being cached

    We have also added:

    -   which Ceph release the monitors are running
    -   whether msgr v1 or v2 addresses are used for the monitors
    -   whether IPv4 or IPv6 addresses are used for the monitors
    -   whether RADOS cache tiering is enabled (and which mode)
    -   whether pools are replicated or erasure coded, and which erasure
        code profile plugin and parameters are in use
    -   how many hosts are in the cluster, and how many hosts have each
        type of daemon
    -   whether a separate OSD cluster network is being used
    -   how many RBD pools and images are in the cluster, and how many
        pools have RBD mirroring enabled
    -   how many RGW daemons, zones, and zonegroups are present; which
        RGW frontends are in use
    -   aggregate stats about the CRUSH map, like which algorithms are
        used, how big buckets are, how many rules are defined, and what
        tunables are in use

    If you had telemetry enabled, you will need to re-opt-in with:

    ``` console
    ceph telemetry on
    ```

    You can view exactly what information will be reported first with:

    ``` console
    $ ceph telemetry show        # see everything
    $ ceph telemetry show basic  # basic cluster info (including all of the new info)
    ```

-   Following invalid settings now are not tolerated anymore for the
    command [ceph osd erasure-code-profile set xxx]{.title-ref}.

    -   invalid [m]{.title-ref} for \"reed_sol_r6_op\" erasure technique
    -   invalid [m]{.title-ref} and invalid [w]{.title-ref} for
        \"liber8tion\" erasure technique

-   New OSD daemon command dump_recovery_reservations which reveals the
    recovery locks held (in_progress) and waiting in priority queues.

-   New OSD daemon command dump_scrub_reservations which reveals the
    scrub reservations that are held for local (primary) and remote
    (replica) PGs.

-   Previously, `ceph tell mgr ...` could be used to call commands
    implemented by mgr modules. This is no longer supported. Since
    Luminous, using `tell` has not been necessary: those same commands
    are also accessible without the `tell mgr` portion (e.g.,
    `ceph tell mgr influx foo` is the same as `ceph influx foo`.
    `ceph tell mgr ...` will now call admin commands\--the same set of
    commands accessible via `ceph daemon ...` when you are logged into
    the appropriate host.

-   The `ceph tell` and `ceph daemon` commands have been unified, such
    that all such commands are accessible via either interface. Note
    that ceph-mgr tell commands are accessible via either
    `ceph tell mgr ...` or `ceph tell mgr.<id> ...`, and it is only
    possible to send tell commands to the active daemon (the standbys do
    not accept incoming connections over the network).

-   Ceph will now issue a health warning if a RADOS pool as a `pg_num`
    value that is not a power of two. This can be fixed by adjusting the
    pool to a nearby power of two:

    ``` console
    ceph osd pool set <pool-name> pg_num <new-pg-num>
    ```

    Alternatively, the warning can be silenced with:

    ``` console
    ceph config set global mon_warn_on_pool_pg_num_not_power_of_two false
    ```

-   The format of MDSs in `ceph fs dump` has changed.

-   The `mds_cache_size` config option is completely removed. Since
    Luminous, the `mds_cache_memory_limit` config option has been
    preferred to configure the MDS\'s cache limits.

-   The `pg_autoscale_mode` is now set to `on` by default for newly
    created pools, which means that Ceph will automatically manage the
    number of PGs. To change this behavior, or to learn more about PG
    autoscaling, see `pg-autoscaler`{.interpreted-text role="ref"}. Note
    that existing pools in upgraded clusters will still be set to `warn`
    by default.

-   The pool parameter `target_size_ratio`, used by the pg autoscaler,
    has changed meaning. It is now normalized across pools, rather than
    specifying an absolute ratio. For details, see
    `pg-autoscaler`{.interpreted-text role="ref"}. If you have set
    target size ratios on any pools, you may want to set these pools to
    autoscale `warn` mode to avoid data movement during the upgrade:

    ``` console
    ceph osd pool set <pool-name> pg_autoscale_mode warn
    ```

-   The `upmap_max_iterations` config option of mgr/balancer has been
    renamed to `upmap_max_optimizations` to better match its behaviour.

-   `mClockClientQueue` and `mClockClassQueue` OpQueue implementations
    have been removed in favor of of a single `mClockScheduler`
    implementation of a simpler OSD interface. Accordingly, the
    `osd_op_queue_mclock*` family of config options has been removed in
    favor of the `osd_mclock_scheduler*` family of options.

-   The config subsystem now searches dot (\'.\') delimited prefixes for
    options. That means for an entity like `client.foo.bar`, its overall
    configuration will be a combination of the global options, `client`,
    `client.foo`, and `client.foo.bar`. Previously, only global,
    `client`, and `client.foo.bar` options would apply. This change may
    affect the configuration for clients that include a `.` in their
    name.

-   MDS default cache memory limit is now 4GB.

-   The behaviour of the `-o` argument to the rados tool has been
    reverted to its original behaviour of indicating an output file.
    This reverts it to a more consistent behaviour when compared to
    other tools. Specifying object size is now accomplished by using an
    upper-case O `-O`.

-   In certain rare cases, OSDs would self-classify themselves as type
    \'nvme\' instead of \'hdd\' or \'ssd\'. This appears to be limited
    to cases where BlueStore was deployed with older versions of
    ceph-disk, or manually without ceph-volume and LVM. Going forward,
    the OSD will limit itself to only \'hdd\' and \'ssd\' (or whatever
    device class the user manually specifies).

-   RGW: a mismatch between the bucket notification documentation and
    the actual message format was fixed. This means that any endpoints
    receiving bucket notification, will now receive the same
    notifications inside an JSON array named \'Records\'. Note that this
    does not affect pulling bucket notification from a subscription in a
    \'pubsub\' zone, as these are already wrapped inside that array.

-   The configuration value `osd_calc_pg_upmaps_max_stddev` used for
    upmap balancing has been removed. Instead use the mgr balancer
    config `upmap_max_deviation` which now is an integer number of PGs
    of deviation from the target PGs per OSD. This can be set with a
    command like
    `ceph config set mgr mgr/balancer/upmap_max_deviation 2`. The
    default `upmap_max_deviation` is 1. There are situations where crush
    rules would not allow a pool to ever have completely balanced PGs.
    For example, if crush requires 1 replica on each of 3 racks, but
    there are fewer OSDs in one of the racks. In those cases, the
    configuration value can be increased.

-   MDS daemons can now be assigned to manage a particular file system
    via the new `mds_join_fs` option. The monitors will try to use only
    MDS for a file system with mds_join_fs equal to the file system name
    (strong affinity). Monitors may also deliberately failover an active
    MDS to a standby when the cluster is otherwise healthy if the
    standby has stronger affinity.

-   RGW Multisite: A new fine grained bucket-granularity policy
    configuration system has been introduced and it supersedes the
    previous coarse zone sync configuration (specifically the
    `sync_from` and `sync_from_all` fields in the zonegroup
    configuration. New configuration should only be configured after all
    relevant zones in the zonegroup have been upgraded.

-   RGW S3: Support has been added for BlockPublicAccess set of APIs at
    a bucket level, currently blocking/ignoring public acls & policies
    are supported. User/Account level APIs are planned to be added in
    the future

-   RGW: The default number of bucket index shards for new buckets was
    raised from 1 to 11 to increase the amount of write throughput for
    small buckets and delay the onset of dynamic resharding. This change
    only affects new deployments/zones. To change this default value on
    existing deployments, use
    `radosgw-admin zonegroup modify --bucket-index-max-shards=11`. If
    the zonegroup is part of a realm, the change must be committed with
    `radosgw-admin period update --commit` - otherwise the change will
    take effect after radosgws are restarted.

### Changelog

-   .gitignore: add more stuff
    ([pr#29568](https://github.com/ceph/ceph/pull/29568), Volker Theile)
-   async/dpdk: fix compile errors from ceph::mutex update
    ([pr#30066](https://github.com/ceph/ceph/pull/30066), yehu)
-   bluestore,build/ops,common,rgw: Enable \_GLIBCXX_ASSERTIONS and fix
    unittest problems
    ([pr#32387](https://github.com/ceph/ceph/pull/32387), Samuel Just)
-   bluestore,cephfs,common,core,mgr,mon,rbd,rgw: src/:
    s/Mutex/ceph::mutex/
    ([pr#29113](https://github.com/ceph/ceph/pull/29113), Kefu Chai)
-   bluestore,common,core,mgr,rbd: common/RefCountedObj: cleanup con/des
    ([pr#29672](https://github.com/ceph/ceph/pull/29672), Patrick
    Donnelly)
-   bluestore,common,core,rgw: common, \\\*: kill the bl::last_p member.
    Use iterator instead
    ([pr#32831](https://github.com/ceph/ceph/pull/32831), Radoslaw
    Zarzynski)
-   bluestore,common: os/bluestore: s/align_down/p2align/
    ([pr#29379](https://github.com/ceph/ceph/pull/29379), Kefu Chai)
-   bluestore,core: common/options: Set bluestore min_alloc size to 4K
    ([pr#30698](https://github.com/ceph/ceph/pull/30698), Mark Nelson)
-   bluestore,core: common/options: Set concurrent bluestore rocksdb
    compactions to 2
    ([pr#29027](https://github.com/ceph/ceph/pull/29027), Mark Nelson)
-   bluestore,core: mon,osd: only use new per-pool usage stats once
    \\\*all\\\* osds are reporting
    ([pr#28978](https://github.com/ceph/ceph/pull/28978), Sage Weil)
-   bluestore,core: os/bluestore,mon: segregate omap keys by pool;
    report via df ([pr#29292](https://github.com/ceph/ceph/pull/29292),
    Sage Weil)
-   bluestore,core: os/bluestore/BlueFS: explicit check for too-granular
    allocations ([pr#33027](https://github.com/ceph/ceph/pull/33027),
    Sage Weil)
-   bluestore,core: os/bluestore/bluefs_types: consolidate contiguous
    extents ([pr#28821](https://github.com/ceph/ceph/pull/28821), Sage
    Weil)
-   bluestore,core: os/bluestore/KernelDevice: fix RW_IO_MAX constant
    ([pr#29577](https://github.com/ceph/ceph/pull/29577), Sage Weil)
-   bluestore,core: os/bluestore: do not set osd_memory_target default
    from cgroup limit
    ([pr#29581](https://github.com/ceph/ceph/pull/29581), Sage Weil)
-   bluestore,core: os/bluestore: drop (semi-broken) nvme automatic
    class ([pr#31796](https://github.com/ceph/ceph/pull/31796), Sage
    Weil)
-   bluestore,core: os/bluestore: expand lttng tracepoints, improve
    fio_ceph_objectstore backend
    ([pr#29674](https://github.com/ceph/ceph/pull/29674), Samuel Just)
-   bluestore,core: os/bluestore: Keep separate onode cache pinned list
    ([pr#30964](https://github.com/ceph/ceph/pull/30964), Mark Nelson)
-   bluestore,core: os/bluestore: prefix omap of temp objects by real
    pool ([pr#29717](https://github.com/ceph/ceph/pull/29717), xie
    xingguo)
-   bluestore,core: os/bluestore: Unify on preadv for io_uring and
    future refactor
    ([pr#28025](https://github.com/ceph/ceph/pull/28025), Mark Nelson)
-   bluestore,core: os/bluestore: v.2 framework for more intelligent DB
    space usage ([pr#29687](https://github.com/ceph/ceph/pull/29687),
    Igor Fedotov)
-   bluestore,mgr,rgw: rgw,bluestore: fixes to address failures from
    check-generated.sh
    ([pr#29862](https://github.com/ceph/ceph/pull/29862), Kefu Chai)
-   bluestore,mon: os/bluestore: create the tail when first set
    FLAG_OMAP ([pr#27627](https://github.com/ceph/ceph/pull/27627), Tao
    Ning)
-   bluestore,tools: os/bluestore/bluestore-tool: minor fixes around
    migrate ([pr#28651](https://github.com/ceph/ceph/pull/28651), Igor
    Fedotov)
-   bluestore,tools: tools/ceph-objectstore-tool: implement onode
    metadata dump ([pr#27869](https://github.com/ceph/ceph/pull/27869),
    Igor Fedotov)
-   bluestore,tools: tools/ceph-objectstore-tool: introduce
    list-slow-omap command
    ([pr#27985](https://github.com/ceph/ceph/pull/27985), Igor Fedotov)
-   bluestore: BlueFS: prevent BlueFS::dirty_files from being leaked
    when syncing metadata
    ([pr#30631](https://github.com/ceph/ceph/pull/30631), Xuehan Xu)
-   bluestore: bluestore/allocator: Ageing test for bluestore allocators
    ([pr#22574](https://github.com/ceph/ceph/pull/22574), Adam Kupczyk)
-   bluestore: bluestore/bdev: initialize size when creating object
    ([pr#29968](https://github.com/ceph/ceph/pull/29968), Willem Jan
    Withagen)
-   bluestore: bluestore/bluefs: make accounting resiliant to unlock()
    ([pr#32584](https://github.com/ceph/ceph/pull/32584), Adam Kupczyk)
-   bluestore: common/options.cc: change default value of
    bluestore_fsck_on_mount_deep to false
    ([pr#29408](https://github.com/ceph/ceph/pull/29408), Neha Ojha)
-   bluestore: common/options: bluestore 64k min_alloc_size for HDD
    ([pr#32809](https://github.com/ceph/ceph/pull/32809), Sage Weil)
-   bluestore: NVMEDevice: Remove the unnecessary aio_wait in sync read
    ([pr#33597](https://github.com/ceph/ceph/pull/33597), Ziye Yang)
-   bluestore: NVMEDevice: Split the read I/O if the io size is large
    ([pr#32647](https://github.com/ceph/ceph/pull/32647), Ziye Yang)
-   bluestore: os/bluestore/Blue(FS\|Store): uint64_t alloc_size
    ([pr#32484](https://github.com/ceph/ceph/pull/32484), Bernd Zeimetz)
-   bluestore: os/bluestore/BlueFS: clear newly allocated space for WAL
    logs ([pr#30549](https://github.com/ceph/ceph/pull/30549), Adam
    Kupczyk)
-   bluestore: os/bluestore/BlueFS: fixed printing stats
    ([pr#33235](https://github.com/ceph/ceph/pull/33235), Adam Kupczyk)
-   bluestore: os/bluestore/BlueFS: less verbose about alloc adjustments
    ([pr#33512](https://github.com/ceph/ceph/pull/33512), Sage Weil)
-   bluestore: os/bluestore/BlueFS: Move bluefs alloc size
    initialization log message to log level 1
    ([pr#29822](https://github.com/ceph/ceph/pull/29822), Vikhyat Umrao)
-   bluestore: os/bluestore/BlueFS: replace flush_log with sync_metadata
    ([pr#32563](https://github.com/ceph/ceph/pull/32563), Jianpeng Ma)
-   bluestore: os/bluestore/BlueFS: use 64K alloc_size on the shared
    device ([pr#29537](https://github.com/ceph/ceph/pull/29537), Sage
    Weil, Neha Ojha)
-   bluestore: os/bluestore/BlueStore.cc: set priorities for compression
    stats ([pr#31959](https://github.com/ceph/ceph/pull/31959), Neha
    Ojha)
-   bluestore: os/bluestore/spdk: Fix the overflow error of parsing spdk
    coremask ([pr#32440](https://github.com/ceph/ceph/pull/32440), Hu
    Ye, Chunsong Feng, luo rixin)
-   bluestore: os/bluestore: Actually wait until completion in
    write_sync ([pr#26909](https://github.com/ceph/ceph/pull/26909),
    Vitaliy Filippov)
-   bluestore: os/bluestore: add bluestore_bluefs_max_free; smooth space
    balancing a bit
    ([pr#30231](https://github.com/ceph/ceph/pull/30231), xie xingguo)
-   bluestore: os/bluestore: add slow op detection for
    collection_listing
    ([issue#40741](http://tracker.ceph.com/issues/40741),
    [pr#29085](https://github.com/ceph/ceph/pull/29085), Igor Fedotov)
-   bluestore: os/bluestore: allocate Task on stack
    ([pr#33358](https://github.com/ceph/ceph/pull/33358), Jun Su)
-   bluestore: os/bluestore: apply garbage collection against excessive
    blob count growth
    ([pr#28229](https://github.com/ceph/ceph/pull/28229), Igor Fedotov)
-   bluestore: os/bluestore: AVL-tree & extent - based space allocator
    ([pr#30897](https://github.com/ceph/ceph/pull/30897), Adam Kupczyk,
    xie xingguo, Kefu Chai)
-   bluestore: os/bluestore: avoid length overflow in extents returned
    by Stupid ([issue#40703](http://tracker.ceph.com/issues/40703),
    [pr#28945](https://github.com/ceph/ceph/pull/28945), Igor Fedotov)
-   bluestore: os/bluestore: avoid race between split_cache and get/put
    pin/unpin ([pr#32665](https://github.com/ceph/ceph/pull/32665), Sage
    Weil)
-   bluestore: os/bluestore: avoid unnecessary notify
    ([pr#29345](https://github.com/ceph/ceph/pull/29345), Jianpeng Ma)
-   bluestore: os/bluestore: be more verbose doing bluefs log replay
    ([pr#27615](https://github.com/ceph/ceph/pull/27615), Igor Fedotov)
-   bluestore: os/bluestore: bluefs_preextend_wal_files=true
    ([pr#28322](https://github.com/ceph/ceph/pull/28322), Sage Weil)
-   bluestore: os/bluestore: call fault_range prior to looking for blob
    to reuse ([pr#27444](https://github.com/ceph/ceph/pull/27444), Igor
    Fedotov)
-   bluestore: os/bluestore: check bluefs allocations on log replay
    ([pr#31513](https://github.com/ceph/ceph/pull/31513), Igor Fedotov)
-   bluestore: os/bluestore: check return value of func
    \_open_db_and_around
    ([pr#27477](https://github.com/ceph/ceph/pull/27477), Jianpeng Ma)
-   bluestore: os/bluestore: cleanup around allocator calls
    ([pr#29068](https://github.com/ceph/ceph/pull/29068), Igor Fedotov)
-   bluestore: os/bluestore: cleanups
    ([pr#30737](https://github.com/ceph/ceph/pull/30737), Kefu Chai)
-   bluestore: os/bluestore: consolidate extents from the same device
    only ([pr#31621](https://github.com/ceph/ceph/pull/31621), Igor
    Fedotov)
-   bluestore: os/bluestore: correctly measure deferred writes into new
    blobs ([issue#38816](http://tracker.ceph.com/issues/38816),
    [pr#27789](https://github.com/ceph/ceph/pull/27789), Sage Weil)
-   bluestore: os/bluestore: deferred IO notify and locking optimization
    ([pr#29522](https://github.com/ceph/ceph/pull/29522), Jianpeng Ma)
-   bluestore: os/bluestore: do not check osd_max_object_size in
    \_open_path() ([pr#26176](https://github.com/ceph/ceph/pull/26176),
    Igor Fedotov)
-   bluestore: os/bluestore: do not mark per_pool_omap updated unless we
    fixed it ([pr#31167](https://github.com/ceph/ceph/pull/31167), Sage
    Weil)
-   bluestore: os/bluestore: dont round_up_to in apply_for_bitset_range
    ([pr#31903](https://github.com/ceph/ceph/pull/31903), Jianpeng Ma)
-   bluestore: os/bluestore: dump onode before no available blob id
    abort ([pr#27911](https://github.com/ceph/ceph/pull/27911), Igor
    Fedotov)
-   bluestore: os/bluestore: dump onode that has too many spanning blobs
    ([pr#28010](https://github.com/ceph/ceph/pull/28010), Igor Fedotov)
-   bluestore: os/bluestore: fix \>2GB writes
    ([pr#27871](https://github.com/ceph/ceph/pull/27871), Sage Weil,
    kungf)
-   bluestore: os/bluestore: fix bitmap allocator issues
    ([pr#26939](https://github.com/ceph/ceph/pull/26939), Igor Fedotov)
-   bluestore: os/bluestore: fix duplicate allocations in bmap allocator
    ([issue#40080](http://tracker.ceph.com/issues/40080),
    [pr#28496](https://github.com/ceph/ceph/pull/28496), Igor Fedotov)
-   bluestore: os/bluestore: fix duplicative and misleading debug in
    KernelDevice::open()
    ([pr#28630](https://github.com/ceph/ceph/pull/28630), Radoslaw
    Zarzynski)
-   bluestore: os/bluestore: fix for FreeBSD iocb structure
    ([pr#27458](https://github.com/ceph/ceph/pull/27458), Willem Jan
    Withagen)
-   bluestore: os/bluestore: fix invalid stray shared blob detection in
    fsck ([pr#30616](https://github.com/ceph/ceph/pull/30616), Igor
    Fedotov)
-   bluestore: os/bluestore: fix missing discard in
    BlueStore::\_kv_sync_thread
    ([pr#27843](https://github.com/ceph/ceph/pull/27843), Junhui Tang)
-   bluestore: os/bluestore: fix origin reference in logging slow ops
    ([pr#27951](https://github.com/ceph/ceph/pull/27951), Igor Fedotov)
-   bluestore: os/bluestore: fix out-of-bound access in bmap allocator
    ([pr#27691](https://github.com/ceph/ceph/pull/27691), Igor Fedotov)
-   bluestore: os/bluestore: fix per-pool omap repair
    ([pr#32925](https://github.com/ceph/ceph/pull/32925), Igor Fedotov)
-   bluestore: os/bluestore: fix space balancing overflow
    ([pr#30255](https://github.com/ceph/ceph/pull/30255), xie xingguo)
-   bluestore: os/bluestore: fix wakeup bug
    ([pr#31931](https://github.com/ceph/ceph/pull/31931), Jianpeng Ma)
-   bluestore: os/bluestore: introduce legacy statfs and dev size
    mismatch alerts
    ([pr#27519](https://github.com/ceph/ceph/pull/27519), Sage Weil,
    Igor Fedotov)
-   bluestore: os/bluestore: introduce new io_uring IO engine
    ([pr#27392](https://github.com/ceph/ceph/pull/27392), Roman Penyaev)
-   bluestore: os/bluestore: its better to erase spanning blob once
    ([pr#29238](https://github.com/ceph/ceph/pull/29238), Xiangyang Yu)
-   bluestore: os/bluestore: load OSD all compression settings
    unconditionally
    ([issue#40480](http://tracker.ceph.com/issues/40480),
    [pr#28688](https://github.com/ceph/ceph/pull/28688), Igor Fedotov)
-   bluestore: os/bluestore: log allocation stats on a daily basis
    ([pr#33565](https://github.com/ceph/ceph/pull/33565), Igor Fedotov)
-   bluestore: os/bluestore: memorize layout of BlueFS on management
    ([pr#30593](https://github.com/ceph/ceph/pull/30593), Radoslaw
    Zarzynski)
-   bluestore: os/bluestore: Merge deferred_finisher and finisher
    ([pr#29623](https://github.com/ceph/ceph/pull/29623), Jianpeng Ma)
-   bluestore: os/bluestore: minor improvements/cleanup around allocator
    ([pr#29738](https://github.com/ceph/ceph/pull/29738), Igor Fedotov)
-   bluestore: os/bluestore: more aggressive deferred submit when onode
    trim skipping ([issue#21531](http://tracker.ceph.com/issues/21531),
    [pr#25697](https://github.com/ceph/ceph/pull/25697), Zengran Zhang)
-   bluestore: os/bluestore: more smart allocator dump when lacking
    space for bluefs
    ([issue#40623](http://tracker.ceph.com/issues/40623),
    [pr#28845](https://github.com/ceph/ceph/pull/28845), Igor Fedotov)
-   bluestore: os/bluestore: new bluestore_debug_enforce_settings option
    ([pr#27132](https://github.com/ceph/ceph/pull/27132), Igor Fedotov)
-   bluestore: os/bluestore: no need protected by OpSequencer::qlock
    ([pr#29488](https://github.com/ceph/ceph/pull/29488), Jianpeng Ma)
-   bluestore: os/bluestore: no need to add tail length (revert
    PR#29185) ([pr#29465](https://github.com/ceph/ceph/pull/29465),
    Xiangyang Yu)
-   bluestore: os/bluestore: print correctly info
    ([pr#29939](https://github.com/ceph/ceph/pull/29939), Jianpeng Ma)
-   bluestore: os/bluestore: print error if spdk_nvme_ns_cmd_writev()
    fails ([pr#31932](https://github.com/ceph/ceph/pull/31932),
    NancySu05)
-   bluestore: os/bluestore: proper locking for BlueFS prefetching
    ([pr#29012](https://github.com/ceph/ceph/pull/29012), Igor Fedotov)
-   bluestore: os/bluestore: reduce wakeups
    ([pr#29130](https://github.com/ceph/ceph/pull/29130), Jianpeng Ma)
-   bluestore: os/bluestore: Refactor Bluestore Caches
    ([pr#28597](https://github.com/ceph/ceph/pull/28597), Mark Nelson)
-   bluestore: os/bluestore: remove unused arg to \_get_deferred_op()
    ([issue#40918](http://tracker.ceph.com/issues/40918),
    [pr#29320](https://github.com/ceph/ceph/pull/29320), Sage Weil)
-   bluestore: os/bluestore: remove unused \_tune_cache_size() method
    declaration ([pr#29393](https://github.com/ceph/ceph/pull/29393),
    Igor Fedotov)
-   bluestore: os/bluestore: restore and fix bug with onode cache
    pinning ([pr#31778](https://github.com/ceph/ceph/pull/31778), Josh
    Durgin)
-   bluestore: os/bluestore: revert cache pinned list
    ([pr#31180](https://github.com/ceph/ceph/pull/31180), Sage Weil)
-   bluestore: os/bluestore: set STATE_KV_SUBMITTED properly
    ([pr#30753](https://github.com/ceph/ceph/pull/30753), Igor Fedotov)
-   bluestore: os/bluestore: show device name in osd metadata output
    ([pr#28107](https://github.com/ceph/ceph/pull/28107), Igor Fedotov)
-   bluestore: os/bluestore: silence StupidAllocator reorder warning
    ([pr#29866](https://github.com/ceph/ceph/pull/29866), Jos Collin)
-   bluestore: os/bluestore: simplify multithreaded shallow fsck
    ([pr#31473](https://github.com/ceph/ceph/pull/31473), Igor Fedotov)
-   bluestore: os/bluestore: simplify per-pool-stat config options
    ([pr#30350](https://github.com/ceph/ceph/pull/30350), Sage Weil,
    Igor Fedotov)
-   bluestore: os/bluestore: support RocksDB prefetch in buffered read
    mode ([issue#36482](http://tracker.ceph.com/issues/36482),
    [pr#27782](https://github.com/ceph/ceph/pull/27782), Igor Fedotov)
-   bluestore: os/bluestore: tiny tracepoints improvement
    ([pr#31669](https://github.com/ceph/ceph/pull/31669), Adam Kupczyk)
-   bluestore: os/bluestore: upgrade legacy omap to per-pool format
    automatically ([pr#32758](https://github.com/ceph/ceph/pull/32758),
    Igor Fedotov)
-   bluestore: os/bluestore: verify disk layout of BlueFS
    ([issue#25098](http://tracker.ceph.com/issues/25098),
    [pr#30109](https://github.com/ceph/ceph/pull/30109), Radoslaw
    Zarzynski)
-   bluestore: os/bluestore:fix two calculation bugs
    ([pr#29185](https://github.com/ceph/ceph/pull/29185), Xiangyang Yu)
-   bluestore: os/ceph-bluestore-tool: bluefs-bdev-expand asserts if no
    WAL ([pr#27445](https://github.com/ceph/ceph/pull/27445), Igor
    Fedotov)
-   bluestore: os/objectstore: add new op OP_CREATE for create a new
    object ([pr#26251](https://github.com/ceph/ceph/pull/26251),
    Jianpeng Ma)
-   bluestore: Revert os/bluestore: add kv_drain_preceding_waiters
    indicate drain_preceding.
    ([pr#31503](https://github.com/ceph/ceph/pull/31503), Sage Weil)
-   bluestore: test/fio: handle nullptr when parsing throttle params
    ([pr#31681](https://github.com/ceph/ceph/pull/31681), Igor Fedotov)
-   bluestore: \[bluestore\]\[tools\] Inspect allocations in bluestore
    ([pr#29425](https://github.com/ceph/ceph/pull/29425), Adam Kupczyk)
-   build(deps): bump lodash from 4.17.11 to 4.17.13 in
    /src/pybind/mgr/dashboard/frontend
    ([pr#29192](https://github.com/ceph/ceph/pull/29192),
    dependabot\[bot\])
-   build/ops,cephfs,common,core,rbd: Fix big-endian handling
    ([pr#30079](https://github.com/ceph/ceph/pull/30079), Ulrich
    Weigand)
-   build/ops,cephfs: mgr/ssh: make mds add work
    ([pr#31059](https://github.com/ceph/ceph/pull/31059), Sage Weil)
-   build/ops,common,core: common, include: bump the version of
    ceph::buffers C++ API
    ([pr#33373](https://github.com/ceph/ceph/pull/33373), Radoslaw
    Zarzynski)
-   build/ops,common,mgr: python-common: Python common package
    ([pr#28915](https://github.com/ceph/ceph/pull/28915), Kefu Chai,
    Sebastian Wagner)
-   build/ops,common,rgw: rgw, common, build: drop NSS support
    ([pr#27834](https://github.com/ceph/ceph/pull/27834), Radoslaw
    Zarzynski)
-   build/ops,core,rbd: Windows support \[part 1\]
    ([pr#31981](https://github.com/ceph/ceph/pull/31981), Lucian Petrut,
    Alin Gabriel Serdean)
-   build/ops,core: ceph-crash: use client.crash\[.host\] to post, and
    provsion keys via mgr/ssh + ceph-daemon
    ([pr#30734](https://github.com/ceph/ceph/pull/30734), Sage Weil)
-   build/ops,core: debian: fix ceph-mgr-modules-core files
    ([pr#33468](https://github.com/ceph/ceph/pull/33468), Sage Weil)
-   build/ops,core: os/bluestore: fix pmem osd build problem
    ([pr#28761](https://github.com/ceph/ceph/pull/28761), Peterson,
    Scott, Li, Xiaoyan)
-   build/ops,core: qa: stop testing on 16.04 xenial
    ([pr#28943](https://github.com/ceph/ceph/pull/28943), Sage Weil)
-   build/ops,mgr: mgr/diskprediction_local: Replaced old models and
    updated predictor
    ([pr#29437](https://github.com/ceph/ceph/pull/29437), Karanraj
    Chauhan)
-   build/ops,mgr: systemd: ceph-mgr: set MemoryDenyWriteExecute to
    false ([issue#39628](http://tracker.ceph.com/issues/39628),
    [pr#28023](https://github.com/ceph/ceph/pull/28023), Ricardo Dias)
-   build/ops,pybind: cmake, pybind: fix build on armhf
    ([pr#28843](https://github.com/ceph/ceph/pull/28843), Kefu Chai)
-   build/ops,rbd: rpm,deb: fix python dateutil module dependency
    ([pr#33624](https://github.com/ceph/ceph/pull/33624), Mykola Golub)
-   build/ops,rgw: build/rgw: unittest_rgw_dmclock_scheduler does not
    need Boost_LIBRARIES
    ([pr#27466](https://github.com/ceph/ceph/pull/27466), Willem Jan
    Withagen)
-   build/ops,rgw: install-deps.sh, cmake: use boost 1.72 on bionic
    ([pr#32391](https://github.com/ceph/ceph/pull/32391), Kefu Chai)
-   build/ops,tests: ceph-daemon: a few fixes; functional test
    ([pr#31094](https://github.com/ceph/ceph/pull/31094), Sage Weil)
-   build/ops,tests: googletest: pick up change to suppress CMP0048
    warning ([pr#29471](https://github.com/ceph/ceph/pull/29471), Kefu
    Chai)
-   build/ops,tests: install-deps.sh,deb,rpm: move python-saml deps into
    debian/control anxe2x80xa6
    ([pr#29840](https://github.com/ceph/ceph/pull/29840), Kefu Chai)
-   build/ops,tools: src/script/credits.sh - switch to bash
    ([pr#32736](https://github.com/ceph/ceph/pull/32736), Kai Wagner)
-   build/ops,tools: vstart: Now all OSDs are starting in parallel. Use
    \--no-parallel to revert to sequential
    ([pr#31732](https://github.com/ceph/ceph/pull/31732), Adam Kupczyk)
-   build/ops: .github/stale.yml: warn at 60, close at 90; adjust
    message ([pr#24744](https://github.com/ceph/ceph/pull/24744), Lenz
    Grimmer, Sage Weil)
-   build/ops: admin/build-doc: keep-going when finding warnings
    ([pr#27050](https://github.com/ceph/ceph/pull/27050), Abhishek
    Lekshmanan)
-   build/ops: build-doc: allow building docs on fedora 30
    ([pr#30136](https://github.com/ceph/ceph/pull/30136), Yuval
    Lifshitz)
-   build/ops: build-integration-branch: s/prefix/postfix/
    ([pr#32303](https://github.com/ceph/ceph/pull/32303), Kefu Chai)
-   build/ops: build: add static analysis targets
    ([pr#31579](https://github.com/ceph/ceph/pull/31579), Yuval
    Lifshitz)
-   build/ops: build: FreeBSD does not have /etc/os-release
    ([pr#26731](https://github.com/ceph/ceph/pull/26731), Willem Jan
    Withagen)
-   build/ops: ceph-daemon: a couple fixes
    ([pr#31060](https://github.com/ceph/ceph/pull/31060), Sage Weil)
-   build/ops: ceph-daemon: add a logrotate.d file for each cluster
    ([pr#30882](https://github.com/ceph/ceph/pull/30882), Sage Weil)
-   build/ops: ceph-daemon: deploy ceph daemons with podman and systemd
    ([pr#30603](https://github.com/ceph/ceph/pull/30603), Sage Weil)
-   build/ops: ceph-daemon: fix logrotate su line
    ([pr#31823](https://github.com/ceph/ceph/pull/31823), Sage Weil)
-   build/ops: ceph-daemon: misc improvements
    ([pr#30826](https://github.com/ceph/ceph/pull/30826), Sage Weil)
-   build/ops: ceph-daemon: use /usr/bin/python, not /usr/bin/env python
    ([pr#31318](https://github.com/ceph/ceph/pull/31318), Sage Weil)
-   build/ops: ceph.spec.in: add missing python-yaml dependency for
    mgr-k8sevents ([pr#31178](https://github.com/ceph/ceph/pull/31178),
    Kefu Chai)
-   build/ops: ceph.spec.in: add runtime deps for
    mgr-diskprediction-cloud
    ([pr#32232](https://github.com/ceph/ceph/pull/32232), Kefu Chai)
-   build/ops: ceph.spec.in: always depends on python3.6-pyOpenSSL
    ([pr#32317](https://github.com/ceph/ceph/pull/32317), Kefu Chai)
-   build/ops: ceph.spec.in: Drop systemd BuildRequires in case of
    building for SUSE
    ([pr#28884](https://github.com/ceph/ceph/pull/28884), Dominique
    Leuenberger)
-   build/ops: ceph.spec.in: enable amqp_endpoint on RHEL8 by default
    ([pr#31143](https://github.com/ceph/ceph/pull/31143), Brad Hubbard)
-   build/ops: ceph.spec.in: fix Cython package dependency for Fedora
    ([pr#30590](https://github.com/ceph/ceph/pull/30590), Jeff Layton)
-   build/ops: ceph.spec.in: fix make check deps for centos8
    ([pr#32798](https://github.com/ceph/ceph/pull/32798), Alfonso
    Martxc3xadnez)
-   build/ops: ceph.spec.in: fix python coverage dependency for non-rhel
    distros ([pr#33361](https://github.com/ceph/ceph/pull/33361), Kiefer
    Chang)
-   build/ops: ceph.spec.in: fix python3 dependencies in centos7
    ([pr#32775](https://github.com/ceph/ceph/pull/32775), liushi)
-   build/ops: ceph.spec.in: grafana-dashboards package depends on
    grafana ([pr#28228](https://github.com/ceph/ceph/pull/28228), Jan
    Fajerski)
-   build/ops: ceph.spec.in: move distro-conditional deps to dedicated
    section ([pr#32080](https://github.com/ceph/ceph/pull/32080), Nathan
    Cutler)
-   build/ops: ceph.spec.in: package prometheus default alerts for SUSE
    ([pr#27996](https://github.com/ceph/ceph/pull/27996), Jan Fajerski)
-   build/ops: ceph.spec.in: pin to gcc-c++-8.2.1
    ([pr#28859](https://github.com/ceph/ceph/pull/28859), Kefu Chai)
-   build/ops: ceph.spec.in: re-enable make check deps for el8
    ([pr#32412](https://github.com/ceph/ceph/pull/32412), Kefu Chai)
-   build/ops: ceph.spec.in: reserve more memory per build jo
    ([pr#30126](https://github.com/ceph/ceph/pull/30126), Dan van der
    Ster)
-   build/ops: ceph.spec.in: s/pkgversion/version_nodots/
    ([pr#30036](https://github.com/ceph/ceph/pull/30036), Kefu Chai)
-   build/ops: ceph.spec.in: use g++ \>= 8.3.1-3.1
    ([pr#30088](https://github.com/ceph/ceph/pull/30088), Kefu Chai)
-   build/ops: ceph.spec.in: Use pkgconfig() style BuildRequires for
    udev/libudev-devel
    ([pr#32933](https://github.com/ceph/ceph/pull/32933), Dominique
    Leuenberger)
-   build/ops: ceph.spec.in: use python3 to bytecompile .py files
    ([pr#32608](https://github.com/ceph/ceph/pull/32608), Kefu Chai)
-   build/ops: ceph.spec: Recommend (but do not require) podman
    ([pr#33221](https://github.com/ceph/ceph/pull/33221), Sage Weil)
-   build/ops: ceph_release: octopus rc 15.1.0
    ([pr#32623](https://github.com/ceph/ceph/pull/32623), Sage Weil)
-   build/ops: cmake,crimson: pick up latest seastar
    ([pr#27088](https://github.com/ceph/ceph/pull/27088), Kefu Chai)
-   build/ops: cmake,run-make-check.sh: disable SPDK by default
    ([pr#29728](https://github.com/ceph/ceph/pull/29728), Kefu Chai)
-   build/ops: cmake/Boost: Fix python3 version
    ([pr#32344](https://github.com/ceph/ceph/pull/32344), Kotresh HR)
-   build/ops: cmake/FindRocksDB: fix IMPORTED_LOCATION for
    ROCKSDB_LIBRARIES
    ([pr#26813](https://github.com/ceph/ceph/pull/26813), dudengke)
-   build/ops: cmake/modules/GetGitRevisionDescription: update to work
    with git-worktree
    ([pr#30772](https://github.com/ceph/ceph/pull/30772), Sage Weil)
-   build/ops: cmake/modules: replace ; with in compile flags
    ([pr#28339](https://github.com/ceph/ceph/pull/28339), Kefu Chai)
-   build/ops: CMakeLists: add std::move warnings in gcc9
    ([pr#27569](https://github.com/ceph/ceph/pull/27569), Patrick
    Donnelly)
-   build/ops: crimson: clang related cleanups
    ([pr#33680](https://github.com/ceph/ceph/pull/33680), Kefu Chai)
-   build/ops: crimson: fix build seastar with dpdk
    ([pr#31426](https://github.com/ceph/ceph/pull/31426), Yingxin Cheng)
-   build/ops: deb,rpm,doc: s/plugin/module/
    ([pr#33435](https://github.com/ceph/ceph/pull/33435), Kefu Chai)
-   build/ops: debian/: use ceph-osd for packaging crimson-osd
    ([pr#28535](https://github.com/ceph/ceph/pull/28535), Kefu Chai)
-   build/ops: debian/control: add python-routes dependency for
    dashboard ([pr#28835](https://github.com/ceph/ceph/pull/28835), Paul
    Emmerich)
-   build/ops: debian/control: Build-Depends on g++
    ([pr#30410](https://github.com/ceph/ceph/pull/30410), Kefu Chai)
-   build/ops: debian/control: fix Build-Depends
    ([pr#29913](https://github.com/ceph/ceph/pull/29913), Kefu Chai)
-   build/ops: debian/radosgw.install: correct path to libradosgw.so\\\*
    ([pr#32539](https://github.com/ceph/ceph/pull/32539), Kefu Chai)
-   build/ops: debian/rules: run dh_python2 with ceph-daemon
    ([pr#31313](https://github.com/ceph/ceph/pull/31313), Kefu Chai)
-   build/ops: debian: modules-core replaces and breaks older ceph-mgr
    ([pr#33501](https://github.com/ceph/ceph/pull/33501), Kefu Chai)
-   build/ops: debian: remove dup ceph-fuse line
    ([pr#28788](https://github.com/ceph/ceph/pull/28788), huangjun)
-   build/ops: dmclock: pick up change to use specified C++ settings if
    any ([pr#30113](https://github.com/ceph/ceph/pull/30113), Kefu Chai)
-   build/ops: do_cmake.sh: Add a heading to the minimal config
    ([pr#28776](https://github.com/ceph/ceph/pull/28776), Brad Hubbard)
-   build/ops: do_cmake.sh: Add CEPH_GIT_DIR
    ([pr#30863](https://github.com/ceph/ceph/pull/30863), Matthew
    Oliver)
-   build/ops: do_cmake.sh: bail out if something goes wrong
    ([pr#33016](https://github.com/ceph/ceph/pull/33016), Kefu Chai)
-   build/ops: do_cmake.sh: enable amqp and rdma for EL8
    ([pr#30974](https://github.com/ceph/ceph/pull/30974), Kefu Chai)
-   build/ops: do_cmake.sh: optionally specify build dir with
    \$BUILD_DIR env var
    ([pr#29786](https://github.com/ceph/ceph/pull/29786), Yuval
    Lifshitz)
-   build/ops: do_cmake.sh: remove -DCMAKE_BUILD_TYPE=Debug from cmake
    options ([pr#30250](https://github.com/ceph/ceph/pull/30250), Kefu
    Chai)
-   build/ops: do_cmake.sh: use bash
    ([issue#39981](http://tracker.ceph.com/issues/39981),
    [pr#28181](https://github.com/ceph/ceph/pull/28181), Nathan Cutler)
-   build/ops: do_cmake: Warn user about slow debug performance only for
    not set ([pr#31113](https://github.com/ceph/ceph/pull/31113),
    Junyoung, Sung)
-   build/ops: do_freebsd.sh: update build scripts to resemble Jenkins
    scripts ([pr#29400](https://github.com/ceph/ceph/pull/29400), Willem
    Jan Withagen)
-   build/ops: dpdk: drop dpdk submodule
    ([issue#24032](http://tracker.ceph.com/issues/24032),
    [pr#33001](https://github.com/ceph/ceph/pull/33001), Kefu Chai)
-   build/ops: fix build fail related to PYTHON_EXECUTABLE variable
    ([pr#30199](https://github.com/ceph/ceph/pull/30199), Ilsoo Byun)
-   build/ops: github: display phrase for signed-off check
    ([pr#29890](https://github.com/ceph/ceph/pull/29890), Ernesto
    Puerta)
-   build/ops: install-dep,rpm: use devtools-8 on amd64
    ([issue#38892](http://tracker.ceph.com/issues/38892),
    [pr#27134](https://github.com/ceph/ceph/pull/27134), Kefu Chai)
-   build/ops: install-deps, rpm: use python_provide macro and cleanups
    ([pr#30830](https://github.com/ceph/ceph/pull/30830), Kefu Chai)
-   build/ops: install-deps,rpm,do_cmake: build on RHEL/CentOS 8
    ([pr#30630](https://github.com/ceph/ceph/pull/30630), Kefu Chai)
-   build/ops: install-deps.sh,src: drop python2 support
    ([pr#31525](https://github.com/ceph/ceph/pull/31525), Kefu Chai)
-   build/ops: install-deps.sh: Actually set gpgcheck to false
    ([pr#33591](https://github.com/ceph/ceph/pull/33591), Brad Hubbard)
-   build/ops: install-deps.sh: add EPEL repo for non-x86_64 archs as
    well ([pr#30557](https://github.com/ceph/ceph/pull/30557), Kefu
    Chai, Nathan Cutler)
-   build/ops: install-deps.sh: add kens copr repo for el8 build
    ([pr#32324](https://github.com/ceph/ceph/pull/32324), Kefu Chai)
-   build/ops: install-deps.sh: add option to skip prebuilt boost-\\\*
    pkgs installation
    ([pr#27776](https://github.com/ceph/ceph/pull/27776), Jun He)
-   build/ops: install-deps.sh: add support for Ubuntu Disco Dingo
    ([pr#30405](https://github.com/ceph/ceph/pull/30405), Patrick
    Seidensal)
-   build/ops: install-deps.sh: download wheel using pip wheel
    ([pr#29903](https://github.com/ceph/ceph/pull/29903), Kefu Chai)
-   build/ops: install-deps.sh: enable PowerTool repo for EL8
    ([pr#30656](https://github.com/ceph/ceph/pull/30656), Kefu Chai)
-   build/ops: install-deps.sh: fix typo for krb5 on FreeBSD
    ([pr#28269](https://github.com/ceph/ceph/pull/28269), Thomas
    Johnson)
-   build/ops: install-deps.sh: install binutils 2.28 for xenial
    ([pr#31601](https://github.com/ceph/ceph/pull/31601), Kefu Chai)
-   build/ops: install-deps.sh: install libboost-test for seastar
    ([pr#28015](https://github.com/ceph/ceph/pull/28015), Kefu Chai)
-   build/ops: install-deps.sh: install python2-{virtualenv,devel} on
    SUSE if needed ([pr#32153](https://github.com/ceph/ceph/pull/32153),
    Nathan Cutler)
-   build/ops: install-deps.sh: install \\\*rpm-macros
    ([issue#39164](http://tracker.ceph.com/issues/39164),
    [pr#27524](https://github.com/ceph/ceph/pull/27524), Kefu Chai)
-   build/ops: install-deps.sh: install [python\*-devel]{.title-ref} for
    python\\\*rpm-macros
    ([pr#30190](https://github.com/ceph/ceph/pull/30190), Kefu Chai)
-   build/ops: install-deps.sh: only prepare wheels for make check
    ([pr#29912](https://github.com/ceph/ceph/pull/29912), Kefu Chai)
-   build/ops: install-deps.sh: use chacra for cmake repo
    ([pr#29475](https://github.com/ceph/ceph/pull/29475), Kefu Chai)
-   build/ops: install-deps.sh: Use dnf for rhel/centos 8
    ([pr#31144](https://github.com/ceph/ceph/pull/31144), Brad Hubbard)
-   build/ops: install-deps.sh: use gcc-8 on xenial and trusty
    ([pr#28094](https://github.com/ceph/ceph/pull/28094), Kefu Chai)
-   build/ops: install-deps.sh: use GCC-9 on bionic
    ([pr#28454](https://github.com/ceph/ceph/pull/28454), Kefu Chai)
-   build/ops: install-deps.sh: use sepia/lab-extra/8
    ([pr#31238](https://github.com/ceph/ceph/pull/31238), Kefu Chai)
-   build/ops: install-deps: do not install if rpm already installed
    ([pr#30612](https://github.com/ceph/ceph/pull/30612), Kefu Chai)
-   build/ops: install-deps: enable homebrew repos for RHEL8
    ([pr#33905](https://github.com/ceph/ceph/pull/33905), Kefu Chai, Dan
    Mick)
-   build/ops: install-deps: revert 47d4351d
    ([pr#30122](https://github.com/ceph/ceph/pull/30122), Kefu Chai)
-   build/ops: make patch build dependency explicit
    ([issue#40175](http://tracker.ceph.com/issues/40175),
    [pr#28414](https://github.com/ceph/ceph/pull/28414), Nathan Cutler)
-   build/ops: make perf_async_msgr link jemalloc/tcmalloc
    ([pr#28039](https://github.com/ceph/ceph/pull/28039), Jianpeng Ma)
-   build/ops: make-dist: Bump Node.js to v10.18.1
    ([pr#33059](https://github.com/ceph/ceph/pull/33059), Tiago Melo)
-   build/ops: make-dist: default to no dashboard frontend build
    parallelism ([pr#32037](https://github.com/ceph/ceph/pull/32037),
    Nathan Cutler)
-   build/ops: make-dist: drop Python 2/3 autoselect
    ([pr#27792](https://github.com/ceph/ceph/pull/27792), Nathan Cutler)
-   build/ops: make-dist: set version number only once
    ([pr#26281](https://github.com/ceph/ceph/pull/26281), Nathan Cutler)
-   build/ops: mgr/dashboard: Prevent angular of getting stuck during
    installation ([pr#29929](https://github.com/ceph/ceph/pull/29929),
    Tiago Melo)
-   build/ops: mgr/rook: Make use of rook-client-python when talking to
    Rook ([pr#29427](https://github.com/ceph/ceph/pull/29427), Sebastian
    Wagner)
-   build/ops: pybind/mgr/CMakeLists: exclude tox.ini, requirements.txt
    from install ([pr#31577](https://github.com/ceph/ceph/pull/31577),
    Sage Weil)
-   build/ops: pybind/mgr: Exclude tests/
    ([pr#31671](https://github.com/ceph/ceph/pull/31671), Sebastian
    Wagner)
-   build/ops: pybind/mgr: Rename orchestrator_cli to orchestrator
    ([pr#32817](https://github.com/ceph/ceph/pull/32817), Sebastian
    Wagner)
-   build/ops: qa/tasks/ceph_deploy: do not rely on ceph-create-keys
    ([pr#29002](https://github.com/ceph/ceph/pull/29002), Sage Weil)
-   build/ops: Revert dpdk: drop dpdk submodule
    ([pr#32992](https://github.com/ceph/ceph/pull/32992), David
    Galloway)
-   build/ops: rpm,cmake: use specified python3 version if any
    ([pr#27358](https://github.com/ceph/ceph/pull/27358), Kefu Chai)
-   build/ops: rpm,deb: package always-enabled plugins in a separated
    package ([pr#33422](https://github.com/ceph/ceph/pull/33422), Kefu
    Chai)
-   build/ops: rpm,deb: python-requests is not needed for ceph-common
    ([pr#30420](https://github.com/ceph/ceph/pull/30420), luo.runbing)
-   build/ops: rpm,debian,install-deps: package crimson-osd
    ([pr#28428](https://github.com/ceph/ceph/pull/28428), Kefu Chai)
-   build/ops: rpm,etc/sysconfig: remove SuSEfirewall2 support
    ([issue#40738](http://tracker.ceph.com/issues/40738),
    [pr#28957](https://github.com/ceph/ceph/pull/28957), Matthias
    Gerstner)
-   build/ops: rpm/cephadm: move HOMEDIR to /var/lib and make scriptlets
    idempotent on SUSE
    ([pr#32212](https://github.com/ceph/ceph/pull/32212), Nathan Cutler)
-   build/ops: rpm: add cmake_verbose_logging switch
    ([pr#32805](https://github.com/ceph/ceph/pull/32805), Nathan Cutler)
-   build/ops: rpm: add Provides: python3-\\\* for python packages and
    cleanup ([pr#27468](https://github.com/ceph/ceph/pull/27468), Kefu
    Chai)
-   build/ops: rpm: add rpm-build to SUSE-specific make check deps
    ([pr#32083](https://github.com/ceph/ceph/pull/32083), Nathan Cutler)
-   build/ops: rpm: always build ceph-test package
    ([pr#29685](https://github.com/ceph/ceph/pull/29685), Nathan Cutler)
-   build/ops: rpm: define weak_deps for el8
    ([pr#33229](https://github.com/ceph/ceph/pull/33229), Kefu Chai)
-   build/ops: rpm: Disable LTO in spec when being used
    ([issue#39974](http://tracker.ceph.com/issues/39974),
    [pr#28170](https://github.com/ceph/ceph/pull/28170), Martin
    Lixc5xa1ka)
-   build/ops: rpm: drop vim-specific header
    ([pr#32331](https://github.com/ceph/ceph/pull/32331), Nathan Cutler)
-   build/ops: rpm: enable devtoolset-8 on aarch64 also
    ([issue#38892](http://tracker.ceph.com/issues/38892),
    [pr#27333](https://github.com/ceph/ceph/pull/27333), Kefu Chai)
-   build/ops: rpm: fdupes in SUSE builds to conform with packaging
    guidelines ([issue#40973](http://tracker.ceph.com/issues/40973),
    [pr#29346](https://github.com/ceph/ceph/pull/29346), Nathan Cutler)
-   build/ops: rpm: fix rhel \<= 7 conditional
    ([pr#27045](https://github.com/ceph/ceph/pull/27045), Nathan Cutler)
-   build/ops: rpm: fix up a specfile syntax error
    ([pr#33066](https://github.com/ceph/ceph/pull/33066), Greg Farnum)
-   build/ops: rpm: have pybind RPMs provide/obsolete their python2
    predecessors ([issue#40099](http://tracker.ceph.com/issues/40099),
    [pr#28352](https://github.com/ceph/ceph/pull/28352), Nathan Cutler)
-   build/ops: rpm: immutable-object-cache related changes
    ([pr#27150](https://github.com/ceph/ceph/pull/27150), Kefu Chai)
-   build/ops: rpm: improve ceph-mgr plugin package summaries
    ([issue#40974](http://tracker.ceph.com/issues/40974),
    [pr#29347](https://github.com/ceph/ceph/pull/29347), Nathan Cutler)
-   build/ops: rpm: make librados2, libcephfs2 own (create) /etc/ceph
    ([pr#30975](https://github.com/ceph/ceph/pull/30975), Nathan Cutler)
-   build/ops: rpm: put librgw lttng SOs in the librgw-devel package
    ([issue#40975](http://tracker.ceph.com/issues/40975),
    [pr#29349](https://github.com/ceph/ceph/pull/29349), Nathan Cutler)
-   build/ops: rpm: refrain from building ceph-resource-agents on SLE
    ([pr#27046](https://github.com/ceph/ceph/pull/27046), Nathan Cutler)
-   build/ops: rpm: Relax the selinux policy version for centos builds
    ([pr#32700](https://github.com/ceph/ceph/pull/32700), Boris Ranto)
-   build/ops: rpm: s/devtoolset-7/devtoolset-8/
    ([pr#27183](https://github.com/ceph/ceph/pull/27183), Kefu Chai)
-   build/ops: rpm: use python 3.6 as the default python3
    ([pr#27417](https://github.com/ceph/ceph/pull/27417), Kefu Chai)
-   build/ops: rpm: use python3.4 on RHEL7 by default
    ([pr#27407](https://github.com/ceph/ceph/pull/27407), Kefu Chai)
-   build/ops: rpm: use Recommends on fedora also
    ([pr#26819](https://github.com/ceph/ceph/pull/26819), Kefu Chai)
-   build/ops: run npm ci with a one-hour timeout
    ([pr#28994](https://github.com/ceph/ceph/pull/28994), Nathan Cutler)
-   build/ops: run-make-check.sh: extract run-make.sh
    ([pr#30184](https://github.com/ceph/ceph/pull/30184), Kefu Chai)
-   build/ops: run-make-check.sh: run sudo with absolute path
    ([pr#29753](https://github.com/ceph/ceph/pull/29753), Kefu Chai)
-   build/ops: run-make-check.sh: WITH_SEASTAR on demand
    ([pr#33723](https://github.com/ceph/ceph/pull/33723), Kefu Chai)
-   build/ops: script,doc: add gen-corpus.sh
    ([pr#28950](https://github.com/ceph/ceph/pull/28950), Kefu Chai)
-   build/ops: script/build-integration-branch: Add usage
    ([pr#32293](https://github.com/ceph/ceph/pull/32293), Sebastian
    Wagner)
-   build/ops: script/run-make.sh: do not pass cmake options twice
    ([pr#30318](https://github.com/ceph/ceph/pull/30318), Kefu Chai)
-   build/ops: script/run_tox.sh: Dont overwrite the build dir
    ([pr#29925](https://github.com/ceph/ceph/pull/29925), Sebastian
    Wagner)
-   build/ops: script: remove dep-report.sh
    ([pr#29296](https://github.com/ceph/ceph/pull/29296), Kefu Chai)
-   build/ops: scripts: ceph_dump_log.py
    ([pr#21729](https://github.com/ceph/ceph/pull/21729), Brad Hubbard)
-   build/ops: seastar: pickup change to add pthread linkage
    ([pr#33453](https://github.com/ceph/ceph/pull/33453), Kefu Chai)
-   build/ops: spec, debian: cephadm requires lvm2
    ([pr#32323](https://github.com/ceph/ceph/pull/32323), Sebastian
    Wagner)
-   build/ops: spec,debian: ceph-mgr-ssh depends on openssh{-client{s}}
    ([pr#31806](https://github.com/ceph/ceph/pull/31806), Sebastian
    Wagner)
-   build/ops: spec: add missing python3-pyyaml
    ([pr#33387](https://github.com/ceph/ceph/pull/33387), Sebastian
    Wagner)
-   build/ops: spec: Podman (temporarily) requires apparmor-abstractions
    on suse ([pr#33850](https://github.com/ceph/ceph/pull/33850),
    Sebastian Wagner)
-   build/ops: src/CMakeLists: remove leading v from git describe
    version ([pr#31387](https://github.com/ceph/ceph/pull/31387), Sage
    Weil)
-   build/ops: test/fio: bump to fio-3.15
    ([pr#31544](https://github.com/ceph/ceph/pull/31544), Igor Fedotov)
-   build/ops: test: only compile ceph_test_bmap_alloc_replay
    WITH_BLUESTORE ([pr#31306](https://github.com/ceph/ceph/pull/31306),
    Willem Jan Withagen)
-   build/ops: vstart: Remove duplicate option -N
    ([pr#31917](https://github.com/ceph/ceph/pull/31917), Kotresh HR)
-   ceph-crash: use ceph-crash as logger name
    ([pr#30989](https://github.com/ceph/ceph/pull/30989), Kefu Chai)
-   ceph-daemon -\> cephadm, mgr/ssh -\> mgr/cephadm
    ([pr#32193](https://github.com/ceph/ceph/pull/32193), Sage Weil)
-   ceph-daemon,mgr/ssh: add check-host
    ([pr#31795](https://github.com/ceph/ceph/pull/31795), Sage Weil)
-   ceph-daemon: -v\--debug
    ([pr#31583](https://github.com/ceph/ceph/pull/31583), Sage Weil)
-   ceph-daemon: a few more py2 compatibility hacks
    ([pr#31264](https://github.com/ceph/ceph/pull/31264), Sage Weil)
-   ceph-daemon: add additional debug logging
    ([pr#31837](https://github.com/ceph/ceph/pull/31837), Michael
    Fritch)
-   ceph-daemon: Add basic mypy support
    ([pr#31609](https://github.com/ceph/ceph/pull/31609), Thomas
    Bechtold)
-   ceph-daemon: add explicit pull at bootstrap start
    ([pr#31478](https://github.com/ceph/ceph/pull/31478), Sage Weil)
-   ceph-daemon: Add more type hints
    ([pr#31631](https://github.com/ceph/ceph/pull/31631), Thomas
    Bechtold)
-   ceph-daemon: add osd create test
    ([pr#31679](https://github.com/ceph/ceph/pull/31679), Michael
    Fritch)
-   ceph-daemon: add standalone [adopt]{.title-ref} tests
    ([pr#31486](https://github.com/ceph/ceph/pull/31486), Michael
    Fritch)
-   ceph-daemon: add [\--base-dir]{.title-ref} arg to
    [adopt]{.title-ref} command
    ([pr#31487](https://github.com/ceph/ceph/pull/31487), Michael
    Fritch)
-   ceph-daemon: add [\--legacy-dir]{.title-ref} arg to [ls]{.title-ref}
    command ([pr#31585](https://github.com/ceph/ceph/pull/31585),
    Michael Fritch)
-   ceph-daemon: Allow env var for setting the used image
    ([pr#31913](https://github.com/ceph/ceph/pull/31913), Thomas
    Bechtold)
-   ceph-daemon: append newline before public key string
    ([pr#31788](https://github.com/ceph/ceph/pull/31788), Ricardo Dias)
-   ceph-daemon: behave on rm-cluster when legacy dirs exist and ceph
    isnt installed ([pr#31499](https://github.com/ceph/ceph/pull/31499),
    Sage Weil)
-   ceph-daemon: bootstrap: make \--output-\\\* args optional
    ([pr#31695](https://github.com/ceph/ceph/pull/31695), Sage Weil)
-   ceph-daemon: ceph/daemon-base:latest-master-devel
    ([pr#31507](https://github.com/ceph/ceph/pull/31507), Sage Weil)
-   ceph-daemon: clean-up tempfiles on EXIT
    ([pr#32052](https://github.com/ceph/ceph/pull/32052), Michael
    Fritch)
-   ceph-daemon: combine SUDO and ARGS into a single var
    ([pr#32138](https://github.com/ceph/ceph/pull/32138), Michael
    Fritch)
-   ceph-daemon: configure firewalld for new daemons
    ([pr#31869](https://github.com/ceph/ceph/pull/31869), Sage Weil)
-   ceph-daemon: consolidate NamedTemporaryFile logic
    ([pr#31908](https://github.com/ceph/ceph/pull/31908), Michael
    Fritch)
-   ceph-daemon: create \~/.ssh if not exist
    ([pr#31315](https://github.com/ceph/ceph/pull/31315), Kefu Chai)
-   ceph-daemon: customize the bash prompt for shell + enter
    ([pr#31498](https://github.com/ceph/ceph/pull/31498), Sage Weil)
-   ceph-daemon: do not pass -it unless it is an interactive shell
    ([pr#31181](https://github.com/ceph/ceph/pull/31181), Sage Weil)
-   ceph-daemon: do not relabel system directories
    ([pr#31321](https://github.com/ceph/ceph/pull/31321), Sage Weil)
-   ceph-daemon: dont deref symlinks during chown
    ([pr#32137](https://github.com/ceph/ceph/pull/32137), Michael
    Fritch)
-   ceph-daemon: enable dashboard during bootstrap
    ([pr#31464](https://github.com/ceph/ceph/pull/31464), Sage Weil)
-   ceph-daemon: fix bootstrap ownership of tmp monmap file
    ([pr#32097](https://github.com/ceph/ceph/pull/32097), Sage Weil)
-   ceph-daemon: fix extract_uid_gid
    ([pr#31832](https://github.com/ceph/ceph/pull/31832), Sage Weil)
-   ceph-daemon: fix firewalld error case
    ([pr#32096](https://github.com/ceph/ceph/pull/32096), Sage Weil)
-   ceph-daemon: Fix handling for symlinks on python2
    ([pr#31838](https://github.com/ceph/ceph/pull/31838), Michael
    Fritch)
-   ceph-daemon: fix os.mkdir call
    ([pr#31320](https://github.com/ceph/ceph/pull/31320), Sage Weil)
-   ceph-daemon: fix pod stop
    ([pr#32157](https://github.com/ceph/ceph/pull/32157), Sage Weil)
-   ceph-daemon: fix prompt
    ([pr#31603](https://github.com/ceph/ceph/pull/31603), Sage Weil)
-   ceph-daemon: fix standalone [adopt]{.title-ref} OSD test
    ([pr#31772](https://github.com/ceph/ceph/pull/31772), Sage Weil,
    Michael Fritch)
-   ceph-daemon: fix traceback during [ls]{.title-ref} command
    ([pr#31439](https://github.com/ceph/ceph/pull/31439), Michael
    Fritch)
-   ceph-daemon: fix version field for legacy [ls]{.title-ref}
    ([pr#31443](https://github.com/ceph/ceph/pull/31443), Michael
    Fritch)
-   ceph-daemon: fix [systemctl is-enabled]{.title-ref} bool
    ([pr#31870](https://github.com/ceph/ceph/pull/31870), Michael
    Fritch)
-   ceph-daemon: infer fsid for some commands
    ([pr#31702](https://github.com/ceph/ceph/pull/31702), Michael
    Fritch)
-   ceph-daemon: logs command
    ([pr#31575](https://github.com/ceph/ceph/pull/31575), Sage Weil)
-   ceph-daemon: make /var/run/ceph behavior better
    ([pr#31141](https://github.com/ceph/ceph/pull/31141), Sage Weil)
-   ceph-daemon: make infer_fsid behave when /var/lib/ceph dne
    ([pr#31831](https://github.com/ceph/ceph/pull/31831), Sage Weil)
-   ceph-daemon: make ls log less noisy
    ([pr#31448](https://github.com/ceph/ceph/pull/31448), Sage Weil)
-   ceph-daemon: make mon container privileged
    ([pr#31476](https://github.com/ceph/ceph/pull/31476), Sage Weil)
-   ceph-daemon: make ps1 a raw string
    ([pr#31540](https://github.com/ceph/ceph/pull/31540), Michael
    Fritch)
-   ceph-daemon: make rm-cluster faster
    ([pr#31538](https://github.com/ceph/ceph/pull/31538), Sage Weil)
-   ceph-daemon: make rm-cluster handle failed unit cleanup
    ([pr#31365](https://github.com/ceph/ceph/pull/31365), Sage Weil)
-   ceph-daemon: Move ceph-daemon executable to own directory
    ([pr#31467](https://github.com/ceph/ceph/pull/31467), Thomas
    Bechtold)
-   ceph-daemon: nicer errors
    ([pr#31886](https://github.com/ceph/ceph/pull/31886), Sage Weil,
    Michael Fritch)
-   ceph-daemon: Only run in the \_\_main\_\_ scope
    ([pr#31458](https://github.com/ceph/ceph/pull/31458), Thomas
    Bechtold)
-   ceph-daemon: only set up /var/run/ceph/\$fsid if it exists
    ([pr#31341](https://github.com/ceph/ceph/pull/31341), Sage Weil)
-   ceph-daemon: only set up crash dir mount if it exists
    ([pr#31130](https://github.com/ceph/ceph/pull/31130), Sage Weil)
-   ceph-daemon: py2 compatibility
    ([pr#31168](https://github.com/ceph/ceph/pull/31168), Sage Weil)
-   ceph-daemon: py2: tolerate whitespace before config key name
    ([pr#32098](https://github.com/ceph/ceph/pull/32098), Sage Weil)
-   ceph-daemon: raise RuntimeError when CephContainer.run() fails
    ([pr#31328](https://github.com/ceph/ceph/pull/31328), Michael
    Fritch)
-   ceph-daemon: Remove data dir during adopt
    ([pr#31437](https://github.com/ceph/ceph/pull/31437), Michael
    Fritch)
-   ceph-daemon: remove prepare-host
    ([pr#32108](https://github.com/ceph/ceph/pull/32108), Sage Weil)
-   ceph-daemon: replace podman variables by container
    ([pr#31618](https://github.com/ceph/ceph/pull/31618), Dimitri
    Savineau)
-   ceph-daemon: seek relative to the start of file
    ([pr#31892](https://github.com/ceph/ceph/pull/31892), Michael
    Fritch)
-   ceph-daemon: set container_image during bootstrap
    ([pr#31445](https://github.com/ceph/ceph/pull/31445), Sage Weil)
-   ceph-daemon: set ssh public identity
    ([pr#31500](https://github.com/ceph/ceph/pull/31500), Sage Weil)
-   ceph-daemon: several fsid inference fixes
    ([pr#31798](https://github.com/ceph/ceph/pull/31798), Sage Weil)
-   ceph-daemon: switch default image
    ([pr#31463](https://github.com/ceph/ceph/pull/31463), Sage Weil)
-   ceph-daemon: unmount osd data dir during [adopt]{.title-ref}
    ([pr#31477](https://github.com/ceph/ceph/pull/31477), Michael
    Fritch)
-   ceph-daemon: use client.admin keyring during bootstrap
    ([pr#31270](https://github.com/ceph/ceph/pull/31270), Sage Weil)
-   ceph-daemon: use [-e]{.title-ref} instead of [\--env]{.title-ref}
    ([pr#31614](https://github.com/ceph/ceph/pull/31614), Michael
    Fritch)
-   ceph-daemon: Use [shutil.move]{.title-ref} to move log files
    ([pr#31331](https://github.com/ceph/ceph/pull/31331), Michael
    Fritch)
-   ceph-daemon: [imp]{.title-ref} module DeprecationWarning
    ([pr#32161](https://github.com/ceph/ceph/pull/32161), Michael
    Fritch)
-   ceph-mon: keep v1 address type when explicitly set
    ([pr#31765](https://github.com/ceph/ceph/pull/31765), Ricardo Dias)
-   ceph-object-corpus: forward_incompat pg_missing_item and
    pg_missing_t ([pr#28034](https://github.com/ceph/ceph/pull/28034),
    lishuhao)
-   ceph-volume simple: better detection when type file is not present
    ([pr#29386](https://github.com/ceph/ceph/pull/29386), Alfredo Deza)
-   ceph-volume zap always skips block.db, leaves them around
    ([issue#40664](http://tracker.ceph.com/issues/40664),
    [pr#28998](https://github.com/ceph/ceph/pull/28998), Alfredo Deza)
-   ceph-volume broken assertion errors after pytest changes
    ([issue#40665](http://tracker.ceph.com/issues/40665),
    [pr#28866](https://github.com/ceph/ceph/pull/28866), Alfredo Deza)
-   ceph-volume lvm.zap fix cleanup for db partitions
    ([issue#40664](http://tracker.ceph.com/issues/40664),
    [pr#28267](https://github.com/ceph/ceph/pull/28267), Dominik Csapak)
-   ceph-volume tests add a sleep in tox for slow OSDs after booting
    ([issue#40619](http://tracker.ceph.com/issues/40619),
    [pr#28836](https://github.com/ceph/ceph/pull/28836), Alfredo Deza)
-   ceph-volume tests remove xenial from functional testing
    ([pr#31159](https://github.com/ceph/ceph/pull/31159), Alfredo Deza)
-   ceph-volume tests set the noninteractive flag for Debian
    ([pr#29804](https://github.com/ceph/ceph/pull/29804), Alfredo Deza)
-   ceph-volume-zfs: add the inventory command
    ([pr#30995](https://github.com/ceph/ceph/pull/30995), Willem Jan
    Withagen)
-   ceph-volume/batch: fail on filtered devices when non-interactive
    ([pr#31978](https://github.com/ceph/ceph/pull/31978), Jan Fajerski)
-   ceph-volume/lvm/activate.py: clarify error message: fsid refers to
    osd_fsid ([pr#32351](https://github.com/ceph/ceph/pull/32351), Yaniv
    Kaul)
-   ceph-volume/test: patch VolumeGroups
    ([pr#31979](https://github.com/ceph/ceph/pull/31979), Jan Fajerski)
-   ceph-volume: add Cephs device id to inventory
    ([pr#31072](https://github.com/ceph/ceph/pull/31072), Sebastian
    Wagner)
-   ceph-volume: add db and wal support to raw mode
    ([pr#32828](https://github.com/ceph/ceph/pull/32828), Sxc3xa9bastien
    Han)
-   ceph-volume: add methods to pass filters to pvs, vgs and lvs
    commands ([pr#32242](https://github.com/ceph/ceph/pull/32242),
    Rishabh Dave)
-   ceph-volume: add proper size attribute to partitions
    ([pr#31492](https://github.com/ceph/ceph/pull/31492), Jan Fajerski)
-   ceph-volume: add raw (\--bluestore) mode
    ([pr#32095](https://github.com/ceph/ceph/pull/32095), Sage Weil)
-   ceph-volume: add sizing arguments to prepare
    ([pr#32235](https://github.com/ceph/ceph/pull/32235), Jan Fajerski)
-   ceph-volume: add utility functions
    ([pr#27282](https://github.com/ceph/ceph/pull/27282), Mohamad Gebai)
-   ceph-volume: allow raw block devices everywhere
    ([pr#31410](https://github.com/ceph/ceph/pull/31410), Jan Fajerski)
-   ceph-volume: allow to skip restorecon calls
    ([pr#31421](https://github.com/ceph/ceph/pull/31421), Alfredo Deza)
-   ceph-volume: api/lvm: check if list of LVs is empty
    ([pr#30101](https://github.com/ceph/ceph/pull/30101), Rishabh Dave)
-   ceph-volume: assume msgrV1 for all branches containing mimic
    ([pr#31592](https://github.com/ceph/ceph/pull/31592), Jan Fajerski)
-   ceph-volume: avoid calling zap_lv with a LV-less VG
    ([pr#33283](https://github.com/ceph/ceph/pull/33283), Jan Fajerski)
-   ceph-volume: batch bluestore fix create_lvs call
    ([pr#32929](https://github.com/ceph/ceph/pull/32929), Jan Fajerski)
-   ceph-volume: batch ensure device lists are disjoint
    ([pr#27754](https://github.com/ceph/ceph/pull/27754), Jan Fajerski)
-   ceph-volume: check if we run in an selinux environment
    ([pr#31809](https://github.com/ceph/ceph/pull/31809), Jan Fajerski)
-   ceph-volume: check if we run in an selinux environment, now also in
    py2 ([pr#31814](https://github.com/ceph/ceph/pull/31814), Jan
    Fajerski)
-   ceph-volume: Dereference symlink in lvm list
    ([pr#32525](https://github.com/ceph/ceph/pull/32525), Benoxc3xaet
    Knecht)
-   ceph-volume: detect ceph-disk osd if PARTLABEL is missing
    ([issue#40917](http://tracker.ceph.com/issues/40917),
    [pr#29401](https://github.com/ceph/ceph/pull/29401), Jan Fajerski)
-   ceph-volume: do not fail when trying to remove crypt mapper
    ([pr#30490](https://github.com/ceph/ceph/pull/30490), Guillaume
    Abrioux)
-   ceph-volume: dont keep device lists as sets
    ([pr#29683](https://github.com/ceph/ceph/pull/29683), Jan Fajerski)
-   ceph-volume: dont remove vg twice when zapping filestore
    ([pr#33332](https://github.com/ceph/ceph/pull/33332), Jan Fajerski)
-   ceph-volume: dont try to test lvm zap on simple tests
    ([pr#29659](https://github.com/ceph/ceph/pull/29659), Jan Fajerski)
-   ceph-volume: finer grained availability notion in inventory
    ([pr#32634](https://github.com/ceph/ceph/pull/32634), Jan Fajerski)
-   ceph-volume: fix batch functional tests, idempotent test must check
    sxe2x80xa6 ([pr#29684](https://github.com/ceph/ceph/pull/29684), Jan
    Fajerski)
-   ceph-volume: fix device unittest, mock has_bluestore_label
    ([pr#32655](https://github.com/ceph/ceph/pull/32655), Jan Fajerski)
-   ceph-volume: fix has_bluestore_label() function
    ([pr#33074](https://github.com/ceph/ceph/pull/33074), Guillaume
    Abrioux)
-   ceph-volume: fix is_ceph_device for lvm batch
    ([pr#33223](https://github.com/ceph/ceph/pull/33223), Jan Fajerski,
    Dimitri Savineau)
-   ceph-volume: fix lvm list
    ([pr#33077](https://github.com/ceph/ceph/pull/33077), Guillaume
    Abrioux)
-   ceph-volume: fix regression and improve output in lvm list
    ([pr#33112](https://github.com/ceph/ceph/pull/33112), Jan Fajerski)
-   ceph-volume: fix stderr failure to decode/encode when redirected
    ([pr#30274](https://github.com/ceph/ceph/pull/30274), Alfredo Deza)
-   ceph-volume: fix the integer overflow
    ([pr#32106](https://github.com/ceph/ceph/pull/32106), dongdong tao)
-   ceph-volume: fix warnings raised by pytest
    ([pr#30422](https://github.com/ceph/ceph/pull/30422), Rishabh Dave)
-   ceph-volume: import mock.mock instead of unittest.mock (py2)
    ([pr#31816](https://github.com/ceph/ceph/pull/31816), Jan Fajerski)
-   ceph-volume: look for rotational data in lsblk
    ([pr#26957](https://github.com/ceph/ceph/pull/26957), Andrew Schoen)
-   ceph-volume: lvm: get_device_vgs() filter by provided prefix
    ([pr#33478](https://github.com/ceph/ceph/pull/33478), Jan Fajerski,
    Yehuda Sadeh)
-   ceph-volume: make get_devices fs location independent
    ([pr#31574](https://github.com/ceph/ceph/pull/31574), Jan Fajerski)
-   ceph-volume: minor clean-up of [simple scan]{.title-ref} subcommand
    help ([pr#31821](https://github.com/ceph/ceph/pull/31821), Michael
    Fritch)
-   ceph-volume: minor optimizations related to class Volumess use
    ([pr#29665](https://github.com/ceph/ceph/pull/29665), Rishabh Dave)
-   ceph-volume: mokeypatch calls to lvm related binaries
    ([pr#31197](https://github.com/ceph/ceph/pull/31197), Jan Fajerski)
-   ceph-volume: never log to stdout, use stderr instead
    ([pr#29547](https://github.com/ceph/ceph/pull/29547), Jan Fajerski)
-   ceph-volume: pass \--ssh-config to pytest to resolve hosts when
    connecting ([issue#40063](http://tracker.ceph.com/issues/40063),
    [pr#28294](https://github.com/ceph/ceph/pull/28294), Alfredo Deza)
-   ceph-volume: pass journal_size as Size not string
    ([pr#33320](https://github.com/ceph/ceph/pull/33320), Jan Fajerski)
-   ceph-volume: pre-install python-apt and its variants before test
    runs ([pr#30115](https://github.com/ceph/ceph/pull/30115), Alfredo
    Deza)
-   ceph-volume: print most logging messages to stderr
    ([issue#38548](http://tracker.ceph.com/issues/38548),
    [pr#27675](https://github.com/ceph/ceph/pull/27675), Jan Fajerski)
-   ceph-volume: PVolumes.filter shouldnt purge itself
    ([pr#30703](https://github.com/ceph/ceph/pull/30703), Rishabh Dave)
-   ceph-volume: rearrange api/lvm.py
    ([pr#30867](https://github.com/ceph/ceph/pull/30867), Rishabh Dave)
-   ceph-volume: refactor listing.py
    ([pr#31700](https://github.com/ceph/ceph/pull/31700), Rishabh Dave)
-   ceph-volume: reject disks smaller then 5GB in inventory
    ([issue#40776](http://tracker.ceph.com/issues/40776),
    [pr#29041](https://github.com/ceph/ceph/pull/29041), Jan Fajerski)
-   ceph-volume: revert \--no-tmpfs change
    ([pr#30788](https://github.com/ceph/ceph/pull/30788), Sage Weil)
-   ceph-volume: silence ceph-bluestore-tool failures
    ([pr#33371](https://github.com/ceph/ceph/pull/33371), Sxc3xa9bastien
    Han)
-   ceph-volume: skip osd creation when already done
    ([pr#33086](https://github.com/ceph/ceph/pull/33086), Guillaume
    Abrioux)
-   ceph-volume: strip \_dmcrypt suffix in simple scan json output
    ([pr#33079](https://github.com/ceph/ceph/pull/33079), Jan Fajerski)
-   ceph-volume: systemd fix typo in log message
    ([pr#30497](https://github.com/ceph/ceph/pull/30497), Manu
    Zurmxc3xbchl)
-   ceph-volume: terminal: encode unicode when writing to stdout
    ([pr#27148](https://github.com/ceph/ceph/pull/27148), Alfredo Deza,
    Kefu Chai)
-   ceph-volume: use centos8 for functional testing
    ([pr#33174](https://github.com/ceph/ceph/pull/33174), Jan Fajerski)
-   ceph-volume: use correct extents if using db-devices and \>1
    osds_per_device
    ([pr#32177](https://github.com/ceph/ceph/pull/32177), Fabian
    Niepelt)
-   ceph-volume: use fsync for dd command
    ([pr#31479](https://github.com/ceph/ceph/pull/31479), Rishabh Dave)
-   ceph-volume: use get_device_vgs in has_common_vg
    ([pr#33246](https://github.com/ceph/ceph/pull/33246), Jan Fajerski)
-   ceph-volume: use python3 compatible print
    ([pr#30790](https://github.com/ceph/ceph/pull/30790), Kyr Shatskyy)
-   ceph-volume: use the Device.rotational property instead of sys_api
    ([pr#28060](https://github.com/ceph/ceph/pull/28060), Andrew Schoen)
-   ceph-volume: use the OSD identifier when reporting success
    ([pr#29762](https://github.com/ceph/ceph/pull/29762), Alfredo Deza)
-   ceph-volume: util: look for executable in \$PATH
    ([pr#31787](https://github.com/ceph/ceph/pull/31787), Shyukri
    Shyukriev)
-   ceph-volume: util: Use proper param substition
    ([pr#28448](https://github.com/ceph/ceph/pull/28448), Shyukri
    Shyukriev)
-   ceph-volume: VolumeGroups.filter shouldnt purge itself
    ([pr#30707](https://github.com/ceph/ceph/pull/30707), Rishabh Dave)
-   ceph-volume: when testing disable the dashboard
    ([pr#29387](https://github.com/ceph/ceph/pull/29387), Andrew Schoen)
-   ceph.in: disable ASAN if libasan is not found
    ([pr#28247](https://github.com/ceph/ceph/pull/28247), Kefu Chai)
-   ceph.in: do not preload asan even if not needed
    ([pr#28703](https://github.com/ceph/ceph/pull/28703), Kefu Chai)
-   ceph.in: do not preload libasan if it is found
    ([pr#28275](https://github.com/ceph/ceph/pull/28275), Kefu Chai)
-   ceph.in: print decoded output in interactive mode
    ([pr#33099](https://github.com/ceph/ceph/pull/33099), Jun Su)
-   cephadm: \--cap-add=SYS_PTRACE
    ([pr#33442](https://github.com/ceph/ceph/pull/33442), Sage Weil)
-   cephadm: Add ability to deploy grafana container
    ([pr#32491](https://github.com/ceph/ceph/pull/32491), Paul Cuzner)
-   cephadm: add ability to specify a timeout
    ([pr#32049](https://github.com/ceph/ceph/pull/32049), Michael
    Fritch)
-   cephadm: add alertmanager deployment feature
    ([pr#32949](https://github.com/ceph/ceph/pull/32949), Sage Weil,
    Paul Cuzner)
-   cephadm: add assert foo is not None for mypy check
    ([pr#33876](https://github.com/ceph/ceph/pull/33876), Kefu Chai)
-   cephadm: add grafana adopt
    ([pr#33746](https://github.com/ceph/ceph/pull/33746), Eric Jackson)
-   cephadm: add locking
    ([pr#32334](https://github.com/ceph/ceph/pull/32334), Sage Weil)
-   cephadm: add nfs-ganesha deployment
    ([pr#33064](https://github.com/ceph/ceph/pull/33064), Michael
    Fritch)
-   cephadm: add prepare-host
    ([pr#33374](https://github.com/ceph/ceph/pull/33374), Sage Weil)
-   cephadm: add prometheus adopt
    ([pr#33438](https://github.com/ceph/ceph/pull/33438), Eric Jackson)
-   cephadm: add reconfig service action
    ([pr#32281](https://github.com/ceph/ceph/pull/32281), Sage Weil)
-   cephadm: add start/stop hooks and c-v activate on container start
    ([pr#32158](https://github.com/ceph/ceph/pull/32158), Sage Weil)
-   cephadm: Add Zypper packager (openSUSE/SLES)
    ([pr#33461](https://github.com/ceph/ceph/pull/33461), Kristoffer
    Grxc3xb6nlund)
-   cephadm: add [\--retry]{.title-ref} arg
    ([pr#33342](https://github.com/ceph/ceph/pull/33342), Michael
    Fritch)
-   cephadm: add {add,rm}-repo commands
    ([pr#33062](https://github.com/ceph/ceph/pull/33062), Sage Weil)
-   cephadm: add-repo: add \--version
    ([pr#33961](https://github.com/ceph/ceph/pull/33961), Sage Weil)
-   cephadm: adopt fixes
    ([pr#32995](https://github.com/ceph/ceph/pull/32995), Sage Weil)
-   cephadm: allow multiple get_parm() calls
    ([pr#33437](https://github.com/ceph/ceph/pull/33437), Sage Weil)
-   cephadm: allow skipping prepare_host in bootstrap step
    ([pr#33504](https://github.com/ceph/ceph/pull/33504), Kiefer Chang)
-   cephadm: allow users to provide their dashboard cert during
    bootstrap ([pr#33472](https://github.com/ceph/ceph/pull/33472),
    Daniel-Pivonka)
-   cephadm: also return JSON decode error
    ([pr#33433](https://github.com/ceph/ceph/pull/33433), Sebastian
    Wagner)
-   cephadm: bootstrap: avoid repeat chars in generated password
    ([pr#32332](https://github.com/ceph/ceph/pull/32332), Sage Weil)
-   cephadm: bootstrap: deploy monitoring stack by default
    ([pr#33936](https://github.com/ceph/ceph/pull/33936), Sage Weil)
-   cephadm: bootstrap: nag about telemetry
    ([pr#33517](https://github.com/ceph/ceph/pull/33517), Sage Weil)
-   cephadm: bootstrap: wait for mgr to restart after enabling a module
    ([pr#33857](https://github.com/ceph/ceph/pull/33857), Sage Weil)
-   cephadm: bootstrap: warn on fqdn hostname
    ([pr#33042](https://github.com/ceph/ceph/pull/33042), Sage Weil)
-   cephadm: check for both chrony service names
    ([pr#33369](https://github.com/ceph/ceph/pull/33369), Sage Weil)
-   cephadm: check for both ntp.service and ntpd.service
    ([pr#32302](https://github.com/ceph/ceph/pull/32302), Sage Weil)
-   cephadm: clean up the systemd unit and ceph-crash shutdown behavior
    ([pr#32685](https://github.com/ceph/ceph/pull/32685), Sage Weil)
-   cephadm: correct ipv6 support in port open detection
    ([pr#32286](https://github.com/ceph/ceph/pull/32286), Paul Cuzner)
-   cephadm: create /var/run/ceph/\$fsid as needed
    ([pr#32390](https://github.com/ceph/ceph/pull/32390), Sage Weil)
-   cephadm: disable node-exporter cpu/memory limits for the time being
    ([pr#33133](https://github.com/ceph/ceph/pull/33133), Sage Weil)
-   cephadm: drop sha256: prefix on container id
    ([pr#32300](https://github.com/ceph/ceph/pull/32300), Sage Weil)
-   cephadm: error out on filestore OSDs
    ([pr#33395](https://github.com/ceph/ceph/pull/33395), Sage Weil)
-   cephadm: fix adoption safety check
    ([pr#33445](https://github.com/ceph/ceph/pull/33445), Sage Weil)
-   cephadm: fix ceph version probe
    ([pr#33136](https://github.com/ceph/ceph/pull/33136), Sage Weil)
-   cephadm: fix container cleanup
    ([pr#32282](https://github.com/ceph/ceph/pull/32282), Sage Weil)
-   cephadm: fix datetime regexp to capture at most 6 digits
    ([pr#33932](https://github.com/ceph/ceph/pull/33932), Michael
    Fritch)
-   cephadm: fix deploy crash when no [args.fsid]{.title-ref}
    ([pr#33248](https://github.com/ceph/ceph/pull/33248), Michael
    Fritch)
-   cephadm: fix error handing in [command_check_host()]{.title-ref}
    ([pr#33048](https://github.com/ceph/ceph/pull/33048), Guillaume
    Abrioux)
-   cephadm: fix failure when getting keyring for deploying daemons
    ([pr#33679](https://github.com/ceph/ceph/pull/33679), Kiefer Chang)
-   cephadm: fix help message for bootstrap \--mgr-id
    ([pr#32640](https://github.com/ceph/ceph/pull/32640), Sage Weil)
-   cephadm: fix inspect-image
    ([pr#33109](https://github.com/ceph/ceph/pull/33109), Sage Weil)
-   cephadm: fix logging defaults
    ([pr#32641](https://github.com/ceph/ceph/pull/32641), Sage Weil)
-   cephadm: fix name argument parsing during image check for non-ceph
    components ([pr#33114](https://github.com/ceph/ceph/pull/33114),
    Daniel-Pivonka)
-   cephadm: Fix Py3 ConfigParser deprecation warnings
    ([pr#32218](https://github.com/ceph/ceph/pull/32218), Michael
    Fritch)
-   cephadm: fix tox DeprecationWarning
    ([pr#32753](https://github.com/ceph/ceph/pull/32753), Michael
    Fritch)
-   cephadm: fix v1/v2 ip/addrv handling; explicitly check bind to
    ip:port ([pr#32392](https://github.com/ceph/ceph/pull/32392), Sage
    Weil)
-   cephadm: fix [alertmanager not implemented yet]{.title-ref}
    ([pr#33694](https://github.com/ceph/ceph/pull/33694), Patrick
    Seidensal)
-   cephadm: flag dashboard user to change password
    ([pr#32990](https://github.com/ceph/ceph/pull/32990),
    Daniel-Pivonka)
-   cephadm: further simplify mon setup
    ([pr#33952](https://github.com/ceph/ceph/pull/33952), Sage Weil)
-   cephadm: implement install command
    ([pr#33979](https://github.com/ceph/ceph/pull/33979), Sage Weil)
-   cephadm: improve handling of crash agent container
    ([pr#33189](https://github.com/ceph/ceph/pull/33189), Sage Weil)
-   cephadm: include daemon/unit id in unit name
    ([pr#32970](https://github.com/ceph/ceph/pull/32970), Sage Weil)
-   cephadm: Infer ceph image
    ([pr#33829](https://github.com/ceph/ceph/pull/33829), Sage Weil,
    Ricardo Marques)
-   cephadm: infer the fsid by name
    ([pr#32795](https://github.com/ceph/ceph/pull/32795), Michael
    Fritch)
-   cephadm: KillMode=none in unit file
    ([pr#33162](https://github.com/ceph/ceph/pull/33162), Sage Weil)
-   cephadm: leave backup when removing stateful daemons
    ([pr#33973](https://github.com/ceph/ceph/pull/33973), Sage Weil)
-   cephadm: make add-repo \--release and \--version independent
    ([pr#34034](https://github.com/ceph/ceph/pull/34034), Sage Weil)
-   cephadm: merge [\--config-and-keyring]{.title-ref} and
    [\--config-json]{.title-ref} args
    ([pr#33870](https://github.com/ceph/ceph/pull/33870), Michael
    Fritch)
-   cephadm: misc upgrade fixes
    ([pr#32794](https://github.com/ceph/ceph/pull/32794), Sage Weil)
-   cephadm: no \--no-systemd arg to ceph-volume deactivate
    ([pr#32886](https://github.com/ceph/ceph/pull/32886), Sage Weil)
-   cephadm: only infer image for shell, run, inspect-image, pull,
    ceph-volume ([pr#34030](https://github.com/ceph/ceph/pull/34030),
    Sage Weil)
-   cephadm: podman inspect: image field was called
    [ImageID]{.title-ref}
    ([pr#32616](https://github.com/ceph/ceph/pull/32616), Sebastian
    Wagner)
-   cephadm: prepare-host: do not create Packager unless we need it
    ([pr#33443](https://github.com/ceph/ceph/pull/33443), Sage Weil)
-   cephadm: pull: strip newline from version string
    ([pr#33446](https://github.com/ceph/ceph/pull/33446), Sage Weil)
-   cephadm: python3 shebang
    ([pr#32378](https://github.com/ceph/ceph/pull/32378), Sage Weil)
-   cephadm: re-introduce the [podman logs]{.title-ref} command
    ([pr#33089](https://github.com/ceph/ceph/pull/33089), Michael
    Fritch)
-   cephadm: Read ceph version from io.ceph.version label if set
    ([pr#32982](https://github.com/ceph/ceph/pull/32982), Kristoffer
    Grxc3xb6nlund)
-   cephadm: Refactor, prepare for other adoptions
    ([pr#33672](https://github.com/ceph/ceph/pull/33672), Eric Jackson)
-   cephadm: relabel /etc/ganesha mount
    ([pr#34098](https://github.com/ceph/ceph/pull/34098), Sage Weil)
-   cephadm: remove orphan daemons
    ([pr#33830](https://github.com/ceph/ceph/pull/33830), Sage Weil)
-   cephadm: remove [logs]{.title-ref} command
    ([pr#32752](https://github.com/ceph/ceph/pull/32752), Michael
    Fritch)
-   cephadm: Rename tox tests ceph-daemon -\> cephadm
    ([pr#32353](https://github.com/ceph/ceph/pull/32353), Michael
    Fritch)
-   cephadm: report image name for stopped daemons
    ([pr#33190](https://github.com/ceph/ceph/pull/33190), Sage Weil)
-   cephadm: report version for grafana prom etc
    ([pr#33804](https://github.com/ceph/ceph/pull/33804), Sage Weil)
-   cephadm: shell: allow -e
    ([pr#33191](https://github.com/ceph/ceph/pull/33191), Sage Weil)
-   cephadm: shell: default to config and keyring in /etc/ceph, if
    present ([pr#33793](https://github.com/ceph/ceph/pull/33793), Sage
    Weil)
-   cephadm: shell: do not bind ceph.conf twice
    ([pr#32425](https://github.com/ceph/ceph/pull/32425), Sage Weil)
-   cephadm: shell: keep .bash_history in /var/log/ceph/\$fsid
    ([pr#33519](https://github.com/ceph/ceph/pull/33519), Sage Weil)
-   cephadm: show contextual message when port is in use
    ([pr#32560](https://github.com/ceph/ceph/pull/32560), Michael
    Fritch)
-   cephadm: simplify Monitoring.components structure
    ([pr#32977](https://github.com/ceph/ceph/pull/32977), Michael
    Fritch)
-   cephadm: SO_REUSEADDR when doing bind check
    ([pr#32712](https://github.com/ceph/ceph/pull/32712), Sage Weil)
-   cephadm: streamline bootstrap a bit
    ([pr#33980](https://github.com/ceph/ceph/pull/33980), Sage Weil)
-   cephadm: support deployment of node-exporter
    ([pr#32340](https://github.com/ceph/ceph/pull/32340), Paul Cuzner)
-   cephadm: support deployment of prometheus container
    ([pr#32198](https://github.com/ceph/ceph/pull/32198), Sebastian
    Wagner, Paul Cuzner)
-   cephadm: switch grafana image to the ceph repo
    ([pr#34082](https://github.com/ceph/ceph/pull/34082), Paul Cuzner)
-   cephadm: update unit.\\\* atomically
    ([pr#33895](https://github.com/ceph/ceph/pull/33895), Sage Weil)
-   cephadm: use appropriate default image for non-ceph components
    ([pr#33069](https://github.com/ceph/ceph/pull/33069), Sage Weil)
-   cephadm: use spec to deploy crash on every host
    ([pr#33658](https://github.com/ceph/ceph/pull/33658), Sage Weil)
-   cephadm: use [sh]{.title-ref} instead of [bash]{.title-ref} during
    enter ([pr#33822](https://github.com/ceph/ceph/pull/33822), Michael
    Fritch)
-   cephadm: wait longer for things to come up
    ([pr#33216](https://github.com/ceph/ceph/pull/33216), Sage Weil)
-   cephfs,common,core: global: disable THP for Ceph daemons
    ([pr#31582](https://github.com/ceph/ceph/pull/31582), Patrick
    Donnelly, Mark Nelson)
-   cephfs,common,rbd: common/config_proxy: hold lock while accessing
    mutable container
    ([pr#29809](https://github.com/ceph/ceph/pull/29809), Jason
    Dillaman)
-   cephfs,common: common/secret.c: fix key parsing when doing a remount
    ([pr#28148](https://github.com/ceph/ceph/pull/28148), Luis
    Henriques)
-   cephfs,common: osdc: should release the rwlock before waiting
    ([pr#29686](https://github.com/ceph/ceph/pull/29686), Kefu Chai)
-   cephfs,core: mds/MDSDaemon: fix asok exit and respawn commands
    ([pr#32251](https://github.com/ceph/ceph/pull/32251), Sage Weil)
-   cephfs,core: msg/async: perform the v2 resets in proper EventCenter
    ([pr#30717](https://github.com/ceph/ceph/pull/30717), Radoslaw
    Zarzynski)
-   cephfs,core: qa/suites/rados/mgr/tasks/module_selftest: whitelist
    mgr client getting backlisted
    ([issue#40867](http://tracker.ceph.com/issues/40867),
    [pr#29169](https://github.com/ceph/ceph/pull/29169), Sage Weil)
-   cephfs,core: qa/suites/upgrade: a few more octopus fixes
    ([pr#32853](https://github.com/ceph/ceph/pull/32853), Sage Weil)
-   cephfs,core: qa: log warning on scrub error
    ([pr#32739](https://github.com/ceph/ceph/pull/32739), Patrick
    Donnelly)
-   cephfs,core: src/: define ceph_release_t and use it
    ([pr#27855](https://github.com/ceph/ceph/pull/27855), Kefu Chai)
-   cephfs,mgr,mon: mon/MDSMonitor: enforce mds_join_fs cluster affinity
    ([pr#33194](https://github.com/ceph/ceph/pull/33194), Patrick
    Donnelly)
-   cephfs,mgr,mon: mon/MgrMonitor: blacklist previous instance of
    ceph-mgr during failover
    ([pr#31797](https://github.com/ceph/ceph/pull/31797), Patrick
    Donnelly)
-   cephfs,mgr,pybind: mgr/prometheus: export standby mds metadata
    ([pr#29996](https://github.com/ceph/ceph/pull/29996), lei01.liu)
-   cephfs,mgr,pybind: mgr/volumes: minor enhancements and fixes
    ([issue#40429](http://tracker.ceph.com/issues/40429),
    [pr#28706](https://github.com/ceph/ceph/pull/28706), Ramana Raja)
-   cephfs,mgr: mds/MDSRank: report state to mgr as mds id, not rank
    ([pr#31231](https://github.com/ceph/ceph/pull/31231), Patrick
    Donnelly, Sage Weil)
-   cephfs,mgr: mgr/volume: ceph cephfs metadata pool pg_num_min and
    bias ([pr#27374](https://github.com/ceph/ceph/pull/27374), Sage
    Weil)
-   cephfs,mgr: mgr/volumes: cleanup libcephfs handles on plugin
    shutdown ([issue#42299](http://tracker.ceph.com/issues/42299),
    [pr#30890](https://github.com/ceph/ceph/pull/30890), Venky Shankar)
-   cephfs,mgr: pybind/mgr/volumes: use py3 items iterator
    ([pr#31986](https://github.com/ceph/ceph/pull/31986), Patrick
    Donnelly)
-   cephfs,mgr: qa: use skipTest method instead of exception
    ([pr#27761](https://github.com/ceph/ceph/pull/27761), Patrick
    Donnelly)
-   cephfs,mon: mon/MDSMonitor: cleanup check_subs
    ([pr#32308](https://github.com/ceph/ceph/pull/32308), Patrick
    Donnelly)
-   cephfs,mon: mon/MDSMonitor: handle standby already without fscid
    ([pr#32585](https://github.com/ceph/ceph/pull/32585), Patrick
    Donnelly)
-   cephfs,pybind: libcephfs: add missing declaration of ceph_getaddrs()
    ([pr#32629](https://github.com/ceph/ceph/pull/32629), Kefu Chai)
-   cephfs,pybind: mgr/volumes: add [ceph fs subvolumegroup
    getpath]{.title-ref} command
    ([issue#40617](http://tracker.ceph.com/issues/40617),
    [pr#29103](https://github.com/ceph/ceph/pull/29103), Ramana Raja)
-   cephfs,pybind: mgr/volumes: set uid/gid of FS clients mount as 0/0
    ([issue#40927](http://tracker.ceph.com/issues/40927),
    [pr#29355](https://github.com/ceph/ceph/pull/29355), Ramana Raja)
-   cephfs,pybind: pybind/cephfs: add cephfs python API removexattr()
    ([pr#30641](https://github.com/ceph/ceph/pull/30641), bingyi zhang)
-   cephfs,pybind: pybind/cephfs: Add listxattr
    ([pr#32804](https://github.com/ceph/ceph/pull/32804), Varsha Rao)
-   cephfs,rbd,tests: qa/tasks: drop object inherit
    ([pr#29843](https://github.com/ceph/ceph/pull/29843), Jos Collin)
-   cephfs,rbd: osdc: using decltype(auto) instead of trailing return
    type ([pr#29931](https://github.com/ceph/ceph/pull/29931), Yao
    Zongyou)
-   cephfs,tests: cephfs-shell: teuthology tests
    ([issue#39526](http://tracker.ceph.com/issues/39526),
    [pr#27872](https://github.com/ceph/ceph/pull/27872), Milind
    Changire)
-   cephfs,tests: mgr/volumes: fs subvolume resize command
    ([pr#30054](https://github.com/ceph/ceph/pull/30054), Jos Collin)
-   cephfs,tests: qa/cephfs: add test for ACLs
    ([pr#29421](https://github.com/ceph/ceph/pull/29421), Rishabh Dave)
-   cephfs,tests: qa/cephfs: change deps for xfstests-dev on centos8
    ([pr#32524](https://github.com/ceph/ceph/pull/32524), Rishabh Dave)
-   cephfs,tests: qa/cephfs: dont test kclient on RHEL 7
    ([pr#32582](https://github.com/ceph/ceph/pull/32582), Rishabh Dave)
-   cephfs,tests: qa/cephfs: update xfstests-dev deps for RHEL 8
    ([pr#33427](https://github.com/ceph/ceph/pull/33427), Rishabh Dave)
-   cephfs,tests: qa/suites/powercycle: install build deps for building
    xfstest ([pr#33874](https://github.com/ceph/ceph/pull/33874), Kefu
    Chai)
-   cephfs,tests: qa/tasks/cephfs/fuse_mount: use python3
    ([pr#32339](https://github.com/ceph/ceph/pull/32339), Sage Weil)
-   cephfs,tests: qa/tasks: add exception in do_thrash()
    ([pr#29067](https://github.com/ceph/ceph/pull/29067), Jos Collin)
-   cephfs,tests: qa/tasks: DaemonWatchdog Expansion
    ([issue#10369](http://tracker.ceph.com/issues/10369),
    [issue#11314](http://tracker.ceph.com/issues/11314),
    [pr#28378](https://github.com/ceph/ceph/pull/28378), Jos Collin)
-   cephfs,tests: qa/tasks: Fix raises that doesnt re-raise
    ([pr#30201](https://github.com/ceph/ceph/pull/30201), Jos Collin)
-   cephfs,tests: qa/tasks: fixed typo in the comment
    ([pr#29759](https://github.com/ceph/ceph/pull/29759), Jos Collin)
-   cephfs,tests: qa/tasks: improvements in vstart_runner.py and
    mount.py ([pr#27481](https://github.com/ceph/ceph/pull/27481),
    Rishabh Dave)
-   cephfs,tests: qa/tasks: upgrade command arguments checks in
    vstart_runner.py
    ([pr#28198](https://github.com/ceph/ceph/pull/28198), Rishabh Dave)
-   cephfs,tests: qa/tests: reduce number of jobs for
    [kcephfs]{.title-ref}
    ([pr#27328](https://github.com/ceph/ceph/pull/27328), Yuri
    Weinstein)
-   cephfs,tests: qa/tests: reduced number of jobs for
    [kcephfs]{.title-ref}
    ([pr#27165](https://github.com/ceph/ceph/pull/27165), Yuri
    Weinstein)
-   cephfs,tests: qa/vstart_runner.py: make run()s interface same as
    teuthologys run
    ([pr#33263](https://github.com/ceph/ceph/pull/33263), Rishabh Dave)
-   cephfs,tests: qa: note timeout in debug message
    ([pr#32162](https://github.com/ceph/ceph/pull/32162), Patrick
    Donnelly)
-   cephfs,tests: qa: stop DaemonWatchdog for each cluster in daemon
    roles ([pr#29821](https://github.com/ceph/ceph/pull/29821), Patrick
    Donnelly)
-   cephfs,tests: qa: test fs:upgrade when running upgrade suite
    ([pr#31206](https://github.com/ceph/ceph/pull/31206), Patrick
    Donnelly)
-   cephfs,tests: test: define ALLPERMS if not yet
    ([pr#30726](https://github.com/ceph/ceph/pull/30726), Kefu Chai)
-   cephfs,tests: test_cephfs_shell: fix test_du_works_for_hardlinks
    ([pr#32168](https://github.com/ceph/ceph/pull/32168), Rishabh Dave)
-   cephfs,tests: test_cephfs_shell: initialize stderr for
    run_cephfs_shell_cmd()
    ([pr#31626](https://github.com/ceph/ceph/pull/31626), Rishabh Dave)
-   cephfs,tests: test_sessionmap: use sudo_write_file() from
    teuthology.misc
    ([pr#29123](https://github.com/ceph/ceph/pull/29123), Rishabh Dave)
-   cephfs,tools: cephfs-journal-tool: fix crash and usage
    ([pr#32452](https://github.com/ceph/ceph/pull/32452), Xiubo Li)
-   cephfs,tools: mount.ceph: fix incorrect options parsing
    ([pr#33197](https://github.com/ceph/ceph/pull/33197), Xiubo Li)
-   cephfs,tools: vstart.sh: highlight presence of stray conf
    ([pr#31403](https://github.com/ceph/ceph/pull/31403), Milind
    Changire)
-   cephfs: client: more precise CEPH_CLIENT_CAPS_PENDING_CAPSNAP
    ([pr#28685](https://github.com/ceph/ceph/pull/28685), Yan, Zheng)
-   cephfs: mds: change how mds revoke stale caps
    ([issue#17854](http://tracker.ceph.com/issues/17854),
    [pr#26737](https://github.com/ceph/ceph/pull/26737), Yan, Zheng,
    Rishabh Dave)
-   cephfs: mds: fix corner case of replaying open sessions
    ([pr#28456](https://github.com/ceph/ceph/pull/28456), Yan, Zheng)
-   cephfs: Add doc for deploying cephfs-nfs cluster using rook
    ([pr#30914](https://github.com/ceph/ceph/pull/30914), Varsha Rao)
-   cephfs: Allow mount.ceph to get mount info from ceph configs and
    keyrings ([pr#29817](https://github.com/ceph/ceph/pull/29817), Jeff
    Layton)
-   cephfs: avoid map client_caps been inserted by mistake
    ([pr#29304](https://github.com/ceph/ceph/pull/29304),
    XiaoGuoDong2019)
-   cephfs: ceph-mds: dump all info of ceph_file_layout, InodeStoreBase,
    frag_infxe2x80xa6
    ([pr#28874](https://github.com/ceph/ceph/pull/28874), simon gao)
-   cephfs: ceph-mds: set ceph_mds cpu affinity
    ([pr#31712](https://github.com/ceph/ceph/pull/31712), qilianghong)
-   cephfs: cephfs pybind: added lseek() function to cephfs pybind
    ([pr#27688](https://github.com/ceph/ceph/pull/27688), Xiaowei Chu)
-   cephfs: cephfs-shell: Add command for setxattr, getxattr and
    listxattr ([pr#32570](https://github.com/ceph/ceph/pull/32570),
    Varsha Rao)
-   cephfs: cephfs-shell: Add error message for invalid ls commands
    ([pr#28652](https://github.com/ceph/ceph/pull/28652), Varsha Rao)
-   cephfs: cephfs-shell: add quota management
    ([issue#39165](http://tracker.ceph.com/issues/39165),
    [pr#27483](https://github.com/ceph/ceph/pull/27483), Milind
    Changire)
-   cephfs: cephfs-shell: add snapshot management
    ([issue#38681](http://tracker.ceph.com/issues/38681),
    [pr#27467](https://github.com/ceph/ceph/pull/27467), Milind
    Changire)
-   cephfs: cephfs-shell: Add stat command
    ([pr#27753](https://github.com/ceph/ceph/pull/27753), Varsha Rao)
-   cephfs: cephfs-shell: Add tox for testing with flake8
    ([pr#28239](https://github.com/ceph/ceph/pull/28239), Varsha Rao)
-   cephfs: cephfs-shell: better complain info, when deleting non-empty
    directory ([issue#40864](http://tracker.ceph.com/issues/40864),
    [pr#30341](https://github.com/ceph/ceph/pull/30341), Shen Hang)
-   cephfs: cephfs-shell: Catch OSError exceptions in lcd
    ([issue#40243](http://tracker.ceph.com/issues/40243),
    [pr#28473](https://github.com/ceph/ceph/pull/28473), Varsha Rao)
-   cephfs: cephfs-shell: cd with no args must change CWD to root
    ([issue#40476](http://tracker.ceph.com/issues/40476),
    [pr#28793](https://github.com/ceph/ceph/pull/28793), Rishabh Dave)
-   cephfs: cephfs-shell: changes related to read_ceph_conf()
    ([pr#32347](https://github.com/ceph/ceph/pull/32347), Rishabh Dave)
-   cephfs: cephfs-shell: changes to stderr and stdout messages
    ([pr#30365](https://github.com/ceph/ceph/pull/30365), Rishabh Dave)
-   cephfs: cephfs-shell: Convert paths type from string to bytes
    ([pr#29552](https://github.com/ceph/ceph/pull/29552), Varsha Rao)
-   cephfs: cephfs-shell: du should ignore non-directory files
    ([issue#40371](http://tracker.ceph.com/issues/40371),
    [pr#28560](https://github.com/ceph/ceph/pull/28560), Rishabh Dave,
    Varsha Rao)
-   cephfs: cephfs-shell: Fix df command errors
    ([pr#27894](https://github.com/ceph/ceph/pull/27894), Varsha Rao)
-   cephfs: cephfs-shell: Fix flake8 blank line and indentation error
    ([pr#29149](https://github.com/ceph/ceph/pull/29149), Varsha Rao)
-   cephfs: cephfs-shell: Fix hidden files and directories list by ls
    command ([pr#27266](https://github.com/ceph/ceph/pull/27266), Varsha
    Rao)
-   cephfs: cephfs-shell: Fix lls command errors
    ([issue#40244](http://tracker.ceph.com/issues/40244),
    [pr#28475](https://github.com/ceph/ceph/pull/28475), Varsha Rao)
-   cephfs: cephfs-shell: Fix ls -l
    ([pr#32801](https://github.com/ceph/ceph/pull/32801), Kotresh HR)
-   cephfs: cephfs-shell: Fix mkdir relative path error
    ([pr#27822](https://github.com/ceph/ceph/pull/27822), Varsha Rao)
-   cephfs: cephfs-shell: Fix multiple flake8 errors
    ([pr#28080](https://github.com/ceph/ceph/pull/28080), Varsha Rao)
-   cephfs: cephfs-shell: Fix multiple flake8 errors
    ([pr#28433](https://github.com/ceph/ceph/pull/28433), Varsha Rao)
-   cephfs: cephfs-shell: Fix multiple flake8 errors
    ([pr#29374](https://github.com/ceph/ceph/pull/29374), Varsha Rao)
-   cephfs: cephfs-shell: Fix onecmd TypeError
    ([pr#29554](https://github.com/ceph/ceph/pull/29554), Varsha Rao)
-   cephfs: cephfs-shell: Fix print of error messages to stdout
    ([pr#28447](https://github.com/ceph/ceph/pull/28447), Varsha Rao)
-   cephfs: cephfs-shell: Fix rmdir -p issues and add tests for rmdir
    ([pr#31633](https://github.com/ceph/ceph/pull/31633), Varsha Rao)
-   cephfs: cephfs-shell: fix string decoding for ls command
    ([issue#39404](http://tracker.ceph.com/issues/39404),
    [pr#27716](https://github.com/ceph/ceph/pull/27716), Milind
    Changire)
-   cephfs: cephfs-shell: Fix TypeError in poutput()
    ([pr#28906](https://github.com/ceph/ceph/pull/28906), Varsha Rao)
-   cephfs: cephfs-shell: Fix typo for mounting
    ([pr#28718](https://github.com/ceph/ceph/pull/28718), Varsha Rao)
-   cephfs: cephfs-shell: fix unecessary usage of to_bytes for file
    paths ([issue#40455](http://tracker.ceph.com/issues/40455),
    [pr#28663](https://github.com/ceph/ceph/pull/28663), Patrick
    Donnelly)
-   cephfs: cephfs-shell: fix various tracebacks
    ([issue#38743](http://tracker.ceph.com/issues/38743),
    [issue#38739](http://tracker.ceph.com/issues/38739),
    [issue#38741](http://tracker.ceph.com/issues/38741),
    [issue#38740](http://tracker.ceph.com/issues/38740),
    [pr#27235](https://github.com/ceph/ceph/pull/27235), Milind
    Changire)
-   cephfs: cephfs-shell: make compatible with cmd2 versions after
    0.9.13 ([pr#30585](https://github.com/ceph/ceph/pull/30585), Rishabh
    Dave)
-   cephfs: cephfs-shell: make every command set a return value on
    failure ([pr#32213](https://github.com/ceph/ceph/pull/32213),
    Rishabh Dave)
-   cephfs: cephfs-shell: print helpful message when conf file is not
    found ([pr#31460](https://github.com/ceph/ceph/pull/31460), Rishabh
    Dave)
-   cephfs: cephfs-shell: py version fixes
    ([issue#40418](http://tracker.ceph.com/issues/40418),
    [pr#28638](https://github.com/ceph/ceph/pull/28638), Patrick
    Donnelly)
-   cephfs: cephfs-shell: read options from ceph.conf
    ([pr#29964](https://github.com/ceph/ceph/pull/29964), Rishabh Dave)
-   cephfs: cephfs-shell: rearrange code for convenience
    ([pr#31629](https://github.com/ceph/ceph/pull/31629), Rishabh Dave)
-   cephfs: cephfs-shell: Remove extra length argument passed to
    setxattr() ([pr#30802](https://github.com/ceph/ceph/pull/30802),
    Varsha Rao)
-   cephfs: cephfs-shell: Remove str object references to attribute
    decode ([pr#27345](https://github.com/ceph/ceph/pull/27345), Varsha
    Rao)
-   cephfs: cephfs-shell: Remove undefined variable files in do_rm()
    ([pr#28710](https://github.com/ceph/ceph/pull/28710), Varsha Rao)
-   cephfs: cephfs-shell: return non-zero value on error
    ([pr#30657](https://github.com/ceph/ceph/pull/30657), Rishabh Dave)
-   cephfs: cephfs-shell: rewrite help text for put and get commands
    ([pr#30297](https://github.com/ceph/ceph/pull/30297), Rishabh Dave)
-   cephfs: cephfs-shell: Use colorama module instead of colorize
    ([pr#27427](https://github.com/ceph/ceph/pull/27427), Varsha Rao)
-   cephfs: ceph_volume_client: convert string to bytes object
    ([issue#40369](http://tracker.ceph.com/issues/40369),
    [issue#40800](http://tracker.ceph.com/issues/40800),
    [pr#28557](https://github.com/ceph/ceph/pull/28557), Rishabh Dave)
-   cephfs: ceph_volume_client: decode d_name before using it
    ([issue#39406](http://tracker.ceph.com/issues/39406),
    [pr#28196](https://github.com/ceph/ceph/pull/28196), Rishabh Dave)
-   cephfs: client: add client_fs mount option support
    ([pr#33506](https://github.com/ceph/ceph/pull/33506), Xiubo Li)
-   cephfs: client: Add is_dir() check before changing directory
    ([pr#32637](https://github.com/ceph/ceph/pull/32637), Varsha Rao)
-   cephfs: client: add procession of SEEK_HOLE and SEEK_DATA in lseek
    ([pr#30416](https://github.com/ceph/ceph/pull/30416), Shen Hang)
-   cephfs: client: add stx_btime and stx_version in cephfs.pyx
    ([pr#30206](https://github.com/ceph/ceph/pull/30206), huanwen ren)
-   cephfs: client: add warning when cap != in-\>auth_cap
    ([pr#30402](https://github.com/ceph/ceph/pull/30402), Shen Hang)
-   cephfs: client: avoid length overflow by calling the lseek function
    ([pr#29626](https://github.com/ceph/ceph/pull/29626), wenpengLi)
-   cephfs: Client: bump ll_ref from int32 to uint64_t
    ([pr#29136](https://github.com/ceph/ceph/pull/29136), Xiaoxi CHEN)
-   cephfs: client: directory size always is zero lead to
    is_quota_bytes_approaching lose efficacy
    ([pr#26104](https://github.com/ceph/ceph/pull/26104), guoyong)
-   cephfs: client: disallow changing fuse_default_permissions option at
    runtime ([pr#32315](https://github.com/ceph/ceph/pull/32315), Zhi
    Zhang)
-   cephfs: client: dont report any vxattrs to listxattr
    ([pr#29339](https://github.com/ceph/ceph/pull/29339), Jeff Layton)
-   cephfs: client: fix bad error handling in ll_lookup_inode
    ([issue#40085](http://tracker.ceph.com/issues/40085),
    [pr#28324](https://github.com/ceph/ceph/pull/28324), Jeff Layton)
-   cephfs: client: fix bad error handling in lseek SEEK_HOLE /
    SEEK_DATA ([pr#33480](https://github.com/ceph/ceph/pull/33480), Jeff
    Layton)
-   cephfs: client: fix dir.rctime and snap.btime vxattr values
    ([pr#28116](https://github.com/ceph/ceph/pull/28116), David
    Disseldorp)
-   cephfs: client: fix fuse client hang because its bad session
    PipeConnection to mds
    ([issue#39305](http://tracker.ceph.com/issues/39305),
    [pr#27482](https://github.com/ceph/ceph/pull/27482), Guan yunfei)
-   cephfs: client: fix lazyio_synchronize() to update file size
    ([pr#29705](https://github.com/ceph/ceph/pull/29705), Sidharth
    Anupkrishnan)
-   cephfs: client: Fixes for missing consts SEEK_DATA and SEEK_HOLE on
    alpine linux ([pr#33104](https://github.com/ceph/ceph/pull/33104),
    Stefan Bischoff)
-   cephfs: client: nfs-ganesha with cephfs client, removing dir reports
    not empty ([issue#40746](http://tracker.ceph.com/issues/40746),
    [pr#29005](https://github.com/ceph/ceph/pull/29005), Peng Xie)
-   cephfs: client: optimize rename operation under different quota root
    ([issue#39715](http://tracker.ceph.com/issues/39715),
    [pr#28077](https://github.com/ceph/ceph/pull/28077), Zhi Zhang)
-   cephfs: client: remove Inode.dir_contacts field and handle bad
    whence value to llseek gracefully
    ([pr#30580](https://github.com/ceph/ceph/pull/30580), Jeff Layton)
-   cephfs: client: remove unused variable
    ([pr#31509](https://github.com/ceph/ceph/pull/31509),
    <su_nan@inspur.com>)
-   cephfs: client: return -EIO when sync file which unsafe reqs have
    been dropped ([issue#40877](http://tracker.ceph.com/issues/40877),
    [pr#29167](https://github.com/ceph/ceph/pull/29167), simon gao)
-   cephfs: client: set snapdirs link count to 1
    ([pr#28545](https://github.com/ceph/ceph/pull/28545), Yan, Zheng)
-   cephfs: client: support the fallocate() when fuse version \>= 2.9
    ([issue#40615](http://tracker.ceph.com/issues/40615),
    [pr#28831](https://github.com/ceph/ceph/pull/28831), huanwen ren)
-   cephfs: Client: unlink dentry for inode with llref=0
    ([issue#40960](http://tracker.ceph.com/issues/40960),
    [pr#29321](https://github.com/ceph/ceph/pull/29321), Xiaoxi CHEN)
-   cephfs: client: \_readdir_cache_cb() may use the readdir_cache
    already clear ([issue#41148](http://tracker.ceph.com/issues/41148),
    [pr#29526](https://github.com/ceph/ceph/pull/29526), huanwen ren)
-   cephfs: clientxefxbcx9aEINVAL may be returned when offset is 0
    ([pr#30312](https://github.com/ceph/ceph/pull/30312), wenpengLi)
-   cephfs: Deploy ganesha daemons with vstart
    ([pr#31527](https://github.com/ceph/ceph/pull/31527), Varsha Rao)
-   cephfs: expose snapshot creation time as new ceph.snap.btime vxattr
    ([pr#27077](https://github.com/ceph/ceph/pull/27077), David
    Disseldorp)
-   cephfs: include: fix interval_set const_iterator call operator type
    ([pr#32185](https://github.com/ceph/ceph/pull/32185), Patrick
    Donnelly)
-   cephfs: libcephfs: Add Tests for LazyIO
    ([issue#40283](http://tracker.ceph.com/issues/40283),
    [pr#28834](https://github.com/ceph/ceph/pull/28834), Sidharth
    Anupkrishnan)
-   cephfs: mds : clean up data written to unsafe inodes
    ([pr#30969](https://github.com/ceph/ceph/pull/30969), simon gao)
-   cephfs: mds : optimization functions,get_dirfrags_under, to speed up
    processing directories with tens of millions of files
    ([pr#31123](https://github.com/ceph/ceph/pull/31123), simon gao)
-   cephfs: mds,mon: deprecate CephFS inline_data support
    ([pr#29824](https://github.com/ceph/ceph/pull/29824), Jeff Layton)
-   cephfs: mds/client: inode number delegation
    ([pr#31817](https://github.com/ceph/ceph/pull/31817), Jeff Layton)
-   cephfs: mds/FSMap: fix adjust_standby_fscid
    ([pr#32709](https://github.com/ceph/ceph/pull/32709), Sage Weil)
-   cephfs: mds/OpenFileTable: match MAX_ITEMS_PER_OBJ to
    osd_deep_scrub_large_omap_object_key_threshold
    ([pr#31232](https://github.com/ceph/ceph/pull/31232), Vikhyat Umrao)
-   cephfs: mds/server:mds: drop reconnect message from non-existent
    session ([issue#39026](http://tracker.ceph.com/issues/39026),
    [pr#27256](https://github.com/ceph/ceph/pull/27256), Shen Hang)
-   cephfs: messages: make CephFS messages safe
    ([pr#31330](https://github.com/ceph/ceph/pull/31330), Patrick
    Donnelly)
-   cephfs: mgr / volume: refactor \[sub\]volume
    ([issue#39969](http://tracker.ceph.com/issues/39969),
    [pr#28082](https://github.com/ceph/ceph/pull/28082), Venky Shankar)
-   cephfs: mgr / volumes: background purge queue for subvolumes
    ([issue#40036](http://tracker.ceph.com/issues/40036),
    [pr#28003](https://github.com/ceph/ceph/pull/28003), Patrick
    Donnelly, Venky Shankar)
-   cephfs: mgr/dashboard: CephFS class issues with strings
    ([pr#29353](https://github.com/ceph/ceph/pull/29353), Volker Theile)
-   cephfs: mgr/volume: adapt arg passing to ServiceSpec
    ([pr#33687](https://github.com/ceph/ceph/pull/33687), Joshua Schmid)
-   cephfs: mgr/volumes: add [mypy]{.title-ref} support
    ([pr#33674](https://github.com/ceph/ceph/pull/33674), Michael
    Fritch)
-   cephfs: mgr/volumes: check for string values in uid/gid
    ([pr#31961](https://github.com/ceph/ceph/pull/31961), Jos Collin)
-   cephfs: mgr/volumes: cleanup leftovers from earlier purge job
    implementation ([pr#30886](https://github.com/ceph/ceph/pull/30886),
    Venky Shankar)
-   cephfs: mgr/volumes: cleanup on fs create error
    ([pr#32459](https://github.com/ceph/ceph/pull/32459), Jos Collin)
-   cephfs: mgr/volumes: clone from snapshot
    ([issue#24880](http://tracker.ceph.com/issues/24880),
    [pr#32030](https://github.com/ceph/ceph/pull/32030), Venky Shankar)
-   cephfs: mgr/volumes: convert string to bytes object
    ([issue#39750](http://tracker.ceph.com/issues/39750),
    [pr#28380](https://github.com/ceph/ceph/pull/28380), Rishabh Dave)
-   cephfs: mgr/volumes: drop unused size
    ([pr#30185](https://github.com/ceph/ceph/pull/30185), Jos Collin)
-   cephfs: mgr/volumes: drop unused variable vol_name
    ([pr#31780](https://github.com/ceph/ceph/pull/31780), Joshua Schmid)
-   cephfs: mgr/volumes: fail removing subvolume with snapshots
    ([issue#43645](http://tracker.ceph.com/issues/43645),
    [pr#32696](https://github.com/ceph/ceph/pull/32696), Venky Shankar)
-   cephfs: mgr/volumes: fetch trash and clone entries without blocking
    volume access ([issue#44207](http://tracker.ceph.com/issues/44207),
    [pr#33413](https://github.com/ceph/ceph/pull/33413), Venky Shankar)
-   cephfs: mgr/volumes: fix error message
    ([issue#40014](http://tracker.ceph.com/issues/40014),
    [pr#28407](https://github.com/ceph/ceph/pull/28407), Ramana Raja)
-   cephfs: mgr/volumes: fix incorrect snapshot path creation
    ([pr#30654](https://github.com/ceph/ceph/pull/30654), Ramana Raja)
-   cephfs: mgr/volumes: fix placement default value
    ([pr#33476](https://github.com/ceph/ceph/pull/33476), Sage Weil)
-   cephfs: mgr/volumes: fix subvolume creation with quota
    ([issue#40152](http://tracker.ceph.com/issues/40152),
    [pr#28384](https://github.com/ceph/ceph/pull/28384), Ramana Raja)
-   cephfs: mgr/volumes: fs subvolume resize inf command
    ([pr#31157](https://github.com/ceph/ceph/pull/31157), Jos Collin)
-   cephfs: mgr/volumes: handle exceptions in purge thread with retry
    ([issue#41218](http://tracker.ceph.com/issues/41218),
    [issue#41219](http://tracker.ceph.com/issues/41219),
    [pr#29735](https://github.com/ceph/ceph/pull/29735), Venky Shankar)
-   cephfs: mgr/volumes: improve volume deletion process
    ([pr#31762](https://github.com/ceph/ceph/pull/31762), Joshua Schmid)
-   cephfs: mgr/volumes: list FS subvolumes, subvolume groups, and their
    snapshots ([pr#30476](https://github.com/ceph/ceph/pull/30476), Jos
    Collin)
-   cephfs: mgr/volumes: minor fixes
    ([pr#29760](https://github.com/ceph/ceph/pull/29760), Ramana Raja)
-   cephfs: mgr/volumes: prevent negative subvolume size
    ([pr#30058](https://github.com/ceph/ceph/pull/30058), Jos Collin)
-   cephfs: mgr/volumes: protection for [fs volume rm]{.title-ref}
    command ([pr#30407](https://github.com/ceph/ceph/pull/30407), Jos
    Collin)
-   cephfs: mgr/volumes: refactor dir handle cleanup
    ([pr#30887](https://github.com/ceph/ceph/pull/30887), Jos Collin)
-   cephfs: mgr/volumes: remove stale subvolume module
    ([pr#32645](https://github.com/ceph/ceph/pull/32645), Venky Shankar)
-   cephfs: mgr/volumes: return string type to ceph-manager
    ([pr#30451](https://github.com/ceph/ceph/pull/30451), Venky Shankar)
-   cephfs: mgr/volumes: sync inode attributes for cloned subvolumes
    ([issue#43965](http://tracker.ceph.com/issues/43965),
    [pr#33120](https://github.com/ceph/ceph/pull/33120), Venky Shankar)
-   cephfs: mgr/volumes: uid, gid for subvolume create and
    subvolumegroup create commands
    ([pr#30336](https://github.com/ceph/ceph/pull/30336), Jos Collin)
-   cephfs: mgr/volumes: unregister job upon async threads exception
    ([issue#44293](http://tracker.ceph.com/issues/44293),
    [pr#33547](https://github.com/ceph/ceph/pull/33547), Venky Shankar)
-   cephfs: mgr/volumes: versioned subvolume provisioning
    ([pr#31763](https://github.com/ceph/ceph/pull/31763), Venky Shankar)
-   cephfs: mon,mds: map mds daemons to a particular fs
    ([pr#32015](https://github.com/ceph/ceph/pull/32015), Sage Weil)
-   cephfs: mon/MDSMonitor: use stringstream instead of dout for mds
    repaired ([issue#40472](http://tracker.ceph.com/issues/40472),
    [pr#28683](https://github.com/ceph/ceph/pull/28683), Zhi Zhang)
-   cephfs: mon/MDSMonitor: warn when creating fs with default EC data
    pool ([pr#31494](https://github.com/ceph/ceph/pull/31494), Patrick
    Donnelly)
-   cephfs: mount.ceph.c: do not pass nofail to the kernel
    ([pr#26992](https://github.com/ceph/ceph/pull/26992), Kenneth
    Waegeman)
-   cephfs: mount.ceph: give a hint message when no mds is up or cluster
    is laggy ([pr#32164](https://github.com/ceph/ceph/pull/32164), Xiubo
    Li)
-   cephfs: mount.ceph: new mount option alias \-- translate fs= option
    to mds_namespace=
    ([pr#33491](https://github.com/ceph/ceph/pull/33491), Xiubo Li)
-   cephfs: mount.ceph: properly handle -o strictatime
    ([pr#29518](https://github.com/ceph/ceph/pull/29518), Jeff Layton)
-   cephfs: mount.ceph: remove arbitrary limit on size of name= option
    ([pr#32706](https://github.com/ceph/ceph/pull/32706), Jeff Layton)
-   cephfs: mount: fix the debug log when keyring getting secret failed
    ([pr#33499](https://github.com/ceph/ceph/pull/33499), Xiubo Li)
-   cephfs: octopus: Add FS subvolume clone cancel
    ([issue#44208](http://tracker.ceph.com/issues/44208),
    [pr#34018](https://github.com/ceph/ceph/pull/34018), Venky Shankar)
-   cephfs: osdc/objecter: Fix last_sent in scientific format and add
    age to ops ([pr#29818](https://github.com/ceph/ceph/pull/29818),
    Varsha Rao)
-   cephfs: propagate ll_releasedir errors
    ([pr#32548](https://github.com/ceph/ceph/pull/32548), David
    Disseldorp)
-   cephfs: pybind / cephfs: remove static typing in LibCephFS.chown
    ([issue#42923](http://tracker.ceph.com/issues/42923),
    [pr#31756](https://github.com/ceph/ceph/pull/31756), Venky Shankar)
-   cephfs: pybind/cephfs: Modification to error message
    ([pr#28628](https://github.com/ceph/ceph/pull/28628), Varsha Rao)
-   cephfs: pybind/mgr: add cephfs subvolumes module
    ([issue#39610](http://tracker.ceph.com/issues/39610),
    [pr#27594](https://github.com/ceph/ceph/pull/27594), Ramana Raja)
-   cephfs: pybind/test_volume_client: print python version correctly
    ([issue#40184](http://tracker.ceph.com/issues/40184),
    [pr#28221](https://github.com/ceph/ceph/pull/28221), Lianne)
-   cephfs: qa/cephfs: fix test_evict_client
    ([pr#28411](https://github.com/ceph/ceph/pull/28411), Yan, Zheng)
-   cephfs: qa/cephfs: make filelock_interrupt.py work with python3
    ([pr#32741](https://github.com/ceph/ceph/pull/32741), Yan, Zheng)
-   cephfs: qa/cephfs: test case for auto reconnect after blacklisted
    ([pr#31200](https://github.com/ceph/ceph/pull/31200), Yan, Zheng)
-   cephfs: qa/suites/fs/multifs/tasks/failover.yaml: disable
    RECENT_CRASH ([pr#29363](https://github.com/ceph/ceph/pull/29363),
    Sage Weil)
-   cephfs: qa/suites/fs: mon_thrash test for fs
    ([issue#17309](http://tracker.ceph.com/issues/17309),
    [pr#27073](https://github.com/ceph/ceph/pull/27073), Jos Collin)
-   cephfs: qa/tasks/cephfs: os.write takes bytes, not str
    ([pr#32359](https://github.com/ceph/ceph/pull/32359), Sage Weil)
-   cephfs: qa/tasks: add remaining tests for fs volume
    ([pr#31884](https://github.com/ceph/ceph/pull/31884), Jos Collin)
-   cephfs: qa/tasks: Better handling of thrasher names and \_\_init\_\_
    calls ([pr#31207](https://github.com/ceph/ceph/pull/31207), Jos
    Collin)
-   cephfs: qa/tasks: check if fs mounted in umount_wait
    ([pr#30553](https://github.com/ceph/ceph/pull/30553), Jos Collin)
-   cephfs: qa/tasks: Fix AttributeError: cant set attribute
    ([pr#31428](https://github.com/ceph/ceph/pull/31428), Jos Collin)
-   cephfs: qa/tasks: upgrade the check for -c sudo option in
    vstart_runner.py
    ([issue#39385](http://tracker.ceph.com/issues/39385),
    [pr#28199](https://github.com/ceph/ceph/pull/28199), Rishabh Dave)
-   cephfs: qa/vstart_runner.py: add more options
    ([pr#29906](https://github.com/ceph/ceph/pull/29906), Rishabh Dave)
-   cephfs: qa: add debugging failed osd-release setting
    ([pr#29715](https://github.com/ceph/ceph/pull/29715), Patrick
    Donnelly)
-   cephfs: qa: add upgrade test for volume upgrade from legacy
    ([pr#33636](https://github.com/ceph/ceph/pull/33636), Patrick
    Donnelly)
-   cephfs: qa: allow client mount to reset fully
    ([issue#42213](http://tracker.ceph.com/issues/42213),
    [pr#30986](https://github.com/ceph/ceph/pull/30986), Venky Shankar)
-   cephfs: qa: avoid subtree rep in test_version_splitting
    ([pr#33078](https://github.com/ceph/ceph/pull/33078), Patrick
    Donnelly)
-   cephfs: qa: build v5.4 kernel
    ([pr#32763](https://github.com/ceph/ceph/pull/32763), Patrick
    Donnelly)
-   cephfs: qa: decouple session map test from simple msgr
    ([issue#38803](http://tracker.ceph.com/issues/38803),
    [pr#27415](https://github.com/ceph/ceph/pull/27415), Patrick
    Donnelly)
-   cephfs: qa: define centos version for fs:verify
    ([pr#32535](https://github.com/ceph/ceph/pull/32535), Patrick
    Donnelly)
-   cephfs: qa: detect RHEL8 for yum package installation
    ([pr#32507](https://github.com/ceph/ceph/pull/32507), Patrick
    Donnelly)
-   cephfs: qa: do not check pg count for new data_isolated volume
    ([pr#31095](https://github.com/ceph/ceph/pull/31095), Patrick
    Donnelly)
-   cephfs: qa: fix malformed suite config
    ([pr#29431](https://github.com/ceph/ceph/pull/29431), Patrick
    Donnelly)
-   cephfs: qa: fix output check to not be sensitive to debugging
    ([pr#32163](https://github.com/ceph/ceph/pull/32163), Patrick
    Donnelly)
-   cephfs: qa: fix testing kernel branch link
    ([pr#32854](https://github.com/ceph/ceph/pull/32854), Patrick
    Donnelly)
-   cephfs: qa: fix various py3 cephfs qa bugs
    ([pr#32467](https://github.com/ceph/ceph/pull/32467), Patrick
    Donnelly)
-   cephfs: qa: fix various py3 cephfs qa bugs x2
    ([pr#32533](https://github.com/ceph/ceph/pull/32533), Patrick
    Donnelly)
-   cephfs: qa: fs Ignore ceph.dir.pin: No such attribute errors in
    getfattr tests for old kernel client
    ([pr#27377](https://github.com/ceph/ceph/pull/27377), Sidharth
    Anupkrishnan)
-   cephfs: qa: fs/upgrade test fixes and cephfs feature bit updates for
    Octopus/Nautilus
    ([issue#39078](http://tracker.ceph.com/issues/39078),
    [issue#39077](http://tracker.ceph.com/issues/39077),
    [issue#39020](http://tracker.ceph.com/issues/39020),
    [pr#27303](https://github.com/ceph/ceph/pull/27303), Patrick
    Donnelly)
-   cephfs: qa: have kclient tests use new mount.ceph functionality
    ([pr#30462](https://github.com/ceph/ceph/pull/30462), Jeff Layton)
-   cephfs: qa: ignore expected MDS_CLIENT_LATE_RELEASE warning
    ([issue#40968](http://tracker.ceph.com/issues/40968),
    [pr#29338](https://github.com/ceph/ceph/pull/29338), Patrick
    Donnelly)
-   cephfs: qa: ignore RECENT_CRASH for multimds snapshot testing
    ([pr#29911](https://github.com/ceph/ceph/pull/29911), Patrick
    Donnelly)
-   cephfs: qa: ignore slow ops for ffsb workunit
    ([pr#32668](https://github.com/ceph/ceph/pull/32668), Patrick
    Donnelly)
-   cephfs: qa: ignore trimmed cache items for dead cache drop
    ([pr#32644](https://github.com/ceph/ceph/pull/32644), Patrick
    Donnelly)
-   cephfs: qa: install some dependencies for xfstests
    ([pr#32478](https://github.com/ceph/ceph/pull/32478), Patrick
    Donnelly)
-   cephfs: qa: only restart MDS between tests
    ([pr#32532](https://github.com/ceph/ceph/pull/32532), Patrick
    Donnelly)
-   cephfs: qa: remove requirement on simple msgr
    ([issue#39079](http://tracker.ceph.com/issues/39079),
    [pr#27301](https://github.com/ceph/ceph/pull/27301), Patrick
    Donnelly)
-   cephfs: qa: rename kcephfs distro overrides
    ([pr#32639](https://github.com/ceph/ceph/pull/32639), Patrick
    Donnelly)
-   cephfs: qa: save MDS epoch barrier
    ([pr#32642](https://github.com/ceph/ceph/pull/32642), Patrick
    Donnelly)
-   cephfs: qa: sleep briefly after resetting kclient
    ([pr#29388](https://github.com/ceph/ceph/pull/29388), Patrick
    Donnelly)
-   cephfs: qa: specify random distros in multimds
    ([pr#33080](https://github.com/ceph/ceph/pull/33080), Patrick
    Donnelly)
-   cephfs: qa: tolerate ECONNRESET errcode during logrotate
    ([issue#41800](http://tracker.ceph.com/issues/41800),
    [pr#30809](https://github.com/ceph/ceph/pull/30809), Venky Shankar)
-   cephfs: qa: update kclient testing to RHEL 7.6
    ([pr#26662](https://github.com/ceph/ceph/pull/26662), Patrick
    Donnelly)
-   cephfs: qa: use -D_GNU_SOURCE when compiling fsync-tester.c
    ([pr#32480](https://github.com/ceph/ceph/pull/32480), Patrick
    Donnelly)
-   cephfs: qa: use hard_reset to reboot kclient
    ([issue#37681](http://tracker.ceph.com/issues/37681),
    [pr#28825](https://github.com/ceph/ceph/pull/28825), Patrick
    Donnelly)
-   cephfs: qa: use mimic-O upgrade process
    ([pr#27731](https://github.com/ceph/ceph/pull/27731), Patrick
    Donnelly)
-   cephfs: qa: use small default pg count for CephFS pools
    ([pr#30816](https://github.com/ceph/ceph/pull/30816), Patrick
    Donnelly)
-   cephfs: qa: wait for MDS to come back after removing it
    ([issue#40967](http://tracker.ceph.com/issues/40967),
    [pr#29336](https://github.com/ceph/ceph/pull/29336), Patrick
    Donnelly)
-   cephfs: qa: whitelist Error recovering journal for cephfs-data-scan
    ([pr#30971](https://github.com/ceph/ceph/pull/30971), Yan, Zheng)
-   cephfs: qa: whitelist TOO_FEW_PGS during Mimic deploy
    ([pr#31063](https://github.com/ceph/ceph/pull/31063), Patrick
    Donnelly)
-   cephfs: Resolve a memory leak in cephfs/Resetter.cc
    ([pr#29302](https://github.com/ceph/ceph/pull/29302),
    XiaoGuoDong2019)
-   cephfs: src/common: fix help text for echo option of cephfs-shell
    ([pr#33285](https://github.com/ceph/ceph/pull/33285), Rishabh Dave)
-   cephfs: stop: Cleanly umount cephFS volumes
    ([pr#32024](https://github.com/ceph/ceph/pull/32024), Kotresh HR)
-   cephfs: test/{fs,cephfs}: Get libcephfs and cephfs to compile with
    FreeBSD ([pr#30505](https://github.com/ceph/ceph/pull/30505), Willem
    Jan Withagen)
-   cephfs: test: extend [fs subvolume]{.title-ref} test to cover new
    interfaces ([issue#39949](http://tracker.ceph.com/issues/39949),
    [pr#27856](https://github.com/ceph/ceph/pull/27856), Venky Shankar)
-   cephfs: test: use distinct subvolume/group/snapshot names
    ([issue#42646](http://tracker.ceph.com/issues/42646),
    [pr#31418](https://github.com/ceph/ceph/pull/31418), Venky Shankar)
-   cephfs: test_volumes: fix \_verify_clone_attrs call
    ([pr#33788](https://github.com/ceph/ceph/pull/33788), Ramana Raja)
-   cephfs: test_volume_client: declare only one default for python
    version ([issue#40460](http://tracker.ceph.com/issues/40460),
    [pr#28194](https://github.com/ceph/ceph/pull/28194), Rishabh Dave)
-   cephfs: test_volume_client: fix test_put_object_versioned()
    ([issue#39405](http://tracker.ceph.com/issues/39405),
    [issue#39510](http://tracker.ceph.com/issues/39510),
    [pr#28692](https://github.com/ceph/ceph/pull/28692), Rishabh Dave)
-   cephfs: test_volume_client: simplify test_get_authorized_ids()
    ([pr#28171](https://github.com/ceph/ceph/pull/28171), Rishabh Dave)
-   cephfs: tools/cephfs: make cephfs-data-scan scan_links fix dentrys
    first ([pr#31680](https://github.com/ceph/ceph/pull/31680), Yan,
    Zheng)
-   cephfs: Trivial comment and cleanup fixes for cephfs
    ([pr#27199](https://github.com/ceph/ceph/pull/27199), Jeff Layton)
-   cephfs: vstart: add an alias for cephfs-shell to
    vstart_environment.sh
    ([pr#27437](https://github.com/ceph/ceph/pull/27437), Jeff Layton)
-   cephfs: vstart: generate environment script suitable for sourcing
    ([pr#27198](https://github.com/ceph/ceph/pull/27198), Jeff Layton)
-   cephfs: vstart_runner: allow the use of it with kernel mounts
    ([pr#30463](https://github.com/ceph/ceph/pull/30463), Jeff Layton)
-   ceph_argparse: increment matchcnt on kwargs
    ([pr#33004](https://github.com/ceph/ceph/pull/33004), Matthew
    Oliver)
-   check rdma configuration and fix some logic problem
    ([pr#28344](https://github.com/ceph/ceph/pull/28344), Changcheng
    Liu)
-   client/Client : Fix sign compare compiler warning
    ([pr#30719](https://github.com/ceph/ceph/pull/30719), Prashant D)
-   cls/queue: fix data corruption in urgent data
    ([pr#33686](https://github.com/ceph/ceph/pull/33686), Yuval
    Lifshitz)
-   cmake: support parallel build for rocksd
    ([pr#31781](https://github.com/ceph/ceph/pull/31781), Deepika
    Upadhyay)
-   cmake: add add_tox_test()
    ([pr#29446](https://github.com/ceph/ceph/pull/29446), Kefu Chai)
-   cmake: add cython_cephfs to vstart target
    ([pr#28876](https://github.com/ceph/ceph/pull/28876), Kefu Chai)
-   cmake: Add dpdk numa support
    ([pr#31841](https://github.com/ceph/ceph/pull/31841), Chunsong Feng,
    Hu Ye)
-   cmake: Allow cephfs and ceph-mds to be build when building on
    FreeBSD ([pr#30494](https://github.com/ceph/ceph/pull/30494), Willem
    Jan Withagen)
-   cmake: avoid rebuilding extensions, and using python-config
    ([pr#28920](https://github.com/ceph/ceph/pull/28920), Kefu Chai)
-   cmake: boost fixes for ARM 32 bit
    ([pr#25729](https://github.com/ceph/ceph/pull/25729), Daniel Glaser)
-   cmake: bump libceph-common SO version for compliance
    ([pr#30976](https://github.com/ceph/ceph/pull/30976), Nathan Cutler)
-   cmake: check for MAJOR.MINOR version of python3
    ([pr#27383](https://github.com/ceph/ceph/pull/27383), Kefu Chai,
    Boris Ranto)
-   cmake: check for unaligned access
    ([pr#28936](https://github.com/ceph/ceph/pull/28936), Kefu Chai)
-   cmake: check version of librdkafka
    ([pr#32237](https://github.com/ceph/ceph/pull/32237), Kefu Chai)
-   cmake: cleanups
    ([pr#28252](https://github.com/ceph/ceph/pull/28252), Kefu Chai)
-   cmake: cleanups
    ([pr#33500](https://github.com/ceph/ceph/pull/33500), Kefu Chai)
-   cmake: compile crimson-auth with crimson::cflags
    ([pr#33296](https://github.com/ceph/ceph/pull/33296), Kefu Chai)
-   cmake: dashboard: enable frontend on arm64
    ([pr#30958](https://github.com/ceph/ceph/pull/30958), Kefu Chai)
-   cmake: define mgr_cap_obj library when WITH_MGR=OFF
    ([pr#31326](https://github.com/ceph/ceph/pull/31326), Casey Bodley)
-   cmake: detect librt for POSIX time functions
    ([pr#31543](https://github.com/ceph/ceph/pull/31543), Kefu Chai)
-   cmake: detect linker support
    ([pr#30781](https://github.com/ceph/ceph/pull/30781), Kefu Chai)
-   cmake: Do a debug build by default
    ([pr#30799](https://github.com/ceph/ceph/pull/30799), Brad Hubbard)
-   cmake: do not assume \${CMAKE_GENERATOR} == make
    ([pr#27089](https://github.com/ceph/ceph/pull/27089), Kefu Chai)
-   cmake: do not include \${CMAKE_SOURCE_DIR}/src/fmt/include
    ([pr#31761](https://github.com/ceph/ceph/pull/31761), Kefu Chai)
-   cmake: do not include global_context.cc multiple times
    ([pr#32607](https://github.com/ceph/ceph/pull/32607), Kefu Chai)
-   cmake: do not link against unused libs
    ([pr#33247](https://github.com/ceph/ceph/pull/33247), Kefu Chai)
-   cmake: do not use CMP0074 unless it is supported
    ([pr#31958](https://github.com/ceph/ceph/pull/31958), Kefu Chai)
-   cmake: do not use CMP0093 unless it is supported
    ([pr#31960](https://github.com/ceph/ceph/pull/31960), Kefu Chai)
-   cmake: exclude unittest_alloc_aging from all
    ([pr#33466](https://github.com/ceph/ceph/pull/33466), Kefu Chai)
-   cmake: Fix build against ncurses with separate libtinfo
    ([pr#27443](https://github.com/ceph/ceph/pull/27443), Lars Wendler)
-   cmake: Fix unaligned check on big-endian systems
    ([pr#30362](https://github.com/ceph/ceph/pull/30362), Ulrich
    Weigand)
-   cmake: fix WITH_UBSAN
    ([pr#28725](https://github.com/ceph/ceph/pull/28725), Casey Bodley)
-   cmake: Improve test for 16-byte atomic support on IBM Z
    ([pr#32802](https://github.com/ceph/ceph/pull/32802), Ulrich
    Weigand)
-   cmake: let vstart depend on radosgwd
    ([pr#32564](https://github.com/ceph/ceph/pull/32564), Kefu Chai)
-   cmake: link ceph-fuse against librt
    ([pr#31531](https://github.com/ceph/ceph/pull/31531), Yong Wang)
-   cmake: move crimson-crush to crimson/
    ([pr#33481](https://github.com/ceph/ceph/pull/33481), Kefu Chai)
-   cmake: one run_tox.sh to rule them all
    ([pr#29457](https://github.com/ceph/ceph/pull/29457), Kefu Chai)
-   cmake: pass arguments to crimson tests
    ([pr#30655](https://github.com/ceph/ceph/pull/30655), Kefu Chai)
-   cmake: pmem/pmdk changes to cmake
    ([pr#28802](https://github.com/ceph/ceph/pull/28802), Scott
    Peterson, Xiaoyan Li)
-   cmake: remove cython 0.29s subinterpreter check during install
    ([pr#27067](https://github.com/ceph/ceph/pull/27067), Tim Serong)
-   cmake: Removed unittest_alloc_aging from make check
    ([pr#33397](https://github.com/ceph/ceph/pull/33397), Adam Kupczyk)
-   cmake: require CMake v3.10.2
    ([pr#29291](https://github.com/ceph/ceph/pull/29291), Kefu Chai)
-   cmake: require RocksDB 5.14 or higher
    ([pr#29930](https://github.com/ceph/ceph/pull/29930), Ilsoo Byun)
-   cmake: revert librados_tp.so version from 3 to 2
    ([issue#39291](http://tracker.ceph.com/issues/39291),
    [pr#27593](https://github.com/ceph/ceph/pull/27593), Nathan Cutler)
-   cmake: rewrite Findgenl to support components argument
    ([pr#28460](https://github.com/ceph/ceph/pull/28460), Kefu Chai)
-   cmake: s/bortli_libs/brotli_libs/
    ([pr#30374](https://github.com/ceph/ceph/pull/30374), Kefu Chai)
-   cmake: selectively rewrite install rpath
    ([pr#30028](https://github.com/ceph/ceph/pull/30028), Kefu Chai)
-   cmake: set empty INSTALL_RPATH on crypto shared libs
    ([issue#40398](http://tracker.ceph.com/issues/40398),
    [pr#28593](https://github.com/ceph/ceph/pull/28593), Nathan Cutler)
-   cmake: set empty RPATH for some test executables
    ([pr#29922](https://github.com/ceph/ceph/pull/29922), Nathan Cutler)
-   cmake: set empty-string RPATH for ceph-osd
    ([issue#40295](http://tracker.ceph.com/issues/40295),
    [pr#28508](https://github.com/ceph/ceph/pull/28508), Nathan Cutler)
-   cmake: should expose \${C-ARES_BINARY_DIR} from c-ares
    ([pr#33256](https://github.com/ceph/ceph/pull/33256), Kefu Chai)
-   cmake: silence messages when cppcheck/IWYU is not found
    ([pr#32140](https://github.com/ceph/ceph/pull/32140), Kefu Chai)
-   cmake: support [Seastar_DPDK=ON]{.title-ref} option
    ([pr#31110](https://github.com/ceph/ceph/pull/31110), Kefu Chai)
-   cmake: Test for 16-byte atomic support on IBM Z
    ([pr#30638](https://github.com/ceph/ceph/pull/30638), Ulrich
    Weigand)
-   cmake: update FindBoost.cmake
    ([pr#29396](https://github.com/ceph/ceph/pull/29396), Willem Jan
    Withagen)
-   cmake: update FindBoost.cmake for 1.71
    ([pr#31317](https://github.com/ceph/ceph/pull/31317), Willem Jan
    Withagen)
-   cmake: Update pmdk version to 1.7
    ([pr#32693](https://github.com/ceph/ceph/pull/32693), Yin, Congmin)
-   cmake: update SPDK to build with GCC-9
    ([pr#28507](https://github.com/ceph/ceph/pull/28507), Kefu Chai)
-   cmake: use BUILD_ALWAYS for rebuilding external project
    ([pr#28984](https://github.com/ceph/ceph/pull/28984), Kefu Chai)
-   cmake: use GNU linker on FreeBSD
    ([pr#30621](https://github.com/ceph/ceph/pull/30621), Willem Jan
    Withagen)
-   cmake: use latest FindPython\\\*.cmake
    ([pr#29100](https://github.com/ceph/ceph/pull/29100), Kefu Chai)
-   cmake: use python2 by default
    ([pr#29148](https://github.com/ceph/ceph/pull/29148), Kefu Chai)
-   cmake: use StdFilesystem::filesystem instead of stdc++fs
    ([pr#27149](https://github.com/ceph/ceph/pull/27149), Willem Jan
    Withagen)
-   cmake: workaround of false alarm from ubsan
    ([pr#27094](https://github.com/ceph/ceph/pull/27094), Kefu Chai)
-   CMakeLists.txt: fix typo in error message
    ([pr#28795](https://github.com/ceph/ceph/pull/28795), Kefu Chai)
-   codeowners: Add ceph2.py to \@ceph/orchestrators
    ([pr#32131](https://github.com/ceph/ceph/pull/32131), Sebastian
    Wagner)
-   common,core,mon: src/: drop cct from cmd_getval()
    ([pr#33010](https://github.com/ceph/ceph/pull/33010), Kefu Chai)
-   common,core: common, auth: use boost::spirit to parse ceph.conf,
    escape quotes in exported auths
    ([issue#22227](http://tracker.ceph.com/issues/22227),
    [pr#28634](https://github.com/ceph/ceph/pull/28634), Kefu Chai, Gu
    Zhongyan)
-   common,core: common,mgr,osd: pass string_view as name
    ([pr#33167](https://github.com/ceph/ceph/pull/33167), Kefu Chai)
-   common,core: common,osd: add hash algorithms for dedup fingerprint
    ([pr#28254](https://github.com/ceph/ceph/pull/28254), Myoungwon Oh)
-   common,core: include/cpp-btree: use the same type when
    allocate/deallocate
    ([pr#33638](https://github.com/ceph/ceph/pull/33638), Kefu Chai)
-   common,core: message,mgr: drop MessageFactory and friends and use
    ref_t\<\> in mgr
    ([pr#27592](https://github.com/ceph/ceph/pull/27592), Patrick
    Donnelly, Kefu Chai)
-   common,core: Remove dependence on \`using namespace\`: Build of
    common through osdc/Objecter.cc
    ([pr#27255](https://github.com/ceph/ceph/pull/27255), Adam C.
    Emerson)
-   common,mgr: vstart.sh: set prometheus port for each mgr
    ([pr#33698](https://github.com/ceph/ceph/pull/33698), Alfonso
    Martxc3xadnez)
-   common,mon: common/options: make mon_clean_pg_upmaps_per_chunk
    unsigned ([pr#28509](https://github.com/ceph/ceph/pull/28509), Kefu
    Chai)
-   common,rbd: common/ceph_context: avoid unnecessary wait during
    service thread shutdown
    ([pr#30947](https://github.com/ceph/ceph/pull/30947), Jason
    Dillaman)
-   common,rgw: common/Formatter: escape printed buffer in
    XMLFormatter::dump_format_va()
    ([issue#38121](http://tracker.ceph.com/issues/38121),
    [pr#26220](https://github.com/ceph/ceph/pull/26220), ashitakasam)
-   common,rgw: rgw/OutputDataSocket: actually discard data on full
    buffer ([issue#40178](http://tracker.ceph.com/issues/40178),
    [pr#28415](https://github.com/ceph/ceph/pull/28415), Matt Benjamin)
-   common,tests: python-common: Add mypy testing
    ([pr#31071](https://github.com/ceph/ceph/pull/31071), Sebastian
    Wagner)
-   common,tests: test/test_mempool: test accounting for btree_map
    ([pr#33621](https://github.com/ceph/ceph/pull/33621), Adam Kupczyk)
-   common,tools: src/common: add rabin chunking for dedup
    ([pr#26730](https://github.com/ceph/ceph/pull/26730), Myoungwon Oh,
    Hsuan-Heng, Wu)
-   common,tools: vstart.sh: enable creating multiple OSDs backed by
    spdk backend ([pr#27841](https://github.com/ceph/ceph/pull/27841),
    Richael Zhuang)
-   common,tools: vstart.sh: enable nfs-ganesha mgmt. in dashboard
    ([pr#33691](https://github.com/ceph/ceph/pull/33691), Alfonso
    Martxc3xadnez)
-   common/config_values: set seastar logging level per that of ceph
    ([pr#28792](https://github.com/ceph/ceph/pull/28792), Kefu Chai)
-   common/options: remove unused ms_msgr2\\\_{sign,encrypt}\_messages
    ([pr#31818](https://github.com/ceph/ceph/pull/31818), Ilya Dryomov)
-   common: crimson/osd: add \--mkkey support
    ([pr#28534](https://github.com/ceph/ceph/pull/28534), Kefu Chai)
-   common: .gitignore: ignore /src/python-common/build
    ([pr#32967](https://github.com/ceph/ceph/pull/32967), Alfonso
    Martxc3xadnez)
-   common: add \--log-early command line option
    ([pr#27419](https://github.com/ceph/ceph/pull/27419), Sage Weil)
-   common: add bool log_to_file option
    ([pr#27044](https://github.com/ceph/ceph/pull/27044), Sage Weil)
-   common: add comment about pod memory requests/limits
    ([pr#29331](https://github.com/ceph/ceph/pull/29331), Patrick
    Donnelly)
-   common: add iterator-based string splitter
    ([pr#33696](https://github.com/ceph/ceph/pull/33696), Casey Bodley)
-   common: add ref header
    ([pr#29119](https://github.com/ceph/ceph/pull/29119), Patrick
    Donnelly)
-   common: auth/cephx: always initialize local variables
    ([pr#31154](https://github.com/ceph/ceph/pull/31154), Kefu Chai)
-   common: auth/krb: fix Kerberos compile error
    ([issue#39948](http://tracker.ceph.com/issues/39948),
    [pr#28113](https://github.com/ceph/ceph/pull/28113), huangjun)
-   common: avoid use of size_t in options
    ([pr#28277](https://github.com/ceph/ceph/pull/28277), James Page)
-   common: blobhash.h: remove extra \[\[fallthrough\]\]
    ([pr#28270](https://github.com/ceph/ceph/pull/28270), Thomas
    Johnson)
-   common: blobhash: do not use cast for unaligned access
    ([pr#28099](https://github.com/ceph/ceph/pull/28099), Kefu Chai)
-   common: buffer, denc: more constness
    ([pr#27767](https://github.com/ceph/ceph/pull/27767), Kefu Chai)
-   common: buffer,crypto,tools: extract digest methods out of
    bufferlist ([pr#28486](https://github.com/ceph/ceph/pull/28486),
    Kefu Chai)
-   common: buffer.h: remove list::iterator_impl::advance(size_t)
    ([pr#28278](https://github.com/ceph/ceph/pull/28278), Kefu Chai)
-   common: ceph.in: use sys.\_exit when we dont shut down
    ([pr#33950](https://github.com/ceph/ceph/pull/33950), Sage Weil)
-   common: ceph_argparse: put args from env before existing ones
    ([pr#33243](https://github.com/ceph/ceph/pull/33243), Kefu Chai)
-   common: Clang requires a default constructor, but it can be empty
    ([issue#39561](http://tracker.ceph.com/issues/39561),
    [pr#27844](https://github.com/ceph/ceph/pull/27844), Willem Jan
    Withagen)
-   common: clean up CLUSTER_CREATE and CREATE options
    ([pr#31584](https://github.com/ceph/ceph/pull/31584), Sage Weil)
-   common: common,crimson: fixes to compile with clang and libc++
    ([pr#32485](https://github.com/ceph/ceph/pull/32485), Kefu Chai)
-   common: common,crimson: supporting admin-socket commands
    ([pr#32174](https://github.com/ceph/ceph/pull/32174), Ronen
    Friedman, Kefu Chai)
-   common: common,log: use ISO 8601 datetime format
    ([pr#27799](https://github.com/ceph/ceph/pull/27799), Sage Weil,
    Casey Bodley)
-   common: common,os: address string truncated warnings from GCC-9
    ([pr#28289](https://github.com/ceph/ceph/pull/28289), Kefu Chai)
-   common: common/admin_socket: Added printing of error message
    ([pr#33380](https://github.com/ceph/ceph/pull/33380), Adam Kupczyk)
-   common: common/bl: carry the bufferlist::\_carriage over std::moves
    ([pr#32937](https://github.com/ceph/ceph/pull/32937), Radoslaw
    Zarzynski)
-   common: common/bl: fix memory corruption in
    bufferlist::claim_append()
    ([pr#32823](https://github.com/ceph/ceph/pull/32823), Radoslaw
    Zarzynski)
-   common: common/bl: fix the dangling last_p issue
    ([pr#32702](https://github.com/ceph/ceph/pull/32702), Radoslaw
    Zarzynski)
-   common: common/bloom_filter: Fix endian issues
    ([pr#30527](https://github.com/ceph/ceph/pull/30527), Ulrich
    Weigand)
-   common: common/ceph_time: tolerate mono time going backwards
    ([pr#33699](https://github.com/ceph/ceph/pull/33699), Sage Weil)
-   common: common/config: cleanups
    ([pr#33362](https://github.com/ceph/ceph/pull/33362), Jianpeng Ma)
-   common: common/config: fix lack of normalize_key_name() apply
    ([pr#33558](https://github.com/ceph/ceph/pull/33558), Igor Fedotov)
-   common: common/config: Remove unused code
    ([pr#28940](https://github.com/ceph/ceph/pull/28940), Jianpeng Ma)
-   common: common/Finisher: remove some lock acquisitions
    ([pr#29495](https://github.com/ceph/ceph/pull/29495), Igor Fedotov)
-   common: common/options: change default erasure-code-profile to k=2
    m=2 ([pr#27656](https://github.com/ceph/ceph/pull/27656), Sage Weil)
-   common: common/pick_address.cc: silence GCC warning
    ([pr#32025](https://github.com/ceph/ceph/pull/32025), Kefu Chai)
-   common: common/secret.c: dont pass uninitialized stack data to the
    kernel ([pr#30675](https://github.com/ceph/ceph/pull/30675), Ilya
    Dryomov)
-   common: common/thread: Fix race condition in make_named_thread
    ([pr#31057](https://github.com/ceph/ceph/pull/31057), Adam C.
    Emerson)
-   common: common/util: use ifstream to read from /proc files
    ([pr#32630](https://github.com/ceph/ceph/pull/32630), Kefu Chai)
-   common: common/WorkQueue: narrow ThreadPool::\_lock in func worker
    ([pr#22411](https://github.com/ceph/ceph/pull/22411), Jianpeng Ma)
-   common: crimson, common: introduce ceph::atomic and apply it on
    bufferlist ([pr#32766](https://github.com/ceph/ceph/pull/32766),
    Radoslaw Zarzynski)
-   common: crimson, common: RefCountedObj doesnt use atomics in Seastar
    builds ([pr#28085](https://github.com/ceph/ceph/pull/28085),
    Radoslaw Zarzynski)
-   common: crimson/osd: implement readable/lease related methods
    ([pr#30639](https://github.com/ceph/ceph/pull/30639), Kefu Chai)
-   common: crimson/osd: Message has non-null ref to SocketConnection
    now ([pr#30124](https://github.com/ceph/ceph/pull/30124), Radoslaw
    Zarzynski)
-   common: crimson: cleanups
    ([pr#33797](https://github.com/ceph/ceph/pull/33797), Kefu Chai)
-   common: crimson: cleanups for clang build
    ([pr#32605](https://github.com/ceph/ceph/pull/32605), Kefu Chai)
-   common: Cycles: Add support for IBM Z
    ([pr#30874](https://github.com/ceph/ceph/pull/30874), Ulrich
    Weigand)
-   common: default pg_autoscale_mode=on for new pools
    ([pr#30112](https://github.com/ceph/ceph/pull/30112), Sage Weil)
-   common: default pg_autoscale_mode=on for new pools
    ([pr#30475](https://github.com/ceph/ceph/pull/30475), Sage Weil)
-   common: denc: fix build error by calling global snprintf
    ([pr#27572](https://github.com/ceph/ceph/pull/27572), Changcheng
    Liu)
-   common: denc: slightly optimize container_base::bound_encode
    ([pr#24636](https://github.com/ceph/ceph/pull/24636), Radoslaw
    Zarzynski, Kefu Chai)
-   common: denc: support enums wider than 8 bits
    ([pr#33673](https://github.com/ceph/ceph/pull/33673), Casey Bodley)
-   common: dmclock: pick up fix to replace uint
    ([pr#28829](https://github.com/ceph/ceph/pull/28829), Kefu Chai)
-   common: drop sharing of buffer::raw outside bufferlist
    ([pr#32806](https://github.com/ceph/ceph/pull/32806), Radoslaw
    Zarzynski)
-   common: encode for std::list\<T\> doesnt use bl::copy_in() anymore
    ([pr#32785](https://github.com/ceph/ceph/pull/32785), Radoslaw
    Zarzynski)
-   common: FIPS: audit and switch some memset & bzero users
    ([pr#31692](https://github.com/ceph/ceph/pull/31692), Radoslaw
    Zarzynski)
-   common: Fix 44373 and make a couple cleanups in ceph::timer
    ([pr#33771](https://github.com/ceph/ceph/pull/33771), Adam C.
    Emerson)
-   common: fix clang build failures, and clean up warnings
    ([pr#26701](https://github.com/ceph/ceph/pull/26701), Adam C.
    Emerson)
-   common: fix clang compile errors from cython_modules
    ([pr#33056](https://github.com/ceph/ceph/pull/33056), Mark Kogan)
-   common: fix compat of strerror_r
    ([pr#30279](https://github.com/ceph/ceph/pull/30279), luo.runbing)
-   common: fix deadlocky inflight op visiting in OpTracker
    ([pr#32364](https://github.com/ceph/ceph/pull/32364), Radoslaw
    Zarzynski)
-   common: fix missing \<stdio.h\> include
    ([pr#31209](https://github.com/ceph/ceph/pull/31209), Willem Jan
    Withagen)
-   common: fix parse_env nullptr deref
    ([pr#28159](https://github.com/ceph/ceph/pull/28159), Patrick
    Donnelly)
-   common: Fix the error handling logic in get_device_id
    ([pr#30636](https://github.com/ceph/ceph/pull/30636), Difan Zhang)
-   common: fix typo in rgw_user_max_buckets option long description
    ([pr#31571](https://github.com/ceph/ceph/pull/31571), Alfonso
    Martxc3xadnez)
-   common: give lockdeps group name to OpenSSLs mutexes
    ([issue#40698](http://tracker.ceph.com/issues/40698),
    [pr#28987](https://github.com/ceph/ceph/pull/28987), Radoslaw
    Zarzynski)
-   common: global/global_context: always add \\0 after strncpy()
    ([pr#28365](https://github.com/ceph/ceph/pull/28365), Kefu Chai)
-   common: global/global_init: do first transport connection after
    setuid() ([pr#28012](https://github.com/ceph/ceph/pull/28012), Roman
    Penyaev)
-   common: global/pidfile: pass string_view instead of ConfigProxy to
    pidfile_wrxe2x80xa6
    ([pr#27975](https://github.com/ceph/ceph/pull/27975), Kefu Chai)
-   common: handle return value from read(2)
    ([pr#32192](https://github.com/ceph/ceph/pull/32192), Patrick
    Donnelly)
-   common: include, common: make ceph::bufferlist 32 bytes long on x86
    ([pr#32934](https://github.com/ceph/ceph/pull/32934), Radoslaw
    Zarzynski)
-   common: include/buffer: add operator+=() for list::iterator
    ([pr#33003](https://github.com/ceph/ceph/pull/33003), Kefu Chai)
-   common: include/cpp-btree: drop btree::dump()
    ([pr#32692](https://github.com/ceph/ceph/pull/32692), Kefu Chai)
-   common: include/interval_set: rename some types
    ([pr#32415](https://github.com/ceph/ceph/pull/32415), Kefu Chai)
-   common: include: switch mempool.h to ceph::atomic
    ([pr#33034](https://github.com/ceph/ceph/pull/33034), Radoslaw
    Zarzynski)
-   common: json: JSONDecoder::err inherits from std::runtime_error
    ([pr#27957](https://github.com/ceph/ceph/pull/27957), Casey Bodley)
-   common: make cluster_network work
    ([pr#27811](https://github.com/ceph/ceph/pull/27811), Jianpeng Ma)
-   common: messages: MOSDPGCreate2 doesnt assume using namespace std
    ([pr#28342](https://github.com/ceph/ceph/pull/28342), Radoslaw
    Zarzynski)
-   common: messages: remove MNop
    ([pr#27585](https://github.com/ceph/ceph/pull/27585), Kefu Chai)
-   common: mgr/test_orchestrator: Add dummy data
    ([pr#32182](https://github.com/ceph/ceph/pull/32182), Sebastian
    Wagner, Volker Theile)
-   common: move gen_rand_alphanumeric() helpers into common
    ([pr#31567](https://github.com/ceph/ceph/pull/31567), Casey Bodley)
-   common: move xattr -\> os/filestore/os_xattr
    ([pr#32219](https://github.com/ceph/ceph/pull/32219), David
    Disseldorp)
-   common: msg/Message: remove unused local variables
    ([pr#29155](https://github.com/ceph/ceph/pull/29155), Kefu Chai)
-   common: msg/msg_types: use inet_ntop(3) to render IP addresses
    ([pr#26987](https://github.com/ceph/ceph/pull/26987), Sage Weil)
-   common: no need to include ceph_assert.h
    ([pr#28255](https://github.com/ceph/ceph/pull/28255), Kefu Chai)
-   common: octopus
    ([pr#27009](https://github.com/ceph/ceph/pull/27009), Sage Weil)
-   common: optimize check_utf8
    ([pr#27628](https://github.com/ceph/ceph/pull/27628), Yibo Cai)
-   common: optimize encode_utf8
    ([pr#27807](https://github.com/ceph/ceph/pull/27807), Yibo Cai)
-   common: OutputDataSocket retakes mutex on error path
    ([issue#40188](http://tracker.ceph.com/issues/40188),
    [pr#28431](https://github.com/ceph/ceph/pull/28431), Casey Bodley)
-   common: preforker: remove useless code
    ([pr#31714](https://github.com/ceph/ceph/pull/31714), Xiubo Li)
-   common: python-common: Add drive selection
    ([pr#31021](https://github.com/ceph/ceph/pull/31021), Sebastian
    Wagner)
-   common: python-common: add py.typed (PEP 561)
    ([pr#33236](https://github.com/ceph/ceph/pull/33236), Sebastian
    Wagner)
-   common: python-common: Add small Readme
    ([pr#30587](https://github.com/ceph/ceph/pull/30587), Sebastian
    Wagner)
-   common: python-common: avoid using setup_requires in setup.py
    ([pr#31222](https://github.com/ceph/ceph/pull/31222), Sebastian
    Wagner)
-   common: python-common: enable lint in tox tests
    ([pr#31068](https://github.com/ceph/ceph/pull/31068), Kiefer Chang)
-   common: python-common: Fix typo in device type
    ([pr#31758](https://github.com/ceph/ceph/pull/31758), Volker Theile)
-   common: python-common: Make Drive Group filter by AND, instead of OR
    ([pr#33625](https://github.com/ceph/ceph/pull/33625), Sage Weil,
    Sebastian Wagner)
-   common: python-common: Make DriveGroupSpec a sub type of ServiceSpec
    ([pr#33817](https://github.com/ceph/ceph/pull/33817), Sebastian
    Wagner)
-   common: random: added a deduction guide to make using the function
    obxe2x80xa6 ([pr#30224](https://github.com/ceph/ceph/pull/30224),
    Jesse Williamson)
-   common: remove dead code in {safe,mutable}\_item_history
    ([pr#32698](https://github.com/ceph/ceph/pull/32698), Radoslaw
    Zarzynski)
-   common: remove unused \_STR and STRINGIFY macro
    ([pr#29605](https://github.com/ceph/ceph/pull/29605), Yao Zongyou)
-   common: rename image to container_image
    ([pr#30800](https://github.com/ceph/ceph/pull/30800), Sage Weil)
-   common: Revert Merge pull request #33673 from cbodley/wip-denc-enum
    ([pr#33832](https://github.com/ceph/ceph/pull/33832), Sage Weil)
-   common: selinux: Allow ceph to setsched
    ([pr#33404](https://github.com/ceph/ceph/pull/33404), Brad Hubbard)
-   common: skip interfaces starting with lo in
    find_ipv{4,6}\_in_subnet()
    ([pr#32420](https://github.com/ceph/ceph/pull/32420), Jiawei Li)
-   common: sort best-matched commond by req argument count
    ([issue#40292](http://tracker.ceph.com/issues/40292),
    [pr#28510](https://github.com/ceph/ceph/pull/28510), Chang Liu)
-   common: src/: remove execute permissions on nine source files
    ([pr#28781](https://github.com/ceph/ceph/pull/28781), J. Eric
    Ivancich)
-   common: start logging for non-global_init users
    ([pr#27352](https://github.com/ceph/ceph/pull/27352), Sage Weil)
-   common: systemd: Wait 5 seconds before attempting a restart of an
    OSD ([pr#31550](https://github.com/ceph/ceph/pull/31550), Wido den
    Hollander)
-   common: use of malloc.h is deprecated
    ([pr#29397](https://github.com/ceph/ceph/pull/29397), Willem Jan
    Withagen)
-   common: zstd: upgrade to v1.4.0
    ([pr#28656](https://github.com/ceph/ceph/pull/28656), Dan van der
    Ster)
-   core,mgr,tools: osd,tools: Balancer fixes without all of the
    calc_pg_upmaps() rewrites
    ([pr#31774](https://github.com/ceph/ceph/pull/31774), David Zafman)
-   core,mgr: mgr/ActivePyModules: drop GIL to register/unregister
    clients ([pr#33464](https://github.com/ceph/ceph/pull/33464), Sage
    Weil)
-   core,mgr: mgr/alerts: simple module to send health alerts
    ([pr#30738](https://github.com/ceph/ceph/pull/30738), Sage Weil)
-   core,mgr: mgr/DaemonServer: warn when we reject reports
    ([pr#31471](https://github.com/ceph/ceph/pull/31471), Sage Weil)
-   core,mgr: mgr/pg_autoscaler: add pg_autoscale_bias pool property and
    apply it to pg_num selection
    ([pr#27154](https://github.com/ceph/ceph/pull/27154), Sage Weil)
-   core,mgr: mgr/prometheus: report per-pool pg states
    ([pr#32370](https://github.com/ceph/ceph/pull/32370), Aleksei
    Zakharov)
-   core,mgr: mgr/telemetry: add report_timestamp to sent reports
    ([pr#27571](https://github.com/ceph/ceph/pull/27571), Dan Mick)
-   core,mgr: mgr/telemetry: catch exception during requests.put
    ([pr#33070](https://github.com/ceph/ceph/pull/33070), Sage Weil)
-   core,mgr: mgr/telemetry: obscure entity_name with a salt
    ([pr#29330](https://github.com/ceph/ceph/pull/29330), Sage Weil)
-   core,mgr: osd,mon,mgr: report /dev/disk/by-path paths for devices
    ([pr#32261](https://github.com/ceph/ceph/pull/32261), Sage Weil)
-   core,mon: mon,osd: use get_req\<\> instead of
    static_cast\<\>(get_req())
    ([pr#30023](https://github.com/ceph/ceph/pull/30023), Kefu Chai)
-   core,mon: mon/AuthMonitor: fix initial creation of rotating keys
    ([issue#40634](http://tracker.ceph.com/issues/40634),
    [pr#28850](https://github.com/ceph/ceph/pull/28850), Sage Weil)
-   core,mon: mon/MonClient: add proper SRV priority support
    ([pr#27126](https://github.com/ceph/ceph/pull/27126), Kefu Chai)
-   core,mon: mon/Monitor.cc: fix condition that checks for unrecognized
    auth mode ([pr#30015](https://github.com/ceph/ceph/pull/30015), Neha
    Ojha)
-   core,mon: mon/Monitor.cc: print min_mon_release correctly
    ([pr#27107](https://github.com/ceph/ceph/pull/27107), Neha Ojha)
-   core,mon: mon/OSDMonitor: clean up removed_snap keys
    ([pr#30518](https://github.com/ceph/ceph/pull/30518), Sage Weil)
-   core,mon: mon/OSDMonitor: expand iec_options for osd pool set
    ([pr#31196](https://github.com/ceph/ceph/pull/31196), Sage Weil)
-   core,mon: mon/OSDMonitor: Use generic priority cache tuner for mon
    caches ([issue#40870](http://tracker.ceph.com/issues/40870),
    [pr#28227](https://github.com/ceph/ceph/pull/28227), Sridhar
    Seshasayee)
-   core,pybind: pybind/ceph_argparse: avoid int overflow
    ([pr#33101](https://github.com/ceph/ceph/pull/33101), Kefu Chai)
-   core,pybind: pybind/rados: fix set_omap() crash on py3
    ([pr#29096](https://github.com/ceph/ceph/pull/29096), Sage Weil)
-   core,pybind: pybind/rados: fixed Python3 string conversion issue on
    get_fsid ([issue#38381](http://tracker.ceph.com/issues/38381),
    [pr#26514](https://github.com/ceph/ceph/pull/26514), Jason Dillaman)
-   core,rbd: common/config: use string_view for keys
    ([pr#27097](https://github.com/ceph/ceph/pull/27097), Kefu Chai)
-   core,rbd: osd/OSDCap: rbd profile permits use of rbd_info
    ([issue#39973](http://tracker.ceph.com/issues/39973),
    [pr#28253](https://github.com/ceph/ceph/pull/28253), songweibin)
-   core,rbd: osd/PrimaryLogPG: do not append outdata to TMAPUP ops
    ([pr#30457](https://github.com/ceph/ceph/pull/30457), Jason
    Dillaman)
-   core,rgw,tests: librados,test,rgw: cleanups to deprecate safe_cb
    related functions
    ([pr#31045](https://github.com/ceph/ceph/pull/31045), Kefu Chai)
-   core,tests: ceph_test_cls_hello: set RETURNVEC on the expected
    EINVAL request ([pr#33708](https://github.com/ceph/ceph/pull/33708),
    Sage Weil)
-   core,tests: ceph_test_rados_api\\\_{watch_notify,misc}: tolerate
    some timeouts ([pr#34011](https://github.com/ceph/ceph/pull/34011),
    Sage Weil)
-   core,tests: Improvements to standalone tests
    ([pr#27279](https://github.com/ceph/ceph/pull/27279), David Zafman)
-   core,tests: kv_store_bench: fix teuthology_tests() return value
    ([pr#30293](https://github.com/ceph/ceph/pull/30293), luo rixin)
-   core,tests: mon.test: improve validation and add a test for osd pool
    create ([pr#30538](https://github.com/ceph/ceph/pull/30538), Kefu
    Chai)
-   core,tests: qa/objectstore: test with reduced value of
    osd_memory_target
    ([pr#27083](https://github.com/ceph/ceph/pull/27083), Neha Ojha)
-   core,tests: qa/standalone/ceph-helpers: more osd debug
    ([issue#40666](http://tracker.ceph.com/issues/40666),
    [pr#28867](https://github.com/ceph/ceph/pull/28867), Sage Weil)
-   core,tests: qa/standalone/misc/ok-to-stop: improve test
    ([pr#32738](https://github.com/ceph/ceph/pull/32738), Sage Weil)
-   core,tests: qa/standalone/mon/health-mute.sh: misc fixes
    ([pr#29744](https://github.com/ceph/ceph/pull/29744), Sage Weil)
-   core,tests: qa/standalone/osd/osd-backfill-recovery-log.sh: fix
    TEST_backfill_log\\\_\[1, 2\]
    ([pr#32851](https://github.com/ceph/ceph/pull/32851), Neha Ojha)
-   core,tests: qa/standalone/scrub/osd-scrub-snaps: snapmapper omap is
    now m ([pr#29774](https://github.com/ceph/ceph/pull/29774), Sage
    Weil)
-   core,tests: qa/standalone/scrub/osd-scrub-test: wait longer for
    update ([pr#33809](https://github.com/ceph/ceph/pull/33809), Sage
    Weil)
-   core,tests: qa/suites/rados/multimon: whitelist SLOW_OPS while
    thrashing mons ([pr#29121](https://github.com/ceph/ceph/pull/29121),
    Sage Weil)
-   core,tests: qa/suites/rados/perf: run on ubuntu
    ([pr#32355](https://github.com/ceph/ceph/pull/32355), Sage Weil)
-   core,tests: qa/suites/rados/rest: run restful test on el8
    ([pr#32920](https://github.com/ceph/ceph/pull/32920), Sage Weil)
-   core,tests: qa/suites/rados/singleton-bluestore/cephtool: whitelist
    MON_DOWN ([pr#33645](https://github.com/ceph/ceph/pull/33645), Sage
    Weil)
-   core,tests: qa/suites/rados/singleton/all/lost-unfound\\\*:
    whitelist SLOW_OPS
    ([pr#32958](https://github.com/ceph/ceph/pull/32958), Sage Weil)
-   core,tests: qa/suites/rados/singleton/all/recovery-preemption: fix
    pg log length ([pr#32898](https://github.com/ceph/ceph/pull/32898),
    Sage Weil)
-   core,tests: qa/suites/rados/singleton/all/thrash-eio: whitelist slow
    request ([pr#33497](https://github.com/ceph/ceph/pull/33497), Sage
    Weil, Sridhar Seshasayee)
-   core,tests: qa/suites/rados/thrash-old-clients: exclude ceph-daemon
    on nautilus installs
    ([pr#30817](https://github.com/ceph/ceph/pull/30817), Sage Weil)
-   core,tests: qa/suites/rados/thrash-old-clients: rejigger v1 vs v2
    settings ([pr#27249](https://github.com/ceph/ceph/pull/27249), Sage
    Weil)
-   core,tests: qa/suites/rados/thrash-old-clients: tolerate MON_DOWN
    ([pr#30577](https://github.com/ceph/ceph/pull/30577), Sage Weil)
-   core,tests: qa/suites/rados/thrash-old-clients: use cephadm
    ([pr#32377](https://github.com/ceph/ceph/pull/32377), Sage Weil)
-   core,tests: qa/suites/rados/thrash: force normal pg log length with
    cache tiering ([issue#38358](http://tracker.ceph.com/issues/38358),
    [issue#24320](http://tracker.ceph.com/issues/24320),
    [pr#28658](https://github.com/ceph/ceph/pull/28658), Sage Weil)
-   core,tests: qa/suites/rados/thrash: increase async and partial
    recovery test coverage
    ([pr#30699](https://github.com/ceph/ceph/pull/30699), Neha Ojha)
-   core,tests: qa/suites/rados/valgrind-leaks: independently verify we
    detect leaks on mon, osd, mgr
    ([pr#32946](https://github.com/ceph/ceph/pull/32946), Sage Weil)
-   core,tests: qa/suites/rados/verify/tasks/mon_recovery: whitelist
    SLOW_OPS ([pr#33644](https://github.com/ceph/ceph/pull/33644), Sage
    Weil)
-   core,tests: qa/suites/rados/verify: debug monc = 20
    ([pr#32968](https://github.com/ceph/ceph/pull/32968), Sage Weil)
-   core,tests: qa/suites/rados/verify: debug_ms = 1
    ([pr#33871](https://github.com/ceph/ceph/pull/33871), Sage Weil)
-   core,tests: qa/suites/rados: move cephadm_orchestrator to el8
    ([pr#32407](https://github.com/ceph/ceph/pull/32407), Sage Weil)
-   core,tests: qa/suites/upgrade/mimic-x-singleton: suppress
    TOO_FEW_PGS warning
    ([pr#31054](https://github.com/ceph/ceph/pull/31054), Sage Weil)
-   core,tests: qa/suites/upgrade: fix mimic-x-singleton
    ([pr#32719](https://github.com/ceph/ceph/pull/32719), Sage Weil)
-   core,tests: qa/suites/upgrade: misc fixes for octopus
    ([pr#32750](https://github.com/ceph/ceph/pull/32750), Sage Weil,
    Josh Durgin)
-   core,tests: qa/tasks/cbt: run stop-all.sh while shutting down
    ([pr#31171](https://github.com/ceph/ceph/pull/31171), Sage Weil)
-   core,tests: qa/tasks/ceph: restart: stop osd, mark down, then start
    ([pr#30196](https://github.com/ceph/ceph/pull/30196), Sage Weil)
-   core,tests: qa/tasks/ceph_manager: add \--log-early to
    raw_cluster_cmd
    ([pr#32989](https://github.com/ceph/ceph/pull/32989), Sage Weil)
-   core,tests: qa/tasks/ceph_manager: enable ceph-objectstore-tool via
    cephadm ([pr#32411](https://github.com/ceph/ceph/pull/32411), Sage
    Weil)
-   core,tests: qa/tasks/ceph_manager: fix ceph-objectstore-tool
    incantations ([pr#32701](https://github.com/ceph/ceph/pull/32701),
    Sage Weil)
-   core,tests: qa/tasks/ceph_manager: fix chmod on log dir during pg
    export copy ([pr#32943](https://github.com/ceph/ceph/pull/32943),
    Sage Weil)
-   core,tests: qa/tasks/ceph_manager: fix post-osd-kill pg peered check
    ([pr#32737](https://github.com/ceph/ceph/pull/32737), Sage Weil)
-   core,tests: qa/tasks/ceph_manager: make
    is\\\_{clean,recovered,active_or_down} less racy
    ([pr#28969](https://github.com/ceph/ceph/pull/28969), Sage Weil)
-   core,tests: qa/tasks/mon_thrash: sync force requires some force
    flags ([pr#30361](https://github.com/ceph/ceph/pull/30361), Sage
    Weil)
-   core,tests: qa/tasks/radosbench: fix usage of -O
    ([pr#33744](https://github.com/ceph/ceph/pull/33744), Sage Weil)
-   core,tests: qa/tasks/thrashosds-health: disable osd_max_markdown
    behavior ([pr#33601](https://github.com/ceph/ceph/pull/33601), Sage
    Weil)
-   core,tests: qa/workunits/cephtool/test.sh: delete test_erasure pool
    ([pr#33188](https://github.com/ceph/ceph/pull/33188), Sage Weil)
-   core,tests: qa/workunits/rados/test_crash.sh: suppress core files
    ([pr#32724](https://github.com/ceph/ceph/pull/32724), Sage Weil)
-   core,tests: qa: add basic omap testing capability
    ([pr#29120](https://github.com/ceph/ceph/pull/29120), Neha Ojha)
-   core,tests: remove ceph_test_rados_watch_notify
    ([pr#34044](https://github.com/ceph/ceph/pull/34044), Sage Weil)
-   core,tests: test/CMakeLists: disable memstore make check test
    ([pr#33473](https://github.com/ceph/ceph/pull/33473), Sage Weil)
-   core,tests: test/librados: dont release handler if set_pg_num failed
    ([pr#32112](https://github.com/ceph/ceph/pull/32112), huangjun)
-   core,tests: test/osd/safe-to-destroy.sh: fix typo
    ([pr#27651](https://github.com/ceph/ceph/pull/27651), Sage Weil)
-   core,tests: test/pybind/test_rados.py: test test_aio_remove
    ([pr#31003](https://github.com/ceph/ceph/pull/31003), Zhang Jiao)
-   core,tests: test/unittest_lockdep: do not start extra threads
    ([pr#32772](https://github.com/ceph/ceph/pull/32772), Kefu Chai)
-   core,tests: test: Bump sleep time for slower machines
    ([pr#29494](https://github.com/ceph/ceph/pull/29494), David Zafman)
-   core,tests: test: Make sure that extra scheduled scrubs dont confuse
    test ([issue#40078](http://tracker.ceph.com/issues/40078),
    [pr#28302](https://github.com/ceph/ceph/pull/28302), David Zafman)
-   core,tests: tests/osd: fix typo in unittest_osdmap
    ([pr#29790](https://github.com/ceph/ceph/pull/29790), huangjun)
-   core,tests: tools/rados: use num ops instead of num objs for
    tracking outstanding IO
    ([pr#29734](https://github.com/ceph/ceph/pull/29734), Albert H Chen)
-   core,tests: unittest_lockdep: avoid any threads for death test
    ([pr#32765](https://github.com/ceph/ceph/pull/32765), Sage Weil)
-   core,tools: ceph-objectstore-tool cant remove head with bad snapset
    ([pr#29919](https://github.com/ceph/ceph/pull/29919), David Zafman)
-   core,tools: ceph.in: check ceph-conf returncode
    ([pr#30695](https://github.com/ceph/ceph/pull/30695), Dimitri
    Savineau)
-   core,tools: src/tools/ceph-dedup-tool: Fix chunk scru
    ([pr#28765](https://github.com/ceph/ceph/pull/28765), Myoungwon Oh)
-   core: ceph.in: only preload asan library for Debug build
    ([pr#27190](https://github.com/ceph/ceph/pull/27190), Kefu Chai)
-   core: osd/ClassHandler: cleanups
    ([pr#28363](https://github.com/ceph/ceph/pull/28363), Kefu Chai)
-   core: osd: add hdd, ssd and hybrid variants for osd_snap_trim_sleep
    ([pr#28772](https://github.com/ceph/ceph/pull/28772), Neha Ojha)
-   core: osdc/Objecter: use unique_ptr\<OSDMap\> for Objecter::osdmap
    ([issue#38403](http://tracker.ceph.com/issues/38403),
    [pr#28397](https://github.com/ceph/ceph/pull/28397), Kefu Chai)
-   core: Add structures for tracking in progress operations
    ([pr#28395](https://github.com/ceph/ceph/pull/28395), Samuel Just)
-   core: auth: treat mgr the same as mon when selecting auth mode
    ([pr#33226](https://github.com/ceph/ceph/pull/33226), Yehuda Sadeh)
-   core: backfill_toofull seen on cluster where the most full OSD is at
    1% ([pr#29857](https://github.com/ceph/ceph/pull/29857), David
    Zafman)
-   core: ceph,pybind/mgr: a few py3 fixes
    ([pr#32187](https://github.com/ceph/ceph/pull/32187), Sage Weil)
-   core: ceph-objectstore-tool: better error message if pgid and object
    do not match ([pr#30501](https://github.com/ceph/ceph/pull/30501),
    Sage Weil)
-   core: ceph.in: Fix name retval is not defined error
    ([pr#33516](https://github.com/ceph/ceph/pull/33516), Varsha Rao)
-   core: ceph.in: improve control-c handling
    ([pr#33352](https://github.com/ceph/ceph/pull/33352), Sage Weil)
-   core: ceph.in: only shut down rados on clean exit
    ([pr#33825](https://github.com/ceph/ceph/pull/33825), Sage Weil)
-   core: client: fix FTBFS due to bl::iterator::advance()
    ([pr#33085](https://github.com/ceph/ceph/pull/33085), Radoslaw
    Zarzynski)
-   core: cls_hello: fix typo
    ([pr#32976](https://github.com/ceph/ceph/pull/32976), Sage Weil)
-   core: common,mon,osd: unify ceph tell and ceph daemon command sets
    ([pr#30217](https://github.com/ceph/ceph/pull/30217), Sage Weil)
-   core: common,tools,crush,test: misc converity & klocwork fixes
    ([pr#29316](https://github.com/ceph/ceph/pull/29316), songweibin)
-   core: common/admin_socket: Increase socket timeouts
    ([pr#31623](https://github.com/ceph/ceph/pull/31623), Brad Hubbard)
-   core: common/assert: include ceph_abort_msg(arg) arg in log output
    ([pr#27732](https://github.com/ceph/ceph/pull/27732), Sage Weil)
-   core: common/blkdev: fix some problems with smart scraping
    ([pr#28848](https://github.com/ceph/ceph/pull/28848), Sage Weil)
-   core: common/blkdev: get_device_id: behave if model is lvm and
    id_model_enc isnt there
    ([pr#27156](https://github.com/ceph/ceph/pull/27156), Sage Weil)
-   core: common/blkdev: handle devices with ID_MODEL as LVM PV \... but
    valid ID_MODEL_ENC
    ([pr#27020](https://github.com/ceph/ceph/pull/27020), Sage Weil)
-   core: common/condition_variable_debug: do not assert() if sloppy
    ([pr#29854](https://github.com/ceph/ceph/pull/29854), Kefu Chai)
-   core: common/config: behave when both POD_MEMORY_REQUEST and
    POD_MEMORY_LIMIT are set
    ([pr#29511](https://github.com/ceph/ceph/pull/29511), Sage Weil)
-   core: common/config: less noise about configs from mon we cant apply
    ([pr#31988](https://github.com/ceph/ceph/pull/31988), Sage Weil)
-   core: common/config: parse \--default-\$option as a default value
    ([pr#27169](https://github.com/ceph/ceph/pull/27169), Sage Weil)
-   core: common/config: update values when they are removed via mon
    ([pr#32091](https://github.com/ceph/ceph/pull/32091), Sage Weil)
-   core: common/kv/rocksdb: Fixed async compations
    ([pr#26786](https://github.com/ceph/ceph/pull/26786), Adam Kupczyk)
-   core: common/options.cc: Lower the default value of
    osd_deep_scrub_large_omap_object_key_threshold
    ([pr#28782](https://github.com/ceph/ceph/pull/28782), Neha Ojha)
-   core: common/options.cc: make rocksdb_delete_range_threshold very
    high ([pr#33439](https://github.com/ceph/ceph/pull/33439), Neha
    Ojha)
-   core: common/options: allow osd_pool_default_pg_autoscale_mode to
    update a runtime
    ([pr#27821](https://github.com/ceph/ceph/pull/27821), Sage Weil)
-   core: common/options: annotate some options; enable some runtime
    updates ([pr#27655](https://github.com/ceph/ceph/pull/27655), Sage
    Weil)
-   core: common/options: decrease the default
    max_omap_entries_per_request
    ([pr#31506](https://github.com/ceph/ceph/pull/31506), Yan Jun)
-   core: common/options: make secure mode non-experimental, and
    prefer/require it for mons
    ([pr#27012](https://github.com/ceph/ceph/pull/27012), Sage Weil)
-   core: common/options: update mon_crush_min_required_version=hammer
    ([pr#27568](https://github.com/ceph/ceph/pull/27568), Sage Weil)
-   core: common/PriorityCache: fix over-aggressive assert when mem
    limited ([pr#27763](https://github.com/ceph/ceph/pull/27763), Mark
    Nelson)
-   core: common/PriorityCache: Implement a Cache Manager
    ([pr#27381](https://github.com/ceph/ceph/pull/27381), Mark Nelson)
-   core: common/TextTable,mgr: standardize on 2 spaces between table
    columns ([pr#33138](https://github.com/ceph/ceph/pull/33138), Sage
    Weil)
-   core: common/util: handle long lines in /proc/cpuinfo
    ([issue#38296](http://tracker.ceph.com/issues/38296),
    [pr#27707](https://github.com/ceph/ceph/pull/27707), Sage Weil)
-   core: compressor/lz4: work around bug in liblz4 versions \<1.8.2
    ([pr#33584](https://github.com/ceph/ceph/pull/33584), Sage Weil, Dan
    van der Ster)
-   core: crimson, osd: add support for Ceph Classes, part 1
    ([pr#29651](https://github.com/ceph/ceph/pull/29651), Radoslaw
    Zarzynski)
-   core: crimson/osd: add osd to crush when it boots
    ([pr#28689](https://github.com/ceph/ceph/pull/28689), Kefu Chai)
-   core: crush/CrushCompiler: Fix \_\_replacement_assert
    ([issue#39174](http://tracker.ceph.com/issues/39174),
    [pr#27506](https://github.com/ceph/ceph/pull/27506), Brad Hubbard)
-   core: crush/CrushWrapper.cc: Fix sign compare compiler warning
    ([pr#31184](https://github.com/ceph/ceph/pull/31184), Prashant D)
-   core: crush/CrushWrapper: behave with empty weight vector
    ([pr#32673](https://github.com/ceph/ceph/pull/32673), Kefu Chai)
-   core: dencoder: include some missed types
    ([pr#27804](https://github.com/ceph/ceph/pull/27804), Greg Farnum)
-   core: dmclock server side refactor
    ([pr#30650](https://github.com/ceph/ceph/pull/30650), Samuel Just)
-   core: examples/librados: fix bufferlist::copy() in hello_world.cc
    ([pr#33075](https://github.com/ceph/ceph/pull/33075), Radoslaw
    Zarzynski)
-   core: Extract peering logic into a module for use in crimson
    ([pr#27874](https://github.com/ceph/ceph/pull/27874), Samuel Just,
    <sjust@redhat.com>)
-   core: feature: Health warnings on long network ping times, add
    dump_osd_network to get a report
    ([issue#40640](http://tracker.ceph.com/issues/40640),
    [pr#28755](https://github.com/ceph/ceph/pull/28755), David Zafman)
-   core: Feature: Improvements to auto repair
    ([issue#38616](http://tracker.ceph.com/issues/38616),
    [pr#26942](https://github.com/ceph/ceph/pull/26942), David Zafman)
-   core: global: ensure CEPH_ARGS is decoded before early arg
    processing ([pr#32830](https://github.com/ceph/ceph/pull/32830),
    Jason Dillaman)
-   core: global: explicitly call out EIO events in crash dumps
    ([pr#27386](https://github.com/ceph/ceph/pull/27386), Sage Weil)
-   core: include,os: Make ceph_le member private
    ([pr#30526](https://github.com/ceph/ceph/pull/30526), Ulrich
    Weigand)
-   core: include/ceph_features: fix typo
    ([pr#27353](https://github.com/ceph/ceph/pull/27353), Sage Weil)
-   core: include/cpp-btree: cleanups
    ([pr#32443](https://github.com/ceph/ceph/pull/32443), Kefu Chai)
-   core: init-ceph: wait longer before resending \$signal
    ([pr#27308](https://github.com/ceph/ceph/pull/27308), Kefu Chai)
-   core: kv/KeyValueDB: fix estimate_prefix_size()
    ([pr#29842](https://github.com/ceph/ceph/pull/29842), Adam Kupczyk)
-   core: kv/RocksDBStore: Add minimum key limit before invoking
    DeleteRange ([pr#31442](https://github.com/ceph/ceph/pull/31442),
    Mark Nelson)
-   core: kv/RocksDBStore: make option:
    compaction_threads/disableWAL/flusher_txe2x80xa6
    ([pr#32453](https://github.com/ceph/ceph/pull/32453), Jianpeng Ma)
-   core: kv/RocksDBStore: tell rocksdb to set mode to 0600, not 0644
    ([pr#30679](https://github.com/ceph/ceph/pull/30679), Sage Weil)
-   core: kv: fix shutdown vs async compaction
    ([pr#32619](https://github.com/ceph/ceph/pull/32619), Sage Weil)
-   core: kv: make delete range optional on number of keys
    ([pr#27317](https://github.com/ceph/ceph/pull/27317), Zengran Zhang)
-   core: librados,osd,mon: remove traces of CEPH_OSDMAP_FULL
    ([pr#30614](https://github.com/ceph/ceph/pull/30614), Kefu Chai)
-   core: Make dumping of reservation info congruent between scrub and
    recovery ([pr#30192](https://github.com/ceph/ceph/pull/30192), David
    Zafman)
-   core: messages,osd: remove MPGStats::had_map_for
    ([pr#27026](https://github.com/ceph/ceph/pull/27026), Kefu Chai)
-   core: messages: #include necessary header
    ([pr#27590](https://github.com/ceph/ceph/pull/27590), Kefu Chai)
-   core: mgr/balancer: sort pool names in balancer ls output
    ([pr#32424](https://github.com/ceph/ceph/pull/32424), Sage Weil)
-   core: mgr/balancer: tolerate pgs outside of target weight map
    ([pr#34014](https://github.com/ceph/ceph/pull/34014), Sage Weil)
-   core: mgr/cephadm: health alert for stray services or hosts
    ([pr#32754](https://github.com/ceph/ceph/pull/32754), Sage Weil)
-   core: mgr/crash: behave when posted crash has no backtrace
    ([pr#31643](https://github.com/ceph/ceph/pull/31643), Sage Weil)
-   core: mgr/crash: raise warning about recent crashes and other
    improvements ([pr#29034](https://github.com/ceph/ceph/pull/29034),
    Sage Weil)
-   core: mgr/DaemonServer: fix osd ok-to-stop for EC pools
    ([pr#32046](https://github.com/ceph/ceph/pull/32046), Sage Weil)
-   core: mgr/DaemonServer: fix pg merge checks
    ([pr#34067](https://github.com/ceph/ceph/pull/34067), Sage Weil)
-   core: mgr/DaemonServer: prevent pgp_num reductions from outpacing
    pg_num merges ([issue#38786](http://tracker.ceph.com/issues/38786),
    [pr#27473](https://github.com/ceph/ceph/pull/27473), Sage Weil)
-   core: mgr/devicehealth: fix telemetry stops sending device reports
    after 48xe2x80xa6
    ([pr#32903](https://github.com/ceph/ceph/pull/32903), Yaarit Hatuka)
-   core: mgr/diskprediction_cloud: Service unavailable
    ([issue#40478](http://tracker.ceph.com/issues/40478),
    [pr#28687](https://github.com/ceph/ceph/pull/28687), Rick Chen)
-   core: mgr/diskprediction_local: import scipy early to fix self-test
    deadlock ([pr#32102](https://github.com/ceph/ceph/pull/32102), Sage
    Weil)
-   core: mgr/diskprediction_local: some debug output during predict
    (and self-test)
    ([pr#31572](https://github.com/ceph/ceph/pull/31572), Sage Weil)
-   core: mgr/MgrClient: fix open condition
    ([pr#31256](https://github.com/ceph/ceph/pull/31256), Sage Weil)
-   core: mgr/MgrClient: fix open condition fix
    ([pr#31422](https://github.com/ceph/ceph/pull/31422), Sage Weil)
-   core: mgr/MgrClient: fix tell mgr.x \...
    ([pr#31989](https://github.com/ceph/ceph/pull/31989), Sage Weil)
-   core: mgr/pg_autoscaler: complete event if pool disappears
    ([pr#30819](https://github.com/ceph/ceph/pull/30819), Sage Weil)
-   core: mgr/pg_autoscaler: default to pg_num\[\_min\] = 16
    ([pr#31636](https://github.com/ceph/ceph/pull/31636), Sage Weil)
-   core: mgr/pg_autoscaler: default to pg_num\[\_min\] = 32
    ([pr#32788](https://github.com/ceph/ceph/pull/32788), Neha Ojha)
-   core: mgr/pg_autoscaler: fix division by zero
    ([pr#33402](https://github.com/ceph/ceph/pull/33402), Sage Weil)
-   core: mgr/pg_autoscaler: only generate target\\\_\\\* health
    warnings if targets set
    ([pr#31638](https://github.com/ceph/ceph/pull/31638), Sage Weil)
-   core: mgr/progress: behave if pgs disappear (due to a racing pg
    merge) ([issue#38157](http://tracker.ceph.com/issues/38157),
    [pr#27546](https://github.com/ceph/ceph/pull/27546), Sage Weil)
-   core: mgr/progress: fix duration strings
    ([pr#34045](https://github.com/ceph/ceph/pull/34045), Sage Weil)
-   core: mgr/progress: progress clear command should clear events in
    ceph -s ([pr#33400](https://github.com/ceph/ceph/pull/33400), Sage
    Weil)
-   core: mgr/telemetry: add some more telemetry
    ([pr#31226](https://github.com/ceph/ceph/pull/31226), Sage Weil)
-   core: mgr/telemetry: include pg_autoscaler and balancer status
    ([pr#30871](https://github.com/ceph/ceph/pull/30871), Sage Weil)
-   core: mgr/telemetry: send device telemetry via per-host POST to
    device endpoint
    ([pr#31225](https://github.com/ceph/ceph/pull/31225), Sage Weil)
-   core: mgr/telemetry: split entity_name only once (handle ids with
    dots) ([pr#33094](https://github.com/ceph/ceph/pull/33094), Dan
    Mick)
-   core: Miscellaneous lost fixes
    ([pr#27599](https://github.com/ceph/ceph/pull/27599), Xinze Chi,
    Greg Farnum, linbing, shangfufei)
-   core: mon, osd: parallel clean_pg_upmaps
    ([issue#40104](http://tracker.ceph.com/issues/40104),
    [pr#28373](https://github.com/ceph/ceph/pull/28373), xie xingguo)
-   core: mon,msg/async: fix mon to mon authentication
    ([pr#27823](https://github.com/ceph/ceph/pull/27823), Sage Weil)
-   core: mon,osd: add dead_epoch, \--dead flag to osd down
    ([pr#29221](https://github.com/ceph/ceph/pull/29221), Sage Weil)
-   core: mon,osd: add no{out,down,in,out} flags on CRUSH nodes
    ([pr#27563](https://github.com/ceph/ceph/pull/27563), Sage Weil)
-   core: mon,osd: deprecate forward and readforward cache modes
    ([pr#28944](https://github.com/ceph/ceph/pull/28944), Sage Weil)
-   core: mon,osd: track history and past_intervals for creating pgs
    ([pr#27696](https://github.com/ceph/ceph/pull/27696), Sage Weil)
-   core: mon,osd: various octopus feature bits
    ([pr#27141](https://github.com/ceph/ceph/pull/27141), Sage Weil)
-   core: mon/ConfigMap: search nested sections
    ([pr#31327](https://github.com/ceph/ceph/pull/31327), Sage Weil)
-   core: mon/ConfigMonitor: fix handling of NO_MON_UPDATE settings
    ([pr#32726](https://github.com/ceph/ceph/pull/32726), Sage Weil)
-   core: mon/ConfigMonitor: only propose if leader
    ([pr#32975](https://github.com/ceph/ceph/pull/32975), Sage Weil)
-   core: mon/ConfigMonitor: prefix all global config options with
    global/ ([pr#32786](https://github.com/ceph/ceph/pull/32786), Sage
    Weil)
-   core: mon/LogMonitor: add mon_cluster_log_to_file bool option
    ([pr#27343](https://github.com/ceph/ceph/pull/27343), Sage Weil)
-   core: mon/MgrMonitor: fix null deref when invalid formatter is
    specified ([pr#29089](https://github.com/ceph/ceph/pull/29089), Sage
    Weil)
-   core: mon/MgrMonitor: make mgr fail work with no arguments
    ([pr#33997](https://github.com/ceph/ceph/pull/33997), Sage Weil)
-   core: mon/MgrStatMonitor: ensure only one copy of initial service
    map ([issue#38839](http://tracker.ceph.com/issues/38839),
    [pr#27101](https://github.com/ceph/ceph/pull/27101), Sage Weil)
-   core: mon/MonClient: do not dereference auth_supported.end()
    ([pr#27196](https://github.com/ceph/ceph/pull/27196), Kefu Chai)
-   core: mon/MonClient: ENXIO when sending command to down mon
    ([pr#29090](https://github.com/ceph/ceph/pull/29090), Sage Weil,
    Greg Farnum)
-   core: mon/MonClient: send logs to mon on separate schedule than
    pings ([pr#33732](https://github.com/ceph/ceph/pull/33732), Sage
    Weil)
-   core: mon/MonClient: skip CEPHX_V2 challenge if client doesnt
    support it ([pr#30523](https://github.com/ceph/ceph/pull/30523),
    Sage Weil)
-   core: mon/Monitor: fail forwarded tell commands
    ([pr#33542](https://github.com/ceph/ceph/pull/33542), Sage Weil)
-   core: mon/MonMap: encode (more) valid compat monmap when we have
    v2-only addrs ([pr#31472](https://github.com/ceph/ceph/pull/31472),
    Sage Weil)
-   core: mon/MonmapMonitor: clean up empty created stamp in monmap
    ([issue#39085](http://tracker.ceph.com/issues/39085),
    [pr#27327](https://github.com/ceph/ceph/pull/27327), Sage Weil)
-   core: mon/OSDMonitor.cc: Add current numbers of objects and bytes
    ([pr#18694](https://github.com/ceph/ceph/pull/18694), Shinobu Kinjo)
-   core: mon/OSDMonitor.cc: better error message about min_size
    ([pr#29184](https://github.com/ceph/ceph/pull/29184), Neha Ojha)
-   core: mon/OSDMonitor: accept autoscale_mode argument to osd pool
    create ([pr#33092](https://github.com/ceph/ceph/pull/33092), Sage
    Weil)
-   core: mon/OSDMonitor: add check for crush rule size in pool set size
    command ([pr#30723](https://github.com/ceph/ceph/pull/30723),
    Vikhyat Umrao)
-   core: mon/OSDMonitor: allow osd pool set pgp_num_actual
    ([pr#27010](https://github.com/ceph/ceph/pull/27010), Sage Weil)
-   core: mon/OSDMonitor: allow pg_num to increase when
    require_osd_release \< N
    ([issue#39570](http://tracker.ceph.com/issues/39570),
    [pr#27928](https://github.com/ceph/ceph/pull/27928), Sage Weil)
-   core: mon/OSDMonitor: Dont update mon cache settings if rocksdb is
    not used ([pr#32473](https://github.com/ceph/ceph/pull/32473),
    Sridhar Seshasayee)
-   core: mon/OSDMonitor: fix format error ceph osd stat \--format json
    ([pr#31399](https://github.com/ceph/ceph/pull/31399), Zheng Yin)
-   core: mon/OSDMonitor: make memory autotune disable itself if no
    rocksd ([pr#32044](https://github.com/ceph/ceph/pull/32044), Sage
    Weil)
-   core: mon/OSDMonitor: tolerate duplicate MRemoveSnaps messages
    ([issue#40774](http://tracker.ceph.com/issues/40774),
    [pr#29051](https://github.com/ceph/ceph/pull/29051), Sage Weil)
-   core: mon/PGMap.h: disable network stats in dump_osd_stats
    ([pr#32406](https://github.com/ceph/ceph/pull/32406), Neha Ojha,
    David Zafman)
-   core: mon/PGMap: drop indentation on df human output
    ([pr#30848](https://github.com/ceph/ceph/pull/30848), Sage Weil)
-   core: mon/PGMap: fix summary display of \>32bit pg states
    ([pr#33137](https://github.com/ceph/ceph/pull/33137), Sage Weil)
-   core: mon/PGMap: use NONE for pg ls\[-\\\*\] output too
    ([pr#32048](https://github.com/ceph/ceph/pull/32048), Sage Weil)
-   core: mon/Session: only index osd ids \>= 0
    ([pr#32764](https://github.com/ceph/ceph/pull/32764), Sage Weil)
-   core: More PeeringState and related cleanups to ease use in crimson
    ([pr#28048](https://github.com/ceph/ceph/pull/28048), Samuel Just)
-   core: msg,auth: migrate msg/async V1 implementation to new
    Auth{Server,Client} interfaces
    ([pr#27566](https://github.com/ceph/ceph/pull/27566), Sage Weil)
-   core: msg/async/frames_v2.h: fix warning
    ([pr#27464](https://github.com/ceph/ceph/pull/27464), Sage Weil)
-   core: msg/async/ProtocolV2: fix typo in register_lossy_clients fix
    ([pr#33559](https://github.com/ceph/ceph/pull/33559), Sage Weil)
-   core: msg/async/ProtocolV\[12\]: add ms_learn_addr_from_peer
    ([pr#27341](https://github.com/ceph/ceph/pull/27341), Sage Weil)
-   core: msg/async: clear_payload when requeue_sent
    ([pr#30211](https://github.com/ceph/ceph/pull/30211), Jianpeng Ma)
-   core: msg/async: optimizations
    ([pr#26531](https://github.com/ceph/ceph/pull/26531), Jianpeng Ma)
-   core: msg/auth: handle decode errors instead of throwing exceptions
    ([pr#31052](https://github.com/ceph/ceph/pull/31052), Sage Weil)
-   core: msg/DispatchQueue: Set throttle stamp for local_delivery
    ([pr#31137](https://github.com/ceph/ceph/pull/31137), Brad Hubbard)
-   core: msg/Policy: limit unregistered anon connections to mon
    ([pr#33163](https://github.com/ceph/ceph/pull/33163), Sage Weil)
-   core: msg/Policy: make stateless_server default to anon (again)
    ([pr#33633](https://github.com/ceph/ceph/pull/33633), Sage Weil)
-   core: objclass, osd: clean up the cls-host interface. Turn
    ClassHandler into singleton
    ([pr#29322](https://github.com/ceph/ceph/pull/29322), Radoslaw
    Zarzynski)
-   core: object_stat_sum_t decode broken if given older version
    ([issue#39284](http://tracker.ceph.com/issues/39284),
    [issue#39281](http://tracker.ceph.com/issues/39281),
    [pr#27564](https://github.com/ceph/ceph/pull/27564), David Zafman)
-   core: os, osd: readv
    ([pr#30061](https://github.com/ceph/ceph/pull/30061), xie xingguo)
-   core: os/bluestore: Add config observer for osd memory specific
    options ([pr#29606](https://github.com/ceph/ceph/pull/29606),
    Sridhar Seshasayee)
-   core: os/filestore: assure sufficient leaves in pre-split
    ([issue#39390](http://tracker.ceph.com/issues/39390),
    [pr#27689](https://github.com/ceph/ceph/pull/27689), Jeegn Chen)
-   core: os/Transaction: dump alloc hint flags in op
    ([pr#28881](https://github.com/ceph/ceph/pull/28881), Zengran Zhang)
-   core: os: remove KineticStore
    ([pr#30653](https://github.com/ceph/ceph/pull/30653), Kefu Chai)
-   core: osd,crimson: use make_message for creating message
    ([pr#30412](https://github.com/ceph/ceph/pull/30412), Kefu Chai)
-   core: osd,messages: changes for preparing for crimson-osd
    ([pr#27003](https://github.com/ceph/ceph/pull/27003), Kefu Chai)
-   core: osd,mon: remove pg_pool_t::removed_snaps
    ([pr#28330](https://github.com/ceph/ceph/pull/28330), Sage Weil)
-   core: osd/ECTransaction,ReplicatedBackend: create op is new in
    octopus ([pr#29092](https://github.com/ceph/ceph/pull/29092), Sage
    Weil)
-   core: osd/MissingLoc, PeeringState: remove osd from missing loc in
    purge_strays() ([pr#30119](https://github.com/ceph/ceph/pull/30119),
    Neha Ojha)
-   core: osd/MissingLoc.cc: do not rely on missing_loc_sources only
    ([pr#30226](https://github.com/ceph/ceph/pull/30226), Neha Ojha)
-   core: osd/OSD.cc: make osd bench description consistent with
    parameters ([issue#39006](http://tracker.ceph.com/issues/39006),
    [pr#27600](https://github.com/ceph/ceph/pull/27600), Neha Ojha)
-   core: osd/osd: add an err log to set_numa_affinty
    ([pr#30870](https://github.com/ceph/ceph/pull/30870), luo rixin)
-   core: osd/OSD: auto mark heartbeat sessions as stale and tear them
    down ([issue#40586](http://tracker.ceph.com/issues/40586),
    [pr#28752](https://github.com/ceph/ceph/pull/28752), xie xingguo)
-   core: osd/OSD: choose more heartbeat peers from different subtrees
    ([pr#33037](https://github.com/ceph/ceph/pull/33037), xie xingguo)
-   core: osd/OSD: enhance osd numa affinity compatibility
    ([pr#31274](https://github.com/ceph/ceph/pull/31274), Dai zhiwei)
-   core: osd/OSD: keep synchronizing with mon if stuck at booting
    ([pr#28404](https://github.com/ceph/ceph/pull/28404), xie xingguo)
-   core: osd/OSD: Log slow ops/types to cluster logs
    ([pr#33328](https://github.com/ceph/ceph/pull/33328), Sridhar
    Seshasayee)
-   core: osd/OSD: only wake up empty pqueue
    ([pr#28832](https://github.com/ceph/ceph/pull/28832), Jianpeng Ma)
-   core: osd/OSD: prevent down osds from immediately rejoining the
    culster ([pr#33039](https://github.com/ceph/ceph/pull/33039), xie
    xingguo)
-   core: osd/osd: Refactor get_iface_numa_node
    ([pr#31965](https://github.com/ceph/ceph/pull/31965), Dai zhiwei,
    luo rixin)
-   core: osd/OSD: remove unused func enqueue_peering_evt_front
    ([pr#32496](https://github.com/ceph/ceph/pull/32496), Jianpeng Ma)
-   core: osd/OSD: remove unused parameter osdmap_lock_name
    ([pr#32514](https://github.com/ceph/ceph/pull/32514), Jianpeng Ma)
-   core: osd/OSDCap: Check for empty namespace
    ([issue#40835](http://tracker.ceph.com/issues/40835),
    [pr#29146](https://github.com/ceph/ceph/pull/29146), Brad Hubbard)
-   core: osd/OSDMap.cc: add more info in json output of osd stat
    ([pr#30344](https://github.com/ceph/ceph/pull/30344), Shen Hang)
-   core: osd/OSDMap.cc: dont output over/underfull messages to lderr
    ([pr#31542](https://github.com/ceph/ceph/pull/31542), Neha Ojha)
-   core: osd/OSDMap: add zone to default crush map
    ([pr#27070](https://github.com/ceph/ceph/pull/27070), Sage Weil)
-   core: osd/OSDMap: calc_pg_upmaps - restrict optimization to origin
    pools only ([issue#38897](http://tracker.ceph.com/issues/38897),
    [pr#27142](https://github.com/ceph/ceph/pull/27142), xie xingguo)
-   core: osd/OSDMap: consider overfull osds only when trying to do
    upmap ([pr#32368](https://github.com/ceph/ceph/pull/32368), xie
    xingguo)
-   core: osd/OSDMap: do not trust partially simplified pg_upmap_item
    ([pr#30576](https://github.com/ceph/ceph/pull/30576), xie xingguo)
-   core: osd/OSDMap: fix calc_pg_role
    ([pr#32132](https://github.com/ceph/ceph/pull/32132), Sage Weil)
-   core: osd/OSDMap: health alert for non-power-of-two pg_num
    ([pr#30525](https://github.com/ceph/ceph/pull/30525), Sage Weil)
-   core: osd/OSDMap: Replace get_out_osds with get_out_existing_osds
    ([issue#39154](http://tracker.ceph.com/issues/39154),
    [pr#27663](https://github.com/ceph/ceph/pull/27663), Brad Hubbard)
-   core: osd/OSDMap: Show health warning if a pool is configured with
    size 1 ([pr#31416](https://github.com/ceph/ceph/pull/31416), Sridhar
    Seshasayee)
-   core: osd/OSDMap: stop encoding osd_state with \>8 bits wide states
    only for old client
    ([pr#33814](https://github.com/ceph/ceph/pull/33814), xie xingguo)
-   core: osd/osd_types: bump up some encoding versions
    ([pr#29923](https://github.com/ceph/ceph/pull/29923), xie xingguo)
-   core: osd/osd_types: drop last_backfill_bitwise member
    ([pr#28766](https://github.com/ceph/ceph/pull/28766), Sage Weil)
-   core: osd/osd_types: fix {omap,hitset_bytes}\_stats_invalid handling
    on split/merge ([pr#30479](https://github.com/ceph/ceph/pull/30479),
    Sage Weil)
-   core: osd/osd_types: inc-recovery - add special handler for
    lost_revert ([pr#29893](https://github.com/ceph/ceph/pull/29893),
    xie xingguo)
-   core: osd/osd_types: pool_stat_t::dump - fix num_store_stats field
    ([issue#39340](http://tracker.ceph.com/issues/39340),
    [pr#27633](https://github.com/ceph/ceph/pull/27633), xie xingguo)
-   core: osd/PeeringState.cc: dont let num_objects become negative
    ([pr#32305](https://github.com/ceph/ceph/pull/32305), Neha Ojha)
-   core: osd/PeeringState.cc: skip peer_purged when discovering all
    missing ([pr#32195](https://github.com/ceph/ceph/pull/32195), Neha
    Ojha)
-   core: osd/PeeringState.h: Fix pg stuck in WaitActingChange
    ([pr#29669](https://github.com/ceph/ceph/pull/29669), chen qiuzhang)
-   core: osd/PeeringState.h: get_num_missing() should report
    num_missing() ([pr#30414](https://github.com/ceph/ceph/pull/30414),
    Neha Ojha)
-   core: osd/PeeringState.h: ignore RemoteBackfillReserved in
    WaitLocalBackfillReserved
    ([pr#33525](https://github.com/ceph/ceph/pull/33525), Neha Ojha)
-   core: osd/PeeringState: base lease support checks on features, not
    require_osd_release
    ([pr#30721](https://github.com/ceph/ceph/pull/30721), Sage Weil)
-   core: osd/PeeringState: clear LAGGY and WAIT states on exiting
    Started ([pr#31864](https://github.com/ceph/ceph/pull/31864), Sage
    Weil)
-   core: osd/PeeringState: disable read lease until require_osd_release
    \>= octopus ([pr#30692](https://github.com/ceph/ceph/pull/30692),
    Sage Weil)
-   core: osd/PeeringState: do not complain about past_intervals
    constrained by oldest epoch
    ([pr#29747](https://github.com/ceph/ceph/pull/29747), Sage Weil)
-   core: osd/PeeringState: do not exclude up from
    acting_recovery_backfill
    ([pr#31703](https://github.com/ceph/ceph/pull/31703), xie xingguo)
-   core: osd/PeeringState: do not start renewing leases until PG is
    activated ([pr#33129](https://github.com/ceph/ceph/pull/33129), Sage
    Weil)
-   core: osd/PeeringState: fix wrong history of merge target
    ([pr#29835](https://github.com/ceph/ceph/pull/29835), xie xingguo)
-   core: osd/PeeringState: on_new_interval on child PG after split
    ([pr#29780](https://github.com/ceph/ceph/pull/29780), Sage Weil)
-   core: osd/PeeringState: recover_got - add special handler for empty
    log ([pr#30503](https://github.com/ceph/ceph/pull/30503), xie
    xingguo)
-   core: osd/PeeringState: require SERVER_OCTOPUS to respond to
    RenewLease ([pr#33339](https://github.com/ceph/ceph/pull/33339),
    Neha Ojha)
-   core: osd/PeeringState: send pg_info2 if release \>= octopus
    ([pr#30836](https://github.com/ceph/ceph/pull/30836), Kefu Chai)
-   core: osd/PeeringState: transit async_recovery_targets back into
    acting before backfilling
    ([pr#32202](https://github.com/ceph/ceph/pull/32202), xie xingguo)
-   core: osd/PG: Add PG to large omap log message
    ([pr#30682](https://github.com/ceph/ceph/pull/30682), Brad Hubbard)
-   core: osd/PG: adjust pg history on fabricated merge target if
    necessary ([issue#38623](http://tracker.ceph.com/issues/38623),
    [pr#26822](https://github.com/ceph/ceph/pull/26822), Sage Weil)
-   core: osd/PG: clean up fastinfo key when last_update does not
    increase ([pr#32615](https://github.com/ceph/ceph/pull/32615), Sage
    Weil, Kefu Chai)
-   core: osd/PG: discover missing objects when an OSD peers and PG is
    degraded ([pr#27288](https://github.com/ceph/ceph/pull/27288), Jonas
    Jelten)
-   core: osd/PG: do not leak cluster message when theres no con
    ([pr#32897](https://github.com/ceph/ceph/pull/32897), Sage Weil)
-   core: osd/PG: do not queue scrub if PG is not active when unblock
    ([issue#40451](http://tracker.ceph.com/issues/40451),
    [pr#28660](https://github.com/ceph/ceph/pull/28660), Sage Weil)
-   core: osd/PG: do not use approx_missing_objects pre-nautilus
    ([pr#27798](https://github.com/ceph/ceph/pull/27798), Neha Ojha)
-   core: osd/PG: fix cleanup of pgmeta-like objects on PG deletion;
    disallow empty object names
    ([pr#27929](https://github.com/ceph/ceph/pull/27929), Sage Weil)
-   core: osd/PG: fix last_complete re-calculation on splitting
    ([issue#26958](http://tracker.ceph.com/issues/26958),
    [pr#27702](https://github.com/ceph/ceph/pull/27702), xie xingguo)
-   core: osd/PG: fix \_finish_recovery vs repair race
    ([pr#30059](https://github.com/ceph/ceph/pull/30059), xie xingguo)
-   core: osd/PG: introduce all_missing_unfound helper
    ([issue#38784](http://tracker.ceph.com/issues/38784),
    [issue#38931](http://tracker.ceph.com/issues/38931),
    [pr#27205](https://github.com/ceph/ceph/pull/27205), xie xingguo)
-   core: osd/PG: move down peers out from peer_purged
    ([issue#38931](http://tracker.ceph.com/issues/38931),
    [pr#27182](https://github.com/ceph/ceph/pull/27182), xie xingguo)
-   core: osd/PG: move } to the proper place
    ([pr#27204](https://github.com/ceph/ceph/pull/27204), xie xingguo)
-   core: osd/PG: remove unused code
    ([pr#30930](https://github.com/ceph/ceph/pull/30930), Jianpeng Ma)
-   core: osd/PG: restart peering for undersized PG on any down stray
    peer coming back
    ([pr#33106](https://github.com/ceph/ceph/pull/33106), xie xingguo,
    Yan Jun)
-   core: osd/PG: skip rollforward when !transaction_applied during
    append_log() ([issue#36739](http://tracker.ceph.com/issues/36739),
    [pr#26996](https://github.com/ceph/ceph/pull/26996), Neha Ojha)
-   core: osd/PG: the warning seems more serious than what it wanna
    transmit ([pr#27509](https://github.com/ceph/ceph/pull/27509),
    Zengran Zhang)
-   core: osd/PG: use emplace() to construct new element in-place
    ([pr#27124](https://github.com/ceph/ceph/pull/27124), Zengran Zhang)
-   core: osd/PGLog.h: print olog_can_rollback_to before deciding to
    rollback ([issue#38894](http://tracker.ceph.com/issues/38894),
    [issue#21174](http://tracker.ceph.com/issues/21174),
    [pr#27105](https://github.com/ceph/ceph/pull/27105), Neha Ojha)
-   core: osd/PGLog: persist num_objects_missing for replicas when
    peering is done
    ([pr#30466](https://github.com/ceph/ceph/pull/30466), xie xingguo)
-   core: osd/PGLog: preserve original_crt to check rollbackability
    ([issue#36739](http://tracker.ceph.com/issues/36739),
    [pr#27200](https://github.com/ceph/ceph/pull/27200), Neha Ojha)
-   core: osd/PGLog: reset log.complete_to when recover obect failed
    ([pr#30533](https://github.com/ceph/ceph/pull/30533), Tao Ning)
-   core: osd/PGStateUtils: initialize NamedState::enter_time
    ([pr#33813](https://github.com/ceph/ceph/pull/33813), Jianpeng Ma)
-   core: osd/PrimaryLogPG: always use strict priority ordering for
    kicked recovery ops
    ([pr#30632](https://github.com/ceph/ceph/pull/30632), xie xingguo)
-   core: osd/PrimaryLogPG: Avoid accessing destroyed references in
    finish_degrxe2x80xa6
    ([pr#29663](https://github.com/ceph/ceph/pull/29663), Tao Ning)
-   core: osd/PrimaryLogPG: cancel in-flight manifest ops on interval
    changing; fix race with scru
    ([pr#29985](https://github.com/ceph/ceph/pull/29985), xie xingguo)
-   core: osd/PrimaryLogPG: do_op - do not create head object twice
    ([pr#28785](https://github.com/ceph/ceph/pull/28785), xie xingguo)
-   core: osd/PrimaryLogPG: finish_copyfrom - dirty omap if necessary
    ([pr#29729](https://github.com/ceph/ceph/pull/29729), xie xingguo)
-   core: osd/PrimaryLogPG: fix dirty range of write_full
    ([pr#29726](https://github.com/ceph/ceph/pull/29726), xie xingguo)
-   core: osd/PrimaryLogPG: fix warning
    ([pr#30716](https://github.com/ceph/ceph/pull/30716), Sage Weil)
-   core: osd/PrimaryLogPG: include op_returns in dup replies
    ([pr#30640](https://github.com/ceph/ceph/pull/30640), Sage Weil)
-   core: osd/PrimaryLogPG: kill obsolete ondisk\\\_{read,write}\_lock
    comments ([pr#29719](https://github.com/ceph/ceph/pull/29719), xie
    xingguo)
-   core: osd/PrimaryLogPG: more constness
    ([pr#28786](https://github.com/ceph/ceph/pull/28786), Kefu Chai)
-   core: osd/PrimaryLogPG: remove unused parent pgls-filter
    ([pr#29675](https://github.com/ceph/ceph/pull/29675), Radoslaw
    Zarzynski, Kefu Chai)
-   core: osd/PrimaryLogPG: simple debug message
    ([pr#32444](https://github.com/ceph/ceph/pull/32444), Jianpeng Ma)
-   core: osd/PrimaryLogPG: skip obcs that dont exist during backfill
    scan_range ([pr#30715](https://github.com/ceph/ceph/pull/30715),
    Sage Weil)
-   core: osd/PrimaryLogPG: update oi.size on write op implicitly
    truncating object up
    ([pr#30085](https://github.com/ceph/ceph/pull/30085), xie xingguo)
-   core: osd/PrimaryLogPG: use legacy timestamp rendering for hit_set
    objects ([pr#33117](https://github.com/ceph/ceph/pull/33117), Sage
    Weil)
-   core: osd/ReplicatedBackend: check against empty data_included
    before enabling crc
    ([pr#29621](https://github.com/ceph/ceph/pull/29621), xie xingguo)
-   core: osd/scheduler/OpSchedulerItem: schedule backoffs as client ops
    ([pr#32382](https://github.com/ceph/ceph/pull/32382), Samuel Just)
-   core: osd/SnapMapper: remove pre-octopus snapmapper keys after
    conversion ([pr#30368](https://github.com/ceph/ceph/pull/30368),
    Sage Weil)
-   core: osd/SnapMirror: no need to record purged_snaps every epoch
    ([pr#31866](https://github.com/ceph/ceph/pull/31866), Sage Weil)
-   core: OSD: modify n.cookie to op.notify.cookie
    ([pr#29418](https://github.com/ceph/ceph/pull/29418), yangjun)
-   core: osdc/Objecter: always add [0 after strncpy() (\`pr#27286
    \<https://github.com/ceph/ceph/pull/27286\>]{.title-ref}\_, Kefu
    Chai)
-   core: osdc/Objecter: Boost.Asio (I object!)
    ([pr#16715](https://github.com/ceph/ceph/pull/16715), Adam C.
    Emerson)
-   core: osdc/Objecter: debug pause/unpause transition
    ([pr#32850](https://github.com/ceph/ceph/pull/32850), Sage Weil)
-   core: osdc/Objecter: fix OSDMap leak in handle_osd_map
    ([issue#20491](http://tracker.ceph.com/issues/20491),
    [pr#28242](https://github.com/ceph/ceph/pull/28242), Sage Weil)
-   core: osdc/Objecter: only pause if respects_full()
    ([pr#33020](https://github.com/ceph/ceph/pull/33020), Sage Weil)
-   core: osdc/Objecter: pg-mapping cache
    ([pr#28487](https://github.com/ceph/ceph/pull/28487), xie xingguo)
-   core: osdc/Objecter: \_calc_target - inline spgid
    ([pr#28570](https://github.com/ceph/ceph/pull/28570), xie xingguo)
-   core: osdc: Fix a missing : for the correct namespace
    ([pr#29472](https://github.com/ceph/ceph/pull/29472), Willem Jan
    Withagen)
-   core: pybind/ceph_argparse: improve ceph -h syntax
    ([pr#30431](https://github.com/ceph/ceph/pull/30431), Sage Weil)
-   core: pybind/mgr/mgr_module: fix standby module logging options
    ([pr#33639](https://github.com/ceph/ceph/pull/33639), Sage Weil)
-   core: pybind/mgr/mgr_util: fix pretty time delta
    ([pr#33794](https://github.com/ceph/ceph/pull/33794), Sage Weil)
-   core: pybind/mgr/\\\*: fix config_notify handling of default values
    ([pr#32755](https://github.com/ceph/ceph/pull/32755), Sage Weil)
-   core: qa/distros: add rhel/centos 8.1
    ([pr#33026](https://github.com/ceph/ceph/pull/33026), Sage Weil)
-   core: qa/distros: centos 7.6; update centos and ubuntu latest
    symlinks ([pr#27349](https://github.com/ceph/ceph/pull/27349), Sage
    Weil)
-   core: qa/standalone/mon/osd-create-pool: fix utf-8 grep LANG
    ([pr#32711](https://github.com/ceph/ceph/pull/32711), Sage Weil)
-   core: qa/standalone/osd/divergent-priors: add reproducer for bug
    41816 ([pr#30506](https://github.com/ceph/ceph/pull/30506), Sage
    Weil)
-   core: qa/standalone/osd/osd-bench: debug bluestore
    ([pr#32961](https://github.com/ceph/ceph/pull/32961), Sage Weil)
-   core: qa/standalone/osd/osd-markdown: fix dup command disabling
    ([issue#38359](http://tracker.ceph.com/issues/38359),
    [pr#27499](https://github.com/ceph/ceph/pull/27499), Sage Weil)
-   core: qa/standalone/scrub/osd-scrub-snaps: misc fixes for
    removed_snaps change
    ([issue#40725](http://tracker.ceph.com/issues/40725),
    [pr#29003](https://github.com/ceph/ceph/pull/29003), Sage Weil)
-   core: qa/standalone: python -\> python3
    ([pr#32383](https://github.com/ceph/ceph/pull/32383), Sage Weil)
-   core: qa/suites/rados/multimon/tasks/mon_clock_with_skews: disable
    ntpd etc ([pr#33184](https://github.com/ceph/ceph/pull/33184), Sage
    Weil)
-   core: qa/suites/rados/multimon: fix failures
    ([issue#40112](http://tracker.ceph.com/issues/40112),
    [pr#28353](https://github.com/ceph/ceph/pull/28353), Sage Weil)
-   core: qa/suites/rados/singleton-nomsgr/all/balancer: whitelist
    PG_AVAILABILITY
    ([pr#31747](https://github.com/ceph/ceph/pull/31747), Sage Weil)
-   core: qa/suites/rados/singleton/all/ec-lost-unfound: no rbd pool
    ([pr#30596](https://github.com/ceph/ceph/pull/30596), Sage Weil)
-   core: qa/suites/rados/thrash-old-clients: centos -\> ubuntu
    ([pr#32356](https://github.com/ceph/ceph/pull/32356), Sage Weil)
-   core: qa/suites/rados/thrash-old-clients: skip TestClsRbd.mirror
    test ([pr#31745](https://github.com/ceph/ceph/pull/31745), Sage
    Weil)
-   core: qa/suites/rados/thrash: debug monc
    ([pr#32885](https://github.com/ceph/ceph/pull/32885), Sage Weil)
-   core: qa/suites/upgrade/nautilus-x: misc updates
    ([pr#27138](https://github.com/ceph/ceph/pull/27138), Sage Weil)
-   core: qa/suites/upgrade/\\\*-x-singleton: enable bluestore debugging
    settings ([pr#27786](https://github.com/ceph/ceph/pull/27786), Sage
    Weil)
-   core: qa/suites/upgrade: all upgrades to octopus on ubuntu only
    ([pr#32275](https://github.com/ceph/ceph/pull/32275), Sage Weil)
-   core: qa/suits/rados/basic/tasks/rados_api_tests: pgs can go
    degraded ([pr#30627](https://github.com/ceph/ceph/pull/30627), Sage
    Weil)
-   core: qa/tasks/ceph2: teuthology task to bring up a ceph-daemon+ssh
    cluster ([pr#31502](https://github.com/ceph/ceph/pull/31502), Sage
    Weil)
-   core: qa/tasks/ceph: only re-request scrub on unscrubbed pgs
    ([pr#32988](https://github.com/ceph/ceph/pull/32988), Sage Weil)
-   core: qa/tasks/ceph_manager: fix thrash_pg_upmap_items when no pools
    ([pr#29144](https://github.com/ceph/ceph/pull/29144), Sage Weil)
-   core: qa/tasks/ceph_manager: make upmap thrasher behave when no
    pools/pgs ([pr#29069](https://github.com/ceph/ceph/pull/29069), Sage
    Weil)
-   core: qa/tasks/ceph_manager: remove race from all_active_or_peered()
    ([pr#29498](https://github.com/ceph/ceph/pull/29498), Sage Weil)
-   core: qa/tasks/ceph_manager: wait for clean before asserting clean
    on minsize test
    ([pr#29109](https://github.com/ceph/ceph/pull/29109), Sage Weil)
-   core: qa/workunits/rados/test_large_omap_detection: py3-ify
    ([pr#32405](https://github.com/ceph/ceph/pull/32405), Sage Weil)
-   core: qa: increase mon tell retries when injecting msgr failures
    ([pr#30872](https://github.com/ceph/ceph/pull/30872), Sage Weil)
-   core: qa: more fixes for the removed_snaps changeset
    ([issue#40674](http://tracker.ceph.com/issues/40674),
    [pr#28901](https://github.com/ceph/ceph/pull/28901), Sage Weil)
-   core: qa: run various tests on ubuntu
    ([pr#32278](https://github.com/ceph/ceph/pull/32278), Sage Weil)
-   core: rados bench: fix the delayed checking of completed ops
    ([pr#32928](https://github.com/ceph/ceph/pull/32928), Jianshen Liu)
-   core: Revert common: default pg_autoscale_mode=on for new pools
    ([pr#30440](https://github.com/ceph/ceph/pull/30440), David Zafman)
-   core: Revert crush: remove invalid upmap items
    ([pr#32017](https://github.com/ceph/ceph/pull/32017), David Zafman)
-   core: Revert Merge pull request #16715 from
    adamemerson/wip-I-Object!
    ([pr#31790](https://github.com/ceph/ceph/pull/31790), Sage Weil)
-   core: Revert test: librados startup/shutdown racer test
    ([pr#31092](https://github.com/ceph/ceph/pull/31092), Sage Weil)
-   core: rgw/rgw_tools: fix osd pool set json syntax
    ([pr#27967](https://github.com/ceph/ceph/pull/27967), Sage Weil)
-   core: rocksdb: enable rocksdb_rmrange=true by default
    ([pr#29323](https://github.com/ceph/ceph/pull/29323), Sage Weil)
-   core: rocksdb: Updated to v6.1.2
    ([pr#29026](https://github.com/ceph/ceph/pull/29026), Mark Nelson)
-   core: sample.ceph.conf: correct the default value of filestore merge
    threshold ([pr#28653](https://github.com/ceph/ceph/pull/28653),
    zhang Shaowen)
-   core: selinux: Allow ceph to read udev d
    ([pr#29071](https://github.com/ceph/ceph/pull/29071), Boris Ranto)
-   core: src/: Clean up endian handling
    ([pr#30409](https://github.com/ceph/ceph/pull/30409), Ulrich
    Weigand)
-   core: src/dmclock: bring in fixes for indirect_intrusive_heap
    ([pr#32380](https://github.com/ceph/ceph/pull/32380), Samuel Just)
-   core: src/osd: add tier-flush op
    ([pr#28778](https://github.com/ceph/ceph/pull/28778), Myoungwon Oh)
-   core: test: add librados-based startup/shutdown racer test
    ([pr#30552](https://github.com/ceph/ceph/pull/30552), Jeff Layton)
-   core: tools/rados: call pool_lookup() after rados is connected
    ([pr#30413](https://github.com/ceph/ceph/pull/30413), Vikhyat Umrao)
-   core: tools/rados: prevent put operation from recreating object when
    \--offset=0 ([pr#31230](https://github.com/ceph/ceph/pull/31230),
    Adam Kupczyk)
-   core: tools/rados: Unmask -o to restore original behaviour
    ([pr#31310](https://github.com/ceph/ceph/pull/31310), Brad Hubbard)
-   core: Wip lazy omap test
    ([pr#28070](https://github.com/ceph/ceph/pull/28070), Brad Hubbard)
-   crimon/osd: serve read requests
    ([pr#26697](https://github.com/ceph/ceph/pull/26697), Kefu Chai)
-   Crimson build fixes
    ([pr#33345](https://github.com/ceph/ceph/pull/33345), Samuel Just)
-   crimson, common: Add ephemeral ObjectContext state to crimson
    ([pr#31202](https://github.com/ceph/ceph/pull/31202), Samuel Just)
-   crimson,auth: fix FTBFS of crimson-osd and fix v1/v2 auth
    ([pr#27809](https://github.com/ceph/ceph/pull/27809), Kefu Chai,
    Yingxin Cheng)
-   crimson,osd: performance fixes
    ([pr#28071](https://github.com/ceph/ceph/pull/28071), Kefu Chai,
    Radoslaw Zarzynski)
-   crimson/common/errorator.h: add handle_error() method
    ([pr#31856](https://github.com/ceph/ceph/pull/31856), Radoslaw
    Zarzynski)
-   crimson/common/errorator.h: simplify the compound safe_then()
    variant ([pr#31918](https://github.com/ceph/ceph/pull/31918),
    Radoslaw Zarzynski)
-   crimson/common: more friendly to seastar::do_with()
    ([pr#33199](https://github.com/ceph/ceph/pull/33199), Kefu Chai)
-   crimson/common: remove unused file .#log.cc
    ([pr#28828](https://github.com/ceph/ceph/pull/28828), Changcheng
    Liu)
-   crimson/mon: fix the v1 auth
    ([pr#28041](https://github.com/ceph/ceph/pull/28041), Kefu Chai)
-   crimson/mon: use shared_future for waiting MauthReply
    ([pr#30366](https://github.com/ceph/ceph/pull/30366), chunmei Liu)
-   crimson/net: bug fixes from v2 failover tests
    ([pr#29882](https://github.com/ceph/ceph/pull/29882), Yingxin Cheng)
-   crimson/net: clean-up and fixes of messenger
    ([pr#29057](https://github.com/ceph/ceph/pull/29057), Yingxin Cheng)
-   crimson/net: extract do_write_dispatch_sweep()
    ([pr#27428](https://github.com/ceph/ceph/pull/27428), Yingxin Cheng)
-   crimson/net: implement preemptive shutdown/close
    ([pr#28682](https://github.com/ceph/ceph/pull/28682), Yingxin Cheng)
-   crimson/net: improve batching in the write path
    ([pr#27788](https://github.com/ceph/ceph/pull/27788), Yingxin Cheng)
-   crimson/net: lossless policy for v2 protocol
    ([pr#29378](https://github.com/ceph/ceph/pull/29378), Yingxin Cheng)
-   crimson/net: lossy connection for ProtocolV2
    ([pr#26710](https://github.com/ceph/ceph/pull/26710), Yingxin Cheng)
-   crimson/net: misc fixes in v1 read path
    ([pr#27837](https://github.com/ceph/ceph/pull/27837), Yingxin Cheng)
-   crimson/net: prefer \<fmt/chrono.h\> over \<fmt/time.h\>
    ([pr#27831](https://github.com/ceph/ceph/pull/27831), Kefu Chai)
-   crimson/net: prevent reusing the sent messages
    ([pr#28890](https://github.com/ceph/ceph/pull/28890), Yingxin Cheng)
-   crimson/net: print tx/rx messages using logger().info()
    ([pr#28798](https://github.com/ceph/ceph/pull/28798), Kefu Chai)
-   crimson/net: remove redundant std::move()
    ([pr#28317](https://github.com/ceph/ceph/pull/28317), Kefu Chai)
-   crimson/net: v2 racing tests, stall tests and bug fixes
    ([pr#30313](https://github.com/ceph/ceph/pull/30313), Yingxin Cheng)
-   crimson/os: do not fail if fsid file exists when mkfs
    ([pr#27006](https://github.com/ceph/ceph/pull/27006), chunmei Liu,
    Kefu Chai)
-   crimson/os: init PG with pg coll not meta coll
    ([pr#33084](https://github.com/ceph/ceph/pull/33084), Kefu Chai)
-   crimson/os: Object::read() returns bufferlist instead of never used
    errcode ([pr#30380](https://github.com/ceph/ceph/pull/30380),
    Radoslaw Zarzynski)
-   crimson/osd/osd_operation.h: clean up duplicative check
    ([pr#31859](https://github.com/ceph/ceph/pull/31859), Radoslaw
    Zarzynski)
-   crimson/osd/pg: start_operation for read_state,
    schedule_event_on_commit
    ([pr#28771](https://github.com/ceph/ceph/pull/28771), Samuel Just)
-   crimson/osd/pg_meta: use initializer list for passing set\<\>
    ([pr#28461](https://github.com/ceph/ceph/pull/28461), Kefu Chai)
-   crimson/osd: abort on unsupported objectstore type
    ([pr#28790](https://github.com/ceph/ceph/pull/28790), Kefu Chai)
-   crimson/osd: add \--help-seastar command line option
    ([pr#28794](https://github.com/ceph/ceph/pull/28794), Kefu Chai)
-   crimson/osd: add minimal state machine for PG peering
    ([pr#27071](https://github.com/ceph/ceph/pull/27071), Kefu Chai)
-   crimson/osd: add pgls support
    ([pr#30433](https://github.com/ceph/ceph/pull/30433), Kefu Chai)
-   crimson/osd: cache object_info and snapset in PGBackend
    ([pr#27310](https://github.com/ceph/ceph/pull/27310), Kefu Chai)
-   crimson/osd: call at_exit() before stopping the engine
    ([pr#27177](https://github.com/ceph/ceph/pull/27177), Kefu Chai)
-   crimson/osd: call engine().exit(0) after mkfs
    ([pr#27061](https://github.com/ceph/ceph/pull/27061), Kefu Chai)
-   crimson/osd: capture watcher when calling its member function
    ([pr#33425](https://github.com/ceph/ceph/pull/33425), Kefu Chai)
-   crimson/osd: cleanups
    ([pr#30736](https://github.com/ceph/ceph/pull/30736), Kefu Chai)
-   crimson/osd: consolidate the code to initialize msgrs
    ([pr#27426](https://github.com/ceph/ceph/pull/27426), Kefu Chai)
-   crimson/osd: create msgrs in main.cc
    ([pr#27066](https://github.com/ceph/ceph/pull/27066), Kefu Chai)
-   crimson/osd: crimson/osd: do not load fullmap.0
    ([pr#27004](https://github.com/ceph/ceph/pull/27004), chunmei Liu,
    Kefu Chai)
-   crimson/osd: differentiate write from writefull
    ([pr#28959](https://github.com/ceph/ceph/pull/28959), Kefu Chai)
-   crimson/osd: do not add whoami as hb peer and cleanups
    ([pr#27307](https://github.com/ceph/ceph/pull/27307), Kefu Chai)
-   crimson/osd: extend OpsExecuter to carry about op effects
    ([pr#30310](https://github.com/ceph/ceph/pull/30310), Radoslaw
    Zarzynski)
-   crimson/osd: fix the build broken by df771861
    ([pr#28053](https://github.com/ceph/ceph/pull/28053), chunmei Liu)
-   crimson/osd: fix the Clang build in create_watch_info()
    ([pr#33350](https://github.com/ceph/ceph/pull/33350), Radoslaw
    Zarzynski)
-   crimson/osd: implement replicated write
    ([pr#29076](https://github.com/ceph/ceph/pull/29076), Kefu Chai)
-   crimson/osd: init PG with more info
    ([pr#27064](https://github.com/ceph/ceph/pull/27064), Kefu Chai)
-   crimson/osd: lower debug level on i/o path
    ([pr#27338](https://github.com/ceph/ceph/pull/27338), Kefu Chai)
-   crimson/osd: misc fixes and cleanup
    ([pr#33528](https://github.com/ceph/ceph/pull/33528), Yingxin Cheng)
-   crimson/osd: misc fixes for OSD reboot-ability
    ([pr#33595](https://github.com/ceph/ceph/pull/33595), Yingxin Cheng)
-   crimson/osd: partition args the right way
    ([pr#27211](https://github.com/ceph/ceph/pull/27211), Kefu Chai)
-   crimson/osd: pass unknown args to ConfigProxy::parse_args()
    ([pr#27062](https://github.com/ceph/ceph/pull/27062), Kefu Chai)
-   crimson/osd: remove unneeded captures - pg.cc
    ([pr#33349](https://github.com/ceph/ceph/pull/33349), Ronen
    Friedman)
-   crimson/osd: report pg_stats to mgr
    ([pr#27065](https://github.com/ceph/ceph/pull/27065), Kefu Chai)
-   crimson/osd: should handle pg_lease messages
    ([pr#30834](https://github.com/ceph/ceph/pull/30834), Kefu Chai)
-   crimson/osd: shutdown services in the right order
    ([pr#27987](https://github.com/ceph/ceph/pull/27987), Kefu Chai)
-   crimson/osd: some cleanups
    ([pr#28402](https://github.com/ceph/ceph/pull/28402), Kefu Chai)
-   crimson/osd: support write pid_file when osd start
    ([pr#27413](https://github.com/ceph/ceph/pull/27413), chunmei Liu)
-   crimson/osd: update peering_state in PG::on_activate_complete()
    ([pr#28747](https://github.com/ceph/ceph/pull/28747), Kefu Chai)
-   crimson/osd: use single-pg peering ops
    ([pr#30372](https://github.com/ceph/ceph/pull/30372), Kefu Chai)
-   crimson/thread: generalize Task so it works w/ func returns void
    ([pr#32742](https://github.com/ceph/ceph/pull/32742), Kefu Chai)
-   crimson/{net,mon,osd}: misc logging changes
    ([pr#27099](https://github.com/ceph/ceph/pull/27099), Kefu Chai)
-   crimson/{osd,heartbeat}: allow heartbeat to have access to
    authorizer ([pr#27059](https://github.com/ceph/ceph/pull/27059),
    Kefu Chai)
-   crimson/{osd,mon}: lower log level when sending a replicated op
    ([pr#30957](https://github.com/ceph/ceph/pull/30957), Kefu Chai)
-   crimson: add editor properties header
    ([pr#33408](https://github.com/ceph/ceph/pull/33408), Kefu Chai)
-   crimson: add FuturizedStore to encapsulate CyanStore
    ([pr#28358](https://github.com/ceph/ceph/pull/28358), chunmei Liu)
-   crimson: add missing include in common/errorator.h
    ([pr#32490](https://github.com/ceph/ceph/pull/32490), Radoslaw
    Zarzynski)
-   crimson: add support for basic write path
    ([pr#27873](https://github.com/ceph/ceph/pull/27873), Radoslaw
    Zarzynski)
-   crimson: add support for watch / notify, part 1
    ([pr#32679](https://github.com/ceph/ceph/pull/32679), Radoslaw
    Zarzynski)
-   crimson: bring ceph::errorator with its first appliances
    ([pr#30387](https://github.com/ceph/ceph/pull/30387), Radoslaw
    Zarzynski)
-   crimson: CLANG-related fixes to errorator.h
    ([pr#32488](https://github.com/ceph/ceph/pull/32488), Ronen
    Friedman, Radoslaw Zarzynski)
-   crimson: clean up and refactor asok
    ([pr#33357](https://github.com/ceph/ceph/pull/33357), Kefu Chai)
-   crimson: enable cephx for v2 msgr
    ([pr#27514](https://github.com/ceph/ceph/pull/27514), Kefu Chai)
-   crimson: fix build with GCC-10
    ([pr#33233](https://github.com/ceph/ceph/pull/33233), Kefu Chai)
-   crimson: fix crimson pg coll usage error
    ([pr#33076](https://github.com/ceph/ceph/pull/33076), Chunmei Liu)
-   crimson: fix lambda captures of non-variables
    ([pr#32494](https://github.com/ceph/ceph/pull/32494), Ronen
    Friedman)
-   crimson: futurized CyanStores member functions and Collection
    ([pr#29470](https://github.com/ceph/ceph/pull/29470), Kefu Chai,
    chunmei Liu)
-   crimson: handle MOSDPGQuery2 properly
    ([pr#30399](https://github.com/ceph/ceph/pull/30399), Kefu Chai)
-   crimson: make seastar::do_with() a friend of errorated futures
    ([pr#32175](https://github.com/ceph/ceph/pull/32175), Radoslaw
    Zarzynski)
-   crimson: move dummy impl of AuthServer to DummyAuth
    ([pr#27452](https://github.com/ceph/ceph/pull/27452), Kefu Chai)
-   crimson: move os/cyan\\\_\\\* down to os/cyanstore/\\\*
    ([pr#31874](https://github.com/ceph/ceph/pull/31874), Kefu Chai)
-   crimson: pass [Connection\*]{.title-ref} to Dispatch::ms_dispatch()
    ([pr#27690](https://github.com/ceph/ceph/pull/27690), Yingxin Cheng,
    Kefu Chai)
-   crimson: pickup change to fix \--cpuset support and cleanups
    ([pr#33250](https://github.com/ceph/ceph/pull/33250), Kefu Chai)
-   crimson: remove some attributes from lambda
    ([pr#32604](https://github.com/ceph/ceph/pull/32604), Ronen
    Friedman)
-   crimson: run in foreground if possible, silence warnings
    ([pr#30474](https://github.com/ceph/ceph/pull/30474), Samuel Just,
    Kefu Chai)
-   crimson: s/ceph/crimson/ in namespace names
    ([pr#31069](https://github.com/ceph/ceph/pull/31069), Kefu Chai)
-   crimson: serve basic RBD traffic coming from fio
    ([pr#30339](https://github.com/ceph/ceph/pull/30339), Radoslaw
    Zarzynski)
-   crimson: solve the problem that crimson-osds created pgs stuck in
    unknown state ([pr#33780](https://github.com/ceph/ceph/pull/33780),
    Xuehan Xu)
-   crimson: stop osd before stopping messengers
    ([pr#31904](https://github.com/ceph/ceph/pull/31904), Kefu Chai)
-   crimson: support pgnls and delete op
    ([pr#28079](https://github.com/ceph/ceph/pull/28079), Kefu Chai)
-   crimson: update osd when peer gets authenticated
    ([pr#27416](https://github.com/ceph/ceph/pull/27416), Kefu Chai)
-   crimson: use given osd_fsid when mkfs
    ([pr#28800](https://github.com/ceph/ceph/pull/28800), Kefu Chai)
-   crimson:: add alien blue store
    ([pr#31041](https://github.com/ceph/ceph/pull/31041), Samuel Just,
    Chunmei Liu, Kefu Chai)
-   crush: add root_bucket to identify underfull buckets
    ([issue#38826](http://tracker.ceph.com/issues/38826),
    [pr#27068](https://github.com/ceph/ceph/pull/27068), huangjun)
-   crush: remove invalid upmap items
    ([pr#31131](https://github.com/ceph/ceph/pull/31131), huangjun)
-   crush: remove invalid upmap items
    ([pr#32099](https://github.com/ceph/ceph/pull/32099), huangjun)
-   crush: various fixes for weight-sets, the
    osd_crush_update_weight_set option, and tests
    ([pr#26955](https://github.com/ceph/ceph/pull/26955), Sage Weil)
-   dashboard/services: fix lint error
    ([pr#30289](https://github.com/ceph/ceph/pull/30289), Willem Jan
    Withagen)
-   deb,rpm: switch to python 3
    ([pr#32252](https://github.com/ceph/ceph/pull/32252), Sage Weil,
    Alfredo Deza)
-   debian: add python3-jsonpatch as dependency
    ([pr#33298](https://github.com/ceph/ceph/pull/33298), Sebastian
    Wagner)
-   denc: allow DencDumper to dump OOB buffer
    ([pr#27704](https://github.com/ceph/ceph/pull/27704), Kefu Chai)
-   doc/bootstrap: fixed default \--keyring target
    ([pr#32643](https://github.com/ceph/ceph/pull/32643), Yaarit Hatuka)
-   doc/foundation: fix amihan
    ([pr#32999](https://github.com/ceph/ceph/pull/32999), Sage Weil)
-   doc: .organizationmap: Wido 42on -\> 42on
    ([pr#32260](https://github.com/ceph/ceph/pull/32260), Sage Weil)
-   doc: add a deduplication document
    ([pr#28462](https://github.com/ceph/ceph/pull/28462), Myoungwon Oh)
-   doc: add a doc for vstart_runner.py
    ([pr#29907](https://github.com/ceph/ceph/pull/29907), Rishabh Dave)
-   doc: add a new document on distributed cephfs metadata cache
    ([pr#30265](https://github.com/ceph/ceph/pull/30265), Jeff Layton)
-   doc: Add a new document on Dynamic Metadata Management in CephFS
    ([pr#30348](https://github.com/ceph/ceph/pull/30348), Sidharth
    Anupkrishnan)
-   doc: Add a RGW swift auth note
    ([pr#31309](https://github.com/ceph/ceph/pull/31309), Matthew
    Oliver)
-   doc: add ceph fs volumes and subvolumes documentation
    ([pr#30381](https://github.com/ceph/ceph/pull/30381), Ramana Raja)
-   doc: add CephFS Octopus release notes
    ([pr#33450](https://github.com/ceph/ceph/pull/33450), Patrick
    Donnelly)
-   doc: add changelog for nautilus
    ([pr#27048](https://github.com/ceph/ceph/pull/27048), Abhishek
    Lekshmanan)
-   doc: add chrony to preflight checklist for Ubuntu 18.04
    ([pr#31948](https://github.com/ceph/ceph/pull/31948), Zac Dover)
-   doc: add config help/get/set section for runtime client
    configuration ([issue#41688](http://tracker.ceph.com/issues/41688),
    [pr#32117](https://github.com/ceph/ceph/pull/32117), Venky Shankar)
-   doc: Add Dashboard Octopus release notes
    ([pr#33555](https://github.com/ceph/ceph/pull/33555), Lenz Grimmer)
-   doc: add description for fuse_disable_pagecache
    ([pr#31902](https://github.com/ceph/ceph/pull/31902), Yan, Zheng)
-   doc: add doc for blacklisting older CephFS clients
    ([issue#39130](http://tracker.ceph.com/issues/39130),
    [pr#27412](https://github.com/ceph/ceph/pull/27412), Patrick
    Donnelly)
-   doc: add doc for cephfs lazyio
    ([issue#38729](http://tracker.ceph.com/issues/38729),
    [pr#26976](https://github.com/ceph/ceph/pull/26976), Yan, Zheng)
-   doc: add guide for running tests with teuthology
    ([pr#32114](https://github.com/ceph/ceph/pull/32114), Rishabh Dave)
-   doc: add mds map to list of ceph monitor assets
    ([pr#32631](https://github.com/ceph/ceph/pull/32631), Zac Dover)
-   doc: add missed word than in doc/man/8/rbd.rst
    ([pr#31022](https://github.com/ceph/ceph/pull/31022), Drunkard
    Zhang)
-   doc: Add missing mgr cap for the bootstrap keyring
    ([pr#27201](https://github.com/ceph/ceph/pull/27201), Bryan
    Stillwell)
-   doc: add missing virtualenv for build-doc
    ([pr#31896](https://github.com/ceph/ceph/pull/31896), Rodrigo
    Severo)
-   doc: Add note to execute cephfs-shell
    ([pr#27369](https://github.com/ceph/ceph/pull/27369), Varsha Rao)
-   doc: add package for Golang
    ([issue#38730](http://tracker.ceph.com/issues/38730),
    [pr#26937](https://github.com/ceph/ceph/pull/26937), Irek Fasikhov)
-   doc: add Python 2 to Ubuntu 18.04 installations
    ([pr#31947](https://github.com/ceph/ceph/pull/31947), Zac Dover)
-   doc: add release notes for 13.2.5 mimic
    ([pr#26913](https://github.com/ceph/ceph/pull/26913), Abhishek
    Lekshmanan)
-   doc: add release notes for v13.2.6 mimic
    ([pr#28385](https://github.com/ceph/ceph/pull/28385), Abhishek
    Lekshmanan)
-   doc: Add sphinx_autodoc_typehints extension
    ([pr#33577](https://github.com/ceph/ceph/pull/33577), Sebastian
    Wagner)
-   doc: Add stat command usage in cephfs-shell
    ([pr#28236](https://github.com/ceph/ceph/pull/28236), Varsha Rao)
-   doc: Add usage for shortcuts command in cephfs-shell
    ([pr#27373](https://github.com/ceph/ceph/pull/27373), Varsha Rao)
-   doc: Add warning that the root directory cannot be fragmented
    ([pr#28354](https://github.com/ceph/ceph/pull/28354), Nathan Fish)
-   doc: Added a link to Ceph Community Calendar
    ([pr#31475](https://github.com/ceph/ceph/pull/31475), Zac Dover)
-   doc: added a remark to always use powers of two for pg_num
    ([pr#31541](https://github.com/ceph/ceph/pull/31541), Thomas
    Schneider)
-   doc: added an is where it was needed
    ([pr#32374](https://github.com/ceph/ceph/pull/32374), Zac Dover)
-   doc: Added dashboard features, improved wording
    ([pr#27997](https://github.com/ceph/ceph/pull/27997), Lenz Grimmer)
-   doc: added section on creating RESTful API user
    ([pr#26016](https://github.com/ceph/ceph/pull/26016), James McClune)
-   doc: Added the crisp getting started guide to index.rst
    ([pr#32531](https://github.com/ceph/ceph/pull/32531), Zac Dover)
-   doc: Adding US-Mid-West Mirror to docs
    ([pr#25099](https://github.com/ceph/ceph/pull/25099), Mike Perez)
-   doc: Adds cmake build options for optionally skipping few components
    ([pr#31066](https://github.com/ceph/ceph/pull/31066), Deepika
    Upadhyay)
-   doc: adjust for mon_status changes in octopus
    ([pr#33703](https://github.com/ceph/ceph/pull/33703), Nathan Cutler)
-   doc: admin,doc/\_ext/ceph_releases.py: use yaml.safe_load()
    ([pr#28463](https://github.com/ceph/ceph/pull/28463), Kefu Chai)
-   doc: admin/build-doc: always install python3-\\\* for build deps
    ([pr#32481](https://github.com/ceph/ceph/pull/32481), Kefu Chai)
-   doc: admin/build-doc: do not use system site-packages
    ([pr#32285](https://github.com/ceph/ceph/pull/32285), Sage Weil)
-   doc: admin/build-doc: Fix doxygen typo
    ([pr#32572](https://github.com/ceph/ceph/pull/32572), Varsha Rao)
-   doc: admin/build-doc: use python3
    ([pr#29528](https://github.com/ceph/ceph/pull/29528), Kefu Chai)
-   doc: admin/doc-requirements.txt: bump up Sphinx and breathe
    ([pr#32301](https://github.com/ceph/ceph/pull/32301), Kefu Chai)
-   doc: admin/serve-doc: Switch to python3 only
    ([pr#33596](https://github.com/ceph/ceph/pull/33596), Brad Hubbard)
-   doc: always load resources via HTTPS
    ([pr#29544](https://github.com/ceph/ceph/pull/29544), Tiago Melo)
-   doc: ceph-monstore-tool: correct the key for storing
    mgr_command_descs
    ([pr#33172](https://github.com/ceph/ceph/pull/33172), Kefu Chai)
-   doc: cephfs: add section on fsync error reporting to posix.rst
    ([issue#24641](http://tracker.ceph.com/issues/24641),
    [pr#28300](https://github.com/ceph/ceph/pull/28300), Jeff Layton)
-   doc: change case from [apis]{.title-ref} to [APIs]{.title-ref}
    ([pr#33664](https://github.com/ceph/ceph/pull/33664), Deepika
    Upadhyay)
-   doc: clarify difference between fs and kcephfs suite
    ([pr#32144](https://github.com/ceph/ceph/pull/32144), Rishabh Dave)
-   doc: clarify priority use
    ([pr#32191](https://github.com/ceph/ceph/pull/32191), Yuri
    Weinstein)
-   doc: clarify support for rbd fancy striping
    ([pr#32176](https://github.com/ceph/ceph/pull/32176), Ilya Dryomov)
-   doc: cleanup CephFS Landing Page
    ([pr#30542](https://github.com/ceph/ceph/pull/30542), Milind
    Changire)
-   doc: coding-style: update a link and fix typos
    ([pr#33128](https://github.com/ceph/ceph/pull/33128), Ponnuvel
    Palaniyappan)
-   doc: common/admin_socket: Add doxygen for call and call_async
    ([pr#32547](https://github.com/ceph/ceph/pull/32547), Adam Kupczyk)
-   doc: common/hobject: Error invocation of formula in documentation
    ([pr#28366](https://github.com/ceph/ceph/pull/28366), Albert)
-   doc: config-ref: add a note on current scheduler settings
    ([pr#27243](https://github.com/ceph/ceph/pull/27243), Abhishek
    Lekshmanan)
-   doc: correct example to use vstart to run up cluster
    ([pr#26816](https://github.com/ceph/ceph/pull/26816), Changcheng
    Liu)
-   doc: cover more cache modes in rados/operations/cache-tiering.rst
    ([issue#14153](http://tracker.ceph.com/issues/14153),
    [pr#17614](https://github.com/ceph/ceph/pull/17614), Nathan Cutler)
-   doc: default values for mon_health_to_clog\\\_\\\* were flipped
    ([pr#29867](https://github.com/ceph/ceph/pull/29867), James McClune)
-   doc: describe metadata_heap cleanup
    ([issue#18174](http://tracker.ceph.com/issues/18174),
    [pr#26915](https://github.com/ceph/ceph/pull/26915), Dan van der
    Ster)
-   doc: Describe recovery and backfill prioritizations
    ([issue#39011](http://tracker.ceph.com/issues/39011),
    [pr#27941](https://github.com/ceph/ceph/pull/27941), David Zafman)
-   doc: doc : fixed capitalization
    ([pr#27379](https://github.com/ceph/ceph/pull/27379), Servesha
    Dudhgaonkar)
-   doc: doc, qa: remove invalid option mon_pg_warn_max_per_osd
    ([pr#30787](https://github.com/ceph/ceph/pull/30787), zhang daolong)
-   doc: doc,admin: fix the builtin search
    ([pr#33592](https://github.com/ceph/ceph/pull/33592), Kefu Chai)
-   doc: doc/architecture.rst: fix a typo in EC section
    ([pr#33241](https://github.com/ceph/ceph/pull/33241), Nag Pavan
    Chilakam)
-   doc: doc/bootstrap.rst: fix githus url
    ([pr#31086](https://github.com/ceph/ceph/pull/31086), Alexandre
    Bruyelles)
-   doc: doc/bootstrap: add mds and rgw steps to bootstrap
    ([pr#33088](https://github.com/ceph/ceph/pull/33088), Sage Weil)
-   doc: doc/ceph-fuse: describe -n option
    ([pr#30911](https://github.com/ceph/ceph/pull/30911), Rishabh Dave)
-   doc: doc/ceph-fuse: mention -k option in ceph-fuse man page
    ([pr#30561](https://github.com/ceph/ceph/pull/30561), Rishabh Dave)
-   doc: doc/ceph-kvstore-tool: add description for stats command
    ([pr#29990](https://github.com/ceph/ceph/pull/29990), Josh Durgin,
    Adam Kupczyk)
-   doc: doc/ceph-volume: initial docs for zfs/inventory and zfs/api
    ([pr#31252](https://github.com/ceph/ceph/pull/31252), Willem Jan
    Withagen)
-   doc: doc/cephadm/administration: clarify log gathering
    ([pr#33627](https://github.com/ceph/ceph/pull/33627), Nathan Cutler)
-   doc: doc/cephadm: adjust syntax for config set
    ([pr#33600](https://github.com/ceph/ceph/pull/33600), Joshua Schmid)
-   doc: doc/cephadm: big cleanup of cephadm docs
    ([pr#33981](https://github.com/ceph/ceph/pull/33981), Sage Weil)
-   doc: doc/cephadm: Troubleshooting
    ([pr#33460](https://github.com/ceph/ceph/pull/33460), Sebastian
    Wagner)
-   doc: doc/cephfs/client-auth: description and example are
    inconsistent ([pr#32762](https://github.com/ceph/ceph/pull/32762),
    Ilya Dryomov)
-   doc: doc/cephfs/disaster-recovery-experts: Add link for scrub and
    note for scrub_path
    ([pr#32124](https://github.com/ceph/ceph/pull/32124), Varsha Rao)
-   doc: doc/cephfs: add doc for cephfs io path
    ([pr#30369](https://github.com/ceph/ceph/pull/30369), Yan, Zheng)
-   doc: doc/cephfs: correct a description mistake about mds states
    ([issue#41893](http://tracker.ceph.com/issues/41893),
    [pr#30427](https://github.com/ceph/ceph/pull/30427), Xiao Guodong)
-   doc: doc/cephfs: improve add/remove MDS section
    ([issue#39620](http://tracker.ceph.com/issues/39620),
    [pr#28700](https://github.com/ceph/ceph/pull/28700), Patrick
    Donnelly)
-   doc: doc/cephfs: migrate best practices recommendations to relevant
    docs ([pr#32522](https://github.com/ceph/ceph/pull/32522), Rishabh
    Dave)
-   doc: doc/cleanup: drop repo-access.rst
    ([pr#32276](https://github.com/ceph/ceph/pull/32276), Nathan Cutler)
-   doc: doc/corpus: update to adapt the change from autotools to cmake
    ([pr#27552](https://github.com/ceph/ceph/pull/27552), Kefu Chai)
-   doc: doc/dev/corpus.rst: correct instructions
    ([pr#27741](https://github.com/ceph/ceph/pull/27741), Kefu Chai)
-   doc: doc/dev/corpus.rst: minor tweaks
    ([pr#28877](https://github.com/ceph/ceph/pull/28877), Kefu Chai)
-   doc: doc/dev/crimson.rst: document CBT testing
    ([pr#30290](https://github.com/ceph/ceph/pull/30290), Kefu Chai)
-   doc: doc/dev/crimson: transpose options of compare.py
    ([pr#30453](https://github.com/ceph/ceph/pull/30453), Kefu Chai)
-   doc: doc/dev/developer_guide/index.rst: add youtube reference for
    Getting Started
    ([pr#29712](https://github.com/ceph/ceph/pull/29712), Neha Ojha)
-   doc: doc/dev/developer_guide/index.rst: add youtube references
    ([pr#29033](https://github.com/ceph/ceph/pull/29033), Neha Ojha)
-   doc: doc/dev/developer_guide: fix heading level
    ([pr#30428](https://github.com/ceph/ceph/pull/30428), Nathan Cutler)
-   doc: doc/dev/developer_guide: remove web address
    ([pr#29183](https://github.com/ceph/ceph/pull/29183),
    gabriellasroman)
-   doc: doc/dev/kubernetes: Update
    ([pr#28081](https://github.com/ceph/ceph/pull/28081), Sebastian
    Wagner)
-   doc: doc/dev/osd_internals/async_recovery: update cost calculation
    ([pr#28036](https://github.com/ceph/ceph/pull/28036), Neha Ojha)
-   doc: doc/dev: add crimson.rst
    ([pr#28674](https://github.com/ceph/ceph/pull/28674), Kefu Chai)
-   doc: doc/dev: add teuthology priority recommendations
    ([pr#30308](https://github.com/ceph/ceph/pull/30308), Patrick
    Donnelly)
-   doc: doc/developer: fix dev mailing list address
    ([pr#32442](https://github.com/ceph/ceph/pull/32442), Willem Jan
    Withagen)
-   doc: doc/drivegroups: add docs for DriveGroups with excessive
    examples ([pr#33044](https://github.com/ceph/ceph/pull/33044),
    Joshua Schmid)
-   doc: doc/foundation: add ceph foundation info here
    ([pr#31955](https://github.com/ceph/ceph/pull/31955), Sage Weil)
-   doc: doc/foundation: add cloudbase and vexxhost
    ([pr#32013](https://github.com/ceph/ceph/pull/32013), Sage Weil)
-   doc: doc/foundation: add Samsung Electronics
    ([pr#33518](https://github.com/ceph/ceph/pull/33518), Sage Weil)
-   doc: doc/governance: add cbodey
    ([pr#27708](https://github.com/ceph/ceph/pull/27708), Sage Weil)
-   doc: doc/index: remove quick start from front page for now
    ([pr#33207](https://github.com/ceph/ceph/pull/33207), Sage Weil)
-   doc: doc/install/containers: add summary of containers and branches
    ([pr#31465](https://github.com/ceph/ceph/pull/31465), Sage Weil)
-   doc: doc/install/containers: note vX.Y.Z\[-YYYYMMDD\] tags
    ([pr#31975](https://github.com/ceph/ceph/pull/31975), Sage Weil)
-   doc: doc/install/manual-deployment: Change owner to ceph for the
    keyring file ([pr#31452](https://github.com/ceph/ceph/pull/31452),
    Jeffrey Chu)
-   doc: doc/install/upgrading-ceph: systemctl in Ubuntu instructions
    ([pr#32595](https://github.com/ceph/ceph/pull/32595), Rodrigo
    Severo)
-   doc: doc/install: rethink install doc installation methods order
    ([pr#33890](https://github.com/ceph/ceph/pull/33890), Zac Dover,
    Sebastian Wagner)
-   doc: doc/man/ceph: document ceph config
    ([pr#30645](https://github.com/ceph/ceph/pull/30645), Kefu Chai)
-   doc: doc/man: improve bluefs-bdev-expand option
    ([pr#32590](https://github.com/ceph/ceph/pull/32590), Kefu Chai)
-   doc: doc/mgr/ansible.rst: fix typo
    ([pr#28827](https://github.com/ceph/ceph/pull/28827), Lan Liu)
-   doc: doc/mgr/cephadm: document adoption process
    ([pr#33459](https://github.com/ceph/ceph/pull/33459), Sage Weil)
-   doc: doc/mgr/orchestrator.rst: updated current implementation status
    ([pr#33410](https://github.com/ceph/ceph/pull/33410), Kai Wagner)
-   doc: doc/mgr/orchestrator: Add Cephfs
    ([pr#33574](https://github.com/ceph/ceph/pull/33574), Sebastian
    Wagner)
-   doc: doc/mgr/orchestrator_cli: Rook orch supports mon update
    ([issue#39137](http://tracker.ceph.com/issues/39137),
    [pr#27431](https://github.com/ceph/ceph/pull/27431), Sebastian
    Wagner)
-   doc: doc/mgr/telemetry: added device channel details
    ([pr#33113](https://github.com/ceph/ceph/pull/33113), Yaarit Hatuka)
-   doc: doc/mgr/telemetry: update default interval
    ([pr#31008](https://github.com/ceph/ceph/pull/31008), Tim Serong)
-   doc: doc/mgr: Enhance placement specs
    ([pr#33924](https://github.com/ceph/ceph/pull/33924), Sebastian
    Wagner)
-   doc: doc/orchestrator: Fix broken bullet points
    ([issue#39094](http://tracker.ceph.com/issues/39094),
    [pr#27121](https://github.com/ceph/ceph/pull/27121), Sebastian
    Wagner)
-   doc: doc/orchestrator: Fix various issues in Orchestrator CLI
    documentation ([pr#31353](https://github.com/ceph/ceph/pull/31353),
    Volker Theile)
-   doc: doc/orchestrator: Sync status with reality
    ([pr#30281](https://github.com/ceph/ceph/pull/30281), Sebastian
    Wagner)
-   doc: doc/orchestrator: update rgw creation
    ([pr#33540](https://github.com/ceph/ceph/pull/33540), Yehuda Sadeh)
-   doc: doc/rados/api/python: Add documentation for mon_command
    ([pr#26934](https://github.com/ceph/ceph/pull/26934), Sebastian
    Wagner)
-   doc: doc/rados/configuration/osd-config-ref.rst: document
    osd_delete_sleep
    ([pr#28775](https://github.com/ceph/ceph/pull/28775), Neha Ojha)
-   doc: doc/rados/configuration: fix typo in mon-lookup-dns
    ([pr#27362](https://github.com/ceph/ceph/pull/27362), Vanush Misha
    Paturyan)
-   doc: doc/rados/configuration: fix typos in osd-config-ref.rst
    ([pr#28805](https://github.com/ceph/ceph/pull/28805), Lan Liu)
-   doc: doc/rados/configuration: update to be in sync with ConfUtils
    changes ([pr#28753](https://github.com/ceph/ceph/pull/28753), Kefu
    Chai)
-   doc: doc/rados/deployment/ceph-deploy-mon: fix typo
    ([pr#31164](https://github.com/ceph/ceph/pull/31164), Kefu Chai)
-   doc: doc/rados/operations/crush-map-edits: recompile and set
    instructions ([pr#32451](https://github.com/ceph/ceph/pull/32451),
    Rodrigo Severo)
-   doc: doc/rados/operations/devices: document device failure
    prediction ([pr#27472](https://github.com/ceph/ceph/pull/27472),
    Sage Weil)
-   doc: doc/rados/operations/erasure-code.rst: allow recovery below
    min_size ([pr#28750](https://github.com/ceph/ceph/pull/28750), Greg
    Farnum, Neha Ojha)
-   doc: doc/rados/operations: add safe-to-destroy check to OSD
    replacement workflow
    ([pr#28491](https://github.com/ceph/ceph/pull/28491), Sage Weil)
-   doc: doc/rados/operations: crush_rule is a name
    ([pr#29367](https://github.com/ceph/ceph/pull/29367), Kefu Chai)
-   doc: doc/rados/operations: document BLUEFS_SPILLOVER
    ([pr#27316](https://github.com/ceph/ceph/pull/27316), Sage Weil)
-   doc: doc/rados/operations: min_size is applicable to EC
    ([pr#33543](https://github.com/ceph/ceph/pull/33543), Brad Hubbard)
-   doc: doc/rados/operations: OSD_OUT_OF_ORDER_FULL fullness order is
    wrong ([pr#31588](https://github.com/ceph/ceph/pull/31588), Tsung-Ju
    Lii)
-   doc: doc/rados: Better block.db size recommendations for bluestore
    ([pr#32226](https://github.com/ceph/ceph/pull/32226), Neha Ojha)
-   doc: doc/rados: Correcting some typos in the clay code documentation
    ([pr#29889](https://github.com/ceph/ceph/pull/29889), Myna)
-   doc: doc/rados: update osd_min_pg_log_entries and add
    osd_max_pg_log_entries
    ([pr#32790](https://github.com/ceph/ceph/pull/32790), Neha Ojha)
-   doc: doc/radosgw/admin:fix how to modify subuser info
    ([pr#29839](https://github.com/ceph/ceph/pull/29839), Feng Hualong)
-   doc: doc/radosgw/compression.rst: fix typo
    ([pr#28749](https://github.com/ceph/ceph/pull/28749), hydro-)
-   doc: doc/radosgw/config-ref: paragraph to explain the gc settings
    ([pr#32367](https://github.com/ceph/ceph/pull/32367), Kai Wagner)
-   doc: doc/radosgw/multisite-sync-policy.rst: fix typo
    ([pr#33230](https://github.com/ceph/ceph/pull/33230), Liu Lan)
-   doc: doc/radosgw: fix typos
    ([pr#30642](https://github.com/ceph/ceph/pull/30642), Liu Lan)
-   doc: doc/radosgw: update documentation examples with the current S3
    PHP client ([pr#25985](https://github.com/ceph/ceph/pull/25985),
    Laurent VOULLEMIER)
-   doc: doc/rbd/rbd-cloudstack: update disk offering URL to new docs
    ([pr#27713](https://github.com/ceph/ceph/pull/27713), Kefu Chai)
-   doc: doc/rbd: document the new snapshot-based mirroring feature
    ([pr#33561](https://github.com/ceph/ceph/pull/33561), Jason
    Dillaman)
-   doc: doc/rbd: fix small typos
    ([pr#33689](https://github.com/ceph/ceph/pull/33689), songweibin)
-   doc: doc/rbd: initial kubernetes / ceph-csi integration
    documentation ([pr#29429](https://github.com/ceph/ceph/pull/29429),
    Jason Dillaman)
-   doc: doc/rbd: re-organize top-level and add live-migration docs
    ([issue#40486](http://tracker.ceph.com/issues/40486),
    [pr#29135](https://github.com/ceph/ceph/pull/29135), Jason Dillaman)
-   doc: doc/rbd: refine rbd/libvirt usage
    ([pr#32273](https://github.com/ceph/ceph/pull/32273), Changcheng
    Liu)
-   doc: doc/rbd: s/guess/xml/ for codeblock lexer
    ([pr#30953](https://github.com/ceph/ceph/pull/30953), Kefu Chai)
-   doc: doc/rbd: simplify libvirt usage
    ([pr#32142](https://github.com/ceph/ceph/pull/32142), Changcheng
    Liu)
-   doc: doc/rbd: update krbd version support for RBD features
    ([issue#40802](http://tracker.ceph.com/issues/40802),
    [pr#29083](https://github.com/ceph/ceph/pull/29083), Jason Dillaman)
-   doc: doc/release/nautilus: 14.2.2 changes redone
    ([pr#29145](https://github.com/ceph/ceph/pull/29145), Sage Weil)
-   doc: doc/release/octopus: note about upgrade times
    ([pr#33401](https://github.com/ceph/ceph/pull/33401), Sage Weil)
-   doc: doc/releases/nautilus,PendingReleaseNotes: consolidate
    telemetry note ([pr#32160](https://github.com/ceph/ceph/pull/32160),
    Sage Weil)
-   doc: doc/releases/nautilus.rst: fix command to check
    min_compat_client
    ([pr#28526](https://github.com/ceph/ceph/pull/28526), Osama Elswah)
-   doc: doc/releases/nautilus.rst: remove a redundant \\\*
    ([pr#32577](https://github.com/ceph/ceph/pull/32577), Servesha
    Dudhgaonkar)
-   doc: doc/releases/nautilus: Correct a systemctl command in an
    upgrade guide ([pr#27773](https://github.com/ceph/ceph/pull/27773),
    Teeranai Kormongkolkul)
-   doc: doc/releases/nautilus: final notes for v14.2.0
    ([pr#27019](https://github.com/ceph/ceph/pull/27019), Sage Weil)
-   doc: doc/releases/nautilus: fix config update step
    ([pr#27495](https://github.com/ceph/ceph/pull/27495), Sage Weil)
-   doc: doc/releases/nautilus: fix release notes (crash-\>device)
    ([pr#32148](https://github.com/ceph/ceph/pull/32148), Sage Weil)
-   doc: doc/releases/octopus.rst: add note about ec recovery below
    min_size ([pr#34092](https://github.com/ceph/ceph/pull/34092), Neha
    Ojha)
-   doc: doc/releases/octopus.rst: format tweaks
    ([pr#33971](https://github.com/ceph/ceph/pull/33971), Kefu Chai)
-   doc: doc/releases/octopus.rst: formatting tweaks
    ([pr#33987](https://github.com/ceph/ceph/pull/33987), Kefu Chai)
-   doc: doc/releases/octopus: add additional RBD improvements
    ([pr#34032](https://github.com/ceph/ceph/pull/34032), Jason
    Dillaman)
-   doc: doc/releases/schedule.rst: add 14.2.3, 14.2.4, 15.0.0 and drop
    dumpling ([pr#30430](https://github.com/ceph/ceph/pull/30430),
    Nathan Cutler)
-   doc: doc/releases: access main releases page from top-level TOC
    ([pr#30598](https://github.com/ceph/ceph/pull/30598), Nathan Cutler)
-   doc: doc/releases: add 14.2.8 to release timeline
    ([pr#33721](https://github.com/ceph/ceph/pull/33721), Nathan Cutler)
-   doc: doc/releases: add mimic v13.2.7 to releases timeline
    ([pr#31872](https://github.com/ceph/ceph/pull/31872), Nathan Cutler)
-   doc: doc/releases: add release notes for mimic v13.2.7
    ([pr#31777](https://github.com/ceph/ceph/pull/31777), Nathan Cutler)
-   doc: doc/releases: add release notes for mimic v13.2.8
    ([pr#32040](https://github.com/ceph/ceph/pull/32040), Nathan Cutler)
-   doc: doc/releases: add release notes for nautilus v14.2.5
    ([pr#31970](https://github.com/ceph/ceph/pull/31970), Nathan Cutler)
-   doc: doc/releases: Ceph Nautilus v14.2.4 Release Notes
    ([pr#30429](https://github.com/ceph/ceph/pull/30429), Nathan Cutler)
-   doc: doc/releases: octopus draft notes
    ([pr#33043](https://github.com/ceph/ceph/pull/33043), Sage Weil)
-   doc: doc/releases: Octopus is not stable yet
    ([pr#33729](https://github.com/ceph/ceph/pull/33729), Nathan Cutler)
-   doc: doc/releases: update for 12 month cycle
    ([pr#28864](https://github.com/ceph/ceph/pull/28864), Sage Weil)
-   doc: doc/rgw: add design doc for multisite resharding
    ([pr#33539](https://github.com/ceph/ceph/pull/33539), Casey Bodley)
-   doc: doc/rgw: document CreateBucketConfiguration for s3 PUT Bucket
    api ([issue#39597](http://tracker.ceph.com/issues/39597),
    [pr#27977](https://github.com/ceph/ceph/pull/27977), Casey Bodley)
-   doc: doc/rgw: document use of realm pull instead of period pull
    ([issue#39655](http://tracker.ceph.com/issues/39655),
    [pr#28052](https://github.com/ceph/ceph/pull/28052), Casey Bodley)
-   doc: doc/rgw: fix broken link to boto s3 extensions document
    ([pr#32740](https://github.com/ceph/ceph/pull/32740), Casey Bodley)
-   doc: doc/rgw: update civetweb rgw_frontends config example
    ([pr#27054](https://github.com/ceph/ceph/pull/27054), Casey Bodley)
-   doc: doc/start/documenting-ceph.rst: make better doc recommendations
    ([pr#30273](https://github.com/ceph/ceph/pull/30273), Neha Ojha)
-   doc: doc/start/hardware-recommendations.rst: minor tweaks
    ([pr#30837](https://github.com/ceph/ceph/pull/30837), Amrita
    Sakthivel)
-   doc: doc/\_templates/page.html: redirect to etherpad
    ([pr#32197](https://github.com/ceph/ceph/pull/32197), Neha Ojha)
-   doc: Doc: Add Nautilus 14.2.2 to schedule and releases
    ([issue#40988](http://tracker.ceph.com/issues/40988),
    [pr#29362](https://github.com/ceph/ceph/pull/29362), JuanJose
    Galvez)
-   doc: Doc: update release schedule
    ([pr#28466](https://github.com/ceph/ceph/pull/28466), Torben
    Hxc3xb8rup)
-   doc: docs: fix rgw_ldap_dnattr username token
    ([pr#27964](https://github.com/ceph/ceph/pull/27964), Thomas
    Kriechbaumer)
-   doc: docs: improve rgw ldap auth options
    ([pr#28157](https://github.com/ceph/ceph/pull/28157), Thomas
    Kriechbaumer)
-   doc: docs: rgw: fix bucket operation spelling:
    ListBucketMultipartUploads
    ([pr#28885](https://github.com/ceph/ceph/pull/28885), Thomas
    Kriechbaumer)
-   doc: docs: Update au.ceph.com maintainers, update README.md
    ([pr#32814](https://github.com/ceph/ceph/pull/32814), Matthew
    Taylor)
-   doc: Document Export Process during Subtree Migrations
    ([pr#30751](https://github.com/ceph/ceph/pull/30751), Sidharth
    Anupkrishnan)
-   doc: document mds journal event types
    ([issue#42190](http://tracker.ceph.com/issues/42190),
    [pr#30749](https://github.com/ceph/ceph/pull/30749), Venky Shankar)
-   doc: document mds journaling
    ([issue#41783](http://tracker.ceph.com/issues/41783),
    [pr#30396](https://github.com/ceph/ceph/pull/30396), Venky Shankar)
-   doc: document mode param for rbd mirror image enable command
    ([pr#32735](https://github.com/ceph/ceph/pull/32735), Mykola Golub)
-   doc: document rank option for journal reset
    ([pr#31201](https://github.com/ceph/ceph/pull/31201), Patrick
    Donnelly)
-   doc: document the new \--addv argument
    ([issue#40568](http://tracker.ceph.com/issues/40568),
    [pr#28819](https://github.com/ceph/ceph/pull/28819), Luca Castoro)
-   doc: Documentation: Add missing ceph-volume lvm batch argument to
    ceph-volume.rst
    ([pr#29081](https://github.com/ceph/ceph/pull/29081), Andreas Krebs)
-   doc: Documentation: Centos ceph-deploys python dependencies
    ([pr#32591](https://github.com/ceph/ceph/pull/32591), Clxc3xa9ment
    Hampaxc3xaf)
-   doc: documentation: Updated Dashboard Features, improved flow
    ([pr#33919](https://github.com/ceph/ceph/pull/33919), Lenz Grimmer)
-   doc: drop and update troubleshooting
    ([pr#28900](https://github.com/ceph/ceph/pull/28900), Jos Collin)
-   doc: emphasize the importance of require-osd-release nautilus
    ([pr#32587](https://github.com/ceph/ceph/pull/32587), Zac Dover)
-   doc: fix a typo in a command
    ([pr#32230](https://github.com/ceph/ceph/pull/32230), taeuk_kim)
-   doc: Fix a typo in balancer documentation
    ([pr#30210](https://github.com/ceph/ceph/pull/30210), Francois
    Deppierraz)
-   doc: fix boot transition in mds state diagram
    ([pr#27685](https://github.com/ceph/ceph/pull/27685), Patrick
    Donnelly)
-   doc: fix errors in search page and use relative address for
    releases.json ([pr#33423](https://github.com/ceph/ceph/pull/33423),
    Kefu Chai)
-   doc: Fix for new ceph-devel mailing list
    ([pr#29492](https://github.com/ceph/ceph/pull/29492), David Zafman)
-   doc: Fix FUSE expansion
    ([pr#30473](https://github.com/ceph/ceph/pull/30473), Sidharth
    Anupkrishnan)
-   doc: fix Getting Started with CephFS
    ([pr#32457](https://github.com/ceph/ceph/pull/32457), Jos Collin)
-   doc: fix links in developer_guide
    ([pr#32728](https://github.com/ceph/ceph/pull/32728), Rishabh Dave)
-   doc: fix LRC documentation
    ([pr#27106](https://github.com/ceph/ceph/pull/27106), Danny Al-Gaaf)
-   doc: fix parameter to set pg autoscale mode
    ([pr#27422](https://github.com/ceph/ceph/pull/27422), Changcheng
    Liu)
-   doc: Fix rbd namespace documentation
    ([pr#29445](https://github.com/ceph/ceph/pull/29445), Ricardo
    Marques)
-   doc: Fix the pg states and auto repair config options
    ([issue#38896](http://tracker.ceph.com/issues/38896),
    [pr#27143](https://github.com/ceph/ceph/pull/27143), David Zafman)
-   doc: fix typo ([pr#28888](https://github.com/ceph/ceph/pull/28888),
    Jos Collin)
-   doc: fix typo in doc/radosgw/layout.rst
    ([pr#29932](https://github.com/ceph/ceph/pull/29932), ypdai)
-   doc: fix typo to auto scale pg number
    ([pr#31065](https://github.com/ceph/ceph/pull/31065), Changcheng
    Liu)
-   doc: fix typos ([pr#30583](https://github.com/ceph/ceph/pull/30583),
    Michael Prokop)
-   doc: fix urls ([pr#29300](https://github.com/ceph/ceph/pull/29300),
    Jos Collin)
-   doc: fixed \--read-only argument value in multisite doc
    ([pr#28655](https://github.com/ceph/ceph/pull/28655), Chenjiong
    Deng)
-   doc: fixed broken link in Swift Settings section
    ([pr#28774](https://github.com/ceph/ceph/pull/28774), James McClune)
-   doc: fixed broken links in nautilus release page
    ([pr#28074](https://github.com/ceph/ceph/pull/28074), James McClune)
-   doc: fixed broken reference link for Graphviz
    ([pr#32021](https://github.com/ceph/ceph/pull/32021), James McClune)
-   doc: fixed caps
    ([pr#27397](https://github.com/ceph/ceph/pull/27397), Servesha
    Dudhgaonkar)
-   doc: fixed telemetry module reference link
    ([pr#27624](https://github.com/ceph/ceph/pull/27624), James McClune)
-   doc: fixed typo in leadership names
    ([pr#27396](https://github.com/ceph/ceph/pull/27396), Servesha
    Dudhgaonkar)
-   doc: Fixes OSD node labels which based on the osd_devices name
    ([pr#23312](https://github.com/ceph/ceph/pull/23312), Siyu Sun)
-   doc: Fixes typo for ceph dashboard command
    ([pr#30292](https://github.com/ceph/ceph/pull/30292), Fabian Bonk)
-   doc: hide page contents for Ceph Internals
    ([pr#31046](https://github.com/ceph/ceph/pull/31046), Milind
    Changire)
-   doc: improve ceph-backport.sh comment block
    ([pr#28042](https://github.com/ceph/ceph/pull/28042), Nathan Cutler)
-   doc: improve developer guide doc
    ([pr#30435](https://github.com/ceph/ceph/pull/30435), Rishabh Dave)
-   doc: improve in mount.ceph man page
    ([pr#31024](https://github.com/ceph/ceph/pull/31024), Rishabh Dave)
-   doc: Improved the dashboard proxy config section
    ([pr#27581](https://github.com/ceph/ceph/pull/27581), Lenz Grimmer)
-   doc: indicate imperative mood for commit titles
    ([pr#29509](https://github.com/ceph/ceph/pull/29509), Patrick
    Donnelly)
-   doc: Make ceph-dashboard require grafana dashboards
    ([pr#28997](https://github.com/ceph/ceph/pull/28997), Boris Ranto)
-   doc: mds-config-ref: update mds_log_max_segments value
    ([pr#29412](https://github.com/ceph/ceph/pull/29412), Konstantin
    Shalygin)
-   doc: mention \--namespace option in rados manpage
    ([pr#31871](https://github.com/ceph/ceph/pull/31871), Nathan Cutler)
-   doc: mgr/dashboard: Add frontend code documentation
    ([issue#36243](http://tracker.ceph.com/issues/36243),
    [pr#27433](https://github.com/ceph/ceph/pull/27433), Ernesto Puerta)
-   doc: mgr/dashboard: Document UiApiController with ApiController
    usage ([pr#29819](https://github.com/ceph/ceph/pull/29819), Stephan
    Mxc3xbcller)
-   doc: mgr/dashboard: Extend Writing End-to-End Tests section
    (describe vs it)
    ([pr#29707](https://github.com/ceph/ceph/pull/29707), Adam King,
    Rafael Quintero)
-   doc: mgr/dashboard: fix hacking.rst
    ([pr#27222](https://github.com/ceph/ceph/pull/27222), Ernesto
    Puerta)
-   doc: mgr/dashboard: Fix link format to HACKING.rst
    ([pr#28897](https://github.com/ceph/ceph/pull/28897), Ernesto
    Puerta)
-   doc: mgr/dashboard: fix typos in HACKING.rst
    ([pr#30847](https://github.com/ceph/ceph/pull/30847), Ernesto
    Puerta)
-   doc: mgr/orchestrator: Add error handling to interface
    ([pr#26404](https://github.com/ceph/ceph/pull/26404), Sebastian
    Wagner)
-   doc: mgr/orchestrator: Fix disabling the orchestrator
    ([issue#40779](http://tracker.ceph.com/issues/40779),
    [pr#29042](https://github.com/ceph/ceph/pull/29042), Sebastian
    Wagner)
-   doc: mgr/orchestrator_cli: Update doc link in README
    ([pr#31731](https://github.com/ceph/ceph/pull/31731), Varsha Rao)
-   doc: mgr/ssh: HACKING.rst: Add Understanding
    [AsyncCompletion]{.title-ref}
    ([pr#31967](https://github.com/ceph/ceph/pull/31967), Sebastian
    Wagner)
-   doc: mgr/ssh: update ssh-orch bootstrap guide (Vagrantfile & docs)
    ([pr#31457](https://github.com/ceph/ceph/pull/31457), Joshua Schmid)
-   doc: mgr/telemetry: force \--license when sending while opted-out
    ([pr#33747](https://github.com/ceph/ceph/pull/33747), Yaarit Hatuka)
-   doc: minor fix in mount.ceph
    ([pr#32748](https://github.com/ceph/ceph/pull/32748), Rishabh Dave)
-   doc: Miscellaneous spelling fixes
    ([pr#27202](https://github.com/ceph/ceph/pull/27202), Bryan
    Stillwell)
-   doc: Modify nature theme
    ([pr#32312](https://github.com/ceph/ceph/pull/32312), Brad Hubbard)
-   doc: mon/OSDMonitor: Fix pool set target_size_bytes (etc) with unit
    suffix ([pr#30701](https://github.com/ceph/ceph/pull/30701),
    Prashant D)
-   doc: mounting CephFS subdirectory and Persistent Mounts cleanup
    ([pr#32498](https://github.com/ceph/ceph/pull/32498), Jos Collin)
-   doc: Move ceph-deploy docs to doc/install/ceph-deploy
    ([pr#33953](https://github.com/ceph/ceph/pull/33953), Sebastian
    Wagner)
-   doc: move cephadm files to its own directory
    ([pr#33551](https://github.com/ceph/ceph/pull/33551), Alexandra
    Settle, Sebastian Wagner)
-   doc: move Developer Guide to its own subdirectory
    ([pr#27159](https://github.com/ceph/ceph/pull/27159), Nathan Cutler)
-   doc: nautilus 14.2.2 release notes, take three
    ([pr#29171](https://github.com/ceph/ceph/pull/29171), Nathan Cutler)
-   doc: Nautilus mailmaps
    ([pr#27092](https://github.com/ceph/ceph/pull/27092), Abhishek
    Lekshmanan)
-   doc: note explicitly that profile rbd allows blacklisting
    ([pr#28296](https://github.com/ceph/ceph/pull/28296), Matthew
    Vernon)
-   doc: obsolete entries for allow_standby_replay
    ([pr#31897](https://github.com/ceph/ceph/pull/31897), Rodrigo
    Severo)
-   doc: operations: correct comma-delimited
    ([pr#29644](https://github.com/ceph/ceph/pull/29644), Anthony DAtri)
-   doc: operations: improve reweight-by-utilization
    ([pr#27657](https://github.com/ceph/ceph/pull/27657), Anthony DAtri)
-   doc: PendingReleaseNotes: 14.2.1 note on crush required version
    ([pr#27649](https://github.com/ceph/ceph/pull/27649), Sage Weil)
-   doc: PendingReleaseNotes: fix typo
    ([pr#31853](https://github.com/ceph/ceph/pull/31853), Sage Weil)
-   doc: PendingReleaseNotes: note on python3.6 changes
    ([issue#39164](http://tracker.ceph.com/issues/39164),
    [pr#27490](https://github.com/ceph/ceph/pull/27490), Kefu Chai)
-   doc: pg_num should always be a power of two
    ([pr#29364](https://github.com/ceph/ceph/pull/29364), Lars
    Marowsky-Bree, Kai Wagner)
-   doc: QAT Acceleration for Encryption and Compression
    ([pr#26967](https://github.com/ceph/ceph/pull/26967), Qiaowei Ren)
-   doc: quick-rbd.rst de-duplicate
    ([pr#32965](https://github.com/ceph/ceph/pull/32965), Tim)
-   doc: RBD exclusive locks
    ([pr#31893](https://github.com/ceph/ceph/pull/31893), Florian Haas)
-   doc: README.md: remove stale cmake prerequisite
    ([pr#32751](https://github.com/ceph/ceph/pull/32751), Kefu Chai)
-   doc: release note: Add pending release notes for already merged code
    ([pr#32041](https://github.com/ceph/ceph/pull/32041), David Zafman)
-   doc: release notes for 14.2.1
    ([pr#27793](https://github.com/ceph/ceph/pull/27793), Abhishek
    Lekshmanan)
-   doc: release notes for Luminous v12.2.13
    ([pr#33030](https://github.com/ceph/ceph/pull/33030), Nathan Cutler)
-   doc: release notes for nautilus 14.2.2
    ([pr#29011](https://github.com/ceph/ceph/pull/29011), Sage Weil,
    Nathan Cutler)
-   doc: release notes for Nautilus 14.2.7
    ([pr#33031](https://github.com/ceph/ceph/pull/33031), Nathan Cutler)
-   doc: release notes for v14.2.3 nautilus
    ([pr#29973](https://github.com/ceph/ceph/pull/29973), Abhishek
    Lekshmanan)
-   doc: release notes for v14.2.6
    ([pr#32551](https://github.com/ceph/ceph/pull/32551), Abhishek
    Lekshmanan)
-   doc: releases/luminous: release notes for 12.2.12
    ([pr#27553](https://github.com/ceph/ceph/pull/27553), Abhishek
    Lekshmanan)
-   doc: releases: 14.2.3 dashboard note
    ([pr#30145](https://github.com/ceph/ceph/pull/30145), Abhishek
    Lekshmanan)
-   doc: releases: v14.2.8 release notes
    ([pr#33670](https://github.com/ceph/ceph/pull/33670), Abhishek
    Lekshmanan)
-   doc: relicense LGPL-2.1 code as LGPL-2.1 or LGPL-3.0
    ([pr#22446](https://github.com/ceph/ceph/pull/22446), Sage Weil)
-   doc: remove prod cluster examples from hardware recs
    ([pr#32670](https://github.com/ceph/ceph/pull/32670), Zac Dover)
-   doc: remove recommendation for kernel.pid_max
    ([pr#27965](https://github.com/ceph/ceph/pull/27965), Ben England)
-   doc: remove reference to obsolete scrub command
    ([pr#32508](https://github.com/ceph/ceph/pull/32508), Patrick
    Donnelly)
-   doc: remove the CephFS-Hadoop instructions
    ([pr#32980](https://github.com/ceph/ceph/pull/32980), Greg Farnum)
-   doc: removed OpenStack Kilo references in Keystone docs
    ([pr#27203](https://github.com/ceph/ceph/pull/27203), James McClune)
-   doc: removes kube-helm installation instructions
    ([pr#32009](https://github.com/ceph/ceph/pull/32009), Zac Dover)
-   doc: reorganize CephFS landing page and ToC
    ([pr#32038](https://github.com/ceph/ceph/pull/32038), Patrick
    Donnelly)
-   doc: Revert doc: do not add suffix for search result links
    ([pr#33562](https://github.com/ceph/ceph/pull/33562), Jason
    Dillaman)
-   doc: rgw/pubsub: add S3 compliant API to master zone
    ([pr#28971](https://github.com/ceph/ceph/pull/28971), Yuval
    Lifshitz)
-   doc: rgw/pubsub: clarify pubsub zone configuration
    ([pr#27493](https://github.com/ceph/ceph/pull/27493), Yuval
    Lifshitz)
-   doc: rgw/pubsub: fix topic arn. tenant support to multisite tests
    ([pr#27671](https://github.com/ceph/ceph/pull/27671), Yuval
    Lifshitz)
-   doc: rgw: Fixed bug on wrong name for user_id for OPA
    ([pr#31972](https://github.com/ceph/ceph/pull/31972), Seena Fallah)
-   doc: s/achieve/achieves/ (Fixed a verb disagreement)
    ([pr#32036](https://github.com/ceph/ceph/pull/32036), Zac Dover)
-   doc: script/ceph-backport.sh: add Troubleshooting notes
    ([pr#29948](https://github.com/ceph/ceph/pull/29948), Nathan Cutler)
-   doc: set ceph_perf_msgr_server arguments
    ([pr#29847](https://github.com/ceph/ceph/pull/29847), Changcheng
    Liu)
-   doc: show how to count jobs before triggering them
    ([pr#32145](https://github.com/ceph/ceph/pull/32145), Rishabh Dave)
-   doc: Show Jenkins commands
    ([pr#29423](https://github.com/ceph/ceph/pull/29423), Ernesto
    Puerta)
-   doc: Small update of SubmittingPatches-backports
    ([pr#31163](https://github.com/ceph/ceph/pull/31163), Laura Paduano)
-   doc: split up SubmittingPatches.rst
    ([issue#20953](http://tracker.ceph.com/issues/20953),
    [pr#30705](https://github.com/ceph/ceph/pull/30705), Nathan Cutler)
-   doc: Switch spelling of utilization
    ([pr#32537](https://github.com/ceph/ceph/pull/32537), Bryan
    Stillwell)
-   doc: tools/rados: add \--pgid in help
    ([pr#30383](https://github.com/ceph/ceph/pull/30383), Vikhyat Umrao)
-   doc: typo fix in doc/dev/dev_cluster_deployement.rst:
    s/hostanme/hostname/
    ([pr#31515](https://github.com/ceph/ceph/pull/31515), Drunkard
    Zhang)
-   doc: update \--force flag to be precise
    ([pr#32343](https://github.com/ceph/ceph/pull/32343), Jos Collin)
-   doc: update adding an MDS
    ([pr#32291](https://github.com/ceph/ceph/pull/32291), Jos Collin)
-   doc: update and improve mounting with fuse/kernel docs
    ([pr#30754](https://github.com/ceph/ceph/pull/30754), Rishabh Dave)
-   doc: update bluestore cache settings and clarify data fraction
    ([issue#39522](http://tracker.ceph.com/issues/39522),
    [pr#27859](https://github.com/ceph/ceph/pull/27859), Jan Fajerski)
-   doc: update ceph ansible iscsi info
    ([pr#28665](https://github.com/ceph/ceph/pull/28665), Mike Christie)
-   doc: Update ceph-deploy docs from dumpling to nautilus
    ([pr#30269](https://github.com/ceph/ceph/pull/30269), Danny
    Abukalam)
-   doc: Update ceph-iscsi min version
    ([pr#29195](https://github.com/ceph/ceph/pull/29195), Ricardo
    Marques)
-   doc: update CephFS overview in introductory page
    ([pr#30014](https://github.com/ceph/ceph/pull/30014), Patrick
    Donnelly)
-   doc: update CephFS Quick Start doc
    ([pr#30406](https://github.com/ceph/ceph/pull/30406), Rishabh Dave)
-   doc: Update commands in bootstrap.rst
    ([pr#31800](https://github.com/ceph/ceph/pull/31800), Zac Dover)
-   doc: update default container images
    ([pr#33974](https://github.com/ceph/ceph/pull/33974), Sage Weil)
-   doc: Update documentation for LazyIO methods lazyio_synchronize()
    and lazyio_propagate()
    ([pr#29711](https://github.com/ceph/ceph/pull/29711), Sidharth
    Anupkrishnan)
-   doc: update documentation for the MANY_OBJECTS_PER_PG warning
    ([pr#27403](https://github.com/ceph/ceph/pull/27403), Vangelis
    Tasoulas)
-   doc: update documents on using kcephfs
    ([pr#30626](https://github.com/ceph/ceph/pull/30626), Jeff Layton)
-   doc: update erasure-code-profile.rst
    ([pr#33707](https://github.com/ceph/ceph/pull/33707), Guillaume
    Abrioux)
-   doc: Update link to Red Hat documentation
    ([pr#27976](https://github.com/ceph/ceph/pull/27976), Yaniv Kaul)
-   doc: update list of formats for \--format flag for ceph pg dump
    ([pr#32373](https://github.com/ceph/ceph/pull/32373), Zac Dover)
-   doc: Update mailing lists
    ([pr#31666](https://github.com/ceph/ceph/pull/31666), hrchu)
-   doc: update mondb recovery script
    ([pr#28515](https://github.com/ceph/ceph/pull/28515), Hannes von
    Haugwitz)
-   doc: Update mount CephFS index
    ([pr#28955](https://github.com/ceph/ceph/pull/28955), Jos Collin)
-   doc: Update python-rtsli and tcmu-runner min versions
    ([pr#28494](https://github.com/ceph/ceph/pull/28494), Ricardo
    Marques)
-   doc: Update requirements for using CephFS
    ([pr#30251](https://github.com/ceph/ceph/pull/30251), Varsha Rao)
-   doc: update with osd addition
    ([pr#31244](https://github.com/ceph/ceph/pull/31244), Changcheng
    Liu)
-   doc: update with zone bucket and straw2 addition
    ([pr#31177](https://github.com/ceph/ceph/pull/31177), Changcheng
    Liu)
-   doc: update Zabbix template reference
    ([pr#33661](https://github.com/ceph/ceph/pull/33661), Mathijs Smit)
-   doc: updated ceph monitor config options
    ([pr#29982](https://github.com/ceph/ceph/pull/29982), James McClune)
-   doc: Updated dashboard iSCSI configuration, added labels
    ([pr#27074](https://github.com/ceph/ceph/pull/27074), Lenz Grimmer)
-   doc: updated OpenStack rbd documentation
    ([pr#28979](https://github.com/ceph/ceph/pull/28979), James McClune)
-   doc: updated OS recommendations and distro list
    ([pr#28643](https://github.com/ceph/ceph/pull/28643), Kai Wagner)
-   doc: Updates link to Sepia la
    ([pr#28780](https://github.com/ceph/ceph/pull/28780), Varsha Rao)
-   doc: use subsection for representing components in release notes
    ([pr#33940](https://github.com/ceph/ceph/pull/33940), Kefu Chai)
-   doc: use the console lexer for rendering command line sessions
    ([pr#32141](https://github.com/ceph/ceph/pull/32141), Kefu Chai)
-   do_cmake.sh: fedora-32 (rawhide) build with python-3.8
    ([pr#32474](https://github.com/ceph/ceph/pull/32474), Kaleb S.
    Keithley)
-   errorator: improve general error handlers
    ([pr#33344](https://github.com/ceph/ceph/pull/33344), Samuel Just)
-   github/codeowners: Add orchestrator team
    ([pr#31441](https://github.com/ceph/ceph/pull/31441), Sebastian
    Wagner)
-   github: Add ceph-volume to list of jenkins commands
    ([pr#31191](https://github.com/ceph/ceph/pull/31191), Sebastian
    Wagner)
-   include/config-h.in.cmake: remove HAVE_XIO
    ([pr#28465](https://github.com/ceph/ceph/pull/28465), Kefu Chai)
-   include/utime: do not cast sec to time_t
    ([pr#27861](https://github.com/ceph/ceph/pull/27861), Kefu Chai)
-   include: buffer_raw.h: Copyright time fix
    ([pr#28481](https://github.com/ceph/ceph/pull/28481), Changcheng
    Liu)
-   install-deps.sh: remove failing error catching
    ([pr#29403](https://github.com/ceph/ceph/pull/29403), Ernesto
    Puerta)
-   Integrate PeeringState into crimson, fix related bugs
    ([pr#28180](https://github.com/ceph/ceph/pull/28180), Samuel Just)
-   krbd: do away with explicit memory management and other cleanups
    ([pr#31919](https://github.com/ceph/ceph/pull/31919), Ilya Dryomov)
-   librados: allow passing flags to operate sync APIs
    ([pr#33536](https://github.com/ceph/ceph/pull/33536), Yuval
    Lifshitz)
-   librados: fix leak in getxattr and getxattrs
    ([pr#32183](https://github.com/ceph/ceph/pull/32183), Adam Kupczyk)
-   librados: move buffer free functions to inline namespace
    ([issue#39972](http://tracker.ceph.com/issues/39972),
    [pr#28167](https://github.com/ceph/ceph/pull/28167), Jason Dillaman)
-   librados: prefer reinterpret_cast over c-style cast
    ([pr#33038](https://github.com/ceph/ceph/pull/33038), Kefu Chai)
-   librbd: add reference counting
    ([pr#30397](https://github.com/ceph/ceph/pull/30397), Mahati
    Chamarthy, Venky Shankar)
-   librbd: add snap_get_name and snap_get_id method API
    ([pr#31280](https://github.com/ceph/ceph/pull/31280), Zheng Yin)
-   librbd: added missing \<string\> include to PoolMetadata header
    ([pr#32614](https://github.com/ceph/ceph/pull/32614), Kaleb S.
    Keithley)
-   librbd: adjust the else-if conditions in validate_striping()
    ([pr#30053](https://github.com/ceph/ceph/pull/30053), mxdInspur)
-   librbd: always initialize local variables
    ([pr#31311](https://github.com/ceph/ceph/pull/31311), Kefu Chai)
-   librbd: always try to acquire exclusive lock when removing image
    ([pr#29775](https://github.com/ceph/ceph/pull/29775), Mykola Golub)
-   librbd: async open/close should free ImageCtx before issuing
    callback ([issue#39031](http://tracker.ceph.com/issues/39031),
    [pr#27682](https://github.com/ceph/ceph/pull/27682), Jason Dillaman)
-   librbd: avoid dereferencing an empty container during deep-copy
    ([issue#40368](http://tracker.ceph.com/issues/40368),
    [pr#28559](https://github.com/ceph/ceph/pull/28559), Jason Dillaman)
-   librbd: behave more gracefully when data pool removed
    ([pr#29613](https://github.com/ceph/ceph/pull/29613), Mykola Golub)
-   librbd: bump minor version to match octopus
    ([pr#32402](https://github.com/ceph/ceph/pull/32402), Jason
    Dillaman)
-   librbd: clean up unused variable
    ([pr#30019](https://github.com/ceph/ceph/pull/30019), mxdInspur)
-   librbd: clone copy-on-write operations should preserve sparseness
    ([pr#27999](https://github.com/ceph/ceph/pull/27999), Mykola Golub)
-   librbd: copyup read stats were incorrectly tied to child
    ([pr#27757](https://github.com/ceph/ceph/pull/27757), Jason
    Dillaman)
-   librbd: defer event socket completion until after callback issued
    ([pr#33994](https://github.com/ceph/ceph/pull/33994), Jason
    Dillaman)
-   librbd: diff iterate with fast-diff now correctly includes parent
    ([pr#32403](https://github.com/ceph/ceph/pull/32403), Jason
    Dillaman)
-   librbd: disable zero-copy writes by default
    ([pr#31794](https://github.com/ceph/ceph/pull/31794), Jason
    Dillaman)
-   librbd: dispatch delayed requests only if read intersects
    ([pr#27446](https://github.com/ceph/ceph/pull/27446), Mykola Golub)
-   librbd: do not allow to deep copy migrating image
    ([pr#27194](https://github.com/ceph/ceph/pull/27194), Mykola Golub)
-   librbd: do not unblock IO prior to growing object map during resize
    ([issue#39952](http://tracker.ceph.com/issues/39952),
    [pr#28295](https://github.com/ceph/ceph/pull/28295), Jason Dillaman)
-   librbd: dont call refresh from mirror::GetInfoRequest state machine
    ([pr#32734](https://github.com/ceph/ceph/pull/32734), Mykola Golub)
-   librbd: dont use complete_external_callback if ImageCtx destroyed
    ([pr#29263](https://github.com/ceph/ceph/pull/29263), Mykola Golub)
-   librbd: explicitly specify mode on mirror image enable
    ([pr#32217](https://github.com/ceph/ceph/pull/32217), Mykola Golub)
-   librbd: features converting bitmask and string API
    ([pr#31188](https://github.com/ceph/ceph/pull/31188), Zheng Yin)
-   librbd: finish write request early
    ([pr#32113](https://github.com/ceph/ceph/pull/32113), Li, Xiaoyan)
-   librbd: fix broken group snapshot handling
    ([pr#33448](https://github.com/ceph/ceph/pull/33448), Jason
    Dillaman)
-   librbd: fix build on freebsd
    ([pr#32938](https://github.com/ceph/ceph/pull/32938), Mykola Golub)
-   librbd: fix issues with object-map/fast-diff feature interlock
    ([issue#39521](http://tracker.ceph.com/issues/39521),
    [pr#28051](https://github.com/ceph/ceph/pull/28051), Jason Dillaman)
-   librbd: fix potential race conditions
    ([pr#33563](https://github.com/ceph/ceph/pull/33563), Mahati
    Chamarthy)
-   librbd: fix potential snapshot remove failure due to duplicate RPC
    messages ([pr#32760](https://github.com/ceph/ceph/pull/32760),
    Mykola Golub)
-   librbd: fix rbd_features_to_string output
    ([pr#31006](https://github.com/ceph/ceph/pull/31006), Zheng Yin)
-   librbd: fix rbd_open_by_id, rbd_open_by_id_read_only
    ([pr#32105](https://github.com/ceph/ceph/pull/32105), yangjun)
-   librbd: fix some edge cases for snapshot mirror mode promote
    ([pr#32567](https://github.com/ceph/ceph/pull/32567), Mykola Golub)
-   librbd: fix typo in deep_copy::ObjectCopyRequest::compute_read_ops
    ([pr#27049](https://github.com/ceph/ceph/pull/27049), Mykola Golub)
-   librbd: fixed several race conditions related to copyup
    ([issue#39021](http://tracker.ceph.com/issues/39021),
    [pr#27357](https://github.com/ceph/ceph/pull/27357), Jason Dillaman)
-   librbd: force reacquire lock if blacklist is disabled
    ([pr#30955](https://github.com/ceph/ceph/pull/30955), luo.runbing)
-   librbd: implement ordering for overlapping IOs
    ([pr#28952](https://github.com/ceph/ceph/pull/28952), Mahati
    Chamarthy)
-   librbd: improve journal performance to match expected degradation
    ([issue#40072](http://tracker.ceph.com/issues/40072),
    [pr#28539](https://github.com/ceph/ceph/pull/28539), Jason Dillaman)
-   librbd: improved support for balanced and localized reads
    ([pr#33493](https://github.com/ceph/ceph/pull/33493), Zheng Yin)
-   librbd: initial consolidation of internal locks
    ([pr#27756](https://github.com/ceph/ceph/pull/27756), Jason
    Dillaman)
-   librbd: introduce new default write-around cache policy
    ([pr#27229](https://github.com/ceph/ceph/pull/27229), Jason
    Dillaman)
-   librbd: leak on canceling simple io scheduler timer task
    ([pr#27755](https://github.com/ceph/ceph/pull/27755), Mykola Golub)
-   librbd: look for mirror peers in default namespace
    ([pr#32338](https://github.com/ceph/ceph/pull/32338), Mykola Golub)
-   librbd: look for pool metadata in default namespace
    ([pr#27151](https://github.com/ceph/ceph/pull/27151), Mykola Golub)
-   librbd: make flush be queued by QOS throttler
    ([pr#26931](https://github.com/ceph/ceph/pull/26931), Mykola Golub)
-   librbd: mirror image enable/disable should enable/disable journaling
    ([pr#28553](https://github.com/ceph/ceph/pull/28553), Mykola Golub)
-   librbd: optimize image copy state machine to use fast-diff
    ([pr#33867](https://github.com/ceph/ceph/pull/33867), Jason
    Dillaman)
-   librbd: optionally move parent image to trash on remove
    ([pr#27521](https://github.com/ceph/ceph/pull/27521), Mykola Golub)
-   librbd: prevent concurrent AIO callbacks to external clients
    ([issue#40417](http://tracker.ceph.com/issues/40417),
    [pr#28743](https://github.com/ceph/ceph/pull/28743), Jason Dillaman)
-   librbd: Remove duplicated AsyncOpTracker in librbd/Utils.h
    ([pr#29653](https://github.com/ceph/ceph/pull/29653), Xiaoyan Li)
-   librbd: remove pool objects when removing a namespace
    ([pr#32401](https://github.com/ceph/ceph/pull/32401), Jason
    Dillaman)
-   librbd: shared read-only cache hook
    ([pr#27285](https://github.com/ceph/ceph/pull/27285), Dehao Shang,
    Yuan Zhou)
-   librbd: silence -Wunused-variable warnings
    ([pr#27513](https://github.com/ceph/ceph/pull/27513), David
    Disseldorp)
-   librbd: simple scheduler plugin for object dispatcher layer
    ([pr#26675](https://github.com/ceph/ceph/pull/26675), Mykola Golub)
-   librbd: snapshot object maps can go inconsistent during copyup
    ([issue#39435](http://tracker.ceph.com/issues/39435),
    [pr#27724](https://github.com/ceph/ceph/pull/27724), Ilya Dryomov)
-   librbd: support compression allocation hints to the OSD
    ([pr#32687](https://github.com/ceph/ceph/pull/32687), Jason
    Dillaman)
-   librbd: support EC data pool images sparsify
    ([pr#27268](https://github.com/ceph/ceph/pull/27268), Mykola Golub)
-   librbd: support zero-copy writes via the C API
    ([pr#27895](https://github.com/ceph/ceph/pull/27895), Jason
    Dillaman)
-   librbd: trash move return EBUSY instead of EINVAL for migrating
    image ([pr#27136](https://github.com/ceph/ceph/pull/27136), Mykola
    Golub)
-   librbd: tweak deep-copy to avoid creating last snapshot until sync
    is complete ([pr#33097](https://github.com/ceph/ceph/pull/33097),
    Jason Dillaman)
-   librbd: tweaks to increase IOPS and reduce CPU usage
    ([pr#28044](https://github.com/ceph/ceph/pull/28044), Jason
    Dillaman)
-   librbd: use custom allocator for aligned boost::lockfree::queue
    ([issue#39703](http://tracker.ceph.com/issues/39703),
    [pr#28093](https://github.com/ceph/ceph/pull/28093), Jason Dillaman)
-   librbd: v1 clones are restricted to the same namespace
    ([pr#30711](https://github.com/ceph/ceph/pull/30711), Jason
    Dillaman)
-   librbd: when unlinking peer from mirror snaps do it in all
    namespaces ([pr#32463](https://github.com/ceph/ceph/pull/32463),
    Mykola Golub)
-   librbd:move all snapshot API functions in internal.cc over to
    api/Snapshot.cc
    ([pr#31589](https://github.com/ceph/ceph/pull/31589), Zheng Yin)
-   log: avoid logging anything when log_to_file=false
    ([pr#27133](https://github.com/ceph/ceph/pull/27133), Sage Weil)
-   log: fix store_statfs log line
    ([pr#28564](https://github.com/ceph/ceph/pull/28564), Mohamad Gebai)
-   log: just return if t is empty
    ([pr#31243](https://github.com/ceph/ceph/pull/31243), Xiubo Li)
-   log: print pthread ID / name mapping in recent events dump
    ([pr#32354](https://github.com/ceph/ceph/pull/32354), Radoslaw
    Zarzynski)
-   lvm deactivate command
    ([pr#32179](https://github.com/ceph/ceph/pull/32179), Jan Fajerski)
-   mds: add command that config individual client session
    ([issue#40811](http://tracker.ceph.com/issues/40811),
    [pr#29104](https://github.com/ceph/ceph/pull/29104), Yan, Zheng)
-   mds: add config to require forward to auth MDS
    ([pr#29995](https://github.com/ceph/ceph/pull/29995), simon gao)
-   mds: add configurable snapshot limit
    ([pr#30710](https://github.com/ceph/ceph/pull/30710), Milind
    Changire)
-   mds: add perf counter for finisher of MDSRank
    ([pr#29377](https://github.com/ceph/ceph/pull/29377), simon gao)
-   mds: add perf counters for openfiletable
    ([pr#33363](https://github.com/ceph/ceph/pull/33363), Milind
    Changire)
-   mds: add scrub_info_t into mempool
    ([pr#33180](https://github.com/ceph/ceph/pull/33180), Jun Su)
-   mds: answering all pending getattr/lookups targeting the same inode
    in one go ([issue#36608](http://tracker.ceph.com/issues/36608),
    [pr#24794](https://github.com/ceph/ceph/pull/24794), Patrick
    Donnelly, Xuehan Xu)
-   mds: apply configuration changes through MDSRank
    ([pr#28951](https://github.com/ceph/ceph/pull/28951), Patrick
    Donnelly)
-   mds: async dir operation support
    ([pr#27866](https://github.com/ceph/ceph/pull/27866), Yan, Zheng)
-   mds: async dirop support
    ([pr#32816](https://github.com/ceph/ceph/pull/32816), Yan, Zheng)
-   mds: avoid check session connections features when issuing caps
    ([pr#26881](https://github.com/ceph/ceph/pull/26881), Yan, Zheng)
-   mds: avoid revoking Fsx from loner during directory fragmentation
    ([pr#26817](https://github.com/ceph/ceph/pull/26817), Yan, Zheng)
-   mds: avoid sending too many osd requests at once after mds restarts
    ([issue#40028](http://tracker.ceph.com/issues/40028),
    [pr#27436](https://github.com/ceph/ceph/pull/27436), simon gao)
-   mds: better output of ceph health detail when some client is failing
    to advance oldest client/flush tid
    ([issue#39266](http://tracker.ceph.com/issues/39266),
    [pr#27537](https://github.com/ceph/ceph/pull/27537), Shen Hang)
-   mds: check dir fragment to split dir if mkdir makes it oversized
    ([pr#27480](https://github.com/ceph/ceph/pull/27480), Erqi Chen)
-   mds: check directory split after rename
    ([issue#38994](http://tracker.ceph.com/issues/38994),
    [pr#27214](https://github.com/ceph/ceph/pull/27214), Shen Hang)
-   mds: clarify comment
    ([pr#31401](https://github.com/ceph/ceph/pull/31401), Patrick
    Donnelly)
-   mds: cleanup truncating inodes when standby replay mds trim log
    segments ([pr#28686](https://github.com/ceph/ceph/pull/28686), Yan,
    Zheng)
-   mds: cleanup unneeded client_snap_caps when splitting snap inode
    ([issue#39987](http://tracker.ceph.com/issues/39987),
    [pr#28190](https://github.com/ceph/ceph/pull/28190), Yan, Zheng)
-   mds: complete all the replay op when mds is restarted
    ([issue#40784](http://tracker.ceph.com/issues/40784),
    [pr#29059](https://github.com/ceph/ceph/pull/29059), Shen Hang)
-   mds: convert unnecessary usage of std::list to std::vector
    ([pr#26895](https://github.com/ceph/ceph/pull/26895), Patrick
    Donnelly)
-   mds: count purge queue items left in journal
    ([issue#40121](http://tracker.ceph.com/issues/40121),
    [pr#28376](https://github.com/ceph/ceph/pull/28376), Zhi Zhang)
-   mds: delay exporting directory whose pin value exceeds max rank id
    ([issue#40603](http://tracker.ceph.com/issues/40603),
    [pr#28804](https://github.com/ceph/ceph/pull/28804), Zhi Zhang)
-   mds: display scrub status in ceph status
    ([pr#28855](https://github.com/ceph/ceph/pull/28855), Venky Shankar)
-   mds: do not include metric_spec in MClientSession from MDS
    ([pr#32659](https://github.com/ceph/ceph/pull/32659), Patrick
    Donnelly)
-   mds: dont add metadata to session close message
    ([pr#32318](https://github.com/ceph/ceph/pull/32318), Yan, Zheng)
-   mds: dont mark cap NEEDSNAPFLUSH if client has no pending capsnap
    ([pr#28551](https://github.com/ceph/ceph/pull/28551), Yan, Zheng)
-   mds: dont print subtrees if they are too big or too many
    ([pr#26056](https://github.com/ceph/ceph/pull/26056), Rishabh Dave)
-   mds: dont respond getattr with -EROFS when mds is readonly
    ([pr#32676](https://github.com/ceph/ceph/pull/32676), Yan, Zheng)
-   mds: drive cap recall while dropping cache
    ([pr#30389](https://github.com/ceph/ceph/pull/30389), Patrick
    Donnelly)
-   mds: evict an unresponsive client only when another client wants its
    caps ([issue#17854](http://tracker.ceph.com/issues/17854),
    [pr#22645](https://github.com/ceph/ceph/pull/22645), Rishabh Dave)
-   mds: execute PurgeQueue on_error handler in finisher
    ([pr#29064](https://github.com/ceph/ceph/pull/29064), Yan, Zheng)
-   mds: fix assert(omap_num_objs \<= MAX_OBJECTS) of OpenFileTable
    ([pr#32020](https://github.com/ceph/ceph/pull/32020), Yan, Zheng)
-   mds: fix bug of batch getattr/lookup
    ([pr#32268](https://github.com/ceph/ceph/pull/32268), Yan, Zheng)
-   mds: fix can wrlock check in Locker::acquire_locks()
    ([pr#33005](https://github.com/ceph/ceph/pull/33005), Yan, Zheng)
-   mds: fix infinite loop in Locker::file_update_finish
    ([pr#29902](https://github.com/ceph/ceph/pull/29902), Yan, Zheng)
-   mds: fix InoTable::force_consume_to()
    ([pr#29411](https://github.com/ceph/ceph/pull/29411), Yan, Zheng)
-   mds: fix invalid access of mdr-\>dn\[0\].back()
    ([pr#31534](https://github.com/ceph/ceph/pull/31534), Yan, Zheng)
-   mds: fix is session in blacklist check in Server::apply_blacklist()
    ([issue#40061](http://tracker.ceph.com/issues/40061),
    [pr#28293](https://github.com/ceph/ceph/pull/28293), Yan, Zheng)
-   mds: Fix MDCache.h reorder compiler warnings
    ([pr#31409](https://github.com/ceph/ceph/pull/31409), Varsha Rao)
-   mds: fix null pointer dereference in Server::handle_client_link()
    ([pr#32722](https://github.com/ceph/ceph/pull/32722), Yan, Zheng)
-   mds: fix revoking caps after after stale-\>resume circle
    ([pr#31662](https://github.com/ceph/ceph/pull/31662), Yan, Zheng)
-   mds: fix SnapRealm::resolve_snapname for long name
    ([pr#27511](https://github.com/ceph/ceph/pull/27511), Yan, Zheng)
-   mds: fix use-after-free in Migrater
    ([pr#33291](https://github.com/ceph/ceph/pull/33291), Yan, Zheng)
-   mds: handle bad purge queue item encoding
    ([pr#33449](https://github.com/ceph/ceph/pull/33449), Yan, Zheng)
-   mds: handle ceph_assert on blacklisting
    ([pr#33662](https://github.com/ceph/ceph/pull/33662), Milind
    Changire)
-   mds: increase default cache memory limit to 4G
    ([pr#32042](https://github.com/ceph/ceph/pull/32042), Patrick
    Donnelly)
-   mds: initialize cap_revoke_eviction_timeout with conf
    ([issue#38844](http://tracker.ceph.com/issues/38844),
    [pr#26970](https://github.com/ceph/ceph/pull/26970), simon gao)
-   mds: initialize the monc later in init()
    ([pr#31715](https://github.com/ceph/ceph/pull/31715), Xiubo Li)
-   mds: just delete MDSIOContextBase during shutdown
    ([pr#33538](https://github.com/ceph/ceph/pull/33538), Patrick
    Donnelly)
-   mds: maintain client provided metric flags in client metadata
    ([pr#32201](https://github.com/ceph/ceph/pull/32201), Venky Shankar)
-   mds: make mds-mds per-message versioned
    ([issue#12107](http://tracker.ceph.com/issues/12107),
    [pr#20160](https://github.com/ceph/ceph/pull/20160), dongdong tao)
-   mds: make MDSIOContextBase delete itself when shutting down
    ([pr#29752](https://github.com/ceph/ceph/pull/29752), Xuehan Xu)
-   mds: mds returns -5(EIO) error when the deleted file does not exist
    ([pr#30403](https://github.com/ceph/ceph/pull/30403), huanwen ren)
-   mds: move some MDCache member init to header
    ([pr#29543](https://github.com/ceph/ceph/pull/29543), Patrick
    Donnelly)
-   mds: no assert on frozen dir when scrub path
    ([pr#30835](https://github.com/ceph/ceph/pull/30835), Zhi Zhang)
-   mds: note client features when rejecting client
    ([pr#32505](https://github.com/ceph/ceph/pull/32505), Patrick
    Donnelly)
-   mds: obsoleting mds_cache_size
    ([pr#31729](https://github.com/ceph/ceph/pull/31729), Patrick
    Donnelly, Ramana Raja)
-   mds: optimize function, fragset_t::simplify, to improve the
    efficiency of merging fragment
    ([pr#31595](https://github.com/ceph/ceph/pull/31595), simon gao)
-   mds: output lock state in format dump
    ([issue#39645](http://tracker.ceph.com/issues/39645),
    [pr#27717](https://github.com/ceph/ceph/pull/27717), Zhi Zhang)
-   mds: pass proper MutationImpl::LockOp to Locker::wrlock_start()
    ([pr#33719](https://github.com/ceph/ceph/pull/33719), Yan, Zheng)
-   mds: preparation for async dir operation support
    ([pr#30972](https://github.com/ceph/ceph/pull/30972), Yan, Zheng)
-   mds: properly evaluate unstable locks when evicting client
    ([pr#31548](https://github.com/ceph/ceph/pull/31548), Yan, Zheng)
-   mds: recall caps from quiescent sessions
    ([pr#28702](https://github.com/ceph/ceph/pull/28702), Patrick
    Donnelly)
-   mds: register with mgr only after added to FSMap
    ([pr#31400](https://github.com/ceph/ceph/pull/31400), Patrick
    Donnelly)
-   mds: reject sessionless messages
    ([pr#29594](https://github.com/ceph/ceph/pull/29594), Xiao Guodong)
-   mds: release free heap pages after trim
    ([pr#31793](https://github.com/ceph/ceph/pull/31793), Patrick
    Donnelly)
-   mds: relevel debug message levels for balancer/migrator
    ([pr#33471](https://github.com/ceph/ceph/pull/33471), Patrick
    Donnelly)
-   mds: remove dead get_commands code
    ([pr#33390](https://github.com/ceph/ceph/pull/33390), Patrick
    Donnelly)
-   mds: remove duplicated check on balance amount
    ([pr#27087](https://github.com/ceph/ceph/pull/27087), Zhi Zhang)
-   mds: remove superfluous error in StrayManager::advance_delayed()
    ([issue#38679](http://tracker.ceph.com/issues/38679),
    [pr#27051](https://github.com/ceph/ceph/pull/27051), Yan, Zheng)
-   mds: remove the code that skip evicting the only client
    ([pr#28642](https://github.com/ceph/ceph/pull/28642), Yan, Zheng)
-   mds: remove the incorrect comments
    ([pr#31775](https://github.com/ceph/ceph/pull/31775), Xiubo Li)
-   mds: remove unnecessary debug warning
    ([pr#31898](https://github.com/ceph/ceph/pull/31898), Patrick
    Donnelly)
-   mds: remove unused CDir members
    ([pr#33227](https://github.com/ceph/ceph/pull/33227), Jun Su)
-   mds: Reorganize class members in Anchor header
    ([pr#30090](https://github.com/ceph/ceph/pull/30090), Varsha Rao)
-   mds: Reorganize class members in Capability header
    ([pr#29166](https://github.com/ceph/ceph/pull/29166), Varsha Rao)
-   mds: Reorganize class members in CDir header
    ([pr#28860](https://github.com/ceph/ceph/pull/28860), Varsha Rao)
-   mds: Reorganize class members in CInode header
    ([pr#29066](https://github.com/ceph/ceph/pull/29066), Varsha Rao)
-   mds: Reorganize class members in DamageTable header
    ([pr#29569](https://github.com/ceph/ceph/pull/29569), Varsha Rao)
-   mds: Reorganize class members in FSMap header
    ([pr#29572](https://github.com/ceph/ceph/pull/29572), Varsha Rao)
-   mds: Reorganize class members in FSMapUser header
    ([pr#29574](https://github.com/ceph/ceph/pull/29574), Varsha Rao)
-   mds: Reorganize class members in InoTable header
    ([pr#29883](https://github.com/ceph/ceph/pull/29883), Varsha Rao)
-   mds: Reorganize class members in JournalPointer header
    ([pr#29888](https://github.com/ceph/ceph/pull/29888), Varsha Rao)
-   mds: Reorganize class members in LocalLock header
    ([pr#30143](https://github.com/ceph/ceph/pull/30143), Varsha Rao)
-   mds: Reorganize class members in Locker header
    ([pr#30164](https://github.com/ceph/ceph/pull/30164), Varsha Rao)
-   mds: Reorganize class members in LogEvent header
    ([pr#30205](https://github.com/ceph/ceph/pull/30205), Varsha Rao)
-   mds: Reorganize class members in LogSegment header
    ([pr#30202](https://github.com/ceph/ceph/pull/30202), Varsha Rao)
-   mds: Reorganize class members in MDBalancer header
    ([pr#30559](https://github.com/ceph/ceph/pull/30559), Varsha Rao)
-   mds: Reorganize class members in MDCache header
    ([pr#30745](https://github.com/ceph/ceph/pull/30745), Varsha Rao)
-   mds: Reorganize class members in MDLog header
    ([pr#30744](https://github.com/ceph/ceph/pull/30744), Varsha Rao)
-   mds: Reorganize class members in MDSAuthCaps header
    ([pr#30915](https://github.com/ceph/ceph/pull/30915), Varsha Rao)
-   mds: Reorganize class members in MDSCacheObject header
    ([pr#30938](https://github.com/ceph/ceph/pull/30938), Varsha Rao)
-   mds: Reorganize class members in MDSDaemon header
    ([pr#30990](https://github.com/ceph/ceph/pull/30990), Varsha Rao)
-   mds: Reorganize class members in MDSMap header
    ([pr#31118](https://github.com/ceph/ceph/pull/31118), Varsha Rao)
-   mds: Reorganize class members in MDSRank header
    ([pr#31120](https://github.com/ceph/ceph/pull/31120), Varsha Rao)
-   mds: Reorganize class members in MDSTable header
    ([pr#31122](https://github.com/ceph/ceph/pull/31122), Varsha Rao)
-   mds: Reorganize class members in MDSTableClient header
    ([pr#31115](https://github.com/ceph/ceph/pull/31115), Varsha Rao)
-   mds: Reorganize class members in MDSTableServer header
    ([pr#31250](https://github.com/ceph/ceph/pull/31250), Varsha Rao)
-   mds: Reorganize class members in Migrator header
    ([pr#31253](https://github.com/ceph/ceph/pull/31253), Varsha Rao)
-   mds: Reorganize class members in OpenFileTable header
    ([pr#31597](https://github.com/ceph/ceph/pull/31597), Varsha Rao)
-   mds: Reorganize class members in PurgeQueue header
    ([pr#31596](https://github.com/ceph/ceph/pull/31596), Varsha Rao)
-   mds: Reorganize class members in RecoveryQueue header
    ([pr#31635](https://github.com/ceph/ceph/pull/31635), Varsha Rao)
-   mds: Reorganize class members in ScatterLock header
    ([pr#31716](https://github.com/ceph/ceph/pull/31716), Varsha Rao)
-   mds: Reorganize class members in ScrubHeader header
    ([pr#31717](https://github.com/ceph/ceph/pull/31717), Varsha Rao)
-   mds: Reorganize class members in ScrubStack header
    ([pr#31718](https://github.com/ceph/ceph/pull/31718), Varsha Rao)
-   mds: Reorganize class members in Server header
    ([pr#31719](https://github.com/ceph/ceph/pull/31719), Varsha Rao)
-   mds: Reorganize class members in SessionMap header
    ([pr#32320](https://github.com/ceph/ceph/pull/32320), Varsha Rao)
-   mds: Reorganize class members in SimpleLock header
    ([pr#32322](https://github.com/ceph/ceph/pull/32322), Varsha Rao)
-   mds: Reorganize class members in SnapClient header
    ([pr#32326](https://github.com/ceph/ceph/pull/32326), Varsha Rao)
-   mds: Reorganize class members in SnapServer header
    ([pr#32350](https://github.com/ceph/ceph/pull/32350), Varsha Rao)
-   mds: Reorganize struct members in Mutation header
    ([pr#31481](https://github.com/ceph/ceph/pull/31481), Varsha Rao)
-   mds: Reorganize structure and class members in mdstypes header
    ([pr#32435](https://github.com/ceph/ceph/pull/32435), Varsha Rao)
-   mds: Reorganize structure members in flock header
    ([pr#32416](https://github.com/ceph/ceph/pull/32416), Varsha Rao)
-   mds: Reorganize structure members in inode_backtrace header
    ([pr#32431](https://github.com/ceph/ceph/pull/32431), Varsha Rao)
-   mds: Reorganize structure members in snap header
    ([pr#32432](https://github.com/ceph/ceph/pull/32432), Varsha Rao)
-   mds: Reorganize structure members in SnapRealm header
    ([pr#32348](https://github.com/ceph/ceph/pull/32348), Varsha Rao)
-   mds: Reorganize structure members in StrayManager header
    ([pr#32397](https://github.com/ceph/ceph/pull/32397), Varsha Rao)
-   mds: reset heartbeat inside big loop
    ([pr#28406](https://github.com/ceph/ceph/pull/28406), Yan, Zheng)
-   mds: split the dir if the op makes it oversized, because some ops
    maybe in flight
    ([pr#29921](https://github.com/ceph/ceph/pull/29921), simon gao)
-   mds: there is an assertion when calling Beacon::shutdown()
    ([issue#38822](http://tracker.ceph.com/issues/38822),
    [pr#27063](https://github.com/ceph/ceph/pull/27063), huanwen ren)
-   mds: throttle scrub start for multiple active MDS
    ([pr#32521](https://github.com/ceph/ceph/pull/32521), Patrick
    Donnelly, Milind Changire)
-   mds: tolerate no snaprealm encoded in on-disk root inode
    ([pr#31455](https://github.com/ceph/ceph/pull/31455), Yan, Zheng)
-   mds: track high water mark for purges
    ([pr#32667](https://github.com/ceph/ceph/pull/32667), Patrick
    Donnelly)
-   mds: trim cache during standby-replay
    ([issue#40213](http://tracker.ceph.com/issues/40213),
    [pr#28212](https://github.com/ceph/ceph/pull/28212), simon gao)
-   mds: trim cache on regular schedule
    ([pr#29542](https://github.com/ceph/ceph/pull/29542), Patrick
    Donnelly)
-   mds: unify daemon and tell commands
    ([pr#31255](https://github.com/ceph/ceph/pull/31255), Sage Weil)
-   mds: update projected_version when upgrading snaptable
    ([issue#38835](http://tracker.ceph.com/issues/38835),
    [pr#27238](https://github.com/ceph/ceph/pull/27238), Yan, Zheng)
-   mds: use set to store to evict client
    ([pr#30029](https://github.com/ceph/ceph/pull/30029), Erqi Chen)
-   mds: use vector::empty in feature_bitset_t
    ([pr#32541](https://github.com/ceph/ceph/pull/32541), Jos Collin)
-   mds: wake up lock waiters after forcibly changing lock state
    ([issue#39987](http://tracker.ceph.com/issues/39987),
    [pr#28459](https://github.com/ceph/ceph/pull/28459), Yan, Zheng)
-   mgr,mon,rbd: mon/mgr: add rbd_support to list of always-on mgr
    modules ([issue#40790](http://tracker.ceph.com/issues/40790),
    [pr#29073](https://github.com/ceph/ceph/pull/29073), Jason Dillaman)
-   mgr,mon: mon,mgr: pass MessageRef to monc.send_mon_message()
    xe2x80xa6 ([pr#30449](https://github.com/ceph/ceph/pull/30449), Kefu
    Chai)
-   mgr,mon: mon/MgrMonitor.cc: add always_on_modules to the output of
    ceph mgr module ls
    ([pr#32939](https://github.com/ceph/ceph/pull/32939), Neha Ojha)
-   mgr,mon: mon/MgrMonitor.cc: warn about missing mgr in a cluster with
    osds ([pr#33025](https://github.com/ceph/ceph/pull/33025), Neha
    Ojha)
-   mgr,pybind: pybind/mgr/prometheus: remove scrape_duration metric
    ([pr#27034](https://github.com/ceph/ceph/pull/27034), Jan Fajerski)
-   mgr,rbd: mgr/dashboard: block mirroring page results in internal
    server error ([pr#31907](https://github.com/ceph/ceph/pull/31907),
    Jason Dillaman)
-   mgr,rbd: mgr/rbd_support: dont scan pools that dont have schedules
    ([pr#33840](https://github.com/ceph/ceph/pull/33840), Mykola Golub)
-   mgr,rbd: mgr/rbd_support: implement mirror snapshot scheduler
    ([pr#32434](https://github.com/ceph/ceph/pull/32434), Mykola Golub)
-   mgr,rbd: mgr/rbd_support: support scheduling long-running background
    operations ([issue#40621](http://tracker.ceph.com/issues/40621),
    [pr#29054](https://github.com/ceph/ceph/pull/29054), Jason Dillaman)
-   mgr,rbd: pybind/mgr: fix format for rbd-mirror prometheus metrics
    ([pr#28200](https://github.com/ceph/ceph/pull/28200), Mykola Golub)
-   mgr,rgw: mgr/ansible: RGW service
    ([pr#28468](https://github.com/ceph/ceph/pull/28468), Juan Miguel
    Olmo Martxc3xadnez)
-   mgr,tests: install-deps.sh: preload wheel for all mgr
    requirements.txt files
    ([pr#32151](https://github.com/ceph/ceph/pull/32151), Sage Weil)
-   mgr,tests: mgr/orchestrator_cli: remove tox and move test to parent
    dir ([pr#31561](https://github.com/ceph/ceph/pull/31561), Sebastian
    Wagner)
-   mgr,tests: mgr/progress: Created first unit test for progress module
    ([pr#28758](https://github.com/ceph/ceph/pull/28758), Kamoltat
    (Junior) Sirivadhna)
-   mgr,tests: pybind/mgr: Add ceph_module.pyi to improve type checking
    ([pr#32502](https://github.com/ceph/ceph/pull/32502), Sebastian
    Wagner)
-   mgr,tests: pybind/mgr: install setuptools \>= 12
    ([pr#29414](https://github.com/ceph/ceph/pull/29414), Kefu Chai)
-   mgr,tests: pybind/tox: handle possible WITH_PYTHON3 values other
    than 3 ([pr#28002](https://github.com/ceph/ceph/pull/28002), Nathan
    Cutler)
-   mgr,tests: qa/mgr/balancer: Add cram based test for altering
    target_max_misplaced_ratio setting
    ([pr#30646](https://github.com/ceph/ceph/pull/30646), Shyukri
    Shyukriev)
-   mgr,tests: qa/mgr/progress: update the test suite for progress
    module ([issue#40618](http://tracker.ceph.com/issues/40618),
    [pr#29111](https://github.com/ceph/ceph/pull/29111), Kamoltat
    (Junior) Sirivadhna)
-   mgr,tools: Remove use of rules batching for upmap balancer and
    default for upmap_max_deviation to 5
    ([pr#32247](https://github.com/ceph/ceph/pull/32247), David Zafman)
-   mgr/ansible: Host ls implementation
    ([pr#26185](https://github.com/ceph/ceph/pull/26185), Juan Miguel
    Olmo Martxc3xadnez)
-   mgr/ansible: Integrate mgr/ansible/tox into mgr/tox
    ([pr#32149](https://github.com/ceph/ceph/pull/32149), Sebastian
    Wagner)
-   mgr/ansible: TLS Mutual Authentication
    ([pr#27512](https://github.com/ceph/ceph/pull/27512), Juan Miguel
    Olmo Martxc3xadnez)
-   mgr/cephadm: a few fixes around daemon and device caches
    ([pr#33495](https://github.com/ceph/ceph/pull/33495), Sage Weil)
-   mgr/cephadm: adapt osd deployment to service_apply
    ([pr#33922](https://github.com/ceph/ceph/pull/33922), Sage Weil,
    Joshua Schmid)
-   mgr/cephadm: add drivegroup support; workaround c-v batch
    shortcoming ([pr#32972](https://github.com/ceph/ceph/pull/32972),
    Sage Weil, Joshua Schmid)
-   mgr/cephadm: add HostAssignment.validate()
    ([pr#34005](https://github.com/ceph/ceph/pull/34005), Sebastian
    Wagner)
-   mgr/cephadm: Add progress to update_mgr()
    ([pr#32372](https://github.com/ceph/ceph/pull/32372), Sebastian
    Wagner)
-   mgr/cephadm: Add unittest for osd removal
    ([pr#33602](https://github.com/ceph/ceph/pull/33602), Sage Weil,
    Sebastian Wagner)
-   mgr/cephadm: Add unittest for service_action
    ([pr#32209](https://github.com/ceph/ceph/pull/32209), Sebastian
    Wagner)
-   mgr/cephadm: allow osd replacement/removal in the background
    ([pr#32983](https://github.com/ceph/ceph/pull/32983), Joshua Schmid)
-   mgr/cephadm: auto-select python version to use remotely
    ([pr#32327](https://github.com/ceph/ceph/pull/32327), Sage Weil)
-   mgr/cephadm: cache device inventory; zap
    ([pr#33394](https://github.com/ceph/ceph/pull/33394), Sage Weil)
-   mgr/cephadm: catch exceptions when scraping ceph-volume inventory
    ([pr#33484](https://github.com/ceph/ceph/pull/33484), Sage Weil)
-   mgr/cephadm: catch excpetions in serve() thread
    ([pr#33139](https://github.com/ceph/ceph/pull/33139), Sage Weil)
-   mgr/cephadm: check-host on host add
    ([pr#32385](https://github.com/ceph/ceph/pull/32385), Sage Weil)
-   mgr/cephadm: clean up client.crash.\\\* container_image settings
    after upgrade ([pr#34068](https://github.com/ceph/ceph/pull/34068),
    Sage Weil)
-   mgr/cephadm: consolidate/refactor all add\\\_ and apply\\\_ methods
    ([pr#33496](https://github.com/ceph/ceph/pull/33496), Sage Weil)
-   mgr/cephadm: Convert HostNotFound to OrchestratorError
    ([pr#33310](https://github.com/ceph/ceph/pull/33310), Sebastian
    Wagner)
-   mgr/cephadm: deploy Grafana
    ([pr#33515](https://github.com/ceph/ceph/pull/33515), Patrick
    Seidensal)
-   mgr/cephadm: do not include osd service in orch ls output
    ([pr#33968](https://github.com/ceph/ceph/pull/33968), Sage Weil)
-   mgr/cephadm: do not reconfig orphan daemons; fix test to not remote
    orphans ([pr#34027](https://github.com/ceph/ceph/pull/34027), Sage
    Weil)
-   mgr/cephadm: do not refresh daemon and device inventory as often
    ([pr#33734](https://github.com/ceph/ceph/pull/33734), Sage Weil)
-   mgr/cephadm: drop mixin parent
    ([pr#33514](https://github.com/ceph/ceph/pull/33514), Sage Weil)
-   mgr/cephadm: Enable provisioning alertmanager via orchestrator
    ([pr#33554](https://github.com/ceph/ceph/pull/33554), Kristoffer
    Grxc3xb6nlund)
-   mgr/cephadm: fix dump output by formatting to yaml first
    ([pr#33891](https://github.com/ceph/ceph/pull/33891), Joshua Schmid)
-   mgr/cephadm: fix listing services by host
    ([pr#32314](https://github.com/ceph/ceph/pull/32314), Kiefer Chang)
-   mgr/cephadm: fix orch rm and upgrade
    ([pr#33772](https://github.com/ceph/ceph/pull/33772), Sage Weil)
-   mgr/cephadm: fix osd reconfig/redeploy
    ([pr#32812](https://github.com/ceph/ceph/pull/32812), Sage Weil)
-   mgr/cephadm: Fix placement for new services
    ([pr#33205](https://github.com/ceph/ceph/pull/33205), Sebastian
    Wagner)
-   mgr/cephadm: fix placement when existing + specified dont overlap
    ([pr#33766](https://github.com/ceph/ceph/pull/33766), Sage Weil)
-   mgr/cephadm: fix prom config generation when hosts have no labels or
    addrs ([pr#33800](https://github.com/ceph/ceph/pull/33800), Sage
    Weil)
-   mgr/cephadm: Fix remove_osds()
    ([pr#32146](https://github.com/ceph/ceph/pull/32146), Sebastian
    Wagner)
-   mgr/cephadm: fix section name for mon options in ceph.conf
    ([pr#32681](https://github.com/ceph/ceph/pull/32681), Sage Weil)
-   mgr/cephadm: fix service list filtering
    ([pr#33838](https://github.com/ceph/ceph/pull/33838), Kiefer Chang)
-   mgr/cephadm: fix type of timeout options
    ([pr#32316](https://github.com/ceph/ceph/pull/32316), Kiefer Chang)
-   mgr/cephadm: fix upgrade ok-to-stop condition check
    ([pr#33469](https://github.com/ceph/ceph/pull/33469), Sage Weil)
-   mgr/cephadm: fix upgrade order
    ([pr#33811](https://github.com/ceph/ceph/pull/33811), Sage Weil)
-   mgr/cephadm: fix upgrade wait loop
    ([pr#33447](https://github.com/ceph/ceph/pull/33447), Sage Weil)
-   mgr/cephadm: fix upgrade when daemon is stopped
    ([pr#33678](https://github.com/ceph/ceph/pull/33678), Sage Weil)
-   mgr/cephadm: if we had no record of deps, and deps are \[\], do not
    reconfig ([pr#33733](https://github.com/ceph/ceph/pull/33733), Sage
    Weil)
-   mgr/cephadm: implement apply mon, mon removal checks
    ([pr#33792](https://github.com/ceph/ceph/pull/33792), Sage Weil)
-   mgr/cephadm: implement pause/resume to suspect non-monitoring
    background work
    ([pr#33930](https://github.com/ceph/ceph/pull/33930), Sage Weil)
-   mgr/cephadm: improve pull behavior for upgrade
    ([pr#32878](https://github.com/ceph/ceph/pull/32878), Sage Weil)
-   mgr/cephadm: init attrs created by settattr()
    ([pr#32957](https://github.com/ceph/ceph/pull/32957), Kefu Chai)
-   mgr/cephadm: leverage service specs
    ([pr#33553](https://github.com/ceph/ceph/pull/33553), Sage Weil,
    Joshua Schmid)
-   mgr/cephadm: limit number of times check host is performed in the
    serve loop ([pr#33866](https://github.com/ceph/ceph/pull/33866),
    Daniel-Pivonka)
-   mgr/cephadm: log information to cluster log
    ([pr#33488](https://github.com/ceph/ceph/pull/33488), Sage Weil)
-   mgr/cephadm: make apply move daemons, do its work synchronously
    ([pr#33704](https://github.com/ceph/ceph/pull/33704), Sage Weil)
-   mgr/cephadm: make NodeAssignment return a simple host list
    ([pr#33669](https://github.com/ceph/ceph/pull/33669), Sage Weil)
-   mgr/cephadm: make osd create on an existing LV idempotent
    ([pr#33755](https://github.com/ceph/ceph/pull/33755), Sage Weil)
-   mgr/cephadm: make prometheus scrape all mgrs, node-exporters
    ([pr#33444](https://github.com/ceph/ceph/pull/33444), Sage Weil)
-   mgr/cephadm: Make sure we dont co-locate the same daemon
    ([pr#33853](https://github.com/ceph/ceph/pull/33853), Sebastian
    Wagner)
-   mgr/cephadm: misc fixes
    ([pr#33119](https://github.com/ceph/ceph/pull/33119), Sage Weil)
-   mgr/cephadm: misc fixes + smoke test
    ([pr#33730](https://github.com/ceph/ceph/pull/33730), Sage Weil)
-   mgr/cephadm: mon: Dont show traceback for user errors
    ([pr#33333](https://github.com/ceph/ceph/pull/33333), Sebastian
    Wagner)
-   mgr/cephadm: nicer error from cephadm check-host
    ([pr#33935](https://github.com/ceph/ceph/pull/33935), Sage Weil)
-   mgr/cephadm: point dashboard at cephadms grafana automatically
    ([pr#33700](https://github.com/ceph/ceph/pull/33700), Sage Weil)
-   mgr/cephadm: prefix daemon ids with hostname
    ([pr#33012](https://github.com/ceph/ceph/pull/33012), Sage Weil)
-   mgr/cephadm: progress for upgrade
    ([pr#33415](https://github.com/ceph/ceph/pull/33415), Sage Weil)
-   mgr/cephadm: provision node-exporter
    ([pr#33123](https://github.com/ceph/ceph/pull/33123), Sage Weil,
    Patrick Seidensal)
-   mgr/cephadm: provision prometheus
    ([pr#33073](https://github.com/ceph/ceph/pull/33073), Sage Weil)
-   mgr/cephadm: reduce boilerplate for unittests
    ([pr#33663](https://github.com/ceph/ceph/pull/33663), Joshua Schmid)
-   mgr/cephadm: refresh ceph.conf when mons change
    ([pr#33855](https://github.com/ceph/ceph/pull/33855), Sage Weil)
-   mgr/cephadm: refresh configs when dependencies change
    ([pr#33671](https://github.com/ceph/ceph/pull/33671), Sage Weil)
-   mgr/cephadm: refresh service state in the background
    ([pr#32859](https://github.com/ceph/ceph/pull/32859), Sebastian
    Wagner, Sage Weil)
-   mgr/cephadm: remove item from cache when removing
    ([pr#33071](https://github.com/ceph/ceph/pull/33071), Sage Weil)
-   mgr/cephadm: remove redundant /dev when blinking device light
    ([pr#32246](https://github.com/ceph/ceph/pull/32246), Sage Weil)
-   mgr/cephadm: revamp scheduling
    ([pr#33523](https://github.com/ceph/ceph/pull/33523), Sage Weil)
-   mgr/cephadm: set thread pool size to 10
    ([pr#33463](https://github.com/ceph/ceph/pull/33463), Sebastian
    Wagner)
-   mgr/cephadm: show age of service ls
    ([pr#32686](https://github.com/ceph/ceph/pull/32686), Sage Weil)
-   mgr/cephadm: simplify and improve placement
    ([pr#33808](https://github.com/ceph/ceph/pull/33808), Sage Weil)
-   mgr/cephadm: simplify tracking of daemon inventory
    ([pr#33249](https://github.com/ceph/ceph/pull/33249), Sage Weil)
-   mgr/cephadm: two minor fixes
    ([pr#33736](https://github.com/ceph/ceph/pull/33736), Sage Weil)
-   mgr/cephadm: update osd removal report immediately
    ([pr#33713](https://github.com/ceph/ceph/pull/33713), Kiefer Chang)
-   mgr/cephadm: update type annotation
    ([pr#33784](https://github.com/ceph/ceph/pull/33784), Kefu Chai)
-   mgr/cephadm: upgrade requires root mode for now
    ([pr#33802](https://github.com/ceph/ceph/pull/33802), Sage Weil)
-   mgr/cephadm: upgrade: fix daemons missing image_id
    ([pr#33745](https://github.com/ceph/ceph/pull/33745), Sage Weil)
-   mgr/cephadm: upgrade: handle stopped daemons
    ([pr#33487](https://github.com/ceph/ceph/pull/33487), Sage Weil)
-   mgr/cephadm: verify hosts hostname matches cephadm host
    ([pr#33058](https://github.com/ceph/ceph/pull/33058), Sage Weil)
-   mgr/dashbaord: Fix E2E pools page failure
    ([pr#32635](https://github.com/ceph/ceph/pull/32635), Stephan
    Mxc3xbcller)
-   mgr/dashboad: Improve iSCSI overview page
    ([pr#27254](https://github.com/ceph/ceph/pull/27254), Ricardo
    Marques)
-   mgr/dashboard Displays progress bar in notification tray for
    background tasks
    ([pr#27420](https://github.com/ceph/ceph/pull/27420), Pooja)
-   mgr/dashboard/qa: Improve
    tasks.mgr.test_dashboard.TestDashboard.test_standby
    ([pr#26925](https://github.com/ceph/ceph/pull/26925), Volker Theile)
-   mgr/dashboard/qa: Increase timeout for test_disable
    (tasks.mgr.dashboard.test_mgr_module.MgrModuleTelemetryTest)
    ([pr#27187](https://github.com/ceph/ceph/pull/27187), Volker Theile)
-   mgr/dashboard: 1 osds exist in the crush map but not in the osdmap
    breaks OSD page
    ([issue#36086](http://tracker.ceph.com/issues/36086),
    [pr#26836](https://github.com/ceph/ceph/pull/26836), Patrick
    Nawracay)
-   mgr/dashboard: A block-manager can not access the pool page
    ([pr#30001](https://github.com/ceph/ceph/pull/30001), Volker Theile)
-   mgr/dashboard: accept expected exception when SSL handshaking
    ([pr#31014](https://github.com/ceph/ceph/pull/31014), Kefu Chai)
-   mgr/dashboard: Access control database does not restore disabled
    users correctly
    ([pr#29614](https://github.com/ceph/ceph/pull/29614), Volker Theile)
-   mgr/dashboard: adapt bucket tenant API tests to new behaviour
    ([pr#29570](https://github.com/ceph/ceph/pull/29570), alfonsomthd)
-   mgr/dashboard: adapt create_osds interface change
    ([pr#34000](https://github.com/ceph/ceph/pull/34000), Kiefer Chang)
-   mgr/dashboard: Add Always-on column to mgr module list
    ([pr#33429](https://github.com/ceph/ceph/pull/33429), Volker Theile)
-   mgr/dashboard: Add date range and log search functionality
    ([issue#37387](http://tracker.ceph.com/issues/37387),
    [pr#26562](https://github.com/ceph/ceph/pull/26562), guodan1)
-   mgr/dashboard: add debug mode
    ([pr#30522](https://github.com/ceph/ceph/pull/30522), Ernesto
    Puerta)
-   mgr/dashboard: add feature toggle for NFS and fix feature toggles
    regression ([pr#32419](https://github.com/ceph/ceph/pull/32419),
    Ernesto Puerta)
-   mgr/dashboard: Add invalid pattern message for Pool name
    ([pr#31607](https://github.com/ceph/ceph/pull/31607), Tiago Melo)
-   mgr/dashboard: Add missing text translation
    ([pr#29934](https://github.com/ceph/ceph/pull/29934), Volker Theile)
-   mgr/dashboard: Add polish translation
    ([pr#27247](https://github.com/ceph/ceph/pull/27247), Sebastian
    Krah)
-   mgr/dashboard: Add protractor-screenshoter-plugin
    ([pr#27166](https://github.com/ceph/ceph/pull/27166), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: Add refresh interval to the dashboard landing page
    ([issue#26872](http://tracker.ceph.com/issues/26872),
    [pr#26396](https://github.com/ceph/ceph/pull/26396), guodan1)
-   mgr/dashboard: Add separate option to config SSL port
    ([pr#26914](https://github.com/ceph/ceph/pull/26914), Volker Theile)
-   mgr/dashboard: Add support for blinking enclosure LEDs
    ([pr#31851](https://github.com/ceph/ceph/pull/31851), Volker Theile)
-   mgr/dashboard: Add time-diff unittest and docs
    ([pr#31357](https://github.com/ceph/ceph/pull/31357), Volker Theile)
-   mgr/dashboard: Add vertical menu
    ([pr#31923](https://github.com/ceph/ceph/pull/31923), Tiago Melo)
-   mgr/dashboard: Add whitelist to guard
    ([pr#27406](https://github.com/ceph/ceph/pull/27406), Ernesto
    Puerta)
-   mgr/dashboard: Allow deletion of RBD with snapshots
    ([pr#33067](https://github.com/ceph/ceph/pull/33067), Tiago Melo)
-   mgr/dashboard: Allow disabling redirection on standby Dashboards
    ([pr#29088](https://github.com/ceph/ceph/pull/29088), Volker Theile)
-   mgr/dashboard: allow refreshing inventory page
    ([pr#32423](https://github.com/ceph/ceph/pull/32423), Kiefer Chang)
-   mgr/dashboard: Allow users to change their password on the UI
    ([pr#28935](https://github.com/ceph/ceph/pull/28935), Volker Theile)
-   mgr/dashboard: auth ttl expired error
    ([pr#27098](https://github.com/ceph/ceph/pull/27098), ming416)
-   mgr/dashboard: Back button component
    ([pr#27164](https://github.com/ceph/ceph/pull/27164), Stephan
    Mxc3xbcller)
-   mgr/dashboard: behave when pwdUpdateRequired key is missing
    ([pr#33513](https://github.com/ceph/ceph/pull/33513), Sage Weil)
-   mgr/dashboard: Bucket names cannot be formatted as IP address
    ([pr#30620](https://github.com/ceph/ceph/pull/30620), Volker Theile)
-   mgr/dashboard: ceph dashboard i18ntool
    ([pr#26953](https://github.com/ceph/ceph/pull/26953), Sebastian
    Krah)
-   mgr/dashboard: CephFS client tab switch
    ([pr#29556](https://github.com/ceph/ceph/pull/29556), Stephan
    Mxc3xbcller)
-   mgr/dashboard: CephFS tab component
    ([pr#29800](https://github.com/ceph/ceph/pull/29800), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Change the provider of services to root
    ([issue#39996](http://tracker.ceph.com/issues/39996),
    [pr#28211](https://github.com/ceph/ceph/pull/28211), Tiago Melo)
-   mgr/dashboard: change warn_explicit to warn
    ([pr#30075](https://github.com/ceph/ceph/pull/30075), Ernesto
    Puerta)
-   mgr/dashboard: Check if gateway is in use before deletion
    ([pr#27262](https://github.com/ceph/ceph/pull/27262), Ricardo
    Marques)
-   mgr/dashboard: Check if [num_sessions]{.title-ref} is available
    ([pr#30270](https://github.com/ceph/ceph/pull/30270), Ricardo
    Marques)
-   mgr/dashboard: cheroot moved into a separate project
    ([pr#31431](https://github.com/ceph/ceph/pull/31431), Joshua Schmid)
-   mgr/dashboard: Cleanup code
    ([pr#33107](https://github.com/ceph/ceph/pull/33107), Volker Theile)
-   mgr/dashboard: Cleanup feature toggle status output
    ([pr#32569](https://github.com/ceph/ceph/pull/32569), Volker Theile)
-   mgr/dashboard: Cleanup Python code
    ([pr#29604](https://github.com/ceph/ceph/pull/29604), Volker Theile)
-   mgr/dashboard: Clone an existing user role
    ([pr#32653](https://github.com/ceph/ceph/pull/32653), Volker Theile)
-   mgr/dashboard: commands to set SSL certificate and key
    ([pr#27463](https://github.com/ceph/ceph/pull/27463), Ricardo Dias)
-   mgr/dashboard: Configuring an URL prefix does not work as expected
    ([pr#30599](https://github.com/ceph/ceph/pull/30599), Volker Theile)
-   mgr/dashboard: consider mon_allow_pool_delete flag
    ([pr#28260](https://github.com/ceph/ceph/pull/28260), Tatjana
    Dehler)
-   mgr/dashboard: Controls UI inputs based on type
    ([pr#30208](https://github.com/ceph/ceph/pull/30208), Ricardo
    Marques)
-   mgr/dashboard: coverage venv python version same as mgr
    ([pr#33407](https://github.com/ceph/ceph/pull/33407), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: Create bucket with x-amz-bucket-object-lock-enabled
    ([pr#33821](https://github.com/ceph/ceph/pull/33821), Volker Theile)
-   mgr/dashboard: Crush rule modal
    ([pr#33620](https://github.com/ceph/ceph/pull/33620), Stephan
    Mxc3xbcller)
-   mgr/dashboard: decouple backend unit tests from build
    ([pr#32565](https://github.com/ceph/ceph/pull/32565), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: destroyed view in CRUSH map viewer
    ([pr#33405](https://github.com/ceph/ceph/pull/33405), Avan Thakkar)
-   mgr/dashboard: Disable event propagation in the helper icon
    ([issue#40715](http://tracker.ceph.com/issues/40715),
    [pr#29105](https://github.com/ceph/ceph/pull/29105), Tiago Melo)
-   mgr/dashboard: Display correct dialog title
    ([pr#28168](https://github.com/ceph/ceph/pull/28168), Volker Theile)
-   mgr/dashboard: Display iSCSI logged in info
    ([pr#28265](https://github.com/ceph/ceph/pull/28265), Ricardo
    Marques)
-   mgr/dashboard: Display legend for CephFS standbys
    ([pr#29927](https://github.com/ceph/ceph/pull/29927), Volker Theile)
-   mgr/dashboard: display OSD IDs on inventory page
    ([pr#31189](https://github.com/ceph/ceph/pull/31189), Kiefer Chang)
-   mgr/dashboard: Display the number of iSCSI active sessions
    ([pr#27248](https://github.com/ceph/ceph/pull/27248), Ricardo
    Marques)
-   mgr/dashboard: Display WWN and LUN number in iSCSI target details
    ([pr#30288](https://github.com/ceph/ceph/pull/30288), Ricardo
    Marques)
-   mgr/dashboard: do not log tokens
    ([pr#30445](https://github.com/ceph/ceph/pull/30445), Kefu Chai)
-   mgr/dashboard: do not show RGW API keys if only read-only privileges
    ([pr#33178](https://github.com/ceph/ceph/pull/33178), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: Editing RGW bucket fails because of name is already
    in use ([pr#29767](https://github.com/ceph/ceph/pull/29767), Volker
    Theile)
-   mgr/dashboard: Enable compiler options used by Angular \--strict
    flag ([pr#32553](https://github.com/ceph/ceph/pull/32553), Tiago
    Melo)
-   mgr/dashboard: Enable read only users to read again
    ([pr#27348](https://github.com/ceph/ceph/pull/27348), Stephan
    Mxc3xbcller)
-   mgr/dashboard: enable/disable versioning on RGW bucket
    ([pr#29460](https://github.com/ceph/ceph/pull/29460), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: Enforce password change upon first login
    ([pr#32680](https://github.com/ceph/ceph/pull/32680), Volker Theile,
    Tatjana Dehler)
-   mgr/dashboard: Enhance user create CLI command to force password
    change ([pr#33552](https://github.com/ceph/ceph/pull/33552), Volker
    Theile)
-   mgr/dashboard: Evict a CephFS client
    ([pr#28898](https://github.com/ceph/ceph/pull/28898), Ricardo
    Marques)
-   mgr/dashboard: Explicitly set/change the device class of an OSD
    ([pr#32150](https://github.com/ceph/ceph/pull/32150), Ricardo
    Marques)
-   mgr/dashboard: Extend E2E test section
    ([pr#28858](https://github.com/ceph/ceph/pull/28858), Laura Paduano)
-   mgr/dashboard: extend types of [smart]{.title-ref} response
    ([pr#30595](https://github.com/ceph/ceph/pull/30595), Patrick
    Seidensal)
-   mgr/dashboard: fix adding/removing host errors
    ([pr#34023](https://github.com/ceph/ceph/pull/34023), Kiefer Chang)
-   mgr/dashboard: fix backend error when updating RBD interlocked
    features ([issue#39933](http://tracker.ceph.com/issues/39933),
    [pr#28147](https://github.com/ceph/ceph/pull/28147), Kiefer Chang)
-   mgr/dashboard: fix cdEncode decorator is not working on class
    ([pr#30064](https://github.com/ceph/ceph/pull/30064), Kiefer Chang)
-   mgr/dashboard: Fix CephFS chart
    ([pr#29557](https://github.com/ceph/ceph/pull/29557), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Fix dashboard health test failure
    ([pr#29172](https://github.com/ceph/ceph/pull/29172), Ricardo
    Marques)
-   mgr/dashboard: Fix deletion of NFS protocol properties
    ([issue#38997](http://tracker.ceph.com/issues/38997),
    [pr#27244](https://github.com/ceph/ceph/pull/27244), Tiago Melo)
-   mgr/dashboard: Fix deletion of NFS transports properties
    ([issue#39090](http://tracker.ceph.com/issues/39090),
    [pr#27350](https://github.com/ceph/ceph/pull/27350), Tiago Melo)
-   mgr/dashboard: Fix e2e chromedriver problem
    ([pr#32224](https://github.com/ceph/ceph/pull/32224), Tiago Melo)
-   mgr/dashboard: Fix env vars of [run-tox.sh]{.title-ref}
    ([issue#38798](http://tracker.ceph.com/issues/38798),
    [pr#26977](https://github.com/ceph/ceph/pull/26977), Patrick
    Nawracay)
-   mgr/dashboard: Fix error in unit test caused by timezone
    ([pr#31632](https://github.com/ceph/ceph/pull/31632), Tiago Melo)
-   mgr/dashboard: fix failing user test
    ([pr#32461](https://github.com/ceph/ceph/pull/32461), Tatjana
    Dehler)
-   mgr/dashboard: fix improper URL checking
    ([pr#32652](https://github.com/ceph/ceph/pull/32652), Ernesto
    Puerta)
-   mgr/dashboard: Fix iSCSI + Rook issues
    ([issue#39586](http://tracker.ceph.com/issues/39586),
    [pr#26341](https://github.com/ceph/ceph/pull/26341), Sebastian
    Wagner)
-   mgr/dashboard: Fix iSCSI Discovery user permissions
    ([issue#39328](http://tracker.ceph.com/issues/39328),
    [pr#27678](https://github.com/ceph/ceph/pull/27678), Tiago Melo)
-   mgr/dashboard: Fix iSCSI disk diff calculation
    ([pr#27378](https://github.com/ceph/ceph/pull/27378), Ricardo
    Marques)
-   mgr/dashboard: Fix iSCSI form when using IPv6
    ([pr#27946](https://github.com/ceph/ceph/pull/27946), Ricardo
    Marques)
-   mgr/dashboard: Fix iSCSI target form warning
    ([issue#39324](http://tracker.ceph.com/issues/39324),
    [pr#27609](https://github.com/ceph/ceph/pull/27609), Tiago Melo)
-   mgr/dashboard: Fix iSCSI target submission
    ([pr#27380](https://github.com/ceph/ceph/pull/27380), Ricardo
    Marques)
-   mgr/dashboard: Fix issues in user form
    ([pr#28863](https://github.com/ceph/ceph/pull/28863), Volker Theile)
-   mgr/dashboard: fix LazyUUID4 not serializable
    ([pr#31266](https://github.com/ceph/ceph/pull/31266), Ernesto
    Puerta)
-   mgr/dashboard: fix MDS counter chart is not displayed
    ([pr#29371](https://github.com/ceph/ceph/pull/29371), Kiefer Chang)
-   mgr/dashboard: fix mgr module API tests
    ([pr#29634](https://github.com/ceph/ceph/pull/29634), alfonsomthd,
    Kefu Chai)
-   mgr/dashboard: fix missing constraints file in backend API tests
    ([pr#30720](https://github.com/ceph/ceph/pull/30720), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: Fix missing i18n
    ([pr#32650](https://github.com/ceph/ceph/pull/32650), Volker Theile)
-   mgr/dashboard: Fix mypy issues and enable it by default
    ([pr#33454](https://github.com/ceph/ceph/pull/33454), Volker Theile)
-   mgr/dashboard: Fix NFS pseudo validation
    ([issue#39063](http://tracker.ceph.com/issues/39063),
    [pr#27293](https://github.com/ceph/ceph/pull/27293), Tiago Melo)
-   mgr/dashboard: Fix NFS squash default value
    ([issue#39064](http://tracker.ceph.com/issues/39064),
    [pr#27294](https://github.com/ceph/ceph/pull/27294), Tiago Melo)
-   mgr/dashboard: Fix npm vulnerabilities
    ([pr#32699](https://github.com/ceph/ceph/pull/32699), Tiago Melo)
-   mgr/dashboard: Fix OSD IDs are not displayed when using cephadm
    backend ([pr#32207](https://github.com/ceph/ceph/pull/32207), Kiefer
    Chang)
-   mgr/dashboard: Fix pool deletion e2e
    ([pr#29993](https://github.com/ceph/ceph/pull/29993), Volker Theile)
-   mgr/dashboard: Fix pool renaming functionality
    ([pr#31617](https://github.com/ceph/ceph/pull/31617), Stephan
    Mxc3xbcller)
-   mgr/dashboard: fix python2 failure in home controller
    ([pr#30937](https://github.com/ceph/ceph/pull/30937), Ricardo Dias)
-   mgr/dashboard: fix RGW subuser auto-generate key
    ([pr#32186](https://github.com/ceph/ceph/pull/32186), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: Fix RGW user/bucket quota issues
    ([pr#28174](https://github.com/ceph/ceph/pull/28174), Volker Theile)
-   mgr/dashboard: fix SAML input argument handling
    ([pr#29848](https://github.com/ceph/ceph/pull/29848), Ernesto
    Puerta)
-   mgr/dashboard: fix small typos in description message
    ([pr#30647](https://github.com/ceph/ceph/pull/30647), Tatjana
    Dehler)
-   mgr/dashboard: fix some performance data are not displayed
    ([issue#39971](http://tracker.ceph.com/issues/39971),
    [pr#28169](https://github.com/ceph/ceph/pull/28169), Kiefer Chang)
-   mgr/dashboard: fix sparkline component
    ([pr#26985](https://github.com/ceph/ceph/pull/26985), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: fix tasks.mgr.dashboard.test_rgw suite
    ([pr#33718](https://github.com/ceph/ceph/pull/33718), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: Fix the table mouseenter event handling test
    ([pr#28879](https://github.com/ceph/ceph/pull/28879), Stephan
    Mxc3xbcller)
-   mgr/dashboard: fix tox test failure
    ([pr#29125](https://github.com/ceph/ceph/pull/29125), Kiefer Chang)
-   mgr/dashboard: Fix translation of variables
    ([pr#30671](https://github.com/ceph/ceph/pull/30671), Tiago Melo)
-   mgr/dashboard: Fix typo in NFS form
    ([issue#39067](http://tracker.ceph.com/issues/39067),
    [pr#27245](https://github.com/ceph/ceph/pull/27245), Tiago Melo)
-   mgr/dashboard: fix visibility of pwdExpirationDate field
    ([pr#32703](https://github.com/ceph/ceph/pull/32703), Tatjana
    Dehler)
-   mgr/dashboard: Fix zsh support in run-backend-api-tests.sh
    ([pr#31070](https://github.com/ceph/ceph/pull/31070), Sebastian
    Wagner)
-   mgr/dashboard: Fix [npm run fixmod]{.title-ref} command
    ([pr#28176](https://github.com/ceph/ceph/pull/28176), Patrick
    Nawracay)
-   mgr/dashboard: Fixes defaultBuilder is not a function
    ([pr#29420](https://github.com/ceph/ceph/pull/29420), Ricardo
    Marques)
-   mgr/dashboard: Fixes random cephfs tab test failure
    ([pr#30814](https://github.com/ceph/ceph/pull/30814), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Fixes rbd image purge trash button & modal text
    ([pr#33321](https://github.com/ceph/ceph/pull/33321), anurag)
-   mgr/dashboard: Fixes tooltip behavior
    ([pr#27153](https://github.com/ceph/ceph/pull/27153), Stephan
    Mxc3xbcller)
-   mgr/dashboard: FixtureHelper
    ([pr#27157](https://github.com/ceph/ceph/pull/27157), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Form fields do not show error messages/hints
    ([pr#29043](https://github.com/ceph/ceph/pull/29043), Volker Theile)
-   mgr/dashboard: ganesha: Specify the name of the filesystem
    (create_path) ([pr#29182](https://github.com/ceph/ceph/pull/29182),
    David Casier)
-   mgr/dashboard: hide daemon table when orchestrator is disabled
    ([pr#33941](https://github.com/ceph/ceph/pull/33941), Kiefer Chang)
-   mgr/dashboard: hide in-use devices when creating OSDs
    ([pr#31927](https://github.com/ceph/ceph/pull/31927), Kiefer Chang)
-   mgr/dashboard: improve device selection modal for creating OSDs
    ([pr#33081](https://github.com/ceph/ceph/pull/33081), Kiefer Chang)
-   mgr/dashboard: Improve hints shown when message.xlf is invalid
    ([issue#40064](http://tracker.ceph.com/issues/40064),
    [pr#28377](https://github.com/ceph/ceph/pull/28377), Patrick
    Nawracay)
-   mgr/dashboard: Improve NFS Pseudo pattern message
    ([issue#39327](http://tracker.ceph.com/issues/39327),
    [pr#27653](https://github.com/ceph/ceph/pull/27653), Tiago Melo)
-   mgr/dashboard: Improve Notification sidebar
    ([pr#32895](https://github.com/ceph/ceph/pull/32895), Tiago Melo)
-   mgr/dashboard: Improve RestClient error logging
    ([pr#29794](https://github.com/ceph/ceph/pull/29794), Volker Theile)
-   mgr/dashboard: Increase column size on mgr module form
    ([pr#29107](https://github.com/ceph/ceph/pull/29107), Ricardo
    Marques)
-   mgr/dashboard: install teuthology using pip
    ([pr#31815](https://github.com/ceph/ceph/pull/31815), Kefu Chai)
-   mgr/dashboard: internationalization support with AOT enabled
    ([pr#30694](https://github.com/ceph/ceph/pull/30694), Tiago Melo,
    Ricardo Dias)
-   mgr/dashboard: Invalid SSO configuration when certificate path does
    not exist ([pr#31920](https://github.com/ceph/ceph/pull/31920),
    Ricardo Marques)
-   mgr/dashboard: iSCSI GET requests should not be logged
    ([pr#27813](https://github.com/ceph/ceph/pull/27813), Ricardo
    Marques)
-   mgr/dashboard: iSCSI targets not available if any gateway is down
    ([pr#31819](https://github.com/ceph/ceph/pull/31819), Ricardo
    Marques)
-   mgr/dashboard: Isolate each RBD component
    ([pr#33520](https://github.com/ceph/ceph/pull/33520), Tiago Melo)
-   mgr/dashboard: KeyError on dashboard reload
    ([pr#31469](https://github.com/ceph/ceph/pull/31469), Patrick
    Seidensal)
-   mgr/dashboard: KV-table transforms dates through pipe
    ([pr#27612](https://github.com/ceph/ceph/pull/27612), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Left align badge datatable columns
    ([pr#32053](https://github.com/ceph/ceph/pull/32053), Volker Theile)
-   mgr/dashboard: list services and daemons
    ([pr#33531](https://github.com/ceph/ceph/pull/33531), Sage Weil,
    Kiefer Chang)
-   mgr/dashboard: Localization for date picker module
    ([pr#27275](https://github.com/ceph/ceph/pull/27275), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Make all columns sortable
    ([pr#27784](https://github.com/ceph/ceph/pull/27784), Stephan
    Mxc3xbcller)
-   mgr/dashboard: make check mypy failure
    ([pr#33573](https://github.com/ceph/ceph/pull/33573), Volker Theile)
-   mgr/dashboard: Make password policy check configurable
    ([pr#32546](https://github.com/ceph/ceph/pull/32546), Volker Theile)
-   mgr/dashboard: Make preventDefault work with 400 errors
    ([pr#26561](https://github.com/ceph/ceph/pull/26561), Stephan
    Mxc3xbcller)
-   mgr/dashboard: monitoring: improve generic Could not reach external
    API message ([pr#32648](https://github.com/ceph/ceph/pull/32648),
    Patrick Seidensal)
-   mgr/dashboard: Not able to restrict bucket creation for new user
    ([pr#33612](https://github.com/ceph/ceph/pull/33612), Volker Theile)
-   mgr/dashboard: Optimize portal IPs calculation
    ([pr#28084](https://github.com/ceph/ceph/pull/28084), Ricardo
    Marques)
-   mgr/dashboard: orchestrator integration initial works
    ([pr#29127](https://github.com/ceph/ceph/pull/29127), Kiefer Chang)
-   mgr/dashboard: OSD custom action button removal
    ([pr#28095](https://github.com/ceph/ceph/pull/28095), Stephan
    Mxc3xbcller)
-   mgr/dashboard: OSD improvements
    ([pr#30493](https://github.com/ceph/ceph/pull/30493), Patrick
    Seidensal)
-   mgr/dashboard: pass a list of drive_group to create_osds
    ([pr#33014](https://github.com/ceph/ceph/pull/33014), Kefu Chai)
-   mgr/dashboard: Pool form uses different loading spinner
    ([pr#28649](https://github.com/ceph/ceph/pull/28649), Volker Theile)
-   mgr/dashboard: Prevent deletion of iSCSI IQNs with open sessions
    ([pr#29133](https://github.com/ceph/ceph/pull/29133), Ricardo
    Marques)
-   mgr/dashboard: Prevent KeyError when requesting always_on_modules
    ([pr#30426](https://github.com/ceph/ceph/pull/30426), Volker Theile)
-   mgr/dashboard: Process password complexity checks immediately
    ([pr#32032](https://github.com/ceph/ceph/pull/32032), Volker Theile,
    Tatjana Dehler)
-   mgr/dashboard: Provide the name of the object being deleted
    ([pr#30658](https://github.com/ceph/ceph/pull/30658), Ricardo
    Marques)
-   mgr/dashboard: Provide user enable/disable capability
    ([issue#25229](http://tracker.ceph.com/issues/25229),
    [pr#29046](https://github.com/ceph/ceph/pull/29046), Ricardo Dias,
    Patrick Nawracay)
-   mgr/dashboard: Push Grafana dashboards on startup
    ([pr#26415](https://github.com/ceph/ceph/pull/26415), Zack Cerza)
-   mgr/dashboard: qa: fix RBD test when matching error strings
    ([pr#29264](https://github.com/ceph/ceph/pull/29264), Ricardo Dias)
-   mgr/dashboard: qa: whitelist client eviction warning
    ([pr#29114](https://github.com/ceph/ceph/pull/29114), Ricardo Dias)
-   mgr/dashboard: RBD snapshot name suggestion with local time suffix
    ([pr#27613](https://github.com/ceph/ceph/pull/27613), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Reduce the number of renders on the tables
    ([issue#39944](http://tracker.ceph.com/issues/39944),
    [pr#28118](https://github.com/ceph/ceph/pull/28118), Tiago Melo)
-   mgr/dashboard: Refactor and cleanup tasks.mgr.dashboard.test_user
    ([pr#33743](https://github.com/ceph/ceph/pull/33743), Volker Theile)
-   mgr/dashboard: Refactor Python unittests and controller
    ([pr#31165](https://github.com/ceph/ceph/pull/31165), Volker Theile)
-   mgr/dashboard: Reload all CephFS directories
    ([pr#32552](https://github.com/ceph/ceph/pull/32552), Stephan
    Mxc3xbcller)
-   mgr/dashboard: remove config-opt: read perm. from system roles
    ([pr#33690](https://github.com/ceph/ceph/pull/33690), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: Remove ngx-store
    ([pr#33756](https://github.com/ceph/ceph/pull/33756), Tiago Melo)
-   mgr/dashboard: remove traceback/version assertions
    ([pr#31720](https://github.com/ceph/ceph/pull/31720), Ernesto
    Puerta)
-   mgr/dashboard: Remove unused RBD configuration endpoint
    ([pr#30815](https://github.com/ceph/ceph/pull/30815), Ricardo
    Marques)
-   mgr/dashboard: Remove unused variable
    ([pr#31785](https://github.com/ceph/ceph/pull/31785), Volker Theile)
-   mgr/dashboard: Removes distracting search behavior
    ([pr#27438](https://github.com/ceph/ceph/pull/27438), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Rename pipe list -\> join
    ([pr#31843](https://github.com/ceph/ceph/pull/31843), Volker Theile)
-   mgr/dashboard: Replace IP address validation with Python standard
    library functions
    ([pr#26184](https://github.com/ceph/ceph/pull/26184), Ashish Singh)
-   mgr/dashboard: Replace ng2-tree with angular-tree-component
    ([pr#33758](https://github.com/ceph/ceph/pull/33758), Tiago Melo)
-   mgr/dashboard: RGW bucket creation when no placement target received
    ([pr#29280](https://github.com/ceph/ceph/pull/29280), alfonsomthd)
-   mgr/dashboard: RGW port autodetection does not support Beast RGW
    frontend ([pr#33060](https://github.com/ceph/ceph/pull/33060),
    Volker Theile)
-   mgr/dashboard: RGW User quota validation is not working correctly
    ([pr#29132](https://github.com/ceph/ceph/pull/29132), Volker Theile)
-   mgr/dashboard: run e2e tests against prod build (jenkins job)
    ([pr#29198](https://github.com/ceph/ceph/pull/29198), alfonsomthd)
-   mgr/dashboard: run-frontend-e2e-tests.sh: allow user defined
    BASE_URLxe2x80xa6
    ([pr#32211](https://github.com/ceph/ceph/pull/32211), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: select placement target on RGW bucket creation
    ([pr#28764](https://github.com/ceph/ceph/pull/28764), alfonsomthd)
-   mgr/dashboard: Set RO as the default access_type for RGW NFS exports
    ([pr#30111](https://github.com/ceph/ceph/pull/30111), Tiago Melo)
-   mgr/dashboard: show checkboxes for booleans
    ([pr#32836](https://github.com/ceph/ceph/pull/32836), Tatjana
    Dehler)
-   mgr/dashboard: show correct RGW user system info
    ([pr#33206](https://github.com/ceph/ceph/pull/33206), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: Show iSCSI gateways status in the health page
    ([pr#29112](https://github.com/ceph/ceph/pull/29112), Ricardo
    Marques)
-   mgr/dashboard: smart: smart data read out on down osd causes error
    popup ([pr#32953](https://github.com/ceph/ceph/pull/32953), Volker
    Theile)
-   mgr/dashboard: Standby Dashboards dont handle all requests properly
    ([pr#30478](https://github.com/ceph/ceph/pull/30478), Volker Theile)
-   mgr/dashboard: Support ceph-iscsi config v9
    ([pr#27448](https://github.com/ceph/ceph/pull/27448), Ricardo
    Marques)
-   mgr/dashboard: support multiple DriveGroups when creating OSDs
    ([pr#32678](https://github.com/ceph/ceph/pull/32678), Kiefer Chang)
-   mgr/dashboard: support removing OSDs in OSDs page
    ([pr#31997](https://github.com/ceph/ceph/pull/31997), Kiefer Chang)
-   mgr/dashboard: support setting password hashes
    ([pr#29138](https://github.com/ceph/ceph/pull/29138), Fabian Bonk)
-   mgr/dashboard: tasks: only unblock controller thread after
    TaskManager thread
    ([pr#30747](https://github.com/ceph/ceph/pull/30747), Ricardo Dias)
-   mgr/dashboard: Throw a more meaningful exception
    ([pr#32234](https://github.com/ceph/ceph/pull/32234), Volker Theile)
-   mgr/dashboard: tox.ini fixes
    ([pr#30779](https://github.com/ceph/ceph/pull/30779), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: UI fixes
    ([pr#33171](https://github.com/ceph/ceph/pull/33171), Avan Thakkar)
-   mgr/dashboard: Unable to set boolean values to false when default is
    true ([pr#31738](https://github.com/ceph/ceph/pull/31738), Ricardo
    Marques)
-   mgr/dashboard: unify button/URL actions naming
    ([issue#37337](http://tracker.ceph.com/issues/37337),
    [pr#26572](https://github.com/ceph/ceph/pull/26572), Ernesto Puerta)
-   mgr/dashboard: Unify the look of dashboard charts
    ([issue#39384](http://tracker.ceph.com/issues/39384),
    [pr#27681](https://github.com/ceph/ceph/pull/27681), Tiago Melo)
-   mgr/dashboard: update dashboard CODEOWNERShip
    ([pr#31193](https://github.com/ceph/ceph/pull/31193), Ernesto
    Puerta)
-   mgr/dashboard: Update tar to v4.4.8
    ([pr#28092](https://github.com/ceph/ceph/pull/28092), Kefu Chai)
-   mgr/dashboard: update vstart to use new ssl port
    ([issue#26914](http://tracker.ceph.com/issues/26914),
    [pr#27269](https://github.com/ceph/ceph/pull/27269), Ernesto Puerta)
-   mgr/dashboard: Updated octopus image on 404 page
    ([pr#33920](https://github.com/ceph/ceph/pull/33920), Lenz Grimmer)
-   mgr/dashboard: Use booleanText pipe
    ([pr#26733](https://github.com/ceph/ceph/pull/26733), Volker Theile)
-   mgr/dashboard: Use default language when running npm run build
    ([pr#31563](https://github.com/ceph/ceph/pull/31563), Tiago Melo)
-   mgr/dashboard: Use ModalComponent in all modals
    ([pr#33858](https://github.com/ceph/ceph/pull/33858), Tiago Melo)
-   mgr/dashboard: Use Observable in auth.service
    ([pr#32084](https://github.com/ceph/ceph/pull/32084), Volker Theile)
-   mgr/dashboard: Use onCancel on any modal event
    ([pr#29402](https://github.com/ceph/ceph/pull/29402), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Validate iSCSI controls min/max value
    ([pr#28942](https://github.com/ceph/ceph/pull/28942), Ricardo
    Marques)
-   mgr/dashboard: Validate iSCSI images features
    ([pr#27135](https://github.com/ceph/ceph/pull/27135), Ricardo
    Marques)
-   mgr/dashboard: Validate [ceph-iscsi]{.title-ref} config version
    ([pr#26835](https://github.com/ceph/ceph/pull/26835), Ricardo
    Marques)
-   mgr/dashboard: Various UI issues related to CephFS
    ([pr#29272](https://github.com/ceph/ceph/pull/29272), Volker Theile)
-   mgr/dashboard: Vertically align the Refresh label
    ([pr#29737](https://github.com/ceph/ceph/pull/29737), Tiago Melo)
-   mgr/dashboard: vstart: Fix /dev/tty No such device or address
    ([pr#31195](https://github.com/ceph/ceph/pull/31195), Volker Theile)
-   mgr/dashboard: wait for PG unknown state to be cleared
    ([pr#33013](https://github.com/ceph/ceph/pull/33013), Tatjana
    Dehler)
-   mgr/dashboard: Watch for pool pgs increase and decrease
    ([pr#28006](https://github.com/ceph/ceph/pull/28006), Ricardo Dias,
    Stephan Mxc3xbcller)
-   mgr/modules: outsource SSL certificate creation
    ([pr#33550](https://github.com/ceph/ceph/pull/33550), Patrick
    Seidensal)
-   mgr/orch,cephadm: add timestamps to daemons and services
    ([pr#33728](https://github.com/ceph/ceph/pull/33728), Sage Weil)
-   mgr/orch: add \--all-available-devices to orch apply osd
    ([pr#33990](https://github.com/ceph/ceph/pull/33990), Sage Weil)
-   mgr/orch: add missing CLI commands for grafana, alertmanager
    ([pr#33695](https://github.com/ceph/ceph/pull/33695), Sage Weil)
-   mgr/orch: associate addresses with hosts
    ([pr#33098](https://github.com/ceph/ceph/pull/33098), Sage Weil)
-   mgr/orch: ceph orchestrator \... -\> ceph orch \...
    ([pr#33131](https://github.com/ceph/ceph/pull/33131), Sage Weil)
-   mgr/orch: ceph upgrade \... -\> ceph orch upgrade \...
    ([pr#34046](https://github.com/ceph/ceph/pull/34046), Sage Weil)
-   mgr/orch: collapse SPEC and PLACEMENT columns in orch ls
    ([pr#33795](https://github.com/ceph/ceph/pull/33795), Sage Weil)
-   mgr/orch: dump service spec by name
    ([pr#33951](https://github.com/ceph/ceph/pull/33951), Michael
    Fritch)
-   mgr/orch: first phase of new cli
    ([pr#33212](https://github.com/ceph/ceph/pull/33212), Sage Weil)
-   mgr/orch: fix host ls
    ([pr#33486](https://github.com/ceph/ceph/pull/33486), Sage Weil)
-   mgr/orch: fix orch ls table spacing
    ([pr#33586](https://github.com/ceph/ceph/pull/33586), Sage Weil)
-   mgr/orch: fix ServiceSpec deserialization error
    ([pr#33779](https://github.com/ceph/ceph/pull/33779), Kiefer Chang)
-   mgr/orch: improve commandline parsing for update\\\_\\\*
    ([pr#31672](https://github.com/ceph/ceph/pull/31672), Joshua Schmid)
-   mgr/orch: include spec ref in ServiceDescription
    ([pr#33667](https://github.com/ceph/ceph/pull/33667), Sage Weil)
-   mgr/orch: make arg hostname, not host
    ([pr#33474](https://github.com/ceph/ceph/pull/33474), Sage Weil)
-   mgr/orch: new cli, phase 2
    ([pr#33244](https://github.com/ceph/ceph/pull/33244), Sage Weil)
-   mgr/orch: pass unicode string to ipaddress.ip_network()
    ([pr#31755](https://github.com/ceph/ceph/pull/31755), Kefu Chai)
-   mgr/orch: PlacementSpec: add all_hosts property
    ([pr#33465](https://github.com/ceph/ceph/pull/33465), Sage Weil)
-   mgr/orch: Properly handle NotImplementedError
    ([pr#33914](https://github.com/ceph/ceph/pull/33914), Sebastian
    Wagner)
-   mgr/orch: remove ansible and deepsea
    ([pr#33126](https://github.com/ceph/ceph/pull/33126), Sage Weil)
-   mgr/orch: resurrect ServiceDescription, orch ls
    ([pr#33359](https://github.com/ceph/ceph/pull/33359), Sage Weil)
-   mgr/orch: take a single placement argument
    ([pr#33706](https://github.com/ceph/ceph/pull/33706), Sage Weil)
-   mgr/orchestrator,mgr/ssh: add host labels
    ([pr#31854](https://github.com/ceph/ceph/pull/31854), Sage Weil)
-   mgr/orchestrator: Add doc about how to use OrchestratorClientMixin
    ([pr#32893](https://github.com/ceph/ceph/pull/32893), Sebastian
    Wagner)
-   mgr/orchestrator: Add mypy static type checking
    ([pr#32010](https://github.com/ceph/ceph/pull/32010), Sebastian
    Wagner)
-   mgr/orchestrator: add optional format param for orchestrator host ls
    ([pr#31930](https://github.com/ceph/ceph/pull/31930), Kefu Chai)
-   mgr/orchestrator: add progress events to all orchestrators
    ([pr#26654](https://github.com/ceph/ceph/pull/26654), Sebastian
    Wagner)
-   mgr/orchestrator: Add simple scheduler
    ([pr#32003](https://github.com/ceph/ceph/pull/32003), Joshua Schmid)
-   mgr/orchestrator: addr is optional for constructing InventoryNode
    ([pr#33347](https://github.com/ceph/ceph/pull/33347), Kefu Chai)
-   mgr/orchestrator: device lights
    ([pr#26768](https://github.com/ceph/ceph/pull/26768), Sebastian
    Wagner, Sage Weil)
-   mgr/orchestrator: do not try to iterate through None
    ([pr#31705](https://github.com/ceph/ceph/pull/31705), Kefu Chai)
-   mgr/orchestrator: Document OSD replacement
    ([pr#29792](https://github.com/ceph/ceph/pull/29792), Sebastian
    Wagner)
-   mgr/orchestrator: fix orch host label rm help text
    ([pr#33585](https://github.com/ceph/ceph/pull/33585), Sage Weil)
-   mgr/orchestrator: Fix raise_if_exception for Python 3
    ([pr#31015](https://github.com/ceph/ceph/pull/31015), Sebastian
    Wagner)
-   mgr/orchestrator: fix refs property of progresses
    ([pr#30197](https://github.com/ceph/ceph/pull/30197), Kiefer Chang)
-   mgr/orchestrator: fix [ceph orch apply -i]{.title-ref} + yaml
    cleanup + Completion cleanup
    ([pr#34001](https://github.com/ceph/ceph/pull/34001), Sebastian
    Wagner)
-   mgr/orchestrator: functools.partial doesnt work for methods
    ([pr#33432](https://github.com/ceph/ceph/pull/33432), Sebastian
    Wagner)
-   mgr/orchestrator: get_hosts return [HostSpec]{.title-ref} instead of
    [InventoryDevice]{.title-ref}
    ([pr#33258](https://github.com/ceph/ceph/pull/33258), Sebastian
    Wagner)
-   mgr/orchestrator: Make Completions composable
    ([pr#30262](https://github.com/ceph/ceph/pull/30262), Sebastian
    Wagner, Tim Serong)
-   mgr/orchestrator: make hosts and label args consistent
    ([pr#32253](https://github.com/ceph/ceph/pull/32253), Sage Weil)
-   mgr/orchestrator: Raise more expressive Error, if completion already
    xe2x80xa6 ([pr#32270](https://github.com/ceph/ceph/pull/32270),
    Sebastian Wagner)
-   mgr/orchestrator: raise_if_exception: Add exception type to message
    ([pr#32574](https://github.com/ceph/ceph/pull/32574), Sebastian
    Wagner)
-   mgr/orchestrator: Remove
    [(add\|test\|remove)\_stateful_service_rule]{.title-ref}
    ([pr#26772](https://github.com/ceph/ceph/pull/26772), Sebastian
    Wagner)
-   mgr/orchestrator: set node labels to empty list if none specified
    ([pr#31914](https://github.com/ceph/ceph/pull/31914), Tim Serong)
-   mgr/orchestrator: Split \\\*\_stateless_service and add
    get_feature_set
    ([pr#29063](https://github.com/ceph/ceph/pull/29063), Sebastian
    Wagner)
-   mgr/orchestrator: Substitute [hostname]{.title-ref} for
    [nodename]{.title-ref}, globally
    ([pr#33467](https://github.com/ceph/ceph/pull/33467), Sebastian
    Wagner)
-   mgr/orchestrator: unify StatelessServiceSpec and StatefulServiceSpec
    ([pr#33175](https://github.com/ceph/ceph/pull/33175), Sebastian
    Wagner)
-   mgr/orchestrator: use deepcopy for copying exceptions
    ([pr#32881](https://github.com/ceph/ceph/pull/32881), Kefu Chai)
-   mgr/orchestrator: Use [pickle]{.title-ref} to pass exceptions across
    sub-interpreters
    ([pr#33179](https://github.com/ceph/ceph/pull/33179), Sebastian
    Wagner)
-   mgr/orchestrator_cli: clean up device ls table
    ([pr#32279](https://github.com/ceph/ceph/pull/32279), Sage Weil)
-   mgr/orchestrator_cli: Fix NFS
    ([pr#32272](https://github.com/ceph/ceph/pull/32272), Sebastian
    Wagner)
-   mgr/orchestrator_cli: improve service ls output, sorting
    ([pr#31539](https://github.com/ceph/ceph/pull/31539), Sage Weil)
-   mgr/orchestrator_cli: set type for orchestrator option
    ([pr#32189](https://github.com/ceph/ceph/pull/32189), Sage Weil)
-   mgr/orchestrator_cli: sort host list
    ([pr#33370](https://github.com/ceph/ceph/pull/33370), Sage Weil)
-   mgr/orchestrator_cli: \_update_mons require host spec only
    ([pr#32499](https://github.com/ceph/ceph/pull/32499), Sebastian
    Wagner)
-   mgr/progress/module.py: s/events/\_events/
    ([pr#29625](https://github.com/ceph/ceph/pull/29625), Kamoltat
    (Junior) Sirivadhna)
-   mgr/rook: Add caching for the Dashboard
    ([pr#29131](https://github.com/ceph/ceph/pull/29131), Sebastian
    Wagner, Paul Cuzner)
-   mgr/rook: Added missing [rgw]{.title-ref} daemons in [service
    ls]{.title-ref}
    ([issue#39171](http://tracker.ceph.com/issues/39171),
    [pr#27491](https://github.com/ceph/ceph/pull/27491), Sebastian
    Wagner)
-   mgr/rook: Added Mypy static type checking
    ([pr#32127](https://github.com/ceph/ceph/pull/32127), Sebastian
    Wagner)
-   mgr/rook: Fix creation of bluestore OSDs
    ([issue#39062](http://tracker.ceph.com/issues/39062),
    [pr#27289](https://github.com/ceph/ceph/pull/27289), Sebastian
    Wagner)
-   mgr/rook: Fix error creating OSDs
    ([pr#33176](https://github.com/ceph/ceph/pull/33176), Juan Miguel
    Olmo Martxc3xadnez)
-   mgr/rook: Fix Python 2 regression
    ([issue#39250](http://tracker.ceph.com/issues/39250),
    [pr#27516](https://github.com/ceph/ceph/pull/27516), Sebastian
    Wagner)
-   mgr/rook: Fix RGW creation
    ([issue#39158](http://tracker.ceph.com/issues/39158),
    [pr#27462](https://github.com/ceph/ceph/pull/27462), Sebastian
    Wagner)
-   mgr/rook: misc fixes for orch ps
    ([pr#33868](https://github.com/ceph/ceph/pull/33868), Sage Weil)
-   mgr/rook: provide full path for devices names in inventory
    ([pr#32654](https://github.com/ceph/ceph/pull/32654), Sage Weil)
-   mgr/rook: Remove support for Rook older than v0.9
    ([issue#39278](http://tracker.ceph.com/issues/39278),
    [pr#27556](https://github.com/ceph/ceph/pull/27556), Sebastian
    Wagner)
-   mgr/rook: Support other system namespaces
    ([issue#38799](http://tracker.ceph.com/issues/38799),
    [pr#27290](https://github.com/ceph/ceph/pull/27290), Sebastian
    Wagner)
-   mgr/ssh/tests: fix RGWSpec test
    ([pr#31983](https://github.com/ceph/ceph/pull/31983), Sage Weil)
-   mgr/ssh: add per-service operations: start, stop, restart, redeploy
    ([pr#31292](https://github.com/ceph/ceph/pull/31292), Sage Weil)
-   mgr/ssh: add TemporaryDirectory impl for py2 compat
    ([pr#31835](https://github.com/ceph/ceph/pull/31835), Sage Weil)
-   mgr/ssh: allow passing LV to orchestrator osd create
    ([pr#31512](https://github.com/ceph/ceph/pull/31512), Sage Weil)
-   mgr/ssh: annotate object representation
    ([pr#31602](https://github.com/ceph/ceph/pull/31602), Joshua Schmid)
-   mgr/ssh: cache service inventory
    ([pr#31385](https://github.com/ceph/ceph/pull/31385), Sage Weil)
-   mgr/ssh: deploy and remove rgw daemons
    ([pr#31303](https://github.com/ceph/ceph/pull/31303), Sage Weil)
-   mgr/ssh: deploy rbd-mirror daemons
    ([pr#31493](https://github.com/ceph/ceph/pull/31493), Sage Weil)
-   mgr/ssh: fix redeploy
    ([pr#31613](https://github.com/ceph/ceph/pull/31613), Sage Weil)
-   mgr/ssh: fix service_action, remove_osds
    ([pr#31952](https://github.com/ceph/ceph/pull/31952), Sage Weil)
-   mgr/ssh: Fix various Python issues
    ([pr#31524](https://github.com/ceph/ceph/pull/31524), Volker Theile)
-   mgr/ssh: Ignore ssh-config file
    ([pr#31710](https://github.com/ceph/ceph/pull/31710), Volker Theile)
-   mgr/ssh: implement blink_device_light
    ([pr#31438](https://github.com/ceph/ceph/pull/31438), Sage Weil)
-   mgr/ssh: implement service ls
    ([pr#31169](https://github.com/ceph/ceph/pull/31169), Sage Weil)
-   mgr/ssh: improve service ls
    ([pr#31828](https://github.com/ceph/ceph/pull/31828), Sage Weil)
-   mgr/ssh: Install SSH public key in Vagrantfile box fails
    ([pr#31519](https://github.com/ceph/ceph/pull/31519), Volker Theile)
-   mgr/ssh: optionally specify service names
    ([pr#31537](https://github.com/ceph/ceph/pull/31537), Sage Weil)
-   mgr/ssh: packaged-ceph-daemon mode; ssh key mgmt
    ([pr#31698](https://github.com/ceph/ceph/pull/31698), Sage Weil)
-   mgr/ssh: Port raising exceptions from completion handlers to Py2
    ([pr#31940](https://github.com/ceph/ceph/pull/31940), Sebastian
    Wagner)
-   mgr/ssh: raise RuntimeError when ceph-daemon invocation fails
    ([pr#31420](https://github.com/ceph/ceph/pull/31420), Sage Weil)
-   mgr/ssh: remove superfluous parameters
    ([pr#31462](https://github.com/ceph/ceph/pull/31462), Joshua Schmid)
-   mgr/ssh: set up dummy known_hosts file
    ([pr#31721](https://github.com/ceph/ceph/pull/31721), Sage Weil)
-   mgr/ssh: take IP, CIDR, or addrvec for new mon(s)
    ([pr#31505](https://github.com/ceph/ceph/pull/31505), Sage Weil)
-   mgr/ssh: upgrade check command
    ([pr#31827](https://github.com/ceph/ceph/pull/31827), Sage Weil)
-   mgr/ssh: [test_mon_update]{.title-ref} needs to set a mon name
    ([pr#31933](https://github.com/ceph/ceph/pull/31933), Sebastian
    Wagner)
-   mgr/telemetry: anonymizing smartctl report itself
    ([pr#33029](https://github.com/ceph/ceph/pull/33029), Yaarit Hatuka)
-   mgr/telemetry: dict.pop() errs on nonexistent key
    ([pr#30854](https://github.com/ceph/ceph/pull/30854), Dan Mick)
-   mgr/telemetry: fix log typo
    ([pr#31984](https://github.com/ceph/ceph/pull/31984), Sage Weil)
-   mgr/test_orchestrator: Allow initializing dummy data
    ([pr#29595](https://github.com/ceph/ceph/pull/29595), Kiefer Chang)
-   mgr/test_orchestrator: fix tests
    ([pr#33541](https://github.com/ceph/ceph/pull/33541), Sage Weil)
-   mgr/test_orchestrator: Fix TestWriteCompletion object has no
    attribute id ([pr#27607](https://github.com/ceph/ceph/pull/27607),
    Sebastian Wagner)
-   mgr/test_orchestrator: fix update_mgrs assert
    ([pr#32417](https://github.com/ceph/ceph/pull/32417), Sage Weil)
-   mgr/volumes: add arg to fs volume create for mds daemons placement
    ([pr#33441](https://github.com/ceph/ceph/pull/33441),
    Daniel-Pivonka)
-   mgr: Add get_rates_from_data to mgr_util.py
    ([pr#28603](https://github.com/ceph/ceph/pull/28603), Stephan
    Mxc3xbcller)
-   mgr: add rbd profiles to support rbd_support module commands
    ([pr#30912](https://github.com/ceph/ceph/pull/30912), Jason
    Dillaman)
-   mgr: better error handling when reading option
    ([pr#32730](https://github.com/ceph/ceph/pull/32730), Kefu Chai)
-   mgr: ceph fs status support json format
    ([pr#30985](https://github.com/ceph/ceph/pull/30985), Erqi Chen)
-   mgr: change perf-counter precision to float
    ([pr#30400](https://github.com/ceph/ceph/pull/30400), Ernesto
    Puerta)
-   mgr: check for unicode passed to set_health_checks()
    ([pr#29117](https://github.com/ceph/ceph/pull/29117), Kefu Chai)
-   mgr: cleanup idle debug log at level 4
    ([pr#29164](https://github.com/ceph/ceph/pull/29164), Sebastian
    Wagner)
-   mgr: close restful socket after exec
    ([pr#32396](https://github.com/ceph/ceph/pull/32396), liushi)
-   mgr: Configure Py root logger for Mgr modules
    ([pr#27069](https://github.com/ceph/ceph/pull/27069), Volker Theile)
-   mgr: do not reset reported if a new metric is not collected
    ([pr#30285](https://github.com/ceph/ceph/pull/30285), Ilsoo Byun)
-   mgr: drop session with Ceph daemon when not ready
    ([pr#31899](https://github.com/ceph/ceph/pull/31899), Patrick
    Donnelly)
-   mgr: fix a few bugs with teh pgp_num adjustments
    ([pr#27875](https://github.com/ceph/ceph/pull/27875), Sage Weil)
-   mgr: fix ceph native option value types
    ([pr#29855](https://github.com/ceph/ceph/pull/29855), Sage Weil)
-   mgr: fix debug typo
    ([pr#31900](https://github.com/ceph/ceph/pull/31900), Patrick
    Donnelly)
-   mgr: fix errors on using a reference in a Lambda function
    ([pr#31786](https://github.com/ceph/ceph/pull/31786), Willem Jan
    Withagen)
-   mgr: fix reporting of per-module logging options to mon
    ([pr#33897](https://github.com/ceph/ceph/pull/33897), Sage Weil)
-   mgr: fix weird health-alert daemon key
    ([pr#30617](https://github.com/ceph/ceph/pull/30617), xie xingguo)
-   mgr: handle race with finisher after shutdown
    ([pr#31620](https://github.com/ceph/ceph/pull/31620), Patrick
    Donnelly)
-   mgr: Improve internal python to c++ interface
    ([pr#32554](https://github.com/ceph/ceph/pull/32554), David Zafman)
-   mgr: install tox deps from wheelhouse
    ([pr#30034](https://github.com/ceph/ceph/pull/30034), Kefu Chai)
-   mgr: mgr, osd: osd df by pool
    ([pr#28629](https://github.com/ceph/ceph/pull/28629), xie xingguo)
-   mgr: mgr/ActivePyModules: behave if a module queries a devid that
    does not exist ([pr#31291](https://github.com/ceph/ceph/pull/31291),
    Sage Weil)
-   mgr: mgr/ActivePyModules: drop GIL while we wait for mon reply in
    set_store, set_config
    ([issue#39335](http://tracker.ceph.com/issues/39335),
    [pr#27619](https://github.com/ceph/ceph/pull/27619), Sage Weil)
-   mgr: mgr/ActivePyModules: handle_command - fix broken lock
    ([issue#39235](http://tracker.ceph.com/issues/39235),
    [pr#27485](https://github.com/ceph/ceph/pull/27485), xie xingguo)
-   mgr: mgr/balancer: avoid pulling pg_dump twice
    ([pr#32266](https://github.com/ceph/ceph/pull/32266), xie xingguo)
-   mgr: mgr/balancer: eliminate usage of MS infrastructure for upmap
    mode ([pr#32289](https://github.com/ceph/ceph/pull/32289), xie
    xingguo)
-   mgr: mgr/balancer: enable pg_upmap cli for future use
    ([pr#30560](https://github.com/ceph/ceph/pull/30560), xie xingguo)
-   mgr: mgr/balancer: fix fudge
    ([pr#27994](https://github.com/ceph/ceph/pull/27994), xie xingguo)
-   mgr: mgr/balancer: fix initial weight-set value for newly created
    osds ([pr#28251](https://github.com/ceph/ceph/pull/28251), xie
    xingguo)
-   mgr: mgr/balancer: Python 3 compatibility fix
    ([issue#38831](http://tracker.ceph.com/issues/38831),
    [pr#27076](https://github.com/ceph/ceph/pull/27076), Marius
    Schiffer)
-   mgr: mgr/balancer: python3 compatibility issue
    ([pr#30987](https://github.com/ceph/ceph/pull/30987), Mykola Golub)
-   mgr: mgr/balancer: upmap_max_iterations -\> upmap_max_optimizations;
    behave as it is per pool
    ([pr#30591](https://github.com/ceph/ceph/pull/30591), xie xingguo)
-   mgr: mgr/BaseMgrModule: tolerate Int or Long for health count
    ([pr#29806](https://github.com/ceph/ceph/pull/29806), Sage Weil)
-   mgr: mgr/BaseMgrModule: use PyInt_Check() to compatible with py2
    ([pr#29831](https://github.com/ceph/ceph/pull/29831), Kefu Chai)
-   mgr: mgr/BaseMgrStandbyModule: drop GIL in ceph_get_module_option()
    ([pr#30625](https://github.com/ceph/ceph/pull/30625), Kefu Chai)
-   mgr: mgr/cephadm: custom certificates for Grafana deployment
    ([pr#33614](https://github.com/ceph/ceph/pull/33614), Patrick
    Seidensal)
-   mgr: mgr/cephadm: support (point release) upgrades
    ([pr#32006](https://github.com/ceph/ceph/pull/32006), Sage Weil)
-   mgr: mgr/crash: Calculate and add stack_sig to metadata
    ([pr#31394](https://github.com/ceph/ceph/pull/31394), Dan Mick)
-   mgr: mgr/crash: fix crash ls\[-new\] sorting
    ([pr#31973](https://github.com/ceph/ceph/pull/31973), Sage Weil)
-   mgr: mgr/DaemonServer: handle caps more carefully
    ([pr#26903](https://github.com/ceph/ceph/pull/26903), xie xingguo)
-   mgr: mgr/DaemonServer: handle_conf_change - fix broken locking
    ([issue#38899](http://tracker.ceph.com/issues/38899),
    [pr#27184](https://github.com/ceph/ceph/pull/27184), xie xingguo)
-   mgr: mgr/DaemonServer: refactor pgp_num changes throttling
    ([pr#27891](https://github.com/ceph/ceph/pull/27891), Kefu Chai)
-   mgr: mgr/DaemonServer: safe-to-destroy - do not consider irrelevant
    pgs ([pr#27962](https://github.com/ceph/ceph/pull/27962), xie
    xingguo)
-   mgr: mgr/DaemonServer: skip adjusting pgp_num when merging is
    in-progress ([pr#30139](https://github.com/ceph/ceph/pull/30139),
    xie xingguo)
-   mgr: mgr/dashboard: Do not default to admin as Admin Resource
    ([issue#39338](http://tracker.ceph.com/issues/39338),
    [pr#27626](https://github.com/ceph/ceph/pull/27626), Wido den
    Hollander)
-   mgr: mgr/dashboard: Handle always-on Ceph Manager modules correctly
    ([pr#30142](https://github.com/ceph/ceph/pull/30142), Volker Theile)
-   mgr: mgr/dashboard: integrate progress mgr module events into
    dashboard tasks list
    ([pr#29048](https://github.com/ceph/ceph/pull/29048), Ricardo Dias)
-   mgr: mgr/dashboard: Manager should complain about wrong dashboard
    certificate ([pr#27036](https://github.com/ceph/ceph/pull/27036),
    Volker Theile)
-   mgr: mgr/deepsea: return ganesha and iscsi endpoint URLs
    ([pr#27336](https://github.com/ceph/ceph/pull/27336), Tim Serong)
-   mgr: mgr/deepsea: use ceph_volume output in get_inventory()
    ([pr#26966](https://github.com/ceph/ceph/pull/26966), Tim Serong)
-   mgr: mgr/devicehealth: ensure we dont store empty objects
    ([pr#31474](https://github.com/ceph/ceph/pull/31474), Sage Weil)
-   mgr: mgr/devicehealth: Fix python 3 incompatiblity
    ([issue#38939](http://tracker.ceph.com/issues/38939),
    [pr#27172](https://github.com/ceph/ceph/pull/27172), Marius
    Schiffer)
-   mgr: mgr/devicehealth: set default monitoring to on
    ([pr#33091](https://github.com/ceph/ceph/pull/33091), Sage Weil,
    Yaarit Hatuka)
-   mgr: mgr/diskprediction: Add diskprediction local plugin
    dependencies ([pr#25530](https://github.com/ceph/ceph/pull/25530),
    Rick Chen)
-   mgr: mgr/diskprediction_cloud: Correct base64 encode translate table
    ([issue#38848](http://tracker.ceph.com/issues/38848),
    [pr#27113](https://github.com/ceph/ceph/pull/27113), Rick Chen)
-   mgr: mgr/diskprediction_cloud: refactor timeout() decorator
    ([pr#31176](https://github.com/ceph/ceph/pull/31176), Kefu Chai)
-   mgr: mgr/hello: some clean up and modernization
    ([pr#29514](https://github.com/ceph/ceph/pull/29514), Sage Weil)
-   mgr: mgr/influx: try to call close()
    ([issue#40174](http://tracker.ceph.com/issues/40174),
    [pr#28427](https://github.com/ceph/ceph/pull/28427), Kefu Chai)
-   mgr: mgr/insights: fix prune-health-history
    ([pr#32973](https://github.com/ceph/ceph/pull/32973), Sage Weil)
-   mgr: mgr/k8sevents: Add mgr module for kubernetes event integration
    ([pr#29520](https://github.com/ceph/ceph/pull/29520), Paul Cuzner)
-   mgr: mgr/k8sevents: Add support for remote kubernetes
    ([pr#30482](https://github.com/ceph/ceph/pull/30482), Paul Cuzner)
-   mgr: mgr/Mgr: kill redundant sub_unwant call
    ([pr#26950](https://github.com/ceph/ceph/pull/26950), xie xingguo)
-   mgr: mgr/MgrMonitor: print pending.always_on_modules before updating
    it ([pr#29917](https://github.com/ceph/ceph/pull/29917), Kefu Chai)
-   mgr: mgr/orch: logging - handle lists output
    ([pr#32879](https://github.com/ceph/ceph/pull/32879), Shyukri
    Shyukriev)
-   mgr: mgr/orchestrator: Add cache for Inventory and Services
    ([pr#28213](https://github.com/ceph/ceph/pull/28213), Tim Serong,
    Sebastian Wagner)
-   mgr: mgr/orchestrator_cli: pass default value to req=False params
    ([pr#31314](https://github.com/ceph/ceph/pull/31314), Kefu Chai)
-   mgr: mgr/osd_support: new module for osd utility
    ([pr#32677](https://github.com/ceph/ceph/pull/32677), Joshua Schmid)
-   mgr: mgr/pg_autoscaler: calculate pool_pg_target using pool size
    ([pr#32592](https://github.com/ceph/ceph/pull/32592), Dan van der
    Ster)
-   mgr: mgr/pg_autoscaler: fix pool_logical_used
    ([pr#29986](https://github.com/ceph/ceph/pull/29986), Ansgar
    Jazdzewski)
-   mgr: mgr/pg_autoscaler: Fix python3 incompatibility
    ([issue#38626](http://tracker.ceph.com/issues/38626),
    [pr#27079](https://github.com/ceph/ceph/pull/27079), Marius
    Schiffer)
-   mgr: mgr/pg_autoscaler: fix race with pool deletion
    ([pr#29807](https://github.com/ceph/ceph/pull/29807), Sage Weil)
-   mgr: mgr/pg_autoscaler: treat target ratios as weights
    ([pr#33035](https://github.com/ceph/ceph/pull/33035), Josh Durgin)
-   mgr: mgr/progress & mgr/pg_autoscaler: Added Pg Autoscaler Event
    ([pr#29035](https://github.com/ceph/ceph/pull/29035), Kamoltat
    (Junior) Sirivadhna)
-   mgr: mgr/progress: Add integration to pybind/mgr/tox.ini
    ([pr#32985](https://github.com/ceph/ceph/pull/32985), Sebastian
    Wagner)
-   mgr: mgr/progress: Add recovery event when OSD marked in
    ([pr#28498](https://github.com/ceph/ceph/pull/28498), Kamoltat
    (Junior) Sirivadhna)
-   mgr: mgr/progress: added the time an event has been in progress
    ([pr#28907](https://github.com/ceph/ceph/pull/28907), Kamoltat
    (Junior) Sirivadhna)
-   mgr: mgr/progress: Bug fix complete event when OSD marked in
    ([pr#28695](https://github.com/ceph/ceph/pull/28695), Kamoltat
    (Junior) Sirivadhna)
-   mgr: mgr/progress: clamp pg recovery ratio to 0
    ([pr#29126](https://github.com/ceph/ceph/pull/29126), xie xingguo)
-   mgr: mgr/progress: estimated remaining time for events
    ([pr#30615](https://github.com/ceph/ceph/pull/30615), xie xingguo)
-   mgr: mgr/progress: Look at PG state when PG epoch \>= OSDMap epoch
    ([pr#28368](https://github.com/ceph/ceph/pull/28368), Kamoltat
    (Junior) Sirivadhna)
-   mgr: mgr/progress: remove since from duration string
    ([pr#31007](https://github.com/ceph/ceph/pull/31007), Kefu Chai)
-   mgr: mgr/prometheus: Add mgr metdata to prometheus exporter module
    ([pr#28372](https://github.com/ceph/ceph/pull/28372), Paul Cuzner)
-   mgr: mgr/prometheus: assign a value to osd_dev_node when obj_store
    is not filestore or bluestore
    ([pr#30534](https://github.com/ceph/ceph/pull/30534), jiahuizeng)
-   mgr: mgr/prometheus: Cast collect_timeout (scrape_interval) to float
    ([pr#29382](https://github.com/ceph/ceph/pull/29382), Ben Meekhof)
-   mgr: mgr/prometheus: Fix KeyError in get_mgr_status
    ([pr#30421](https://github.com/ceph/ceph/pull/30421), Sebastian
    Wagner)
-   mgr: mgr/prometheus: replace whitespaces in metrics names
    ([pr#27722](https://github.com/ceph/ceph/pull/27722), Alfonso
    Martxc3xadnez)
-   mgr: mgr/PyModule: correctly remove config options
    ([pr#31807](https://github.com/ceph/ceph/pull/31807), Tim Serong)
-   mgr: mgr/PyModuleRegistry: log error if we cant find any modules to
    load ([pr#28055](https://github.com/ceph/ceph/pull/28055), Tim
    Serong)
-   mgr: mgr/restful: allow shutdown before weve fully started up
    ([pr#32004](https://github.com/ceph/ceph/pull/32004), Sage Weil)
-   mgr: mgr/restful: do not use filter() for list
    ([pr#27925](https://github.com/ceph/ceph/pull/27925), Kefu Chai)
-   mgr: mgr/restful: jsonify lists instead of maps
    ([pr#32421](https://github.com/ceph/ceph/pull/32421), Kefu Chai)
-   mgr: mgr/restful: requests api adds support multiple commands
    ([pr#31152](https://github.com/ceph/ceph/pull/31152), Duncan Chiang)
-   mgr: mgr/status: fix ceph osd status ZeroDivisionError
    ([pr#28797](https://github.com/ceph/ceph/pull/28797), simon gao)
-   mgr: mgr/telemetry: add last_upload to status
    ([pr#33125](https://github.com/ceph/ceph/pull/33125), Yaarit Hatuka)
-   mgr: mgr/telemetry: change crash dict to a list
    ([pr#27631](https://github.com/ceph/ceph/pull/27631), Dan Mick)
-   mgr: mgr/telemetry: channels
    ([pr#28847](https://github.com/ceph/ceph/pull/28847), Sage Weil)
-   mgr: mgr/telemetry: check get_metadata return val
    ([pr#33051](https://github.com/ceph/ceph/pull/33051), Yaarit Hatuka)
-   mgr: mgr/telemetry: clear the event after being awaken by it
    ([pr#29546](https://github.com/ceph/ceph/pull/29546), Kefu Chai)
-   mgr: mgr/telemetry: exclude hostname field in crash reports
    ([pr#27693](https://github.com/ceph/ceph/pull/27693), Sage Weil)
-   mgr: mgr/telemetry: fix and document proxy usage
    ([pr#33575](https://github.com/ceph/ceph/pull/33575), Lars
    Marowsky-Bree)
-   mgr: mgr/telemetry: fix device serial number anonymization
    ([pr#32492](https://github.com/ceph/ceph/pull/32492), Yaarit Hatuka)
-   mgr: mgr/telemetry: include any config options that are customized
    ([pr#29334](https://github.com/ceph/ceph/pull/29334), Sage Weil)
-   mgr: mgr/telemetry: include device health telemetry
    ([pr#30724](https://github.com/ceph/ceph/pull/30724), Sage Weil)
-   mgr: mgr/telemetry: re-opt-in when telemetry content changes; nag on
    major releases ([pr#29337](https://github.com/ceph/ceph/pull/29337),
    Sage Weil)
-   mgr: mgr/telemetry: salt osd ids too
    ([pr#29358](https://github.com/ceph/ceph/pull/29358), Sage Weil)
-   mgr: mgr/telemetry: specify license when opting in
    ([pr#29340](https://github.com/ceph/ceph/pull/29340), Sage Weil)
-   mgr: mgr/volumes: do not import unused module
    ([pr#28875](https://github.com/ceph/ceph/pull/28875), Kefu Chai)
-   mgr: mgr/zabbix Added pools discovery and per-pool statistics
    ([pr#26152](https://github.com/ceph/ceph/pull/26152), Dmitriy
    Rabotjagov)
-   mgr: mgr/zabbix: Adds possibility to send data to multiple zabbix
    servers ([issue#38409](http://tracker.ceph.com/issues/38409),
    [pr#26547](https://github.com/ceph/ceph/pull/26547), slivik, Jakub
    Sliva)
-   mgr: mgr/zabbix: encode string for Python 3 compatibility
    ([pr#28624](https://github.com/ceph/ceph/pull/28624), Nathan Cutler)
-   mgr: mgr/zabbix: Fix raw_bytes_used key name
    ([pr#28058](https://github.com/ceph/ceph/pull/28058), Dmitriy
    Rabotjagov)
-   mgr: mgr/zabbix: Fix typo in key name for PGs in backfill_wait state
    ([issue#39666](http://tracker.ceph.com/issues/39666),
    [pr#28057](https://github.com/ceph/ceph/pull/28057), Wido den
    Hollander)
-   mgr: missing lock release in DaemonServer::handle_report()
    ([issue#42169](http://tracker.ceph.com/issues/42169),
    [pr#30706](https://github.com/ceph/ceph/pull/30706), Venky Shankar)
-   mgr: module logging infrastructure
    ([pr#30961](https://github.com/ceph/ceph/pull/30961), Ricardo Dias)
-   mgr: more GIL fixes
    ([issue#39040](http://tracker.ceph.com/issues/39040),
    [pr#27280](https://github.com/ceph/ceph/pull/27280), xie xingguo)
-   mgr: pybind/mgr/balancer/module.py: add max/min info in
    stats_by_root ([pr#30432](https://github.com/ceph/ceph/pull/30432),
    Yang Honggang)
-   mgr: pybind/mgr/pg_autoscaler: implement shutdown method
    ([pr#31398](https://github.com/ceph/ceph/pull/31398), Patrick
    Donnelly)
-   mgr: pybind/mgr/restful: use dict.items() for py3 compatible
    ([pr#29356](https://github.com/ceph/ceph/pull/29356), Kefu Chai)
-   mgr: pybind/mgr: Cancel output color control
    ([pr#31427](https://github.com/ceph/ceph/pull/31427), Zheng Yin)
-   mgr: pybind/mgr: convert str to int using int()
    ([pr#27926](https://github.com/ceph/ceph/pull/27926), Kefu Chai)
-   mgr: pybind/mgr: Make it easier to create a Module instance without
    the mgr ([pr#31969](https://github.com/ceph/ceph/pull/31969),
    Sebastian Wagner)
-   mgr: pybind/mgr: Remove code duplication
    ([issue#40698](http://tracker.ceph.com/issues/40698),
    [pr#28986](https://github.com/ceph/ceph/pull/28986), Sebastian
    Wagner)
-   mgr: pyind/mgr: add mgr_module.py and mgr_util.py to mypy
    ([pr#32597](https://github.com/ceph/ceph/pull/32597), Sebastian
    Wagner)
-   mgr: Python cleanup and type check
    ([pr#31559](https://github.com/ceph/ceph/pull/31559), Volker Theile)
-   mgr: qa/mgr/progress: fix timeout error when waiting for osd in
    event ([pr#30095](https://github.com/ceph/ceph/pull/30095), Ricardo
    Dias)
-   mgr: re-enable mds [scrub status]{.title-ref} info in ceph status
    ([issue#42835](http://tracker.ceph.com/issues/42835),
    [pr#32657](https://github.com/ceph/ceph/pull/32657), Venky Shankar)
-   mgr: Reduce logging noise when handling commands
    ([pr#29305](https://github.com/ceph/ceph/pull/29305), Sebastian
    Wagner)
-   mgr: Release GIL before calling OSDMap::calc_pg_upmaps()
    ([pr#31064](https://github.com/ceph/ceph/pull/31064), David Zafman)
-   mgr: remove unused variable pool_name
    ([pr#28340](https://github.com/ceph/ceph/pull/28340), Alex Wu)
-   mgr: restful: Expose perf counters
    ([pr#27885](https://github.com/ceph/ceph/pull/27885), Boris Ranto)
-   mgr: restful: Query nodes_by_id for items
    ([pr#31153](https://github.com/ceph/ceph/pull/31153), Boris Ranto)
-   mgr: return perf_counters data timestamps in nanosecs
    ([pr#28882](https://github.com/ceph/ceph/pull/28882), Ricardo Dias)
-   mgr: Revert mgr/DaemonServer: safe-to-destroy - do not consider
    irrelevant pgs ([pr#32203](https://github.com/ceph/ceph/pull/32203),
    xie xingguo)
-   mgr: set hostname in DeviceState::set_metadata()
    ([pr#30448](https://github.com/ceph/ceph/pull/30448), Kefu Chai)
-   mgr: simply exit on SIGINT or SIGTERM
    ([pr#32051](https://github.com/ceph/ceph/pull/32051), Sage Weil)
-   mgr: telemetry/server: misc fixes
    ([pr#29365](https://github.com/ceph/ceph/pull/29365), user.email,
    Sage Weil)
-   mgr: telemetry: misc scripts
    ([pr#29781](https://github.com/ceph/ceph/pull/29781),
    <sage@newdream.net>, Sage Weil)
-   mgr: templatize metrics collection interface
    ([pr#29214](https://github.com/ceph/ceph/pull/29214), Venky Shankar)
-   mgr: update hostname when we already have the daemon state from the
    same entity ([pr#33752](https://github.com/ceph/ceph/pull/33752),
    Kefu Chai)
-   mgr: use a struct for DaemonKey
    ([pr#30635](https://github.com/ceph/ceph/pull/30635), Kefu Chai)
-   mgr: use ipv4 default when ipv6 was disabled
    ([pr#28246](https://github.com/ceph/ceph/pull/28246), kungf)
-   mgr: use new MMgrCommand for CLI commands sent to mgr
    ([pr#30155](https://github.com/ceph/ceph/pull/30155), Sage Weil)
-   mgr: zabbix triggers never triggered due to wrong trigger function
    ([pr#26146](https://github.com/ceph/ceph/pull/26146), Sebastiaan
    Nijhuis)
-   mgr: \_exit(0) from signal handler even if we are standby
    ([pr#31685](https://github.com/ceph/ceph/pull/31685), Sage Weil)
-   mon,rbd,tests: mon,test: silence warnings from GCC and test
    ([pr#28250](https://github.com/ceph/ceph/pull/28250), Kefu Chai)
-   mon,tests: qa/tasks: Fix ambiguous store_thrash, thrash_store
    ([issue#39159](http://tracker.ceph.com/issues/39159),
    [pr#27542](https://github.com/ceph/ceph/pull/27542), Jos Collin)
-   mon,tools: monmaptool: added \--addv option to usage description
    ([pr#29307](https://github.com/ceph/ceph/pull/29307), Ricardo Dias)
-   mon/MonClient: fix mon tell to older mons
    ([pr#31121](https://github.com/ceph/ceph/pull/31121), Sage Weil)
-   mon/OSDMonitor.cc: Allow pool set target_max\\\_(objects/bytes) with
    SI/IEC units ([pr#31010](https://github.com/ceph/ceph/pull/31010),
    Prashant D)
-   mon/OSDMonitor: osd add-no{up,down,in,out} - remove state checker
    ([pr#27605](https://github.com/ceph/ceph/pull/27605), xie xingguo)
-   mon/pgmap: fix bluestore alerts output
    ([pr#30342](https://github.com/ceph/ceph/pull/30342), Igor Fedotov)
-   mon: add ability to mute health alerts
    ([pr#29422](https://github.com/ceph/ceph/pull/29422), Sage Weil)
-   mon: add mon, osd, mds ok-to-stop and related commands
    ([pr#27146](https://github.com/ceph/ceph/pull/27146), Sage Weil)
-   mon: add [ceph osd info]{.title-ref} to obtain info on osds rather
    than parsing [osd dump]{.title-ref}
    ([pr#26724](https://github.com/ceph/ceph/pull/26724), Joao Eduardo
    Luis)
-   mon: allow running without a config file
    ([pr#30498](https://github.com/ceph/ceph/pull/30498), Joao Eduardo
    Luis)
-   mon: always enable pg_autoscaler
    ([pr#29072](https://github.com/ceph/ceph/pull/29072), Sage Weil)
-   mon: disable min pg per osd warning
    ([pr#30352](https://github.com/ceph/ceph/pull/30352), Sage Weil)
-   mon: Dont put session during feature change
    ([pr#32365](https://github.com/ceph/ceph/pull/32365), Brad Hubbard)
-   mon: dump json from sessions asok/tell command
    ([pr#32974](https://github.com/ceph/ceph/pull/32974), Sage Weil)
-   mon: elector: return after triggering a new election
    ([pr#32981](https://github.com/ceph/ceph/pull/32981), Greg Farnum)
-   mon: ensure prepare_failure() marks no_reply on op
    ([pr#28177](https://github.com/ceph/ceph/pull/28177), Joao Eduardo
    Luis)
-   mon: fix INCOMPAT_OCTOPUS feature number
    ([pr#27622](https://github.com/ceph/ceph/pull/27622), Sage Weil)
-   mon: fix misc asok commands
    ([pr#30859](https://github.com/ceph/ceph/pull/30859), Sage Weil,
    Patrick Donnelly)
-   mon: fix off-by-one rendering progress bar
    ([pr#28268](https://github.com/ceph/ceph/pull/28268), Sage Weil)
-   mon: fix tell command description (and ceph CLI help behavior)
    ([pr#33135](https://github.com/ceph/ceph/pull/33135), Sage Weil)
-   mon: fix tell to hybrid octopus/pre-octopus mons
    ([pr#31138](https://github.com/ceph/ceph/pull/31138), Sage Weil)
-   mon: fix/improve mon sync over small keys
    ([pr#31581](https://github.com/ceph/ceph/pull/31581), Sage Weil)
-   mon: Get session_map_lock before remove_session
    ([pr#33682](https://github.com/ceph/ceph/pull/33682), Xiaofei Cui)
-   mon: Improve health status for backfill_toofull and recovery_toofull
    ([pr#28204](https://github.com/ceph/ceph/pull/28204), David Zafman)
-   mon: Improvements to slow heartbeat health messages
    ([pr#32342](https://github.com/ceph/ceph/pull/32342), David Zafman)
-   mon: make ceph -s much more concise
    ([pr#29493](https://github.com/ceph/ceph/pull/29493), Sage Weil)
-   mon: make compact tell command, and add deprecate/obsolete check for
    tell commands ([pr#31722](https://github.com/ceph/ceph/pull/31722),
    Kefu Chai)
-   mon: make mon_osd_down_out_subtree_limit update at runtime
    ([pr#27517](https://github.com/ceph/ceph/pull/27517), Sage Weil)
-   mon: mon/ConfigMonitor: make config reset idempotent
    ([pr#27155](https://github.com/ceph/ceph/pull/27155), xie xingguo)
-   mon: mon/ConfigMonitor: make num of config reset optional; allow
    target version 0
    ([pr#27090](https://github.com/ceph/ceph/pull/27090), xie xingguo)
-   mon: mon/HealthMonitor: remove unused label
    ([pr#29749](https://github.com/ceph/ceph/pull/29749), Kefu Chai)
-   mon: mon/MonClient: weight-based mon selection
    ([pr#26940](https://github.com/ceph/ceph/pull/26940), xie xingguo)
-   mon: mon/Monitor: no need to create a local variable for capturing
    it ([pr#28744](https://github.com/ceph/ceph/pull/28744), Kefu Chai)
-   mon: mon/MonMap: always set mon priority; add it to dump
    ([pr#26975](https://github.com/ceph/ceph/pull/26975), xie xingguo)
-   mon: mon/OSDMonitor: crush node flags - two fixes; add tests
    ([pr#27719](https://github.com/ceph/ceph/pull/27719), xie xingguo)
-   mon: mon/OSDMonitor: fix off-by-one when updating new_last_in_change
    ([pr#28568](https://github.com/ceph/ceph/pull/28568), xie xingguo)
-   mon: mon/OSDMonitor: report pg[\[pgp\]]()num_target instead of
    pg[\[pgp\]]()num
    ([issue#40193](http://tracker.ceph.com/issues/40193),
    [pr#28490](https://github.com/ceph/ceph/pull/28490), xie xingguo)
-   mon: mon/OSDMonitor: trim not-longer-exist failure reporters
    ([pr#30200](https://github.com/ceph/ceph/pull/30200), NancySu05)
-   mon: mon/OSDMonitor: use initializer_list\<\> for {si,iec}\_options
    ([pr#31175](https://github.com/ceph/ceph/pull/31175), Kefu Chai)
-   mon: mon/PGMap: fix incorrect pg_pool_sum when delete pool
    ([pr#31560](https://github.com/ceph/ceph/pull/31560), luo rixin)
-   mon: optionally bind to public_addrv (instead of public_addr or
    public_network)
    ([pr#31501](https://github.com/ceph/ceph/pull/31501), Sage Weil)
-   mon: paxos: empty pending_finishers before retrying any of
    committingxe2x80xa6
    ([issue#39484](http://tracker.ceph.com/issues/39484),
    [pr#27877](https://github.com/ceph/ceph/pull/27877), Greg Farnum)
-   mon: print FSMap regardless of file system count
    ([pr#32307](https://github.com/ceph/ceph/pull/32307), Patrick
    Donnelly)
-   mon: quiet devname noise
    ([pr#27313](https://github.com/ceph/ceph/pull/27313), Sage Weil)
-   mon: remove the restriction of address type in init_with_hosts
    ([pr#31691](https://github.com/ceph/ceph/pull/31691), Hao Xiong)
-   mon: Revert mon/OSDMonitor: report pg[\[pgp\]]()num_target instead
    of pg[\[pgp\]]()xe2x80xa6
    ([pr#28567](https://github.com/ceph/ceph/pull/28567), xie xingguo)
-   mon: set recovery_priority, pg_num_min, pg_autoscale_bias via fs new
    command ([pr#29180](https://github.com/ceph/ceph/pull/29180), Sage
    Weil)
-   mon: should not take non-tell commands as tell ones
    ([pr#32517](https://github.com/ceph/ceph/pull/32517), Kefu Chai)
-   mon: show no\[deep-\]scrub flags per pool in the status
    ([issue#38029](http://tracker.ceph.com/issues/38029),
    [pr#26488](https://github.com/ceph/ceph/pull/26488), Mohamad Gebai)
-   mon: show pool id in pool ls command
    ([issue#40287](http://tracker.ceph.com/issues/40287),
    [pr#28488](https://github.com/ceph/ceph/pull/28488), Chang Liu)
-   mon: Split Elector into message-passing and logic/state components
    ([pr#28727](https://github.com/ceph/ceph/pull/28727), Greg Farnum)
-   mon: stash newer map on bootstrap when addr doesnt match
    ([pr#33418](https://github.com/ceph/ceph/pull/33418), Sage Weil)
-   mon: take the mon lock in handle_conf_change
    ([issue#39625](http://tracker.ceph.com/issues/39625),
    [pr#28018](https://github.com/ceph/ceph/pull/28018), huangjun)
-   mon: use non-obsolete mon scrub cmd
    ([pr#32510](https://github.com/ceph/ceph/pull/32510), Patrick
    Donnelly)
-   mon:C_AckMarkedDown has not handled the Callback Arguments
    ([pr#29624](https://github.com/ceph/ceph/pull/29624), NancySu05)
-   monitoring: fix prometheus alert for full pools
    ([pr#32325](https://github.com/ceph/ceph/pull/32325), Thomas
    Kriechbaumer)
-   monitoring: fix RGW grafana chart Average GET/PUT Latencies
    ([pr#33839](https://github.com/ceph/ceph/pull/33839), Alfonso
    Martxc3xadnez)
-   monitoring: restore lost fix for [pool full]{.title-ref} alert
    ([pr#33655](https://github.com/ceph/ceph/pull/33655), Patrick
    Seidensal)
-   monitoring: SNMP OID per every Prometheus alert rule
    ([pr#27978](https://github.com/ceph/ceph/pull/27978), Volker Theile)
-   monitoring: wait before firing osd full alert
    ([pr#31711](https://github.com/ceph/ceph/pull/31711), Patrick
    Seidensal)
-   msg/async, v2: make the reset_recv_state() unconditional
    ([issue#40115](http://tracker.ceph.com/issues/40115),
    [pr#28453](https://github.com/ceph/ceph/pull/28453), Sage Weil,
    Radoslaw Zarzynski)
-   msg/async/AsyncConnection: optimize check loopback connection
    ([pr#26923](https://github.com/ceph/ceph/pull/26923), Jianpeng Ma)
-   msg/async/dpdk: destroy fd in do_request
    ([pr#32690](https://github.com/ceph/ceph/pull/32690), Chunsong Feng,
    luo rixin)
-   msg/async/dpdk: Fix build when DPDK enabled
    ([pr#33203](https://github.com/ceph/ceph/pull/33203), Jun Su)
-   msg/async/dpdk: fix compilation errors when WITH_DPDK=on
    ([pr#31840](https://github.com/ceph/ceph/pull/31840), Chunsong Feng)
-   msg/async/dpdk: fix complie errors from fix FTBFS
    ([pr#30086](https://github.com/ceph/ceph/pull/30086), yehu)
-   msg/async/dpdk: fix FTBFS
    ([pr#28763](https://github.com/ceph/ceph/pull/28763), Kefu Chai)
-   msg/async/dpdk: Fix infinite loop when sending packets
    ([pr#32691](https://github.com/ceph/ceph/pull/32691), Chunsong Feng,
    luo rixin)
-   msg/async/dpdk: fix SEGV caused by zero length packet
    ([pr#31876](https://github.com/ceph/ceph/pull/31876), Chunsong Feng)
-   msg/async/dpdk: Fix the overflow while parsing dpdk coremask
    ([pr#32173](https://github.com/ceph/ceph/pull/32173), Hu Ye,
    Chunsong Feng, luo rixin)
-   msg/async/DPDK: refactor set_rss_table to support DPDK 19.05
    ([pr#32170](https://github.com/ceph/ceph/pull/32170), Chunsong Feng,
    luo rixin)
-   msg/async/EventEpoll: set EPOLLET flag on del_event()
    ([pr#26926](https://github.com/ceph/ceph/pull/26926), Roman Penyaev)
-   msg/async/ProtocolV1: avoid unnecessary bufferlist::swap
    ([pr#30125](https://github.com/ceph/ceph/pull/30125), Jianpeng Ma)
-   msg/async/ProtocolV2: make v2 work on rdma
    ([pr#27022](https://github.com/ceph/ceph/pull/27022), Jianpeng Ma)
-   msg/async/ProtocolV2: optimize check state by replace
    ([pr#26812](https://github.com/ceph/ceph/pull/26812), Jianpeng Ma)
-   msg/async/rdma: add an option for choosing different RoCE protocol
    ([pr#31517](https://github.com/ceph/ceph/pull/31517), Changcheng
    Liu)
-   msg/async/rdma: do not init mutex before lockdeps is ready
    ([pr#31532](https://github.com/ceph/ceph/pull/31532), Kefu Chai)
-   msg/async/rdma: fix memory leak
    ([pr#27574](https://github.com/ceph/ceph/pull/27574), Changcheng
    Liu)
-   msg/async/rdma: set/get silence warning
    ([pr#26581](https://github.com/ceph/ceph/pull/26581), Kefu Chai)
-   msg/async/rdma: unblock event center if the peer is down when
    connecting ([pr#31109](https://github.com/ceph/ceph/pull/31109),
    Peng Liu)
-   msg/async: add comments for commit 294c41f18adada6a
    ([pr#28667](https://github.com/ceph/ceph/pull/28667), Jianpeng Ma)
-   msg/async: add timeout for connections which are not ready
    ([issue#38493](http://tracker.ceph.com/issues/38493),
    [issue#37499](http://tracker.ceph.com/issues/37499),
    [pr#27337](https://github.com/ceph/ceph/pull/27337), xie xingguo)
-   msg/async: avoid creating unnecessary AsyncConnectionRef
    ([pr#27323](https://github.com/ceph/ceph/pull/27323), Patrick
    Donnelly)
-   msg/async: Dont dec(msgr_active_connections) if conn still in
    acceptxe2x80xa6
    ([pr#29836](https://github.com/ceph/ceph/pull/29836), Jianpeng Ma)
-   msg/async: Dont miss record l_msgr_running_recv_time if
    pendingReadxe2x80xa6
    ([pr#27734](https://github.com/ceph/ceph/pull/27734), Jianpeng Ma)
-   msg/async: drop zero_copy_read() & co from ConnectedSocket
    ([pr#28921](https://github.com/ceph/ceph/pull/28921), Radoslaw
    Zarzynski)
-   msg/async: fix typo in Errormessage
    ([pr#31825](https://github.com/ceph/ceph/pull/31825), Willem Jan
    Withagen)
-   msg/async: mark down local_connection before draining the stack
    ([pr#32732](https://github.com/ceph/ceph/pull/32732), Radoslaw
    Zarzynski)
-   msg/async: move submit_message() into send_to()
    ([pr#30883](https://github.com/ceph/ceph/pull/30883), Jianpeng Ma)
-   msg/async: narrow scope of AsyncMessenger::lock in fun connect_to
    ([pr#30840](https://github.com/ceph/ceph/pull/30840), Jianpeng Ma)
-   msg/async: No need lock for func \_filter_addrs
    ([pr#31995](https://github.com/ceph/ceph/pull/31995), Jianpeng Ma)
-   msg/async: no-need set connection for Message
    ([pr#27766](https://github.com/ceph/ceph/pull/27766), Jianpeng Ma)
-   msg/async: open() should be called with connection locked
    ([pr#33015](https://github.com/ceph/ceph/pull/33015), Roman Penyaev)
-   msg/async: perform recv reset immediately if called inside EC
    ([pr#33742](https://github.com/ceph/ceph/pull/33742), Radoslaw
    Zarzynski)
-   msg/async: remove unsued code
    ([pr#30833](https://github.com/ceph/ceph/pull/30833), Jianpeng Ma)
-   msg/async: rename outcoming_bl -\> outgoing_bl in AsyncConnection
    ([pr#30709](https://github.com/ceph/ceph/pull/30709), Radoslaw
    Zarzynski)
-   msg/async: reset the V1s session_security in proper EventCenter
    ([pr#32352](https://github.com/ceph/ceph/pull/32352), Radoslaw
    Zarzynski)
-   msg/async: resolve gcc warning
    ([pr#27414](https://github.com/ceph/ceph/pull/27414), Patrick
    Donnelly)
-   msg/async: skip repeat calc crc header in <Message::encode>
    ([pr#26534](https://github.com/ceph/ceph/pull/26534), Jianpeng Ma)
-   msg/async: update refcount and perf counter properly
    ([pr#31929](https://github.com/ceph/ceph/pull/31929), Jianpeng Ma)
-   msg/async: use faster clear method to delete containers
    ([pr#27324](https://github.com/ceph/ceph/pull/27324), Patrick
    Donnelly)
-   msg/Message: Remove used code about XioMessenger
    ([pr#28719](https://github.com/ceph/ceph/pull/28719), Jianpeng Ma)
-   msg: add func is_blackhole to reduce duplicated code
    ([pr#30356](https://github.com/ceph/ceph/pull/30356), Jianpeng Ma)
-   msg: add some anonymous connection infrastructure
    ([pr#30223](https://github.com/ceph/ceph/pull/30223), Sage Weil)
-   msg: default to debug_ms=0
    ([pr#26936](https://github.com/ceph/ceph/pull/26936), Sage Weil)
-   msg: fix addr2 encoding for sockaddrs
    ([issue#40114](http://tracker.ceph.com/issues/40114),
    [pr#28379](https://github.com/ceph/ceph/pull/28379), Jeff Layton)
-   msg: fix comments in Messenger.h after the set -\> std::set switch
    ([pr#30693](https://github.com/ceph/ceph/pull/30693), Radoslaw
    Zarzynski)
-   msg: output peer address when detecting bad CRCs
    ([issue#39367](http://tracker.ceph.com/issues/39367),
    [pr#27658](https://github.com/ceph/ceph/pull/27658), Greg Farnum)
-   msg: remove unused header file in Messenger.h
    ([pr#27086](https://github.com/ceph/ceph/pull/27086), Jianpeng Ma)
-   msg: remove xiomessenger
    ([pr#27021](https://github.com/ceph/ceph/pull/27021), Sage Weil)
-   msg: set_require_authorizer on messenger, not dispatcher
    ([pr#27832](https://github.com/ceph/ceph/pull/27832), Sage Weil)
-   orchestrator: usability fixes
    ([pr#33118](https://github.com/ceph/ceph/pull/33118), Yehuda Sadeh)
-   os/bluestore,comon,erasure-code: chmod -x source files
    ([pr#31179](https://github.com/ceph/ceph/pull/31179), Sage Weil)
-   os/bluestore: default bluestore_block_size 1T -\> 100G
    ([pr#32043](https://github.com/ceph/ceph/pull/32043), Sage Weil)
-   os/kstore: do not cache in-fight stripes on read ops to avoid leaks
    ([issue#39665](http://tracker.ceph.com/issues/39665),
    [pr#32538](https://github.com/ceph/ceph/pull/32538), Chang Liu)
-   os/memstore, crimson/os: introduce
    memstore_debug_omit_block_device_write
    ([pr#28601](https://github.com/ceph/ceph/pull/28601), Radoslaw
    Zarzynski)
-   osd: a few fixes for the removed_snaps changes
    ([pr#28865](https://github.com/ceph/ceph/pull/28865), Sage Weil)
-   osd: accident of rollforward may need to mark pglog dirty
    ([issue#40403](http://tracker.ceph.com/issues/40403),
    [pr#28621](https://github.com/ceph/ceph/pull/28621), Zengran Zhang)
-   osd: add a copy-from2 operation that includes truncate\\\_{seq,size}
    parameters ([pr#31728](https://github.com/ceph/ceph/pull/31728),
    Luis Henriques)
-   osd: add ceph osd stop \<osd.nnn\> command
    ([pr#27595](https://github.com/ceph/ceph/pull/27595), xie xingguo)
-   osd: add cls_cxx_map_remove_range()
    ([issue#19975](http://tracker.ceph.com/issues/19975),
    [pr#15183](https://github.com/ceph/ceph/pull/15183), Casey Bodley)
-   osd: add common smartctl output to JSON output
    ([pr#30408](https://github.com/ceph/ceph/pull/30408), Patrick
    Seidensal)
-   osd: add device_id to list_devices to help get smart info easily
    ([pr#29548](https://github.com/ceph/ceph/pull/29548), Song Shun)
-   osd: add duration field to dump_historic_ops method
    ([pr#28801](https://github.com/ceph/ceph/pull/28801), Deepika
    Upadhyay)
-   osd: add flag to prevent truncate_seq copy in copy-from operation
    ([pr#25374](https://github.com/ceph/ceph/pull/25374), Luis
    Henriques)
-   osd: add hdd and ssd variants for osd_recovery_max_active
    ([pr#28677](https://github.com/ceph/ceph/pull/28677), Sage Weil)
-   osd: add log information to record the cause of do_osd_ops failure
    ([issue#41210](http://tracker.ceph.com/issues/41210),
    [pr#29787](https://github.com/ceph/ceph/pull/29787), NancySu05)
-   osd: add osd_fast_shutdown option (default true)
    ([pr#31677](https://github.com/ceph/ceph/pull/31677), Sage Weil)
-   osd: Again remove deprecated full/nearfull from osdmap
    ([pr#32506](https://github.com/ceph/ceph/pull/32506), David Zafman)
-   osd: Allow 64-char hostname to be added as the host in CRUSH
    ([pr#32947](https://github.com/ceph/ceph/pull/32947), Michal
    Skalski)
-   osd: allow EC PGs to do recovery below min_size
    ([issue#18749](http://tracker.ceph.com/issues/18749),
    [pr#17619](https://github.com/ceph/ceph/pull/17619), Chang Liu, Greg
    Farnum)
-   osd: allow rados write ops to return data and error codes
    ([pr#30581](https://github.com/ceph/ceph/pull/30581), Sage Weil)
-   osd: always initialize local variable
    ([pr#29757](https://github.com/ceph/ceph/pull/29757), Kefu Chai)
-   osd: assert that write ops have result==0 and no payload
    ([pr#30191](https://github.com/ceph/ceph/pull/30191), Sage Weil)
-   osd: automatically repair replicated replica on pulling error
    ([issue#39101](http://tracker.ceph.com/issues/39101),
    [pr#26806](https://github.com/ceph/ceph/pull/26806), xie xingguo,
    David Zafman)
-   osd: avoid prep_object_replica_pushes() on clone object when head
    missing ([issue#39286](http://tracker.ceph.com/issues/39286),
    [pr#27575](https://github.com/ceph/ceph/pull/27575), Zengran Zhang)
-   osd: Better error message when OSD count is less than
    osd_pool_default_size
    ([issue#38617](http://tracker.ceph.com/issues/38617),
    [pr#27806](https://github.com/ceph/ceph/pull/27806), Sage Weil, zjh)
-   osd: Change osd op queue cut off default to high
    ([pr#30441](https://github.com/ceph/ceph/pull/30441), Anthony DAtri)
-   osd: clean up osdmap sharing
    ([pr#27932](https://github.com/ceph/ceph/pull/27932), Sage Weil)
-   osd: clear osd op reply output only when writes success
    ([issue#38492](http://tracker.ceph.com/issues/38492),
    [pr#26652](https://github.com/ceph/ceph/pull/26652), huangjun)
-   osd: clear PG_STATE_CLEAN when repair object
    ([pr#29756](https://github.com/ceph/ceph/pull/29756), Zengran Zhang)
-   osd: copy (dont move) pg list when sending beacon
    ([issue#40377](http://tracker.ceph.com/issues/40377),
    [pr#28566](https://github.com/ceph/ceph/pull/28566), Sage Weil)
-   osd: copy ObjectOperation::BufferUpdate::Write::fadvise_flag to
    ceph::os::Transaction
    ([pr#29944](https://github.com/ceph/ceph/pull/29944), Xuehan Xu)
-   osd: copyfrom omitted to set mtime
    ([pr#28581](https://github.com/ceph/ceph/pull/28581), Zengran Zhang)
-   osd: correct a local variable type
    ([pr#26672](https://github.com/ceph/ceph/pull/26672), Kefu Chai)
-   osd: Diagnostic logging for upmap cleaning
    ([pr#32663](https://github.com/ceph/ceph/pull/32663), David Zafman)
-   osd: dispatch peering messages as messages, inside the PG lock
    ([pr#29820](https://github.com/ceph/ceph/pull/29820), Sage Weil)
-   osd: dispatch_context and queue split finish on early bail-out
    ([pr#32942](https://github.com/ceph/ceph/pull/32942), Sage Weil)
-   osd: do not hold osd_lock while requeuing snaps to purge
    ([pr#28941](https://github.com/ceph/ceph/pull/28941), Sage Weil)
-   osd: do not invalidate clear_regions of missing item at boot
    ([pr#29755](https://github.com/ceph/ceph/pull/29755), xie xingguo)
-   osd: dont carry PGLSFilter between multiple ops in MOSDOp
    ([pr#29575](https://github.com/ceph/ceph/pull/29575), Radoslaw
    Zarzynski)
-   osd: Dont evict after a flush if intersecting scrub range
    ([issue#38840](http://tracker.ceph.com/issues/38840),
    [pr#27209](https://github.com/ceph/ceph/pull/27209), David Zafman)
-   osd: Dont include user changeable flag in snaptrim related assert
    ([issue#38124](http://tracker.ceph.com/issues/38124),
    [pr#27830](https://github.com/ceph/ceph/pull/27830), David Zafman)
-   osd: Dont randomize deep scrubs when noscrub set
    ([issue#40198](http://tracker.ceph.com/issues/40198),
    [pr#28443](https://github.com/ceph/ceph/pull/28443), David Zafman)
-   osd: drop unnecessary includes of messages/MOSDPGTrim.h
    ([pr#33660](https://github.com/ceph/ceph/pull/33660), Radoslaw
    Zarzynski)
-   osd: Fix assert in the case that snapset is missing
    ([pr#29941](https://github.com/ceph/ceph/pull/29941), David Zafman)
-   osd: fix possible crash on sending dynamic perf stats report
    ([pr#30454](https://github.com/ceph/ceph/pull/30454), Mykola Golub)
-   osd: fix racy accesses to OSD::osdmap
    ([pr#33336](https://github.com/ceph/ceph/pull/33336), Radoslaw
    Zarzynski)
-   osd: fix the missing default value m=2 of reed_sol_r6_op in profile
    ([pr#29892](https://github.com/ceph/ceph/pull/29892), Yan Jun)
-   osd: Fix the way that auto repair triggers after regular scru
    ([issue#40073](http://tracker.ceph.com/issues/40073),
    [issue#40530](http://tracker.ceph.com/issues/40530),
    [pr#28334](https://github.com/ceph/ceph/pull/28334), David Zafman)
-   osd: fix wrong arguments when dropping refcount
    ([pr#29348](https://github.com/ceph/ceph/pull/29348), Myoungwon Oh)
-   osd: Give recovery for inactive PGs a higher priority
    ([issue#38195](http://tracker.ceph.com/issues/38195),
    [pr#27503](https://github.com/ceph/ceph/pull/27503), David Zafman)
-   osd: give recovery ops initialized by client op a higher priority
    ([pr#28418](https://github.com/ceph/ceph/pull/28418), xie xingguo)
-   osd: implement per-pg leases to avoid stale reads
    ([pr#29236](https://github.com/ceph/ceph/pull/29236), Sage Weil)
-   osd: Improve dump_pgstate_history json output
    ([issue#38846](http://tracker.ceph.com/issues/38846),
    [pr#27665](https://github.com/ceph/ceph/pull/27665), Brad Hubbard)
-   osd: Include dups in copy_after() and copy_up_to()
    ([issue#39304](http://tracker.ceph.com/issues/39304),
    [pr#27914](https://github.com/ceph/ceph/pull/27914), David Zafman)
-   osd: Increase log level of messages which unnecessarily fill up logs
    ([pr#27686](https://github.com/ceph/ceph/pull/27686), David Zafman)
-   osd: make osd recover more smoothly by avoiding failure peer info to
    resent ([pr#30404](https://github.com/ceph/ceph/pull/30404),
    xe5xaex8bxe9xa1xba10180185)
-   osd: make PastIntervals a member of pg_notify_t
    ([pr#29517](https://github.com/ceph/ceph/pull/29517), Sage Weil)
-   osd: merge replica log on primary need according to replica logs crt
    ([pr#29590](https://github.com/ceph/ceph/pull/29590), Zengran Zhang)
-   osd: misc cleanups
    ([pr#30022](https://github.com/ceph/ceph/pull/30022), Yan Jun)
-   osd: misc inc-recovery compat fixes
    ([pr#29754](https://github.com/ceph/ceph/pull/29754), xie xingguo)
-   osd: optimize send_message to peers
    ([pr#30968](https://github.com/ceph/ceph/pull/30968), Jianpeng Ma)
-   osd: OSDMapRef access by multiple threads is unsafe
    ([pr#26874](https://github.com/ceph/ceph/pull/26874), Kefu Chai,
    Zengran Zhang)
-   osd: Output Base64 encoding of CRC header if binary data present
    ([pr#27961](https://github.com/ceph/ceph/pull/27961), David Zafman)
-   osd: partial recovery strategy based on PGLog
    ([pr#21722](https://github.com/ceph/ceph/pull/21722), lishuhao, Ning
    Yao)
-   osd: peering updates peer_last_complete_ondisk via setter
    ([pr#33659](https://github.com/ceph/ceph/pull/33659), Radoslaw
    Zarzynski)
-   osd: pg as a mutex
    ([pr#29477](https://github.com/ceph/ceph/pull/29477), Kefu Chai)
-   osd: prime splits/merges for any potential fabricated split/merge
    participant ([issue#38483](http://tracker.ceph.com/issues/38483),
    [pr#30018](https://github.com/ceph/ceph/pull/30018), xie xingguo)
-   osd: process_copy_chunk remove obc ref before pg unlock
    ([issue#38842](http://tracker.ceph.com/issues/38842),
    [pr#27084](https://github.com/ceph/ceph/pull/27084), Zengran Zhang)
-   osd: propagate mlcod to replicas and fix problems with read from
    replica ([pr#32381](https://github.com/ceph/ceph/pull/32381), Samuel
    Just, Sage Weil)
-   osd: release backoffs during merge
    ([pr#31657](https://github.com/ceph/ceph/pull/31657), Sage Weil)
-   osd: remove orphan include after PGLSParentFilter
    ([pr#29709](https://github.com/ceph/ceph/pull/29709), Radoslaw
    Zarzynski)
-   osd: remove unused function
    ([pr#30644](https://github.com/ceph/ceph/pull/30644), Jianpeng Ma)
-   osd: remove unused functions
    ([pr#32515](https://github.com/ceph/ceph/pull/32515), Jianpeng Ma)
-   osd: Remove unused osdmap flags full, nearfull from output
    ([pr#30530](https://github.com/ceph/ceph/pull/30530), David Zafman)
-   osd: remove useless ceph_assert
    ([pr#31915](https://github.com/ceph/ceph/pull/31915), Jianpeng Ma)
-   osd: revamp {noup,nodown,noin,noout} related commands
    ([pr#27735](https://github.com/ceph/ceph/pull/27735), xie xingguo)
-   osd: rollforward may need to mark pglog dirty
    ([issue#36739](http://tracker.ceph.com/issues/36739),
    [pr#27015](https://github.com/ceph/ceph/pull/27015), Zengran Zhang)
-   osd: scrub error on big objects; make bluestore refuse to start on
    big objects ([pr#29579](https://github.com/ceph/ceph/pull/29579),
    David Zafman, Sage Weil)
-   osd: send smart asok result to stdout, not stderr
    ([pr#31412](https://github.com/ceph/ceph/pull/31412), Sage Weil)
-   osd: set affinity for \\\*all\\\* threads
    ([pr#30712](https://github.com/ceph/ceph/pull/30712), Sage Weil)
-   osd: set collection pool opts on collection create, pg load
    ([pr#29093](https://github.com/ceph/ceph/pull/29093), Sage Weil)
-   osd: share curmap in handle_osd_ping
    ([pr#28662](https://github.com/ceph/ceph/pull/28662), Sage Weil)
-   osd: shutdown recovery_request_timer earlier
    ([pr#27206](https://github.com/ceph/ceph/pull/27206), Zengran Zhang)
-   osd: some prelim changes
    ([pr#29052](https://github.com/ceph/ceph/pull/29052), Sage Weil)
-   osd: support osd_repair_during_recovery
    ([issue#40620](http://tracker.ceph.com/issues/40620),
    [pr#28839](https://github.com/ceph/ceph/pull/28839), Jeegn Chen)
-   osd: support osd_scrub_extended_sleep
    ([issue#40955](http://tracker.ceph.com/issues/40955),
    [pr#29342](https://github.com/ceph/ceph/pull/29342), Jeegn Chen)
-   osd: take heartbeat_lock when calling heartbeat()
    ([issue#39439](http://tracker.ceph.com/issues/39439),
    [pr#27729](https://github.com/ceph/ceph/pull/27729), Sage Weil)
-   osd: tiny clean-ups around the backfill
    ([pr#33583](https://github.com/ceph/ceph/pull/33583), Radoslaw
    Zarzynski)
-   osd: track monotonic clock deltas between osds who ping each other
    ([pr#29116](https://github.com/ceph/ceph/pull/29116), Sage Weil,
    Samuel Just)
-   osd: transpose two wait lists in comment
    ([pr#27017](https://github.com/ceph/ceph/pull/27017), Kefu Chai)
-   osd: trim pg logs based on a per-osd budget
    ([pr#32683](https://github.com/ceph/ceph/pull/32683), Sage Weil,
    Kefu Chai)
-   osd: Turn off repair pg state when leaving recovery
    ([pr#30852](https://github.com/ceph/ceph/pull/30852), David Zafman)
-   osd: unify sources of no{up,down,in,out} flags into singleton
    helpers ([pr#28403](https://github.com/ceph/ceph/pull/28403), xie
    xingguo)
-   osd: update comment as sub_op_scrub_map has been removed
    ([pr#28338](https://github.com/ceph/ceph/pull/28338), Jing Wenjun)
-   osd: Use physical ratio for nearfull (doesnt include backfill
    resserve) ([pr#31954](https://github.com/ceph/ceph/pull/31954),
    David Zafman)
-   osd: use steady clock in prepare_to_stop()
    ([pr#26457](https://github.com/ceph/ceph/pull/26457), Mohamad Gebai)
-   osd: use unique_ptr for managing life cycles
    ([pr#32007](https://github.com/ceph/ceph/pull/32007), Kefu Chai)
-   osdc/Striper: specialize std::min\<\>
    ([pr#28732](https://github.com/ceph/ceph/pull/28732), Kefu Chai)
-   osd_types: add ec profile to plain text osd pool ls detail output
    ([issue#40009](http://tracker.ceph.com/issues/40009),
    [pr#28224](https://github.com/ceph/ceph/pull/28224), Jan Fajerski)
-   pybind,rbd: Add RBD_FEATURE_MIGRATING to rbd.pyx
    ([issue#39609](http://tracker.ceph.com/issues/39609),
    [pr#28009](https://github.com/ceph/ceph/pull/28009), Ricardo
    Marques)
-   pybind,rbd: pybind/rbd: add config_set/get/remove api in rbd.pyx
    ([pr#29459](https://github.com/ceph/ceph/pull/29459), Zheng Yin)
-   pybind,rbd: pybind/rbd: add pool config_set/get/remove api in
    rbd.pyx ([pr#30865](https://github.com/ceph/ceph/pull/30865), Zheng
    Yin)
-   pybind,rbd: pybind/rbd: parent_info should return pool namespace
    ([pr#30793](https://github.com/ceph/ceph/pull/30793), Ricardo
    Marques)
-   pybind,rbd: rbd/pybind: fix unsupported format character of %lx
    ([pr#30314](https://github.com/ceph/ceph/pull/30314), songweibin)
-   pybind,tests: pybind/rados: do not slice zip()
    ([pr#31044](https://github.com/ceph/ceph/pull/31044), Kefu Chai)
-   pybind,tests: test/pybind/test_rados.py: test
    test_operate_aio_write_op()
    ([pr#31158](https://github.com/ceph/ceph/pull/31158), Zhang Jiao)
-   pybind/mgr: Add test_orchestrator to mypy
    ([pr#32500](https://github.com/ceph/ceph/pull/32500), Sebastian
    Wagner)
-   pybind/mgr: add_tox_test: Add mypy to TOX_ENVS
    ([pr#32236](https://github.com/ceph/ceph/pull/32236), Sebastian
    Wagner)
-   pybind/mgr: bump six to 1.14
    ([pr#33185](https://github.com/ceph/ceph/pull/33185), Kefu Chai)
-   pybind/tox: pass additional command line arguments through to tox
    ([pr#27947](https://github.com/ceph/ceph/pull/27947), Nathan Cutler)
-   pybind: .gitignore: Add .mypy_cache to .gitignore
    ([pr#33510](https://github.com/ceph/ceph/pull/33510), Kristoffer
    Grxc3xb6nlund)
-   pybind: add verbose error message
    ([pr#28054](https://github.com/ceph/ceph/pull/28054), Daniel Badea,
    Changcheng Liu, Ovidiu Poncea)
-   pybind: add WriteOp::set_xattr() & rm_xattr()
    ([pr#31829](https://github.com/ceph/ceph/pull/31829), Zhang Jiao)
-   pybind: add writesame API
    ([pr#31489](https://github.com/ceph/ceph/pull/31489), Zhang Jiao)
-   pybind: check CEPH_LIBDIR not MAKEFLAGS
    ([pr#29080](https://github.com/ceph/ceph/pull/29080), Kefu Chai)
-   pybind: customize compiler before checking cflags
    ([pr#33177](https://github.com/ceph/ceph/pull/33177), Kefu Chai)
-   pybind: fix use of WriteOpCtx and ReadOpCtx
    ([issue#38946](http://tracker.ceph.com/issues/38946),
    [pr#27213](https://github.com/ceph/ceph/pull/27213), Ramana Raja)
-   pybind: pybind/rados/rados.pyx: improve Rados.create_pool()
    ([pr#31241](https://github.com/ceph/ceph/pull/31241), Zhang Jiao)
-   pybind: pybind/rados: add application_metadata_get
    ([pr#30504](https://github.com/ceph/ceph/pull/30504), songweibin)
-   pybind: pybind/rados: add Ioctx.get_pool_id() and
    Ioctx.get_pool_name()
    ([pr#29646](https://github.com/ceph/ceph/pull/29646), Zheng Yin)
-   pybind: pybind/rados: add WriteOp::execute()
    ([pr#31546](https://github.com/ceph/ceph/pull/31546), Zhang Jiao)
-   pybind: pybind/rados: should pass name to cstr()
    ([pr#27111](https://github.com/ceph/ceph/pull/27111), Kefu Chai)
-   pybind: refactor monkey_with_compiler()
    ([pr#33061](https://github.com/ceph/ceph/pull/33061), Kefu Chai)
-   pybind: set language_level for cythonize explicitly
    ([pr#26607](https://github.com/ceph/ceph/pull/26607), Kefu Chai)
-   python-common, mgr/orchestrator, mgr/dashboard: Use common Devices
    ([pr#30662](https://github.com/ceph/ceph/pull/30662), Kiefer Chang,
    Sebastian Wagner)
-   python-common: add unmanaged property to PlacementSpec
    ([pr#33955](https://github.com/ceph/ceph/pull/33955), Sage Weil)
-   python-common: all:true -\> \\\*
    ([pr#33970](https://github.com/ceph/ceph/pull/33970), Sage Weil)
-   python-common: move pytest integration from setup.py to tox.ini
    ([pr#31943](https://github.com/ceph/ceph/pull/31943), Sebastian
    Wagner)
-   python-common: remove [all_hosts]{.title-ref} from
    [PlacementSpec]{.title-ref}
    ([pr#33948](https://github.com/ceph/ceph/pull/33948), Sebastian
    Wagner)
-   qa/distros: rhel and centos: whitelist cephadm logrotate selinux
    denial ([pr#33110](https://github.com/ceph/ceph/pull/33110), Sage
    Weil)
-   qa/standalone/test_ceph_daemon.sh: disable adoption for the moment
    ([pr#32178](https://github.com/ceph/ceph/pull/32178), Sage Weil)
-   qa/standalone/test_ceph_daemon.sh: fix overwrites of temp files
    ([pr#31748](https://github.com/ceph/ceph/pull/31748), Sage Weil)
-   qa/standalone/test_ceph_daemon: fix multi-version python test
    ([pr#31342](https://github.com/ceph/ceph/pull/31342), Sage Weil)
-   qa/suites/cephadm: move orchestrator_cli test into rados/cephadm
    ([pr#33648](https://github.com/ceph/ceph/pull/33648), Sage Weil)
-   qa/suites/rados/ceph: drop opensuse for now
    ([pr#33801](https://github.com/ceph/ceph/pull/33801), Sage Weil)
-   qa/suites/rados/cephadm/smoke: disable rgw role for now
    ([pr#33360](https://github.com/ceph/ceph/pull/33360), Sage Weil)
-   qa/suites/rados/cephadm/upgrade: change start version
    ([pr#33475](https://github.com/ceph/ceph/pull/33475), Sage Weil)
-   qa/suites/rados/cephadm/upgrade: fix initial version
    ([pr#33396](https://github.com/ceph/ceph/pull/33396), Sage Weil)
-   qa/suites/rados/cephadm: explicitly test many distros
    ([pr#32969](https://github.com/ceph/ceph/pull/32969), Sage Weil)
-   qa/suites/rados/cephadm: fix conflicts, missing .qa link
    ([pr#33132](https://github.com/ceph/ceph/pull/33132), Sage Weil)
-   qa/suites/rados/cephadm\[-smoke\]: test podman on ubuntu 18.04
    ([pr#33111](https://github.com/ceph/ceph/pull/33111), Sage Weil)
-   qa/tasks/cephadm: ceph.git branches are now pushed to quay.io
    ([pr#32375](https://github.com/ceph/ceph/pull/32375), Sage Weil)
-   qa/tasks/cephadm: deploy rgw daemons too
    ([pr#33289](https://github.com/ceph/ceph/pull/33289), Sage Weil)
-   qa/tasks/cephadm: learn to pull cephadm from githu
    ([pr#32787](https://github.com/ceph/ceph/pull/32787), Sage Weil)
-   qa/tasks/cephadm: misc fixes
    ([pr#32713](https://github.com/ceph/ceph/pull/32713), Sage Weil)
-   qa/tasks/ceph_manager.py: always use self.logger
    ([pr#29239](https://github.com/ceph/ceph/pull/29239), Kefu Chai)
-   qa/tasks/ceph_manager: 5s -\> 15s for osd out to be visible
    ([pr#29013](https://github.com/ceph/ceph/pull/29013), Sage Weil)
-   qa/tasks/ceph_manager: fix movement of cot exports with cephadm
    ([pr#32986](https://github.com/ceph/ceph/pull/32986), Sage Weil)
-   qa/tasks/ceph_manager: fix shell osd for ceph-objectstore-tool
    commands ([pr#32725](https://github.com/ceph/ceph/pull/32725), Sage
    Weil)
-   qa/tasks/ceph_manager: make fix_pgp_num behave when no pool is found
    ([pr#32987](https://github.com/ceph/ceph/pull/32987), Sage Weil)
-   qa/tasks/mgr/dashboard/test_health: update schema
    ([pr#30507](https://github.com/ceph/ceph/pull/30507), Kefu Chai)
-   qa/tasks/mgr/dashboard/test_orchestrator: support addr attribute in
    inventory ([pr#33211](https://github.com/ceph/ceph/pull/33211),
    Kiefer Chang)
-   qa/tasks/mgr/test_orchestrator_cli: fix device ls test
    ([pr#32384](https://github.com/ceph/ceph/pull/32384), Sage Weil)
-   qa/tasks/mgr/test_orchestrator_cli: fix rgw add test
    ([pr#32101](https://github.com/ceph/ceph/pull/32101), Sage Weil)
-   qa/tasks/mgr/test_orchestrator_cli: support multiple DriveGroups
    ([pr#33055](https://github.com/ceph/ceph/pull/33055), Kiefer Chang)
-   qa/test: reduce over all number of runs
    ([pr#27979](https://github.com/ceph/ceph/pull/27979), Yuri
    Weinstein)
-   qa/tests - cleaned up distro settings
    ([pr#27956](https://github.com/ceph/ceph/pull/27956), Yuri
    Weinstein)
-   qa/tests - upped priority for upgrades on master, otherwise they
    nevexe2x80xa6 ([pr#29666](https://github.com/ceph/ceph/pull/29666),
    Yuri Weinstein)
-   qa/tests: added nautilus-x-singleton suite to rados as symlink
    ([pr#27291](https://github.com/ceph/ceph/pull/27291), Sage Weil)
-   qa/tests: added rados on master, reduced fs, rbd, multimds
    ([pr#27535](https://github.com/ceph/ceph/pull/27535), Yuri
    Weinstein)
-   qa/tests: added the subset clause for nautilus branch
    ([pr#27129](https://github.com/ceph/ceph/pull/27129), Yuri
    Weinstein)
-   qa/tests: changed the TO email to <ceph-qa@ceph.io>
    ([pr#28721](https://github.com/ceph/ceph/pull/28721), Yuri
    Weinstein)
-   qa/tests: moved some runs from ovh, removed ceph-disk/nautilus
    ([pr#27616](https://github.com/ceph/ceph/pull/27616), Yuri
    Weinstein)
-   qa/tests: reduced runs for nautilus, added runs for octopus
    ([pr#33214](https://github.com/ceph/ceph/pull/33214), Yuri
    Weinstein)
-   qa/tests: removed all runs on ovh
    ([pr#27960](https://github.com/ceph/ceph/pull/27960), Yuri
    Weinstein)
-   qa/tests: removed filters for client-upgrade-\\\* suites
    ([pr#28271](https://github.com/ceph/ceph/pull/28271), Yuri
    Weinstein)
-   qa/tests: run luminous-x and mimic-x 2 times a week but with high
    priority ([pr#27527](https://github.com/ceph/ceph/pull/27527), Yuri
    Weinstein)
-   qa/tests: trying to fix syntax error that prevented mimic-x to be
    addxe2x80xa6 ([pr#31799](https://github.com/ceph/ceph/pull/31799),
    Yuri Weinstein)
-   qa/valgrind.supp: abstract from ceph::buffers symbol versioning
    ([pr#33757](https://github.com/ceph/ceph/pull/33757), Radoslaw
    Zarzynski)
-   qa/workunits/cephadm/test_adoption: run as root
    ([pr#33485](https://github.com/ceph/ceph/pull/33485), Sage Weil)
-   qa/workunits/cephadm/test_cephadm.sh: consolidate wait loop logic
    ([pr#33544](https://github.com/ceph/ceph/pull/33544), Michael
    Fritch)
-   qa/workunits/cephadm/test_cephadm.sh: dump logs on exit
    ([pr#33634](https://github.com/ceph/ceph/pull/33634), Michael
    Fritch)
-   qa/workunits/cephadm/test_cephadm.sh: need \--fsid always
    ([pr#32220](https://github.com/ceph/ceph/pull/32220), Sage Weil)
-   qa/workunits/cephadm/test_cephadm.sh: re-enable [adopt]{.title-ref}
    tests ([pr#32244](https://github.com/ceph/ceph/pull/32244), Michael
    Fritch)
-   qa/workunits/cephadm/test_cephadm.sh: skip docker when service is
    disabled ([pr#33018](https://github.com/ceph/ceph/pull/33018),
    Michael Fritch)
-   qa/workunits/cephadm/test_cephadm.sh: use avialable pythons; test on
    ubuntu and centos
    ([pr#32333](https://github.com/ceph/ceph/pull/32333), Sage Weil)
-   qa/workunits/cephadm/test_cephadm: \--skip-monitoring-stack
    ([pr#34013](https://github.com/ceph/ceph/pull/34013), Sage Weil)
-   qa/workunits/cephadm/test_cephadm: fix typo
    ([pr#33181](https://github.com/ceph/ceph/pull/33181), Sage Weil)
-   qa/workunits/cephadm/test_cephadm: workunit test cleanup
    ([pr#32625](https://github.com/ceph/ceph/pull/32625), Michael
    Fritch)
-   qa/workunits/cephadm/test_repos: dont try to use the refspec
    ([pr#33134](https://github.com/ceph/ceph/pull/33134), Sage Weil)
-   qa/workunits/cephadm: separate out test_adoption.sh; fix
    ([pr#33457](https://github.com/ceph/ceph/pull/33457), Sage Weil)
-   qa: fixes ([pr#29361](https://github.com/ceph/ceph/pull/29361), Kefu
    Chai)
-   qa: misc fixes for rados and py3
    ([pr#32362](https://github.com/ceph/ceph/pull/32362), Sage Weil)
-   qa: pin rgw/verify to 8.0
    ([pr#32761](https://github.com/ceph/ceph/pull/32761), Ali Maredia)
-   qa: Run flake8 on python2 and python3
    ([pr#32222](https://github.com/ceph/ceph/pull/32222), Thomas
    Bechtold)
-   qa: vstart_runner fails because of string index out of range
    ([pr#28990](https://github.com/ceph/ceph/pull/28990), Volker Theile)
-   rbd,tests: cls/rbd: add snapshot limit UINT64_MAX test case
    ([pr#31350](https://github.com/ceph/ceph/pull/31350), Chen Pan)
-   rbd,tests: cls/rbd: add snapshot_add raise -ESTALE test case
    ([pr#31149](https://github.com/ceph/ceph/pull/31149), wonderpow)
-   rbd,tests: journal: always shutdown JournalRecoreder before
    destructing it ([pr#29501](https://github.com/ceph/ceph/pull/29501),
    Kefu Chai)
-   rbd,tests: journal: fix flush by age and in-flight byte tracking
    ([pr#31392](https://github.com/ceph/ceph/pull/31392), Jason
    Dillaman)
-   rbd,tests: mgr/dashboard: s/fsid/mirror_uuid/
    ([pr#33348](https://github.com/ceph/ceph/pull/33348), Kefu Chai)
-   rbd,tests: qa/rbd: add cram-based snap diff test
    ([issue#39447](http://tracker.ceph.com/issues/39447),
    [pr#28346](https://github.com/ceph/ceph/pull/28346), Shyukri
    Shyukriev, Nathan Cutler)
-   rbd,tests: qa/suites/krbd: run unmap subsuite with msgr1 only
    ([pr#31265](https://github.com/ceph/ceph/pull/31265), Ilya Dryomov)
-   rbd,tests: qa/suites/rbd: add random distro selection to librbd
    tests ([pr#27577](https://github.com/ceph/ceph/pull/27577), Jason
    Dillaman)
-   rbd,tests: qa/suites/rbd: added writearound cache test permutations
    ([issue#39386](http://tracker.ceph.com/issues/39386),
    [pr#27694](https://github.com/ceph/ceph/pull/27694), Jason Dillaman)
-   rbd,tests: qa/suites/rbd: fix errant tab in yaml which is causing
    parsing failures
    ([pr#30942](https://github.com/ceph/ceph/pull/30942), Jason
    Dillaman)
-   rbd,tests: qa/suites/rbd: fixed download path for Ubuntu Bionic
    ([pr#32408](https://github.com/ceph/ceph/pull/32408), Jason
    Dillaman)
-   rbd,tests: qa/suites/rbd: removed OpenStack tempest test cases
    ([pr#33900](https://github.com/ceph/ceph/pull/33900), Jason
    Dillaman)
-   rbd,tests: qa/tests: added rbd task on ec
    ([pr#29541](https://github.com/ceph/ceph/pull/29541), Yuri
    Weinstein)
-   rbd,tests: qa/workunit/rbd: fixed QoS throughput unit parsing
    ([pr#32280](https://github.com/ceph/ceph/pull/32280), Jason
    Dillaman)
-   rbd,tests: qa/workunits/rbd: fix compare_images and
    compare_image_snapshots
    ([pr#28524](https://github.com/ceph/ceph/pull/28524), Mykola Golub)
-   rbd,tests: qa/workunits/rbd: fixed python interpreter for EL8
    ([pr#32409](https://github.com/ceph/ceph/pull/32409), Jason
    Dillaman)
-   rbd,tests: qa/workunits/rbd: fixups for the new krbd discard
    behavior ([pr#27192](https://github.com/ceph/ceph/pull/27192), Ilya
    Dryomov)
-   rbd,tests: qa/workunits/rbd: override CEPH_ARGS when initializing
    the site name ([pr#33187](https://github.com/ceph/ceph/pull/33187),
    Jason Dillaman)
-   rbd,tests: qa/workunits/rbd: remove fast-diff from dynamic features
    test ([issue#39946](http://tracker.ceph.com/issues/39946),
    [pr#28135](https://github.com/ceph/ceph/pull/28135), Jason Dillaman)
-   rbd,tests: qa/workunits/rbd: stress test [rbd mirror pool status
    \--verbose]{.title-ref}
    ([pr#29655](https://github.com/ceph/ceph/pull/29655), Mykola Golub)
-   rbd,tests: qa/workunits/rbd: use context managers to control Rados
    lifespan ([pr#34035](https://github.com/ceph/ceph/pull/34035), Jason
    Dillaman)
-   rbd,tests: qa/workunits/rbd: use https protocol for devstack git
    operations ([issue#39656](http://tracker.ceph.com/issues/39656),
    [pr#28063](https://github.com/ceph/ceph/pull/28063), Jason Dillaman)
-   rbd,tests: qa/workunits/rbd: use more recent qemu-iotests that
    support Bionic ([issue#24668](http://tracker.ceph.com/issues/24668),
    [pr#27683](https://github.com/ceph/ceph/pull/27683), Jason Dillaman)
-   rbd,tests: qa/workunits/rbd: wait for nbd map to close after unmap
    ([pr#33898](https://github.com/ceph/ceph/pull/33898), Jason
    Dillaman)
-   rbd,tests: qa/workunits/rbd: wait for rbd-nbd unmap to complete
    ([issue#39598](http://tracker.ceph.com/issues/39598),
    [pr#27981](https://github.com/ceph/ceph/pull/27981), Jason Dillaman)
-   rbd,tests: qa: add device mapper and lvm test cases for stable pages
    ([pr#27271](https://github.com/ceph/ceph/pull/27271), Ilya Dryomov)
-   rbd,tests: qa: add krbd_discard_granularity.t test
    ([pr#27042](https://github.com/ceph/ceph/pull/27042), Ilya Dryomov)
-   rbd,tests: qa: add RBD QOS functional test
    ([pr#27137](https://github.com/ceph/ceph/pull/27137), Mykola Golub)
-   rbd,tests: qa: add script to test how libceph handles huge osdmaps
    ([pr#30363](https://github.com/ceph/ceph/pull/30363), Ilya Dryomov)
-   rbd,tests: qa: avoid hexdump skip and length options
    ([pr#30502](https://github.com/ceph/ceph/pull/30502), Ilya Dryomov)
-   rbd,tests: qa: avoid page cache for krbd discard round off tests
    ([pr#30452](https://github.com/ceph/ceph/pull/30452), Ilya Dryomov)
-   rbd,tests: qa: krbd_parent_overlap.t: fix read test
    ([pr#29966](https://github.com/ceph/ceph/pull/29966), Ilya Dryomov)
-   rbd,tests: test/cli-integration/rbd: fixed missing image and snap
    ids ([pr#29853](https://github.com/ceph/ceph/pull/29853), Jason
    Dillaman)
-   rbd,tests: test/cli-integration: fixed spacing issue for RBD
    formatted tables
    ([pr#33902](https://github.com/ceph/ceph/pull/33902), Jason
    Dillaman)
-   rbd,tests: test/cls_rbd/test_cls_rbd: update TestClsRbd.sparsify
    ([pr#30258](https://github.com/ceph/ceph/pull/30258), Kefu Chai)
-   rbd,tests: test/cls_rbd: include compat.h for ERESTART
    ([pr#32172](https://github.com/ceph/ceph/pull/32172), Willem Jan
    Withagen)
-   rbd,tests: test/journal: always close object
    ([pr#29476](https://github.com/ceph/ceph/pull/29476), Kefu Chai)
-   rbd,tests: test/librados_test_stub: ensure the log flusher thread is
    started ([pr#27326](https://github.com/ceph/ceph/pull/27326), Jason
    Dillaman)
-   rbd,tests: test/librbd: allow parallel runs of run-rbd-unit-tests
    ([pr#30072](https://github.com/ceph/ceph/pull/30072), Willem Jan
    Withagen)
-   rbd,tests: test/librbd: drop ceph_test_librbd_api target
    ([issue#39072](http://tracker.ceph.com/issues/39072),
    [pr#27695](https://github.com/ceph/ceph/pull/27695), Jason Dillaman)
-   rbd,tests: test/librbd: fix mock warnings in TestMockIoImageRequest
    ([pr#31497](https://github.com/ceph/ceph/pull/31497), Mykola Golub)
-   rbd,tests: test/librbd: set nbd timeout due to newer kernels
    defaulting it on
    ([pr#29858](https://github.com/ceph/ceph/pull/29858), Jason
    Dillaman)
-   rbd,tests: test/pybind/rbd.pyx: add test_remove_snap_by_id case in
    test_rbd.py ([pr#30927](https://github.com/ceph/ceph/pull/30927),
    Zhang Jiao)
-   rbd,tests: test/pybind: add create_snap rasie ImageExists test case
    ([pr#31140](https://github.com/ceph/ceph/pull/31140), Gangbiao Liu)
-   rbd,tests: test/pybind: inconsistent use of tabs and spaces in
    indentation ([pr#31606](https://github.com/ceph/ceph/pull/31606),
    Mykola Golub)
-   rbd,tests: test/rbd_mirror: fix mock warnings
    ([pr#31608](https://github.com/ceph/ceph/pull/31608), Mykola Golub)
-   rbd,tests: test/run-rbd-tests: properly initialize newly created rbd
    pool ([pr#33642](https://github.com/ceph/ceph/pull/33642), Mykola
    Golub)
-   rbd,tests: test: add test_remove_snap_ImageNotFound test case in
    remove snap part
    ([pr#31221](https://github.com/ceph/ceph/pull/31221), Yingze Wei)
-   rbd,tests: test:add test_remove_snap2 interface to remove snap when
    its protected ([pr#31208](https://github.com/ceph/ceph/pull/31208),
    Yingze Wei)
-   rbd,tools: tools/rbd-ggate: close log before running postfork
    ([pr#30010](https://github.com/ceph/ceph/pull/30010), Willem Jan
    Withagen)
-   rbd,tools: tools/rbd_nbd: use POSIX basename()
    ([pr#28856](https://github.com/ceph/ceph/pull/28856), Kefu Chai)
-   rbd-ggate: fix fallout from bufferlist.copy() change
    ([pr#33057](https://github.com/ceph/ceph/pull/33057), Willem Jan
    Withagen)
-   rbd-mirror: add namespace support
    ([issue#37529](http://tracker.ceph.com/issues/37529),
    [pr#28939](https://github.com/ceph/ceph/pull/28939), Mykola Golub)
-   rbd-mirror: add namespace support to service daemon
    ([pr#31642](https://github.com/ceph/ceph/pull/31642), Mykola Golub)
-   rbd-mirror: add support for snapshot-based mirroring resyncs
    ([pr#33490](https://github.com/ceph/ceph/pull/33490), Jason
    Dillaman)
-   rbd-mirror: apply image state during snapshot replay
    ([pr#33335](https://github.com/ceph/ceph/pull/33335), Jason
    Dillaman)
-   rbd-mirror: cannot restore deferred deletion mirrored images
    ([pr#30351](https://github.com/ceph/ceph/pull/30351), Jason
    Dillaman)
-   rbd-mirror: clear out bufferlist prior to listing mirror images
    ([issue#39407](http://tracker.ceph.com/issues/39407),
    [pr#27720](https://github.com/ceph/ceph/pull/27720), Jason Dillaman)
-   rbd-mirror: continue to isolate journal replay logic
    ([pr#32399](https://github.com/ceph/ceph/pull/32399), Jason
    Dillaman)
-   rbd-mirror: do not auto-create peers in non-default namespaces
    ([pr#32341](https://github.com/ceph/ceph/pull/32341), Jason
    Dillaman)
-   rbd-mirror: dont expect image map is always initialized
    ([pr#33368](https://github.com/ceph/ceph/pull/33368), Mykola Golub)
-   rbd-mirror: dont overwrite status error returned by replay
    ([pr#28179](https://github.com/ceph/ceph/pull/28179), Mykola Golub)
-   rbd-mirror: ensure deterministic ordering of method calls
    ([pr#32274](https://github.com/ceph/ceph/pull/32274), Jason
    Dillaman)
-   rbd-mirror: extract journal replaying logic from image replayer
    ([pr#32257](https://github.com/ceph/ceph/pull/32257), Jason
    Dillaman)
-   rbd-mirror: fix pool replayer status for case when init failed
    ([pr#32483](https://github.com/ceph/ceph/pull/32483), Mykola Golub)
-   rbd-mirror: fix race on namespace replayer initialization failure
    ([pr#32243](https://github.com/ceph/ceph/pull/32243), Mykola Golub)
-   rbd-mirror: handle duplicates in image sync throttler queue
    ([issue#40519](http://tracker.ceph.com/issues/40519),
    [pr#28730](https://github.com/ceph/ceph/pull/28730), Mykola Golub)
-   rbd-mirror: hold lock while updating local image name
    ([pr#33988](https://github.com/ceph/ceph/pull/33988), Jason
    Dillaman)
-   rbd-mirror: ignore errors relating to parsing the cluster config
    file ([pr#29808](https://github.com/ceph/ceph/pull/29808), Jason
    Dillaman)
-   rbd-mirror: image status should report remote status
    ([pr#30558](https://github.com/ceph/ceph/pull/30558), Jason
    Dillaman)
-   rbd-mirror: improve detection of blacklisted state
    ([pr#33411](https://github.com/ceph/ceph/pull/33411), Mykola Golub)
-   rbd-mirror: initial end-to-end test and associated bug fixes
    ([pr#33588](https://github.com/ceph/ceph/pull/33588), Jason
    Dillaman)
-   rbd-mirror: initial snapshot replay state machine
    ([pr#33166](https://github.com/ceph/ceph/pull/33166), Jason
    Dillaman)
-   rbd-mirror: initial snapshot-based mirroring bootstrap logic
    ([pr#33002](https://github.com/ceph/ceph/pull/33002), Jason
    Dillaman)
-   rbd-mirror: link against the specified alloc library
    ([issue#40110](http://tracker.ceph.com/issues/40110),
    [pr#28434](https://github.com/ceph/ceph/pull/28434), Jason Dillaman)
-   rbd-mirror: make logrotate work
    ([pr#32456](https://github.com/ceph/ceph/pull/32456), Mykola Golub)
-   rbd-mirror: mirrored clone should be same format
    ([pr#31161](https://github.com/ceph/ceph/pull/31161), Mykola Golub)
-   rbd-mirror: peer_ping should send the local fsid to the remote
    ([pr#31950](https://github.com/ceph/ceph/pull/31950), Jason
    Dillaman)
-   rbd-mirror: periodically flush IO and commit positions
    ([issue#39257](http://tracker.ceph.com/issues/39257),
    [pr#27533](https://github.com/ceph/ceph/pull/27533), Jason Dillaman)
-   rbd-mirror: periodically poll remote mirror configuration
    ([pr#32671](https://github.com/ceph/ceph/pull/32671), Jason
    Dillaman)
-   rbd-mirror: potential nullptr dereference in
    ImageReplayer::handle_start_replay
    ([pr#30484](https://github.com/ceph/ceph/pull/30484), Mykola Golub)
-   rbd-mirror: prevent I/O modifications against a non-primary image
    ([pr#33831](https://github.com/ceph/ceph/pull/33831), Jason
    Dillaman)
-   rbd-mirror: provide initial snapshot replay status
    ([pr#33440](https://github.com/ceph/ceph/pull/33440), Jason
    Dillaman)
-   rbd-mirror: remove journal-specific logic from image replay and
    bootstrap state machines
    ([pr#32578](https://github.com/ceph/ceph/pull/32578), Jason
    Dillaman)
-   rbd-mirror: removing non-primary trash snapshot
    ([pr#31260](https://github.com/ceph/ceph/pull/31260), Mykola Golub)
-   rbd-mirror: rename per-image replication perf counters
    ([pr#32184](https://github.com/ceph/ceph/pull/32184), Mykola Golub)
-   rbd-mirror: simplify peer bootstrapping
    ([pr#30411](https://github.com/ceph/ceph/pull/30411), Jason
    Dillaman)
-   rbd-mirror: snapshot mirror mode
    ([pr#30548](https://github.com/ceph/ceph/pull/30548), Mykola Golub)
-   rbd-mirror: snapshot-based mirroring should use image sync throttler
    ([pr#34040](https://github.com/ceph/ceph/pull/34040), Jason
    Dillaman)
-   rbd-nbd: add netlink map/unmap support
    ([pr#27902](https://github.com/ceph/ceph/pull/27902), Mike Christie)
-   rbd-nbd: add nl resize
    ([pr#29036](https://github.com/ceph/ceph/pull/29036), Mike Christie)
-   rbd-nbd: sscanf return 0 mean not-match
    ([issue#39269](http://tracker.ceph.com/issues/39269),
    [pr#27484](https://github.com/ceph/ceph/pull/27484), Jianpeng Ma)
-   rbd: creating thick-provision image progress percent info exceeds
    100% ([pr#30954](https://github.com/ceph/ceph/pull/30954), Xiangdong
    Mu)
-   rbd: journal: add support for aligned appends
    ([pr#28351](https://github.com/ceph/ceph/pull/28351), Mykola Golub)
-   rbd: librbd: skip stale child with non-existent pool for list
    descendants ([pr#29654](https://github.com/ceph/ceph/pull/29654),
    songweibin)
-   rbd: add \--merge to disk-usage
    ([pr#30994](https://github.com/ceph/ceph/pull/30994), Alexandre
    Bruyelles)
-   rbd: add mirror snapshot schedule commands
    ([pr#32882](https://github.com/ceph/ceph/pull/32882), Mykola Golub)
-   rbd: add snap_exists method API
    ([pr#32497](https://github.com/ceph/ceph/pull/32497), Zheng Yin)
-   rbd: client,common,mgr,rbd: clang related cleanups
    ([pr#33657](https://github.com/ceph/ceph/pull/33657), Kefu Chai)
-   rbd: cls/rbd: improve efficiency of mirror image status queries
    ([pr#31865](https://github.com/ceph/ceph/pull/31865), Jason
    Dillaman)
-   rbd: cls/rbd: sanitize entity instance messenger version type
    ([pr#30438](https://github.com/ceph/ceph/pull/30438), Jason
    Dillaman)
-   rbd: cls/rbd: sanitize the mirror image status peer address after
    reading from disk
    ([pr#31824](https://github.com/ceph/ceph/pull/31824), Jason
    Dillaman)
-   rbd: cls: reduce log level for non-fatal errors
    ([issue#40865](http://tracker.ceph.com/issues/40865),
    [pr#29165](https://github.com/ceph/ceph/pull/29165), Jason Dillaman)
-   rbd: delete redundant words when trash restore fails because of same
    name ([pr#30952](https://github.com/ceph/ceph/pull/30952), Xiangdong
    Mu)
-   rbd: fixed additional issues with CEPH_ARGS processing
    ([pr#33219](https://github.com/ceph/ceph/pull/33219), Jason
    Dillaman)
-   rbd: incorporate rbd-mirror daemon status in mirror pool status
    ([pr#31949](https://github.com/ceph/ceph/pull/31949), Jason
    Dillaman)
-   rbd: journal: fix race between player shut down and cache rebalance
    ([pr#28748](https://github.com/ceph/ceph/pull/28748), Mykola Golub)
-   rbd: journal: fix race between player shut down and cache rebalance
    ([pr#29796](https://github.com/ceph/ceph/pull/29796), Mykola Golub)
-   rbd: journal: optimize object overflow detection
    ([pr#28240](https://github.com/ceph/ceph/pull/28240), Mykola Golub)
-   rbd: journal: properly advance read offset after skipping invalid
    range ([pr#28627](https://github.com/ceph/ceph/pull/28627), Mykola
    Golub)
-   rbd: journal: return error after first corruption detected
    ([pr#28820](https://github.com/ceph/ceph/pull/28820), Mykola Golub)
-   rbd: journal: wait for in flight advance sets on stopping recorder
    ([pr#28529](https://github.com/ceph/ceph/pull/28529), Mykola Golub)
-   rbd: krbd: avoid udev netlink socket overrun
    ([pr#30965](https://github.com/ceph/ceph/pull/30965), Ilya Dryomov)
-   rbd: krbd: fix rbd map hang due to udev return subsystem unordered
    ([issue#39089](http://tracker.ceph.com/issues/39089),
    [pr#27339](https://github.com/ceph/ceph/pull/27339), Zhi Zhang)
-   rbd: krbd: modprobe before calling build_map_buf()
    ([pr#30978](https://github.com/ceph/ceph/pull/30978), Ilya Dryomov)
-   rbd: krbd: retry on transient errors from
    udev_enumerate_scan_devices()
    ([pr#31023](https://github.com/ceph/ceph/pull/31023), Ilya Dryomov)
-   rbd: krbd: return -ETIMEDOUT in polling
    ([issue#38792](http://tracker.ceph.com/issues/38792),
    [pr#27025](https://github.com/ceph/ceph/pull/27025), Dongsheng Yang)
-   rbd: mgr/dashboard: support RBD mirroring bootstrap create/import
    ([issue#42355](http://tracker.ceph.com/issues/42355),
    [pr#31062](https://github.com/ceph/ceph/pull/31062), Jason Dillaman)
-   rbd: msg/async: avoid unnecessary costly wakeups for outbound
    messages ([pr#28388](https://github.com/ceph/ceph/pull/28388), Jason
    Dillaman)
-   rbd: msg/async: reduce verbosity of connection timeout failures
    ([issue#39448](http://tracker.ceph.com/issues/39448),
    [pr#28050](https://github.com/ceph/ceph/pull/28050), Jason Dillaman)
-   rbd: pybind/mgr/rbd_support: fix missing variable in error path
    ([pr#29773](https://github.com/ceph/ceph/pull/29773), Jason
    Dillaman)
-   rbd: pybind/mgr/rbd_support: ignore missing support for RBD
    namespaces ([pr#29433](https://github.com/ceph/ceph/pull/29433),
    Jason Dillaman)
-   rbd: pybind/mgr/rbd_support: use image ids to detect duplicate tasks
    ([pr#29468](https://github.com/ceph/ceph/pull/29468), Jason
    Dillaman)
-   rbd: pybind/mgr/rbd_support: wait for latest OSD map prior to
    handling commands
    ([pr#33451](https://github.com/ceph/ceph/pull/33451), Jason
    Dillaman)
-   rbd: pybind/rbd: fix call to unregister_osd_perf_queries
    ([pr#29419](https://github.com/ceph/ceph/pull/29419), Venky Shankar)
-   rbd: pybind/rbd: provide snap remove flags
    ([pr#31627](https://github.com/ceph/ceph/pull/31627), Mykola Golub)
-   rbd: qa/suites/rbd/openstack: use 18.04, not 16.04
    ([pr#32284](https://github.com/ceph/ceph/pull/32284), Sage Weil)
-   rbd: rbd-ggate: fix compile errors from ceph::mutex update
    ([pr#29474](https://github.com/ceph/ceph/pull/29474), Willem Jan
    Withagen)
-   rbd: rbd-mirror: adjust journal fetch properties based on memory
    target ([pr#27670](https://github.com/ceph/ceph/pull/27670), Mykola
    Golub)
-   rbd: rbd/action: display image id in rbd du/list output
    ([pr#29376](https://github.com/ceph/ceph/pull/29376), songweibin)
-   rbd: rbd/action: fix error getting positional argument
    ([issue#40095](http://tracker.ceph.com/issues/40095),
    [pr#28313](https://github.com/ceph/ceph/pull/28313), songweibin)
-   rbd: rbd/bench: outputs bytes/s format dynamically
    ([pr#31491](https://github.com/ceph/ceph/pull/31491), Zheng Yin)
-   rbd: rbd/cache: Replicated Write Log core codes part 1
    ([pr#31279](https://github.com/ceph/ceph/pull/31279), Peterson,
    Scott, Li, Xiaoyan, Lu, Yuan, Chamarthy, Mahati)
-   rbd: rbd/cache: Replicated Write Log core codes part 2
    ([pr#31963](https://github.com/ceph/ceph/pull/31963), Peterson,
    Scott, Li, Xiaoyan, Lu, Yuan, Chamarthy, Mahati)
-   rbd: rbd_replay: call the member decode() explicitly
    ([pr#27703](https://github.com/ceph/ceph/pull/27703), Kefu Chai)
-   rbd: schedule for running trash purge operations
    ([pr#33389](https://github.com/ceph/ceph/pull/33389), Mykola Golub)
-   rbd: src: use un-deprecated version of aio_create_completion
    ([pr#31333](https://github.com/ceph/ceph/pull/31333), Adam C.
    Emerson)
-   rbd: use the ordered throttle for the export action
    ([issue#40435](http://tracker.ceph.com/issues/40435),
    [pr#28657](https://github.com/ceph/ceph/pull/28657), Jason Dillaman)
-   remove cephadm-adoption-corpus as submodule
    ([pr#33587](https://github.com/ceph/ceph/pull/33587), Sage Weil)
-   Return an error, for Bluestore OSD, if WAL or DB are defined in the
    tags of the OSD but not present on the system
    ([pr#28791](https://github.com/ceph/ceph/pull/28791), David Casier)
-   rgw,tests: qa/rgw/pubsub: fix tests to sync from master
    ([pr#33049](https://github.com/ceph/ceph/pull/33049), Yuval
    Lifshitz)
-   rgw,tests: qa/rgw/pubsub: verify incremental sync is used in pubsu
    ([pr#33068](https://github.com/ceph/ceph/pull/33068), Yuval
    Lifshitz)
-   rgw,tests: qa/rgw: add integration test for sse-kms with barbican
    ([pr#30218](https://github.com/ceph/ceph/pull/30218), Casey Bodley,
    Adam Kupczyk)
-   rgw,tests: qa/rgw: add new rgw/website suite for static website
    tests ([pr#30193](https://github.com/ceph/ceph/pull/30193), Casey
    Bodley)
-   rgw,tests: qa/rgw: add rgw_obj and throttle tests to rgw verify
    suite ([pr#32188](https://github.com/ceph/ceph/pull/32188), Casey
    Bodley)
-   rgw,tests: qa/rgw: disable debuginfo packages
    ([pr#27528](https://github.com/ceph/ceph/pull/27528), Casey Bodley)
-   rgw,tests: qa/rgw: dont use ceph-ansible in s3a-hadoop suite
    ([issue#39706](http://tracker.ceph.com/issues/39706),
    [pr#28068](https://github.com/ceph/ceph/pull/28068), Casey Bodley)
-   rgw,tests: qa/rgw: drop some objectstore types
    ([pr#30997](https://github.com/ceph/ceph/pull/30997), Casey Bodley)
-   rgw,tests: qa/rgw: exercise DeleteRange in
    test_bucket_index_log_trim
    ([pr#33047](https://github.com/ceph/ceph/pull/33047), Casey Bodley)
-   rgw,tests: qa/rgw: extra s3tests tasks use rgw endpoint
    configuration ([issue#17882](http://tracker.ceph.com/issues/17882),
    [pr#28631](https://github.com/ceph/ceph/pull/28631), Casey Bodley)
-   rgw,tests: qa/rgw: fix import error in tasks/swift.py
    ([issue#40304](http://tracker.ceph.com/issues/40304),
    [pr#28605](https://github.com/ceph/ceph/pull/28605), Casey Bodley)
-   rgw,tests: qa/rgw: fix swift warning message
    ([pr#28697](https://github.com/ceph/ceph/pull/28697), Casey Bodley)
-   rgw,tests: qa/rgw: more fixes for swift task
    ([issue#40304](http://tracker.ceph.com/issues/40304),
    [pr#28823](https://github.com/ceph/ceph/pull/28823), Casey Bodley)
-   rgw,tests: qa/rgw: multisite checkpoints consider pubsub zone
    ([pr#32941](https://github.com/ceph/ceph/pull/32941), Casey Bodley)
-   rgw,tests: qa/rgw: refactor the kms backend configuration
    ([pr#30940](https://github.com/ceph/ceph/pull/30940), Casey Bodley)
-   rgw,tests: qa/rgw: remove failing radosgw_admin_rest from multisite
    suite ([pr#32550](https://github.com/ceph/ceph/pull/32550), Casey
    Bodley)
-   rgw,tests: qa/rgw: remove whitelist for SLOW_OPS against ec pools
    ([pr#31363](https://github.com/ceph/ceph/pull/31363), Casey Bodley)
-   rgw,tests: qa/rgw: s3a-hadoop task defaults to maven-version 3.6.3
    ([pr#32620](https://github.com/ceph/ceph/pull/32620), Casey Bodley)
-   rgw,tests: qa/rgw: skip swift tests on rhel 7.6+
    ([issue#40304](http://tracker.ceph.com/issues/40304),
    [pr#28532](https://github.com/ceph/ceph/pull/28532), Casey Bodley)
-   rgw,tests: qa/rgw: update run-s3tests.sh
    ([pr#28964](https://github.com/ceph/ceph/pull/28964), Casey Bodley)
-   rgw,tests: qa/rgw: use testing kms backend for multisite tests
    ([pr#31374](https://github.com/ceph/ceph/pull/31374), Casey Bodley)
-   rgw,tests: qa/rgw: use testing kms backend for other rgw subsuites
    ([pr#31414](https://github.com/ceph/ceph/pull/31414), Casey Bodley)
-   rgw,tests: qa/rgw: whitelist SLOW_OPS failures against ec pools
    ([pr#30944](https://github.com/ceph/ceph/pull/30944), Casey Bodley)
-   rgw,tests: qa/suites/rgw/website: run test on ubuntu
    ([pr#32791](https://github.com/ceph/ceph/pull/32791), Sage Weil)
-   rgw,tests: qa/suites/rgw: reenable ragweed (now py3)
    ([pr#32310](https://github.com/ceph/ceph/pull/32310), Sage Weil)
-   rgw,tests: qa/suites: use s3-tests with python3 support
    ([pr#32624](https://github.com/ceph/ceph/pull/32624), Ali Maredia)
-   rgw,tests: qa/tasks/swift: remove swift tests
    ([pr#32357](https://github.com/ceph/ceph/pull/32357), Sage Weil)
-   rgw,tests: qa/tests: added rgw into upgrade sequence to improve
    coverage ([pr#29234](https://github.com/ceph/ceph/pull/29234), Yuri
    Weinstein)
-   rgw,tests: qa/tests: added rgw into upgrade sequence to improve
    coverage - splits
    ([pr#29282](https://github.com/ceph/ceph/pull/29282), Yuri
    Weinstein)
-   rgw,tests: qa: add force-branch to suites running s3readwrite &
    s3roundtrip tasks
    ([pr#32225](https://github.com/ceph/ceph/pull/32225), Ali Maredia)
-   rgw,tests: qa: bump maven repo version in s3a_hadoop.py
    ([pr#30531](https://github.com/ceph/ceph/pull/30531), Ali Maredia)
-   rgw,tests: qa: radosgw-admin: remove dependency on bunch package
    ([pr#32100](https://github.com/ceph/ceph/pull/32100), Yehuda Sadeh)
-   rgw,tests: qa: radosgw_admin: validate a simple user stats output
    ([pr#30684](https://github.com/ceph/ceph/pull/30684), Abhishek
    Lekshmanan)
-   rgw,tests: qa: remove mon valgrind check in rgw verfiy suite
    ([issue#38827](http://tracker.ceph.com/issues/38827),
    [pr#28155](https://github.com/ceph/ceph/pull/28155), Ali Maredia)
-   rgw,tests: qa: remove s3-tests from rados/basic/tasks/rgw_snaps.yml
    ([pr#32940](https://github.com/ceph/ceph/pull/32940), Ali Maredia)
-   rgw,tests: qa: rgw: add user-policy caps for the s3tests users
    ([pr#31127](https://github.com/ceph/ceph/pull/31127), Abhishek
    Lekshmanan)
-   rgw,tests: qa: use curl in wait_for_radosgw() in util/rgw.py
    ([pr#28521](https://github.com/ceph/ceph/pull/28521), Ali Maredia)
-   rgw,tests: rgw/amqp: fix race condition in AMQP unit test
    ([pr#30735](https://github.com/ceph/ceph/pull/30735), Yuval
    Lifshitz)
-   rgw,tests: rgw/amqp: remove flaky amqp test
    ([pr#31510](https://github.com/ceph/ceph/pull/31510), Yuval
    Lifshitz)
-   rgw,tests: rgw/pubsub: add multisite pubsub tests to teuthology
    ([pr#27838](https://github.com/ceph/ceph/pull/27838), Yuval
    Lifshitz)
-   rgw,tests: rgw/pubsub: tests enhancements and fixes
    ([pr#28910](https://github.com/ceph/ceph/pull/28910), Yuval
    Lifshitz)
-   rgw,tests: rgw/pubsub: use incremental sync for pubsub module by
    default ([pr#28470](https://github.com/ceph/ceph/pull/28470), Yuval
    Lifshitz)
-   rgw,tests: test/rgw: fix test-rgw-multisite.sh script for creating
    multisite clusters
    ([pr#27984](https://github.com/ceph/ceph/pull/27984), Casey Bodley)
-   rgw,tests: test/rgw: fixes for test-rgw-multisite.sh
    ([pr#33537](https://github.com/ceph/ceph/pull/33537), Casey Bodley)
-   rgw,tests: test/rgw: raise timer durations for
    unittest_rgw_reshard_wait
    ([pr#32094](https://github.com/ceph/ceph/pull/32094), Casey Bodley)
-   rgw,tests: test/rgw: test_rgw_reshard_wait uses same clock for
    timing ([pr#27035](https://github.com/ceph/ceph/pull/27035), Casey
    Bodley)
-   rgw,tests: vstart: move common rgw config to \[client.rgw\]
    ([pr#29449](https://github.com/ceph/ceph/pull/29449), Casey Bodley)
-   rgw,tools: ceph-dencoder: add RGWPeriodLatestEpochInfo support
    ([pr#30613](https://github.com/ceph/ceph/pull/30613), yuliyang)
-   rgw,tools: rgw/examples: adding examples for boto3 extensions to AWS
    S3 ([pr#30600](https://github.com/ceph/ceph/pull/30600), Yuval
    Lifshitz)
-   rgw,tools: vstart.sh: run multiple rgws with different ids
    ([pr#26690](https://github.com/ceph/ceph/pull/26690), Joao Eduardo
    Luis)
-   rgw: rgw: cls_bucket_list_unordered lists a single shard
    ([issue#39393](http://tracker.ceph.com/issues/39393),
    [pr#27697](https://github.com/ceph/ceph/pull/27697), Casey Bodley)
-   rgw: rgw: make radosgw-admin user create and modify distinct
    ([pr#31901](https://github.com/ceph/ceph/pull/31901), Matthew
    Oliver)
-   rgw: rgw: returns LimitExceeded when user creates too many ACLs
    ([issue#26835](http://tracker.ceph.com/issues/26835),
    [pr#25692](https://github.com/ceph/ceph/pull/25692), Chang Liu)
-   rgw: A task to run S3 Java tests against RGW
    ([pr#22788](https://github.com/ceph/ceph/pull/22788), Antoaneta
    Damyanova)
-   rgw: add \--object-version in radosgw-admin help info
    ([pr#30091](https://github.com/ceph/ceph/pull/30091), yuliyang)
-   rgw: add a small efficiency
    ([pr#29178](https://github.com/ceph/ceph/pull/29178), J. Eric
    Ivancich)
-   rgw: add admin rest api for bucket sync
    ([pr#19020](https://github.com/ceph/ceph/pull/19020), zhang Shaowen,
    Zhang Shaowen)
-   rgw: add cls_queue and cls_rgw_gc for omap offload
    ([pr#28421](https://github.com/ceph/ceph/pull/28421), Pritha
    Srivastava, Casey Bodley)
-   rgw: add const correctness to some rest functions
    ([pr#31660](https://github.com/ceph/ceph/pull/31660), J. Eric
    Ivancich)
-   rgw: add creation time information into bucket stats
    ([pr#30384](https://github.com/ceph/ceph/pull/30384), Enming Zhang)
-   rgw: Add days0 to rgw lc
    ([pr#29937](https://github.com/ceph/ceph/pull/29937), Or Friedmann)
-   rgw: add detailed error message for PutACLs
    ([pr#30385](https://github.com/ceph/ceph/pull/30385), Enming Zhang)
-   rgw: add editor directive comments to rgw services source files
    ([pr#27897](https://github.com/ceph/ceph/pull/27897), J. Eric
    Ivancich)
-   rgw: add GET /admin/realm?list api to list realms
    ([pr#28156](https://github.com/ceph/ceph/pull/28156), Casey Bodley)
-   rgw: add missing admin property when sync user info
    ([pr#30127](https://github.com/ceph/ceph/pull/30127), zhang Shaowen)
-   rgw: add missing bilog status to help info
    ([pr#30357](https://github.com/ceph/ceph/pull/30357), zhang Shaowen)
-   rgw: add missing close_section in send_versioned_response
    ([pr#28946](https://github.com/ceph/ceph/pull/28946), Casey Bodley)
-   rgw: Add more details to the LC delete and transit log
    ([pr#30913](https://github.com/ceph/ceph/pull/30913), Or Friedmann)
-   rgw: add num_shards to radosgw-admin bucket stats
    ([pr#30845](https://github.com/ceph/ceph/pull/30845), Paul Emmerich)
-   rgw: add option to specify shard-id for bi list admin command
    ([pr#29394](https://github.com/ceph/ceph/pull/29394), Mark Kogan)
-   rgw: add optional_yield to http client interface
    ([pr#25355](https://github.com/ceph/ceph/pull/25355), Casey Bodley)
-   rgw: add optional_yield to SysObj service interfaces
    ([pr#25353](https://github.com/ceph/ceph/pull/25353), Casey Bodley)
-   rgw: add PublicAccessBlock set of APIs on buckets
    ([pr#30033](https://github.com/ceph/ceph/pull/30033), Abhishek
    Lekshmanan)
-   rgw: add rgw_rados_pool_recovery_priority (default 5)
    ([pr#29181](https://github.com/ceph/ceph/pull/29181), Sage Weil)
-   rgw: add roles_pool in RGWZoneParams dump/decode json
    ([issue#22162](http://tracker.ceph.com/issues/22162),
    [pr#17338](https://github.com/ceph/ceph/pull/17338), Tianshan Qu)
-   rgw: add S3 object lock feature to support object worm
    ([pr#26538](https://github.com/ceph/ceph/pull/26538), zhang Shaowen)
-   rgw: add some comments to rgw code to help explain functionality
    ([pr#27896](https://github.com/ceph/ceph/pull/27896), J. Eric
    Ivancich)
-   rgw: add SSE-KMS with Vault using token auth
    ([pr#29783](https://github.com/ceph/ceph/pull/29783), Andrea
    Baglioni, Sergio de Carvalho)
-   rgw: Add support bucket policy for subuser
    ([pr#33165](https://github.com/ceph/ceph/pull/33165), Seena Fallah)
-   rgw: add tenant as parameter to User in multisite tests
    ([pr#27969](https://github.com/ceph/ceph/pull/27969), Yuval
    Lifshitz)
-   rgw: add transaction id to ops log
    ([pr#30163](https://github.com/ceph/ceph/pull/30163), zhang Shaowen)
-   rgw: add YieldingAioThrottle for async PutObj/GetObj
    ([pr#26173](https://github.com/ceph/ceph/pull/26173), Casey Bodley)
-   rgw: Added caching for S3 credentials retrieved from keystone
    ([pr#26095](https://github.com/ceph/ceph/pull/26095), James Weaver)
-   rgw: adding documentation for AssumeRoleWithWebIdentity
    ([pr#31994](https://github.com/ceph/ceph/pull/31994), Pritha
    Srivastava)
-   rgw: Adding iam namespace for Role and User Policy related REST APIs
    ([pr#27178](https://github.com/ceph/ceph/pull/27178), Pritha
    Srivastava)
-   rgw: adding mfa code validation when bucket versioning status is
    changed ([pr#31767](https://github.com/ceph/ceph/pull/31767), Pritha
    Srivastava)
-   rgw: Adding tcp_nodelay option to Beast
    ([pr#27008](https://github.com/ceph/ceph/pull/27008), Or Friedmann)
-   rgw: address 0-length listing results when non-vis entries dominate
    ([pr#32636](https://github.com/ceph/ceph/pull/32636), J. Eric
    Ivancich)
-   rgw: adjust allowable bucket index shard counts for dynamic
    resharding ([pr#30795](https://github.com/ceph/ceph/pull/30795), J.
    Eric Ivancich)
-   rgw: admin: handle delete_at attr in object stat output
    ([pr#27781](https://github.com/ceph/ceph/pull/27781), Abhishek
    Lekshmanan)
-   rgw: Allow admin APIs that write metadata to be executed first on
    the mastxe2x80xa6
    ([issue#39549](http://tracker.ceph.com/issues/39549),
    [pr#29549](https://github.com/ceph/ceph/pull/29549), Shilpa
    Jagannath)
-   rgw: allow radosgw-admin to list bucket w \--allow-unordered
    ([issue#39637](http://tracker.ceph.com/issues/39637),
    [pr#28031](https://github.com/ceph/ceph/pull/28031), J. Eric
    Ivancich)
-   rgw: allow reshard log entries for non-existent buckets to be
    cancelled ([pr#31271](https://github.com/ceph/ceph/pull/31271), J.
    Eric Ivancich)
-   rgw: apply_olh_log ignores RGW_ATTR_OLH_VER decode error
    ([pr#31976](https://github.com/ceph/ceph/pull/31976), Casey Bodley)
-   rgw: asio: check the remote endpoint before processing requests
    ([pr#29967](https://github.com/ceph/ceph/pull/29967), Abhishek
    Lekshmanan)
-   rgw: auth/Crypto: fallback to /dev/urandom if getentropy() fails
    ([pr#30544](https://github.com/ceph/ceph/pull/30544), Kefu Chai)
-   rgw: auto-clean reshard queue entries for non-existent buckets
    ([pr#31323](https://github.com/ceph/ceph/pull/31323), J. Eric
    Ivancich)
-   rgw: az: add archive zone tests
    ([pr#29359](https://github.com/ceph/ceph/pull/29359), Javier M.
    Mellid)
-   rgw: beast frontend uses 512k mprotected coroutine stacks
    ([pr#31580](https://github.com/ceph/ceph/pull/31580), Daniel
    Gryniewicz, Casey Bodley)
-   rgw: beast frontend uses yield_context to read/write body
    ([pr#27795](https://github.com/ceph/ceph/pull/27795), Casey Bodley)
-   rgw: beast port parsing
    ([issue#39000](http://tracker.ceph.com/issues/39000),
    [pr#27242](https://github.com/ceph/ceph/pull/27242), Abhishek
    Lekshmanan)
-   rgw: beast ssl certs config through config-key
    ([pr#33287](https://github.com/ceph/ceph/pull/33287), Yehuda Sadeh)
-   rgw: bucket granularity sync
    ([pr#31686](https://github.com/ceph/ceph/pull/31686), Yehuda Sadeh)
-   rgw: bucket re-creation fixes
    ([pr#32121](https://github.com/ceph/ceph/pull/32121), Yehuda Sadeh)
-   rgw: bucket stats report mtime in UTC
    ([pr#27617](https://github.com/ceph/ceph/pull/27617), Casey Bodley)
-   rgw: bucket tagging
    ([pr#27993](https://github.com/ceph/ceph/pull/27993), Chang Liu)
-   rgw: build async scheduler only when beast is built
    ([pr#26634](https://github.com/ceph/ceph/pull/26634), Abhishek
    Lekshmanan)
-   rgw: build radosgw daemon as a shared lib + small executable
    ([pr#32404](https://github.com/ceph/ceph/pull/32404), Kaleb S.
    Keithley)
-   rgw: build_linked_oids_for_bucket and build_buckets_instance_index
    should return negative value if it fails
    ([pr#31346](https://github.com/ceph/ceph/pull/31346), zhangshaowen)
-   rgw: change cls rgw reshard status to enum class
    ([pr#30611](https://github.com/ceph/ceph/pull/30611), J. Eric
    Ivancich)
-   rgw: change MAX_USAGE_TRIM_ENTRIES value from 128 to 1000
    ([pr#30392](https://github.com/ceph/ceph/pull/30392), zhang Shaowen)
-   rgw: check lc objs not empty after fetching
    ([pr#26167](https://github.com/ceph/ceph/pull/26167), Yao Zongyou)
-   rgw: clean index and remove bucket instance info when setting
    resharding status fails
    ([pr#31103](https://github.com/ceph/ceph/pull/31103), zhangshaowen)
-   rgw: clean up ordered list
    ([pr#31338](https://github.com/ceph/ceph/pull/31338), J. Eric
    Ivancich)
-   rgw: clean up some logging
    ([pr#27411](https://github.com/ceph/ceph/pull/27411), J. Eric
    Ivancich)
-   rgw: cleanup the magic string usage in cls_rgw_client.cc
    ([pr#31432](https://github.com/ceph/ceph/pull/31432), zhangshaowen)
-   rgw: cleanup:remove un-used class member in RGWDeleteLC
    ([pr#31404](https://github.com/ceph/ceph/pull/31404), zhang Shaowen)
-   rgw: cleanup:remove un-used create_new_bucket_instance in
    rgw_admin.cc ([pr#31345](https://github.com/ceph/ceph/pull/31345),
    zhangshaowen)
-   rgw: clear ent_list for each loop of bucket list
    ([issue#44394](http://tracker.ceph.com/issues/44394),
    [pr#33693](https://github.com/ceph/ceph/pull/33693), Yao Zongyou)
-   rgw: cls/rgw: fix bilog trim tests in ceph_test_cls_rgw
    ([pr#30268](https://github.com/ceph/ceph/pull/30268), Casey Bodley)
-   rgw: cls/rgw: keep issuing bilog trim ops after reset
    ([issue#40187](http://tracker.ceph.com/issues/40187),
    [pr#28430](https://github.com/ceph/ceph/pull/28430), Casey Bodley)
-   rgw: cls/rgw: test before accessing pkeys-\>rbegin()
    ([issue#39984](http://tracker.ceph.com/issues/39984),
    [pr#28391](https://github.com/ceph/ceph/pull/28391), Casey Bodley)
-   rgw: cls/rgw: when object is versioned and lc transition it, the
    object is becoming non-current
    ([pr#32458](https://github.com/ceph/ceph/pull/32458), Or Friedmann)
-   rgw: cls/user: cls_user_set_buckets_info overwrites creation_time
    ([issue#39635](http://tracker.ceph.com/issues/39635),
    [pr#28045](https://github.com/ceph/ceph/pull/28045), Casey Bodley)
-   rgw: cls_bucket_list\\\_(un)ordered should clear results collection
    ([pr#33702](https://github.com/ceph/ceph/pull/33702), J. Eric
    Ivancich)
-   rgw: compression info should be same during multipart uploading
    ([pr#30574](https://github.com/ceph/ceph/pull/30574), zhang Shaowen)
-   rgw: conditionally allow non-unique email addresses
    ([issue#40089](http://tracker.ceph.com/issues/40089),
    [pr#28327](https://github.com/ceph/ceph/pull/28327), Matt Benjamin)
-   rgw: continuation token doesnt work in list object v2 request
    ([pr#28988](https://github.com/ceph/ceph/pull/28988), zhang Shaowen)
-   rgw: continuationToken or startAfter shouldnt be returned if not
    specified ([pr#29298](https://github.com/ceph/ceph/pull/29298),
    zhang Shaowen)
-   rgw: correct some error log about reshard in cls_rgw.cc
    ([pr#31429](https://github.com/ceph/ceph/pull/31429), zhangshaowen)
-   rgw: crypt: permit RGW-AUTO/default with SSE-S3 headers
    ([pr#30189](https://github.com/ceph/ceph/pull/30189), Matt Benjamin)
-   rgw: crypto: throw DigestException from Digest and HMAC
    ([issue#39456](http://tracker.ceph.com/issues/39456),
    [pr#27765](https://github.com/ceph/ceph/pull/27765), Matt Benjamin)
-   rgw: data sync markers include timestamp from datalog entry
    ([pr#32309](https://github.com/ceph/ceph/pull/32309), Casey Bodley)
-   rgw: data/bilogs are trimmed when no peers are reading them
    ([issue#39487](http://tracker.ceph.com/issues/39487),
    [pr#27794](https://github.com/ceph/ceph/pull/27794), Casey Bodley)
-   rgw: datalog/mdlog trim commands loop until done
    ([pr#29448](https://github.com/ceph/ceph/pull/29448), Casey Bodley)
-   rgw: data_sync_source_zones only contains exporting zones
    ([pr#33193](https://github.com/ceph/ceph/pull/33193), Casey Bodley)
-   rgw: decrypt filter does not cross multipart boundaries
    ([issue#38700](http://tracker.ceph.com/issues/38700),
    [pr#27130](https://github.com/ceph/ceph/pull/27130), Adam Kupczyk,
    Casey Bodley, Abhishek Lekshmanan)
-   rgw: DefaultRetention requires either Days or Years
    ([pr#29680](https://github.com/ceph/ceph/pull/29680), Chang Liu)
-   rgw: delete_obj_index() takes mtime for bilog
    ([issue#24991](http://tracker.ceph.com/issues/24991),
    [pr#27980](https://github.com/ceph/ceph/pull/27980), Casey Bodley)
-   rgw: distinguish different get_usage for usage log
    ([pr#17719](https://github.com/ceph/ceph/pull/17719), Jiaying Ren)
-   rgw: dmclock: wait until the request is handled
    ([pr#30777](https://github.com/ceph/ceph/pull/30777), GaryHyg)
-   rgw: do not miss the 1000th element of every iteration during
    lifecycle processing
    ([pr#30861](https://github.com/ceph/ceph/pull/30861), Ilsoo Byun)
-   rgw: do not remove delete marker when fixing versioned bucket
    ([pr#32562](https://github.com/ceph/ceph/pull/32562), Ilsoo Byun)
-   rgw: Dont crash on copy when metadata directive not supplied
    ([issue#40416](http://tracker.ceph.com/issues/40416),
    [pr#28949](https://github.com/ceph/ceph/pull/28949), Adam C.
    Emerson)
-   rgw: dont crash on missing /etc/mime.types
    ([issue#38328](http://tracker.ceph.com/issues/38328),
    [pr#26998](https://github.com/ceph/ceph/pull/26998), Casey Bodley)
-   rgw: dont print error log when list reshard result is not truncated
    ([pr#31142](https://github.com/ceph/ceph/pull/31142), zhangshaowen)
-   rgw: dont recalculate etags for slo/dlo
    ([pr#27470](https://github.com/ceph/ceph/pull/27470), Casey Bodley)
-   rgw: dont throw when accept errors are happening on frontend
    ([pr#29587](https://github.com/ceph/ceph/pull/29587), Yuval
    Lifshitz)
-   rgw: drop cloud sync module logs attrs from the log
    ([pr#27820](https://github.com/ceph/ceph/pull/27820), Nathan Cutler)
-   rgw: drop dead flush_read_list declaration
    ([pr#29458](https://github.com/ceph/ceph/pull/29458), Jiaying Ren)
-   rgw: drop unused rgw_decode_pki_token()
    ([pr#27052](https://github.com/ceph/ceph/pull/27052), Radoslaw
    Zarzynski)
-   rgw: dump s3_code as the Code response element in
    RGWDeleteMultiObj_ObjStore_S3
    ([issue#18241](http://tracker.ceph.com/issues/18241),
    [pr#12470](https://github.com/ceph/ceph/pull/12470), Radoslaw
    Zarzynski)
-   rgw: eliminates duplicated tags_bl var
    ([pr#27970](https://github.com/ceph/ceph/pull/27970), Chang Liu)
-   rgw: Evaluating bucket policies also while reading permissions for
    anxe2x80xa6 ([issue#38638](http://tracker.ceph.com/issues/38638),
    [pr#27309](https://github.com/ceph/ceph/pull/27309), Pritha
    Srivastava)
-   rgw: examples: rgw: add boto3 append & get usage api extensions
    ([pr#33063](https://github.com/ceph/ceph/pull/33063), Abhishek
    Lekshmanan)
-   rgw: Expiration days cant be zero and transition days can be zero
    ([pr#30878](https://github.com/ceph/ceph/pull/30878), zhang Shaowen)
-   rgw: extend SSE-KMS with Vault using transit secrets engine
    ([pr#31361](https://github.com/ceph/ceph/pull/31361), Andrea
    Baglioni, Sergio de Carvalho)
-   rgw: fetch_remote_obj() compares expected object size
    ([pr#28303](https://github.com/ceph/ceph/pull/28303), Xiaoxi CHEN,
    Casey Bodley)
-   rgw: find oldest period and update RGWMetadataLogHistory()
    ([pr#31873](https://github.com/ceph/ceph/pull/31873), Shilpa
    Jagannath)
-   rgw: fix a bug that bucket instance obj cant be removed after
    resharding completed
    ([pr#31483](https://github.com/ceph/ceph/pull/31483), zhang Shaowen)
-   rgw: fix a bug that lifecycle expiraton generates delete marker
    continuously ([issue#40393](http://tracker.ceph.com/issues/40393),
    [pr#28587](https://github.com/ceph/ceph/pull/28587), zhang Shaowen)
-   rgw: fix bucket may redundantly list keys after BI_PREFIX_CHAR
    ([issue#39984](http://tracker.ceph.com/issues/39984),
    [pr#28188](https://github.com/ceph/ceph/pull/28188), Tianshan Qu)
-   rgw: Fix bucket versioning vs. swift metadata bug
    ([pr#29240](https://github.com/ceph/ceph/pull/29240), Marcus Watts)
-   rgw: Fix bug on subuser policy identity checker
    ([pr#33398](https://github.com/ceph/ceph/pull/33398), Seena Fallah)
-   rgw: fix bug with (un)ordered bucket listing and marker w/ namespace
    ([pr#33046](https://github.com/ceph/ceph/pull/33046), J. Eric
    Ivancich)
-   rgw: fix bugs in listobjectsv1
    ([pr#28873](https://github.com/ceph/ceph/pull/28873), Albin Antony)
-   rgw: fix cls_bucket_list_unordered() partial results
    ([pr#29692](https://github.com/ceph/ceph/pull/29692), Mark Kogan)
-   rgw: fix compile errors with boost 1.70
    ([pr#27730](https://github.com/ceph/ceph/pull/27730), Casey Bodley)
-   rgw: fix data consistency error casued by rgw sent timeout
    ([pr#30257](https://github.com/ceph/ceph/pull/30257),
    xe6x9dx8exe7xbaxb2xe5xbdxac82225)
-   rgw: fix data sync start delay if remote havent init data_log
    ([pr#30393](https://github.com/ceph/ceph/pull/30393), Tianshan Qu)
-   rgw: fix default storage class for get_compression_type
    ([pr#29909](https://github.com/ceph/ceph/pull/29909), Casey Bodley)
-   rgw: fix default_placement containing / when storage_class is
    standard ([issue#39380](http://tracker.ceph.com/issues/39380),
    [pr#27676](https://github.com/ceph/ceph/pull/27676), mkogan1)
-   rgw: fix dns name comparison for virtual hosting
    ([pr#30221](https://github.com/ceph/ceph/pull/30221), Casey Bodley)
-   rgw: Fix documentation for rgw_ldap_secret
    ([pr#29816](https://github.com/ceph/ceph/pull/29816), Robin
    Mxc3xbcller)
-   rgw: fix drain handles error when deleting bucket with bypass-gc
    option ([pr#28789](https://github.com/ceph/ceph/pull/28789),
    dongdong tao)
-   rgw: Fix dynamic resharding not working for empty zonegroup in
    period ([pr#31977](https://github.com/ceph/ceph/pull/31977), Or
    Friedmann)
-   rgw: Fix expiration header does not return the earliest rule
    ([pr#29399](https://github.com/ceph/ceph/pull/29399), Or Friedmann)
-   rgw: fix incorrect radosgw-admin zonegroup rm info
    ([pr#30319](https://github.com/ceph/ceph/pull/30319), zhang Shaowen)
-   rgw: fix indentation for listobjectsv2
    ([pr#28830](https://github.com/ceph/ceph/pull/28830), Albin Antony)
-   rgw: fix list bucket with delimiter wrongly skip some special keys
    ([issue#40905](http://tracker.ceph.com/issues/40905),
    [pr#29215](https://github.com/ceph/ceph/pull/29215), Tianshan Qu)
-   rgw: fix list bucket with start maker and delimiter / will miss next
    objectxe2x80xa6
    ([issue#39989](http://tracker.ceph.com/issues/39989),
    [pr#28192](https://github.com/ceph/ceph/pull/28192), Tianshan Qu)
-   rgw: fix list versions starts with version_id=null
    ([pr#29897](https://github.com/ceph/ceph/pull/29897), Tianshan Qu)
-   rgw: fix MalformedXML errors in PutBucketObjectLock/PutObjRetention
    ([pr#28783](https://github.com/ceph/ceph/pull/28783), Casey Bodley)
-   rgw: fix memory growth while deleting objects with
    ([pr#30174](https://github.com/ceph/ceph/pull/30174), Mark Kogan)
-   rgw: fix minimum of unordered bucket listing
    ([pr#30146](https://github.com/ceph/ceph/pull/30146), J. Eric
    Ivancich)
-   rgw: fix minor compiler warning in keystone auth
    ([pr#27100](https://github.com/ceph/ceph/pull/27100), David
    Disseldorp)
-   rgw: fix miss get ret in STSService::storeARN
    ([issue#40386](http://tracker.ceph.com/issues/40386),
    [pr#28527](https://github.com/ceph/ceph/pull/28527), Tianshan Qu)
-   rgw: fix miss handle curl error return
    ([pr#28345](https://github.com/ceph/ceph/pull/28345), Casey Bodley,
    Tianshan Qu)
-   rgw: fix missing tenant prefix in bucket name during bucket link
    ([pr#29815](https://github.com/ceph/ceph/pull/29815), Shilpa
    Jagannath)
-   rgw: fix multipart uploads error response
    ([pr#32771](https://github.com/ceph/ceph/pull/32771), GaryHyg)
-   rgw: Fix narrowing conversion error
    ([pr#28905](https://github.com/ceph/ceph/pull/28905), Adam C.
    Emerson)
-   rgw: fix one part of the bulk delete(RGWDeleteMultiObj_ObjStore_S3)
    fails but no error messages
    ([pr#29795](https://github.com/ceph/ceph/pull/29795), Snow Si)
-   rgw: fix opslog operation field as per Amazon s3
    ([issue#20978](http://tracker.ceph.com/issues/20978),
    [pr#30539](https://github.com/ceph/ceph/pull/30539), Jiaying Ren)
-   rgw: fix potential realm watch lost
    ([issue#40991](http://tracker.ceph.com/issues/40991),
    [pr#29369](https://github.com/ceph/ceph/pull/29369), Tianshan Qu)
-   rgw: fix read not exists null version return wrong
    ([issue#38811](http://tracker.ceph.com/issues/38811),
    [pr#27047](https://github.com/ceph/ceph/pull/27047), Tianshan Qu)
-   rgw: fix refcount tags to match and update objects idtag
    ([pr#30013](https://github.com/ceph/ceph/pull/30013), J. Eric
    Ivancich)
-   rgw: fix REQUEST_URI setting in the rgw_asio_client.cc
    ([pr#30540](https://github.com/ceph/ceph/pull/30540), Jiaying Ren)
-   rgw: fix rgw crash and set correct error code
    ([pr#28172](https://github.com/ceph/ceph/pull/28172), yuliyang)
-   rgw: fix rgw crash when duration is invalid in sts request
    ([pr#32119](https://github.com/ceph/ceph/pull/32119), yuliyang)
-   rgw: fix rgw crash when token is not base64 encode
    ([pr#31830](https://github.com/ceph/ceph/pull/31830), yuliyang)
-   rgw: fix rgw decompression log-print
    ([pr#29633](https://github.com/ceph/ceph/pull/29633), Han Fengzhe)
-   rgw: fix rgw lc does not delete objects that do not have exactly the
    same tags as the rule
    ([pr#30151](https://github.com/ceph/ceph/pull/30151), Or Friedmann)
-   rgw: fix RGWDeleteMultiObj::verify_permission()
    ([pr#26947](https://github.com/ceph/ceph/pull/26947), Irek Fasikhov)
-   rgw: fix RGWUserInfo decode current version
    ([pr#31591](https://github.com/ceph/ceph/pull/31591), Chang Liu)
-   rgw: fix S3 compatibility bug when CORS is not found
    ([issue#37945](http://tracker.ceph.com/issues/37945),
    [pr#25999](https://github.com/ceph/ceph/pull/25999), Nick Janus)
-   rgw: fix sharded bucket listing with prefix/delimiter
    ([pr#33628](https://github.com/ceph/ceph/pull/33628), Casey Bodley)
-   rgw: fix SignatureDoesNotMatch when use ipv6 address in s3 client
    ([pr#30778](https://github.com/ceph/ceph/pull/30778), yuliyang)
-   rgw: fix signed char truncation in delimiter check
    ([pr#27001](https://github.com/ceph/ceph/pull/27001), Matt Benjamin)
-   rgw: fix string_view formatting in RGWFormatter_Plain
    ([pr#33754](https://github.com/ceph/ceph/pull/33754), Casey Bodley)
-   rgw: fix the bug of rgw not doing necessary checking to website
    configuration ([issue#40678](http://tracker.ceph.com/issues/40678),
    [pr#28904](https://github.com/ceph/ceph/pull/28904), Enming Zhang)
-   rgw: fix unlock of shared lock in RGWCache
    ([pr#29558](https://github.com/ceph/ceph/pull/29558), Abhishek
    Lekshmanan)
-   rgw: fix unlock of shared lock in RGWDataChangesLog
    ([pr#29538](https://github.com/ceph/ceph/pull/29538), Casey Bodley)
-   rgw: Fix upload part copy range able to get almost any string
    ([pr#32487](https://github.com/ceph/ceph/pull/32487), Or Friedmann)
-   rgw: fix version tracking across bucket link steps
    ([pr#29851](https://github.com/ceph/ceph/pull/29851), Matt Benjamin)
-   rgw: fixed unrecognized arg error when using radosgw-admin zone rm
    ([pr#30060](https://github.com/ceph/ceph/pull/30060), Hongang Chen)
-   rgw: Fixes related to omap offload and gc
    ([pr#33372](https://github.com/ceph/ceph/pull/33372), Pritha
    Srivastava)
-   rgw: followup for user rename
    ([pr#29540](https://github.com/ceph/ceph/pull/29540), Casey Bodley)
-   rgw: forwarded some requests to master zone
    ([pr#28276](https://github.com/ceph/ceph/pull/28276), Chang Liu)
-   rgw: gc remove tag after all sub io finish
    ([issue#40903](http://tracker.ceph.com/issues/40903),
    [pr#29199](https://github.com/ceph/ceph/pull/29199), Tianshan Qu)
-   rgw: get barbican secret key request maybe return error code
    ([pr#29639](https://github.com/ceph/ceph/pull/29639), Richard
    Bai(xe7x99xbdxe5xadxa6xe4xbdx99))
-   rgw: get elastic search info in start_sync, avoid creating new
    coroutines manager
    ([pr#32269](https://github.com/ceph/ceph/pull/32269), Chang Liu)
-   rgw: housekeeping of reset stats operation in radosgw-admin and cls
    back-end ([pr#29515](https://github.com/ceph/ceph/pull/29515), J.
    Eric Ivancich)
-   rgw: http client drops lock before suspending coroutine
    ([pr#29553](https://github.com/ceph/ceph/pull/29553), Casey Bodley)
-   rgw: iam: add all http args to req_info
    ([pr#31124](https://github.com/ceph/ceph/pull/31124), Abhishek
    Lekshmanan)
-   rgw: iam: use a function to calculate the Action Bit string
    ([pr#30152](https://github.com/ceph/ceph/pull/30152), Abhishek
    Lekshmanan)
-   rgw: ignore If-Unmodified-Since if If-Match exists, and ignore
    If-Modified-Since if If-None-Match exists
    ([pr#28625](https://github.com/ceph/ceph/pull/28625), zhang Shaowen)
-   rgw: improve beast
    ([pr#33017](https://github.com/ceph/ceph/pull/33017), Or Friedmann,
    Matt Benjamin)
-   rgw: improve data sync restart after failure
    ([pr#30175](https://github.com/ceph/ceph/pull/30175), Tianshan Qu)
-   rgw: improve debugs on the path of RGWRados::cls_bucket_head
    ([pr#12709](https://github.com/ceph/ceph/pull/12709), Radoslaw
    Zarzynski)
-   rgw: improvements to SSE-KMS with Vault
    ([pr#31025](https://github.com/ceph/ceph/pull/31025), Andrea
    Baglioni, Sergio de Carvalho)
-   rgw: Improving doc for Cross Project(Tenant) access with Openstack
    Kexe2x80xa6 ([pr#27507](https://github.com/ceph/ceph/pull/27507),
    Pritha Srivastava)
-   rgw: incorrect return value when processing CORS headers
    ([pr#28622](https://github.com/ceph/ceph/pull/28622), Ilsoo Byun)
-   rgw: Incorrectly calling ceph::buffer::list::decode_base64 in bucket
    policy ([pr#31356](https://github.com/ceph/ceph/pull/31356),
    GaryHyg)
-   rgw: increase beast parse buffer size to 64k
    ([pr#29776](https://github.com/ceph/ceph/pull/29776), Casey Bodley)
-   rgw: increase log level for same or older period pull msg
    ([pr#33527](https://github.com/ceph/ceph/pull/33527), Ali Maredia)
-   rgw: Increase the default number of RGW bucket shards
    ([pr#32660](https://github.com/ceph/ceph/pull/32660), Casey Bodley,
    Mark Nelson)
-   rgw: init-radosgw: use ceph-conf to get cluster configuration value
    ([pr#27538](https://github.com/ceph/ceph/pull/27538), Daniel Badea)
-   rgw: Initialize member variables in rgw_sync.h, rgw_rados.h
    ([pr#16929](https://github.com/ceph/ceph/pull/16929), amitkuma)
-   rgw: initialize member variables of rgw_log_entry
    ([pr#32430](https://github.com/ceph/ceph/pull/32430), Kefu Chai)
-   rgw: kill compile warnning in rgw_object_lock.h
    ([pr#30489](https://github.com/ceph/ceph/pull/30489), Chang Liu)
-   rgw: LC expiration header should present midnight expiration date
    ([pr#31887](https://github.com/ceph/ceph/pull/31887), Or Friedmann)
-   rgw: lc: check for valid placement target before processing
    transitions ([pr#28256](https://github.com/ceph/ceph/pull/28256),
    Abhishek Lekshmanan)
-   rgw: LC: handle resharded buckets
    ([pr#26564](https://github.com/ceph/ceph/pull/26564), Abhishek
    Lekshmanan)
-   rgw: ldap auth: S3 auth failure should return InvalidAccessKeyId
    ([pr#30332](https://github.com/ceph/ceph/pull/30332), Matt Benjamin)
-   rgw: ldap: fix LDAPAuthEngine::init() when uri !empty()
    ([pr#26911](https://github.com/ceph/ceph/pull/26911), Matt Benjamin)
-   rgw: lifecycle days may be 0
    ([pr#26524](https://github.com/ceph/ceph/pull/26524), Matt Benjamin)
-   rgw: lifecycle: alternate solution to prefix_map conflict
    ([issue#37879](http://tracker.ceph.com/issues/37879),
    [pr#26518](https://github.com/ceph/ceph/pull/26518), Matt Benjamin)
-   rgw: limit entries in remove_olh_pending_entries()
    ([issue#39118](http://tracker.ceph.com/issues/39118),
    [pr#27400](https://github.com/ceph/ceph/pull/27400), Casey Bodley)
-   rgw: list buckets: dont return buckets if limit=0
    ([pr#32109](https://github.com/ceph/ceph/pull/32109), Yehuda Sadeh)
-   rgw: list_bucket versions return NextVersionIdMarker = null if
    next_marker.instance is empty
    ([pr#17591](https://github.com/ceph/ceph/pull/17591), Shasha Lu)
-   rgw: log refactoring for putobj_processor
    ([pr#26107](https://github.com/ceph/ceph/pull/26107), Ali Maredia)
-   rgw: log refactoring for rgw_rest_s3/swift ops
    ([pr#27037](https://github.com/ceph/ceph/pull/27037), Ali Maredia)
-   rgw: make dns hostnames matching case insensitive
    ([issue#40995](http://tracker.ceph.com/issues/40995),
    [pr#29380](https://github.com/ceph/ceph/pull/29380), Abhishek
    Lekshmanan)
-   rgw: make max_connections configurable in beast
    ([pr#33053](https://github.com/ceph/ceph/pull/33053), Tiago
    Pasqualini)
-   rgw: Make rgw admin ops api get user info consistent with the
    command line ([pr#26183](https://github.com/ceph/ceph/pull/26183),
    Li Shuhao)
-   rgw: make sure modelines are correct for all files
    ([pr#29742](https://github.com/ceph/ceph/pull/29742), Daniel
    Gryniewicz)
-   rgw: maybe coredump when reload operator happened
    ([pr#29733](https://github.com/ceph/ceph/pull/29733), Richard
    Bai(xe7x99xbdxe5xadxa6xe4xbdx99))
-   rgw: metadata refactoring
    ([pr#29118](https://github.com/ceph/ceph/pull/29118), Casey Bodley,
    Yehuda Sadeh)
-   rgw: mgr/ansible: Change default realm and zonegroup
    ([pr#29793](https://github.com/ceph/ceph/pull/29793), Sebastian
    Wagner)
-   rgw: mgr/dashboard: enable/disable MFA Delete on RGW bucket
    ([pr#31922](https://github.com/ceph/ceph/pull/31922), Alfonso
    Martxc3xadnez)
-   rgw: mgr/orchestrator: name rgw by
    client.rgw.\$realm.\$zone\[.\$id\]
    ([pr#31890](https://github.com/ceph/ceph/pull/31890), Sage Weil)
-   rgw: mitigate bucket list with max-entries excessively high
    ([pr#29179](https://github.com/ceph/ceph/pull/29179), J. Eric
    Ivancich)
-   rgw: move bucket reshard checks out of write path
    ([pr#29852](https://github.com/ceph/ceph/pull/29852), Casey Bodley)
-   rgw: move delimiter-based bucket listing/filtering logic to cls
    ([pr#30272](https://github.com/ceph/ceph/pull/30272), J. Eric
    Ivancich)
-   rgw: move forward marker even in case of many rgw.none indexes
    ([pr#32513](https://github.com/ceph/ceph/pull/32513), Ilsoo Byun)
-   rgw: Move upload_info declaration out of conditional
    ([pr#29559](https://github.com/ceph/ceph/pull/29559), Adam C.
    Emerson)
-   rgw: multipart upload abort is best-effort
    ([issue#40526](http://tracker.ceph.com/issues/40526),
    [pr#28724](https://github.com/ceph/ceph/pull/28724), J. Eric
    Ivancich)
-   rgw: MultipartObjectProcessor supports stripe size \> chunk size
    ([pr#32996](https://github.com/ceph/ceph/pull/32996), Casey Bodley)
-   rgw: multisite log trimming only checks peers that sync from us
    ([issue#39283](http://tracker.ceph.com/issues/39283),
    [pr#27567](https://github.com/ceph/ceph/pull/27567), Casey Bodley)
-   rgw: nfs: skip empty (non-POSIX) path segments
    ([issue#38744](http://tracker.ceph.com/issues/38744),
    [pr#26954](https://github.com/ceph/ceph/pull/26954), Matt Benjamin)
-   rgw: nfs: svc-enable RGWLi
    ([pr#26981](https://github.com/ceph/ceph/pull/26981), Matt Benjamin)
-   rgw: normalize v6 endpoint behaviour for the beast frontend
    ([issue#39038](http://tracker.ceph.com/issues/39038),
    [pr#27270](https://github.com/ceph/ceph/pull/27270), Abhishek
    Lekshmanan)
-   rgw: object expirer fixes
    ([pr#27870](https://github.com/ceph/ceph/pull/27870), Abhishek
    Lekshmanan)
-   rgw: Object tags shouldnt work with deletemarker or multipart
    expiration ([issue#40405](http://tracker.ceph.com/issues/40405),
    [pr#28617](https://github.com/ceph/ceph/pull/28617), zhang Shaowen)
-   rgw: one log shard fails shouldnt block other shards process when
    reshard buckets
    ([pr#31155](https://github.com/ceph/ceph/pull/31155), zhangshaowen)
-   rgw: One Rados Handle to Rule Them All
    ([pr#27102](https://github.com/ceph/ceph/pull/27102), Adam C.
    Emerson)
-   rgw: orphan fixes
    ([pr#26412](https://github.com/ceph/ceph/pull/26412), Abhishek
    Lekshmanan)
-   rgw: parse_copy_location defers url-decode
    ([issue#27217](http://tracker.ceph.com/issues/27217),
    [pr#25498](https://github.com/ceph/ceph/pull/25498), Casey Bodley)
-   rgw: perfcounters: add gc retire counter
    ([pr#26351](https://github.com/ceph/ceph/pull/26351), Matt Benjamin)
-   rgw: permit rgw-admin to populate user info by access-key
    ([pr#28331](https://github.com/ceph/ceph/pull/28331), Matt Benjamin)
-   rgw: Policy should be url_decode when assume_role
    ([pr#28704](https://github.com/ceph/ceph/pull/28704), yuliyang)
-   rgw: prefix-delimiter listing: support \>1 character delimiter
    ([pr#26863](https://github.com/ceph/ceph/pull/26863), Matt Benjamin)
-   rgw: prevent bucket reshard scheduling if bucket is resharding
    ([pr#30610](https://github.com/ceph/ceph/pull/30610), J. Eric
    Ivancich)
-   rgw: prevent LC from reading stale head when transitioning object
    ([pr#31214](https://github.com/ceph/ceph/pull/31214), Ilsoo Byun)
-   rgw: project and return lc expiration from GET/HEAD and PUT ops
    ([pr#26160](https://github.com/ceph/ceph/pull/26160), Matt Benjamin)
-   rgw: Project Zipper - Bucket
    ([pr#31436](https://github.com/ceph/ceph/pull/31436), Daniel
    Gryniewicz)
-   rgw: Project Zipper - Bucketlist
    ([pr#30619](https://github.com/ceph/ceph/pull/30619), Daniel
    Gryniewicz)
-   rgw: Project Zipper part 1
    ([pr#28824](https://github.com/ceph/ceph/pull/28824), Daniel
    Gryniewicz)
-   rgw: qa/suite/rgw/verify: valgrind on centos again!
    ([pr#32727](https://github.com/ceph/ceph/pull/32727), Sage Weil)
-   rgw: qa/tasks/s3tests_java: move to gradle 6.0.1
    ([pr#32335](https://github.com/ceph/ceph/pull/32335), Sage Weil)
-   rgw: qa/tests: update s3a hadoop versions used for test
    ([pr#26100](https://github.com/ceph/ceph/pull/26100), Vasu Kulkarni)
-   rgw: qa: remove force-branch from overrides of s3-tests
    ([pr#32462](https://github.com/ceph/ceph/pull/32462), Ali Maredia)
-   rgw: qa: update s3-test download code for s3-test tasks
    ([pr#31839](https://github.com/ceph/ceph/pull/31839), Ali Maredia)
-   rgw: queue like an
    Egyptian([pr#26461](https://github.com/ceph/ceph/pull/26461),
    Adam C. Emerson)
-   rgw: race condition between resharding and ops waiting on resharding
    ([issue#38990](http://tracker.ceph.com/issues/38990),
    [pr#27223](https://github.com/ceph/ceph/pull/27223), J. Eric
    Ivancich)
-   rgw: radosgw-admin flush user stats output
    ([pr#30669](https://github.com/ceph/ceph/pull/30669), Abhishek
    Lekshmanan)
-   rgw: radosgw-admin zone placement rm and radosgw-admin zonegroup
    placement rm support \--storage-class
    ([pr#31239](https://github.com/ceph/ceph/pull/31239), yuliyang)
-   rgw: radosgw-admin: add \--uid check in bucket list command
    ([pr#30194](https://github.com/ceph/ceph/pull/30194), Vikhyat Umrao)
-   rgw: radosgw-admin: bucket sync status not caught up during full
    sync ([issue#40806](http://tracker.ceph.com/issues/40806),
    [pr#29094](https://github.com/ceph/ceph/pull/29094), Casey Bodley)
-   rgw: radosgw-admin: fix syncs_from in bucket sync status
    ([issue#40022](http://tracker.ceph.com/issues/40022),
    [pr#28243](https://github.com/ceph/ceph/pull/28243), Casey Bodley)
-   rgw: radosgw-admin: sync status displays id of shard furthest behind
    ([pr#32311](https://github.com/ceph/ceph/pull/32311), Casey Bodley)
-   rgw: radosgw-admin: update help for max-concurrent-ios
    ([pr#30742](https://github.com/ceph/ceph/pull/30742), Paul Emmerich)
-   rgw: reduce per-shard entry count during ordered bucket listing
    ([pr#30853](https://github.com/ceph/ceph/pull/30853), J. Eric
    Ivancich)
-   rgw: reject bucket tagging requests and document unsupported
    ([pr#26952](https://github.com/ceph/ceph/pull/26952), Casey Bodley)
-   rgw: relax es zone validity check
    ([pr#32290](https://github.com/ceph/ceph/pull/32290), jiahuizeng)
-   rgw: release unused callback argument
    ([pr#32669](https://github.com/ceph/ceph/pull/32669), Ilsoo Byun)
-   rgw: remove re-defined is_tagging_op in RGWHandler_REST_Bucket_S3
    ([pr#29004](https://github.com/ceph/ceph/pull/29004), zhang Shaowen)
-   rgw: remove unused bucket parameter in check_bucket_shards
    ([pr#31186](https://github.com/ceph/ceph/pull/31186), zhang Shaowen)
-   rgw: remove unused last_run in reshard thread entry
    ([pr#31150](https://github.com/ceph/ceph/pull/31150), zhangshaowen)
-   rgw: Replace COMPLETE_MULTIPART_MAX_LEN with rgw_max_put_param_size
    ([issue#38002](http://tracker.ceph.com/issues/38002),
    [pr#26070](https://github.com/ceph/ceph/pull/26070), Lei Liu)
-   rgw: replace direct calls to ioctx.operate()
    ([pr#28569](https://github.com/ceph/ceph/pull/28569), Ali Maredia)
-   rgw: ReplaceKeyPrefixWith and ReplaceKeyWith can not set at the same
    xe2x80xa6 ([pr#32609](https://github.com/ceph/ceph/pull/32609),
    yuliyang)
-   rgw: reshard list may return more than specified max_entries
    ([pr#31355](https://github.com/ceph/ceph/pull/31355), zhangshaowen)
-   rgw: rest client fixes for cloud sync XML outputs
    ([pr#27680](https://github.com/ceph/ceph/pull/27680), Abhishek
    Lekshmanan)
-   rgw: return error if lock log shard fails
    ([pr#31344](https://github.com/ceph/ceph/pull/31344), zhangshaowen)
-   rgw: return ERR_NO_SUCH_BUCKET early while evaluating bucket policy
    ([issue#38420](http://tracker.ceph.com/issues/38420),
    [pr#26569](https://github.com/ceph/ceph/pull/26569), Abhishek
    Lekshmanan)
-   rgw: rgw : Bucket mv, bucket chown and user rename utilities
    ([issue#35885](http://tracker.ceph.com/issues/35885),
    [issue#24348](http://tracker.ceph.com/issues/24348),
    [pr#28813](https://github.com/ceph/ceph/pull/28813), Shilpa
    Jagannath, Marcus Watts)
-   rgw: rgw admin: add tenant argument to reshard cancel
    ([pr#26887](https://github.com/ceph/ceph/pull/26887), Abhishek
    Lekshmanan)
-   rgw: rgw admin: disable stale instance delete in a multiste env
    ([pr#26852](https://github.com/ceph/ceph/pull/26852), Abhishek
    Lekshmanan)
-   rgw: rgw multisite: add perf counters to data sync
    ([issue#38549](http://tracker.ceph.com/issues/38549),
    [pr#26722](https://github.com/ceph/ceph/pull/26722), Casey Bodley)
-   rgw: rgw multisite: avoid writing bilog entries on PREPARE and
    CANCEL ([pr#26755](https://github.com/ceph/ceph/pull/26755), Casey
    Bodley)
-   rgw: rgw multisite: data sync checks empty next_marker for datalog
    ([issue#39033](http://tracker.ceph.com/issues/39033),
    [pr#27276](https://github.com/ceph/ceph/pull/27276), Casey Bodley)
-   rgw: rgw multisite: enforce spawn window for incremental data sync
    ([pr#32534](https://github.com/ceph/ceph/pull/32534), Casey Bodley)
-   rgw: rgw multisite: fixes for concurrent version creation
    ([pr#31325](https://github.com/ceph/ceph/pull/31325), Casey Bodley)
-   rgw: rgw/kafka: add ssl+sasl security to kafka
    ([pr#31834](https://github.com/ceph/ceph/pull/31834), Yuval
    Lifshitz)
-   rgw: rgw/multisite: Dont allow certain radosgw-admin commands to run
    on non-master zone
    ([issue#39548](http://tracker.ceph.com/issues/39548),
    [pr#28861](https://github.com/ceph/ceph/pull/28861), Shilpa
    Jagannath)
-   rgw: rgw/multisite: warn if bucket chown command is run on
    non-master zone
    ([pr#32932](https://github.com/ceph/ceph/pull/32932), Shilpa
    Jagannath)
-   rgw: rgw/multisite:RGWListBucketIndexesCR for data full sync
    pagination ([issue#39551](http://tracker.ceph.com/issues/39551),
    [pr#28146](https://github.com/ceph/ceph/pull/28146), Shilpa
    Jagannath)
-   rgw: rgw/notification: add opaque data
    ([pr#32723](https://github.com/ceph/ceph/pull/32723), Yuval
    Lifshitz)
-   rgw: rgw/pubsub: add kafka notification endpoint
    ([pr#30960](https://github.com/ceph/ceph/pull/30960), Yuval
    Lifshitz)
-   rgw: rgw/pubsub: fix doc on updates. fix multi-notifications
    ([pr#27931](https://github.com/ceph/ceph/pull/27931), Yuval
    Lifshitz, Casey Bodley)
-   rgw: rgw/pubsub: fix records/event json format to match
    documentation ([pr#31926](https://github.com/ceph/ceph/pull/31926),
    Yuval Lifshitz)
-   rgw: rgw/pubsub: handle subscription conf errors better
    ([pr#27530](https://github.com/ceph/ceph/pull/27530), Yuval
    Lifshitz)
-   rgw: rgw/pubsub: notification filtering by object tags
    ([pr#31878](https://github.com/ceph/ceph/pull/31878), Yuval
    Lifshitz)
-   rgw: rgw/pubsub: prevent kafka thread from spinning when there are
    no messages ([pr#31998](https://github.com/ceph/ceph/pull/31998),
    Yuval Lifshitz)
-   rgw: rgw/pubsub: send notifications from multi-delete op
    ([pr#32155](https://github.com/ceph/ceph/pull/32155), Yuval
    Lifshitz)
-   rgw: rgw/pubsub: service reordering issue
    ([pr#29877](https://github.com/ceph/ceph/pull/29877), Yuval
    Lifshitz)
-   rgw: rgw/rgw_client_io_filters.h: print size_t the portable way
    ([pr#28838](https://github.com/ceph/ceph/pull/28838), Kefu Chai)
-   rgw: rgw/rgw_crypt.cc: silence -Wsign-compare GCC warning
    ([pr#29151](https://github.com/ceph/ceph/pull/29151), Kefu Chai)
-   rgw: rgw/rgw_main: auto set radosgws cpu affinity according to
    numa_node configuration
    ([pr#31001](https://github.com/ceph/ceph/pull/31001), luo rixin)
-   rgw: rgw/rgw_op: Remove get_val from hotpath via legacy options
    ([pr#29943](https://github.com/ceph/ceph/pull/29943), Mark Nelson)
-   rgw: rgw/rgw_rados: set pg_autoscale_bias=4 for omap pools
    ([pr#27375](https://github.com/ceph/ceph/pull/27375), Sage Weil,
    Casey Bodley)
-   rgw: rgw/rgw_reshard: Dont dump RGWBucketReshard JSON in
    process_single_logshard
    ([pr#29894](https://github.com/ceph/ceph/pull/29894), Mark Nelson)
-   rgw: rgw/rgw_user: add \[\[maybe_unused\]\] for silencing
    -Wunused-variable waxe2x80xa6
    ([pr#30035](https://github.com/ceph/ceph/pull/30035), Kefu Chai)
-   rgw: rgw/services: silence -Wunused-variable warning
    ([pr#30063](https://github.com/ceph/ceph/pull/30063), Lan Liu)
-   rgw: RGW: add bucket permission verify when copy obj
    ([pr#29628](https://github.com/ceph/ceph/pull/29628), NancySu05)
-   rgw: RGW: fix an endless loop error when to show usage
    ([pr#30470](https://github.com/ceph/ceph/pull/30470), lvshuhua)
-   rgw: RGW: Set appropriate bucket quota value (when quota value is
    less than 0) ([pr#30920](https://github.com/ceph/ceph/pull/30920),
    GaryHyg)
-   rgw: RGW:Listobjectsv2
    ([pr#28102](https://github.com/ceph/ceph/pull/28102), Albin Antony)
-   rgw: RGWCoroutine::call(nullptr) sets retcode=0
    ([pr#29856](https://github.com/ceph/ceph/pull/29856), Casey Bodley)
-   rgw: rgwfile reqid: absorbs rgw_file: allocate new id for continued
    request #25664 ([issue#37734](http://tracker.ceph.com/issues/37734),
    [pr#28108](https://github.com/ceph/ceph/pull/28108), Matt Benjamin,
    Tao Chen)
-   rgw: RGWPeriodPusher uses zone system key for inter-zonegroup
    messages ([issue#39287](http://tracker.ceph.com/issues/39287),
    [pr#27576](https://github.com/ceph/ceph/pull/27576), Casey Bodley)
-   rgw: RGWSI_User_Module filters .buckets objects out of user listing
    ([pr#29695](https://github.com/ceph/ceph/pull/29695), Casey Bodley)
-   rgw: rgw_file: advance_mtime() should consider namespace expiration
    ([issue#40415](http://tracker.ceph.com/issues/40415),
    [pr#28632](https://github.com/ceph/ceph/pull/28632), Matt Benjamin)
-   rgw: rgw_file: all directories are virtual with respect to contents
    ([issue#40204](http://tracker.ceph.com/issues/40204),
    [pr#28451](https://github.com/ceph/ceph/pull/28451), Matt Benjamin)
-   rgw: rgw_file: avoid string::front() on empty path
    ([pr#32596](https://github.com/ceph/ceph/pull/32596), Matt Benjamin)
-   rgw: rgw_file: dont deadlock in advance_mtime()
    ([pr#29560](https://github.com/ceph/ceph/pull/29560), Matt Benjamin)
-   rgw: rgw_file: fix readdir eof() calc\--caller stop implies !eof
    ([issue#40375](http://tracker.ceph.com/issues/40375),
    [pr#28565](https://github.com/ceph/ceph/pull/28565), Matt Benjamin)
-   rgw: rgw_file: include tenant when hashing bucket names
    ([issue#40118](http://tracker.ceph.com/issues/40118),
    [pr#28370](https://github.com/ceph/ceph/pull/28370), Matt Benjamin)
-   rgw: rgw_file: introduce fast S3 Unix stats (immutable)
    ([issue#40456](http://tracker.ceph.com/issues/40456),
    [pr#28664](https://github.com/ceph/ceph/pull/28664), Matt Benjamin)
-   rgw: rgw_file: permit lookup_handle to lookup root_fh
    ([pr#28440](https://github.com/ceph/ceph/pull/28440), Matt Benjamin)
-   rgw: rgw_file: readdir: do not construct markers w/leading /
    ([pr#29670](https://github.com/ceph/ceph/pull/29670), Matt Benjamin)
-   rgw: rgw_file: save etag and acl info in setattr
    ([pr#26439](https://github.com/ceph/ceph/pull/26439), Tao Chen)
-   rgw: rgw_lc: use a new bl while encoding RGW_ATTR_LC
    ([pr#28049](https://github.com/ceph/ceph/pull/28049), Abhishek
    Lekshmanan)
-   rgw: rgw_sync: drop ENOENT error logs from mdlog
    ([pr#26908](https://github.com/ceph/ceph/pull/26908), Abhishek
    Lekshmanan)
-   rgw: s/std::map/boost::container::flat_map/ cls_bucket_list_ordered
    ([pr#28637](https://github.com/ceph/ceph/pull/28637), Matt Benjamin)
-   rgw: S3 compatible pubsub API
    ([pr#27091](https://github.com/ceph/ceph/pull/27091), Yuval
    Lifshitz)
-   rgw: s3: dont require a body in S3 put-object-acl
    ([pr#31987](https://github.com/ceph/ceph/pull/31987), Matt Benjamin)
-   rgw: save an unnecessary copy of RGWEnv
    ([pr#28426](https://github.com/ceph/ceph/pull/28426), Mark Kogan)
-   rgw: Select the std::bitset to resolv ambiguity
    ([pr#31126](https://github.com/ceph/ceph/pull/31126), Willem Jan
    Withagen)
-   rgw: set bucket attr twice when delete lifecycle config
    ([pr#30862](https://github.com/ceph/ceph/pull/30862), zhang Shaowen)
-   rgw: set correct storage class for append
    ([pr#31088](https://github.com/ceph/ceph/pull/31088), yuliyang)
-   rgw: set correct storage class for post object upload
    ([pr#30956](https://github.com/ceph/ceph/pull/30956), yuliyang)
-   rgw: set null version object acl issues
    ([issue#36763](http://tracker.ceph.com/issues/36763),
    [pr#25044](https://github.com/ceph/ceph/pull/25044), Tianshan Qu)
-   rgw: shard number must be non-negative when resharding the bucket
    ([pr#29037](https://github.com/ceph/ceph/pull/29037), zhang Shaowen)
-   rgw: silence a -Wunused-function warning in pubsu
    ([pr#27578](https://github.com/ceph/ceph/pull/27578), Casey Bodley)
-   rgw: Silence warning: control reaches end of non-void function
    ([issue#40747](http://tracker.ceph.com/issues/40747),
    [pr#28809](https://github.com/ceph/ceph/pull/28809), Jos Collin)
-   rgw: split mdlog/datalog trimming into separate files
    ([pr#27579](https://github.com/ceph/ceph/pull/27579), Casey Bodley)
-   rgw: sts: add all http args to req_info
    ([pr#31661](https://github.com/ceph/ceph/pull/31661), yuliyang)
-   rgw: support encoding-type param for list bucket multiparts
    ([pr#30993](https://github.com/ceph/ceph/pull/30993), Abhishek
    Lekshmanan)
-   rgw: support radosgw-admin zone/zonegroup placement get command
    ([pr#30880](https://github.com/ceph/ceph/pull/30880), jiahuizeng)
-   rgw: support specify user default placement and placement_tags when
    create or modify user
    ([pr#31185](https://github.com/ceph/ceph/pull/31185), yuliyang)
-   rgw: svc.bucket: assign to optional\<\> using =
    ([pr#32433](https://github.com/ceph/ceph/pull/32433), Kefu Chai)
-   rgw: swift: bugfix: <https://tracker.ceph.com/issues/37765>
    ([pr#25962](https://github.com/ceph/ceph/pull/25962), Andrey
    Groshev)
-   rgw: sync counters: drop spaces from counter names
    ([pr#27725](https://github.com/ceph/ceph/pull/27725), Abhishek
    Lekshmanan)
-   rgw: sync with elastic search v7
    ([pr#29637](https://github.com/ceph/ceph/pull/29637), Chang Liu)
-   rgw: TempURL should not allow PUTs with the X-Object-Manifest
    ([issue#20797](http://tracker.ceph.com/issues/20797),
    [pr#16659](https://github.com/ceph/ceph/pull/16659), Radoslaw
    Zarzynski)
-   rgw: test/rgw: fix test_rgw_reshard_wait with
    -DHAVE_BOOST_CONTEXT=OFF
    ([pr#32811](https://github.com/ceph/ceph/pull/32811), Yaakov
    Selkowitz)
-   rgw: test: modify iam tests to use a function to set bits
    ([pr#32808](https://github.com/ceph/ceph/pull/32808), Abhishek
    Lekshmanan)
-   rgw: tests: Fix building with -DWITH_BOOST_CONTEXT=OFF
    ([pr#29430](https://github.com/ceph/ceph/pull/29430), Ulrich
    Weigand)
-   rgw: the http response code of delete bucket should not be
    204-no-content ([pr#30471](https://github.com/ceph/ceph/pull/30471),
    Chang Liu)
-   rgw: Thread optional yield context through get_bucket_info call path
    ([pr#27898](https://github.com/ceph/ceph/pull/27898), Ali Maredia)
-   rgw: thread option_yield through bucket index transaction prepare
    ([pr#28152](https://github.com/ceph/ceph/pull/28152), Ali Maredia)
-   rgw: unexpected crash when creating bucket in librgw
    ([pr#26089](https://github.com/ceph/ceph/pull/26089), Tao CHEN)
-   rgw: update op_mask of user via admin rest api
    ([issue#39084](http://tracker.ceph.com/issues/39084),
    [pr#21154](https://github.com/ceph/ceph/pull/21154), Ning Yao)
-   rgw: update the hash source for multipart entries during resharding
    ([pr#32617](https://github.com/ceph/ceph/pull/32617), dongdong tao)
-   rgw: update the radosgw-admin reshard status
    ([issue#37615](http://tracker.ceph.com/issues/37615),
    [pr#25496](https://github.com/ceph/ceph/pull/25496), Mark Kogan)
-   rgw: updates to resharding documentation
    ([issue#39007](http://tracker.ceph.com/issues/39007),
    [pr#27250](https://github.com/ceph/ceph/pull/27250), J. Eric
    Ivancich)
-   rgw: url decode PutUserPolicy params
    ([pr#29578](https://github.com/ceph/ceph/pull/29578), Abhishek
    Lekshmanan)
-   rgw: url encode common prefixes for List Objects response
    ([pr#30970](https://github.com/ceph/ceph/pull/30970), Abhishek
    Lekshmanan)
-   rgw: usage dump_unsigned instead dump_int
    ([pr#28308](https://github.com/ceph/ceph/pull/28308), yuliyang)
-   rgw: usage dump_unsigned instead dump_int in
    dump_usage_categories_info
    ([pr#25808](https://github.com/ceph/ceph/pull/25808), yuliyang)
-   rgw: use bucket creation time from bucket instance info
    ([pr#32180](https://github.com/ceph/ceph/pull/32180), Yehuda Sadeh)
-   rgw: use explicit to_string() overload for boost::string_ref
    ([issue#39611](http://tracker.ceph.com/issues/39611),
    [pr#28013](https://github.com/ceph/ceph/pull/28013), Casey Bodley)
-   rgw: use new Stopped state for special handling of bucket sync
    disable ([pr#33054](https://github.com/ceph/ceph/pull/33054), Casey
    Bodley)
-   rgw: use STSEngine::authenticate when post upload with
    x_amz_security_token
    ([pr#31879](https://github.com/ceph/ceph/pull/31879), yuliyang)
-   rgw: use the compatibilty function for pthread_setname
    ([pr#27456](https://github.com/ceph/ceph/pull/27456), Willem Jan
    Withagen)
-   rgw: user policy: forward write requests to master zone
    ([pr#32476](https://github.com/ceph/ceph/pull/32476), Abhishek
    Lekshmanan)
-   rgw: vstart: move \[client.rgw\] config into \[client\]
    ([pr#29778](https://github.com/ceph/ceph/pull/29778), Casey Bodley)
-   rgw: vstart: only add \--debug-ms=1 in RGWDEBUG
    ([pr#27409](https://github.com/ceph/ceph/pull/27409), Casey Bodley)
-   rgw: warn on potential insecure mon connection
    ([pr#33777](https://github.com/ceph/ceph/pull/33777), Yehuda Sadeh)
-   rgw: when resharding store progress json
    ([pr#30575](https://github.com/ceph/ceph/pull/30575), Mark Kogan)
-   rgw: when you abort a multipart upload request, the quota may be not
    updated ([pr#29703](https://github.com/ceph/ceph/pull/29703),
    Richard Bai(xe7x99xbdxe5xadxa6xe4xbdx99))
-   rgw: Zipper - RGWUser
    ([pr#32298](https://github.com/ceph/ceph/pull/32298), Daniel
    Gryniewicz)
-   rgw: \[RFC\] rgw: raise default rgw_bucket_index_max_aio to 128
    ([pr#28558](https://github.com/ceph/ceph/pull/28558), Casey Bodley)
-   rgw: \[rgw\]:Validate bucket names as per revised s3 spec
    ([pr#26787](https://github.com/ceph/ceph/pull/26787), Soumya Koduri)
-   seastar,crimson: pickup change to pin socket to fixed core
    ([pr#32797](https://github.com/ceph/ceph/pull/32797), Kefu Chai)
-   seastar: pick up changes for better performance
    ([pr#28008](https://github.com/ceph/ceph/pull/28008), Kefu Chai)
-   seastar: pick up latest changes and cleanups
    ([pr#29942](https://github.com/ceph/ceph/pull/29942), Kefu Chai)
-   seastar: pick up the latest seastar
    ([pr#28709](https://github.com/ceph/ceph/pull/28709), Kefu Chai)
-   seastar: pickup change to fix cgroups V2 support
    ([pr#32978](https://github.com/ceph/ceph/pull/32978), Kefu Chai)
-   seastar: pickup the recent future optimizations
    ([pr#32296](https://github.com/ceph/ceph/pull/32296), Radoslaw
    Zarzynski)
-   seastar: pickup unix domain socket support
    ([pr#30578](https://github.com/ceph/ceph/pull/30578), Kefu Chai)
-   src/: silence GCC warnings
    ([pr#28684](https://github.com/ceph/ceph/pull/28684), Adam C.
    Emerson, Kefu Chai)
-   src/msg/async/net_handler.cc: Fix compilation
    ([pr#31637](https://github.com/ceph/ceph/pull/31637), Carlos
    Valiente)
-   src/script/kubejacker: Fix and simplify
    ([issue#39065](http://tracker.ceph.com/issues/39065),
    [pr#27292](https://github.com/ceph/ceph/pull/27292), Sebastian
    Wagner)
-   src/script: extract mypy config to mypy.ini
    ([pr#28264](https://github.com/ceph/ceph/pull/28264), Alfonso
    Martxc3xadnez)
-   src/telemetry: remove, now lives in ceph-telemetry.git
    ([pr#31170](https://github.com/ceph/ceph/pull/31170), Dan Mick)
-   src: polish the wording
    ([pr#33224](https://github.com/ceph/ceph/pull/33224), Jun Su)
-   stop.sh: add \--crimson option
    ([pr#28676](https://github.com/ceph/ceph/pull/28676), Kefu Chai)
-   stop.sh: do not try to contact mon unless cluster is up
    ([pr#32295](https://github.com/ceph/ceph/pull/32295), Kefu Chai)
-   support RDMA NIC without SRQ in msg/async/rdma
    ([pr#29947](https://github.com/ceph/ceph/pull/29947), Changcheng
    Liu, Roman Penyaev)
-   tasks/ceph_deploy: get rid of iteritems for python3
    ([pr#30791](https://github.com/ceph/ceph/pull/30791), Kyr Shatskyy)
-   telemetry: make server compensate for older mgr modules,
    elasticsearch ([pr#27802](https://github.com/ceph/ceph/pull/27802),
    Dan Mick)
-   test/crimson: fix interpretability with perf_async_msgr
    ([pr#28913](https://github.com/ceph/ceph/pull/28913), Yingxin Cheng)
-   tests,tools: ceph-objectstore-tool: call collection_bits() crashes
    on the meta colxe2x80xa6
    ([pr#31133](https://github.com/ceph/ceph/pull/31133), David Zafman)
-   tests,tools: ceph-objectstore-tool: set log date format
    ([pr#29297](https://github.com/ceph/ceph/pull/29297), Robert Church)
-   tests,tools: tools/ceph-dencoder: split types.h into smaller pieces
    ([issue#39595](http://tracker.ceph.com/issues/39595),
    [pr#28359](https://github.com/ceph/ceph/pull/28359), Kefu Chai)
-   tests,tools: tools/setup-virtualenv.sh: do not default to python2.7
    ([pr#30379](https://github.com/ceph/ceph/pull/30379), Nathan Cutler)
-   tests: add missing header cmath to
    test/mon/test_mon_memory_target.cc
    ([pr#30284](https://github.com/ceph/ceph/pull/30284), Su Yue)
-   tests: ceph-object-corpus: pick up 15.0.0-539-g191ab33faf
    ([pr#27867](https://github.com/ceph/ceph/pull/27867), Kefu Chai)
-   tests: cls/queue: add unit tests
    ([pr#33218](https://github.com/ceph/ceph/pull/33218), Yuval
    Lifshitz)
-   tests: corrected issues with RBD tests under EL8 distros
    ([pr#32684](https://github.com/ceph/ceph/pull/32684), Jason
    Dillaman)
-   tests: crimson/net: configure seastar to accept on a fixed core
    ([pr#32632](https://github.com/ceph/ceph/pull/32632), Yingxin Cheng)
-   tests: crimson/test: add CBT based perf tests
    ([pr#29612](https://github.com/ceph/ceph/pull/29612), Kefu Chai)
-   tests: crimson/test: v2 failover tests with crimson FailoverTestPeer
    ([pr#30162](https://github.com/ceph/ceph/pull/30162), Yingxin Cheng)
-   tests: crush, test: update editor variables
    ([pr#30537](https://github.com/ceph/ceph/pull/30537), Kefu Chai)
-   tests: fio_ceph_messenger: catch up v2 proto changes by using dummy
    auth ([pr#27264](https://github.com/ceph/ceph/pull/27264), Roman
    Penyaev)
-   tests: import-generated.sh: use PATH to get ceph-dencoder
    ([pr#27573](https://github.com/ceph/ceph/pull/27573), Changcheng
    Liu)
-   tests: introduce compiletest_cxx11_client for C++11 conformity
    ([pr#25395](https://github.com/ceph/ceph/pull/25395), Radoslaw
    Zarzynski)
-   tests: lvm/deactivate: add unit tests, remove \--all
    ([pr#32277](https://github.com/ceph/ceph/pull/32277), Jan Fajerski)
-   tests: mgr/dashboard: ability to provide custom credentials for E2E
    tests ([pr#33549](https://github.com/ceph/ceph/pull/33549), Alfonso
    Martxc3xadnez)
-   tests: mgr/dashboard: Add linter for unclosed HTML tags
    ([issue#40686](http://tracker.ceph.com/issues/40686),
    [pr#28916](https://github.com/ceph/ceph/pull/28916), Patrick
    Nawracay)
-   tests: mgr/dashboard: add python-common to \$PYTHONPATH
    ([pr#29525](https://github.com/ceph/ceph/pull/29525), Kefu Chai)
-   tests: mgr/dashboard: Added breadcrumb tests to Manager modules and
    Alerts menu ([pr#26853](https://github.com/ceph/ceph/pull/26853),
    Nathan Weinberg)
-   tests: mgr/dashboard: Added breadcrumb tests to NFS menu
    ([pr#26850](https://github.com/ceph/ceph/pull/26850), Nathan
    Weinberg)
-   tests: mgr/dashboard: Added breadcrumb tests to Object Gateway menu
    items ([pr#25451](https://github.com/ceph/ceph/pull/25451), Nathan
    Weinberg, Tiago Melo)
-   tests: mgr/dashboard: comment failing QA suites out
    ([pr#30864](https://github.com/ceph/ceph/pull/30864), Tatjana
    Dehler)
-   tests: mgr/dashboard: disable pylints \--py3k flag
    ([pr#30078](https://github.com/ceph/ceph/pull/30078), Ernesto
    Puerta)
-   tests: mgr/dashboard: E2E test to verify Configuration editing
    functionality ([pr#29216](https://github.com/ceph/ceph/pull/29216),
    Adam King, Rafael Quintero)
-   tests: mgr/dashboard: Explicitly type page variables
    ([pr#29324](https://github.com/ceph/ceph/pull/29324), Adam King,
    Rafael Quintero)
-   tests: mgr/dashboard: Fix e2e host test
    ([pr#30377](https://github.com/ceph/ceph/pull/30377), Tiago Melo)
-   tests: mgr/dashboard: fix existing issues in user integration tests
    ([pr#30789](https://github.com/ceph/ceph/pull/30789), Tatjana
    Dehler)
-   tests: mgr/dashboard: fix stray requests/error in Grafana unit test
    ([pr#33572](https://github.com/ceph/ceph/pull/33572), Patrick
    Seidensal)
-   tests: mgr/dashboard: fix tasks.mgr.dashboard.test_rgw suite
    ([pr#33426](https://github.com/ceph/ceph/pull/33426), Alfonso
    Martxc3xadnez)
-   tests: mgr/dashboard: fix tests in order to match pg num conventions
    ([pr#31906](https://github.com/ceph/ceph/pull/31906), Tatjana
    Dehler)
-   tests: mgr/dashboard: Improve e2e script
    ([pr#29101](https://github.com/ceph/ceph/pull/29101), Valentin
    Bajrami)
-   tests: mgr/dashboard: RBD Image Purge Trash, Move to Trash and
    Restore ([pr#29673](https://github.com/ceph/ceph/pull/29673), Adam
    King, Rafael Quintero)
-   tests: mgr/dashboard: reactivate dashboard test suites
    ([pr#32005](https://github.com/ceph/ceph/pull/32005), Tatjana
    Dehler)
-   tests: mgr/dashboard: Reduce code duplication through
    TableActionComponent UnitTests
    ([issue#40399](http://tracker.ceph.com/issues/40399),
    [pr#28633](https://github.com/ceph/ceph/pull/28633), Patrick
    Nawracay)
-   tests: mgr/dashboard: restore working directory after creating venv
    ([pr#32371](https://github.com/ceph/ceph/pull/32371), Kefu Chai)
-   tests: mgr/dashboard: RGW bucket E2E Tests
    ([pr#28999](https://github.com/ceph/ceph/pull/28999), Adam King,
    Rafael Quintero)
-   tests: mgr/dashboard: RGW user E2E Tests
    ([pr#29237](https://github.com/ceph/ceph/pull/29237), Adam King,
    Rafael Quintero)
-   tests: mgr/dashboard: take portal_ip_addresses as a list
    ([pr#28495](https://github.com/ceph/ceph/pull/28495), Kefu Chai)
-   tests: mgr/dashboard: Update formatting of e2e test files
    ([pr#29070](https://github.com/ceph/ceph/pull/29070), Adam King,
    Rafael Quintero)
-   tests: mgr/dashboard: Updated existing E2E tests to match new format
    ([pr#27408](https://github.com/ceph/ceph/pull/27408), Nathan
    Weinberg)
-   tests: mgr/dashboard: Verify fields on Configuration page
    ([pr#29583](https://github.com/ceph/ceph/pull/29583), Adam King,
    Rafael Quintero)
-   tests: mgr/dashboard: Verify fields on OSDs page
    ([pr#29447](https://github.com/ceph/ceph/pull/29447), Adam King,
    Rafael Quintero)
-   tests: mgr/dashboard: Wait for iSCSI target put and delete
    ([pr#30588](https://github.com/ceph/ceph/pull/30588), Ricardo
    Marques)
-   tests: mgr/dashboard: Write E2E tests for pool creation, deletion
    and verification
    ([issue#40693](http://tracker.ceph.com/issues/40693),
    [issue#38093](http://tracker.ceph.com/issues/38093),
    [pr#28928](https://github.com/ceph/ceph/pull/28928), Patrick
    Nawracay)
-   tests: mgr/orch: try harder when pickle fails to marshal an
    exception ([pr#33701](https://github.com/ceph/ceph/pull/33701), Kefu
    Chai)
-   tests: mgr/ssh: add make check integration
    ([pr#31523](https://github.com/ceph/ceph/pull/31523), Sebastian
    Wagner)
-   tests: mgr/tox: make run-tox.sh scripts more robust
    ([issue#39323](http://tracker.ceph.com/issues/39323),
    [pr#27614](https://github.com/ceph/ceph/pull/27614), Nathan Cutler)
-   tests: osd-backfill-space.sh test failed in
    TEST_backfill_multi_partial()
    ([issue#39333](http://tracker.ceph.com/issues/39333),
    [pr#27769](https://github.com/ceph/ceph/pull/27769), David Zafman)
-   tests: pybind/mgr: apply_drivegroups should return
    Sequence\[Completion\]
    ([pr#33977](https://github.com/ceph/ceph/pull/33977), Kefu Chai)
-   tests: python: pin mypy requirement to mypy==0.770
    ([pr#33926](https://github.com/ceph/ceph/pull/33926), Sebastian
    Wagner)
-   tests: qa.tests: added smoke suite to the schedule on mimic,nautilus
    ([pr#28479](https://github.com/ceph/ceph/pull/28479), Yuri
    Weinstein)
-   tests: qa/ceph-ansible: Disable dashboard
    ([pr#29916](https://github.com/ceph/ceph/pull/29916), Brad Hubbard)
-   tests: qa/ceph-ansible: Move to ansible 2.8
    ([issue#40602](http://tracker.ceph.com/issues/40602),
    [pr#28803](https://github.com/ceph/ceph/pull/28803), Brad Hubbard)
-   tests: qa/ceph-ansible: Move to Nautilus
    ([pr#27013](https://github.com/ceph/ceph/pull/27013), Brad Hubbard)
-   tests: qa/ceph-ansible: Replace pgs with pg_num
    ([issue#40605](http://tracker.ceph.com/issues/40605),
    [pr#28807](https://github.com/ceph/ceph/pull/28807), Brad Hubbard)
-   tests: qa/ceph-ansible: Upgrade ansible version
    ([pr#33379](https://github.com/ceph/ceph/pull/33379), Brad Hubbard)
-   tests: qa/cephadm/smoke: run on opensuse_15.1
    ([pr#33338](https://github.com/ceph/ceph/pull/33338), Nathan Cutler)
-   tests: qa/crontab/teuthology-cronjobs: fix suite-branch
    ([pr#27140](https://github.com/ceph/ceph/pull/27140), Neha Ojha)
-   tests: qa/distros/all: add openSUSE 15.1, drop openSUSE 12.2
    ([pr#30597](https://github.com/ceph/ceph/pull/30597), Nathan Cutler)
-   tests: qa/distros: add SLE-12-SP3 and SLE-15-SP1
    ([pr#31112](https://github.com/ceph/ceph/pull/31112), Nathan Cutler)
-   tests: qa/orchestrator: do not test mon update 3 host1
    ([pr#32023](https://github.com/ceph/ceph/pull/32023), Sage Weil,
    Kefu Chai)
-   tests: qa/standalone/ceph-helpers: resurrect all OSD before waiting
    for health ([pr#28328](https://github.com/ceph/ceph/pull/28328),
    Kefu Chai)
-   tests: qa/standalone/test_ceph_daemon: Fix ceph daemon standalone
    test ([pr#31440](https://github.com/ceph/ceph/pull/31440), Thomas
    Bechtold)
-   tests: qa/suites/krbd: fsx with object-map and fast-diff
    ([pr#32376](https://github.com/ceph/ceph/pull/32376), Ilya Dryomov)
-   tests: qa/suites/rados/cephadm/upgrade: add simple upgrade test
    ([pr#33343](https://github.com/ceph/ceph/pull/33343), Sage Weil)
-   tests: qa/suites/rados/cephadm: deploy all monitoring components
    ([pr#33785](https://github.com/ceph/ceph/pull/33785), Sage Weil)
-   tests: qa/suites/rados/perf/objectstore: do not symlink to
    qa/objectstore ([pr#30309](https://github.com/ceph/ceph/pull/30309),
    Neha Ojha)
-   tests: qa/suites/rados/perf: test min recommended osd_memory_target
    ([pr#30347](https://github.com/ceph/ceph/pull/30347), Neha Ojha)
-   tests: qa/suites/rados: whitelist POOL_APP_NOT_ENABLED warning
    ([pr#29763](https://github.com/ceph/ceph/pull/29763), Kefu Chai)
-   tests: qa/suites/upgrade/nautilus-x/parallel: restart mgr.x before
    mons ([pr#33705](https://github.com/ceph/ceph/pull/33705), Neha
    Ojha)
-   tests: qa/suites/upgrade: use correct branch names
    ([pr#27764](https://github.com/ceph/ceph/pull/27764), Neha Ojha)
-   tests: qa/suites: do not test luminous-x upgrade path
    ([pr#27112](https://github.com/ceph/ceph/pull/27112), Kefu Chai)
-   tests: qa/tasks/cbt.py: add support for client_endpoints
    ([pr#28522](https://github.com/ceph/ceph/pull/28522), Neha Ojha)
-   tests: qa/tasks/cbt.py: change port to work with client_endpoints
    ([pr#28442](https://github.com/ceph/ceph/pull/28442), Neha Ojha)
-   tests: qa/tasks/cbt.py: use git \--depth 1 for faster clone
    ([pr#29597](https://github.com/ceph/ceph/pull/29597), Kefu Chai)
-   tests: qa/tasks/ceph.py: quote \<kind\> in command line
    ([pr#33775](https://github.com/ceph/ceph/pull/33775), Kefu Chai)
-   tests: qa/tasks/ceph.py: remove unused variables
    ([pr#31005](https://github.com/ceph/ceph/pull/31005), Kefu Chai)
-   tests: qa/tasks/ceph2: add support for shell, packaged ceph-daemon
    ([pr#31891](https://github.com/ceph/ceph/pull/31891), Sage Weil)
-   tests: qa/tasks/cephfs_test_runner: setattr to class not instance
    ([pr#32571](https://github.com/ceph/ceph/pull/32571), Kefu Chai)
-   tests: qa/tasks/ceph_deploy: assume systemd and simplify shutdown
    wonkiness ([pr#29030](https://github.com/ceph/ceph/pull/29030), Sage
    Weil)
-   tests: qa/tasks/ceph_deploy: install python3.6 instead of python3.4
    for py3 tests ([pr#27504](https://github.com/ceph/ceph/pull/27504),
    Kefu Chai)
-   tests: qa/tasks/ceph_manager.py: ignore errors in test_pool_min_size
    ([issue#40533](http://tracker.ceph.com/issues/40533),
    [pr#28731](https://github.com/ceph/ceph/pull/28731), Kefu Chai)
-   tests: qa/tasks/ceph_manager: capture stderr for COT
    ([pr#33805](https://github.com/ceph/ceph/pull/33805), Kefu Chai)
-   tests: qa/tasks/ceph_manager: do not panic if pg_num_target is
    missing ([pr#30973](https://github.com/ceph/ceph/pull/30973), Kefu
    Chai)
-   tests: qa/tasks/ceph_manager: do not pick a pool is there is no
    pools ([pr#32519](https://github.com/ceph/ceph/pull/32519), Kefu
    Chai)
-   tests: qa/tasks/mgr/dashboard/test_health: add allow_unknown in
    mgr_map ([pr#30517](https://github.com/ceph/ceph/pull/30517), Kefu
    Chai)
-   tests: qa/tasks/mgr/dashboard/test_health: add missing field for
    test_full_health
    ([pr#29615](https://github.com/ceph/ceph/pull/29615), Kefu Chai)
-   tests: qa/tasks/mgr/dashboard/test_health: update schema
    ([pr#32122](https://github.com/ceph/ceph/pull/32122), Tatjana
    Dehler)
-   tests: qa/tasks/mgr/dashboard/test_mgr_module: sync w/ telemetry
    ([pr#29461](https://github.com/ceph/ceph/pull/29461), Kefu Chai)
-   tests: qa/tasks/mgr/dashboard: set pg_num to 16
    ([pr#32575](https://github.com/ceph/ceph/pull/32575), Kefu Chai)
-   tests: qa/tasks/mgr/test_orchestrator_cli: fix mon update test
    ([pr#32428](https://github.com/ceph/ceph/pull/32428), Kefu Chai)
-   tests: qa/tasks/mgr/test_orchestrator_cli: fix service action tests
    ([pr#32518](https://github.com/ceph/ceph/pull/32518), Kefu Chai)
-   tests: qa/tasks/mgr/test_orchestrator_cli: fix test_host_ls
    ([pr#33477](https://github.com/ceph/ceph/pull/33477), Sage Weil)
-   tests: qa/tasks/mgr/test_progress.py: fix bug in 9b4dbf0
    ([pr#29385](https://github.com/ceph/ceph/pull/29385), Kamoltat
    (Junior) Sirivadhna)
-   tests: qa/tasks/mgr/test_progress.py: s/ev/new_event/
    ([issue#40618](http://tracker.ceph.com/issues/40618),
    [pr#29368](https://github.com/ceph/ceph/pull/29368), Kefu Chai)
-   tests: qa/tasks/mgr: set mgr module option with \--force
    ([pr#32588](https://github.com/ceph/ceph/pull/32588), Kefu Chai)
-   tests: qa/tasks/vstart_runner: write string to StringIO
    ([pr#32438](https://github.com/ceph/ceph/pull/32438), Kefu Chai)
-   tests: qa/tasks: call super classs setUp()
    ([pr#33325](https://github.com/ceph/ceph/pull/33325), Kefu Chai)
-   tests: qa/tasks: py3 compat (tasks exercised by rados suites)
    ([pr#33709](https://github.com/ceph/ceph/pull/33709), Kyr Shatskyy,
    Kefu Chai)
-   tests: qa/tasks: use items() for py3 compatibility
    ([pr#30813](https://github.com/ceph/ceph/pull/30813), Kyr Shatskyy)
-   tests: qa/tests: filtered in only trusty
    ([issue#40195](http://tracker.ceph.com/issues/40195),
    [pr#28439](https://github.com/ceph/ceph/pull/28439), Yuri Weinstein)
-   tests: qa/tests: added mimic-x on master run
    ([pr#29428](https://github.com/ceph/ceph/pull/29428), Yuri
    Weinstein)
-   tests: qa/tests: added nautilus-p2p to cron
    ([pr#27218](https://github.com/ceph/ceph/pull/27218), Yuri
    Weinstein)
-   tests: qa/tests: added nautilus-x run
    ([pr#27252](https://github.com/ceph/ceph/pull/27252), Yuri
    Weinstein)
-   tests: qa/tests: added new client-upgrade-\\\*-nautilus suites for
    jewel, luminous, mimic
    ([pr#28067](https://github.com/ceph/ceph/pull/28067), Yuri
    Weinstein)
-   tests: qa/tests: added ragweed coverage to stress-split\\\* upgrade
    suites ([issue#40467](http://tracker.ceph.com/issues/40467),
    [issue#40452](http://tracker.ceph.com/issues/40452),
    [pr#28931](https://github.com/ceph/ceph/pull/28931), Yuri Weinstein)
-   tests: qa/tests: added ragweed coverage to stress-split\\\* upgrade
    suites ([issue#40467](http://tracker.ceph.com/issues/40467),
    [issue#40452](http://tracker.ceph.com/issues/40452),
    [pr#28932](https://github.com/ceph/ceph/pull/28932), Yuri Weinstein)
-   tests: qa/tests: added rgw into upgrade sequence to improve coverage
    ([pr#29406](https://github.com/ceph/ceph/pull/29406), Yuri
    Weinstein)
-   tests: qa/tests: reduced distro to run to be random
    ([pr#28435](https://github.com/ceph/ceph/pull/28435), Yuri
    Weinstein)
-   tests: qa/tests: reduced frequency for luminous and mimic runs
    ([pr#27057](https://github.com/ceph/ceph/pull/27057), Yuri
    Weinstein)
-   tests: qa/tests: removed all runs for luminous - EOL
    ([pr#33186](https://github.com/ceph/ceph/pull/33186), Yuri
    Weinstein)
-   tests: qa/tests: removed upgrade/client-upgrade-hammer becasue
    ubuntu 14.04 xe2x80xa6
    ([pr#28518](https://github.com/ceph/ceph/pull/28518), Yuri
    Weinstein)
-   tests: qa/tests: removed [1node]{.title-ref} and
    [systemd]{.title-ref} tests as ceph-deploy is not actively developed
    ([issue#40207](http://tracker.ceph.com/issues/40207),
    [issue#40208](http://tracker.ceph.com/issues/40208),
    [pr#28455](https://github.com/ceph/ceph/pull/28455), Yuri Weinstein)
-   tests: qa/valgrind.supp: generalize the whiterule for aes-128-gcm to
    help rgw suite ([issue#38827](http://tracker.ceph.com/issues/38827),
    [pr#28305](https://github.com/ceph/ceph/pull/28305), Radoslaw
    Zarzynski)
-   tests: qa/workunits/cephadm/test_cephadm: drop stray exit 0
    ([pr#32622](https://github.com/ceph/ceph/pull/32622), Sage Weil)
-   tests: qa/workunits/cephtool/test.sh: a handful fixes
    ([pr#31689](https://github.com/ceph/ceph/pull/31689), Kefu Chai)
-   tests: qa/workunits/mon/config.sh: sceph\|
    ([pr#27147](https://github.com/ceph/ceph/pull/27147), Kefu Chai)
-   tests: qa/workunits/rados/test_crash.sh: do not rm coredump
    ([pr#32883](https://github.com/ceph/ceph/pull/32883), Kefu Chai)
-   tests: qa/workunits/rados/test_envlibrados_for_rocksdb: accomodate
    rocksdb cxe2x80xa6
    ([pr#32143](https://github.com/ceph/ceph/pull/32143), Kefu Chai)
-   tests: qa/workunits/rados/test_envlibrados_for_rocksdb: install
    newer cmake ([pr#29584](https://github.com/ceph/ceph/pull/29584),
    Kefu Chai)
-   tests: qa/workunits/rados/test_librados_build.sh: download from
    current branch ([pr#31693](https://github.com/ceph/ceph/pull/31693),
    Kefu Chai)
-   tests: qa/workunits/rados/test_librados_build.sh: install build deps
    ([pr#28484](https://github.com/ceph/ceph/pull/28484), Kefu Chai)
-   tests: qa/workunits/rest: Better detection of rest url
    ([pr#26604](https://github.com/ceph/ceph/pull/26604), Brad Hubbard)
-   tests: qa: add .qa link
    ([pr#32363](https://github.com/ceph/ceph/pull/32363), Patrick
    Donnelly)
-   tests: qa: Add basic mypy support for the qa directory
    ([pr#32495](https://github.com/ceph/ceph/pull/32495), Thomas
    Bechtold)
-   tests: qa: add path to device output schema
    ([pr#32427](https://github.com/ceph/ceph/pull/32427), Kefu Chai)
-   tests: qa: add RHEL 7.7 and use as RHEL7 default
    ([pr#29908](https://github.com/ceph/ceph/pull/29908), Patrick
    Donnelly)
-   tests: qa: correct zap disk with ceph-deploy tool
    ([pr#31312](https://github.com/ceph/ceph/pull/31312), Changcheng
    Liu, Alfredo Deza)
-   tests: qa: distro helper symlinks
    ([pr#28371](https://github.com/ceph/ceph/pull/28371), Patrick
    Donnelly)
-   tests: qa: enable CRB repo for RHEL8
    ([pr#32426](https://github.com/ceph/ceph/pull/32426), Kefu Chai)
-   tests: qa: enable dashboard tests to be run with \--suite
    rados/dashboard
    ([pr#30434](https://github.com/ceph/ceph/pull/30434), Nathan Cutler)
-   tests: qa: Enable flake8 tox and fix failures
    ([pr#32129](https://github.com/ceph/ceph/pull/32129), Thomas
    Bechtold)
-   tests: qa: fix all the fsx.sh-invoking yaml files to install
    dependencies ([pr#33959](https://github.com/ceph/ceph/pull/33959),
    Greg Farnum)
-   tests: qa: fix lingering ceph-mgr-ssh -\> ceph-mgr-cephadm refs
    ([pr#32250](https://github.com/ceph/ceph/pull/32250), Sage Weil)
-   tests: qa: get rid of iterkeys for py3 compatibility
    ([pr#30873](https://github.com/ceph/ceph/pull/30873), Kyr Shatskyy)
-   tests: qa: kernel.sh: update for read-only changes
    ([pr#31773](https://github.com/ceph/ceph/pull/31773), Ilya Dryomov)
-   tests: qa: krbd_exclusive_option.sh: fixup for json.tool ordering
    change ([pr#32358](https://github.com/ceph/ceph/pull/32358), Ilya
    Dryomov)
-   tests: qa: krbd_exclusive_option.sh: update for recent kernel
    changes ([pr#32088](https://github.com/ceph/ceph/pull/32088), Ilya
    Dryomov)
-   tests: qa: rbd_workunit_suites_fsx: install build dependencies
    ([pr#33412](https://github.com/ceph/ceph/pull/33412), Ilya Dryomov)
-   tests: qa: run cephadm/smoke on opensuse 15.2 instead of 15.1
    ([pr#33535](https://github.com/ceph/ceph/pull/33535), Nathan Cutler)
-   tests: qa: update krbd tests for python3
    ([pr#31968](https://github.com/ceph/ceph/pull/31968), Ilya Dryomov)
-   tests: qa: update krbd_blkroset.t and add krbd_get_features.t
    ([pr#31771](https://github.com/ceph/ceph/pull/31771), Ilya Dryomov)
-   tests: qa: whitelist FS_DEGRADED
    ([pr#32549](https://github.com/ceph/ceph/pull/32549), Kefu Chai)
-   tests: remove spurious whitespace
    ([pr#33848](https://github.com/ceph/ceph/pull/33848), Milind
    Changire)
-   tests: Revert qa/tasks/cbt: include py2 deps on ubuntu for now
    ([pr#32512](https://github.com/ceph/ceph/pull/32512), Kefu Chai)
-   tests: script/run-cbt.sh: add support for ceph-osd testing
    ([pr#30811](https://github.com/ceph/ceph/pull/30811), Radoslaw
    Zarzynski)
-   tests: script/run-cbt.sh: always use python3
    ([pr#30321](https://github.com/ceph/ceph/pull/30321), Kefu Chai)
-   tests: script/run-cbt.sh: check option correctly
    ([pr#30287](https://github.com/ceph/ceph/pull/30287), Kefu Chai)
-   tests: script/run-cbt.sh: set fs.aio-max-nr for seastar
    ([pr#31667](https://github.com/ceph/ceph/pull/31667), Kefu Chai)
-   tests: script/run_mypy: Support mypy 0.740
    ([pr#31192](https://github.com/ceph/ceph/pull/31192), Sebastian
    Wagner)
-   tests: script/run_tox.sh: do not use python2 if we have python3
    ([pr#31751](https://github.com/ceph/ceph/pull/31751), Kefu Chai)
-   tests: selinux: Update the policy for RHEL8
    ([pr#28290](https://github.com/ceph/ceph/pull/28290), Boris Ranto)
-   tests: src/test, qa/suites/rados/thrash: add dedup test
    ([pr#28983](https://github.com/ceph/ceph/pull/28983), Myoungwon Oh)
-   tests: src/test/compressor: Add missing gtest
    ([pr#33731](https://github.com/ceph/ceph/pull/33731), Willem Jan
    Withagen)
-   tests: src/test: fix creating two different objects for testing
    chunked object ([issue#39282](http://tracker.ceph.com/issues/39282),
    [pr#27667](https://github.com/ceph/ceph/pull/27667), Myoungwon Oh)
-   tests: src/valgrind.supp: replace with the teuthologys file.
    Whitelist OpenSSL
    ([pr#27265](https://github.com/ceph/ceph/pull/27265), Radoslaw
    Zarzynski)
-   tests: tasks/ceph: drop testdir replacement in skeleton_config
    ([pr#30829](https://github.com/ceph/ceph/pull/30829), Kyr Shatskyy)
-   tests: tasks/ceph: get rid of iteritems for python3
    ([pr#30792](https://github.com/ceph/ceph/pull/30792), Kyr Shatskyy)
-   tests: test/bench_log: add usage function
    ([pr#31723](https://github.com/ceph/ceph/pull/31723), Xuqiang Chen)
-   tests: test/bufferlist.cc: encode/decode int64_t instead of long
    ([pr#29881](https://github.com/ceph/ceph/pull/29881), Alexandre
    Oliva)
-   tests: test/cli/ceph-conf: fix test
    ([pr#28818](https://github.com/ceph/ceph/pull/28818), Kefu Chai)
-   tests: test/cli: Make the ceph-conf test more liberal
    ([pr#29405](https://github.com/ceph/ceph/pull/29405), Willem Jan
    Withagen)
-   tests: test/common/test_util: skip it if /etc/os-release does not
    exist ([pr#27927](https://github.com/ceph/ceph/pull/27927), Kefu
    Chai)
-   tests: test/crimson/: use 256M mem and 1 cpu core for each test
    ([pr#29152](https://github.com/ceph/ceph/pull/29152), Kefu Chai)
-   tests: test/crimson/perf_async_msgr: remove unsued header file
    ([pr#28707](https://github.com/ceph/ceph/pull/28707), Jianpeng Ma)
-   tests: test/crimson: add acceptable section to tests
    ([pr#30315](https://github.com/ceph/ceph/pull/30315), Kefu Chai)
-   tests: test/crimson: add unit-test for ceph::net::Socket
    ([pr#28623](https://github.com/ceph/ceph/pull/28623), Yingxin Cheng)
-   tests: test/crimson: cbt test does rand-reads instead of seq-reads
    ([pr#30794](https://github.com/ceph/ceph/pull/30794), Radoslaw
    Zarzynski)
-   tests: test/crimson: fix a compiler error
    ([pr#27883](https://github.com/ceph/ceph/pull/27883), Jianpeng Ma)
-   tests: test/crimson: fix build of unittest_seastar_monc
    ([pr#27515](https://github.com/ceph/ceph/pull/27515), Kefu Chai,
    Yingxin Cheng)
-   tests: test/crimson: fix FTBFS
    ([pr#28902](https://github.com/ceph/ceph/pull/28902), Kefu Chai)
-   tests: test/crimson: fix msgr test of ref counter racing
    ([issue#36405](http://tracker.ceph.com/issues/36405),
    [pr#28362](https://github.com/ceph/ceph/pull/28362), Yingxin Cheng)
-   tests: test/crimson: implement a remote async TestPeer for crimson
    msgr tests ([pr#31156](https://github.com/ceph/ceph/pull/31156),
    Yingxin Cheng)
-   tests: test/crimson: improved perf_crimson_msgr with timer and
    sampled lat ([pr#28542](https://github.com/ceph/ceph/pull/28542),
    Yingxin Cheng)
-   tests: test/crimson: include writes in perf_crimson/async_server
    ([pr#27429](https://github.com/ceph/ceph/pull/27429), Yingxin Cheng)
-   tests: test/crimson: lower the bar for cbt test
    ([pr#30458](https://github.com/ceph/ceph/pull/30458), Kefu Chai)
-   tests: test/crimson: remove unittest_seastar_socket temporarily
    ([pr#32720](https://github.com/ceph/ceph/pull/32720), Kefu Chai)
-   tests: test/crimson: update to accomodate Dispatcher changes
    ([pr#27093](https://github.com/ceph/ceph/pull/27093), Kefu Chai)
-   tests: test/crimson: v2 failover tests with ack/keepalive
    ([pr#30803](https://github.com/ceph/ceph/pull/30803), Yingxin Cheng)
-   tests: test/crimson: verify msgr v2 behavior with different policies
    ([pr#30925](https://github.com/ceph/ceph/pull/30925), Yingxin Cheng)
-   tests: test/erasure-code: add exception handling to k & m
    ([pr#30087](https://github.com/ceph/ceph/pull/30087), Hang Li)
-   tests: test/fio/fio_ceph_messenger: make exec multi client on the
    same host ([pr#28464](https://github.com/ceph/ceph/pull/28464),
    Jianpeng Ma)
-   tests: test/fio: fix a compiler error
    ([pr#27880](https://github.com/ceph/ceph/pull/27880), Jianpeng Ma)
-   tests: test/fio: introduce fio ioengine: fio_ceph_messenger
    ([pr#24678](https://github.com/ceph/ceph/pull/24678), Roman Penyaev)
-   tests: test/kv_store_bench: Fix double free error
    ([pr#32439](https://github.com/ceph/ceph/pull/32439), Xuqiang Chen,
    luo rixin)
-   tests: test/librados: avoid residual crush rule after test case
    execution ([issue#40970](http://tracker.ceph.com/issues/40970),
    [pr#29341](https://github.com/ceph/ceph/pull/29341), Bingyi Zhang)
-   tests: test/librados: free AioCompletion using
    AioCompletion::release()
    ([pr#30204](https://github.com/ceph/ceph/pull/30204), Kefu Chai)
-   tests: test/librados: use GTEST_SKIP() to skip test
    ([pr#32770](https://github.com/ceph/ceph/pull/32770), Kefu Chai)
-   tests: test/msgr: fix ComplexTest fail when using DPDK protocal
    stack ([pr#31910](https://github.com/ceph/ceph/pull/31910), Chunsong
    Feng)
-   tests: test/msgr: make ceph_perf_msgr_client/server work
    ([pr#28842](https://github.com/ceph/ceph/pull/28842), Jianpeng Ma)
-   tests: test/objectstore: silence -Wsign-compare warning
    ([pr#27750](https://github.com/ceph/ceph/pull/27750), Kefu Chai)
-   tests: test/old: remove stale tests
    ([pr#29124](https://github.com/ceph/ceph/pull/29124), Kefu Chai)
-   tests: test/pybind/test_ceph_argparse.py: pg_num of pool creation
    now optional ([pr#30535](https://github.com/ceph/ceph/pull/30535),
    xie xingguo)
-   tests: test/python: remove stale tests
    ([pr#29413](https://github.com/ceph/ceph/pull/29413), Kefu Chai)
-   tests: test/TestOSDScrub: fix mktime() error
    ([pr#33430](https://github.com/ceph/ceph/pull/33430), luo rixin)
-   tests: test/test_socket: fix dispatch_sockets() unexpected exception
    ([pr#33482](https://github.com/ceph/ceph/pull/33482), luo rixin)
-   tests: test/test_weighted_shuffle: enlarge epsilon
    ([pr#27181](https://github.com/ceph/ceph/pull/27181), Kefu Chai)
-   tests: test/unittest_bluefs: always remove temp bdev file
    ([pr#29676](https://github.com/ceph/ceph/pull/29676), Kefu Chai)
-   tests: test/venv: do not hardwire to py2.7 for tox tests
    ([pr#29761](https://github.com/ceph/ceph/pull/29761), Willem Jan
    Withagen)
-   tests: test: Add flush_pg_stats to avoid race with getting
    num_shards_repaired
    ([pr#33776](https://github.com/ceph/ceph/pull/33776), David Zafman)
-   tests: test: Add [#include \<array\>]{.title-ref}
    ([pr#27455](https://github.com/ceph/ceph/pull/27455), Willem Jan
    Withagen)
-   tests: test: Allow fractional milliseconds to make test possible
    ([pr#30220](https://github.com/ceph/ceph/pull/30220), David Zafman)
-   tests: test: do not include unnecessary includes
    ([pr#30065](https://github.com/ceph/ceph/pull/30065), Kefu Chai)
-   tests: test: Do not test unicode if boost::spirit \>= 1.72
    ([pr#32388](https://github.com/ceph/ceph/pull/32388), Willem Jan
    Withagen)
-   tests: test: Expect being off by up to 2 and make sure all PGs are
    active+clean ([pr#33566](https://github.com/ceph/ceph/pull/33566),
    David Zafman)
-   tests: test: Fix failing ceph_objectstore_tool.py test
    ([pr#33593](https://github.com/ceph/ceph/pull/33593), David Zafman)
-   tests: test: Fix race with osd restart and doing a scru
    ([pr#32039](https://github.com/ceph/ceph/pull/32039), David Zafman)
-   tests: test: fix unused asserts variable in
    ceph_test_osd_stale_read.cc
    ([pr#32789](https://github.com/ceph/ceph/pull/32789), Radoslaw
    Zarzynski)
-   tests: test: Fix wait_for_state() to wait for a PG to get into a
    state ([pr#32628](https://github.com/ceph/ceph/pull/32628), David
    Zafman)
-   tests: test: Ignore OSD_SLOW_PING_TIME\\\* if injecting socket
    failures ([pr#30714](https://github.com/ceph/ceph/pull/30714), David
    Zafman)
-   tests: test: move bluestore dependent code under WITH_BLUESTORE
    ([pr#31335](https://github.com/ceph/ceph/pull/31335), Willem Jan
    Withagen)
-   tests: test: remove Dockerfile for centos7 and add Dockerfile for
    centos8 ([pr#33452](https://github.com/ceph/ceph/pull/33452), Kefu
    Chai)
-   tests: test: remove useless ASSERT_XXX macros for rgw test
    ([pr#30062](https://github.com/ceph/ceph/pull/30062), Zhi Zhang)
-   tests: test: silence warning unused variable nvme
    ([pr#33650](https://github.com/ceph/ceph/pull/33650), Jos Collin)
-   tests: test: Update pg log test for new trimming behavior
    ([pr#32945](https://github.com/ceph/ceph/pull/32945), David Zafman)
-   tests: use python3 compatible print
    ([pr#30758](https://github.com/ceph/ceph/pull/30758), Kyr Shatskyy)
-   tests: vstart.sh: Make sure mkdir succeeds
    ([pr#30005](https://github.com/ceph/ceph/pull/30005), Willem Jan
    Withagen)
-   test_alien_echo: update to use crimson:: namespace
    ([pr#31135](https://github.com/ceph/ceph/pull/31135), Samuel Just)
-   test_cephadm.sh: pass \--fsid to shell command
    ([pr#32389](https://github.com/ceph/ceph/pull/32389), Sage Weil)
-   test_cephadm: use container shell for ceph cmds
    ([pr#32627](https://github.com/ceph/ceph/pull/32627), Michael
    Fritch)
-   tools: add maxread in rados listomapkeys
    ([pr#30637](https://github.com/ceph/ceph/pull/30637), lvshuhua)
-   tools: adding ceph level immutable obj cache daemon
    ([pr#25545](https://github.com/ceph/ceph/pull/25545), Yuan Zhou,
    Dehao Shang)
-   tools: backport-create-issue: flush line before overprinting
    ([pr#31688](https://github.com/ceph/ceph/pull/31688), Nathan Cutler)
-   tools: backport-create-issue: read redmine key from file
    ([pr#31533](https://github.com/ceph/ceph/pull/31533), Tiago Melo)
-   tools: backport-create-issue: resolve parent if all backports
    resolved/rejected
    ([pr#30752](https://github.com/ceph/ceph/pull/30752), Nathan Cutler)
-   tools: backport-create-issue: resolve parent only if parent has
    backport issues
    ([pr#31753](https://github.com/ceph/ceph/pull/31753), Nathan Cutler)
-   tools: backport-resolve-issue: narrow regular expression and read
    key/token from files
    ([pr#31594](https://github.com/ceph/ceph/pull/31594), Nathan Cutler)
-   tools: backport-resolve-issue: populate tracker_description method
    ([pr#33105](https://github.com/ceph/ceph/pull/33105), Nathan Cutler)
-   tools: backport-resolve-issue: recognize that Target version is
    populated and prune duplicate URLs
    ([pr#31247](https://github.com/ceph/ceph/pull/31247), Nathan Cutler)
-   tools: backport-resolve-issue: resolve multiple backport issues
    ([pr#30988](https://github.com/ceph/ceph/pull/30988), Nathan Cutler)
-   tools: backport-resolve-issue: use Basic Authentication instead of
    access_token ([pr#33173](https://github.com/ceph/ceph/pull/33173),
    Nathan Cutler)
-   tools: build-integration-branch: dont fail on existing branch
    ([pr#33093](https://github.com/ceph/ceph/pull/33093), Sage Weil)
-   tools: build-integration-branch: take PRs in chronological order
    ([pr#31132](https://github.com/ceph/ceph/pull/31132), Nathan Cutler)
-   tools: ceph-backport.sh: allow user to specify \--fork explicitly
    ([pr#31734](https://github.com/ceph/ceph/pull/31734), Nathan Cutler)
-   tools: ceph-backport.sh: automate setting of milestone and component
    label, implement \--version option
    ([pr#30725](https://github.com/ceph/ceph/pull/30725), Nathan Cutler)
-   tools: ceph-backport.sh: cherry-pick individual commits
    ([pr#30097](https://github.com/ceph/ceph/pull/30097), Jan Fajerski)
-   tools: ceph-backport.sh: fix setup routine
    ([pr#33456](https://github.com/ceph/ceph/pull/33456), Nathan Cutler)
-   tools: ceph-backport.sh: guess component with \--existing-pr
    ([pr#31419](https://github.com/ceph/ceph/pull/31419), Nathan Cutler)
-   tools: ceph-backport.sh: implement \--milestones feature and
    more-careful vetting
    ([pr#30879](https://github.com/ceph/ceph/pull/30879), Nathan Cutler)
-   tools: ceph-backport.sh: implement interactive setup routine and new
    options ([pr#31366](https://github.com/ceph/ceph/pull/31366), Nathan
    Cutler)
-   tools: ceph-backport.sh: use Basic Authentication instead of
    access_token ([pr#33182](https://github.com/ceph/ceph/pull/33182),
    Nathan Cutler)
-   tools: ceph-conf: added \--show-config-value to usage
    ([pr#29981](https://github.com/ceph/ceph/pull/29981), James McClune)
-   tools: ceph-crash: use open(..,r) to read bytes for Python3
    ([issue#40781](http://tracker.ceph.com/issues/40781),
    [pr#29053](https://github.com/ceph/ceph/pull/29053), Dan Mick)
-   tools: ceph-daemon: ExecStart=/bin/bash script
    ([pr#31319](https://github.com/ceph/ceph/pull/31319), Sage Weil)
-   tools: ceph-daemon: fix typo in the output_pub_ssh_key argument
    ([pr#31337](https://github.com/ceph/ceph/pull/31337), John McGowan)
-   tools: ceph-daemon: Fix [ls]{.title-ref} cmd for legacy confs
    ([pr#31329](https://github.com/ceph/ceph/pull/31329), Michael
    Fritch)
-   tools: ceph-monstore-tool: print out caps when rebuilding monstore
    ([pr#27340](https://github.com/ceph/ceph/pull/27340), Kefu Chai)
-   tools: ceph-objectstore-tool: return 0 if incmap is sane
    ([pr#29704](https://github.com/ceph/ceph/pull/29704), Kefu Chai)
-   tools: ceph-objectstore-tool: update-mon-db: do not fail if incmap
    is missing ([pr#29571](https://github.com/ceph/ceph/pull/29571),
    Kefu Chai)
-   tools: ceph.in: fix verbose print
    ([pr#29486](https://github.com/ceph/ceph/pull/29486), luo.runbing)
-   tools: cls: add timeindex types to ceph-dencoder
    ([pr#27780](https://github.com/ceph/ceph/pull/27780), Abhishek
    Lekshmanan)
-   tools: github/codeowners: add ceph-volume
    ([pr#31883](https://github.com/ceph/ceph/pull/31883), Jan Fajerski)
-   tools: github: Add CODEOWNERs for designated code-owner reviews
    ([pr#29451](https://github.com/ceph/ceph/pull/29451), Ernesto
    Puerta)
-   tools: no-mon-config switch for ceph-objectstore-tool
    ([pr#26717](https://github.com/ceph/ceph/pull/26717), Igor Fedotov)
-   tools: pin the version of breathe that works with Python2
    ([pr#27721](https://github.com/ceph/ceph/pull/27721), Alfredo Deza)
-   tools: script/backport-create-issue: add \--resolve-parent feature
    ([pr#29904](https://github.com/ceph/ceph/pull/29904), Nathan Cutler)
-   tools: script/backport-create-issue: handle long Redmine issue names
    ([pr#27887](https://github.com/ceph/ceph/pull/27887), Nathan Cutler)
-   tools: script/backport-resolve-issue: better error message
    ([pr#30187](https://github.com/ceph/ceph/pull/30187), Nathan Cutler)
-   tools: script/backport-resolve-issue: handle tracker URLs better
    ([pr#29950](https://github.com/ceph/ceph/pull/29950), Nathan Cutler)
-   tools: script/ceph-backport-sh: add access_token parameter to all
    ghub api cxe2x80xa6
    ([pr#29261](https://github.com/ceph/ceph/pull/29261), Jan Fajerski)
-   tools: script/ceph-backport.sh: Add prepare function
    ([pr#28446](https://github.com/ceph/ceph/pull/28446), Tiago Melo)
-   tools: script/ceph-backport.sh: Allow to set component label
    ([pr#29318](https://github.com/ceph/ceph/pull/29318), Tiago Melo)
-   tools: script/ceph-backport.sh: allow user to specify remote repo
    ([pr#27233](https://github.com/ceph/ceph/pull/27233), Kefu Chai)
-   tools: script/ceph-backport.sh: carry https through to logical
    conclusion ([pr#29743](https://github.com/ceph/ceph/pull/29743),
    Nathan Cutler)
-   tools: script/ceph-backport.sh: Fix verification of git repository
    ([pr#30398](https://github.com/ceph/ceph/pull/30398), Tiago Melo)
-   tools: script/ceph-backport.sh: make the script idempotent
    ([pr#30106](https://github.com/ceph/ceph/pull/30106), Nathan Cutler)
-   tools: script/ceph-backport.sh: Use secure access for
    tracker.ceph.com
    ([pr#29438](https://github.com/ceph/ceph/pull/29438), Willem Jan
    Withagen)
-   tools: script/ceph-backport.sh: wholesale refactor
    ([pr#29957](https://github.com/ceph/ceph/pull/29957), Nathan Cutler)
-   tools: script/ceph-release-notes: alternate merge commit format
    ([pr#27281](https://github.com/ceph/ceph/pull/27281), Nathan Cutler)
-   tools: script/ptl-tool: update for python3
    ([pr#29095](https://github.com/ceph/ceph/pull/29095), Patrick
    Donnelly)
-   tools: script/run_mypy: Sort groups
    ([pr#28225](https://github.com/ceph/ceph/pull/28225), Sebastian
    Wagner)
-   tools: script/run_tox.sh: remove unused code
    ([pr#30386](https://github.com/ceph/ceph/pull/30386), Kefu Chai)
-   tools: script/sepia_bt.sh: remove stale script
    ([pr#29129](https://github.com/ceph/ceph/pull/29129), Kefu Chai)
-   tools: script: add backport-resolve-issue
    ([pr#29797](https://github.com/ceph/ceph/pull/29797), Nathan Cutler)
-   tools: script: enable nautilus in backport scripts
    ([pr#26973](https://github.com/ceph/ceph/pull/26973), Nathan Cutler)
-   tools: script: Obtain milestones via github API
    ([pr#27221](https://github.com/ceph/ceph/pull/27221), Lenz Grimmer)
-   tools: script: raw_input was renamed to input in py3
    ([pr#30346](https://github.com/ceph/ceph/pull/30346), Patrick
    Donnelly)
-   tools: scripts/kubejacker: Fix mgr_plugins target for centos
    ([pr#28078](https://github.com/ceph/ceph/pull/28078), Sebastian
    Wagner)
-   tools: scripts/run_mypy: add .gitignore
    ([pr#27118](https://github.com/ceph/ceph/pull/27118), Sebastian
    Wagner)
-   tools: scripts: use https url for redmine
    ([pr#29536](https://github.com/ceph/ceph/pull/29536), Patrick
    Donnelly)
-   tools: src/script/backport-create-issue: implement \--force option
    ([pr#30571](https://github.com/ceph/ceph/pull/30571), Nathan Cutler)
-   tools: src/script/check_commands.sh: fix grep regex class range
    ([pr#29161](https://github.com/ceph/ceph/pull/29161), Valentin
    Bajrami)
-   tools: src/script/unhexdump-C: script to reverse a hexdump -C style
    hexdump ([pr#29098](https://github.com/ceph/ceph/pull/29098), Sage
    Weil)
-   tools: stop.sh: use bash shell to solve syntax error
    ([pr#32263](https://github.com/ceph/ceph/pull/32263), luo rixin)
-   tools: tool/ceph-conf: s/global_pre_init()/global_init()/
    ([issue#7849](http://tracker.ceph.com/issues/7849),
    [pr#29058](https://github.com/ceph/ceph/pull/29058), Kefu Chai)
-   tools: tool: ceph_monstore_tool: \--readable=0 =\> \--readable
    ([pr#32265](https://github.com/ceph/ceph/pull/32265), simon gao)
-   tools: tools/ceph-kvstore-tool: print db stats
    ([pr#27162](https://github.com/ceph/ceph/pull/27162), Igor Fedotov)
-   tools: tools/osdmaptool.cc: do not use deprecated
    std::random_shuffle()
    ([pr#31990](https://github.com/ceph/ceph/pull/31990), Kefu Chai)
-   tools: tools/rados: update advisory lock break usage with
    \--lock-cookie required
    ([pr#31348](https://github.com/ceph/ceph/pull/31348), Zhi Zhang)
-   tools: vstart.sh: fix CEPH_PORT check and cleanups
    ([pr#26782](https://github.com/ceph/ceph/pull/26782), Changcheng
    Liu, Kefu Chai)
-   tools: vstart: add \--inc-osd option
    ([pr#30512](https://github.com/ceph/ceph/pull/30512), xie xingguo)
-   tools: vstart: add new option to pass list of block devices to
    bluestore ([pr#27518](https://github.com/ceph/ceph/pull/27518), Jeff
    Layton)
-   tools: vstart: fix error when getting CMake variables with the same
    prefix ([pr#31962](https://github.com/ceph/ceph/pull/31962), Kiefer
    Chang)
-   tools: vstart: fix run() invocation for rgw
    ([pr#28386](https://github.com/ceph/ceph/pull/28386), Casey Bodley)
-   Update grafana dashboards
    ([issue#39652](http://tracker.ceph.com/issues/39652),
    [pr#28043](https://github.com/ceph/ceph/pull/28043), Jan Fajerski)
-   vstart.sh: add an option to use crimson-osd
    ([pr#27108](https://github.com/ceph/ceph/pull/27108), chunmei Liu,
    Kefu Chai)
-   vstart.sh: correct ceph-run path
    ([pr#27968](https://github.com/ceph/ceph/pull/27968), Changcheng
    Liu)
-   vstart.sh: fix install of cephadm ssh keys from \~/.ssh
    ([pr#33647](https://github.com/ceph/ceph/pull/33647), Sage Weil)
-   vstart.sh: Fix problem that all extra_conf got merged into single
    line ([pr#28586](https://github.com/ceph/ceph/pull/28586), Adam
    Kupczyk)
-   vstart.sh: move extra_seastar_args up in vstart.sh
    ([pr#32366](https://github.com/ceph/ceph/pull/32366), Chunmei Liu)
-   vstart.sh: unify the indent
    ([pr#27995](https://github.com/ceph/ceph/pull/27995), Kefu Chai,
    Richael Zhuang)
-   vstart_runner: split unicode arguments into lists
    ([pr#28561](https://github.com/ceph/ceph/pull/28561), Rishabh Dave)

# Nautilus

Nautilus is the 14th stable release of Ceph. It is named after the
nautilus, a family of cephalopods characterized by a whorled shell.

## v14.2.22 Nautilus

This is the 22nd and likely the last backport release in the Nautilus
series. Ultimately, we recommend all users upgrade to newer Ceph
releases.

### Notable Changes

-   This release sets `bluefs_buffered_io` to true by default to improve
    performance for metadata heavy workloads. Enabling this option has
    been reported to occasionally cause excessive kernel swapping under
    certain workloads. Currently, the most consistent performing
    combination is to enable bluefs_buffered_io and disable system level
    swap.
-   The default value of `bluestore_cache_trim_max_skip_pinned` has been
    increased to 1000 to control memory growth due to onodes.
-   Several other bug fixes in BlueStore, including a fix for an
    unexpected ENOSPC bug in Avl/Hybrid allocators.
-   The trimming logic in the monitor has been made dynamic, with the
    introduction of `paxos_service_trim_max_multiplier`, a factor by
    which `paxos_service_trim_max` is multiplied to make trimming
    faster, when required. Setting it to 0 disables the upper bound
    check for trimming and makes the monitors trim at the maximum rate.
-   A `--max <n>` option is available with the `osd ok-to-stop` command
    to provide up to N OSDs that can be stopped together without making
    PGs unavailable.
-   OSD: the option `osd_fast_shutdown_notify_mon` has been introduced
    to allow the OSD to notify the monitor it is shutting down even if
    `osd_fast_shutdown` is enabled. This helps with the monitor logs on
    larger clusters, that may get many \'osd.X reported immediately
    failed by osd.Y\' messages, and confuse tools.
-   A long-standing bug that prevented 32-bit and 64-bit client/server
    interoperability under msgr v2 has been fixed. In particular, mixing
    armv7l (armhf) and x86_64 or aarch64 servers in the same cluster now
    works.

### Changelog

-   PendingReleaseNotes: note about 14.2.18 mgr fixes
    ([pr#40121](https://github.com/ceph/ceph/pull/40121), Josh Durgin)
-   bind on loopback address if no other addresses are available
    ([pr#41137](https://github.com/ceph/ceph/pull/41137), Kefu Chai,
    Matthew Oliver)
-   build python extensions using distutils
    ([pr#41167](https://github.com/ceph/ceph/pull/41167), Kefu Chai)
-   ceph-monstore-tool: use a large enough paxos/{first,last}\_committed
    ([issue#38219](http://tracker.ceph.com/issues/38219),
    [pr#41874](https://github.com/ceph/ceph/pull/41874), Kefu Chai)
-   ceph-volume: disable cache for blkid calls
    ([pr#41114](https://github.com/ceph/ceph/pull/41114), Rafał
    Wądołowski)
-   ceph-volume: fix batch report and respect ceph.conf config values
    ([pr#41716](https://github.com/ceph/ceph/pull/41716), Andrew Schoen)
-   ceph-volume: fix batch report and respect ceph.conf config values
    ([pr#41713](https://github.com/ceph/ceph/pull/41713), Andrew Schoen)
-   ceph-volume: implement bluefs volume migration
    ([pr#41676](https://github.com/ceph/ceph/pull/41676), Kefu Chai,
    Igor Fedotov)
-   ceph.spec.in: Enable tcmalloc on IBM Power and Z
    ([pr#40283](https://github.com/ceph/ceph/pull/40283), Nathan Cutler,
    Yaakov Selkowitz)
-   cephfs: client: add ability to lookup snapped inodes by inode number
    ([pr#40769](https://github.com/ceph/ceph/pull/40769), Jeff Layton,
    Xiubo Li)
-   cephfs: client: only check pool permissions for regular files
    ([pr#40730](https://github.com/ceph/ceph/pull/40730), Xiubo Li)
-   cephfs: client: wake up the front pos waiter
    ([pr#40865](https://github.com/ceph/ceph/pull/40865), Xiubo Li)
-   client: Fix executeable access check for the root user
    ([pr#41297](https://github.com/ceph/ceph/pull/41297), Kotresh HR)
-   client: fire the finish_cap_snap() after buffer being flushed
    ([pr#40722](https://github.com/ceph/ceph/pull/40722), Xiubo Li)
-   cls/rgw: look for plain entries in non-ascii plain namespace too
    ([pr#41776](https://github.com/ceph/ceph/pull/41776), Mykola Golub)
-   cmake,zstd,debian: allow use libzstd in system
    ([pr#40516](https://github.com/ceph/ceph/pull/40516), Kefu Chai,
    Bryan Stillwell, Dan van der Ster)
-   cmake: build static libs if they are internal ones
    ([pr#39903](https://github.com/ceph/ceph/pull/39903), Kefu Chai)
-   cmake: detect gettid() presense
    ([pr#40333](https://github.com/ceph/ceph/pull/40333), Igor Fedotov)
-   cmake: set empty RPATH for some test executables
    ([pr#40619](https://github.com/ceph/ceph/pull/40619), Nathan Cutler,
    Kefu Chai)
-   common/buffer: adjust align before calling posix_memalign()
    ([pr#41246](https://github.com/ceph/ceph/pull/41246), Ilya Dryomov)
-   common/ipaddr: skip loopback interfaces named \'lo\' and test it
    ([pr#40423](https://github.com/ceph/ceph/pull/40423), Dan van der
    Ster)
-   common/mempool: only fail tests if sharding is very bad
    ([pr#40567](https://github.com/ceph/ceph/pull/40567), singuliere)
-   common/options/global.yaml.in: increase default value of
    bluestore_cache_trim_max_skip_pinned
    ([pr#40920](https://github.com/ceph/ceph/pull/40920), Neha Ojha)
-   common/options: bluefs_buffered_io=true by default
    ([pr#40393](https://github.com/ceph/ceph/pull/40393), Dan van der
    Ster)
-   common: Fix assertion when disabling and re-enabling
    clog_to_monitors
    ([pr#39912](https://github.com/ceph/ceph/pull/39912), Gerald Yang)
-   common: remove log_early configuration option
    ([pr#40549](https://github.com/ceph/ceph/pull/40549), Changcheng
    Liu)
-   crush/CrushLocation: do not print logging message in constructor
    ([pr#40750](https://github.com/ceph/ceph/pull/40750), Alex Wu)
-   crush/CrushWrapper: update shadow trees on update_item()
    ([pr#39920](https://github.com/ceph/ceph/pull/39920), Sage Weil)
-   debian/ceph-common.postinst: do not chown cephadm log dirs
    ([pr#40698](https://github.com/ceph/ceph/pull/40698), Sage Weil)
-   debian/control: add missing commas, use python3 packages for \"make
    check\" on focal
    ([pr#40485](https://github.com/ceph/ceph/pull/40485), Kefu Chai,
    Alfredo Deza)
-   install-deps.sh: remove existing ceph-libboost of different version
    ([pr#40287](https://github.com/ceph/ceph/pull/40287), Kefu Chai)
-   libcephfs: ignore restoring the open files limit
    ([pr#41593](https://github.com/ceph/ceph/pull/41593), Xiubo Li)
-   librbd: allow interrupted trash move request to be restarted
    ([pr#40675](https://github.com/ceph/ceph/pull/40675), Jason
    Dillaman)
-   librbd: don\'t stop at the first unremovable image when purging
    ([pr#41662](https://github.com/ceph/ceph/pull/41662), Ilya Dryomov)
-   librbd: fix sporadic failures in TestMigration.StressLive
    ([pr#41788](https://github.com/ceph/ceph/pull/41788), Jason
    Dillaman)
-   librbd: race when disabling object map with overlapping in-flight
    writes ([pr#41787](https://github.com/ceph/ceph/pull/41787), Jason
    Dillaman)
-   make-dist: refuse to run if script path contains a colon
    ([pr#41088](https://github.com/ceph/ceph/pull/41088), Nathan Cutler)
-   mds: do not trim the inodes from the lru list in standby_replay
    ([pr#41144](https://github.com/ceph/ceph/pull/41144), Xiubo Li)
-   mds: fix race of fetching large dirfrag
    ([pr#40720](https://github.com/ceph/ceph/pull/40720), Erqi Chen)
-   mds: send scrub status to ceph-mgr only when scrub is running
    ([issue#45349](http://tracker.ceph.com/issues/45349),
    [pr#36183](https://github.com/ceph/ceph/pull/36183), Kefu Chai,
    Venky Shankar)
-   mds: trim cache regularly for standby-replay
    ([pr#40744](https://github.com/ceph/ceph/pull/40744), Patrick
    Donnelly)
-   mgr/ActivePyModules.cc: always release GIL before attempting to
    acquire a lock ([pr#40047](https://github.com/ceph/ceph/pull/40047),
    Kefu Chai)
-   mgr/Dashboard: Remove erroneous elements in hosts-overview Grafana
    dashboard ([pr#41650](https://github.com/ceph/ceph/pull/41650),
    Malcolm Holmes)
-   mgr/PyModule: put mgr_module_path before Py_GetPath()
    ([pr#40753](https://github.com/ceph/ceph/pull/40753), Kefu Chai)
-   mgr/dashboard: Fix for alert notification message being undefined
    ([pr#40590](https://github.com/ceph/ceph/pull/40590), Nizamudeen A)
-   mgr/dashboard: Fix missing root path of each session for CephFS
    ([pr#39869](https://github.com/ceph/ceph/pull/39869), Yongseok Oh)
-   mgr/dashboard: Monitoring alert badge includes suppressed alerts
    ([pr#39511](https://github.com/ceph/ceph/pull/39511), Aashish
    Sharma)
-   mgr/dashboard: Remove username, password fields from Manager
    Modules/dashboard,influx
    ([pr#40490](https://github.com/ceph/ceph/pull/40490), Aashish
    Sharma)
-   mgr/dashboard: Revoke read-only user\'s access to Manager modules
    ([pr#40650](https://github.com/ceph/ceph/pull/40650), Nizamudeen A)
-   mgr/dashboard: debug nodeenv hangs
    ([pr#40818](https://github.com/ceph/ceph/pull/40818), Ernesto
    Puerta)
-   mgr/dashboard: decouple unit tests from build artifacts
    ([pr#40547](https://github.com/ceph/ceph/pull/40547), Alfonso
    Martínez)
-   mgr/dashboard: encode non-ascii string before passing it to
    exec_cmd() ([pr#40522](https://github.com/ceph/ceph/pull/40522),
    Kefu Chai)
-   mgr/dashboard: filesystem pool size should use stored stat
    ([pr#41021](https://github.com/ceph/ceph/pull/41021), Avan Thakkar)
-   mgr/dashboard: fix API docs link
    ([pr#41521](https://github.com/ceph/ceph/pull/41521), Avan Thakkar)
-   mgr/dashboard: fix OSDs Host details/overview grafana graphs
    ([issue#49769](http://tracker.ceph.com/issues/49769),
    [pr#41531](https://github.com/ceph/ceph/pull/41531), Alfonso
    Martínez, Michael Wodniok)
-   mgr/dashboard: fix base-href: revert it to previous approach
    ([pr#41253](https://github.com/ceph/ceph/pull/41253), Avan Thakkar)
-   mgr/dashboard: fix bucket objects and size calculations
    ([pr#41648](https://github.com/ceph/ceph/pull/41648), Avan Thakkar)
-   mgr/dashboard: fix dashboard instance ssl certificate functionality
    ([pr#40003](https://github.com/ceph/ceph/pull/40003), Avan Thakkar)
-   mgr/dashboard: grafana panels for rgw multisite sync performance
    ([pr#41386](https://github.com/ceph/ceph/pull/41386), Alfonso
    Martínez)
-   mgr/dashboard: python 2: fix error when non-ASCII password
    ([pr#40610](https://github.com/ceph/ceph/pull/40610), Alfonso
    Martínez)
-   mgr/dashboard: report mgr fsid
    ([pr#39853](https://github.com/ceph/ceph/pull/39853), Ernesto
    Puerta)
-   mgr/dashboard: show partially deleted RBDs
    ([pr#41738](https://github.com/ceph/ceph/pull/41738), Tatjana
    Dehler)
-   mgr/dashboard: test prometheus rules through promtool
    ([pr#39984](https://github.com/ceph/ceph/pull/39984), Aashish
    Sharma, Kefu Chai)
-   mgr/progress: ensure progress stays between \[0,1\]
    ([pr#41310](https://github.com/ceph/ceph/pull/41310), Dan van der
    Ster)
-   mgr/telemetry: check if \'ident\' channel is active
    ([pr#39923](https://github.com/ceph/ceph/pull/39923), Yaarit Hatuka)
-   mgr/telemetry: pass leaderboard flag even w/o ident
    ([pr#41839](https://github.com/ceph/ceph/pull/41839), Sage Weil)
-   mgr/volumes: Retain suid guid bits in clone
    ([pr#40270](https://github.com/ceph/ceph/pull/40270), Kotresh HR)
-   mgr: add \--max \<n\> to \'osd ok-to-stop\' command
    ([pr#40676](https://github.com/ceph/ceph/pull/40676), Sage Weil,
    Xuehan Xu)
-   mgr: add mon metada using type of \"mon\"
    ([pr#40359](https://github.com/ceph/ceph/pull/40359), Kefu Chai)
-   mon/ConfigMap: fix stray option leak
    ([pr#40299](https://github.com/ceph/ceph/pull/40299), Sage Weil)
-   mon/MonClient: reset authenticate_err in \_reopen_session()
    ([pr#41016](https://github.com/ceph/ceph/pull/41016), Ilya Dryomov)
-   mon/MonClient: tolerate a rotating key that is slightly out of date
    ([pr#41448](https://github.com/ceph/ceph/pull/41448), Ilya Dryomov)
-   mon/OSDMonitor: drop stale failure_info after a grace period
    ([pr#41213](https://github.com/ceph/ceph/pull/41213), Kefu Chai)
-   mon/OSDMonitor: drop stale failure_info even if can_mark_down()
    ([pr#41519](https://github.com/ceph/ceph/pull/41519), Kefu Chai)
-   mon: Modifying trim logic to change paxos_service_trim_max
    dynamically ([pr#41099](https://github.com/ceph/ceph/pull/41099),
    Aishwarya Mathuria)
-   mon: ensure progress is \[0,1\] before printing
    ([pr#41098](https://github.com/ceph/ceph/pull/41098), Dan van der
    Ster)
-   mon: load stashed map before mkfs monmap
    ([pr#41762](https://github.com/ceph/ceph/pull/41762), Dan van der
    Ster)
-   monmaptool: Don\'t call set_port on an invalid address
    ([pr#40700](https://github.com/ceph/ceph/pull/40700), Brad Hubbard,
    Kefu Chai)
-   os/FileStore: don\'t propagate split/merge error to
    \"create\"/\"remove\"
    ([pr#40987](https://github.com/ceph/ceph/pull/40987), Mykola Golub)
-   os/FileStore: fix to handle readdir error correctly
    ([pr#41238](https://github.com/ceph/ceph/pull/41238), Misono
    Tomohiro)
-   os/bluestore/BlueFS: do not \_flush_range deleted files
    ([pr#40752](https://github.com/ceph/ceph/pull/40752), weixinwei)
-   os/bluestore/BlueFS: use iterator_impl::copy instead of
    bufferlist::c_str() to avoid bufferlist rebuild
    ([pr#39883](https://github.com/ceph/ceph/pull/39883), weixinwei)
-   os/bluestore: be more verbose in \_open_super_meta by default
    ([pr#41060](https://github.com/ceph/ceph/pull/41060), Igor Fedotov)
-   os/bluestore: do not count pinned entries as trimmed ones
    ([pr#41173](https://github.com/ceph/ceph/pull/41173), Igor Fedotov)
-   os/bluestore: fix unexpected ENOSPC in Avl/Hybrid allocators
    ([pr#41673](https://github.com/ceph/ceph/pull/41673), Igor Fedotov)
-   os/bluestore: introduce multithireading sync for bluestore\'s
    repairer ([pr#41749](https://github.com/ceph/ceph/pull/41749), Igor
    Fedotov)
-   os/bluestore: tolerate zero length for allocators\'
    init\_\[add/rm\]\_free()
    ([pr#41750](https://github.com/ceph/ceph/pull/41750), Igor Fedotov)
-   osd/PG.cc: handle removal of pgmeta object
    ([pr#41682](https://github.com/ceph/ceph/pull/41682), Neha Ojha)
-   osd/PeeringState: fix acting_set_writeable min_size check
    ([pr#41611](https://github.com/ceph/ceph/pull/41611), Dan van der
    Ster)
-   osd: add osd_fast_shutdown_notify_mon option (default false)
    ([issue#46978](http://tracker.ceph.com/issues/46978),
    [pr#40014](https://github.com/ceph/ceph/pull/40014), Mauricio Faria
    de Oliveira)
-   osd: compute OSD\'s space usage ratio via raw space utilization
    ([pr#41111](https://github.com/ceph/ceph/pull/41111), Igor Fedotov)
-   osd: do not dump an osd multiple times
    ([pr#40747](https://github.com/ceph/ceph/pull/40747), Xue Yantao)
-   pybind/ceph_daemon: do not fail if prettytable is not available
    ([pr#40335](https://github.com/ceph/ceph/pull/40335), Kefu Chai)
-   pybind/cephfs: DT_REG and DT_LNK values are wrong
    ([pr#40704](https://github.com/ceph/ceph/pull/40704), Varsha Rao)
-   pybind/mgr/balancer/module.py: assign weight-sets to all buckets
    before balancing
    ([pr#40128](https://github.com/ceph/ceph/pull/40128), Neha Ojha)
-   pybind/mgr/volumes: deadlock on async job hangs finisher thread
    ([pr#41394](https://github.com/ceph/ceph/pull/41394), Patrick
    Donnelly)
-   pybind/rados: should pass \"name\" to cstr()
    ([pr#41318](https://github.com/ceph/ceph/pull/41318), Kefu Chai)
-   pybind: volume_client handle purge of directory names encoded in
    utf-8 ([pr#36679](https://github.com/ceph/ceph/pull/36679), Jose
    Castro Leon)
-   qa/tasks/mgr/test_progress: fix wait_until_equal
    ([pr#39397](https://github.com/ceph/ceph/pull/39397), Kamoltat,
    Ricardo Dias)
-   qa/tasks/qemu: precise repos have been archived
    ([pr#41641](https://github.com/ceph/ceph/pull/41641), Ilya Dryomov)
-   qa/tasks/vstart_runner.py: start max required mgrs
    ([pr#40751](https://github.com/ceph/ceph/pull/40751), Alfonso
    Martínez)
-   qa/tests: added client-upgrade-nautilus-pacific tests
    ([pr#39818](https://github.com/ceph/ceph/pull/39818), Yuri
    Weinstein)
-   qa/tests: advanced nautilus initial version to 14.2.20
    ([pr#41227](https://github.com/ceph/ceph/pull/41227), Yuri
    Weinstein)
-   qa/upgrade: disable update_features test_notify with older client as
    lockowner ([pr#41513](https://github.com/ceph/ceph/pull/41513),
    Deepika Upadhyay)
-   qa: add sleep for blocklisting to take effect
    ([pr#40714](https://github.com/ceph/ceph/pull/40714), Patrick
    Donnelly)
-   qa: bump osd heartbeat grace for ffsb workload
    ([pr#40713](https://github.com/ceph/ceph/pull/40713), Nathan Cutler)
-   qa: delete all fs during tearDown
    ([pr#40709](https://github.com/ceph/ceph/pull/40709), Patrick
    Donnelly)
-   qa: krbd_blkroset.t: update for separate hw and user read-only flags
    ([pr#40212](https://github.com/ceph/ceph/pull/40212), Ilya Dryomov)
-   qa: vstart_runner: TypeError: lstat: path should be string, bytes or
    os.PathLike, not NoneType
    ([pr#41485](https://github.com/ceph/ceph/pull/41485), Patrick
    Donnelly)
-   rbd-mirror: image replayer stop might race with instance replayer
    shut down ([pr#41792](https://github.com/ceph/ceph/pull/41792),
    Mykola Golub, Jason Dillaman)
-   rgw : catch non int exception
    ([pr#40356](https://github.com/ceph/ceph/pull/40356), caolei)
-   rgw/http: add timeout to http client
    ([pr#40667](https://github.com/ceph/ceph/pull/40667), Yuval
    Lifshitz)
-   rgw: Added caching for S3 credentials retrieved from keystone
    ([pr#41158](https://github.com/ceph/ceph/pull/41158), James Weaver)
-   rgw: Use correct bucket info when put or get large object with swift
    ([pr#40106](https://github.com/ceph/ceph/pull/40106), zhiming zhang,
    yupeng chen)
-   rgw: allow rgw-orphan-list to handle intermediate files w/ binary
    data ([pr#39767](https://github.com/ceph/ceph/pull/39767), J. Eric
    Ivancich)
-   rgw: beast frontend uses 512k mprotected coroutine stacks
    ([pr#39947](https://github.com/ceph/ceph/pull/39947), Yaakov
    Selkowitz, Mauricio Faria de Oliveira, Daniel Gryniewicz, Casey
    Bodley)
-   rgw: check object locks in multi-object delete
    ([issue#47586](http://tracker.ceph.com/issues/47586),
    [pr#41164](https://github.com/ceph/ceph/pull/41164), Mark Houghton,
    Matt Benjamin)
-   rgw: during reshard lock contention, adjust logging
    ([pr#41156](https://github.com/ceph/ceph/pull/41156), J. Eric
    Ivancich)
-   rgw: limit rgw_gc_max_objs to RGW_SHARDS_PRIME_1
    ([pr#40670](https://github.com/ceph/ceph/pull/40670), Rafał
    Wądołowski)
-   rgw: radoslist incomplete multipart parts marker
    ([pr#40827](https://github.com/ceph/ceph/pull/40827), J. Eric
    Ivancich)
-   rgw: return ERR_NO_SUCH_BUCKET early while evaluating bucket policy
    ([issue#38420](http://tracker.ceph.com/issues/38420),
    [pr#40668](https://github.com/ceph/ceph/pull/40668), Abhishek
    Lekshmanan)
-   rgw: return error when trying to copy encrypted object without key
    ([pr#40671](https://github.com/ceph/ceph/pull/40671), Ilsoo Byun)
-   rgw: tooling to locate rgw objects with missing rados components
    ([pr#39771](https://github.com/ceph/ceph/pull/39771), Michael
    Kidd, J. Eric Ivancich)
-   run-make-check.sh: let ctest generate XML output
    ([pr#40407](https://github.com/ceph/ceph/pull/40407), Kefu Chai)
-   src/global/signal_handler.h: fix preprocessor logic for alpine
    ([pr#39942](https://github.com/ceph/ceph/pull/39942), Duncan
    Bellamy)
-   test/TestOSDScrub: fix mktime() error
    ([pr#40621](https://github.com/ceph/ceph/pull/40621), luo rixin)
-   test/pybind: s/nosetests/python3/
    ([pr#40536](https://github.com/ceph/ceph/pull/40536), Kefu Chai)
-   test/rgw: test_datalog_autotrim filters out new entries
    ([pr#40674](https://github.com/ceph/ceph/pull/40674), Casey Bodley)
-   test: use std::atomic\<bool\> instead of volatile for cb_done var
    ([pr#40701](https://github.com/ceph/ceph/pull/40701), Jeff Layton)
-   tests: ceph_test_rados_api_watch_notify: Allow for reconnect
    ([pr#40697](https://github.com/ceph/ceph/pull/40697), Brad Hubbard)
-   vstart.sh: disable \"auth_allow_insecure_global_id_reclaim\"
    ([pr#40959](https://github.com/ceph/ceph/pull/40959), Kefu Chai)

## v14.2.21 Nautilus

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

## v14.2.20 Nautilus

This is the 20th bugfix release in the Nautilus stable series. It
addresses a security vulnerability in the Ceph authentication framework.

We recommend all Nautilus users upgrade.

### Security fixes

-   This release includes a security fix that ensures the global_id
    value (a numeric value that should be unique for every authenticated
    client or daemon in the cluster) is reclaimed after a network
    disconnect or ticket renewal in a secure fashion. Two new health
    alerts may appear during the upgrade indicating that there are
    clients or daemons that are not yet patched with the appropriate
    fix.

    It is possible to disable the health alerts around insecure clients:

        ceph config set mon mon_warn_on_insecure_global_id_reclaim false
        ceph config set mon mon_warn_on_insecure_global_id_reclaim_allowed false

    However, if you disable these alerts, we strongly recommend that you
    follow up by removing these settings after clients have been
    upgraded or after upgrading to Octopus. (Starting in Octopus, these
    health alerts can be muted for a specific period of time.)

    For more information, see `CVE-2021-20288`{.interpreted-text
    role="ref"}.

## v14.2.19 Nautilus

This is the 19th update to the Ceph Nautilus release series. This is a
hotfix release to prevent daemons from binding to loopback network
interfaces. All nautilus users are advised to upgrade to this release.

### Notable Changes

-   This release fixes a regression introduced in v14.2.17 whereby in
    certain environments, OSDs will bind to 127.0.0.1. See
    [issue#49938](https://tracker.ceph.com/issues/49938).

### Changelog

-   common/ipaddr: also skip just [lo]{.title-ref}
    ([pr#40423](https://github.com/ceph/ceph/pull/40423), Dan van der
    Ster)

## v14.2.18 Nautilus

This is the 18th backport release in the Nautilus series. It fixes a
regression introduced in 14.2.17 in which the manager module tries to
use a couple python modules that do not exist in some environments. We
recommend users to update to this release.

### Notable Changes

-   This release fixes issues loading the dashboard and volumes manager
    modules in some environments.

### Changelog

-   nautilus: .github: add workflow for adding labels and milestone
    ([pr#39926](https://github.com/ceph/ceph/pull/39926), Kefu Chai,
    Ernesto Puerta)
-   nautilus: mgr/dashboard: Python2 Cookie module import fails on
    Python3 ([pr#40116](https://github.com/ceph/ceph/pull/40116), Volker
    Theile)
-   nautilus: mgr/volumes: don\'t require typing
    ([pr#40095](https://github.com/ceph/ceph/pull/40095), Josh Durgin)
-   nautilus: qa/suites/krbd: address recent issues caused by newer
    kernels ([pr#40064](https://github.com/ceph/ceph/pull/40064), Ilya
    Dryomov)

## v14.2.17 Nautilus

This is the 17th backport release in the Nautilus series. We recommend
users to update to this release.

### Notable Changes

-   \$pid expansion in config paths like `admin_socket` will now
    properly expand to the daemon pid for commands like `ceph-mds` or
    `ceph-osd`. Previously only `ceph-fuse`/`rbd-nbd` expanded `$pid`
    with the actual daemon pid.
-   RADOS: PG removal has been optimized in this release.
-   RADOS: Memory allocations are tracked in finer detail in BlueStore
    and displayed as a part of the `dump_mempools` command.
-   cephfs: clients which acquire capabilities too quickly are throttled
    to prevent instability. See new config option
    `mds_session_cap_acquisition_throttle` to control this behavior.

### Changelog

-   nautilus mgr/dashboard: fix \'ceph dashboard iscsi-gateway-add\'
    ([pr#39175](https://github.com/ceph/ceph/pull/39175), Alfonso
    Martínez)
-   nautilus: Do not add sensitive information in Ceph log files
    ([pr#38614](https://github.com/ceph/ceph/pull/38614), Neha Ojha)
-   nautilus: bluestore: Add protection against bluefs log file growth
    ([pr#37948](https://github.com/ceph/ceph/pull/37948), Adam Kupczyk)
-   nautilus: bluestore: provide a different name for fallback allocator
    ([pr#37793](https://github.com/ceph/ceph/pull/37793), Igor Fedotov)
-   nautilus: build-integration-branch: take PRs in chronological order
    ([pr#37693](https://github.com/ceph/ceph/pull/37693), Nathan Cutler)
-   nautilus: build/ops: install-deps.sh,deb,rpm: move python-saml deps
    into debian/control and ceph.spec.in
    ([pr#39184](https://github.com/ceph/ceph/pull/39184), Kefu Chai)
-   nautilus: ceph-volume batch: reject partitions in argparser
    ([pr#38279](https://github.com/ceph/ceph/pull/38279), Jan Fajerski)
-   nautilus: ceph-volume: Fix usage of is_lv
    ([pr#39221](https://github.com/ceph/ceph/pull/39221), Michał
    Nasiadka)
-   nautilus: ceph-volume: Update batch.py
    ([pr#39470](https://github.com/ceph/ceph/pull/39470), shenjiatong)
-   nautilus: ceph-volume: add no-systemd argument to zap
    ([pr#37723](https://github.com/ceph/ceph/pull/37723), wanghongxu)
-   nautilus: ceph-volume: add some flexibility to bytes_to_extents
    ([pr#39270](https://github.com/ceph/ceph/pull/39270), Jan Fajerski)
-   nautilus: ceph-volume: consume mount opt in simple activate
    ([pr#38015](https://github.com/ceph/ceph/pull/38015), Dimitri
    Savineau)
-   nautilus: ceph-volume: implement the \--log-level flag
    ([pr#38372](https://github.com/ceph/ceph/pull/38372), Andrew Schoen)
-   nautilus: ceph-volume: remove mention of dmcache from docs and help
    text ([pr#38048](https://github.com/ceph/ceph/pull/38048), Dimitri
    Savineau, Andrew Schoen)
-   nautilus: cephfs: client: check rdonly file handle on truncate
    ([pr#39129](https://github.com/ceph/ceph/pull/39129), Patrick
    Donnelly)
-   nautilus: cephfs: client: dump which fs is used by client for
    multiple-fs ([pr#38552](https://github.com/ceph/ceph/pull/38552),
    Zhi Zhang)
-   nautilus: cephfs: client: ensure we take Fs caps when fetching
    directory link count from cached inode
    ([pr#38950](https://github.com/ceph/ceph/pull/38950), Jeff Layton)
-   nautilus: cephfs: client: fix inode ll_ref reference count leak
    ([pr#37838](https://github.com/ceph/ceph/pull/37838), sepia-liu)
-   nautilus: cephfs: client: increment file position on \_read_sync
    near eof ([pr#37991](https://github.com/ceph/ceph/pull/37991),
    Patrick Donnelly)
-   nautilus: cephfs: client: set CEPH_STAT_RSTAT mask for dir in
    readdir_r_cb ([pr#38948](https://github.com/ceph/ceph/pull/38948),
    chencan)
-   nautilus: cephfs: mds: throttle cap acquisition via readdir
    ([pr#38101](https://github.com/ceph/ceph/pull/38101), Kotresh HR)
-   nautilus: cephfs: mount.ceph: collect v2 addresses for non-legacy
    ms_mode options
    ([pr#39133](https://github.com/ceph/ceph/pull/39133), Jeff Layton)
-   nautilus: cephfs: osdc: restart read on truncate/discard
    ([pr#37988](https://github.com/ceph/ceph/pull/37988), Patrick
    Donnelly)
-   nautilus: cephfs: release client dentry_lease before send caps
    release to mds ([pr#39127](https://github.com/ceph/ceph/pull/39127),
    Wei Qiaomiao)
-   nautilus: client: add ceph.{cluster_fsid/client_id} vxattrs suppport
    ([pr#39001](https://github.com/ceph/ceph/pull/39001), Xiubo Li)
-   nautilus: client: do not use g_conf().get_val\<\>() in libcephfs
    ([pr#38467](https://github.com/ceph/ceph/pull/38467), Xiubo Li)
-   nautilus: cmake: define BOOST_ASIO_USE_TS_EXECUTOR_AS_DEFAULT for
    Boost.Asio users
    ([pr#38760](https://github.com/ceph/ceph/pull/38760), Kefu Chai)
-   nautilus: cmake: detect and use sigdescr_np() if available
    ([pr#38952](https://github.com/ceph/ceph/pull/38952), David
    Disseldorp)
-   nautilus: common/mempool: Improve mempool shard selection
    ([pr#39651](https://github.com/ceph/ceph/pull/39651), Nathan Cutler,
    Adam Kupczyk)
-   nautilus: common: fix logfile create perms
    ([issue#7849](http://tracker.ceph.com/issues/7849),
    [pr#38558](https://github.com/ceph/ceph/pull/38558), Kefu Chai,
    Roman Penyaev)
-   nautilus: common: skip interfaces starting with \"lo\" in
    find_ipv{4,6}\_in_subnet()
    ([pr#39342](https://github.com/ceph/ceph/pull/39342), Thomas
    Goirand, Jiawei Li)
-   nautilus: core: osd: An empty bucket or OSD is not an error
    ([pr#39126](https://github.com/ceph/ceph/pull/39126), Brad Hubbard)
-   nautilus: crush/CrushWrapper: rebuild reverse maps after rebuilding
    crush map ([pr#39197](https://github.com/ceph/ceph/pull/39197),
    Jason Dillaman)
-   nautilus: krbd: add support for msgr2 (kernel 5.11)
    ([pr#39202](https://github.com/ceph/ceph/pull/39202), Ilya Dryomov)
-   nautilus: librados, tests: allow to list objects with the NUL
    character in names
    ([pr#39324](https://github.com/ceph/ceph/pull/39324), Radoslaw
    Zarzynski)
-   nautilus: librbd: clear implicitly enabled feature bits when
    creating images
    ([pr#39121](https://github.com/ceph/ceph/pull/39121), Jason
    Dillaman)
-   nautilus: log: fix timestap precision of log can\'t set to
    millisecond ([pr#37659](https://github.com/ceph/ceph/pull/37659),
    Guan yunfei)
-   nautilus: lvm/create.py: fix a typo in the help message
    ([pr#38371](https://github.com/ceph/ceph/pull/38371), ZhenLiu94)
-   nautilus: mds : move start_files_to_recover() to recovery_done
    ([pr#37986](https://github.com/ceph/ceph/pull/37986), Simon Gao)
-   nautilus: mds: account for closing sessions in hit_session
    ([pr#37820](https://github.com/ceph/ceph/pull/37820), Dan van der
    Ster)
-   nautilus: mds: avoid spurious sleeps
    ([pr#39130](https://github.com/ceph/ceph/pull/39130), Patrick
    Donnelly)
-   nautilus: mds: dir-\>mark_new() should together with
    dir-\>mark_dirty()
    ([pr#39128](https://github.com/ceph/ceph/pull/39128), \"Yan,
    Zheng\")
-   nautilus: mds: update defaults for recall configs
    ([pr#39134](https://github.com/ceph/ceph/pull/39134), Patrick
    Donnelly)
-   nautilus: mgr/PyModule: correctly remove config options
    ([pr#38803](https://github.com/ceph/ceph/pull/38803), Tim Serong)
-   nautilus: mgr/crash: Serialize command handling
    ([pr#39338](https://github.com/ceph/ceph/pull/39338), Boris Ranto)
-   nautilus: mgr/dashboard: CLI commands: read passwords from file
    ([pr#38832](https://github.com/ceph/ceph/pull/38832), Ernesto
    Puerta, Alfonso Martínez, Juan Miguel Olmo Martínez)
-   nautilus: mgr/dashboard: Datatable catches select events from other
    datatables ([pr#37756](https://github.com/ceph/ceph/pull/37756),
    Volker Theile, Tiago Melo)
-   nautilus: mgr/dashboard: Disable TLS 1.0 and 1.1
    ([pr#38332](https://github.com/ceph/ceph/pull/38332), Volker Theile)
-   nautilus: mgr/dashboard: Disable sso without python3-saml
    ([pr#38404](https://github.com/ceph/ceph/pull/38404), Kevin Meijer)
-   nautilus: mgr/dashboard: Display a warning message in Dashboard when
    debug mode is enabled
    ([pr#38799](https://github.com/ceph/ceph/pull/38799), Volker Theile)
-   nautilus: mgr/dashboard: Display users current bucket quota usage
    ([pr#38024](https://github.com/ceph/ceph/pull/38024), Avan Thakkar)
-   nautilus: mgr/dashboard: Drop invalid RGW client instances, improve
    logging ([pr#38584](https://github.com/ceph/ceph/pull/38584), Volker
    Theile)
-   nautilus: mgr/dashboard: Fix for datatable item not showing details
    after getting selected
    ([pr#38813](https://github.com/ceph/ceph/pull/38813), Nizamudeen A)
-   nautilus: mgr/dashboard: Fix for incorrect validation in rgw user
    form ([pr#39117](https://github.com/ceph/ceph/pull/39117),
    Nizamudeen A)
-   nautilus: mgr/dashboard: RGW User Form is validating disabled fields
    ([pr#39543](https://github.com/ceph/ceph/pull/39543), Aashish
    Sharma)
-   nautilus: mgr/dashboard: The /rgw/status endpoint does not check for
    running service
    ([pr#38771](https://github.com/ceph/ceph/pull/38771), Volker Theile)
-   nautilus: mgr/dashboard: Updating the inbuilt ssl providers error
    ([pr#38509](https://github.com/ceph/ceph/pull/38509), Nizamudeen A)
-   nautilus: mgr/dashboard: Use secure cookies to store JWT Token
    ([pr#38839](https://github.com/ceph/ceph/pull/38839), Avan Thakkar,
    Aashish Sharma)
-   nautilus: mgr/dashboard: add [\--ssl]{.title-ref} to [ng
    serve]{.title-ref}
    ([pr#38972](https://github.com/ceph/ceph/pull/38972), Tatjana
    Dehler)
-   nautilus: mgr/dashboard: avoid using document.write()
    ([pr#39526](https://github.com/ceph/ceph/pull/39526), Avan Thakkar)
-   nautilus: mgr/dashboard: customize CherryPy Server Header
    ([pr#39419](https://github.com/ceph/ceph/pull/39419), anurag)
-   nautilus: mgr/dashboard: delete EOF when reading passwords from file
    ([pr#39438](https://github.com/ceph/ceph/pull/39438), Alfonso
    Martínez)
-   nautilus: mgr/dashboard: disable cluster selection in NFS export
    editing form ([pr#37995](https://github.com/ceph/ceph/pull/37995),
    Kiefer Chang)
-   nautilus: mgr/dashboard: enable different URL for users of browser
    to Grafana ([pr#39136](https://github.com/ceph/ceph/pull/39136),
    Patrick Seidensal)
-   nautilus: mgr/dashboard: fix MTU Mismatch alert
    ([pr#39518](https://github.com/ceph/ceph/pull/39518), Aashish
    Sharma)
-   nautilus: mgr/dashboard: fix issues related with PyJWT versions
    \>=2.0.0 ([pr#39837](https://github.com/ceph/ceph/pull/39837),
    Alfonso Martínez)
-   nautilus: mgr/dashboard: fix security scopes of some NFS-Ganesha
    endpoints ([pr#37961](https://github.com/ceph/ceph/pull/37961),
    Kiefer Chang)
-   nautilus: mgr/dashboard: fix tooltip for Provisioned/Total
    Provisioned fields
    ([pr#39646](https://github.com/ceph/ceph/pull/39646), Avan Thakkar)
-   nautilus: mgr/dashboard: minimize console log traces of Ceph backend
    API tests ([pr#39544](https://github.com/ceph/ceph/pull/39544),
    Aashish Sharma)
-   nautilus: mgr/dashboard: prometheus alerting: add some leeway for
    package drops and errors
    ([pr#39509](https://github.com/ceph/ceph/pull/39509), Patrick
    Seidensal)
-   nautilus: mgr/dashboard: python 2: error when setting non-ASCII
    password ([pr#39441](https://github.com/ceph/ceph/pull/39441),
    Alfonso Martínez)
-   nautilus: mgr/dashboard: remove pyOpenSSL version pinning
    ([pr#38504](https://github.com/ceph/ceph/pull/38504), Kiefer Chang)
-   nautilus: mgr/dashboard: set security headers
    ([pr#39626](https://github.com/ceph/ceph/pull/39626), Avan Thakkar)
-   nautilus: mgr/dashboard: test_standby\*
    (tasks.mgr.test_dashboard.TestDashboard) failed locally
    ([pr#38527](https://github.com/ceph/ceph/pull/38527), Volker Theile)
-   nautilus: mgr/dashboard: trigger alert if some nodes have a MTU
    different than the median value
    ([pr#39104](https://github.com/ceph/ceph/pull/39104), Aashish
    Sharma)
-   nautilus: mgr/insights: Test environment requires \'six\'
    ([pr#38382](https://github.com/ceph/ceph/pull/38382), Brad Hubbard)
-   nautilus: mgr/progress: delete all events over the wire
    ([pr#38416](https://github.com/ceph/ceph/pull/38416), Sage Weil)
-   nautilus: mgr/progress: make it so progress bar does not get stuck
    forever ([issue#40618](http://tracker.ceph.com/issues/40618),
    [pr#37589](https://github.com/ceph/ceph/pull/37589), Kamoltat
    (Junior) Sirivadhna, Kamoltat)
-   nautilus: mgr/prometheus: Add SLOW_OPS healthcheck as a metric
    ([pr#39747](https://github.com/ceph/ceph/pull/39747), Paul Cuzner)
-   nautilus: mgr/prometheus: Fix \'pool filling up\' with \>50% usage
    ([pr#39076](https://github.com/ceph/ceph/pull/39076), Daniël Vos)
-   nautilus: mgr/prometheus: Make module more stable
    ([pr#38334](https://github.com/ceph/ceph/pull/38334), Boris Ranto,
    Ken Dreyer)
-   nautilus: mgr/restful: fix TypeError occurring in \_gather_osds()
    ([issue#48488](http://tracker.ceph.com/issues/48488),
    [pr#39339](https://github.com/ceph/ceph/pull/39339), Jerry Pu)
-   nautilus: mgr/telemetry: fix proxy usage
    ([pr#38816](https://github.com/ceph/ceph/pull/38816), Nathan Cutler)
-   nautilus: mgr/volume: subvolume auth_id management and few bug fixes
    ([pr#39292](https://github.com/ceph/ceph/pull/39292), Rishabh Dave,
    Patrick Donnelly, Kotresh HR, Ramana Raja)
-   nautilus: mgr/volumes: Make number of cloner threads configurable
    ([pr#37936](https://github.com/ceph/ceph/pull/37936), Kotresh HR)
-   nautilus: mgr: Pin importlib_metadata version 2.1.0
    ([pr#38296](https://github.com/ceph/ceph/pull/38296), Brad Hubbard)
-   nautilus: mgr: don\'t update osd stat which is already out
    ([pr#38354](https://github.com/ceph/ceph/pull/38354), Zhi Zhang)
-   nautilus: mgr: fix deadlock in ActivePyModules::get_osdmap()
    ([pr#39340](https://github.com/ceph/ceph/pull/39340), peng jiaqi)
-   nautilus: mgr: update mon metadata when monmap is updated
    ([pr#39075](https://github.com/ceph/ceph/pull/39075), Kefu Chai)
-   nautilus: mon scrub testing
    ([pr#38362](https://github.com/ceph/ceph/pull/38362), Brad Hubbard)
-   nautilus: mon/MDSMonitor do not ignore mds\'s down:dne request
    ([pr#37822](https://github.com/ceph/ceph/pull/37822), chencan)
-   nautilus: mon/MDSMonitor: divide mds identifier and mds real name
    with dot ([pr#37821](https://github.com/ceph/ceph/pull/37821), Zhi
    Zhang)
-   nautilus: mon: Log \"ceph health detail\" periodically in cluster
    log ([pr#38118](https://github.com/ceph/ceph/pull/38118), Prashant
    Dhange)
-   nautilus: mon: have \'mon stat\' output json as well
    ([pr#37706](https://github.com/ceph/ceph/pull/37706), Joao Eduardo
    Luis, Sage Weil)
-   nautilus: mon: paxos: Delete logger in destructor
    ([pr#39160](https://github.com/ceph/ceph/pull/39160), Brad Hubbard)
-   nautilus: mon: validate crush-failure-domain
    ([pr#39124](https://github.com/ceph/ceph/pull/39124), Prashant
    Dhange)
-   nautilus: monitoring: Use null yaxes min for OSD read latency
    ([pr#37959](https://github.com/ceph/ceph/pull/37959), Seena Fallah)
-   nautilus: msg/async/ProtocolV2: allow rxbuf/txbuf get bigger in
    testing, again ([pr#38268](https://github.com/ceph/ceph/pull/38268),
    Ilya Dryomov)
-   nautilus: ocf: add support for mapping images within an RBD
    namespace ([pr#39047](https://github.com/ceph/ceph/pull/39047),
    Jason Dillaman)
-   nautilus: os/bluestore: Add option to check BlueFS reads
    ([pr#39756](https://github.com/ceph/ceph/pull/39756), Adam Kupczyk)
-   nautilus: os/bluestore: detect and fix \"zombie\" spanning blobs
    using fsck ([pr#39255](https://github.com/ceph/ceph/pull/39255),
    Igor Fedotov)
-   nautilus: os/bluestore: fix huge read/writes in BlueFS
    ([pr#39698](https://github.com/ceph/ceph/pull/39698), Jianpeng Ma,
    Kefu Chai, Igor Fedotov)
-   nautilus: os/bluestore: fix inappropriate ENOSPC from avl/hybrid
    allocator ([pr#38475](https://github.com/ceph/ceph/pull/38475), Igor
    Fedotov)
-   nautilus: os/bluestore: fix segfault on out-of-bound offset provided
    to claim\_... ([pr#38637](https://github.com/ceph/ceph/pull/38637),
    Igor Fedotov)
-   nautilus: os/bluestore: go beyond pinned onodes while trimming the
    cache ([pr#39720](https://github.com/ceph/ceph/pull/39720), Igor
    Fedotov)
-   nautilus: os/bluestore: mempool\'s finer granularity + adding missed
    structs ([pr#38310](https://github.com/ceph/ceph/pull/38310),
    Deepika Upadhyay, Igor Fedotov, Adam Kupczyk)
-   nautilus: osd: Check for nosrub/nodeep-scrub in between chunks, to
    avoid races ([pr#38411](https://github.com/ceph/ceph/pull/38411),
    David Zafman)
-   nautilus: osd: fix bluestore bitmap allocator calculate wrong
    last_pos with hint
    ([pr#39708](https://github.com/ceph/ceph/pull/39708), Xue Yantao)
-   nautilus: osd: optimize PG removal (part1)
    ([pr#38478](https://github.com/ceph/ceph/pull/38478), Neha Ojha,
    Igor Fedotov)
-   nautilus: pybind/ceph_volume_client: Update the \'volumes\' key to
    \'subvolumes\' in auth-metadata file
    ([pr#39658](https://github.com/ceph/ceph/pull/39658), Kotresh HR,
    Michael Fritch)
-   nautilus: pybind/cephfs: add special values for not reading conffile
    ([pr#37725](https://github.com/ceph/ceph/pull/37725), Kefu Chai)
-   nautilus: pybind/cephfs: fix missing terminating NULL char in
    readlink()\'s C string
    ([pr#38894](https://github.com/ceph/ceph/pull/38894), Tuan Hoang)
-   nautilus: pybind/mgr/rbd_support: delay creation of progress module
    events ([pr#38833](https://github.com/ceph/ceph/pull/38833), Jason
    Dillaman)
-   nautilus: qa/cephfs: add session_timeout option support
    ([pr#37840](https://github.com/ceph/ceph/pull/37840), Xiubo Li)
-   nautilus: qa/distros: add rhel 7.9
    ([pr#38188](https://github.com/ceph/ceph/pull/38188), rakeshgm)
-   nautilus: qa/tasks/ceph_manager.py: don\'t use log-early in
    raw_cluster_cmd
    ([pr#39960](https://github.com/ceph/ceph/pull/39960), Neha Ojha)
-   nautilus: qa/tasks/{ceph,ceph_manager}: drop py2 support
    ([pr#37906](https://github.com/ceph/ceph/pull/37906), Rishabh Dave,
    Deepika Upadhyay, Kefu Chai)
-   nautilus: qa: fix tox failures
    ([pr#38627](https://github.com/ceph/ceph/pull/38627), Patrick
    Donnelly)
-   nautilus: qa: krbd_stable_pages_required.sh: move to stable_writes
    attribute ([pr#38834](https://github.com/ceph/ceph/pull/38834), Ilya
    Dryomov)
-   nautilus: qa: restore file name
    ([pr#38772](https://github.com/ceph/ceph/pull/38772), Patrick
    Donnelly)
-   nautilus: qa: unmount volumes before removal
    ([pr#38690](https://github.com/ceph/ceph/pull/38690), Patrick
    Donnelly)
-   nautilus: qa: use normal build for valgrind
    ([pr#39584](https://github.com/ceph/ceph/pull/39584), Sage Weil)
-   nautilus: rados/upgrade/nautilus-x-singleton fails due to cluster
    \[WRN\] evicting unresponsive client
    ([pr#39706](https://github.com/ceph/ceph/pull/39706), Patrick
    Donnelly)
-   nautilus: rbd-nbd: reexpand the conf meta in child process
    ([pr#38830](https://github.com/ceph/ceph/pull/38830), Xiubo Li)
-   nautilus: rbd/bench: include used headers
    ([pr#39123](https://github.com/ceph/ceph/pull/39123), Kefu Chai)
-   nautilus: rbd: librbd: ensure that thread pool lock is held when
    processing throttled IOs
    ([pr#37895](https://github.com/ceph/ceph/pull/37895), Jason
    Dillaman)
-   nautilus: rbd: librbd: update hidden global config when removing
    pool config override
    ([pr#38831](https://github.com/ceph/ceph/pull/38831), Jason
    Dillaman)
-   nautilus: rgw: Disable prefetch of entire head object when GET
    request with range header
    ([pr#38556](https://github.com/ceph/ceph/pull/38556), Or Friedmann)
-   nautilus: rgw: S3 Put Bucket Policy should return 204 on success
    ([pr#38623](https://github.com/ceph/ceph/pull/38623), Matthew
    Oliver)
-   nautilus: rgw: avoid expiration early triggering caused by overflow
    ([pr#38823](https://github.com/ceph/ceph/pull/38823), jiahuizeng)
-   nautilus: rgw: cls/rgw/cls_rgw.cc: fix multiple lastest version
    problem ([pr#38085](https://github.com/ceph/ceph/pull/38085), Yang
    Honggang, Ruan Zitao)
-   nautilus: rgw: cls/user: set from_index for reset stats calls
    ([pr#38822](https://github.com/ceph/ceph/pull/38822), Mykola Golub,
    Abhishek Lekshmanan)
-   nautilus: rgw: distribute cache for exclusive put
    ([pr#38827](https://github.com/ceph/ceph/pull/38827), Or Friedmann)
-   nautilus: rgw: fix bucket limit check fill_status warnings
    ([issue#40255](http://tracker.ceph.com/issues/40255),
    [pr#38825](https://github.com/ceph/ceph/pull/38825), Paul Emmerich)
-   nautilus: rgw: fix invalid payload issue when serving s3website
    error page ([pr#38590](https://github.com/ceph/ceph/pull/38590),
    Ilsoo Byun)
-   nautilus: rgw: fix trailing null in object names of multipart
    reuploads ([pr#39276](https://github.com/ceph/ceph/pull/39276),
    Casey Bodley)
-   nautilus: rgw: in ordered bucket listing skip namespaced entries
    internally when possible
    ([pr#38493](https://github.com/ceph/ceph/pull/38493), J. Eric
    Ivancich)
-   nautilus: rgw: keep syncstopped flag when copying bucket shard
    headers ([pr#38589](https://github.com/ceph/ceph/pull/38589), Ilsoo
    Byun)
-   nautilus: rgw: multisite: Verify if the synced object is identical
    to source ([pr#38885](https://github.com/ceph/ceph/pull/38885),
    Prasad Krishnan, Yang Honggang, Casey Bodley)
-   nautilus: rgw: radosgw-admin: clarify error when email address
    already in use ([pr#39661](https://github.com/ceph/ceph/pull/39661),
    Matthew Vernon)
-   nautilus: rgw: rgw-admin: fixes BucketInfo for missing buckets
    ([pr#38588](https://github.com/ceph/ceph/pull/38588), Nick Janus,
    caolei)
-   nautilus: rgw_file: return common_prefixes in lexical order
    ([pr#38828](https://github.com/ceph/ceph/pull/38828), Matt Benjamin)
-   nautilus: rpm,deb: change sudoers file mode to 440
    ([pr#39090](https://github.com/ceph/ceph/pull/39090), David Turner)
-   nautilus: rpm: ceph-mgr-dashboard recommends python3-saml on SUSE
    ([pr#38818](https://github.com/ceph/ceph/pull/38818), Nathan Cutler)
-   nautilus: run-make-check.sh: Don\'t run tests if build fails
    ([pr#38295](https://github.com/ceph/ceph/pull/38295), Brad Hubbard)
-   nautilus: test/librados: fix endian bugs in checksum test cases
    ([pr#37605](https://github.com/ceph/ceph/pull/37605), Ulrich
    Weigand)
-   nautilus: test/rbd-mirror: fix broken
    ceph_test_rbd_mirror_random_write
    ([pr#39650](https://github.com/ceph/ceph/pull/39650), Jason
    Dillaman)
-   nautilus: test/run-cli-tests: use cram from github
    ([pr#39072](https://github.com/ceph/ceph/pull/39072), Kefu Chai)
-   nautilus: tests: cancelling both noscrub \*and\* nodeep-scrub
    ([pr#39125](https://github.com/ceph/ceph/pull/39125), Ronen
    Friedman)
-   nautilus: tools/rados: add support for binary object names in the
    rados CLI ([pr#39329](https://github.com/ceph/ceph/pull/39329),
    Radoslaw Zarzynski, Kefu Chai)
-   nautilus: tools/rados: flush formatter periodically during json
    output of \"rados ls\"
    ([pr#37834](https://github.com/ceph/ceph/pull/37834), J. Eric
    Ivancich)
-   nautilus: vstart.sh: fix fs set max_mds bug
    ([pr#37836](https://github.com/ceph/ceph/pull/37836), Jinmyeong Lee)

## v14.2.16 Nautilus

This is the 16th backport release in the Nautilus series. This release
fixes a security flaw in CephFS. We recommend users to update to this
release.

### Notable Changes

-   CVE-2020-27781 : OpenStack Manila use of ceph_volume_client.py
    library allowed tenant access to any Ceph credential\'s secret.
    (Kotresh Hiremath Ravishankar, Ramana Raja)

### Changelog

-   pybind/ceph_volume_client: disallow authorize on existing auth ids
    (Kotresh Hiremath Ravishankar, Ramana Raja)

## v14.2.15 Nautilus

This is the 15th backport release in the Nautilus series. This release
fixes a ceph-volume regression introduced in v14.2.13 and includes few
other fixes. We recommend users to update to this release.

### Notable Changes

-   ceph-volume: Fixes lvm batch \--auto, which breaks backward
    compatibility when using non rotational devices only (SSD and/or
    NVMe).
-   BlueStore: Fixes a bug in collection_list_legacy which makes pgs
    inconsistent during scrub when running mixed versions of osds, prior
    to 14.2.12 with newer.
-   MGR: progress module can now be turned on/off, using the commands:
    `ceph progress on` and `ceph progress off`.

### Changelog

-   ceph-volume: fix filestore/dmcrypt activate
    ([pr#38198](https://github.com/ceph/ceph/pull/38198), Guillaume
    Abrioux)
-   ceph-volume: fix lvm batch auto with full SSDs
    ([pr#38046](https://github.com/ceph/ceph/pull/38046), Dimitri
    Savineau, Guillaume Abrioux)
-   os/bluestore: fix \"end reached\" check in collection_list_legacy
    ([pr#38100](https://github.com/ceph/ceph/pull/38100), Mykola Golub)
-   mgr/progress: introduce turn off/on feature
    ([pr#38173](https://github.com/ceph/ceph/pull/38173), kamoltat)

## v14.2.14 Nautilus

This is the 14th backport release in the Nautilus series. This release
fixes a security flaw affecting Messenger v2, among other fixes across
components. We recommend users to update to this release.

### Notable Changes

-   CVE 2020-25660: CEPHX_V2 replay attack protection lost, for
    Messenger v2 (Ilya Dryomov)

### Changelog

-   mgr/dashboard: Strange iSCSI discovery auth behavior
    ([pr#37333](https://github.com/ceph/ceph/pull/37333), Volker Theile)
-   mgr/dashboard: redirect to original URL after successful login
    ([pr#36834](https://github.com/ceph/ceph/pull/36834), Avan Thakkar)
-   mgr/prometheus: add pool compression stats
    ([pr#37563](https://github.com/ceph/ceph/pull/37563), Paul Cuzner)
-   bluestore: test/objectstore/store_test: kill ExcessiveFragmentation
    test case ([pr#37824](https://github.com/ceph/ceph/pull/37824), Igor
    Fedotov)
-   bluestore: BlockDevice.cc: use pending_aios instead of iovec size as
    ios num ([pr#37823](https://github.com/ceph/ceph/pull/37823),
    weixinwei)
-   bluestore: Support flock retry
    ([pr#37842](https://github.com/ceph/ceph/pull/37842), Kefu Chai,
    wanghongxu)
-   bluestore: attach csum for compressed blobs
    ([pr#37843](https://github.com/ceph/ceph/pull/37843), Igor Fedotov)
-   osdc/ObjectCacher: overwrite might cause stray read request
    callbacks ([pr#37813](https://github.com/ceph/ceph/pull/37813),
    Jason Dillaman)
-   mgr: avoid false alarm of MGR_MODULE_ERROR
    ([pr#38069](https://github.com/ceph/ceph/pull/38069), Kefu Chai,
    Sage Weil)
-   mgr: fix race between module load and notify
    ([pr#37844](https://github.com/ceph/ceph/pull/37844), Mykola Golub,
    Patrick Donnelly)
-   mon: set session_timeout when adding to session_map
    ([pr#37554](https://github.com/ceph/ceph/pull/37554), Ilya Dryomov)
-   mon/MonClient: bring back CEPHX_V2 authorizer challenges (Ilya
    Dryomov)
-   osd/osd-rep-recov-eio.sh: TEST_rados_repair_warning: return 1
    ([pr#37815](https://github.com/ceph/ceph/pull/37815), David Zafman)
-   rbd: librbd: ignore -ENOENT error when disabling object-map
    ([pr#37814](https://github.com/ceph/ceph/pull/37814), Jason
    Dillaman)
-   rbd: rbd-nbd: don\'t ignore namespace when unmapping by image spec
    ([pr#37811](https://github.com/ceph/ceph/pull/37811), Mykola Golub)
-   rgw/rgw_file: Fix the incorrect lru object eviction
    ([pr#37804](https://github.com/ceph/ceph/pull/37804), luo rixin)
-   rgw: fix expiration header returned even if there is only one tag in
    the object the same as the rule
    ([pr#37806](https://github.com/ceph/ceph/pull/37806), Or Friedmann)
-   rgw: fix: S3 API KeyCount incorrect return
    ([pr#37810](https://github.com/ceph/ceph/pull/37810), 胡玮文)
-   rgw: radosgw-admin should paginate internally when listing bucket
    ([pr#37802](https://github.com/ceph/ceph/pull/37802), J. Eric
    Ivancich)
-   rgw: rgw_file: avoid long-ish delay on shutdown
    ([pr#37552](https://github.com/ceph/ceph/pull/37552), Matt Benjamin)
-   rgw: use yum rather than dnf for teuthology testing of
    rgw-orphan-list
    ([pr#37805](https://github.com/ceph/ceph/pull/37805), J. Eric
    Ivancich)

## v14.2.13 Nautilus

This is the 13th backport release in the Nautilus series. This release
fixes a regression introduced in v14.2.12, and a few ceph-volume & RGW
fixes. We recommend users to update to this release.

### Notable Changes

-   Fixed a regression that caused breakage in clusters that referred to
    ceph-mon hosts using dns names instead of ip addresses in the
    `mon_host` param in `ceph.conf`
    ([issue#47951](https://tracker.ceph.com/issues/47951))
-   ceph-volume: the `lvm batch` subcommand received a major rewrite

### Changelog

-   ceph-volume: major batch refactor
    ([pr#37522](https://github.com/ceph/ceph/pull/37522), Jan Fajerski)
-   mgr/dashboard: Proper format iSCSI target portals
    ([pr#37060](https://github.com/ceph/ceph/pull/37060), Volker Theile)
-   rpm: move python-enum34 into rhel 7 conditional
    ([pr#37747](https://github.com/ceph/ceph/pull/37747), Nathan Cutler)
-   mon/MonMap: fix unconditional failure for init_with_hosts
    ([pr#37816](https://github.com/ceph/ceph/pull/37816), Nathan Cutler,
    Patrick Donnelly)
-   rgw: allow rgw-orphan-list to note when rados objects are in
    namespace ([pr#37799](https://github.com/ceph/ceph/pull/37799), J.
    Eric Ivancich)
-   rgw: fix setting of namespace in ordered and unordered bucket
    listing ([pr#37798](https://github.com/ceph/ceph/pull/37798), J.
    Eric Ivancich)

## v14.2.12 Nautilus

This is the 12th backport release in the Nautilus series. This release
brings a number of bugfixes across all major components of Ceph. We
recommend that all Nautilus users upgrade to this release.

### Notable Changes

-   The `ceph df` command now lists the number of pgs in each pool.
-   Monitors now have a config option `mon_osd_warn_num_repaired`, 10 by
    default. If any OSD has repaired more than this many I/O errors in
    stored data a `OSD_TOO_MANY_REPAIRS` health warning is generated. In
    order to allow clearing of the warning, a new command
    `ceph tell osd.# clear_shards_repaired [count]` has been added. By
    default it will set the repair count to 0. If you wanted to be
    warned again if additional repairs are performed you can provide a
    value to the command and specify the value of
    `mon_osd_warn_num_repaired`. This command will be replaced in future
    releases by the health mute/unmute feature.
-   It is now possible to specify the initial monitor to contact for
    Ceph tools and daemons using the `mon_host_override` config option
    or `--mon-host-override <ip>` command-line switch. This generally
    should only be used for debugging and only affects initial
    communication with Ceph\'s monitor cluster.
-   Fix an issue with osdmaps not being trimmed in a healthy cluster
    ([issue#47296](https://tracker.ceph.com/issues/47296),
    [pr#36982](https://github.com/ceph/ceph/pull/36982))

### Changelog

-   bluestore/bluefs: make accounting resiliant to unlock()
    ([pr#36909](https://github.com/ceph/ceph/pull/36909), Adam Kupczyk)
-   bluestore: Rescue procedure for extremely large bluefs log
    ([pr#36930](https://github.com/ceph/ceph/pull/36930), Adam Kupczyk)
-   bluestore: dump onode that has too many spanning blobs
    ([pr#36756](https://github.com/ceph/ceph/pull/36756), Igor Fedotov)
-   bluestore: enable more flexible bluefs space management by default
    ([pr#37091](https://github.com/ceph/ceph/pull/37091), Igor Fedotov)
-   bluestore: fix collection_list ordering
    ([pr#37051](https://github.com/ceph/ceph/pull/37051), Mykola Golub)
-   ceph-iscsi: selinux fixes
    ([pr#36304](https://github.com/ceph/ceph/pull/36304), Mike Christie)
-   ceph-volume: add tests for new functions that run LVM commands
    ([pr#36615](https://github.com/ceph/ceph/pull/36615), Rishabh Dave)
-   ceph-volume: dont use container classes in api/lvm.py
    ([pr#35878](https://github.com/ceph/ceph/pull/35878), Guillaume
    Abrioux, Rishabh Dave\')
-   ceph-volume: fix journal size argument not work
    ([pr#37377](https://github.com/ceph/ceph/pull/37377), wanghongxu)
-   ceph-volume: fix simple activate when legacy osd
    ([pr#37195](https://github.com/ceph/ceph/pull/37195), Guillaume
    Abrioux)
-   ceph-volume: fix test_lvm.TestVolume.test_is_not_ceph_device
    ([pr#36493](https://github.com/ceph/ceph/pull/36493), Jan Fajerski)
-   ceph-volume: handle idempotency with batch and explicit scenarios
    ([pr#35881](https://github.com/ceph/ceph/pull/35881), Andrew Schoen)
-   ceph-volume: remove container classes from api/lvm.py
    ([pr#36610](https://github.com/ceph/ceph/pull/36610), Rishabh Dave)
-   ceph-volume: remove unneeded call to get_devices()
    ([pr#37413](https://github.com/ceph/ceph/pull/37413), Marc Gariepy)
-   ceph-volume: report correct rejected reason in inventory if device
    type is invalid
    ([pr#36453](https://github.com/ceph/ceph/pull/36453), Satoru
    Takeuchi)
-   ceph-volume: retry when acquiring lock fails
    ([pr#36926](https://github.com/ceph/ceph/pull/36926), Sxc3xa9bastien
    Han)
-   ceph-volume: simple scan should ignore tmpfs
    ([pr#36952](https://github.com/ceph/ceph/pull/36952), Andrew Schoen)
-   ceph.in: ignore failures to flush stdout
    ([pr#37226](https://github.com/ceph/ceph/pull/37226), Dan van der
    Ster)
-   ceph.spec.in, debian/control: add smartmontools and nvme-cli
    dependenxe2x80xa6
    ([pr#37288](https://github.com/ceph/ceph/pull/37288), Yaarit Hatuka)
-   cephfs-journal-tool: fix incorrect read_offset when finding missing
    objects ([pr#37479](https://github.com/ceph/ceph/pull/37479), Xue
    Yantao)
-   cephfs: client: fix extra open ref decrease
    ([pr#36966](https://github.com/ceph/ceph/pull/36966), Xiubo Li)
-   cephfs: client: make Client::open() pass proper cap mask to
    path_walk ([pr#37231](https://github.com/ceph/ceph/pull/37231),
    \"Yan, Zheng\")
-   cephfs: mds/CInode: Optimize only pinned by subtrees check
    ([pr#36965](https://github.com/ceph/ceph/pull/36965), Mark Nelson)
-   cephfs: mds: After restarting an mds, its standy-replay mds remained
    in the \"resolve\" state
    ([pr#37179](https://github.com/ceph/ceph/pull/37179), Wei Qiaomiao)
-   cephfs: mds: do not defer incoming mgrmap when mds is laggy
    ([issue#44638](http://tracker.ceph.com/issues/44638),
    [pr#36168](https://github.com/ceph/ceph/pull/36168), Nathan Cutler,
    Venky Shankar)
-   cephfs: mds: fix incorrect check for if dirfrag is being fragmented
    ([pr#37035](https://github.com/ceph/ceph/pull/37035), \"Yan,
    Zheng\")
-   cephfs: mds: fix mds forwarding request no_available_op_found
    ([pr#36963](https://github.com/ceph/ceph/pull/36963), Yanhu Cao\')
-   cephfs: mds: fix purge_queues \_calculate_ops is inaccurate
    ([pr#37481](https://github.com/ceph/ceph/pull/37481), Yanhu Cao\')
-   cephfs: mds: kcephfs parse dirfrags ndist is always 0
    ([pr#37177](https://github.com/ceph/ceph/pull/37177), Yanhu Cao\')
-   cephfs: mds: place MDSGatherBuilder on the stack
    ([pr#36967](https://github.com/ceph/ceph/pull/36967), Patrick
    Donnelly)
-   cephfs: mds: recover files after normal session close
    ([pr#37178](https://github.com/ceph/ceph/pull/37178), \"Yan,
    Zheng\")
-   cephfs: mds: resolve SIGSEGV in waiting for uncommitted fragments
    ([pr#36968](https://github.com/ceph/ceph/pull/36968), Patrick
    Donnelly)
-   cephfs: osdc/Journaler: do not call onsafe-\>complete() if onsafe is
    0 ([pr#37229](https://github.com/ceph/ceph/pull/37229), Xiubo Li)
-   client: handle readdir reply without Fs cap
    ([pr#37232](https://github.com/ceph/ceph/pull/37232), \"Yan,
    Zheng\")
-   common, osd: add sanity checks around osd_scrub_max_preemptions
    ([pr#37470](https://github.com/ceph/ceph/pull/37470), xie xingguo)
-   common/config: less noise about configs from mon we cant apply
    ([pr#36289](https://github.com/ceph/ceph/pull/36289), Sage Weil\')
-   common: ignore SIGHUP prior to fork
    ([issue#46269](http://tracker.ceph.com/issues/46269),
    [pr#36181](https://github.com/ceph/ceph/pull/36181), Willem Jan
    Withagen, hzwuhongsong)
-   compressor: Add a config option to specify Zstd compression level
    ([pr#37254](https://github.com/ceph/ceph/pull/37254), Bryan
    Stillwell)
-   core: include/encoding: Fix encode/decode of float types on
    big-endian systems
    ([pr#37033](https://github.com/ceph/ceph/pull/37033), Ulrich
    Weigand)
-   doc/rados: Fix osd_op_queue default value
    ([pr#36354](https://github.com/ceph/ceph/pull/36354), Benoxc3xaet
    Knecht)
-   doc/rados: Fix osd_scrub_during_recovery default value
    ([pr#37472](https://github.com/ceph/ceph/pull/37472), Benoxc3xaet
    Knecht)
-   doc/rbd: add rbd-target-gw enable and start
    ([pr#36415](https://github.com/ceph/ceph/pull/36415), Zac Dover)
-   doc: enable Read the Docs
    ([pr#37204](https://github.com/ceph/ceph/pull/37204), Kefu Chai)
-   krbd: optionally skip waiting for udev events
    ([pr#37284](https://github.com/ceph/ceph/pull/37284), Ilya Dryomov)
-   kv/RocksDBStore: make options
    compaction_threads/disableWAL/flusher_txe2x80xa6
    ([pr#37055](https://github.com/ceph/ceph/pull/37055), Jianpeng Ma)
-   librados: add LIBRADOS_SUPPORTS_GETADDRS support
    ([pr#36853](https://github.com/ceph/ceph/pull/36853), Xiubo Li,
    Jason Dillaman, Kaleb S. KEITHLEY, Kefu Chai)
-   messages,mds: Fix decoding of enum types on big-endian systems
    ([pr#36814](https://github.com/ceph/ceph/pull/36814), Ulrich
    Weigand)
-   mgr/balancer: use \"==\" and \"!=\" for comparing str
    ([pr#37471](https://github.com/ceph/ceph/pull/37471), Kefu Chai)
-   mgr/dashboard/api: increase API health timeout
    ([pr#36607](https://github.com/ceph/ceph/pull/36607), Ernesto
    Puerta)
-   mgr/dashboard: Allow editing iSCSI targets with initiators logged-in
    ([pr#37278](https://github.com/ceph/ceph/pull/37278), Tiago Melo)
-   mgr/dashboard: Disabling the form inputs for the read_only modals
    ([pr#37241](https://github.com/ceph/ceph/pull/37241), Nizamudeen)
-   mgr/dashboard: Dont use any xlf file when building the default
    language ([pr#37550](https://github.com/ceph/ceph/pull/37550),
    Sebastian Krah\')
-   mgr/dashboard: Fix many-to-many issue in host-details Grafana
    dashboard ([pr#37306](https://github.com/ceph/ceph/pull/37306),
    Patrick Seidensal)
-   mgr/dashboard: Fix pool renaming functionality
    ([pr#37510](https://github.com/ceph/ceph/pull/37510), Stephan
    Mxc3xbcller, Ernesto Puerta)
-   mgr/dashboard: Hide table action input field if limit=0
    ([pr#36783](https://github.com/ceph/ceph/pull/36783), Volker Theile)
-   mgr/dashboard: Monitoring: Fix for the infinite loading bar action
    ([pr#37161](https://github.com/ceph/ceph/pull/37161), Nizamudeen A)
-   mgr/dashboard: REST API returns 500 when no Content-Type is
    specified ([pr#37307](https://github.com/ceph/ceph/pull/37307), Avan
    Thakkar)
-   mgr/dashboard: Unable to edit iSCSI logged-in client
    ([pr#36613](https://github.com/ceph/ceph/pull/36613), Ricardo
    Marques)
-   mgr/dashboard: cpu stats incorrectly displayed
    ([pr#37295](https://github.com/ceph/ceph/pull/37295), Avan Thakkar)
-   mgr/dashboard: document Prometheus security model
    ([pr#36920](https://github.com/ceph/ceph/pull/36920), Patrick
    Seidensal)
-   mgr/dashboard: fix broken backporting
    ([pr#37505](https://github.com/ceph/ceph/pull/37505), Ernesto
    Puerta)
-   mgr/dashboard: fix perf. issue when listing large amounts of buckets
    ([pr#37280](https://github.com/ceph/ceph/pull/37280), Alfonso
    Martxc3xadnez)
-   mgr/dashboard: fix pool usage calculation
    ([pr#37309](https://github.com/ceph/ceph/pull/37309), Ernesto
    Puerta)
-   mgr/dashboard: remove \"This week/month/year\" and \"Today\" time
    stamps ([pr#36790](https://github.com/ceph/ceph/pull/36790), Avan
    Thakkar)
-   mgr/dashboard: table detail rows overflow
    ([pr#37324](https://github.com/ceph/ceph/pull/37324), Aashish
    Sharma)
-   mgr/dashboard: wait longer for health status to be cleared
    ([pr#36784](https://github.com/ceph/ceph/pull/36784), Tatjana
    Dehler)
-   mgr/devicehealth: fix daemon filtering before scraping device
    ([pr#36741](https://github.com/ceph/ceph/pull/36741), Yaarit Hatuka)
-   mgr/diskprediction_local: Fix array size error
    ([pr#36578](https://github.com/ceph/ceph/pull/36578), Benoxc3xaet
    Knecht)
-   mgr/prometheus: automatically discover RBD pools for stats gathering
    ([pr#36412](https://github.com/ceph/ceph/pull/36412), Jason
    Dillaman)
-   mgr/restful: use dict.items() for py3 compatible
    ([pr#36670](https://github.com/ceph/ceph/pull/36670), Kefu Chai)
-   mgr/status: metadata is fetched async
    ([pr#37558](https://github.com/ceph/ceph/pull/37558), Michael
    Fritch)
-   mgr/telemetry: fix device id splitting when anonymizing serial
    ([pr#37318](https://github.com/ceph/ceph/pull/37318), Yaarit Hatuka)
-   mgr/volumes: add global lock debug
    ([pr#36828](https://github.com/ceph/ceph/pull/36828), Patrick
    Donnelly)
-   mgr: Add missing states to PG_STATES in mgr_module.py
    ([pr#36785](https://github.com/ceph/ceph/pull/36785), Harley
    Gorrell)
-   mgr: decrease pool stats if pg was removed
    ([pr#37476](https://github.com/ceph/ceph/pull/37476), Aleksei
    Gutikov)
-   mgr: don\'t update pending service map epoch on receiving map from
    mon ([pr#37181](https://github.com/ceph/ceph/pull/37181), Mykola
    Golub\')
-   minor tweaks to fix compile issues under latest Fedora
    ([pr#36726](https://github.com/ceph/ceph/pull/36726), Willem Jan
    Withagen, Kaleb S. KEITHLEY, Kefu Chai)
-   mon/OSDMonitor: only take in osd into consideration when trimming
    osdmaps ([pr#36982](https://github.com/ceph/ceph/pull/36982), Kefu
    Chai)
-   mon/PGMap: add pg count for pools in the ceph df command
    ([pr#36944](https://github.com/ceph/ceph/pull/36944), Vikhyat Umrao)
-   mon: Warn when too many reads are repaired on an OSD
    ([pr#36379](https://github.com/ceph/ceph/pull/36379), David Zafman)
-   mon: fix the Error ERANGEmessage when conf \"osd_objectstore\" is
    filestore\' ([pr#37474](https://github.com/ceph/ceph/pull/37474),
    wangyunqing\')
-   mon: mark pgtemp messages as no_reply more consistenly in
    preprocess\\\_xe2x80xa6
    ([pr#37171](https://github.com/ceph/ceph/pull/37171), Greg Farnum)
-   mon: store mon updates in ceph context for future MonMap
    instantiation ([pr#36704](https://github.com/ceph/ceph/pull/36704),
    Patrick Donnelly, Shyamsundar Ranganathan)
-   monclient: schedule first tick using mon_client_hunt_interval
    ([pr#36634](https://github.com/ceph/ceph/pull/36634), Mykola Golub)
-   msg/async/ProtocolV2: allow rxbuf/txbuf get bigger in testing
    ([pr#37081](https://github.com/ceph/ceph/pull/37081), Ilya Dryomov)
-   osd/OSDCap: rbd profile permits use of \"rbd_info\"
    ([pr#36413](https://github.com/ceph/ceph/pull/36413), Florian
    Florensa)
-   osd/PeeringState: prevent peers num_objects going negative
    ([pr#37473](https://github.com/ceph/ceph/pull/37473), xie xingguo\')
-   prometheus: Properly split the port off IPv6 addresses
    ([pr#36984](https://github.com/ceph/ceph/pull/36984), Matthew
    Oliver)
-   rbd: include RADOS namespace in krbd symlinks
    ([pr#37468](https://github.com/ceph/ceph/pull/37468), Ilya Dryomov)
-   rbd: librbd: Align rbd_write_zeroes declarations
    ([pr#36712](https://github.com/ceph/ceph/pull/36712), Corey Bryant)
-   rbd: librbd: dont resend async_complete if watcher is unregistered
    ([pr#37040](https://github.com/ceph/ceph/pull/37040), Mykola
    Golub\')
-   rbd: librbd: global and pool-level config overrides require image
    refresh to apply
    ([pr#36725](https://github.com/ceph/ceph/pull/36725), Jason
    Dillaman)
-   rbd: librbd: using migration abort can result in the loss of data
    ([pr#37165](https://github.com/ceph/ceph/pull/37165), Jason
    Dillaman)
-   rbd: make common options override krbd-specific options
    ([pr#37407](https://github.com/ceph/ceph/pull/37407), Ilya Dryomov)
-   rgw/cls: preserve olh entrys name on last unlink
    ([pr#37462](https://github.com/ceph/ceph/pull/37462), Casey
    Bodley\')
-   rgw: Add bucket name to bucket stats error logging
    ([pr#37378](https://github.com/ceph/ceph/pull/37378), Seena Fallah)
-   rgw: Empty reqs_change_state queue before unregistered_reqs
    ([pr#37461](https://github.com/ceph/ceph/pull/37461), Soumya Koduri)
-   rgw: Expiration days cant be zero and transition days can be zero
    ([pr#37465](https://github.com/ceph/ceph/pull/37465), zhang
    Shaowen\')
-   rgw: RGWObjVersionTracker tracks version over increments
    ([pr#37459](https://github.com/ceph/ceph/pull/37459), Casey Bodley)
-   rgw: Swift API anonymous access should 401
    ([pr#37438](https://github.com/ceph/ceph/pull/37438), Matthew
    Oliver)
-   rgw: add access log to the beast frontend
    ([pr#36727](https://github.com/ceph/ceph/pull/36727), Mark Kogan)
-   rgw: add negative cache to the system object
    ([pr#37460](https://github.com/ceph/ceph/pull/37460), Or Friedmann)
-   rgw: append obj: prevent tail from being GCed
    ([pr#36390](https://github.com/ceph/ceph/pull/36390), Abhishek
    Lekshmanan\')
-   rgw: dump transitions in RGWLifecycleConfiguration::dump()
    ([pr#36880](https://github.com/ceph/ceph/pull/36880), Shengming
    Zhang)
-   rgw: fail when get/set-bucket-versioning attempted on a non-existent
    xe2x80xa6 ([pr#36188](https://github.com/ceph/ceph/pull/36188), Matt
    Benjamin)
-   rgw: fix boost::asio::async_write() does not return error
    ([pr#37157](https://github.com/ceph/ceph/pull/37157), Mark Kogan)
-   rgw: fix double slash (//) killing the gateway
    ([pr#36682](https://github.com/ceph/ceph/pull/36682), Theofilos
    Mouratidis)
-   rgw: fix shutdown crash in RGWAsyncReadMDLogEntries
    ([pr#37463](https://github.com/ceph/ceph/pull/37463), Casey Bodley)
-   rgw: hold reloader using unique_ptr
    ([pr#36770](https://github.com/ceph/ceph/pull/36770), Kefu Chai)
-   rgw: log resharding events at level 1 (formerly 20)
    ([pr#36843](https://github.com/ceph/ceph/pull/36843), Or Friedmann)
-   rgw: ordered bucket listing code clean-up
    ([pr#37169](https://github.com/ceph/ceph/pull/37169), J. Eric
    Ivancich)
-   rgw: policy: reuse eval_principal to evaluate the policy principal
    ([pr#36637](https://github.com/ceph/ceph/pull/36637), Abhishek
    Lekshmanan)
-   rgw: radosgw-admin: period pull command is not always a
    raw_storage_op ([pr#37464](https://github.com/ceph/ceph/pull/37464),
    Casey Bodley)
-   rgw: replace +with \"%20\" in canonical query string for s3 v4
    auth\' ([pr#37467](https://github.com/ceph/ceph/pull/37467),
    yuliyang_yewu\')
-   rgw: urlencode bucket name when forwarding request
    ([pr#37435](https://github.com/ceph/ceph/pull/37435), caolei)
-   run-make-check.sh: extract run-make.sh + run sudo with absolute path
    ([pr#36494](https://github.com/ceph/ceph/pull/36494), Kefu Chai,
    Ernesto Puerta)
-   systemd: Support Graceful Reboot for AIO Node
    ([pr#37301](https://github.com/ceph/ceph/pull/37301), Wong Hoi Sing
    Edison)
-   tools/osdmaptool.cc: add ability to clean_temps
    ([pr#37477](https://github.com/ceph/ceph/pull/37477), Neha Ojha)
-   tools/rados: Set locator key when exporting or importing a pool
    ([pr#37475](https://github.com/ceph/ceph/pull/37475), Iain Buclaw)

## v14.2.11 Nautilus

This is the eleventh backport release in the Nautilus series. This
release brings a number of bugfixes across all major components of Ceph.
We recommend that all Nautilus users upgrade to this release.

### Notable Changes

-   RGW: The `radosgw-admin` sub-commands dealing with orphans
    \--`radosgw-admin orphans find`, `radosgw-admin orphans finish`,
    `radosgw-admin orphans list-jobs` \-- have been deprecated. They
    have not been actively maintained and they store intermediate
    results on the cluster, which could fill a nearly-full cluster. They
    have been replaced by a tool, currently considered experimental,
    `rgw-orphan-list`.
-   Now when noscrub and/or nodeep-scrub flags are set globally or per
    pool, scheduled scrubs of the type disabled will be aborted. All
    user initiated scrubs are NOT interrupted.
-   Fixed a ceph-osd crash in \_committed_osd_maps when there is a
    failure to encode the first incremental map.
    [issue#46443](https://tracker.ceph.com/issues/46443)

### Changelog

-   bluestore: core: os/bluestore: fix large (\>2GB) writes when
    bluefs_buffered_io = true
    ([pr#35404](https://github.com/ceph/ceph/pull/35404), Igor Fedotov)
-   bluestore: os/bluestore: implement Hybrid allocator
    ([pr#35500](https://github.com/ceph/ceph/pull/35500), Adam Kupczyk,
    Kefu Chai, Igor Fedotov, xie xingguo)
-   build/ops: build/ops: selinux: allow ceph_t amqp_port_t:tcp_socket
    ([pr#36190](https://github.com/ceph/ceph/pull/36190), Kaleb S.
    KEITHLEY, Thomas Serlin)
-   ceph-volume: add dmcrypt support in raw mode
    ([pr#35831](https://github.com/ceph/ceph/pull/35831), Guillaume
    Abrioux)
-   cephfs,pybind: pybind/cephfs: fix custom exception raised by
    cephfs.pyx ([pr#36180](https://github.com/ceph/ceph/pull/36180),
    Ramana Raja)
-   cephfs: ceph_fuse: add the \'-d\' option back for libfuse
    ([pr#35398](https://github.com/ceph/ceph/pull/35398), Xiubo Li)
-   cephfs: client: fix directory inode can not call release callback
    ([pr#36177](https://github.com/ceph/ceph/pull/36177), sepia-liu)
-   cephfs: client: fix setxattr for 0 size value (NULL value)
    ([pr#36173](https://github.com/ceph/ceph/pull/36173), Sidharth
    Anupkrishnan)
-   cephfs: client: fix snap directory atime
    ([pr#36169](https://github.com/ceph/ceph/pull/36169), Luis
    Henriques)
-   cephfs: client: introduce timeout for client shutdown
    ([issue#44276](http://tracker.ceph.com/issues/44276),
    [pr#36215](https://github.com/ceph/ceph/pull/36215), Venky Shankar)
-   cephfs: client: release the client_lock before copying data in read
    ([pr#36294](https://github.com/ceph/ceph/pull/36294), Chencan)
-   cephfs: client: static dirent for readdir is not thread-safe
    ([pr#36511](https://github.com/ceph/ceph/pull/36511), Patrick
    Donnelly)
-   cephfs: mds: add config to require forward to auth MDS
    ([pr#35377](https://github.com/ceph/ceph/pull/35377), simon gao)
-   cephfs: mds: cleanup uncommitted fragments before mds goes to active
    ([pr#35397](https://github.com/ceph/ceph/pull/35397), \"Yan,
    Zheng\")
-   cephfs: mds: do not raise \"client failing to respond to cap
    release\" when client working set is reasonable
    ([pr#36513](https://github.com/ceph/ceph/pull/36513), Patrick
    Donnelly)
-   cephfs: mds: do not submit omap_rm_keys if the dir is the basedir of
    merge ([pr#36178](https://github.com/ceph/ceph/pull/36178), Chencan)
-   cephfs: mds: fix filelock state when Fc is issued
    ([pr#35841](https://github.com/ceph/ceph/pull/35841), Xiubo Li)
-   cephfs: mds: fix hang issue when accessing a file under a lost
    parent directory
    ([pr#36179](https://github.com/ceph/ceph/pull/36179), Zhi Zhang)
-   cephfs: mds: fix nullptr dereference in MDCache::finish_rollback
    ([pr#36439](https://github.com/ceph/ceph/pull/36439), \"Yan,
    Zheng\")
-   cephfs: mds: flag backtrace scrub failures for new files as okay
    ([pr#35400](https://github.com/ceph/ceph/pull/35400), Milind
    Changire)
-   cephfs: mds: initialize MDSlaveUpdate::waiter
    ([pr#36462](https://github.com/ceph/ceph/pull/36462), \"Yan,
    Zheng\")
-   cephfs: mds: make threshold for MDS_TRIM configurable
    ([pr#36175](https://github.com/ceph/ceph/pull/36175), Paul Emmerich)
-   cephfs: mds: preserve ESlaveUpdate logevent until receiving
    OP_FINISH ([pr#35394](https://github.com/ceph/ceph/pull/35394),
    Varsha Rao, songxinying)
-   cephfs: mds: reset heartbeat in EMetaBlob replay
    ([pr#36170](https://github.com/ceph/ceph/pull/36170), Yanhu Cao)
-   cephfs: mgr/fs/volumes misc fixes
    ([pr#36167](https://github.com/ceph/ceph/pull/36167), Patrick
    Donnelly, Kotresh HR, Ramana Raja)
-   cephfs: mgr/volumes: Add snapshot info command
    ([pr#35672](https://github.com/ceph/ceph/pull/35672), Kotresh HR)
-   cephfs: mgr/volumes: Deprecate protect/unprotect CLI calls for
    subvolume snapshots
    ([pr#36166](https://github.com/ceph/ceph/pull/36166), Shyamsundar
    Ranganathan)
-   cephfs: qa: add debugging for volumes plugin use of libcephfs
    ([pr#36512](https://github.com/ceph/ceph/pull/36512), Patrick
    Donnelly)
-   cephfs: qa: skip cache_size check
    ([pr#36526](https://github.com/ceph/ceph/pull/36526), Patrick
    Donnelly)
-   cephfs: tools/cephfs: don\'t bind to public_addr
    ([pr#35401](https://github.com/ceph/ceph/pull/35401), \"Yan,
    Zheng\")
-   cephfs: vstart_runner: set mounted to True at the end of mount()
    ([pr#35396](https://github.com/ceph/ceph/pull/35396), Rishabh Dave)
-   core,mon: mon/OSDMonitor: Reset grace period if failure interval
    exceeds a threshold
    ([pr#35798](https://github.com/ceph/ceph/pull/35798), Sridhar
    Seshasayee)
-   core: mgr/DaemonServer.cc: make \'config show\' on fsid work
    ([pr#36074](https://github.com/ceph/ceph/pull/36074), Neha Ojha)
-   core: mgr/alert: can\'t set
    inventory_cache_timeout/service_cache_timeout from CLI
    ([pr#36104](https://github.com/ceph/ceph/pull/36104), Kiefer Chang)
-   core: osd/PG: fix history.same_interval_since of merge target again
    ([pr#36161](https://github.com/ceph/ceph/pull/36161), xie xingguo)
-   core: osd/PeeringState.h: Fix pg stuck in WaitActingChange
    ([pr#35389](https://github.com/ceph/ceph/pull/35389), chen qiuzhang)
-   core: osd: Cancel in-progress scrubs (not user requested)
    ([pr#36292](https://github.com/ceph/ceph/pull/36292), David Zafman)
-   core: osd: fix crash in \_committed_osd_maps if incremental osdmap
    crc fails ([pr#36339](https://github.com/ceph/ceph/pull/36339), Neha
    Ojha, Dan van der Ster)
-   core: osd: make \"missing incremental map\" a debug log message
    ([pr#35386](https://github.com/ceph/ceph/pull/35386), Nathan Cutler)
-   core: osd: make message cap option usable again
    ([pr#35738](https://github.com/ceph/ceph/pull/35738), Neha Ojha,
    Josh Durgin)
-   mgr/dashboard: Allow to edit iSCSI target with active session
    ([pr#35998](https://github.com/ceph/ceph/pull/35998), Ricardo
    Marques)
-   mgr/dashboard: Prevent dashboard breakdown on bad pool selection
    ([pr#35367](https://github.com/ceph/ceph/pull/35367), Stephan
    Müller)
-   mgr/dashboard: Prometheus query error in the metrics of Pools, OSDs
    and RBD images ([pr#35884](https://github.com/ceph/ceph/pull/35884),
    Avan Thakkar)
-   mgr/dashboard: add popover list of Stand-by Managers & Metadata
    Servers (MDS) in landing page
    ([pr#34095](https://github.com/ceph/ceph/pull/34095), Kiefer Chang,
    Avan Thakkar)
-   mgr/dashboard: fix Source column i18n issue in RBD configuration
    tables ([pr#35822](https://github.com/ceph/ceph/pull/35822), Kiefer
    Chang)
-   mgr/k8sevents: sanitise kubernetes events
    ([pr#35563](https://github.com/ceph/ceph/pull/35563), Paul Cuzner)
-   mgr/prometheus: improve Prometheus module cache
    ([pr#35918](https://github.com/ceph/ceph/pull/35918), Patrick
    Seidensal)
-   mgr: mgr/progress: Skip pg_summary update if \_events dict is empty
    ([pr#36075](https://github.com/ceph/ceph/pull/36075), Manuel Lausch)
-   mgr: mgr/telemetry: force \--license when sending while opted-out
    ([pr#35390](https://github.com/ceph/ceph/pull/35390), Yaarit Hatuka)
-   mgr: mon/PGMap: do not consider changing pg stuck
    ([pr#35959](https://github.com/ceph/ceph/pull/35959), Kefu Chai)
-   monitoring: fixing some issues in RBD detail dashboard
    ([pr#35464](https://github.com/ceph/ceph/pull/35464), Kiefer Chang)
-   msgr: New msgr2 crc and secure modes (msgr2.1)
    ([pr#35733](https://github.com/ceph/ceph/pull/35733), Jianpeng Ma,
    Ilya Dryomov)
-   rbd: librbd: new \'write_zeroes\' API methods to suppliment the
    [discard]{.title-ref} APIs
    ([pr#36250](https://github.com/ceph/ceph/pull/36250), Jason
    Dillaman)
-   rbd: mgr/dashboard: work with v1 RBD images
    ([pr#35712](https://github.com/ceph/ceph/pull/35712), Ernesto
    Puerta)
-   rbd: rbd: librbd: Watcher should not attempt to re-watch after
    detecting blacklisting
    ([pr#35385](https://github.com/ceph/ceph/pull/35385), Jason
    Dillaman)
-   rgw,tests: test/rgw: update hadoop versions
    ([pr#35778](https://github.com/ceph/ceph/pull/35778), Casey Bodley,
    Vasu Kulkarni)
-   rgw: Add subuser to OPA request
    ([pr#36187](https://github.com/ceph/ceph/pull/36187), Seena Fallah)
-   rgw: Add support wildcard subuser for bucket policy
    ([pr#36186](https://github.com/ceph/ceph/pull/36186), Seena Fallah)
-   rgw: add \"rgw-orphan-list\" tool and \"radosgw-admin bucket
    radoslist \...\"
    ([pr#34127](https://github.com/ceph/ceph/pull/34127), J. Eric
    Ivancich)
-   rgw: add check for index entry\'s existing when adding bucket stats
    during bucket reshard
    ([pr#36189](https://github.com/ceph/ceph/pull/36189), zhang Shaowen)
-   rgw: add quota enforcement to CopyObj
    ([pr#36184](https://github.com/ceph/ceph/pull/36184), Casey Bodley)
-   rgw: bucket list/stats truncates for user w/ \>1000 buckets
    ([pr#36165](https://github.com/ceph/ceph/pull/36165), J. Eric
    Ivancich)
-   rgw: cls_bucket_list\_(un)ordered should clear results collection
    ([pr#36163](https://github.com/ceph/ceph/pull/36163), J. Eric
    Ivancich)
-   rgw: fix loop problem with swift stat on account
    ([pr#36185](https://github.com/ceph/ceph/pull/36185), Marcus Watts)
-   rgw: lc: fix Segmentation Fault when the tag of the object was not
    found ([pr#36086](https://github.com/ceph/ceph/pull/36086), yupeng
    chen, zhuo li)
-   rgw: ordered listing lcv not managed correctly
    ([pr#35882](https://github.com/ceph/ceph/pull/35882), J. Eric
    Ivancich)
-   rgw: radoslist incomplete multipart uploads fix marker progression
    ([pr#36191](https://github.com/ceph/ceph/pull/36191), J. Eric
    Ivancich)
-   rgw: rgw/iam: correcting the result of get role policy
    ([pr#36193](https://github.com/ceph/ceph/pull/36193), Pritha
    Srivastava)
-   rgw: rgw/url: fix amqp urls with vhosts
    ([pr#35384](https://github.com/ceph/ceph/pull/35384), Yuval
    Lifshitz)
-   rgw: stop realm reloader before store shutdown
    ([pr#36192](https://github.com/ceph/ceph/pull/36192), Casey Bodley)
-   tools: Add statfs operation to ceph-objecstore-tool
    ([pr#35713](https://github.com/ceph/ceph/pull/35713), David Zafman)

## v14.2.10 Nautilus

This is the tenth release in the Nautilus series. In addition to fixing
a security-related bug in RGW, this release brings a number of bugfixes
across all major components of Ceph. We recommend that all Nautilus
users upgrade to this release.

### Notable Changes

-   CVE-2020-10753: rgw: sanitize newlines in s3 CORSConfiguration\'s
    ExposeHeader (William Bowling, Adam Mohammed, Casey Bodley)

-   RGW: Bucket notifications now support Kafka endpoints. This requires
    librdkafka of version 0.9.2 and up. Note that Ubuntu 16.04.6 LTS
    (Xenial Xerus) has an older version of librdkafka, and would require
    an update to the library.

-   The pool parameter `target_size_ratio`, used by the pg autoscaler,
    has changed meaning. It is now normalized across pools, rather than
    specifying an absolute ratio. For details, see
    `pg-autoscaler`{.interpreted-text role="ref"}. If you have set
    target size ratios on any pools, you may want to set these pools to
    autoscale `warn` mode to avoid data movement during the upgrade:

        ceph osd pool set <pool-name> pg_autoscale_mode warn

-   The behaviour of the `-o` argument to the rados tool has been
    reverted to its original behaviour of indicating an output file.
    This reverts it to a more consistent behaviour when compared to
    other tools. Specifying object size is now accomplished by using an
    upper case O `-O`.

-   The format of MDSs in [ceph fs dump]{.title-ref} has changed.

-   Ceph will issue a health warning if a RADOS pool\'s `size` is set to
    1 or in other words the pool is configured with no redundancy. This
    can be fixed by setting the pool size to the minimum recommended
    value with:

        ceph osd pool set <pool-name> size <num-replicas>

    The warning can be silenced with:

        ceph config set global mon_warn_on_pool_no_redundancy false

-   RGW: bucket listing performance on sharded bucket indexes has been
    notably improved by heuristically \-- and significantly, in many
    cases \-- reducing the number of entries requested from each bucket
    index shard.

### Changelog

-   build/ops: address SElinux denials observed in rgw/multisite test
    run ([pr#34539](https://github.com/ceph/ceph/pull/34539), Kefu Chai,
    Kaleb S. Keithley)
-   build/ops: ceph.spec.in: build on el8
    ([pr#35599](https://github.com/ceph/ceph/pull/35599), Kefu Chai,
    Brad Hubbard, Alfonso Martínez, Nathan Cutler, Sage Weil,
    luo.runbing)
-   build/ops: cmake: Improve test for 16-byte atomic support on IBM Z
    ([pr#33716](https://github.com/ceph/ceph/pull/33716), Ulrich
    Weigand)
-   build/ops: do_cmake.sh: fix application of
    -DWITH_RADOSGW_KAFKA_ENDPOINT=OFF
    ([pr#34008](https://github.com/ceph/ceph/pull/34008), Nathan Cutler,
    Kefu Chai)
-   build/ops: install-deps.sh: Use dnf for rhel/centos 8
    ([pr#35461](https://github.com/ceph/ceph/pull/35461), Brad Hubbard)
-   build/ops: rpm: add python3-saml as install dependency
    ([pr#34475](https://github.com/ceph/ceph/pull/34475), Kefu Chai,
    Ernesto Puerta)
-   build/ops: selinux: Allow ceph to setsched
    ([pr#34433](https://github.com/ceph/ceph/pull/34433), Brad Hubbard)
-   build/ops: selinux: Allow ceph-mgr access to httpd dir
    ([pr#34434](https://github.com/ceph/ceph/pull/34434), Brad Hubbard)
-   build/ops: selinux: Allow getattr access to /proc/kcore
    ([pr#34870](https://github.com/ceph/ceph/pull/34870), Brad Hubbard)
-   build/ops: spec: address some warnings raised by RPM 4.15.1
    ([pr#34527](https://github.com/ceph/ceph/pull/34527), Nathan Cutler)
-   ceph-volume/batch: check lvs list before access
    ([pr#34481](https://github.com/ceph/ceph/pull/34481), Jan Fajerski)
-   ceph-volume/batch: return success when all devices are filtered
    ([pr#34478](https://github.com/ceph/ceph/pull/34478), Jan Fajerski)
-   ceph-volume: add and delete lvm tags in a single lvchange call
    ([pr#35453](https://github.com/ceph/ceph/pull/35453), Jan Fajerski)
-   ceph-volume: add ceph.osdspec_affinity tag
    ([pr#35132](https://github.com/ceph/ceph/pull/35132), Joshua Schmid)
-   ceph-volume: devices/simple/scan: Fix string in log statement
    ([pr#34445](https://github.com/ceph/ceph/pull/34445), Jan Fajerski)
-   ceph-volume: fix nautilus functional tests
    ([pr#33391](https://github.com/ceph/ceph/pull/33391), Jan Fajerski)
-   ceph-volume: lvm: get_device_vgs() filter by provided prefix
    ([pr#33616](https://github.com/ceph/ceph/pull/33616), Jan Fajerski,
    Yehuda Sadeh)
-   ceph-volume: prepare: use \*-slots arguments for implicit sizing
    ([pr#34278](https://github.com/ceph/ceph/pull/34278), Jan Fajerski)
-   ceph-volume: silence \'ceph-bluestore-tool\' failures
    ([pr#33428](https://github.com/ceph/ceph/pull/33428), Sébastien Han)
-   ceph-volume: strip \_dmcrypt suffix in simple scan json output
    ([pr#33722](https://github.com/ceph/ceph/pull/33722), Jan Fajerski)
-   cephfs/tools: add accounted_rstat/rstat when building file dentry
    ([pr#35185](https://github.com/ceph/ceph/pull/35185), Xiubo Li)
-   cephfs/tools: cephfs-journal-tool: correctly parse \--dry_run
    argument ([pr#34784](https://github.com/ceph/ceph/pull/34784),
    Milind Changire)
-   cephfs: allow pool names with hyphen and period
    ([pr#35391](https://github.com/ceph/ceph/pull/35391), Rishabh Dave,
    Ramana Raja)
-   cephfs: ceph-fuse: link to libfuse3 and pass \"-o big_writes\" to
    libfuse if libfuse \< 3.0.0
    ([pr#34771](https://github.com/ceph/ceph/pull/34771), Kefu Chai,
    Xiubo Li, \"Yan, Zheng\")
-   cephfs: client: expose Client::ll_register_callback via libcephfs
    ([pr#35393](https://github.com/ceph/ceph/pull/35393), Kefu Chai,
    Jeff Layton)
-   cephfs: client: fix Finisher assert failure
    ([pr#35000](https://github.com/ceph/ceph/pull/35000), Xiubo Li)
-   cephfs: client: fix bad error handling in lseek SEEK_HOLE /
    SEEK_DATA ([pr#34308](https://github.com/ceph/ceph/pull/34308), Jeff
    Layton)
-   cephfs: client: only set MClientCaps::FLAG_SYNC when flushing dirty
    auth caps ([pr#35118](https://github.com/ceph/ceph/pull/35118), Jeff
    Layton)
-   cephfs: client: reset requested_max_size if file write is not wanted
    ([pr#34767](https://github.com/ceph/ceph/pull/34767), \"Yan,
    Zheng\")
-   cephfs: mds: Handle blacklisted error in purge queue
    ([pr#35149](https://github.com/ceph/ceph/pull/35149), Varsha Rao)
-   cephfs: mds: SIGSEGV in Migrator::export_sessions_flushed
    ([pr#33751](https://github.com/ceph/ceph/pull/33751), \"Yan,
    Zheng\")
-   cephfs: mds: Using begin() and empty() to iterate the xlist
    ([pr#34338](https://github.com/ceph/ceph/pull/34338), Shen Hang,
    \"Yan, Zheng\")
-   cephfs: mds: add configurable snapshot limit
    ([pr#33295](https://github.com/ceph/ceph/pull/33295), Milind
    Changire)
-   cephfs: mds: display scrub status in ceph status
    ([issue#41508](http://tracker.ceph.com/issues/41508),
    [issue#42713](http://tracker.ceph.com/issues/42713),
    [issue#44520](http://tracker.ceph.com/issues/44520),
    [issue#42168](http://tracker.ceph.com/issues/42168),
    [issue#42169](http://tracker.ceph.com/issues/42169),
    [issue#42569](http://tracker.ceph.com/issues/42569),
    [issue#41424](http://tracker.ceph.com/issues/41424),
    [issue#42835](http://tracker.ceph.com/issues/42835),
    [issue#36370](http://tracker.ceph.com/issues/36370),
    [issue#42325](http://tracker.ceph.com/issues/42325),
    [pr#30704](https://github.com/ceph/ceph/pull/30704), Venky Shankar,
    Patrick Donnelly, Sage Weil, Kefu Chai)
-   cephfs: mds: don\'t shallow copy when decoding xattr map
    ([pr#35199](https://github.com/ceph/ceph/pull/35199), \"Yan,
    Zheng\")
-   cephfs: mds: handle bad purge queue item encoding
    ([pr#34307](https://github.com/ceph/ceph/pull/34307), \"Yan,
    Zheng\")
-   cephfs: mds: handle ceph_assert on blacklisting
    ([pr#34435](https://github.com/ceph/ceph/pull/34435), Milind
    Changire)
-   cephfs: mds: just delete MDSIOContextBase during shutdown
    ([pr#34343](https://github.com/ceph/ceph/pull/34343), \"Yan,
    Zheng\", Patrick Donnelly)
-   cephfs: mds: take xlock in the order requests start locking
    ([pr#35392](https://github.com/ceph/ceph/pull/35392), \"Yan,
    Zheng\")
-   common/bl: fix memory corruption in bufferlist::claim_append()
    ([pr#34516](https://github.com/ceph/ceph/pull/34516), Radoslaw
    Zarzynski)
-   common/blkdev: compilation of telemetry and device backports
    ([pr#33726](https://github.com/ceph/ceph/pull/33726), Sage Weil,
    Difan Zhang, Patrick Seidensal, Kefu Chai)
-   common/blkdev: fix some problems with smart scraping
    ([pr#33421](https://github.com/ceph/ceph/pull/33421), Sage Weil)
-   common/ceph_time: tolerate mono time going backwards
    ([pr#34542](https://github.com/ceph/ceph/pull/34542), Sage Weil)
-   common/options: Disable bluefs_buffered_io by default again
    ([pr#34297](https://github.com/ceph/ceph/pull/34297), Mark Nelson)
-   compressor/lz4: work around bug in liblz4 versions \<1.8.2
    ([pr#35004](https://github.com/ceph/ceph/pull/35004), Sage Weil, Dan
    van der Ster)
-   core: bluestore/bdev: initialize size when creating object
    ([pr#34832](https://github.com/ceph/ceph/pull/34832), Willem Jan
    Withagen)
-   core: bluestore: Don\'t pollute old journal when add new device
    ([pr#34796](https://github.com/ceph/ceph/pull/34796), Yang Honggang)
-   core: bluestore: fix \'unused\' calculation
    ([pr#34794](https://github.com/ceph/ceph/pull/34794), xie xingguo,
    Igor Fedotov)
-   core: bluestore: fix extent leak after main device expand
    ([pr#34711](https://github.com/ceph/ceph/pull/34711), Igor Fedotov)
-   core: bluestore: more flexible DB volume space usage
    ([pr#33889](https://github.com/ceph/ceph/pull/33889), Igor Fedotov)
-   core: bluestore: open DB in read-only when expanding DB/WAL
    ([pr#34611](https://github.com/ceph/ceph/pull/34611), Igor Fedotov,
    Jianpeng Ma, Adam Kupczyk)
-   core: bluestore: prevent BlueFS::dirty_files from being leaked when
    syncing metadata
    ([pr#34515](https://github.com/ceph/ceph/pull/34515), Xuehan Xu)
-   core: msg/async/rdma: fix bug event center is blocked by rdma
    construct connection for transport ib sync msg
    ([pr#34780](https://github.com/ceph/ceph/pull/34780), Peng Liu)
-   core: msgr: backport the EventCenter-related fixes
    ([pr#33820](https://github.com/ceph/ceph/pull/33820), Radoslaw
    Zarzynski, Jeff Layton, Kefu Chai)
-   core: rados: prevent ShardedOpWQ suicide_grace drop when waiting for
    work ([pr#34882](https://github.com/ceph/ceph/pull/34882), Dan Hill)
-   doc/mgr/telemetry: added device channel details
    ([pr#33684](https://github.com/ceph/ceph/pull/33684), Yaarit Hatuka)
-   doc/releases/nautilus: restart OSDs to make them bind to v2 addr
    ([pr#34524](https://github.com/ceph/ceph/pull/34524), Nathan Cutler)
-   doc: fix parameter to set pg autoscale mode
    ([pr#34518](https://github.com/ceph/ceph/pull/34518), Changcheng
    Liu)
-   doc: mds-config-ref: update \'mds_log_max_segments\' value
    ([pr#35278](https://github.com/ceph/ceph/pull/35278), Konstantin
    Shalygin)
-   doc: reset PendingReleaseNotes following 14.2.8 release
    ([pr#33863](https://github.com/ceph/ceph/pull/33863), Nathan Cutler)
-   global: ensure CEPH_ARGS is decoded before early arg processing
    ([pr#33261](https://github.com/ceph/ceph/pull/33261), Kefu Chai,
    Jason Dillaman)
-   mgr/DaemonServer: fix pg merge checks
    ([pr#34354](https://github.com/ceph/ceph/pull/34354), Sage Weil)
-   mgr/PyModule: fix missing tracebacks in handle_pyerror()
    ([pr#34627](https://github.com/ceph/ceph/pull/34627), Tim Serong)
-   mgr/balancer: tolerate pgs outside of target weight map
    ([pr#34761](https://github.com/ceph/ceph/pull/34761), Sage Weil)
-   mgr/dashboard/grafana: Add rbd-image details dashboard
    ([pr#35248](https://github.com/ceph/ceph/pull/35248), Enno Gotthold)
-   mgr/dashboard: \'destroyed\' view in CRUSH map viewer
    ([pr#33764](https://github.com/ceph/ceph/pull/33764), Avan Thakkar)
-   mgr/dashboard: Add more debug information to Dashboard RGW backend
    ([pr#34399](https://github.com/ceph/ceph/pull/34399), Volker Theile)
-   mgr/dashboard: Dashboard does not allow you to set norebalance OSD
    flag ([pr#33927](https://github.com/ceph/ceph/pull/33927),
    Nizamudeen)
-   mgr/dashboard: Disable cache for static files
    ([pr#33763](https://github.com/ceph/ceph/pull/33763), Tiago Melo)
-   mgr/dashboard: Display the aggregated number of request
    ([pr#35212](https://github.com/ceph/ceph/pull/35212), Tiago Melo)
-   mgr/dashboard: Fix HomeTest setup
    ([pr#35086](https://github.com/ceph/ceph/pull/35086), Tiago Melo)
-   mgr/dashboard: Fix cherrypy request logging error
    ([pr#31586](https://github.com/ceph/ceph/pull/31586), Kiefer Chang)
-   mgr/dashboard: Fix error in unit test caused by timezone
    ([pr#34473](https://github.com/ceph/ceph/pull/34473), Tiago Melo)
-   mgr/dashboard: Fix error when listing RBD while deleting or moving
    ([pr#34120](https://github.com/ceph/ceph/pull/34120), Tiago Melo)
-   mgr/dashboard: Fix iSCSI\'s username and password validation
    ([pr#34550](https://github.com/ceph/ceph/pull/34550), Tiago Melo)
-   mgr/dashboard: Fixes rbd image \'purge trash\' button & modal text
    ([pr#33697](https://github.com/ceph/ceph/pull/33697), anurag)
-   mgr/dashboard: Improve workaround to redraw datatables
    ([pr#34413](https://github.com/ceph/ceph/pull/34413), Volker Theile)
-   mgr/dashboard: Not able to restrict bucket creation for new user
    ([pr#34692](https://github.com/ceph/ceph/pull/34692), Volker Theile)
-   mgr/dashboard: Pool read/write OPS shows too many decimal places
    ([pr#34039](https://github.com/ceph/ceph/pull/34039), anurag,
    Ernesto Puerta)
-   mgr/dashboard: Prevent iSCSI target recreation when editing controls
    ([pr#34551](https://github.com/ceph/ceph/pull/34551), Tiago Melo)
-   mgr/dashboard: REST API: OpenAPI docs require internet connection
    ([pr#33032](https://github.com/ceph/ceph/pull/33032), Patrick
    Seidensal)
-   mgr/dashboard: RGW port autodetection does not support \"Beast\" RGW
    frontend ([pr#34400](https://github.com/ceph/ceph/pull/34400),
    Volker Theile)
-   mgr/dashboard: Refactor Python unittests and controller
    ([pr#34662](https://github.com/ceph/ceph/pull/34662), Volker Theile)
-   mgr/dashboard: Repair broken grafana panels
    ([pr#34417](https://github.com/ceph/ceph/pull/34417), Kristoffer
    Grönlund)
-   mgr/dashboard: Searchable objects for table
    ([pr#32891](https://github.com/ceph/ceph/pull/32891), Stephan
    Müller)
-   mgr/dashboard: Tabs does not handle click events
    ([issue#39326](http://tracker.ceph.com/issues/39326),
    [pr#34282](https://github.com/ceph/ceph/pull/34282), Tiago Melo)
-   mgr/dashboard: UI fixes
    ([pr#34038](https://github.com/ceph/ceph/pull/34038), Avan Thakkar)
-   mgr/dashboard: Updated existing E2E tests to match new format
    ([pr#33024](https://github.com/ceph/ceph/pull/33024), Nathan
    Weinberg)
-   mgr/dashboard: Use booleanText pipe
    ([pr#33234](https://github.com/ceph/ceph/pull/33234), Alfonso
    Martínez, Volker Theile)
-   mgr/dashboard: Use default language when running \"npm run build\"
    ([pr#33668](https://github.com/ceph/ceph/pull/33668), Tiago Melo)
-   mgr/dashboard: do not show RGW API keys if only read-only privileges
    ([pr#33665](https://github.com/ceph/ceph/pull/33665), Alfonso
    Martínez)
-   mgr/dashboard: fix COVERAGE_PATH in run-backend-api-tests.sh
    ([pr#34489](https://github.com/ceph/ceph/pull/34489), Alfonso
    Martínez)
-   mgr/dashboard: fix backport #33764
    ([pr#34640](https://github.com/ceph/ceph/pull/34640), Ernesto
    Puerta)
-   mgr/dashboard: fix error when enabling SSO with cert. file
    ([pr#34129](https://github.com/ceph/ceph/pull/34129), Alfonso
    Martínez)
-   mgr/dashboard: fix py2 strptime ImportError (not thread safe)
    ([pr#35016](https://github.com/ceph/ceph/pull/35016), Alfonso
    Martínez)
-   mgr/dashboard: fixing RBD purge error in backend
    ([pr#34847](https://github.com/ceph/ceph/pull/34847), Kiefer Chang)
-   mgr/dashboard: install teuthology using pip
    ([pr#35174](https://github.com/ceph/ceph/pull/35174), Nathan Cutler,
    Kefu Chai)
-   mgr/dashboard: list configured prometheus alerts
    ([pr#34373](https://github.com/ceph/ceph/pull/34373), Patrick
    Seidensal, Tiago Melo)
-   mgr/dashboard: monitoring menu entry should indicate firing alerts
    ([pr#34823](https://github.com/ceph/ceph/pull/34823), Tiago Melo,
    Volker Theile)
-   mgr/dashboard: remove \'config-opt: read\' perm. from system roles
    ([pr#33739](https://github.com/ceph/ceph/pull/33739), Alfonso
    Martínez)
-   mgr/dashboard: show checkboxes for booleans
    ([pr#33388](https://github.com/ceph/ceph/pull/33388), Tatjana
    Dehler)
-   mgr/dashboard: use FQDN for failover redirection
    ([pr#34497](https://github.com/ceph/ceph/pull/34497), Ernesto
    Puerta)
-   mgr/insights: fix prune-health-history
    ([pr#35214](https://github.com/ceph/ceph/pull/35214), Sage Weil)
-   mgr/pg_autoscaler: fix division by zero
    ([pr#33420](https://github.com/ceph/ceph/pull/33420), Sage Weil)
-   mgr/pg_autoscaler: treat target ratios as weights
    ([pr#34087](https://github.com/ceph/ceph/pull/34087), Josh Durgin)
-   mgr/prometheus: ceph_pg\_\* metrics contains last value instead of
    sum across all reported states
    ([pr#34162](https://github.com/ceph/ceph/pull/34162), Jacek
    Suchenia)
-   mgr/run-tox-tests: Fix issue with PYTHONPATH
    ([pr#33688](https://github.com/ceph/ceph/pull/33688), Brad Hubbard)
-   mgr/telegraf: catch FileNotFoundError exception
    ([pr#34628](https://github.com/ceph/ceph/pull/34628), Kefu Chai)
-   mgr/telemetry: add \'last_upload\' to status
    ([pr#33409](https://github.com/ceph/ceph/pull/33409), Yaarit Hatuka)
-   mgr/telemetry: catch exception during requests.put
    ([pr#33141](https://github.com/ceph/ceph/pull/33141), Sage Weil)
-   mgr/telemetry: fix UUID and STR concat
    ([pr#33666](https://github.com/ceph/ceph/pull/33666), Yaarit Hatuka)
-   mgr/telemetry: fix and document proxy usage
    ([pr#33649](https://github.com/ceph/ceph/pull/33649), Lars
    Marowsky-Bree)
-   mgr/volumes: Add interface to get subvolume metadata
    ([pr#34679](https://github.com/ceph/ceph/pull/34679), Kotresh HR)
-   mgr/volumes: fs subvolume clone cancel
    ([issue#44208](http://tracker.ceph.com/issues/44208),
    [pr#34036](https://github.com/ceph/ceph/pull/34036), Venky Shankar,
    Michael Fritch)
-   mgr/volumes: minor fixes
    ([pr#35482](https://github.com/ceph/ceph/pull/35482), Kotresh HR)
-   mgr/volumes: synchronize ownership (for symlinks) and inode
    timestamps for cloned subvolumes
    ([issue#24880](http://tracker.ceph.com/issues/24880),
    [issue#43965](http://tracker.ceph.com/issues/43965),
    [pr#33877](https://github.com/ceph/ceph/pull/33877), Ramana Raja,
    Rishabh Dave, huanwen ren, Venky Shankar, Jos Collin)
-   mgr: Add get_rates_from_data to mgr_util.py
    ([pr#33893](https://github.com/ceph/ceph/pull/33893), Stephan
    Müller, Ernesto Puerta)
-   mgr: Improve internal python to c++ interface
    ([pr#34356](https://github.com/ceph/ceph/pull/34356), David Zafman)
-   mgr: close restful socket after exec
    ([pr#35213](https://github.com/ceph/ceph/pull/35213), liushi)
-   mgr: force purge normal ceph entities from service map
    ([issue#44677](http://tracker.ceph.com/issues/44677),
    [pr#34563](https://github.com/ceph/ceph/pull/34563), Venky Shankar)
-   mgr: synchronize ClusterState\'s health and mon_status
    ([pr#34326](https://github.com/ceph/ceph/pull/34326), Radoslaw
    Zarzynski)
-   mgr: update \"hostname\" when we already have the daemon state from
    that entity ([pr#33834](https://github.com/ceph/ceph/pull/33834),
    Kefu Chai)
-   mon/FSCommands: Fix \'add_data_pool\' command and \'fs new\' command
    ([pr#34774](https://github.com/ceph/ceph/pull/34774), Ramana Raja)
-   mon/OSDMonitor: Always tune priority cache manager memory on all
    mons ([pr#34916](https://github.com/ceph/ceph/pull/34916), Sridhar
    Seshasayee)
-   mon/OSDMonitor: allow trimming maps even if osds are down
    ([pr#34983](https://github.com/ceph/ceph/pull/34983), Joao Eduardo
    Luis)
-   mon/PGMap: fix summary display of \>32bit pg states
    ([pr#33275](https://github.com/ceph/ceph/pull/33275), Sage Weil,
    Adam C. Emerson)
-   mon: Get session_map_lock before remove_session
    ([pr#34677](https://github.com/ceph/ceph/pull/34677), Xiaofei Cui)
-   mon: calculate min_size on osd pool set size
    ([pr#34585](https://github.com/ceph/ceph/pull/34585), Deepika
    Upadhyay)
-   mon: disable min pg per osd warning
    ([pr#34618](https://github.com/ceph/ceph/pull/34618), Sage Weil)
-   mon: fix/improve mon sync over small keys
    ([pr#33765](https://github.com/ceph/ceph/pull/33765), Sage Weil)
-   mon: stash newer map on bootstrap when addr doesn\'t match
    ([pr#34500](https://github.com/ceph/ceph/pull/34500), Sage Weil)
-   monitoring: Fix \"10% OSDs down\" alert description
    ([pr#35211](https://github.com/ceph/ceph/pull/35211), Benoît Knecht)
-   monitoring: Fix pool capacity incorrect
    ([pr#34450](https://github.com/ceph/ceph/pull/34450), James Cheng)
-   monitoring: alert for pool fill up broken
    ([pr#35137](https://github.com/ceph/ceph/pull/35137), Volker Theile)
-   monitoring: alert for prediction of disk and pool fill up broken
    ([pr#34394](https://github.com/ceph/ceph/pull/34394), Patrick
    Seidensal)
-   monitoring: fix RGW grafana chart \'Average GET/PUT Latencies\'
    ([pr#33860](https://github.com/ceph/ceph/pull/33860), Alfonso
    Martínez)
-   monitoring: fix decimal precision in Grafana %percentages
    ([pr#34829](https://github.com/ceph/ceph/pull/34829), Ernesto
    Puerta)
-   monitoring: root volume full alert fires false positives
    ([pr#34419](https://github.com/ceph/ceph/pull/34419), Patrick
    Seidensal)
-   osd/OSD: Log slow ops/types to cluster logs
    ([pr#33503](https://github.com/ceph/ceph/pull/33503), Sage Weil,
    Sridhar Seshasayee)
-   osd/OSDMap: Show health warning if a pool is configured with size 1
    ([pr#31842](https://github.com/ceph/ceph/pull/31842), Sridhar
    Seshasayee)
-   osd/PeeringState.h: ignore RemoteBackfillReserved in
    WaitLocalBackfillReserved
    ([pr#34512](https://github.com/ceph/ceph/pull/34512), Neha Ojha)
-   osd/PeeringState: do not trim pg log past last_update_ondisk
    ([pr#34957](https://github.com/ceph/ceph/pull/34957), Samuel Just,
    xie xingguo)
-   osd/PeeringState: transit async_recovery_targets back into acting
    before backfilling
    ([pr#32849](https://github.com/ceph/ceph/pull/32849), xie xingguo)
-   osd: dispatch_context and queue split finish on early bail-out
    ([pr#35024](https://github.com/ceph/ceph/pull/35024), Sage Weil)
-   osd: fix racy accesses to OSD::osdmap
    ([pr#33530](https://github.com/ceph/ceph/pull/33530), Radoslaw
    Zarzynski)
-   pybind/mgr/\*: fix config_notify handling of default values
    ([pr#34116](https://github.com/ceph/ceph/pull/34116), Nathan Cutler,
    Sage Weil)
-   pybind/mgr: use six==1.14.0
    ([pr#34316](https://github.com/ceph/ceph/pull/34316), Kefu Chai)
-   pybind/rbd: RBD.create() method\'s \'old_format\' parameter now
    defaults to False
    ([pr#35183](https://github.com/ceph/ceph/pull/35183), Jason
    Dillaman)
-   pybind/rbd: ensure image is open before permitting operations
    ([pr#34424](https://github.com/ceph/ceph/pull/34424), Mykola Golub)
-   pybind/rbd: fix no lockers are obtained, ImageNotFound exception
    will be output ([pr#34388](https://github.com/ceph/ceph/pull/34388),
    zhangdaolong)
-   rbd: librbd: copy API should not inherit v1 image format by default
    ([pr#35182](https://github.com/ceph/ceph/pull/35182), Jason
    Dillaman)
-   rbd: rbd-mirror: improve detection of blacklisted state
    ([pr#33533](https://github.com/ceph/ceph/pull/33533), Mykola Golub)
-   rgw/kafka: add kafka endpoint support
    ([pr#32960](https://github.com/ceph/ceph/pull/32960), Yuval
    Lifshitz, Willem Jan Withagen, Kefu Chai)
-   rgw/notifications: backporting features and bug fix
    ([pr#34107](https://github.com/ceph/ceph/pull/34107), Yuval
    Lifshitz)
-   rgw/notifications: fix topic action fail with \"MethodNotAllowed\"
    ([issue#44614](http://tracker.ceph.com/issues/44614),
    [pr#33978](https://github.com/ceph/ceph/pull/33978), Yuval Lifshitz)
-   rgw/notifications: version id was not sent in versioned buckets
    ([pr#35181](https://github.com/ceph/ceph/pull/35181), Yuval
    Lifshitz)
-   rgw: when you abort a multipart upload request, the quota may be not
    updated ([pr#33268](https://github.com/ceph/ceph/pull/33268),
    Richard Bai(白学余))
-   rgw: Add support bucket policy for subuser
    ([pr#33714](https://github.com/ceph/ceph/pull/33714), Seena Fallah)
-   rgw: Fix dynamic resharding not working for empty zonegroup in
    period ([pr#33266](https://github.com/ceph/ceph/pull/33266), Or
    Friedmann)
-   rgw: Fix upload part copy range able to get almost any string
    ([pr#33265](https://github.com/ceph/ceph/pull/33265), Or Friedmann)
-   rgw: GET/HEAD and PUT operations on buckets w/lifecycle expiration
    configured do not return x-amz-expiration header
    ([pr#32924](https://github.com/ceph/ceph/pull/32924), Matt Benjamin,
    Yuval Lifshitz)
-   rgw: MultipartObjectProcessor supports stripe size \> chunk size
    ([pr#33271](https://github.com/ceph/ceph/pull/33271), Casey Bodley)
-   rgw: ReplaceKeyPrefixWith and ReplaceKeyWith can not set at the same
    ... ([pr#34599](https://github.com/ceph/ceph/pull/34599), yuliyang)
-   rgw: anonomous swift to obj that dont exist should 401
    ([pr#35045](https://github.com/ceph/ceph/pull/35045), Matthew
    Oliver)
-   rgw: clear ent_list for each loop of bucket list
    ([issue#44394](http://tracker.ceph.com/issues/44394),
    [pr#34099](https://github.com/ceph/ceph/pull/34099), Yao Zongyou)
-   rgw: dmclock: wait until the request is handled
    ([pr#34954](https://github.com/ceph/ceph/pull/34954), GaryHyg)
-   rgw: find oldest period and update RGWMetadataLogHistory()
    ([pr#34597](https://github.com/ceph/ceph/pull/34597), Shilpa
    Jagannath)
-   rgw: fix SignatureDoesNotMatch when use ipv6 address in s3 client
    ([pr#33267](https://github.com/ceph/ceph/pull/33267), yuliyang)
-   rgw: fix bug with (un)ordered bucket listing and marker w/ namespace
    ([pr#34609](https://github.com/ceph/ceph/pull/34609), J. Eric
    Ivancich)
-   rgw: fix lc does not delete objects that do not have exactly the
    same tags as the rule
    ([pr#35002](https://github.com/ceph/ceph/pull/35002), Or Friedmann)
-   rgw: fix multipart upload\'s error response
    ([pr#35019](https://github.com/ceph/ceph/pull/35019), GaryHyg)
-   rgw: fix rgw crash when duration is invalid in sts request
    ([pr#33273](https://github.com/ceph/ceph/pull/33273), yuliyang)
-   rgw: fix some list buckets handle leak
    ([pr#34986](https://github.com/ceph/ceph/pull/34986), Tianshan Qu)
-   rgw: get barbican secret key request maybe return error code
    ([pr#33965](https://github.com/ceph/ceph/pull/33965), Richard
    Bai(白学余))
-   rgw: increase log level for same or older period pull msg
    ([pr#34833](https://github.com/ceph/ceph/pull/34833), Ali Maredia)
-   rgw: make max_connections configurable in beast
    ([pr#33340](https://github.com/ceph/ceph/pull/33340), Tiago
    Pasqualini)
-   rgw: making implicit_tenants backwards compatible
    ([issue#24348](http://tracker.ceph.com/issues/24348),
    [pr#33749](https://github.com/ceph/ceph/pull/33749), Marcus Watts)
-   rgw: multisite: enforce spawn window for incremental data sync
    ([pr#33270](https://github.com/ceph/ceph/pull/33270), Casey Bodley)
-   rgw: radosgw-admin: add support for \--bucket-id in bucket stats
    command ([pr#34815](https://github.com/ceph/ceph/pull/34815),
    Vikhyat Umrao)
-   rgw: radosgw-admin: fix infinite loops in \'datalog list\'
    ([pr#35001](https://github.com/ceph/ceph/pull/35001), Casey Bodley)
-   rgw: reshard: skip stale bucket id entries from reshard queue
    ([pr#34735](https://github.com/ceph/ceph/pull/34735), Abhishek
    Lekshmanan)
-   rgw: set bucket attr twice when delete lifecycle config
    ([pr#34598](https://github.com/ceph/ceph/pull/34598), zhang Shaowen)
-   rgw: set correct storage class for append
    ([pr#34064](https://github.com/ceph/ceph/pull/34064), yuliyang)
-   rgw: sts: add all http args to req_info
    ([pr#33355](https://github.com/ceph/ceph/pull/33355), yuliyang)
-   rgw: tune sharded bucket listing
    ([pr#33675](https://github.com/ceph/ceph/pull/33675), J. Eric
    Ivancich)
-   tests: migrate qa/ to python3
    ([pr#34171](https://github.com/ceph/ceph/pull/34171), Kefu Chai,
    Sage Weil, Casey Bodley, Rishabh Dave, Patrick Donnelly, Kyr
    Shatskyy, Michael Fritch, Xiubo Li, Ilya Dryomov, Alfonso Martínez,
    Thomas Bechtold)
-   tools/cli: bash_completion: Do not auto complete obsolete and hidden
    cmds ([pr#35117](https://github.com/ceph/ceph/pull/35117), Kotresh
    HR)
-   tools/cli: ceph_argparse: increment matchcnt on kwargs
    ([pr#33160](https://github.com/ceph/ceph/pull/33160), Matthew
    Oliver, Shyukri Shyukriev)
-   tools/rados: Unmask \'-o\' to restore original behaviour
    ([pr#33641](https://github.com/ceph/ceph/pull/33641), Brad Hubbard)

## v14.2.9 Nautilus

This is the ninth bugfix release of Nautilus. This release fixes a
couple of security issues in RGW & Messenger V2. We recommend all users
to upgrade to this release.

### Notable Changes

-   CVE-2020-1759: Fixed nonce reuse in msgr V2 secure mode
-   CVE-2020-1760: Fixed XSS due to RGW GetObject header-splitting

## v14.2.8 Nautilus

This is the eighth update to the Ceph Nautilus release series. This
release fixes issues across a range of subsystems. We recommend that all
users upgrade to this release.

### Notable Changes

-   The default value of `bluestore_min_alloc_size_ssd` has been changed
    to 4K to improve performance across all workloads.

-   The following OSD memory config options related to bluestore cache
    autotuning can now be configured during runtime:

    > -   osd_memory_base (default: 768 MB)
    > -   osd_memory_cache_min (default: 128 MB)
    > -   osd_memory_expected_fragmentation (default: 0.15)
    > -   osd_memory_target (default: 4 GB)

    The above options can be set with:

        ceph config set osd <option> <value>

-   The MGR now accepts `profile rbd` and `profile rbd-read-only` user
    caps. These caps can be used to provide users access to MGR-based
    RBD functionality such as `rbd perf image iostat` an
    `rbd perf image iotop`.

-   The configuration value `osd_calc_pg_upmaps_max_stddev` used for
    upmap balancing has been removed. Instead use the mgr balancer
    config `upmap_max_deviation` which now is an integer number of PGs
    of deviation from the target PGs per OSD. This can be set with a
    command like
    `ceph config set mgr mgr/balancer/upmap_max_deviation 2`. The
    default `upmap_max_deviation` is 5. There are situations where crush
    rules would not allow a pool to ever have completely balanced PGs.
    For example, if crush requires 1 replica on each of 3 racks, but
    there are fewer OSDs in 1 of the racks. In those cases, the
    configuration value can be increased.

-   RGW: a mismatch between the bucket notification documentation and
    the actual message format was fixed. This means that any endpoints
    receiving bucket notification, will now receive the same
    notifications inside a JSON array named \'Records\'. Note that this
    does not affect pulling bucket notification from a subscription in a
    \'pubsub\' zone, as these are already wrapped inside that array.

-   CephFS: multiple active MDS forward scrub is now rejected. Scrub
    currently only is permitted on a file system with a single rank.
    Reduce the ranks to one via `ceph fs set <fs_name> max_mds 1`.

-   Ceph now refuses to create a file system with a default EC data
    pool. For further explanation, see:
    <https://docs.ceph.com/docs/nautilus/cephfs/createfs/#creating-pools>

-   Ceph will now issue a health warning if a RADOS pool has a `pg_num`
    value that is not a power of two. This can be fixed by adjusting the
    pool to a nearby power of two:

        ceph osd pool set <pool-name> pg_num <new-pg-num>

    Alternatively, the warning can be silenced with:

        ceph config set global mon_warn_on_pool_pg_num_not_power_of_two false

### Changelog

-   bluestore: common/options: bluestore 4k min_alloc_size for SSD
    ([pr#32998](https://github.com/ceph/ceph/pull/32998), Mark Nelson,
    Sage Weil)
-   bluestore: os/bluestore: Add config observer for osd memory specific
    options ([pr#31852](https://github.com/ceph/ceph/pull/31852),
    Sridhar Seshasayee)
-   bluestore: os/bluestore/BlueStore.cc: set priorities for compression
    stats ([pr#32845](https://github.com/ceph/ceph/pull/32845), Neha
    Ojha)
-   bluestore: os/bluestore: default bluestore_block_size 1T -\> 100G
    ([pr#32283](https://github.com/ceph/ceph/pull/32283), Sage Weil)
-   build/ops: cmake: remove seastar tests from \"make check\"
    ([pr#32658](https://github.com/ceph/ceph/pull/32658), Kefu Chai)
-   build/ops: install-deps,rpm: enable devtoolset-8 on aarch64 also
    ([issue#38892](http://tracker.ceph.com/issues/38892),
    [pr#32651](https://github.com/ceph/ceph/pull/32651), Kefu Chai)
-   build/ops: rpm: add rpm-build to SUSE-specific make check deps
    ([pr#32208](https://github.com/ceph/ceph/pull/32208), Nathan Cutler)
-   build/ops: switch to boost 1.72
    ([pr#32441](https://github.com/ceph/ceph/pull/32441), Willem Jan
    Withagen, Kefu Chai)
-   build/ops: tools/setup-virtualenv.sh: do not default to python2.7
    ([pr#30739](https://github.com/ceph/ceph/pull/30739), Nathan Cutler)
-   cephfs: cephfs-journal-tool: fix crash and usage
    ([pr#32913](https://github.com/ceph/ceph/pull/32913), Xiubo Li)
-   cephfs: client: Add is_dir() check before changing directory
    ([pr#32916](https://github.com/ceph/ceph/pull/32916), Varsha Rao)
-   cephfs: client: add procession of SEEK_HOLE and SEEK_DATA in lseek
    ([pr#30764](https://github.com/ceph/ceph/pull/30764), Shen Hang)
-   cephfs: client: add warning when cap != in-\>auth_cap
    ([pr#32065](https://github.com/ceph/ceph/pull/32065), Shen Hang)
-   cephfs: client: EINVAL may be returned when offset is 0
    ([pr#30762](https://github.com/ceph/ceph/pull/30762), wenpengLi)
-   cephfs: client: fix lazyio_synchronize() to update file size and
    libcephfs: Add Tests for LazyIO
    ([pr#30769](https://github.com/ceph/ceph/pull/30769), Sidharth
    Anupkrishnan)
-   cephfs: client: \_readdir_cache_cb() may use the readdir_cache
    already clear ([issue#41148](http://tracker.ceph.com/issues/41148),
    [pr#30763](https://github.com/ceph/ceph/pull/30763), huanwen ren)
-   cephfs: client: remove Inode.dir_contacts field and handle bad
    whence value to llseek gracefully
    ([pr#30766](https://github.com/ceph/ceph/pull/30766), Jeff Layton)
-   cephfs,common: osdc/objecter: Fix last_sent in scientific format and
    add age to ops ([pr#31081](https://github.com/ceph/ceph/pull/31081),
    Varsha Rao)
-   cephfs: disallow changing fuse_default_permissions option at runtime
    ([pr#32915](https://github.com/ceph/ceph/pull/32915), Zhi Zhang)
-   cephfs: mds: add command that config individual client session
    ([issue#40811](http://tracker.ceph.com/issues/40811),
    [pr#32245](https://github.com/ceph/ceph/pull/32245), \"Yan, Zheng\")
-   cephfs: mds: \"apply configuration changes through MDSRank\" and
    \"recall caps from quiescent sessions\" and \"drive cap recall while
    dropping cache\"
    ([pr#30761](https://github.com/ceph/ceph/pull/30761), Patrick
    Donnelly, Jeff Layton)
-   cephfs: mds: fix assert(omap_num_objs \<= MAX_OBJECTS) of
    OpenFileTable ([pr#32756](https://github.com/ceph/ceph/pull/32756),
    \"Yan, Zheng\")
-   cephfs: mds: fix revoking caps after after stale-\>resume circle
    ([pr#32909](https://github.com/ceph/ceph/pull/32909), \"Yan,
    Zheng\")
-   cephfs: mds: free heap memory may grow too large for some workloads
    ([pr#31802](https://github.com/ceph/ceph/pull/31802), Patrick
    Donnelly)
-   cephfs: MDSMonitor: warn if a new file system is being created with
    an EC default data pool
    ([pr#32600](https://github.com/ceph/ceph/pull/32600), Patrick
    Donnelly)
-   cephfs: mds: no assert on frozen dir when scrub path
    ([pr#32071](https://github.com/ceph/ceph/pull/32071), Zhi Zhang)
-   cephfs: mds: note client features when rejecting client
    ([pr#32914](https://github.com/ceph/ceph/pull/32914), Patrick
    Donnelly)
-   cephfs: mds/OpenFileTable: match MAX_ITEMS_PER_OBJ to
    osd_deep_scrub_large_omap_object_key_threshold
    ([pr#32921](https://github.com/ceph/ceph/pull/32921), Vikhyat Umrao,
    Varsha Rao)
-   cephfs: mds: properly evaluate unstable locks when evicting client
    ([pr#32073](https://github.com/ceph/ceph/pull/32073), \"Yan,
    Zheng\")
-   cephfs: mds: reject forward scrubs when cluster has multiple active
    MDS (more than one rank)
    ([pr#32602](https://github.com/ceph/ceph/pull/32602), Patrick
    Donnelly, Milind Changire)
-   cephfs: mds: reject sessionless messages
    ([issue#40784](http://tracker.ceph.com/issues/40784),
    [pr#30843](https://github.com/ceph/ceph/pull/30843), \"Yan, Zheng\",
    Xiao Guodong, Shen Hang)
-   cephfs: mds: remove unnecessary debug warning
    ([pr#32077](https://github.com/ceph/ceph/pull/32077), Patrick
    Donnelly)
-   cephfs: mds returns -5(EIO) error when the deleted file does not
    exist ([pr#30767](https://github.com/ceph/ceph/pull/30767), huanwen
    ren)
-   cephfs: mds: split the dir if the op makes it oversized, because
    some ops maybe in flight
    ([pr#31302](https://github.com/ceph/ceph/pull/31302), simon gao)
-   cephfs: mds: tolerate no snaprealm encoded in on-disk root inode
    ([pr#32079](https://github.com/ceph/ceph/pull/32079), \"Yan,
    Zheng\")
-   cephfs: mgr: \"mds metadata\" to setup new DaemonState races with
    fsmap ([pr#31905](https://github.com/ceph/ceph/pull/31905), Patrick
    Donnelly)
-   cephfs: mgr/volumes: allow setting uid, gid of subvolume and
    subvolume group during creation
    ([issue#42923](http://tracker.ceph.com/issues/42923),
    [pr#31741](https://github.com/ceph/ceph/pull/31741), Venky Shankar,
    Jos Collin)
-   cephfs: mgr/volumes: fetch trash and clone entries without blocking
    volume access ([issue#44282](http://tracker.ceph.com/issues/44282),
    [pr#33526](https://github.com/ceph/ceph/pull/33526), Venky Shankar)
-   cephfs: mgr/volumes: fs subvolume resize command
    ([pr#31332](https://github.com/ceph/ceph/pull/31332), Jos Collin)
-   cephfs: mgr/volumes: misc fix and feature enhancements
    ([issue#42646](http://tracker.ceph.com/issues/42646),
    [issue#43645](http://tracker.ceph.com/issues/43645),
    [pr#33122](https://github.com/ceph/ceph/pull/33122), Rishabh Dave,
    Joshua Schmid, Venky Shankar, Ramana Raja, Jos Collin)
-   cephfs: mgr/volumes: unregister job upon async threads exception
    ([issue#44315](http://tracker.ceph.com/issues/44315),
    [pr#33569](https://github.com/ceph/ceph/pull/33569), Venky Shankar)
-   cephfs: mon: print FSMap regardless of file system count
    ([pr#32912](https://github.com/ceph/ceph/pull/32912), Patrick
    Donnelly)
-   cephfs: pybind/mgr/volumes: idle connection drop is not working
    ([pr#33116](https://github.com/ceph/ceph/pull/33116), Patrick
    Donnelly)
-   cephfs: RuntimeError: Files in flight high water is unexpectedly low
    (0 / 6) ([pr#33115](https://github.com/ceph/ceph/pull/33115),
    Patrick Donnelly)
-   ceph.in: check ceph-conf returncode
    ([pr#31367](https://github.com/ceph/ceph/pull/31367), Dimitri
    Savineau)
-   ceph-monstore-tool: correct the key for storing mgr_command_descs
    ([pr#33278](https://github.com/ceph/ceph/pull/33278), Kefu Chai)
-   ceph-volume: add db and wal support to raw mode
    ([pr#32979](https://github.com/ceph/ceph/pull/32979), Sébastien Han)
-   ceph-volume: add methods to pass filters to pvs, vgs and lvs
    commands ([pr#33217](https://github.com/ceph/ceph/pull/33217),
    Rishabh Dave)
-   ceph-volume: add raw (\--bluestore) mode
    ([pr#32733](https://github.com/ceph/ceph/pull/32733), Jan Fajerski,
    Sage Weil)
-   ceph-volume: add sizing arguments to prepare
    ([pr#33231](https://github.com/ceph/ceph/pull/33231), Jan Fajerski)
-   ceph-volume: allow raw block devices everywhere
    ([pr#32868](https://github.com/ceph/ceph/pull/32868), Jan Fajerski)
-   ceph-volume: assume msgrV1 for all branches containing mimic
    ([pr#31616](https://github.com/ceph/ceph/pull/31616), Jan Fajerski)
-   ceph-volume: avoid calling zap_lv with a LV-less VG
    ([pr#33297](https://github.com/ceph/ceph/pull/33297), Jan Fajerski)
-   ceph-volume: batch bluestore fix create_lvs call
    ([pr#33232](https://github.com/ceph/ceph/pull/33232), Jan Fajerski)
-   ceph-volume: batch bluestore fix create_lvs call
    ([pr#33301](https://github.com/ceph/ceph/pull/33301), Jan Fajerski)
-   ceph-volume/batch: fail on filtered devices when non-interactive
    ([pr#33202](https://github.com/ceph/ceph/pull/33202), Jan Fajerski)
-   ceph-volume: Dereference symlink in lvm list
    ([pr#32877](https://github.com/ceph/ceph/pull/32877), Benoît Knecht)
-   ceph-volume: don\'t remove vg twice when zapping filestore
    ([pr#33337](https://github.com/ceph/ceph/pull/33337), Jan Fajerski)
-   ceph-volume: finer grained availability notion in inventory
    ([pr#33240](https://github.com/ceph/ceph/pull/33240), Jan Fajerski)
-   ceph-volume: fix has_bluestore_label() function
    ([pr#33239](https://github.com/ceph/ceph/pull/33239), Guillaume
    Abrioux)
-   ceph-volume: fix is_ceph_device for lvm batch
    ([pr#33253](https://github.com/ceph/ceph/pull/33253), Jan Fajerski,
    Dimitri Savineau)
-   ceph-volume: fix the integer overflow
    ([pr#32873](https://github.com/ceph/ceph/pull/32873), dongdong tao)
-   ceph-volume: import mock.mock instead of unittest.mock (py2)
    ([pr#32870](https://github.com/ceph/ceph/pull/32870), Jan Fajerski)
-   ceph-volume/lvm/activate.py: clarify error message: fsid refers to
    osd_fsid ([pr#32864](https://github.com/ceph/ceph/pull/32864), Yaniv
    Kaul)
-   ceph-volume: lvm/deactivate: add unit tests, remove \--all
    ([pr#32863](https://github.com/ceph/ceph/pull/32863), Jan Fajerski)
-   ceph-volume: lvm deactivate command
    ([pr#33209](https://github.com/ceph/ceph/pull/33209), Jan Fajerski)
-   ceph-volume: make get_devices fs location independent
    ([pr#33200](https://github.com/ceph/ceph/pull/33200), Jan Fajerski)
-   ceph-volume: minor clean-up of \"simple scan\" subcommand help
    ([pr#32556](https://github.com/ceph/ceph/pull/32556), Michael
    Fritch)
-   ceph-volume: pass journal_size as Size not string
    ([pr#33334](https://github.com/ceph/ceph/pull/33334), Jan Fajerski)
-   ceph-volume: refactor listing.py + fixes
    ([pr#33238](https://github.com/ceph/ceph/pull/33238), Jan Fajerski,
    Rishabh Dave, Guillaume Abrioux)
-   ceph-volume: reject disks smaller then 5GB in inventory
    ([issue#40776](http://tracker.ceph.com/issues/40776),
    [pr#31554](https://github.com/ceph/ceph/pull/31554), Jan Fajerski)
-   ceph-volume: skip osd creation when already done
    ([pr#33242](https://github.com/ceph/ceph/pull/33242), Guillaume
    Abrioux)
-   ceph-volume/test: patch VolumeGroups
    ([pr#32558](https://github.com/ceph/ceph/pull/32558), Jan Fajerski)
-   ceph-volume: use correct extents if using db-devices and \>1
    osds_per_device
    ([pr#32874](https://github.com/ceph/ceph/pull/32874), Fabian
    Niepelt)
-   ceph-volume: use fsync for dd command
    ([pr#31553](https://github.com/ceph/ceph/pull/31553), Rishabh Dave)
-   ceph-volume: use get_device_vgs in has_common_vg
    ([pr#33254](https://github.com/ceph/ceph/pull/33254), Jan Fajerski)
-   ceph-volume: util: look for executable in \$PATH
    ([pr#32860](https://github.com/ceph/ceph/pull/32860), Shyukri
    Shyukriev)
-   ceph-volume/zfs: add the inventory command
    ([pr#31295](https://github.com/ceph/ceph/pull/31295), Willem Jan
    Withagen)
-   common/admin_socket: Increase socket timeouts
    ([pr#32063](https://github.com/ceph/ceph/pull/32063), Brad Hubbard)
-   common/bl: fix the dangling last_p issue
    ([pr#33277](https://github.com/ceph/ceph/pull/33277), Radoslaw
    Zarzynski)
-   common/config: update values when they are removed via mon
    ([pr#32846](https://github.com/ceph/ceph/pull/32846), Sage Weil)
-   common: FIPS: audit and switch some memset & bzero users
    ([pr#32167](https://github.com/ceph/ceph/pull/32167), Radoslaw
    Zarzynski)
-   common: fix deadlocky inflight op visiting in OpTracker
    ([pr#32858](https://github.com/ceph/ceph/pull/32858), Radoslaw
    Zarzynski)
-   common/options: remove unused ms_msgr2\_{sign,encrypt}
    ([pr#31850](https://github.com/ceph/ceph/pull/31850), Ilya Dryomov)
-   common/util: use ifstream to read from /proc files
    ([pr#32901](https://github.com/ceph/ceph/pull/32901), Kefu Chai,
    songweibin)
-   core: auth/Crypto: fallback to /dev/urandom if getentropy() fails
    ([pr#31301](https://github.com/ceph/ceph/pull/31301), Kefu Chai)
-   core: mon: keep v1 address type when explicitly set
    ([pr#32028](https://github.com/ceph/ceph/pull/32028), Ricardo Dias)
-   core: mon/OSDMonitor: Fix pool set target_size_bytes (etc) with unit
    suffix ([pr#31740](https://github.com/ceph/ceph/pull/31740),
    Prashant D)
-   core: osd/OSDMap: health alert for non-power-of-two pg_num
    ([pr#30689](https://github.com/ceph/ceph/pull/30689), Sage Weil)
-   crush/CrushWrapper: behave with empty weight vector
    ([pr#32905](https://github.com/ceph/ceph/pull/32905), Kefu Chai)
-   doc/cephfs/client-auth: description and example are inconsistent
    ([pr#32781](https://github.com/ceph/ceph/pull/32781), Ilya Dryomov)
-   doc/cephfs: improve add/remove MDS section
    ([issue#39620](http://tracker.ceph.com/issues/39620),
    [pr#31116](https://github.com/ceph/ceph/pull/31116), Patrick
    Donnelly)
-   doc/ceph-fuse: mention -k option in ceph-fuse man page
    ([pr#30765](https://github.com/ceph/ceph/pull/30765), Rishabh Dave)
-   doc/ceph-volume: initial docs for zfs/inventory and zfs/api
    ([pr#32746](https://github.com/ceph/ceph/pull/32746), Willem Jan
    Withagen)
-   doc: remove invalid option mon_pg_warn_max_per_osd
    ([pr#31300](https://github.com/ceph/ceph/pull/31300), zhang daolong)
-   doc/\_templates/page.html: redirect to etherpad
    ([pr#32248](https://github.com/ceph/ceph/pull/32248), Neha Ojha)
-   doc: wrong datatype describing crush_rule
    ([pr#32254](https://github.com/ceph/ceph/pull/32254), Kefu Chai)
-   global: disable THP for Ceph daemons
    ([pr#31646](https://github.com/ceph/ceph/pull/31646), Patrick
    Donnelly, Mark Nelson)
-   kv: fix shutdown vs async compaction
    ([pr#32715](https://github.com/ceph/ceph/pull/32715), Sage Weil)
-   librbd: diff iterate with fast-diff now correctly includes parent
    ([pr#32469](https://github.com/ceph/ceph/pull/32469), Jason
    Dillaman)
-   librbd: fix rbd_open_by_id, rbd_open_by_id_read_only
    ([pr#32837](https://github.com/ceph/ceph/pull/32837), yangjun)
-   librbd: remove pool objects when removing a namespace
    ([pr#32839](https://github.com/ceph/ceph/pull/32839), Jason
    Dillaman)
-   librbd: skip stale child with non-existent pool for list descendants
    ([pr#32841](https://github.com/ceph/ceph/pull/32841), songweibin)
-   librbd: support compression allocation hints to the OSD
    ([pr#32842](https://github.com/ceph/ceph/pull/32842), Jason
    Dillaman)
-   mgr: add \'rbd\' profiles to support \'rbd_support\' module commands
    ([pr#32086](https://github.com/ceph/ceph/pull/32086), Jason
    Dillaman)
-   mgr/alerts: simple health alerts
    ([pr#30820](https://github.com/ceph/ceph/pull/30820), Sage Weil)
-   mgr: Balancer fixes
    ([pr#31956](https://github.com/ceph/ceph/pull/31956), Neha Ojha,
    Kefu Chai, David Zafman)
-   mgr/DaemonServer: fix \'osd ok-to-stop\' for EC pools
    ([pr#32844](https://github.com/ceph/ceph/pull/32844), Sage Weil)
-   mgr/dashboard: add debug mode, and accept expected exception when
    SSL handshaking
    ([pr#31190](https://github.com/ceph/ceph/pull/31190), Kefu Chai,
    Ernesto Puerta, Joshua Schmid)
-   mgr/dashboard: block mirroring page results in internal server error
    ([pr#32133](https://github.com/ceph/ceph/pull/32133), Jason
    Dillaman)
-   mgr/dashboard: check embedded Grafana dashboard references
    ([issue#40008](http://tracker.ceph.com/issues/40008),
    [pr#31808](https://github.com/ceph/ceph/pull/31808), Kiefer Chang)
-   mgr/dashboard: check if user has config-opt permissions
    ([pr#32827](https://github.com/ceph/ceph/pull/32827), Alfonso
    Martínez)
-   mgr/dashboard: Cross sign button not working for some modals
    ([pr#32012](https://github.com/ceph/ceph/pull/32012), Ricardo
    Marques)
-   mgr/dashboard: Dashboard can\'t handle self-signed cert on Grafana
    API ([pr#31792](https://github.com/ceph/ceph/pull/31792), Volker
    Theile)
-   mgr/dashboard: disable \'Add Capability\' button in rgw user edit
    ([pr#32930](https://github.com/ceph/ceph/pull/32930), Alfonso
    Martínez)
-   mgr/dashboard: fix restored RBD image naming issue
    ([pr#31810](https://github.com/ceph/ceph/pull/31810), Kiefer Chang)
-   mgr/dashboard: grafana charts match time picker selection
    ([pr#31999](https://github.com/ceph/ceph/pull/31999), Alfonso
    Martínez)
-   mgr/dashboard,grafana: remove shortcut menu
    ([pr#31980](https://github.com/ceph/ceph/pull/31980), Ernesto
    Puerta)
-   mgr/dashboard: Handle always-on Ceph Manager modules correctly
    ([pr#31782](https://github.com/ceph/ceph/pull/31782), Volker Theile)
-   mgr/dashboard: Hardening accessing the metadata
    ([pr#32128](https://github.com/ceph/ceph/pull/32128), Volker Theile)
-   mgr/dashboard: iSCSI targets not available if any gateway is down
    (and more\...) ([pr#32304](https://github.com/ceph/ceph/pull/32304),
    Ricardo Marques)
-   mgr/dashboard: KeyError on dashboard reload
    ([pr#32233](https://github.com/ceph/ceph/pull/32233), Patrick
    Seidensal)
-   mgr/dashboard: key-value-table doesn\'t render booleans
    ([pr#31789](https://github.com/ceph/ceph/pull/31789), Patrick
    Seidensal)
-   mgr/dashboard: Remove compression mode unset in pool from
    ([pr#31784](https://github.com/ceph/ceph/pull/31784), Stephan
    Müller)
-   mgr/dashboard: show \"Rename\" in header & button when renaming RBD
    ([pr#31779](https://github.com/ceph/ceph/pull/31779), Alfonso
    Martínez)
-   mgr/dashboard: sort monitors by open sessions correctly
    ([pr#31791](https://github.com/ceph/ceph/pull/31791), Alfonso
    Martínez)
-   mgr/dashboard: Standby Dashboards don\'t handle all requests
    properly ([pr#32299](https://github.com/ceph/ceph/pull/32299),
    Volker Theile)
-   mgr/dashboard: Trim IQN on iSCSI target form
    ([pr#31942](https://github.com/ceph/ceph/pull/31942), Ricardo
    Marques)
-   mgr/dashboard: Unable to set boolean values to false when default is
    true ([pr#31941](https://github.com/ceph/ceph/pull/31941), Ricardo
    Marques)
-   mgr/dashboard: Using wrong identifiers in RGW user/bucket datatables
    ([pr#32888](https://github.com/ceph/ceph/pull/32888), Volker Theile)
-   mgr/devicehealth: ensure we don\'t store empty objects
    ([pr#31735](https://github.com/ceph/ceph/pull/31735), Sage Weil)
-   mgr/devicehealth: fix telemetry stops sending device reports after
    48 hours ([pr#33346](https://github.com/ceph/ceph/pull/33346),
    Yaarit Hatuka, Sage Weil)
-   mgr: drop reference to msg on return
    ([pr#33498](https://github.com/ceph/ceph/pull/33498), Patrick
    Donnelly)
-   mgr/MgrClient: fix open condition
    ([pr#32769](https://github.com/ceph/ceph/pull/32769), Sage Weil)
-   mgr/pg_autoscaler: calculate pool_pg_target using pool size
    ([pr#33170](https://github.com/ceph/ceph/pull/33170), Dan van der
    Ster)
-   mgr/pg_autoscaler: default to pg_num\[\_min\] = 16
    ([pr#32069](https://github.com/ceph/ceph/pull/32069), Sage Weil)
-   mgr/pg_autoscaler: default to pg_num\[\_min\] = 32
    ([pr#32931](https://github.com/ceph/ceph/pull/32931), Neha Ojha)
-   mgr/pg_autoscaler: implement shutdown method
    ([pr#32068](https://github.com/ceph/ceph/pull/32068), Patrick
    Donnelly)
-   mgr/pg_autoscaler: only generate target\_\* health warnings if
    targets set ([pr#32067](https://github.com/ceph/ceph/pull/32067),
    Sage Weil)
-   mgr/prometheus: assign a value to osd_dev_node when obj_store is not
    filestore or bluestore
    ([pr#31556](https://github.com/ceph/ceph/pull/31556), jiahuizeng)
-   mgr/prometheus: report per-pool pg states
    ([pr#33157](https://github.com/ceph/ceph/pull/33157), Aleksei
    Zakharov)
-   mgr/telemetry: anonymizing smartctl report itself
    ([pr#33082](https://github.com/ceph/ceph/pull/33082), Yaarit Hatuka)
-   mgr/telemetry: check get_metadata return val
    ([pr#33095](https://github.com/ceph/ceph/pull/33095), Yaarit Hatuka)
-   mgr/telemetry: split entity_name only once (handle ids with dots)
    ([pr#33168](https://github.com/ceph/ceph/pull/33168), Dan Mick)
-   mgr/zabbix: Adds possibility to send data to multiple zabbix servers
    ([pr#30009](https://github.com/ceph/ceph/pull/30009), slivik, Jakub
    Sliva)
-   mon/ConfigMonitor: fix handling of NO_MON_UPDATE settings
    ([pr#32856](https://github.com/ceph/ceph/pull/32856), Sage Weil)
-   mon/ConfigMonitor: only propose if leader
    ([pr#33155](https://github.com/ceph/ceph/pull/33155), Sage Weil)
-   mon: Don\'t put session during feature change
    ([pr#33152](https://github.com/ceph/ceph/pull/33152), Brad Hubbard)
-   mon: elector: return after triggering a new election
    ([pr#33007](https://github.com/ceph/ceph/pull/33007), Greg Farnum)
-   monitoring: wait before firing osd full alert
    ([pr#32070](https://github.com/ceph/ceph/pull/32070), Patrick
    Seidensal)
-   mon/MgrMonitor.cc: add always_on_modules to the output of \"ceph mgr
    module ls\" ([pr#32997](https://github.com/ceph/ceph/pull/32997),
    Neha Ojha)
-   mon/MgrMonitor.cc: warn about missing mgr in a cluster with osds
    ([pr#33142](https://github.com/ceph/ceph/pull/33142), Neha Ojha)
-   mon/OSDMonitor: Don\'t update mon cache settings if rocksdb is not
    used ([pr#32520](https://github.com/ceph/ceph/pull/32520), Sridhar
    Seshasayee, Sage Weil)
-   mon/OSDMonitor: fix format error ceph osd stat \--format json
    ([pr#32062](https://github.com/ceph/ceph/pull/32062), Zheng Yin)
-   mon/PGMap.h: disable network stats in dump_osd_stats
    ([pr#32466](https://github.com/ceph/ceph/pull/32466), Neha Ojha,
    David Zafman)
-   mon: remove the restriction of address type in init_with_hosts
    ([pr#31844](https://github.com/ceph/ceph/pull/31844), Hao Xiong)
-   mon/Session: only index osd ids \>= 0
    ([pr#32908](https://github.com/ceph/ceph/pull/32908), Sage Weil)
-   mount.ceph: give a hint message when no mds is up or cluster is
    laggy ([pr#32910](https://github.com/ceph/ceph/pull/32910), Xiubo
    Li)
-   mount.ceph: remove arbitrary limit on size of name= option
    ([pr#32807](https://github.com/ceph/ceph/pull/32807), Jeff Layton)
-   msg: async/net_handler.cc: Fix compilation
    ([pr#31736](https://github.com/ceph/ceph/pull/31736), Carlos
    Valiente)
-   osd: add osd_fast_shutdown option (default true)
    ([pr#32743](https://github.com/ceph/ceph/pull/32743), Sage Weil)
-   osd: Allow 64-char hostname to be added as the \"host\" in CRUSH
    ([pr#33147](https://github.com/ceph/ceph/pull/33147), Michal
    Skalski)
-   osd: Diagnostic logging for upmap cleaning
    ([pr#32716](https://github.com/ceph/ceph/pull/32716), David Zafman)
-   osd/OSD: enhance osd numa affinity compatibility
    ([pr#32843](https://github.com/ceph/ceph/pull/32843), luo rixin, Dai
    zhiwei)
-   osd/PeeringState.cc: don\'t let num_objects become negative
    ([pr#32857](https://github.com/ceph/ceph/pull/32857), Neha Ojha)
-   osd/PeeringState.cc: skip peer_purged when discovering all missing
    ([pr#32847](https://github.com/ceph/ceph/pull/32847), Neha Ojha)
-   osd/PeeringState: do not exclude up from acting_recovery_backfill
    ([pr#32064](https://github.com/ceph/ceph/pull/32064), Nathan Cutler,
    xie xingguo)
-   osd/PrimaryLogPG: skip obcs that don\'t exist during backfill
    scan_range ([pr#31028](https://github.com/ceph/ceph/pull/31028),
    Sage Weil)
-   osd: set affinity for \*all\* threads
    ([pr#31359](https://github.com/ceph/ceph/pull/31359), Sage Weil)
-   osd: set collection pool opts on collection create, pg load
    ([pr#32123](https://github.com/ceph/ceph/pull/32123), Sage Weil)
-   osd: Use physical ratio for nearfull (doesn\'t include backfill
    resserve) ([pr#32773](https://github.com/ceph/ceph/pull/32773),
    David Zafman)
-   pybind/mgr: Cancel output color control
    ([pr#31697](https://github.com/ceph/ceph/pull/31697), Zheng Yin)
-   rbd: creating thick-provision image progress percent info exceeds
    100% ([pr#32840](https://github.com/ceph/ceph/pull/32840), Xiangdong
    Mu)
-   rbd: librbd: don\'t call refresh from mirror::GetInfoRequest state
    machine ([pr#32900](https://github.com/ceph/ceph/pull/32900), Mykola
    Golub)
-   rbd-mirror: clone v2 mirroring improvements
    ([pr#31518](https://github.com/ceph/ceph/pull/31518), Mykola Golub)
-   rbd-mirror: fix \'rbd mirror status\' asok command output
    ([pr#32447](https://github.com/ceph/ceph/pull/32447), Mykola Golub)
-   rbd-mirror: make logrotate work
    ([pr#32593](https://github.com/ceph/ceph/pull/32593), Mykola Golub)
-   rgw: add bucket permission verify when copy obj
    ([pr#31089](https://github.com/ceph/ceph/pull/31089), NancySu05)
-   rgw: Adding \'iam\' namespace for Role and User Policy related REST
    APIs ([pr#32437](https://github.com/ceph/ceph/pull/32437), Pritha
    Srivastava)
-   rgw: adding mfa code validation when bucket versioning status is
    changed ([pr#32759](https://github.com/ceph/ceph/pull/32759), Pritha
    Srivastava)
-   rgw: add num_shards to radosgw-admin bucket stats
    ([pr#31182](https://github.com/ceph/ceph/pull/31182), Paul Emmerich)
-   rgw: allow reshard log entries for non-existent buckets to be
    cancelled ([pr#32056](https://github.com/ceph/ceph/pull/32056), J.
    Eric Ivancich)
-   rgw: auto-clean reshard queue entries for non-existent buckets
    ([pr#32055](https://github.com/ceph/ceph/pull/32055), J. Eric
    Ivancich)
-   rgw: build_linked_oids_for_bucket and build_buckets_instance_index
    should return negative value if it fails
    ([pr#32820](https://github.com/ceph/ceph/pull/32820), zhangshaowen)
-   rgw: crypt: permit RGW-AUTO/default with SSE-S3 headers
    ([pr#31862](https://github.com/ceph/ceph/pull/31862), Matt Benjamin)
-   rgw: data sync markers include timestamp from datalog entry
    ([pr#32819](https://github.com/ceph/ceph/pull/32819), Casey Bodley)
-   rgw_file: avoid string::front() on empty path
    ([pr#33008](https://github.com/ceph/ceph/pull/33008), Matt Benjamin)
-   rgw: fix a bug that bucket instance obj can\'t be removed after
    resharding completed
    ([pr#32822](https://github.com/ceph/ceph/pull/32822), zhang Shaowen)
-   rgw: fix an endless loop error when to show usage
    ([pr#31684](https://github.com/ceph/ceph/pull/31684), lvshuhua)
-   rgw: fix bugs in listobjectsv1
    ([pr#32239](https://github.com/ceph/ceph/pull/32239), Albin Antony)
-   rgw: fix compile errors with boost 1.70
    ([pr#31289](https://github.com/ceph/ceph/pull/31289), Casey Bodley)
-   rgw: fix data consistency error casued by rgw sent timeout
    ([pr#32821](https://github.com/ceph/ceph/pull/32821), 李纲彬82225)
-   rgw: fix list versions starts with version_id=null
    ([pr#30743](https://github.com/ceph/ceph/pull/30743), Tianshan Qu)
-   rgw: fix one part of the bulk delete(RGWDeleteMultiObj_ObjStore_S3)
    fails but no error messages
    ([pr#33151](https://github.com/ceph/ceph/pull/33151), Snow Si)
-   rgw: fix opslog operation field as per Amazon s3
    ([issue#20978](http://tracker.ceph.com/issues/20978),
    [pr#32834](https://github.com/ceph/ceph/pull/32834), Jiaying Ren)
-   rgw: fix refcount tags to match and update object\'s idtag
    ([pr#30741](https://github.com/ceph/ceph/pull/30741), J. Eric
    Ivancich)
-   rgw: fix rgw crash when token is not base64 encode
    ([pr#32050](https://github.com/ceph/ceph/pull/32050), yuliyang)
-   rgw: gc remove tag after all sub io finish
    ([issue#40903](http://tracker.ceph.com/issues/40903),
    [pr#30733](https://github.com/ceph/ceph/pull/30733), Tianshan Qu)
-   rgw: Incorrectly calling ceph::buffer::list::decode_base64 in bucket
    policy ([pr#32832](https://github.com/ceph/ceph/pull/32832),
    GaryHyg)
-   rgw: maybe coredump when reload operator happened
    ([pr#33149](https://github.com/ceph/ceph/pull/33149), Richard
    Bai(白学余))
-   rgw: move forward marker even in case of many rgw.none indexes
    ([pr#32824](https://github.com/ceph/ceph/pull/32824), Ilsoo Byun)
-   rgw multisite: fixes for concurrent version creation
    ([pr#32057](https://github.com/ceph/ceph/pull/32057), Or Friedmann,
    Casey Bodley)
-   rgw: prevent bucket reshard scheduling if bucket is resharding
    ([pr#31298](https://github.com/ceph/ceph/pull/31298), J. Eric
    Ivancich)
-   rgw/pubsub: fix records/event json format to match documentation
    ([pr#32221](https://github.com/ceph/ceph/pull/32221), Yuval
    Lifshitz)
-   rgw: radosgw-admin: sync status displays id of shard furthest behind
    ([pr#32818](https://github.com/ceph/ceph/pull/32818), Casey Bodley)
-   rgw: return error if lock log shard fails
    ([pr#32825](https://github.com/ceph/ceph/pull/32825), zhangshaowen)
-   rgw/rgw_rest_conn.h: fix build with clang
    ([pr#32489](https://github.com/ceph/ceph/pull/32489), Bernd Zeimetz)
-   rgw: Select the std::bitset to resolv ambiguity
    ([pr#32504](https://github.com/ceph/ceph/pull/32504), Willem Jan
    Withagen)
-   rgw: support radosgw-admin zone/zonegroup placement get command
    ([pr#32835](https://github.com/ceph/ceph/pull/32835), jiahuizeng)
-   rgw: the http response code of delete bucket should not be
    204-no-content ([pr#32833](https://github.com/ceph/ceph/pull/32833),
    Chang Liu)
-   rgw: update s3-test download code for s3-test tasks
    ([pr#32229](https://github.com/ceph/ceph/pull/32229), Ali Maredia)
-   rgw: update the hash source for multipart entries during resharding
    ([pr#33183](https://github.com/ceph/ceph/pull/33183), dongdong tao)
-   rgw: url encode common prefixes for List Objects response
    ([pr#32058](https://github.com/ceph/ceph/pull/32058), Abhishek
    Lekshmanan)
-   rgw: when resharding store progress json
    ([pr#31683](https://github.com/ceph/ceph/pull/31683), Mark Kogan,
    Mark Nelson)
-   selinux: Allow ceph to read udev db
    ([pr#32259](https://github.com/ceph/ceph/pull/32259), Boris Ranto)

## v14.2.7 Nautilus

This is the seventh update to the Ceph Nautilus release series. This is
a hotfix release primarily fixing a couple of security issues. We
recommend that all users upgrade to this release.

### Notable Changes

-   CVE-2020-1699: Fixed a path traversal flaw in Ceph dashboard that
    could allow for potential information disclosure (Ernesto Puerta)
-   CVE-2020-1700: Fixed a flaw in RGW beast frontend that could lead to
    denial of service from an unauthenticated client (Or Friedmann)

## v14.2.6 Nautilus

This is the sixth update to the Ceph Nautilus release series. This is a
hotfix release primarily fixing a regression introduced in v14.2.5, all
nautilus users are advised to upgrade to this release.

### Notable Changes

-   This release fixes a `ceph-mgr` bug that caused mgr becoming
    unresponsive on larger clusters
    [issue#43364](https://tracker.ceph.com/issues/43364)
    ([pr#32466](https://github.com/ceph/ceph/pull/32466), David Zafman,
    Neha Ojha)

## v14.2.5 Nautilus

This is the fifth release of the Ceph Nautilus release series. Among the
many notable changes, this release fixes a critical BlueStore bug that
was introduced in 14.2.3. All Nautilus users are advised to upgrade to
this release.

### Notable Changes

Critical fix:

-   This release fixes a [critical BlueStore
    bug](https://tracker.ceph.com/issues/42223) introduced in 14.2.3
    (and also present in 14.2.4) that can lead to data corruption when a
    separate \"WAL\" device is used.

New health warnings:

-   Ceph will now issue health warnings if daemons have recently
    crashed. Ceph has been collecting crash reports since the initial
    Nautilus release, but the health alerts are new. To view new crashes
    (or all crashes, if you\'ve just upgraded):

        ceph crash ls-new

    To acknowledge a particular crash (or all crashes) and silence the
    health warning:

        ceph crash archive <crash-id>
        ceph crash archive-all

-   Ceph will issue a health warning if a RADOS pool\'s `size` is set to
    1 or, in other words, if the pool is configured with no redundancy.
    Ceph will stop issuing the warning if the pool size is set to the
    minimum recommended value:

        ceph osd pool set <pool-name> size <num-replicas>

    The warning can be silenced with:

        ceph config set global mon_warn_on_pool_no_redundancy false

-   A health warning is now generated if the average osd heartbeat ping
    time exceeds a configurable threshold for any of the intervals
    computed. The OSD computes 1 minute, 5 minute and 15 minute
    intervals with average, minimum and maximum values. New
    configuration option [mon_warn_on_slow_ping_ratio]{.title-ref}
    specifies a percentage of [osd_heartbeat_grace]{.title-ref} to
    determine the threshold. A value of zero disables the warning. New
    configuration option [mon_warn_on_slow_ping_time]{.title-ref}
    specified in milliseconds over-rides the computed value, causes a
    warning when OSD heartbeat pings take longer than the specified
    amount. A new admin command, [ceph daemon mgr.# dump_osd_network
    \[threshold\]]{.title-ref}, will list all connections with a ping
    time longer than the specified threshold or value determined by the
    config options, for the average for any of the 3 intervals. Another
    new admin command, [ceph daemon osd.# dump_osd_network
    \[threshold\]]{.title-ref}, will do the same but only including
    heartbeats initiated by the specified OSD.

Changes in the telemetry module:

-   The telemetry module now reports more information.

    First, there is a new \'device\' channel, enabled by default, that
    will report anonymized hard disk and SSD health metrics to
    telemetry.ceph.com in order to build and improve device failure
    prediction algorithms. If you are not comfortable sharing device
    metrics, you can disable that channel first before re-opting-in:

        ceph config set mgr mgr/telemetry/channel_device false

    Second, we now report more information about CephFS file systems,
    including:

    > -   how many MDS daemons (in total and per file system)
    > -   which features are (or have been) enabled
    > -   how many data pools
    > -   approximate file system age (year + month of creation)
    > -   how many files, bytes, and snapshots
    > -   how much metadata is being cached

    We have also added:

    > -   which Ceph release the monitors are running
    > -   whether msgr v1 or v2 addresses are used for the monitors
    > -   whether IPv4 or IPv6 addresses are used for the monitors
    > -   whether RADOS cache tiering is enabled (and which mode)
    > -   whether pools are replicated or erasure coded, and which
    >     erasure code profile plugin and parameters are in use
    > -   how many hosts are in the cluster, and how many hosts have
    >     each type of daemon
    > -   whether a separate OSD cluster network is being used
    > -   how many RBD pools and images are in the cluster, and how many
    >     pools have RBD mirroring enabled
    > -   how many RGW daemons, zones, and zonegroups are present; which
    >     RGW frontends are in use
    > -   aggregate stats about the CRUSH map, like which algorithms are
    >     used, how big buckets are, how many rules are defined, and
    >     what tunables are in use

    If you had telemetry enabled, you will need to re-opt-in with:

        ceph telemetry on

    You can view exactly what information will be reported first with:

        ceph telemetry show        # see everything
        ceph telemetry show basic  # basic cluster info (including all of the new info)

OSD:

-   A new OSD daemon command, \'dump_recovery_reservations\', reveals
    the recovery locks held (in_progress) and waiting in priority
    queues.
-   Another new OSD daemon command, \'dump_scrub_reservations\', reveals
    the scrub reservations that are held for local (primary) and remote
    (replica) PGs.

RGW:

-   RGW now supports S3 Object Lock set of APIs allowing for a WORM
    model for storing objects. 6 new APIs have been added put/get bucket
    object lock, put/get object retention, put/get object legal hold.
-   RGW now supports List Objects V2

### Changelog

-   bluestore/KernelDevice: fix RW_IO_MAX constant
    ([pr#31397](https://github.com/ceph/ceph/pull/31397), Sage Weil)
-   bluestore: Don\'t forget sub kv_submitted_waiters
    ([pr#30048](https://github.com/ceph/ceph/pull/30048), Jianpeng Ma)
-   bluestore: apply garbage collection against excessive blob count
    growth ([pr#30144](https://github.com/ceph/ceph/pull/30144), Igor
    Fedotov)
-   bluestore: apply shared_alloc_size to shared device with log level
    change ([pr#30229](https://github.com/ceph/ceph/pull/30229), Vikhyat
    Umrao, Sage Weil, Igor Fedotov, Neha Ojha)
-   bluestore: consolidate extents from the same device only
    ([pr#31644](https://github.com/ceph/ceph/pull/31644), Igor Fedotov)
-   bluestore: fix improper setting of STATE_KV_SUBMITTED
    ([pr#30755](https://github.com/ceph/ceph/pull/30755), Igor Fedotov)
-   bluestore: shallow fsck mode and legacy statfs auto repair
    ([pr#30685](https://github.com/ceph/ceph/pull/30685), Sage Weil,
    Igor Fedotov)
-   bluestore: tool to check fragmentation
    ([pr#29949](https://github.com/ceph/ceph/pull/29949), Adam Kupczyk)
-   build/ops: admin/build-doc: use python3
    ([pr#30664](https://github.com/ceph/ceph/pull/30664), Kefu Chai)
-   build/ops: backport endian fixes
    ([issue#40114](http://tracker.ceph.com/issues/40114),
    [pr#30697](https://github.com/ceph/ceph/pull/30697), Ulrich Weigand,
    Jeff Layton)
-   build/ops: cmake,rgw: IBM Z build fixes
    ([pr#30696](https://github.com/ceph/ceph/pull/30696), Ulrich
    Weigand)
-   build/ops: cmake/BuildDPDK: ignore gcc8/9 warnings
    ([pr#30360](https://github.com/ceph/ceph/pull/30360), Yuval
    Lifshitz)
-   build/ops: cmake: Allow cephfs and ceph-mds to be build when
    building on FreeBSD
    ([pr#31011](https://github.com/ceph/ceph/pull/31011), Willem Jan
    Withagen)
-   build/ops: cmake: enforce C++17 instead of relying on
    cmake-compile-features
    ([pr#30283](https://github.com/ceph/ceph/pull/30283), Kefu Chai)
-   build/ops: fix build fail related to PYTHON_EXECUTABLE variable
    ([pr#30261](https://github.com/ceph/ceph/pull/30261), Ilsoo Byun)
-   build/ops: hidden corei7 requirement in binary packages
    ([pr#29772](https://github.com/ceph/ceph/pull/29772), Kefu Chai)
-   build/ops: install-deps.sh: add EPEL repo for non-x86_64 archs as
    well ([pr#30601](https://github.com/ceph/ceph/pull/30601), Kefu
    Chai, Nathan Cutler)
-   build/ops: install-deps.sh: install [python\*-devel]{.title-ref} for
    python\*rpm-macros
    ([pr#30322](https://github.com/ceph/ceph/pull/30322), Kefu Chai)
-   build/ops: install-deps: do not install if rpm already installed and
    ceph.spec.in: s/pkgversion/version_nodots/
    ([pr#30708](https://github.com/ceph/ceph/pull/30708), Jeff Layton,
    Kefu Chai)
-   build/ops: make patch build dependency explicit
    ([issue#40175](http://tracker.ceph.com/issues/40175),
    [pr#30046](https://github.com/ceph/ceph/pull/30046), Nathan Cutler)
-   build/ops: python3-cephfs should provide python36-cephfs
    ([pr#30983](https://github.com/ceph/ceph/pull/30983), Kefu Chai)
-   build/ops: rpm: always build ceph-test package
    ([pr#30049](https://github.com/ceph/ceph/pull/30049), Nathan Cutler)
-   build/ops: rpm: fdupes in SUSE builds to conform with packaging
    guidelines ([issue#40973](http://tracker.ceph.com/issues/40973),
    [pr#29784](https://github.com/ceph/ceph/pull/29784), Nathan Cutler)
-   build/ops: rpm: make librados2, libcephfs2 own (create) /etc/ceph
    ([pr#31125](https://github.com/ceph/ceph/pull/31125), Nathan Cutler)
-   build/ops: rpm: put librgw lttng SOs in the librgw-devel package
    ([issue#40975](http://tracker.ceph.com/issues/40975),
    [pr#29785](https://github.com/ceph/ceph/pull/29785), Nathan Cutler)
-   build/ops: seastar,dmclock: use CXX_FLAGS from parent project
    ([pr#30114](https://github.com/ceph/ceph/pull/30114), Kefu Chai)
-   build/ops: use gcc-8
    ([issue#38892](http://tracker.ceph.com/issues/38892),
    [pr#30089](https://github.com/ceph/ceph/pull/30089), Kefu Chai)
-   tools: ceph-objectstore-tool: update-mon-db: do not fail if incmap
    is missing ([pr#30740](https://github.com/ceph/ceph/pull/30740),
    Kefu Chai)
-   ceph-volume: PVolumes.filter shouldn\'t purge itself
    ([pr#30805](https://github.com/ceph/ceph/pull/30805), Rishabh Dave)
-   ceph-volume: VolumeGroups.filter shouldn\'t purge itself
    ([pr#30807](https://github.com/ceph/ceph/pull/30807), Rishabh Dave)
-   ceph-volume: add Ceph\'s device id to inventory
    ([pr#31210](https://github.com/ceph/ceph/pull/31210), Sebastian
    Wagner)
-   ceph-volume: allow to skip restorecon calls
    ([pr#31555](https://github.com/ceph/ceph/pull/31555), Alfredo Deza)
-   ceph-volume: api/lvm: check if list of LVs is empty
    ([pr#31228](https://github.com/ceph/ceph/pull/31228), Rishabh Dave)
-   ceph-volume: check if we run in an selinux environment
    ([pr#31812](https://github.com/ceph/ceph/pull/31812), Jan Fajerski)
-   ceph-volume: do not fail when trying to remove crypt mapper
    ([pr#30554](https://github.com/ceph/ceph/pull/30554), Guillaume
    Abrioux)
-   ceph-volume: fix stderr failure to decode/encode when redirected
    ([pr#30300](https://github.com/ceph/ceph/pull/30300), Alfredo Deza)
-   ceph-volume: fix warnings raised by pytest
    ([pr#30676](https://github.com/ceph/ceph/pull/30676), Rishabh Dave)
-   ceph-volume: lvm list is O(n\^2)
    ([pr#30093](https://github.com/ceph/ceph/pull/30093), Rishabh Dave)
-   ceph-volume: lvm.zap fix cleanup for db partitions
    ([issue#40664](http://tracker.ceph.com/issues/40664),
    [pr#30304](https://github.com/ceph/ceph/pull/30304), Dominik Csapak)
-   ceph-volume: mokeypatch calls to lvm related binaries
    ([pr#31405](https://github.com/ceph/ceph/pull/31405), Jan Fajerski)
-   ceph-volume: pre-install python-apt and its variants before test
    runs ([pr#30294](https://github.com/ceph/ceph/pull/30294), Alfredo
    Deza)
-   ceph-volume: rearrange api/lvm.py
    ([pr#31408](https://github.com/ceph/ceph/pull/31408), Rishabh Dave)
-   ceph-volume: systemd fix typo in log message
    ([pr#30520](https://github.com/ceph/ceph/pull/30520), Manu Zurmühl)
-   ceph-volume: use the OSD identifier when reporting success
    ([pr#29769](https://github.com/ceph/ceph/pull/29769), Alfredo Deza)
-   ceph-volume: zap always skips block.db, leaves them around
    ([issue#40664](http://tracker.ceph.com/issues/40664),
    [pr#30307](https://github.com/ceph/ceph/pull/30307), Alfredo Deza)
-   tools: ceph.in: do not preload ASan unless necessary
    ([pr#31676](https://github.com/ceph/ceph/pull/31676), Kefu Chai)
-   build/ops: ceph.spec.in: reserve 2500MB per build job
    ([pr#30370](https://github.com/ceph/ceph/pull/30370), Dan van der
    Ster)
-   tools: ceph_volume_client: convert string to bytes object
    ([issue#39405](http://tracker.ceph.com/issues/39405),
    [issue#40369](http://tracker.ceph.com/issues/40369),
    [issue#39510](http://tracker.ceph.com/issues/39510),
    [issue#40800](http://tracker.ceph.com/issues/40800),
    [issue#40460](http://tracker.ceph.com/issues/40460),
    [pr#30030](https://github.com/ceph/ceph/pull/30030), Rishabh Dave)
-   cephfs-shell: Convert paths type from string to bytes
    ([pr#30057](https://github.com/ceph/ceph/pull/30057), Varsha Rao)
-   cephfs: Allow mount.ceph to get mount info from ceph configs and
    keyrings ([pr#30521](https://github.com/ceph/ceph/pull/30521), Jeff
    Layton)
-   cephfs: avoid map been inserted by mistake
    ([pr#29878](https://github.com/ceph/ceph/pull/29878),
    XiaoGuoDong2019)
-   cephfs: client: more precise CEPH_CLIENT_CAPS_PENDING_CAPSNAP
    ([pr#30032](https://github.com/ceph/ceph/pull/30032), \"Yan,
    Zheng\")
-   cephfs: client: nfs-ganesha with cephfs client, removing dir reports
    not empty ([issue#40746](http://tracker.ceph.com/issues/40746),
    [pr#30442](https://github.com/ceph/ceph/pull/30442), Peng Xie)
-   cephfs: client: return -eio when sync file which unsafe reqs have
    been dropped ([issue#40877](http://tracker.ceph.com/issues/40877),
    [pr#30043](https://github.com/ceph/ceph/pull/30043), simon gao)
-   cephfs: fix a memory leak
    ([pr#29879](https://github.com/ceph/ceph/pull/29879),
    XiaoGuoDong2019)
-   cephfs: mds: Fix duplicate client entries in eviction list
    ([pr#30951](https://github.com/ceph/ceph/pull/30951), Sidharth
    Anupkrishnan)
-   cephfs: mds: cleanup truncating inodes when standby replay mds trim
    log segments ([pr#29591](https://github.com/ceph/ceph/pull/29591),
    \"Yan, Zheng\")
-   cephfs: mds: delay exporting directory whose pin value exceeds max
    rank id ([issue#40603](http://tracker.ceph.com/issues/40603),
    [pr#29938](https://github.com/ceph/ceph/pull/29938), Zhi Zhang)
-   cephfs: mds: evict an unresponsive client only when another client
    wants its caps ([pr#30031](https://github.com/ceph/ceph/pull/30031),
    Rishabh Dave)
-   cephfs: mds: fix InoTable::force_consume_to()
    ([pr#30041](https://github.com/ceph/ceph/pull/30041), \"Yan,
    Zheng\")
-   cephfs: mds: fix infinite loop in Locker::file_update_finish
    ([pr#31079](https://github.com/ceph/ceph/pull/31079), \"Yan,
    Zheng\")
-   cephfs: mds: make MDSIOContextBase delete itself when shutting down
    ([pr#30418](https://github.com/ceph/ceph/pull/30418), Xuehan Xu)
-   cephfs: mds: trim cache on regular schedule
    ([pr#30040](https://github.com/ceph/ceph/pull/30040), Patrick
    Donnelly)
-   cephfs: mds: wake up lock waiters after forcibly changing lock state
    ([issue#39987](http://tracker.ceph.com/issues/39987),
    [pr#30508](https://github.com/ceph/ceph/pull/30508), \"Yan, Zheng\")
-   cephfs: mount.ceph: properly handle -o strictatime
    ([pr#30039](https://github.com/ceph/ceph/pull/30039), Jeff Layton)
-   cephfs: qa: ignore expected MDS_CLIENT_LATE_RELEASE warning
    ([issue#40968](http://tracker.ceph.com/issues/40968),
    [pr#29811](https://github.com/ceph/ceph/pull/29811), Patrick
    Donnelly)
-   cephfs: qa: wait for MDS to come back after removing it
    ([issue#40967](http://tracker.ceph.com/issues/40967),
    [pr#29832](https://github.com/ceph/ceph/pull/29832), Patrick
    Donnelly)
-   cephfs: tests: power off still resulted in client sending session
    close ([issue#37681](http://tracker.ceph.com/issues/37681),
    [pr#29983](https://github.com/ceph/ceph/pull/29983), Patrick
    Donnelly)
-   common/ceph_context: avoid unnecessary wait during service thread
    shutdown ([pr#31097](https://github.com/ceph/ceph/pull/31097), Jason
    Dillaman)
-   common/config_proxy: hold lock while accessing mutable container
    ([pr#30661](https://github.com/ceph/ceph/pull/30661), Jason
    Dillaman)
-   common: fix typo in rgw_user_max_buckets option long description
    ([pr#31605](https://github.com/ceph/ceph/pull/31605), Alfonso
    Martínez)
-   core/osd: do not trust partially simplified pg_upmap_item
    ([issue#42052](http://tracker.ceph.com/issues/42052),
    [pr#30899](https://github.com/ceph/ceph/pull/30899), xie xingguo)
-   core: Health warnings on long network ping times
    ([issue#40640](http://tracker.ceph.com/issues/40640),
    [pr#30195](https://github.com/ceph/ceph/pull/30195), David Zafman)
-   core: If the nodeep-scrub/noscrub flags are set in pools instead of
    global cluster. List the pool names in the ceph status
    ([issue#38029](http://tracker.ceph.com/issues/38029),
    [pr#29991](https://github.com/ceph/ceph/pull/29991), Mohamad Gebai)
-   core: Improve health status for backfill_toofull and
    recovery_toofull and fix backfill_toofull seen on cluster where the
    most full OSD is at 1%
    ([pr#29999](https://github.com/ceph/ceph/pull/29999), David Zafman)
-   core: Make dumping of reservation info congruent between scrub and
    recovery ([pr#31444](https://github.com/ceph/ceph/pull/31444), David
    Zafman)
-   core: Revert \"rocksdb: enable rocksdb_rmrange=true by default\"
    ([pr#31612](https://github.com/ceph/ceph/pull/31612), Neha Ojha)
-   core: filestore pre-split may not split enough directories
    ([issue#39390](http://tracker.ceph.com/issues/39390),
    [pr#29988](https://github.com/ceph/ceph/pull/29988), Jeegn Chen)
-   core: kv/RocksDBStore: tell rocksdb to set mode to 0600, not 0644
    ([pr#31031](https://github.com/ceph/ceph/pull/31031), Sage Weil)
-   core: mon/MonClient: ENXIO when sending command to down mon
    ([pr#31037](https://github.com/ceph/ceph/pull/31037), Sage Weil,
    Greg Farnum)
-   core: mon/MonCommands: \"smart\" only needs read permission
    ([pr#31111](https://github.com/ceph/ceph/pull/31111), Kefu Chai)
-   core: mon/MonMap: encode (more) valid compat monmap when we have
    v2-only addrs ([pr#31658](https://github.com/ceph/ceph/pull/31658),
    Sage Weil)
-   core: mon/Monitor.cc: fix condition that checks for unrecognized
    auth mode ([pr#31038](https://github.com/ceph/ceph/pull/31038), Neha
    Ojha)
-   core: mon/OSDMonitor: Use generic priority cache tuner for mon
    caches ([pr#30419](https://github.com/ceph/ceph/pull/30419), Sridhar
    Seshasayee, Kefu Chai, Mykola Golub, Mark Nelson)
-   core: mon/OSDMonitor: add check for crush rule size in pool set size
    command ([pr#30941](https://github.com/ceph/ceph/pull/30941),
    Vikhyat Umrao)
-   core: mon/OSDMonitor: trim not-longer-exist failure reporters
    ([pr#30904](https://github.com/ceph/ceph/pull/30904), NancySu05)
-   core: mon/PGMap: fix incorrect pg_pool_sum when delete pool
    ([pr#31704](https://github.com/ceph/ceph/pull/31704), luo rixin)
-   core: mon: C_AckMarkedDown has not handled the Callback Arguments
    ([pr#29997](https://github.com/ceph/ceph/pull/29997), NancySu05)
-   core: mon: ensure prepare_failure() marks no_reply on op
    ([pr#30480](https://github.com/ceph/ceph/pull/30480), Joao Eduardo
    Luis)
-   core: mon: show pool id in pool ls command
    ([issue#40287](http://tracker.ceph.com/issues/40287),
    [pr#30486](https://github.com/ceph/ceph/pull/30486), Chang Liu)
-   core: msg,mon/MonClient: fix auth for clients without CEPHX_V2
    feature ([pr#30524](https://github.com/ceph/ceph/pull/30524), Sage
    Weil)
-   core: msg/auth: handle decode errors instead of throwing exceptions
    ([pr#31099](https://github.com/ceph/ceph/pull/31099), Sage Weil)
-   core: msg/simple: reset in_seq_acked to zero when session is reset
    ([pr#29592](https://github.com/ceph/ceph/pull/29592), Xiangyang Yu)
-   core: os/bluestore: fix objectstore_blackhole read-after-write
    ([pr#31019](https://github.com/ceph/ceph/pull/31019), Sage Weil)
-   core: osd/OSDCap: Check for empty namespace
    ([issue#40835](http://tracker.ceph.com/issues/40835),
    [pr#29998](https://github.com/ceph/ceph/pull/29998), Brad Hubbard)
-   core: mon/OSDMonitor: make memory autotune disable itself if no
    rocksdb ([pr#32045](https://github.com/ceph/ceph/pull/32045), Sage
    Weil)
-   core: osd/PG: Add PG to large omap log message
    ([pr#30923](https://github.com/ceph/ceph/pull/30923), Brad Hubbard)
-   core: osd/PGLog: persist num_objects_missing for replicas when
    peering is done
    ([pr#31077](https://github.com/ceph/ceph/pull/31077), xie xingguo)
-   core: osd/PeeringState: do not complain about past_intervals
    constrained by oldest epoch
    ([pr#30000](https://github.com/ceph/ceph/pull/30000), Sage Weil)
-   core: osd/PeeringState: fix wrong history of merge target
    ([pr#30280](https://github.com/ceph/ceph/pull/30280), xie xingguo)
-   core: osd/PeeringState: recover_got - add special handler for empty
    log and improvements to standalone tests
    ([pr#30528](https://github.com/ceph/ceph/pull/30528), Sage Weil,
    David Zafman, xie xingguo)
-   core: osd/PrimaryLogPG: Avoid accessing destroyed references in
    finish_degr... ([pr#29994](https://github.com/ceph/ceph/pull/29994),
    Tao Ning)
-   core: osd/PrimaryLogPG: update oi.size on write op implicitly
    truncating ob...
    ([pr#30278](https://github.com/ceph/ceph/pull/30278), xie xingguo)
-   core: osd/ReplicatedBackend: check against empty data_included
    before enabling crc
    ([pr#29716](https://github.com/ceph/ceph/pull/29716), xie xingguo)
-   core: osd/osd_types: fix {omap,hitset_bytes}\_stats_invalid handling
    on spli... ([pr#30643](https://github.com/ceph/ceph/pull/30643),
    Sage Weil)
-   core: osd: Better error message when OSD count is less than
    osd_pool_default_size
    ([issue#38617](http://tracker.ceph.com/issues/38617),
    [pr#29992](https://github.com/ceph/ceph/pull/29992), Kefu Chai, Sage
    Weil, zjh)
-   core: osd: Remove unused osdmap flags full, nearfull from output
    ([pr#30900](https://github.com/ceph/ceph/pull/30900), David Zafman)
-   core: osd: add log information to record the cause of do_osd_ops
    failure ([pr#30546](https://github.com/ceph/ceph/pull/30546),
    NancySu05)
-   core: osd: clear PG_STATE_CLEAN when repair object
    ([pr#30050](https://github.com/ceph/ceph/pull/30050), Zengran Zhang)
-   core: osd: fix possible crash on sending dynamic perf stats report
    ([pr#30648](https://github.com/ceph/ceph/pull/30648), Mykola Golub)
-   core: osd: merge replica log on primary need according to replica
    log\'s crt ([pr#30051](https://github.com/ceph/ceph/pull/30051),
    Zengran Zhang)
-   core: osd: prime splits/merges for any potential fabricated
    split/merge par...
    ([issue#38483](http://tracker.ceph.com/issues/38483),
    [pr#30371](https://github.com/ceph/ceph/pull/30371), xie xingguo)
-   core: osd: release backoffs during merge
    ([pr#31822](https://github.com/ceph/ceph/pull/31822), Sage Weil)
-   core: osd: rollforward may need to mark pglog dirty
    ([issue#40403](http://tracker.ceph.com/issues/40403),
    [pr#31034](https://github.com/ceph/ceph/pull/31034), Zengran Zhang)
-   core: osd: scrub error on big objects; make bluestore refuse to
    start on big objects
    ([pr#30783](https://github.com/ceph/ceph/pull/30783), David Zafman,
    Sage Weil)
-   core: osd: support osd_repair_during_recovery
    ([issue#40620](http://tracker.ceph.com/issues/40620),
    [pr#29748](https://github.com/ceph/ceph/pull/29748), Jeegn Chen)
-   core: pool_stat.dump() - value of num_store_stats is wrong
    ([issue#39340](http://tracker.ceph.com/issues/39340),
    [pr#29946](https://github.com/ceph/ceph/pull/29946), xie xingguo)
-   doc/ceph-kvstore-tool: add description for \'stats\' command
    ([pr#30245](https://github.com/ceph/ceph/pull/30245), Josh Durgin,
    Adam Kupczyk)
-   doc/mgr/telemetry: update default interval
    ([pr#31009](https://github.com/ceph/ceph/pull/31009), Tim Serong)
-   doc/rbd: s/guess/xml/ for codeblock lexer
    ([pr#31074](https://github.com/ceph/ceph/pull/31074), Kefu Chai)
-   doc: Fix rbd namespace documentation
    ([pr#29731](https://github.com/ceph/ceph/pull/29731), Ricardo
    Marques)
-   doc: cephfs: add section on fsync error reporting to posix.rst
    ([issue#24641](http://tracker.ceph.com/issues/24641),
    [pr#30025](https://github.com/ceph/ceph/pull/30025), Jeff Layton)
-   doc: default values for mon_health_to_clog\_\* were flipped
    ([pr#30003](https://github.com/ceph/ceph/pull/30003), James McClune)
-   doc: fix urls in posix.rst
    ([pr#30686](https://github.com/ceph/ceph/pull/30686), Jos Collin)
-   doc: max_misplaced option was renamed in Nautilus
    ([pr#30649](https://github.com/ceph/ceph/pull/30649), Nathan Fish)
-   doc: pg_num should always be a power of two
    ([pr#30004](https://github.com/ceph/ceph/pull/30004), Lars
    Marowsky-Bree, Kai Wagner)
-   doc: update bluestore cache settings and clarify data fraction
    ([issue#39522](http://tracker.ceph.com/issues/39522),
    [pr#31259](https://github.com/ceph/ceph/pull/31259), Jan Fajerski)
-   mgr/ActivePyModules: behave if a module queries a devid that does
    not exist ([pr#31411](https://github.com/ceph/ceph/pull/31411), Sage
    Weil)
-   mgr/BaseMgrStandbyModule: drop GIL in ceph_get_module_option()
    ([pr#30773](https://github.com/ceph/ceph/pull/30773), Kefu Chai)
-   mgr/balancer: python3 compatibility issue
    ([pr#31012](https://github.com/ceph/ceph/pull/31012), Mykola Golub)
-   mgr/crash: backport archive feature, health alerts
    ([pr#30851](https://github.com/ceph/ceph/pull/30851), Sage Weil)
-   mgr/crash: try client.crash\[.host\] before client.admin; add mon
    profile ([issue#40781](http://tracker.ceph.com/issues/40781),
    [pr#30844](https://github.com/ceph/ceph/pull/30844), Sage Weil, Dan
    Mick)
-   mgr/dashboard: Add transifex-i18ntool
    ([pr#31160](https://github.com/ceph/ceph/pull/31160), Sebastian
    Krah)
-   mgr/dashboard: Allow disabling redirection on standby dashboards
    ([issue#41813](https://tracker.ceph.com/issues/41813),
    [pr#30382](https://github.com/ceph/ceph/pull/30382), Volker Theile)
-   mgr/dashboard: Configuring an URL prefix does not work as expected
    ([pr#31375](https://github.com/ceph/ceph/pull/31375), Volker Theile)
-   mgr/dashbaord: Fix calculation of PG status percentage
    ([issue#41809](https://tracker.ceph.com/issues/41089),
    [pr#30394](https://github.com/ceph/ceph/pull/30394), Tiago Melo)
-   mgr/dashboard: Fix CephFS chart
    ([pr#30691](https://github.com/ceph/ceph/pull/30691), Stephan
    Müller)
-   mgr/dashboard: Fix grafana dashboards
    ([pr#31733](https://github.com/ceph/ceph/pull/31733), Radu Toader)
-   mgr/dashboard: Improve position of MDS chart tooltip
    ([pr#31565](https://github.com/ceph/ceph/pull/31565), Tiago Melo)
-   mgr/dashboard: Provide the name of the object being deleted
    ([pr#31263](https://github.com/ceph/ceph/pull/31263), Ricardo
    Marques)
-   mgr/dashboard: RBD tests must use pools with power-of-two pg_num
    ([pr#31522](https://github.com/ceph/ceph/pull/31522), Ricardo
    Marques)
-   mgr/dashboard: Set RO as the default access_type for RGW NFS exports
    ([pr#30516](https://github.com/ceph/ceph/pull/30516), Tiago Melo)
-   mgr/dashboard: Wait for breadcrumb text is present in e2e tests
    ([pr#31576](https://github.com/ceph/ceph/pull/31576), Volker Theile)
-   mgr/dashboard: access_control: add grafana scope read access to
    \*-manager roles
    ([pr#30259](https://github.com/ceph/ceph/pull/30259), Ricardo Dias)
-   mgr/dashboard: do not log tokens
    ([pr#31413](https://github.com/ceph/ceph/pull/31413), Kefu Chai)
-   mgr/dashboard: do not show non-pool data in pool details
    ([pr#31516](https://github.com/ceph/ceph/pull/31516), Alfonso
    Martínez)
-   mgr/dashboard: edit/clone/copy rbd image after its data is received
    ([pr#31349](https://github.com/ceph/ceph/pull/31349), Alfonso
    Martínez)
-   mgr/dashboard: internationalization support with AOT enabled
    ([pr#30910](https://github.com/ceph/ceph/pull/30910), Ricardo Dias,
    Tiago Melo)
-   mgr/dashboard: run-backend-api-tests.sh improvements
    ([pr#29487](https://github.com/ceph/ceph/pull/29487), Alfonso
    Martínez, Kefu Chai)
-   mgr/dashboard: tasks: only unblock controller thread after
    TaskManager thread
    ([pr#31526](https://github.com/ceph/ceph/pull/31526), Ricardo Dias)
-   mgr/devicehealth: do not scrape mon devices
    ([pr#31446](https://github.com/ceph/ceph/pull/31446), Sage Weil)
-   mgr/devicehealth: import \_strptime directly
    ([pr#32082](https://github.com/ceph/ceph/pull/32082), Sage Weil)
-   mgr/k8sevents: Initial ceph -\> k8s events integration
    ([pr#30215](https://github.com/ceph/ceph/pull/30215), Paul Cuzner,
    Sebastian Wagner)
-   mgr/pg_autoscaler: fix pool_logical_used
    ([pr#31100](https://github.com/ceph/ceph/pull/31100), Ansgar
    Jazdzewski)
-   mgr/pg_autoscaler: fix race with pool deletion
    ([pr#30008](https://github.com/ceph/ceph/pull/30008), Sage Weil)
-   mgr/prometheus: Cast collect_timeout (scrape_interval) to float
    ([pr#30007](https://github.com/ceph/ceph/pull/30007), Ben Meekhof)
-   mgr/prometheus: Fix KeyError in get_mgr_status
    ([pr#30774](https://github.com/ceph/ceph/pull/30774), Sebastian
    Wagner)
-   mgr/rbd_support: module.py:1088: error: Name \'image_spec\' is not
    defined ([pr#29978](https://github.com/ceph/ceph/pull/29978), Jason
    Dillaman)
-   mgr/restful: requests api adds support multiple commands
    ([pr#31334](https://github.com/ceph/ceph/pull/31334), Duncan Chiang)
-   mgr/telemetry: backport a ton of stuff
    ([pr#30849](https://github.com/ceph/ceph/pull/30849), alfonsomthd,
    Kefu Chai, Sage Weil, Dan Mick)
-   mgr/volumes: fix incorrect snapshot path creation
    ([pr#31076](https://github.com/ceph/ceph/pull/31076), Ramana Raja)
-   mgr/volumes: handle exceptions in purge thread with retry
    ([issue#41218](http://tracker.ceph.com/issues/41218),
    [pr#30455](https://github.com/ceph/ceph/pull/30455), Venky Shankar)
-   mgr/volumes: list FS subvolumes, subvolume groups, and their
    snapshots ([pr#30827](https://github.com/ceph/ceph/pull/30827), Jos
    Collin)
-   mgr/volumes: minor fixes
    ([pr#29926](https://github.com/ceph/ceph/pull/29926), Venky Shankar,
    Jos Collin, Ramana Raja)
-   mgr/volumes: protection for \"fs volume rm\" command
    ([pr#30768](https://github.com/ceph/ceph/pull/30768), Jos Collin,
    Ramana Raja)
-   mgr/zabbix: Fix typo in key name for PGs in backfill_wait state
    ([issue#39666](http://tracker.ceph.com/issues/39666),
    [pr#30006](https://github.com/ceph/ceph/pull/30006), Wido den
    Hollander)
-   mgr/zabbix: encode string for Python 3 compatibility
    ([pr#30016](https://github.com/ceph/ceph/pull/30016), Nathan Cutler)
-   mgr/{dashboard,prometheus}: return FQDN instead of \'0.0.0.0\'
    ([pr#31482](https://github.com/ceph/ceph/pull/31482), Patrick
    Seidensal)
-   mgr: Release GIL before calling OSDMap::calc_pg_upmaps()
    ([pr#31682](https://github.com/ceph/ceph/pull/31682), David Zafman,
    Shyukri Shyukriev)
-   mgr: Unable to reset / unset module options
    ([issue#40779](http://tracker.ceph.com/issues/40779),
    [pr#29550](https://github.com/ceph/ceph/pull/29550), Sebastian
    Wagner)
-   mgr: do not reset reported if a new metric is not collected
    ([pr#30390](https://github.com/ceph/ceph/pull/30390), Ilsoo Byun)
-   mgr: fix weird health-alert daemon key
    ([pr#31039](https://github.com/ceph/ceph/pull/31039), xie xingguo)
-   mgr: set hostname in DeviceState::set_metadata()
    ([pr#30624](https://github.com/ceph/ceph/pull/30624), Kefu Chai)
-   pybind/cephfs: Modification to error message
    ([pr#30026](https://github.com/ceph/ceph/pull/30026), Varsha Rao)
-   pybind/rados: fix set_omap() crash on py3
    ([pr#30622](https://github.com/ceph/ceph/pull/30622), Sage Weil)
-   pybind/rbd: deprecate [parent_info]{.title-ref}
    ([pr#30818](https://github.com/ceph/ceph/pull/30818), Ricardo
    Marques)
-   rbd: rbd-mirror: cannot restore deferred deletion mirrored images
    ([pr#30825](https://github.com/ceph/ceph/pull/30825), Jason
    Dillaman, Mykola Golub)
-   rbd: rbd-mirror: don\'t overwrite status error returned by replay
    ([pr#29870](https://github.com/ceph/ceph/pull/29870), Mykola Golub)
-   rbd: rbd-mirror: ignore errors relating to parsing the cluster
    config file ([pr#30116](https://github.com/ceph/ceph/pull/30116),
    Jason Dillaman)
-   rbd: rbd-mirror: simplify peer bootstrapping
    ([pr#30821](https://github.com/ceph/ceph/pull/30821), Jason
    Dillaman)
-   rbd: rbd-nbd: add netlink support and nl resize
    ([pr#30532](https://github.com/ceph/ceph/pull/30532), Mike Christie)
-   rbd: cls/rbd: sanitize entity instance messenger version type
    ([pr#30822](https://github.com/ceph/ceph/pull/30822), Jason
    Dillaman)
-   rbd: cls/rbd: sanitize the mirror image status peer address after
    reading from disk
    ([pr#31833](https://github.com/ceph/ceph/pull/31833), Jason
    Dillaman)
-   rbd: krbd: avoid udev netlink socket overrun and retry on transient
    errors from udev_enumerate_scan_devices()
    ([pr#31075](https://github.com/ceph/ceph/pull/31075), Ilya Dryomov,
    Adam C. Emerson)
-   rbd: librbd: always try to acquire exclusive lock when removing
    image ([pr#29869](https://github.com/ceph/ceph/pull/29869), Mykola
    Golub)
-   rbd: librbd: behave more gracefully when data pool removed
    ([pr#30824](https://github.com/ceph/ceph/pull/30824), Mykola Golub)
-   rbd: librbd: v1 clones are restricted to the same namespace
    ([pr#30823](https://github.com/ceph/ceph/pull/30823), Jason
    Dillaman)
-   mgr/restful: Query nodes_by_id for items
    ([pr#31261](https://github.com/ceph/ceph/pull/31261), Boris Ranto)
-   rgw/amqp: fix race condition in AMQP unit test
    ([pr#30889](https://github.com/ceph/ceph/pull/30889), Yuval
    Lifshitz)
-   rgw/amqp: remove flaky amqp test
    ([pr#31628](https://github.com/ceph/ceph/pull/31628), Yuval
    Lifshitz)
-   rgw/pubsub: backport notifications and pubsub
    ([pr#30579](https://github.com/ceph/ceph/pull/30579), Yuval
    Lifshitz)
-   rgw/rgw_op: Remove get_val from hotpath via legacy options
    ([pr#30160](https://github.com/ceph/ceph/pull/30160), Mark Nelson)
-   rgw: Potential crash in putbj
    ([pr#29898](https://github.com/ceph/ceph/pull/29898), Adam C.
    Emerson)
-   rgw: Put User Policy is sensitive to whitespace
    ([pr#29970](https://github.com/ceph/ceph/pull/29970), Abhishek
    Lekshmanan)
-   rgw: RGWCoroutine::call(nullptr) sets retcode=0
    ([pr#30248](https://github.com/ceph/ceph/pull/30248), Casey Bodley)
-   rgw: Swift metadata dropped after S3 bucket versioning enabled
    ([pr#29961](https://github.com/ceph/ceph/pull/29961), Marcus Watts)
-   rgw: add S3 object lock feature to support object worm
    ([pr#29905](https://github.com/ceph/ceph/pull/29905), Chang Liu,
    Casey Bodley, zhang Shaowen)
-   rgw: add minssing admin property when sync user info
    ([pr#30680](https://github.com/ceph/ceph/pull/30680), zhang Shaowen)
-   rgw: beast frontend throws an exception when running out of FDs
    ([pr#29963](https://github.com/ceph/ceph/pull/29963), Yuval
    Lifshitz)
-   rgw: data/bilogs are trimmed when no peers are reading them
    ([issue#39487](http://tracker.ceph.com/issues/39487),
    [pr#30999](https://github.com/ceph/ceph/pull/30999), Casey Bodley)
-   rgw: datalog/mdlog trim commands loop until done
    ([pr#30869](https://github.com/ceph/ceph/pull/30869), Casey Bodley)
-   rgw: dns name is not case sensitive
    ([issue#40995](http://tracker.ceph.com/issues/40995),
    [pr#29971](https://github.com/ceph/ceph/pull/29971), Casey Bodley,
    Abhishek Lekshmanan)
-   rgw: fix a bug that lifecycle expiraton generates delete marker
    continuously ([issue#40393](http://tracker.ceph.com/issues/40393),
    [pr#30037](https://github.com/ceph/ceph/pull/30037), zhang Shaowen)
-   rgw: fix cls_bucket_list_unordered() partial results
    ([pr#30252](https://github.com/ceph/ceph/pull/30252), Mark Kogan)
-   rgw: fix data sync start delay if remote haven\'t init data_log
    ([pr#30509](https://github.com/ceph/ceph/pull/30509), Tianshan Qu)
-   rgw: fix default storage class for get_compression_type
    ([pr#31026](https://github.com/ceph/ceph/pull/31026), Casey Bodley)
-   rgw: fix drain handles error when deleting bucket with bypass-gc
    option ([pr#29956](https://github.com/ceph/ceph/pull/29956),
    dongdong tao)
-   rgw: fix list bucket with delimiter wrongly skip some special keys
    ([issue#40905](http://tracker.ceph.com/issues/40905),
    [pr#30068](https://github.com/ceph/ceph/pull/30068), Tianshan Qu)
-   rgw: fix memory growth while deleteing objects with
    ([pr#30472](https://github.com/ceph/ceph/pull/30472), Mark Kogan)
-   rgw: fix the bug of rgw not doing necessary checking to website
    configuration ([issue#40678](http://tracker.ceph.com/issues/40678),
    [pr#30325](https://github.com/ceph/ceph/pull/30325), Enming Zhang)
-   rgw: fixed \"unrecognized arg\" error when using \"radosgw-admin
    zone rm\" ([pr#30247](https://github.com/ceph/ceph/pull/30247),
    Hongang Chen)
-   rgw: housekeeping reset stats
    ([pr#29803](https://github.com/ceph/ceph/pull/29803), J. Eric
    Ivancich)
-   rgw: increase beast parse buffer size to 64k
    ([pr#30437](https://github.com/ceph/ceph/pull/30437), Casey Bodley)
-   rgw: ldap auth: S3 auth failure should return InvalidAccessKeyId
    ([pr#30651](https://github.com/ceph/ceph/pull/30651), Matt Benjamin)
-   rgw: lifecycle days may be 0
    ([pr#31073](https://github.com/ceph/ceph/pull/31073), Matt Benjamin)
-   rgw: lifecycle transitions on non existent placement targets
    ([pr#29955](https://github.com/ceph/ceph/pull/29955), Abhishek
    Lekshmanan)
-   rgw: list objects version 2
    ([pr#29849](https://github.com/ceph/ceph/pull/29849), Albin Antony,
    zhang Shaowen)
-   rgw: multisite: radosgw-admin bucket sync status incorrectly reports
    \"caught up\" during full sync
    ([issue#40806](http://tracker.ceph.com/issues/40806),
    [pr#29974](https://github.com/ceph/ceph/pull/29974), Casey Bodley)
-   rgw: potential realm watch lost
    ([issue#40991](http://tracker.ceph.com/issues/40991),
    [pr#29972](https://github.com/ceph/ceph/pull/29972), Tianshan Qu)
-   rgw: protect AioResultList by a lock to avoid race condition
    ([pr#30746](https://github.com/ceph/ceph/pull/30746), Ilsoo Byun)
-   rgw: radosgw-admin: add \--uid check in bucket list command
    ([pr#30604](https://github.com/ceph/ceph/pull/30604), Vikhyat Umrao)
-   rgw: returns one byte more data than the requested range from the
    SLO object ([pr#29960](https://github.com/ceph/ceph/pull/29960),
    Andrey Groshev)
-   rgw: rgw-admin: search for user by access key
    ([pr#29959](https://github.com/ceph/ceph/pull/29959), Matt Benjamin)
-   rgw: rgw-log issues the wrong message when decompression fails
    ([pr#29965](https://github.com/ceph/ceph/pull/29965), Han Fengzhe)
-   rgw: rgw_file: directory enumeration can be accelerated 1-2 orders
    of magnitude taking stats from bucket index Part I (stats from
    S3/Swift only) ([issue#40456](http://tracker.ceph.com/issues/40456),
    [pr#29954](https://github.com/ceph/ceph/pull/29954), Matt Benjamin)
-   rgw: rgw_file: readdir: do not construct markers w/leading \'/\'
    ([pr#29969](https://github.com/ceph/ceph/pull/29969), Matt Benjamin)
-   rgw: silence warning \"control reaches end of non-void function\"
    ([issue#40747](http://tracker.ceph.com/issues/40747),
    [pr#31742](https://github.com/ceph/ceph/pull/31742), Jos Collin)
-   rgw: sync with elastic search v7
    ([pr#31027](https://github.com/ceph/ceph/pull/31027), Chang Liu)
-   rgw: use explicit to_string() overload for boost::string_ref
    ([issue#39611](http://tracker.ceph.com/issues/39611),
    [pr#31650](https://github.com/ceph/ceph/pull/31650), Casey Bodley,
    Ulrich Weigand)
-   rgw: when using radosgw-admin to list bucket, can set \--max-entries
    excessively high
    ([pr#29777](https://github.com/ceph/ceph/pull/29777), J. Eric
    Ivancich)
-   tests: \"CMake Error\" in test_envlibrados_for_rocksdb.sh
    ([pr#29979](https://github.com/ceph/ceph/pull/29979), Kefu Chai)
-   tests: Get libcephfs and cephfs to compile with FreeBSD
    ([pr#31136](https://github.com/ceph/ceph/pull/31136), Willem Jan
    Withagen)
-   tests: add debugging failed osd-release setting
    ([pr#31040](https://github.com/ceph/ceph/pull/31040), Patrick
    Donnelly)
-   tests: cephfs: fix malformed qa suite config
    ([pr#30038](https://github.com/ceph/ceph/pull/30038), Patrick
    Donnelly)
-   tests: cls_rbd/test_cls_rbd: update TestClsRbd.sparsify
    ([pr#30354](https://github.com/ceph/ceph/pull/30354), Kefu Chai)
-   tests: cls_rbd: removed mirror peer pool test cases
    ([pr#30948](https://github.com/ceph/ceph/pull/30948), Jason
    Dillaman)
-   tests: enable dashboard tests to be run with \"\--suite
    rados/dashboard\"
    ([pr#31248](https://github.com/ceph/ceph/pull/31248), Nathan Cutler)
-   tests: librbd: set nbd timeout due to newer kernels defaulting it on
    ([pr#30423](https://github.com/ceph/ceph/pull/30423), Jason
    Dillaman)
-   tests: qa/suites/krbd: run unmap subsuite with msgr1 only
    ([pr#31290](https://github.com/ceph/ceph/pull/31290), Ilya Dryomov)
-   tests: qa/tasks/cbt: run stop-all.sh while shutting down
    ([pr#31304](https://github.com/ceph/ceph/pull/31304), Sage Weil)
-   tests: qa/tasks/ceph.conf.template: increase mon tell retries
    ([pr#31641](https://github.com/ceph/ceph/pull/31641), Sage Weil)
-   tests: qa/workunits/rbd: stress test [rbd mirror pool status
    \--verbose]{.title-ref}
    ([pr#29871](https://github.com/ceph/ceph/pull/29871), Mykola Golub)
-   tests: qa: avoid page cache for krbd discard round off tests
    ([pr#30464](https://github.com/ceph/ceph/pull/30464), Ilya Dryomov)
-   tests: qa: sleep briefly after resetting kclient
    ([pr#29750](https://github.com/ceph/ceph/pull/29750), Patrick
    Donnelly)
-   tests: rados/mgr/tasks/module_selftest: whitelist mgr client getting
    blacklisted ([issue#40867](http://tracker.ceph.com/issues/40867),
    [pr#29649](https://github.com/ceph/ceph/pull/29649), Sage Weil)
-   tests: test_librados_build.sh: grab from nautilus branch in nautilus
    ([pr#31604](https://github.com/ceph/ceph/pull/31604), Nathan Cutler)
-   tests: valgrind: UninitCondition in
    ceph::crypto::onwire::AES128GCM_OnWireRxHandler::authenticated_decrypt_update_final()
    ([issue#38827](http://tracker.ceph.com/issues/38827),
    [pr#29928](https://github.com/ceph/ceph/pull/29928), Radoslaw
    Zarzynski)
-   tools/rados: add \--pgid in help
    ([pr#30607](https://github.com/ceph/ceph/pull/30607), Vikhyat Umrao)
-   tools/rados: call pool_lookup() after rados is connected
    ([pr#30605](https://github.com/ceph/ceph/pull/30605), Vikhyat Umrao)
-   tools/rbd-ggate: close log before running postfork
    ([pr#30120](https://github.com/ceph/ceph/pull/30120), Willem Jan
    Withagen)
-   tools: ceph-backport.sh: add deprecation warning
    ([pr#30748](https://github.com/ceph/ceph/pull/30748), Nathan Cutler)
-   tools: ceph-objectstore-tool can\'t remove head with bad snapset
    ([pr#30080](https://github.com/ceph/ceph/pull/30080), David Zafman)

## v14.2.4 Nautilus

This is the fourth release in the Ceph Nautilus stable release series.
Its sole purpose is to fix a regression that found its way into the
previous release.

### Notable Changes

-   The ceph-volume in Nautilus v14.2.3 was found to contain a serious
    regression, described in `https://tracker.ceph.com/issues/41660`,
    which prevented deployment tools like ceph-ansible, DeepSea, Rook,
    etc. from deploying/removing OSDs.

### Changelog

-   ceph-volume: fix stderr failure to decode/encode when redirected
    ([pr#30300](https://github.com/ceph/ceph/pull/30300), Alfredo Deza)

## v14.2.3 Nautilus

This is the third bug fix release of Ceph Nautilus release series. We
recommend all Nautilus users upgrade to this release. For upgrading from
older releases of ceph, general guidelines for upgrade to nautilus must
be followed `nautilus-old-upgrade`{.interpreted-text role="ref"}.

### Notable Changes

-   [CVE-2019-10222]{.title-ref} - Fixed a denial of service
    vulnerability where an unauthenticated client of Ceph Object Gateway
    could trigger a crash from an uncaught exception
-   Nautilus-based librbd clients can now open images on Jewel clusters.
-   The RGW [num_rados_handles]{.title-ref} has been removed. If you
    were using a value of [num_rados_handles]{.title-ref} greater than
    1, multiply your current [objecter_inflight_ops]{.title-ref} and
    [objecter_inflight_op_bytes]{.title-ref} parameters by the old
    [num_rados_handles]{.title-ref} to get the same throttle behavior.
-   The secure mode of Messenger v2 protocol is no longer experimental
    with this release. This mode is now the preferred mode of connection
    for monitors.
-   \"osd_deep_scrub_large_omap_object_key_threshold\" has been lowered
    to detect an object with large number of omap keys more easily.
-   The Ceph Dashboard now supports silencing Prometheus alert
    notifications.

### Changelog

-   bluestore: 50-100% iops lost due to bluefs_preextend_wal_files =
    false ([issue#38559](http://tracker.ceph.com/issues/38559),
    [pr#28573](https://github.com/ceph/ceph/pull/28573), Vitaliy
    Filippov)
-   bluestore: add slow op detection for collection_listing
    ([pr#29227](https://github.com/ceph/ceph/pull/29227), Igor Fedotov)
-   bluestore: avoid length overflow in extents returned by Stupid
    Allocator ([issue#40703](http://tracker.ceph.com/issues/40703),
    [pr#29023](https://github.com/ceph/ceph/pull/29023), Igor Fedotov)
-   bluestore/bluefs_types: consolidate contiguous extents
    ([pr#28862](https://github.com/ceph/ceph/pull/28862), Sage Weil)
-   bluestore/bluestore-tool: minor fixes around migrate
    ([pr#28893](https://github.com/ceph/ceph/pull/28893), Igor Fedotov)
-   bluestore: create the tail when first set FLAG_OMAP
    ([issue#36482](http://tracker.ceph.com/issues/36482),
    [pr#28963](https://github.com/ceph/ceph/pull/28963), Tao Ning)
-   bluestore: do not set osd_memory_target default from cgroup limit
    ([pr#29745](https://github.com/ceph/ceph/pull/29745), Sage Weil)
-   bluestore: fix \>2GB bluefs writes
    ([pr#28966](https://github.com/ceph/ceph/pull/28966), kungf, Sage
    Weil)
-   bluestore: load OSD all compression settings unconditionally
    ([issue#40480](http://tracker.ceph.com/issues/40480),
    [pr#28892](https://github.com/ceph/ceph/pull/28892), Igor Fedotov)
-   bluestore: more smart allocator dump when lacking space for bluefs
    ([issue#40623](http://tracker.ceph.com/issues/40623),
    [pr#28891](https://github.com/ceph/ceph/pull/28891), Igor Fedotov)
-   bluestore: Set concurrent max_background_compactions in rocksdb to 2
    ([issue#40769](http://tracker.ceph.com/issues/40769),
    [pr#29162](https://github.com/ceph/ceph/pull/29162), Mark Nelson)
-   bluestore: support RocksDB prefetch in buffered read mode
    ([pr#28962](https://github.com/ceph/ceph/pull/28962), Igor Fedotov)
-   build/ops: Module \'dashboard\' has failed: No module named routes
    ([issue#24420](http://tracker.ceph.com/issues/24420),
    [pr#28992](https://github.com/ceph/ceph/pull/28992), Paul Emmerich)
-   build/ops: rpm: drop SuSEfirewall2
    ([issue#40738](http://tracker.ceph.com/issues/40738),
    [pr#29007](https://github.com/ceph/ceph/pull/29007), Matthias
    Gerstner)
-   build/ops: rpm: Require ceph-grafana-dashboards
    ([pr#29682](https://github.com/ceph/ceph/pull/29682), Boris Ranto)
-   cephfs: ceph-fuse: mount does not support the fallocate()
    ([issue#40615](http://tracker.ceph.com/issues/40615),
    [pr#29157](https://github.com/ceph/ceph/pull/29157), huanwen ren)
-   cephfs: ceph_volume_client: d_name needs to be converted to string
    before using ([issue#39406](http://tracker.ceph.com/issues/39406),
    [pr#28609](https://github.com/ceph/ceph/pull/28609), Rishabh Dave)
-   cephfs: client: bump ll_ref from int32 to uint64_t
    ([pr#29186](https://github.com/ceph/ceph/pull/29186), Xiaoxi CHEN)
-   cephfs: client: set snapdir\'s link count to 1
    ([issue#40101](http://tracker.ceph.com/issues/40101),
    [pr#29343](https://github.com/ceph/ceph/pull/29343), \"Yan, Zheng\")
-   cephfs: client: unlink dentry for inode with llref=0
    ([issue#40960](http://tracker.ceph.com/issues/40960),
    [pr#29478](https://github.com/ceph/ceph/pull/29478), Xiaoxi CHEN)
-   cephfs: getattr on snap inode stuck
    ([issue#40361](http://tracker.ceph.com/issues/40361),
    [pr#29231](https://github.com/ceph/ceph/pull/29231), \"Yan, Zheng\")
-   cephfs: mds: cannot switch mds state from standby-replay to active
    ([issue#40213](http://tracker.ceph.com/issues/40213),
    [pr#29233](https://github.com/ceph/ceph/pull/29233), simon gao)
-   cephfs: mds: cleanup unneeded client_snap_caps when splitting snap
    inode ([issue#39987](http://tracker.ceph.com/issues/39987),
    [pr#29344](https://github.com/ceph/ceph/pull/29344), \"Yan, Zheng\")
-   cephfs-shell: name \'files\' is not defined error in do_rm()
    ([issue#40489](http://tracker.ceph.com/issues/40489),
    [pr#29158](https://github.com/ceph/ceph/pull/29158), Varsha Rao)
-   cephfs-shell: TypeError in poutput
    ([issue#40679](http://tracker.ceph.com/issues/40679),
    [pr#29156](https://github.com/ceph/ceph/pull/29156), Varsha Rao)
-   ceph.spec.in: Drop systemd BuildRequires in case of building for
    SUSE ([pr#28937](https://github.com/ceph/ceph/pull/28937), Dominique
    Leuenberger)
-   ceph-volume: batch functional idempotency test fails since message
    is now on stderr
    ([pr#29689](https://github.com/ceph/ceph/pull/29689), Jan Fajerski)
-   ceph-volume: batch gets confused when the same device is passed in
    two device lists
    ([pr#29690](https://github.com/ceph/ceph/pull/29690), Jan Fajerski)
-   ceph-volume: does not recognize wal/db partitions created by
    ceph-disk ([pr#29464](https://github.com/ceph/ceph/pull/29464), Jan
    Fajerski)
-   ceph-volume: \[filestore,bluestore\] single type strategies fail
    after tracking devices as sets
    ([pr#29702](https://github.com/ceph/ceph/pull/29702), Jan Fajerski)
-   ceph-volume: lvm.activate: Return an error if WAL/DB devices absent
    ([pr#29040](https://github.com/ceph/ceph/pull/29040), David Casier)
-   ceph-volume: missing string substitution when reporting mounts
    ([issue#25030](http://tracker.ceph.com/issues/25030),
    [pr#29260](https://github.com/ceph/ceph/pull/29260), Shyukri
    Shyukriev)
-   ceph-volume: prints errors to stdout with \--format json
    ([issue#38548](http://tracker.ceph.com/issues/38548),
    [pr#29506](https://github.com/ceph/ceph/pull/29506), Jan Fajerski)
-   ceph-volume: prints log messages to stdout
    ([pr#29600](https://github.com/ceph/ceph/pull/29600), Jan Fajerski,
    Kefu Chai, Alfredo Deza)
-   ceph-volume: run functional tests without dashboard
    ([pr#29694](https://github.com/ceph/ceph/pull/29694), Andrew Schoen)
-   ceph-volume: simple functional tests drop test for lvm zap
    ([pr#29660](https://github.com/ceph/ceph/pull/29660), Jan Fajerski)
-   ceph-volume: tests set the noninteractive flag for Debian
    ([pr#29899](https://github.com/ceph/ceph/pull/29899), Alfredo Deza)
-   ceph-volume: when \'type\' file is not present activate fails
    ([pr#29416](https://github.com/ceph/ceph/pull/29416), Alfredo Deza)
-   cmake: update FindBoost.cmake
    ([pr#29436](https://github.com/ceph/ceph/pull/29436), Willem Jan
    Withagen)
-   common/config: respect POD_MEMORY_REQUEST \*and\* POD_MEMORY_LIMIT
    env vars ([pr#29562](https://github.com/ceph/ceph/pull/29562),
    Patrick Donnelly, Sage Weil)
-   common: Keyrings created by ceph auth get are not suitable for ceph
    auth import ([issue#22227](http://tracker.ceph.com/issues/22227),
    [pr#28740](https://github.com/ceph/ceph/pull/28740), Kefu Chai)
-   common: OutputDataSocket retakes mutex on error path
    ([issue#40188](http://tracker.ceph.com/issues/40188),
    [pr#29147](https://github.com/ceph/ceph/pull/29147), Casey Bodley)
-   core: Better default value for osd_snap_trim_sleep
    ([pr#29678](https://github.com/ceph/ceph/pull/29678), Neha Ojha)
-   core: Change default for bluestore_fsck_on_mount_deep as false
    ([pr#29697](https://github.com/ceph/ceph/pull/29697), Neha Ojha)
-   core: lazy omap stat collection
    ([pr#29188](https://github.com/ceph/ceph/pull/29188), Brad Hubbard)
-   core: librados: move buffer free functions to inline namespace
    ([issue#39972](http://tracker.ceph.com/issues/39972),
    [pr#29244](https://github.com/ceph/ceph/pull/29244), Jason Dillaman)
-   core: maybe_remove_pg_upmap can be super inefficient for large
    clusters ([issue#40104](http://tracker.ceph.com/issues/40104),
    [pr#28756](https://github.com/ceph/ceph/pull/28756), xie xingguo)
-   core: MDSMonitor: use stringstream instead of dout for mds repaired
    ([issue#40472](http://tracker.ceph.com/issues/40472),
    [pr#29159](https://github.com/ceph/ceph/pull/29159), Zhi Zhang)
-   core: osd beacon sometimes has empty pg list
    ([issue#40377](http://tracker.ceph.com/issues/40377),
    [pr#29254](https://github.com/ceph/ceph/pull/29254), Sage Weil)
-   core: s3tests-test-readwrite failed in rados run (Connection
    refused) ([issue#17882](http://tracker.ceph.com/issues/17882),
    [pr#29325](https://github.com/ceph/ceph/pull/29325), Casey Bodley)
-   doc: Document more cache modes
    ([issue#14153](http://tracker.ceph.com/issues/14153),
    [pr#28958](https://github.com/ceph/ceph/pull/28958), Nathan Cutler)
-   doc: fix rgw ldap username token
    ([pr#29455](https://github.com/ceph/ceph/pull/29455), Thomas
    Kriechbaumer)
-   doc: Improved dashboard feature overview
    ([pr#28919](https://github.com/ceph/ceph/pull/28919), Lenz Grimmer)
-   doc: Object Gateway multisite document read-only argument error
    ([issue#40458](http://tracker.ceph.com/issues/40458),
    [pr#29306](https://github.com/ceph/ceph/pull/29306), Chenjiong Deng)
-   doc/rados: Correcting some typos in the clay code documentation
    ([pr#29191](https://github.com/ceph/ceph/pull/29191), Myna)
-   doc/rbd: initial live-migration documentation
    ([issue#40486](http://tracker.ceph.com/issues/40486),
    [pr#29724](https://github.com/ceph/ceph/pull/29724), Jason Dillaman)
-   doc/rgw: document use of \'realm pull\' instead of \'period pull\'
    ([issue#39655](http://tracker.ceph.com/issues/39655),
    [pr#29484](https://github.com/ceph/ceph/pull/29484), Casey Bodley)
-   doc: steps to disable metadata_heap on existing rgw zones
    ([issue#18174](http://tracker.ceph.com/issues/18174),
    [pr#28738](https://github.com/ceph/ceph/pull/28738), Dan van der
    Ster)
-   doc: Update \'ceph-iscsi\' min version
    ([pr#29444](https://github.com/ceph/ceph/pull/29444), Ricardo
    Marques)
-   journal: properly advance read offset after skipping invalid range
    ([pr#28816](https://github.com/ceph/ceph/pull/28816), Mykola Golub)
-   librbd: improve journal performance to match expected degredation
    ([issue#40072](http://tracker.ceph.com/issues/40072),
    [pr#29723](https://github.com/ceph/ceph/pull/29723), Mykola Golub,
    Jason Dillaman)
-   librbd: properly track in-flight flush requests
    ([issue#40555](http://tracker.ceph.com/issues/40555),
    [pr#28769](https://github.com/ceph/ceph/pull/28769), Jason Dillaman)
-   librbd: snapshot object maps can go inconsistent during copyup
    ([issue#39435](http://tracker.ceph.com/issues/39435),
    [pr#29722](https://github.com/ceph/ceph/pull/29722), Ilya Dryomov)
-   mds: change how mds revoke stale caps
    ([issue#17854](http://tracker.ceph.com/issues/17854),
    [pr#28583](https://github.com/ceph/ceph/pull/28583), Rishabh Dave,
    \"Yan, Zheng\")
-   mgr: Add mgr metdata to prometheus exporter module
    ([pr#29168](https://github.com/ceph/ceph/pull/29168), Paul Cuzner)
-   mgr/dashboard: Add, update and remove translations
    ([issue#39701](http://tracker.ceph.com/issues/39701),
    [pr#28938](https://github.com/ceph/ceph/pull/28938), Sebastian Krah)
-   mgr/dashboard: cephfs multimds graphs stack together
    ([issue#37579](http://tracker.ceph.com/issues/37579),
    [pr#28889](https://github.com/ceph/ceph/pull/28889), Kiefer Chang)
-   mgr/dashboard: Changing rgw-api-host does not get effective without
    disable/enable dashboard mgr module
    ([issue#40252](http://tracker.ceph.com/issues/40252),
    [pr#29044](https://github.com/ceph/ceph/pull/29044), Ricardo
    Marques)
-   mgr/dashboard: controllers/grafana is not Python3 compatible
    ([issue#40428](http://tracker.ceph.com/issues/40428),
    [pr#29524](https://github.com/ceph/ceph/pull/29524), Patrick
    Nawracay)
-   mgr/dashboard: Dentries value of MDS daemon in Filesystems page is
    inconsistent with ceph fs status output
    ([issue#40097](http://tracker.ceph.com/issues/40097),
    [pr#28912](https://github.com/ceph/ceph/pull/28912), Kiefer Chang)
-   mgr/dashboard: Display logged in information for each iSCSI client
    ([issue#40046](http://tracker.ceph.com/issues/40046),
    [pr#29045](https://github.com/ceph/ceph/pull/29045), Ricardo
    Marques)
-   mgr/dashboard: Fix e2e failures caused by webdriver version
    ([pr#29491](https://github.com/ceph/ceph/pull/29491), Tiago Melo)
-   mgr/dashboard: Fix npm vulnerabilities
    ([issue#40677](http://tracker.ceph.com/issues/40677),
    [pr#29102](https://github.com/ceph/ceph/pull/29102), Tiago Melo)
-   mgr/dashboard: Fix the table mouseenter event handling test
    ([issue#40580](http://tracker.ceph.com/issues/40580),
    [pr#29354](https://github.com/ceph/ceph/pull/29354), Stephan Müller)
-   mgr/dashboard: Interlock [fast-diff]{.title-ref} and
    [object-map]{.title-ref}
    ([issue#39451](http://tracker.ceph.com/issues/39451),
    [pr#29442](https://github.com/ceph/ceph/pull/29442), Patrick
    Nawracay)
-   mgr/dashboard: notify the user about unset \'mon_allow_pool_delete\'
    flag beforehand
    ([issue#39533](http://tracker.ceph.com/issues/39533),
    [pr#28833](https://github.com/ceph/ceph/pull/28833), Tatjana Dehler)
-   mgr/dashboard: Optimize the calculation of portal IPs
    ([issue#39580](http://tracker.ceph.com/issues/39580),
    [pr#29061](https://github.com/ceph/ceph/pull/29061), Ricardo
    Marques, Kefu Chai)
-   mgr/dashboard: Pool graph/sparkline points do not display the
    correct values ([issue#39650](http://tracker.ceph.com/issues/39650),
    [pr#29352](https://github.com/ceph/ceph/pull/29352), Stephan Müller)
-   mgr/dashboard: RGW User quota validation is not working correctly
    ([pr#29650](https://github.com/ceph/ceph/pull/29650), Volker Theile)
-   mgr/dashboard: Silence Alertmanager alerts
    ([issue#36722](http://tracker.ceph.com/issues/36722),
    [pr#28968](https://github.com/ceph/ceph/pull/28968), Stephan Müller)
-   mgr/dashboard: SSL certificate upload command throws deprecation
    warning ([issue#39123](http://tracker.ceph.com/issues/39123),
    [pr#29065](https://github.com/ceph/ceph/pull/29065), Ricardo Dias)
-   mgr/dashboard: switch ng2-toastr to ngx-toastr
    ([pr#29050](https://github.com/ceph/ceph/pull/29050), Tiago Melo,
    Ernesto Puerta)
-   mgr/dashboard: Upgrade to ceph-iscsi config v10
    ([issue#40566](http://tracker.ceph.com/issues/40566),
    [pr#28974](https://github.com/ceph/ceph/pull/28974), Ricardo
    Marques)
-   mgr/diskprediction_cloud: Service unavailable
    ([issue#40478](http://tracker.ceph.com/issues/40478),
    [pr#29454](https://github.com/ceph/ceph/pull/29454), Rick Chen)
-   mgr/influx: module fails due to missing close() method
    ([issue#40174](http://tracker.ceph.com/issues/40174),
    [pr#29207](https://github.com/ceph/ceph/pull/29207), Kefu Chai)
-   mgr/orchestrator: Cache and DeepSea iSCSI + NFS
    ([pr#29060](https://github.com/ceph/ceph/pull/29060), Sebastian
    Wagner, Tim Serong)
-   mgr/rbd_support: support scheduling long-running background
    operations ([issue#40621](http://tracker.ceph.com/issues/40621),
    [issue#40790](http://tracker.ceph.com/issues/40790),
    [pr#29725](https://github.com/ceph/ceph/pull/29725), Venky Shankar,
    Jason Dillaman)
-   mgr: use ipv4 default when ipv6 was disabled
    ([issue#40023](http://tracker.ceph.com/issues/40023),
    [pr#29194](https://github.com/ceph/ceph/pull/29194), kungf)
-   mgr/volumes: background purge queue for subvolumes
    ([issue#40036](http://tracker.ceph.com/issues/40036),
    [pr#29079](https://github.com/ceph/ceph/pull/29079), Patrick
    Donnelly, Venky Shankar, Kefu Chai)
-   mgr/volumes: minor enhancement and bug fix
    ([issue#40927](http://tracker.ceph.com/issues/40927),
    [issue#40617](http://tracker.ceph.com/issues/40617),
    [pr#29490](https://github.com/ceph/ceph/pull/29490), Ramana Raja)
-   mon: auth mon isn\'t loading full KeyServerData after restart
    ([issue#40634](http://tracker.ceph.com/issues/40634),
    [pr#28993](https://github.com/ceph/ceph/pull/28993), Sage Weil)
-   mon/MgrMonitor: fix null deref when invalid formatter is specified
    ([pr#29566](https://github.com/ceph/ceph/pull/29566), Sage Weil)
-   mon/OSDMonitor: allow pg_num to increase when require_osd_release \<
    N ([issue#39570](http://tracker.ceph.com/issues/39570),
    [pr#29671](https://github.com/ceph/ceph/pull/29671), Neha Ojha, Sage
    Weil)
-   mon/OSDMonitor.cc: better error message about min_size
    ([pr#29617](https://github.com/ceph/ceph/pull/29617), Neha Ojha)
-   mon: paxos: introduce new reset_pending_committing_finishers for
    safety ([issue#39484](http://tracker.ceph.com/issues/39484),
    [pr#28528](https://github.com/ceph/ceph/pull/28528), Greg Farnum)
-   mon: set recovery priority etc on cephfs metadata pool
    ([pr#29275](https://github.com/ceph/ceph/pull/29275), Sage Weil)
-   mon: take the mon lock in handle_conf_change
    ([issue#39625](http://tracker.ceph.com/issues/39625),
    [pr#29373](https://github.com/ceph/ceph/pull/29373), huangjun)
-   msg/async: avoid unnecessary costly wakeups for outbound messages
    ([pr#29141](https://github.com/ceph/ceph/pull/29141), Jason
    Dillaman)
-   msg/async: enable secure mode by default, no longer experimental
    ([pr#29143](https://github.com/ceph/ceph/pull/29143), Sage Weil)
-   msg/async: no-need set connection for Message
    ([pr#29142](https://github.com/ceph/ceph/pull/29142), Jianpeng Ma)
-   msg/async, v2: make the reset_recv_state() unconditional
    ([issue#40115](http://tracker.ceph.com/issues/40115),
    [pr#29140](https://github.com/ceph/ceph/pull/29140), Radoslaw
    Zarzynski, Sage Weil)
-   nautilus:common/options.cc: Lower the default value of
    osd_deep_scrub_large_omap_object_key_threshold
    ([pr#29173](https://github.com/ceph/ceph/pull/29173), Neha Ojha)
-   osd: Don\'t randomize deep scrubs when noscrub set
    ([issue#40198](http://tracker.ceph.com/issues/40198),
    [pr#28768](https://github.com/ceph/ceph/pull/28768), David Zafman)
-   osd: Fix the way that auto repair triggers after regular scrub
    ([issue#40530](http://tracker.ceph.com/issues/40530),
    [issue#40073](http://tracker.ceph.com/issues/40073),
    [pr#28869](https://github.com/ceph/ceph/pull/28869),
    <sjust@redhat.com>, David Zafman)
-   osd/OSD: auto mark heartbeat sessions as stale and tear them down
    ([issue#40586](http://tracker.ceph.com/issues/40586),
    [pr#29391](https://github.com/ceph/ceph/pull/29391), xie xingguo)
-   osd/OSD: keep synchronizing with mon if stuck at booting
    ([pr#28639](https://github.com/ceph/ceph/pull/28639), xie xingguo)
-   osd/PG: do not queue scrub if PG is not active when unblock
    ([issue#40451](http://tracker.ceph.com/issues/40451),
    [pr#29372](https://github.com/ceph/ceph/pull/29372), Sage Weil)
-   osd/PG: fix cleanup of pgmeta-like objects on PG deletion
    ([pr#29115](https://github.com/ceph/ceph/pull/29115), Sage Weil)
-   pybind/mgr/rbd_support: ignore missing support for RBD namespaces
    ([issue#41475](https://tracker.ceph.com/issues/41475),
    [pr#29945](https://github.com/ceph/ceph/pull/29945), Mykola Golub)
-   rbd/action: fix error getting positional argument
    ([issue#40095](http://tracker.ceph.com/issues/40095),
    [pr#28870](https://github.com/ceph/ceph/pull/28870), songweibin)
-   rbd: \[cli\] \'export\' should handle concurrent IO completions
    ([issue#40435](http://tracker.ceph.com/issues/40435),
    [pr#29329](https://github.com/ceph/ceph/pull/29329), Jason Dillaman)
-   rbd: librbd: do not unblock IO prior to growing object map during
    resize ([issue#39952](http://tracker.ceph.com/issues/39952),
    [pr#29246](https://github.com/ceph/ceph/pull/29246), Jason Dillaman)
-   rbd-mirror: handle duplicates in image sync throttler queue
    ([issue#40519](http://tracker.ceph.com/issues/40519),
    [pr#28817](https://github.com/ceph/ceph/pull/28817), Mykola Golub)
-   rbd-mirror: link against the specified alloc library
    ([issue#40110](http://tracker.ceph.com/issues/40110),
    [pr#29193](https://github.com/ceph/ceph/pull/29193), Jason Dillaman)
-   rbd-nbd: sscanf return 0 mean not-match
    ([issue#39269](http://tracker.ceph.com/issues/39269),
    [pr#29315](https://github.com/ceph/ceph/pull/29315), Jianpeng Ma)
-   rbd: profile rbd OSD cap should add class rbd metadata_list cap by
    default ([issue#39973](http://tracker.ceph.com/issues/39973),
    [pr#29328](https://github.com/ceph/ceph/pull/29328), songweibin)
-   rbd: Reduce log level for cls/journal and cls/rbd expected errors
    ([issue#40865](http://tracker.ceph.com/issues/40865),
    [pr#29551](https://github.com/ceph/ceph/pull/29551), Jason Dillaman)
-   rbd: tests: add \"rbd diff\" coverage to suite
    ([issue#39447](http://tracker.ceph.com/issues/39447),
    [pr#28575](https://github.com/ceph/ceph/pull/28575), Shyukri
    Shyukriev, Nathan Cutler)
-   rgw: add \'GET /admin/realm?list\' api to list realms
    ([issue#39626](http://tracker.ceph.com/issues/39626),
    [pr#28751](https://github.com/ceph/ceph/pull/28751), Casey Bodley)
-   rgw: allow radosgw-admin to list bucket w \--allow-unordered
    ([issue#39637](http://tracker.ceph.com/issues/39637),
    [pr#28230](https://github.com/ceph/ceph/pull/28230), J. Eric
    Ivancich)
-   rgw: conditionally allow builtin users with non-unique email
    addresses ([issue#40089](http://tracker.ceph.com/issues/40089),
    [pr#28715](https://github.com/ceph/ceph/pull/28715), Matt Benjamin)
-   rgw: deleting bucket can fail when it contains unfinished multipart
    uploads ([issue#40526](http://tracker.ceph.com/issues/40526),
    [pr#29154](https://github.com/ceph/ceph/pull/29154), J. Eric
    Ivancich)
-   rgw: Don\'t crash on copy when metadata directive not supplied
    ([issue#40416](http://tracker.ceph.com/issues/40416),
    [pr#29499](https://github.com/ceph/ceph/pull/29499), Adam C.
    Emerson)
-   rgw_file: advance_mtime() should consider namespace expiration
    ([issue#40415](http://tracker.ceph.com/issues/40415),
    [pr#29410](https://github.com/ceph/ceph/pull/29410), Matt Benjamin)
-   rgw_file: advance_mtime() takes RGWFileHandle::mutex unconditionally
    ([pr#29801](https://github.com/ceph/ceph/pull/29801), Matt Benjamin)
-   rgw_file: all directories are virtual with respect to contents
    ([issue#40204](http://tracker.ceph.com/issues/40204),
    [pr#28886](https://github.com/ceph/ceph/pull/28886), Matt Benjamin)
-   rgw_file: fix invalidation of top-level directories
    ([issue#40196](http://tracker.ceph.com/issues/40196),
    [pr#29309](https://github.com/ceph/ceph/pull/29309), Matt Benjamin)
-   rgw_file: fix readdir eof() calc\--caller stop implies !eof
    ([issue#40375](http://tracker.ceph.com/issues/40375),
    [pr#29409](https://github.com/ceph/ceph/pull/29409), Matt Benjamin)
-   rgw_file: include tenant when hashing bucket names
    ([issue#40118](http://tracker.ceph.com/issues/40118),
    [pr#28854](https://github.com/ceph/ceph/pull/28854), Matt Benjamin)
-   rgw: fix miss get ret in STSService::storeARN
    ([issue#40386](http://tracker.ceph.com/issues/40386),
    [pr#28713](https://github.com/ceph/ceph/pull/28713), Tianshan Qu)
-   rgw: fix prefix handling in LCFilter
    ([issue#37879](http://tracker.ceph.com/issues/37879),
    [pr#28550](https://github.com/ceph/ceph/pull/28550), Matt Benjamin)
-   rgw: fix rgw crash and set correct error code
    ([pr#28729](https://github.com/ceph/ceph/pull/28729), yuliyang)
-   rgw: hadoop-s3a suite failing with more ansible errors
    ([issue#39706](http://tracker.ceph.com/issues/39706),
    [pr#28735](https://github.com/ceph/ceph/pull/28735), Casey Bodley)
-   rgw: hadoop-s3a suite failing with more ansible errors
    ([issue#39706](http://tracker.ceph.com/issues/39706),
    [pr#29265](https://github.com/ceph/ceph/pull/29265), Casey Bodley)
-   rgw: Librgw doesn\'t GC deleted object correctly
    ([issue#37734](http://tracker.ceph.com/issues/37734),
    [pr#28648](https://github.com/ceph/ceph/pull/28648), Tao Chen, Matt
    Benjamin)
-   rgw: multisite: DELETE Bucket CORS is not forwarded to master zone
    ([issue#39629](http://tracker.ceph.com/issues/39629),
    [pr#28714](https://github.com/ceph/ceph/pull/28714), Chang Liu)
-   rgw: multisite: fix \--bypass-gc flag for \'radosgw-admin bucket
    rm\' ([issue#24991](http://tracker.ceph.com/issues/24991),
    [pr#28549](https://github.com/ceph/ceph/pull/28549), Casey Bodley)
-   rgw: multisite: \'radosgw-admin bilog trim\' stops after 1000
    entries ([issue#40187](http://tracker.ceph.com/issues/40187),
    [pr#29326](https://github.com/ceph/ceph/pull/29326), Casey Bodley)
-   rgw: multisite: \'radosgw-admin bucket sync status\' should call
    syncs_from(source.name) instead of id
    ([issue#40022](http://tracker.ceph.com/issues/40022),
    [pr#28739](https://github.com/ceph/ceph/pull/28739), Casey Bodley)
-   rgw: multisite: radosgw-admin commands should not modify metadata on
    a non-master zone
    ([issue#39548](http://tracker.ceph.com/issues/39548),
    [pr#29163](https://github.com/ceph/ceph/pull/29163), Shilpa
    Jagannath)
-   rgw: multisite: RGWListBucketIndexesCR for data full sync needs
    pagination ([issue#39551](http://tracker.ceph.com/issues/39551),
    [pr#29311](https://github.com/ceph/ceph/pull/29311), Shilpa
    Jagannath)
-   rgw/OutputDataSocket: append_output(buffer::list&) says it will (but
    does not) discard output at data_max_backlog
    ([issue#40178](http://tracker.ceph.com/issues/40178),
    [pr#29310](https://github.com/ceph/ceph/pull/29310), Matt Benjamin)
-   rgw, Policy should be url_decode when assume_role
    ([pr#28728](https://github.com/ceph/ceph/pull/28728), yuliyang)
-   rgw: provide admin-friendly reshard status output
    ([issue#37615](http://tracker.ceph.com/issues/37615),
    [pr#29286](https://github.com/ceph/ceph/pull/29286), Mark Kogan)
-   rgw: Put LC doesn\'t clear existing lifecycle
    ([issue#39654](http://tracker.ceph.com/issues/39654),
    [pr#29313](https://github.com/ceph/ceph/pull/29313), Abhishek
    Lekshmanan)
-   rgw: remove rgw_num_rados_handles; set autoscale parameters or rgw
    metadata pools ([pr#27684](https://github.com/ceph/ceph/pull/27684),
    Adam C. Emerson, Casey Bodley, Sage Weil)
-   rgw: RGWGC add perfcounter retire counter
    ([issue#38251](http://tracker.ceph.com/issues/38251),
    [pr#29308](https://github.com/ceph/ceph/pull/29308), Matt Benjamin)
-   rgw: Save an unnecessary copy of RGWEnv
    ([issue#40183](http://tracker.ceph.com/issues/40183),
    [pr#29205](https://github.com/ceph/ceph/pull/29205), Mark Kogan)
-   rgw: set null version object issues
    ([issue#36763](http://tracker.ceph.com/issues/36763),
    [pr#29287](https://github.com/ceph/ceph/pull/29287), Tianshan Qu)
-   rgw: Swift interface: server side copy fails if object name contains
    \"?\" ([issue#27217](http://tracker.ceph.com/issues/27217),
    [pr#28736](https://github.com/ceph/ceph/pull/28736), Casey Bodley)
-   rgw: TempURL should not allow PUTs with the X-Object-Manifest
    ([issue#20797](http://tracker.ceph.com/issues/20797),
    [pr#28712](https://github.com/ceph/ceph/pull/28712), Radoslaw
    Zarzynski)
-   rgw: the Multi-Object Delete operation of S3 API wrongly handles the
    Code response element
    ([issue#18241](http://tracker.ceph.com/issues/18241),
    [pr#28737](https://github.com/ceph/ceph/pull/28737), Radoslaw
    Zarzynski)
-   rocksdb: rocksdb_rmrange related improvements
    ([pr#29439](https://github.com/ceph/ceph/pull/29439), Zengran Zhang,
    Sage Weil)
-   rocksdb: Updated to v6.1.2
    ([pr#29440](https://github.com/ceph/ceph/pull/29440), Mark Nelson)
-   tools: ceph-kvstore-tool: print db stats
    ([pr#28810](https://github.com/ceph/ceph/pull/28810), Igor Fedotov)

## v14.2.2 Nautilus

This is the second bug fix release of Ceph Nautilus release series. We
recommend all Nautilus users upgrade to this release. For upgrading from
older releases of ceph, general guidelines for upgrade to nautilus must
be followed `nautilus-old-upgrade`{.interpreted-text role="ref"}.

### Notable Changes

-   The no{up,down,in,out} related commands have been revamped. There
    are now 2 ways to set the no{up,down,in,out} flags: the old \'ceph
    osd \[un\]set \<flag\>\' command, which sets cluster-wide flags; and
    the new \'ceph osd \[un\]set-group \<flags\> \<who\>\' command,
    which sets flags in batch at the granularity of any crush node, or
    device class.

-   radosgw-admin introduces two subcommands that allow the managing of
    expire-stale objects that might be left behind after a bucket
    reshard in earlier versions of RGW. One subcommand lists such
    objects and the other deletes them. Read the troubleshooting section
    of the dynamic resharding docs for details.

-   Earlier Nautilus releases (14.2.1 and 14.2.0) have an issue where
    deploying a single new (Nautilus) BlueStore OSD on an upgraded
    cluster (i.e. one that was originally deployed pre-Nautilus) breaks
    the pool utilization stats reported by `ceph df`. Until all OSDs
    have been reprovisioned or updated (via
    `ceph-bluestore-tool repair`), the pool stats will show values that
    are lower than the true value. This is resolved in 14.2.2, such that
    the cluster only switches to using the more accurate per-pool stats
    after *all* OSDs are 14.2.2 (or later), are BlueStore, and (if they
    were created prior to Nautilus) have been updated via the `repair`
    function.

-   The default value for [mon_crush_min_required_version]{.title-ref}
    has been changed from [firefly]{.title-ref} to [hammer]{.title-ref},
    which means the cluster will issue a health warning if your CRUSH
    tunables are older than hammer. There is generally a small (but
    non-zero) amount of data that will move around by making the switch
    to hammer tunables; for more information, see
    `crush-map-tunables`{.interpreted-text role="ref"}.

    If possible, we recommend that you set the oldest allowed client to
    [hammer]{.title-ref} or later. You can tell what the current oldest
    allowed client is with:

        ceph osd dump | grep min_compat_client

    If the current value is older than hammer, you can tell whether it
    is safe to make this change by verifying that there are no clients
    older than hammer current connected to the cluster with:

        ceph features

    The newer [straw2]{.title-ref} CRUSH bucket type was introduced in
    hammer, and ensuring that all clients are hammer or newer allows new
    features only supported for [straw2]{.title-ref} buckets to be used,
    including the [crush-compat]{.title-ref} mode for the
    `balancer`{.interpreted-text role="ref"}.

### Changelog

-   bluestore: backport more bluestore alerts
    ([pr#27645](https://github.com/ceph/ceph/pull/27645), Sage Weil,
    Igor Fedotov)
-   bluestore: call fault_range prior to looking for blob to reuse
    ([pr#27525](https://github.com/ceph/ceph/pull/27525), Igor Fedotov)
-   bluestore: correctly measure deferred writes into new blobs
    ([issue#38816](http://tracker.ceph.com/issues/38816),
    [pr#27819](https://github.com/ceph/ceph/pull/27819), Sage Weil)
-   bluestore: dump before \"no-spanning blob id\" abort
    ([pr#28028](https://github.com/ceph/ceph/pull/28028), Igor Fedotov)
-   bluestore: fix for FreeBSD iocb structure
    ([issue#39612](http://tracker.ceph.com/issues/39612),
    [pr#28007](https://github.com/ceph/ceph/pull/28007), Willem Jan
    Withagen)
-   bluestore: fix missing discard in BlueStore::\_kv_sync_thread
    ([issue#39672](http://tracker.ceph.com/issues/39672),
    [pr#28258](https://github.com/ceph/ceph/pull/28258), Junhui Tang)
-   bluestore: fix out-of-bound access in bmap allocator
    ([pr#27740](https://github.com/ceph/ceph/pull/27740), Igor Fedotov)
-   bluestore: fix duplicate allocations in bmap allocator
    ([issue#40080](http://tracker.ceph.com/issues/40080),
    [pr#28646](https://github.com/ceph/ceph/pull/28646), Igor Fedotov)
-   build/ops: Ceph RPM build fails on openSUSE Tumbleweed with GCC 9
    ([issue#40067](http://tracker.ceph.com/issues/40067),
    [issue#39974](http://tracker.ceph.com/issues/39974),
    [pr#28299](https://github.com/ceph/ceph/pull/28299), Martin Liška)
-   build/ops: cmake: Fix build against ncurses with separate libtinfo
    ([pr#27532](https://github.com/ceph/ceph/pull/27532), Lars Wendler)
-   build/ops: cmake: set empty-string RPATH for ceph-osd
    ([issue#40301](http://tracker.ceph.com/issues/40301),
    [issue#40295](http://tracker.ceph.com/issues/40295),
    [pr#28516](https://github.com/ceph/ceph/pull/28516), Nathan Cutler)
-   build/ops: do_cmake.sh: source not found
    ([issue#39981](http://tracker.ceph.com/issues/39981),
    [issue#40003](http://tracker.ceph.com/issues/40003),
    [pr#28215](https://github.com/ceph/ceph/pull/28215), Nathan Cutler)
-   build/ops: python3 pybind RPMs do not replace their python2
    counterparts on upgrade even though they should
    ([issue#40099](http://tracker.ceph.com/issues/40099),
    [issue#40232](http://tracker.ceph.com/issues/40232),
    [pr#28469](https://github.com/ceph/ceph/pull/28469), Nathan Cutler)
-   build/ops: rpm: install grafana dashboards world readable
    ([pr#28392](https://github.com/ceph/ceph/pull/28392), Jan Fajerski)
-   build/ops: selinux: Update the policy for RHEL8
    ([pr#28511](https://github.com/ceph/ceph/pull/28511), Boris Ranto)
-   ceph-volume: add utility functions
    ([pr#27791](https://github.com/ceph/ceph/pull/27791), Mohamad Gebai)
-   ceph-volume: broken assertion errors after pytest changes
    ([pr#28925](https://github.com/ceph/ceph/pull/28925), Alfredo Deza)
-   ceph-volume: look for rotational data in lsblk
    ([pr#27723](https://github.com/ceph/ceph/pull/27723), Andrew Schoen)
-   ceph-volume: tests add a sleep in tox for slow OSDs after booting
    ([pr#28924](https://github.com/ceph/ceph/pull/28924), Alfredo Deza)
-   ceph-volume: use the Device.rotational property instead of sys_api
    ([pr#29028](https://github.com/ceph/ceph/pull/29028), Andrew Schoen)
-   cephfs-shell: Revert \"cephfs.pyx: add py3 compatibility
    ([pr#28641](https://github.com/ceph/ceph/pull/28641), Varsha Rao)
-   cephfs-shell: ls command produces error: no colorize attribute found
    error ([issue#39376](http://tracker.ceph.com/issues/39376),
    [issue#39378](http://tracker.ceph.com/issues/39378),
    [issue#38740](http://tracker.ceph.com/issues/38740),
    [issue#39379](http://tracker.ceph.com/issues/39379),
    [issue#39197](http://tracker.ceph.com/issues/39197),
    [issue#39377](http://tracker.ceph.com/issues/39377),
    [pr#27677](https://github.com/ceph/ceph/pull/27677), Milind
    Changire, Varsha Rao)
-   cephfs-shell: misc. cephfs-shell backports
    ([issue#40314](http://tracker.ceph.com/issues/40314),
    [issue#40471](http://tracker.ceph.com/issues/40471),
    [issue#40418](http://tracker.ceph.com/issues/40418),
    [issue#40469](http://tracker.ceph.com/issues/40469),
    [issue#40313](http://tracker.ceph.com/issues/40313),
    [issue#39937](http://tracker.ceph.com/issues/39937),
    [issue#39678](http://tracker.ceph.com/issues/39678),
    [issue#40244](http://tracker.ceph.com/issues/40244),
    [issue#39404](http://tracker.ceph.com/issues/39404),
    [issue#40243](http://tracker.ceph.com/issues/40243),
    [issue#39165](http://tracker.ceph.com/issues/39165),
    [issue#40470](http://tracker.ceph.com/issues/40470),
    [issue#40455](http://tracker.ceph.com/issues/40455),
    [issue#39936](http://tracker.ceph.com/issues/39936),
    [issue#40217](http://tracker.ceph.com/issues/40217),
    [pr#28681](https://github.com/ceph/ceph/pull/28681), Patrick
    Donnelly, Varsha Rao, Milind Changire)
-   cephfs-shell: mkdir error for relative path
    ([issue#39960](http://tracker.ceph.com/issues/39960),
    [pr#28616](https://github.com/ceph/ceph/pull/28616), Varsha Rao)
-   cephfs: FSAL_CEPH assertion failed in Client::\_lookup_name:
    \"parent-\>is_dir()
    ([issue#40085](http://tracker.ceph.com/issues/40085),
    [issue#40161](http://tracker.ceph.com/issues/40161),
    [pr#28612](https://github.com/ceph/ceph/pull/28612), Jeff Layton)
-   cephfs: ceph_volume_client: Too many arguments for \"WriteOpCtx
    ([issue#39050](http://tracker.ceph.com/issues/39050),
    [issue#38946](http://tracker.ceph.com/issues/38946),
    [pr#27893](https://github.com/ceph/ceph/pull/27893), Ramana Raja)
-   cephfs: client: ceph.dir.rctime xattr value incorrectly prefixes 09
    to the nanoseconds component
    ([issue#40167](http://tracker.ceph.com/issues/40167),
    [pr#28500](https://github.com/ceph/ceph/pull/28500), David
    Disseldorp)
-   cephfs: client: fix \"ceph.snap.btime\" vxattr value
    ([issue#40169](http://tracker.ceph.com/issues/40169),
    [pr#28499](https://github.com/ceph/ceph/pull/28499), David
    Disseldorp)
-   cephfs: client: fix fuse client hang because its bad session
    PipeConnection ([issue#39686](http://tracker.ceph.com/issues/39686),
    [issue#39305](http://tracker.ceph.com/issues/39305),
    [pr#28375](https://github.com/ceph/ceph/pull/28375), Guan yunfei)
-   cephfs: kclient: nofail option not supported
    ([issue#39232](http://tracker.ceph.com/issues/39232),
    [pr#27851](https://github.com/ceph/ceph/pull/27851), Kenneth
    Waegeman)
-   cephfs: mds: Expose CephFS snapshot creation time to clients
    ([issue#39471](http://tracker.ceph.com/issues/39471),
    [pr#27901](https://github.com/ceph/ceph/pull/27901), David
    Disseldorp)
-   cephfs: mds: MDSTableServer.cc: 83: FAILED assert(version == tid)
    ([issue#39211](http://tracker.ceph.com/issues/39211),
    [issue#38835](http://tracker.ceph.com/issues/38835),
    [pr#27853](https://github.com/ceph/ceph/pull/27853), \"Yan, Zheng\")
-   cephfs: mds: avoid sending too many osd requests at once after mds
    restarts ([issue#40028](http://tracker.ceph.com/issues/40028),
    [issue#40040](http://tracker.ceph.com/issues/40040),
    [pr#28582](https://github.com/ceph/ceph/pull/28582), simon gao)
-   cephfs: mds: behind on trimming and \"\[dentry\] was purgeable but
    no longer is! ([issue#39222](http://tracker.ceph.com/issues/39222),
    [issue#38679](http://tracker.ceph.com/issues/38679),
    [pr#27879](https://github.com/ceph/ceph/pull/27879), \"Yan, Zheng\")
-   cephfs: mds: better output of \'ceph health detail
    ([issue#39266](http://tracker.ceph.com/issues/39266),
    [pr#27846](https://github.com/ceph/ceph/pull/27846), Shen Hang\')
-   cephfs: mds: check dir fragment to split dir if mkdir makes it
    oversized ([issue#39690](http://tracker.ceph.com/issues/39690),
    [pr#28394](https://github.com/ceph/ceph/pull/28394), Erqi Chen)
-   cephfs: mds: check directory split after rename
    ([issue#39199](http://tracker.ceph.com/issues/39199),
    [issue#38994](http://tracker.ceph.com/issues/38994),
    [pr#27736](https://github.com/ceph/ceph/pull/27736), Shen Hang)
-   cephfs: mds: drop reconnect message from non-existent session
    ([issue#39026](http://tracker.ceph.com/issues/39026),
    [issue#39192](http://tracker.ceph.com/issues/39192),
    [pr#27714](https://github.com/ceph/ceph/pull/27714), Shen Hang)
-   cephfs: mds: fail to resolve snapshot name contains \'\_\'
    ([issue#39473](http://tracker.ceph.com/issues/39473),
    [pr#27849](https://github.com/ceph/ceph/pull/27849), \"Yan, Zheng\')
-   cephfs: mds: fix \'is session in blacklist\' check in
    Server::apply_blacklist()
    ([issue#40236](http://tracker.ceph.com/issues/40236),
    [issue#40061](http://tracker.ceph.com/issues/40061),
    [pr#28618](https://github.com/ceph/ceph/pull/28618), \"Yan, Zheng\')
-   cephfs: mds: fix corner case of replaying open sessions
    ([pr#28580](https://github.com/ceph/ceph/pull/28580), \"Yan,
    Zheng\")
-   cephfs: mds: high debug logging with many subtrees is slow
    ([issue#38876](http://tracker.ceph.com/issues/38876),
    [pr#27892](https://github.com/ceph/ceph/pull/27892), Rishabh Dave)
-   cephfs: mds: initialize cap_revoke_eviction_timeout with conf
    ([issue#39209](http://tracker.ceph.com/issues/39209),
    [issue#38844](http://tracker.ceph.com/issues/38844),
    [pr#27842](https://github.com/ceph/ceph/pull/27842), simon gao)
-   cephfs: mds: output lock state in format dump
    ([issue#39645](http://tracker.ceph.com/issues/39645),
    [issue#39670](http://tracker.ceph.com/issues/39670),
    [pr#28233](https://github.com/ceph/ceph/pull/28233), Zhi Zhang)
-   cephfs: mds: reset heartbeat during long-running loops in recovery
    ([issue#40223](http://tracker.ceph.com/issues/40223),
    [pr#28611](https://github.com/ceph/ceph/pull/28611), \"Yan, Zheng\")
-   cephfs: mds: there is an assertion when calling Beacon::shutdown()
    ([issue#39214](http://tracker.ceph.com/issues/39214),
    [issue#38822](http://tracker.ceph.com/issues/38822),
    [pr#27852](https://github.com/ceph/ceph/pull/27852), huanwen ren)
-   cephfs: mount: key parsing fail when doing a remount
    ([issue#40164](http://tracker.ceph.com/issues/40164),
    [pr#28610](https://github.com/ceph/ceph/pull/28610), Luis Henriques)
-   cephfs: pybind: added lseek()
    ([pr#28333](https://github.com/ceph/ceph/pull/28333), Xiaowei Chu)
-   common/assert: include ceph_abort_msg(arg) arg in log output
    ([pr#27824](https://github.com/ceph/ceph/pull/27824), Sage Weil)
-   common/options: annotate some options; enable some runtime updates
    ([pr#27818](https://github.com/ceph/ceph/pull/27818), Sage Weil)
-   common/options: update mon_crush_min_required_version=hammer
    ([pr#27625](https://github.com/ceph/ceph/pull/27625), Sage Weil)
-   common/util: handle long lines in /proc/cpuinfo
    ([issue#38296](http://tracker.ceph.com/issues/38296),
    [issue#39476](http://tracker.ceph.com/issues/39476),
    [pr#28141](https://github.com/ceph/ceph/pull/28141), Sage Weil)
-   common: Clang requires a default constructor, but it can be empty
    ([issue#39561](http://tracker.ceph.com/issues/39561),
    [issue#39573](http://tracker.ceph.com/issues/39573),
    [pr#28131](https://github.com/ceph/ceph/pull/28131), Willem Jan
    Withagen)
-   common: fix parse_env nullptr deref
    ([pr#28382](https://github.com/ceph/ceph/pull/28382), Patrick
    Donnelly)
-   common: make cluster_network work
    ([issue#39671](http://tracker.ceph.com/issues/39671),
    [pr#28248](https://github.com/ceph/ceph/pull/28248), Jianpeng Ma)
-   common: parse ISO 8601 datetime format
    ([issue#40087](http://tracker.ceph.com/issues/40087),
    [pr#28325](https://github.com/ceph/ceph/pull/28325), Sage Weil)
-   core: Give recovery for inactive PGs a higher priority
    ([issue#39504](http://tracker.ceph.com/issues/39504),
    [issue#38195](http://tracker.ceph.com/issues/38195),
    [pr#27854](https://github.com/ceph/ceph/pull/27854), David Zafman)
-   core: mon,osd: add no{out,down,in,out} flags on CRUSH nodes
    ([pr#27623](https://github.com/ceph/ceph/pull/27623), xie xingguo,
    Sage Weil)
-   core: mon/Elector: format mon_release correctly
    ([issue#39419](http://tracker.ceph.com/issues/39419),
    [pr#27771](https://github.com/ceph/ceph/pull/27771), Sage Weil)
-   core: mon/Monitor: allow probe if MMonProbe::mon_release == 0
    ([issue#38850](http://tracker.ceph.com/issues/38850),
    [pr#28262](https://github.com/ceph/ceph/pull/28262), Sage Weil)
-   core: mon: fix off-by-one rendering progress bar
    ([pr#28398](https://github.com/ceph/ceph/pull/28398), Sage Weil)
-   core: mon: use per-pool stats only when all OSDs are reporting
    ([pr#29032](https://github.com/ceph/ceph/pull/29032), Sage Weil)
-   core: monitoring: Provide a base set of Prometheus alert manager
    rules that notify the user about common Ceph error conditions
    ([issue#39540](http://tracker.ceph.com/issues/39540),
    [pr#27998](https://github.com/ceph/ceph/pull/27998), Jan Fajerski)
-   core: monitoring: update Grafana dashboards
    ([issue#39652](http://tracker.ceph.com/issues/39652),
    [issue#40006](http://tracker.ceph.com/issues/40006),
    [issue#39971](http://tracker.ceph.com/issues/39971),
    [issue#39932](http://tracker.ceph.com/issues/39932),
    [pr#28101](https://github.com/ceph/ceph/pull/28101), Kiefer Chang,
    Jan Fajerski)
-   core: osd/OSD.cc: make osd bench description consistent with
    parameters ([issue#39006](http://tracker.ceph.com/issues/39006),
    [issue#39375](http://tracker.ceph.com/issues/39375),
    [pr#28035](https://github.com/ceph/ceph/pull/28035), Neha Ojha)
-   core: osd/OSDMap: Replace get_out_osds with get_out_existing_osds
    ([issue#39421](http://tracker.ceph.com/issues/39421),
    [issue#39154](http://tracker.ceph.com/issues/39154),
    [pr#28072](https://github.com/ceph/ceph/pull/28072), Brad Hubbard)
-   core: osd/PG: discover missing objects when an OSD peers and PG is
    degraded ([pr#27744](https://github.com/ceph/ceph/pull/27744), Jonas
    Jelten)
-   core: osd/PG: do not use approx_missing_objects pre-nautilus
    ([issue#39512](http://tracker.ceph.com/issues/39512),
    [pr#28160](https://github.com/ceph/ceph/pull/28160), Neha Ojha)
-   core: osd/PG: fix last_complete re-calculation on splitting
    ([issue#39539](http://tracker.ceph.com/issues/39539),
    [issue#26958](http://tracker.ceph.com/issues/26958),
    [pr#28219](https://github.com/ceph/ceph/pull/28219), xie xingguo)
-   core: osd/PG: skip rollforward when !transaction_applied during
    append_log() ([issue#36739](http://tracker.ceph.com/issues/36739),
    [issue#38881](http://tracker.ceph.com/issues/38881),
    [pr#27654](https://github.com/ceph/ceph/pull/27654), Neha Ojha)
-   core: osd/PGLog: preserve original_crt to check rollbackability
    ([issue#36739](http://tracker.ceph.com/issues/36739),
    [issue#39043](http://tracker.ceph.com/issues/39043),
    [pr#27632](https://github.com/ceph/ceph/pull/27632), Neha Ojha)
-   core: osd: Don\'t evict after a flush if intersecting scrub range
    ([issue#38840](http://tracker.ceph.com/issues/38840),
    [issue#39519](http://tracker.ceph.com/issues/39519),
    [pr#28205](https://github.com/ceph/ceph/pull/28205), David Zafman\')
-   core: osd: Don\'t include user changeable flag in snaptrim related
    assert ([issue#39699](http://tracker.ceph.com/issues/39699),
    [issue#38124](http://tracker.ceph.com/issues/38124),
    [pr#28203](https://github.com/ceph/ceph/pull/28203), David Zafman\')
-   core: osd: FAILED ceph_assert(attrs \|\|
    !pg_log.get_missing().is_missing(soid) \|\| (it_objects !=
    pg_log.get_log().objects.end() && it_objects-\>second-\>op ==
    pg_log_entry_t::LOST_REVERT)) in PrimaryLogPG::get_object_context()
    ([issue#38931](http://tracker.ceph.com/issues/38931),
    [issue#39219](http://tracker.ceph.com/issues/39219),
    [issue#38784](http://tracker.ceph.com/issues/38784),
    [pr#27839](https://github.com/ceph/ceph/pull/27839), xie xingguo)
-   core: osd: Include dups in copy_after() and copy_up_to()
    ([issue#39304](http://tracker.ceph.com/issues/39304),
    [pr#28088](https://github.com/ceph/ceph/pull/28088), David Zafman)
-   core: osd: Increase log level of messages which unnecessarily fill
    up logs ([pr#27687](https://github.com/ceph/ceph/pull/27687), David
    Zafman)
-   core: osd: Output Base64 encoding of CRC header if binary data
    present ([issue#39738](http://tracker.ceph.com/issues/39738),
    [pr#28504](https://github.com/ceph/ceph/pull/28504), David Zafman)
-   core: osd: Primary won\'t automatically repair replica on pulling
    error ([issue#39101](http://tracker.ceph.com/issues/39101),
    [issue#39184](http://tracker.ceph.com/issues/39184),
    [pr#27711](https://github.com/ceph/ceph/pull/27711), xie xingguo,
    David Zafman\')
-   core: osd: revamp {noup,nodown,noin,noout} related commands
    ([pr#28400](https://github.com/ceph/ceph/pull/28400), xie xingguo)
-   core: osd: shutdown recovery_request_timer earlier
    ([issue#39205](http://tracker.ceph.com/issues/39205),
    [pr#27803](https://github.com/ceph/ceph/pull/27803), Zengran Zhang)
-   core: osd: take heartbeat_lock when calling heartbeat()
    ([issue#39514](http://tracker.ceph.com/issues/39514),
    [issue#39439](http://tracker.ceph.com/issues/39439),
    [pr#28164](https://github.com/ceph/ceph/pull/28164), Sage Weil)
-   doc: add LAZYIO
    ([issue#39051](http://tracker.ceph.com/issues/39051),
    [issue#38729](http://tracker.ceph.com/issues/38729),
    [pr#27899](https://github.com/ceph/ceph/pull/27899), \"Yan, Zheng\")
-   doc: add documentation for \"fs set min_compat_client\"
    ([issue#39130](http://tracker.ceph.com/issues/39130),
    [issue#39176](http://tracker.ceph.com/issues/39176),
    [pr#27900](https://github.com/ceph/ceph/pull/27900), Patrick
    Donnelly)
-   doc: cleanup HTTP Frontends documentation
    ([issue#38874](http://tracker.ceph.com/issues/38874),
    [pr#27922](https://github.com/ceph/ceph/pull/27922), Casey Bodley)
-   doc: dashboard documentation changes
    ([pr#27642](https://github.com/ceph/ceph/pull/27642), Tatjana
    Dehler, Lenz Grimmer)
-   doc: orchestrator_cli: Rook orch supports mon update
    ([issue#39169](http://tracker.ceph.com/issues/39169),
    [issue#39137](http://tracker.ceph.com/issues/39137),
    [pr#27488](https://github.com/ceph/ceph/pull/27488), Sebastian
    Wagner)
-   doc: osd_internals/async_recovery: update cost calculation
    ([pr#28046](https://github.com/ceph/ceph/pull/28046), Neha Ojha)
-   doc: rados/operations/devices: document device prediction
    ([pr#27752](https://github.com/ceph/ceph/pull/27752), Sage Weil)
-   mgr/ActivePyModules: handle_command - fix broken lock
    ([issue#39235](http://tracker.ceph.com/issues/39235),
    [issue#39308](http://tracker.ceph.com/issues/39308),
    [pr#27939](https://github.com/ceph/ceph/pull/27939), xie xingguo)
-   mgr/BaseMgrModule: run MonCommandCompletion on the finisher
    ([issue#39397](http://tracker.ceph.com/issues/39397),
    [issue#39335](http://tracker.ceph.com/issues/39335),
    [pr#27699](https://github.com/ceph/ceph/pull/27699), Sage Weil)
-   mgr/ansible: Host ls implementation
    ([issue#39559](http://tracker.ceph.com/issues/39559),
    [pr#27919](https://github.com/ceph/ceph/pull/27919), Juan Miguel
    Olmo Martxc3xadnez)
-   mgr/balancer: various compat weight-set fixes
    ([pr#28279](https://github.com/ceph/ceph/pull/28279), xie xingguo)
-   mgr/dashboard: Add custom dialogue for configuring PG scrub
    parameters ([issue#40059](http://tracker.ceph.com/issues/40059),
    [pr#28555](https://github.com/ceph/ceph/pull/28555), Tatjana Dehler)
-   mgr/dashboard: Admin resource not honored
    ([issue#39338](http://tracker.ceph.com/issues/39338),
    [issue#39467](http://tracker.ceph.com/issues/39467),
    [pr#27868](https://github.com/ceph/ceph/pull/27868), Wido den
    Hollander)
-   mgr/dashboard: Angular is creating multiple instances of the same
    service ([issue#39996](http://tracker.ceph.com/issues/39996),
    [issue#40075](http://tracker.ceph.com/issues/40075),
    [pr#28312](https://github.com/ceph/ceph/pull/28312), Tiago Melo)
-   mgr/dashboard: Avoid merge conflicts in messages.xlf by
    auto-generating it at build time?
    ([issue#39658](http://tracker.ceph.com/issues/39658),
    [pr#28178](https://github.com/ceph/ceph/pull/28178), Sebastian Krah)
-   mgr/dashboard: Display correct dialog title
    ([pr#28189](https://github.com/ceph/ceph/pull/28189), Volker Theile)
-   mgr/dashboard: Error creating NFS client without squash
    ([issue#40074](http://tracker.ceph.com/issues/40074),
    [pr#28311](https://github.com/ceph/ceph/pull/28311), Tiago Melo)
-   mgr/dashboard: KV-table transforms dates through pipe
    ([issue#39558](http://tracker.ceph.com/issues/39558),
    [pr#28021](https://github.com/ceph/ceph/pull/28021), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Localization for date picker module
    ([issue#39371](http://tracker.ceph.com/issues/39371),
    [pr#27673](https://github.com/ceph/ceph/pull/27673), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Manager should complain about wrong dashboard
    certificate ([issue#39346](http://tracker.ceph.com/issues/39346),
    [pr#27742](https://github.com/ceph/ceph/pull/27742), Volker Theile)
-   mgr/dashboard: NFS clients information is not displayed in the
    details view ([issue#40057](http://tracker.ceph.com/issues/40057),
    [pr#28318](https://github.com/ceph/ceph/pull/28318), Tiago Melo)
-   mgr/dashboard: NFS export creation: Add more info to the validation
    message of the field Pseudo
    ([issue#39975](http://tracker.ceph.com/issues/39975),
    [issue#39327](http://tracker.ceph.com/issues/39327),
    [pr#28320](https://github.com/ceph/ceph/pull/28320), Tiago Melo)
-   mgr/dashboard: Only one root node is shown in the crush map viewer
    ([issue#39647](http://tracker.ceph.com/issues/39647),
    [issue#40077](http://tracker.ceph.com/issues/40077),
    [pr#28316](https://github.com/ceph/ceph/pull/28316), Tiago Melo)
-   mgr/dashboard: Push Grafana dashboards on startup
    ([pr#28635](https://github.com/ceph/ceph/pull/28635), Zack Cerza)
-   mgr/dashboard: Queue notifications as default
    ([issue#39560](http://tracker.ceph.com/issues/39560),
    [pr#28022](https://github.com/ceph/ceph/pull/28022), Stephan
    Mxc3xbcller)
-   mgr/dashboard: RBD snapshot name suggestion with local time suffix
    ([issue#39534](http://tracker.ceph.com/issues/39534),
    [pr#27890](https://github.com/ceph/ceph/pull/27890), Stephan
    Mxc3xbcller)
-   mgr/dashboard: Reduce the number of renders on the tables
    ([issue#39944](http://tracker.ceph.com/issues/39944),
    [issue#40076](http://tracker.ceph.com/issues/40076),
    [pr#28315](https://github.com/ceph/ceph/pull/28315), Tiago Melo)
-   mgr/dashboard: Some validations are not updated and prevent the
    submission of a form
    ([issue#40030](http://tracker.ceph.com/issues/40030),
    [pr#28319](https://github.com/ceph/ceph/pull/28319), Tiago Melo)
-   mgr/dashboard: Unable to see tcmu-runner perf counters
    ([issue#39988](http://tracker.ceph.com/issues/39988),
    [pr#28191](https://github.com/ceph/ceph/pull/28191), Ricardo
    Marques)
-   mgr/dashboard: Unify the look of dashboard charts
    ([issue#39384](http://tracker.ceph.com/issues/39384),
    [issue#39961](http://tracker.ceph.com/issues/39961),
    [pr#28175](https://github.com/ceph/ceph/pull/28175), Tiago Melo)
-   mgr/dashboard: Validate if any client belongs to more than one group
    ([issue#39036](http://tracker.ceph.com/issues/39036),
    [issue#39454](http://tracker.ceph.com/issues/39454),
    [pr#27760](https://github.com/ceph/ceph/pull/27760), Tiago Melo)
-   mgr/dashboard: code documentation
    ([issue#39345](http://tracker.ceph.com/issues/39345),
    [issue#36243](http://tracker.ceph.com/issues/36243),
    [pr#27746](https://github.com/ceph/ceph/pull/27746), Ernesto Puerta)
-   mgr/dashboard: iSCSI GET requests should not be logged
    ([pr#28024](https://github.com/ceph/ceph/pull/28024), Ricardo
    Marques)
-   mgr/dashboard: iSCSI form does not support IPv6
    ([pr#28026](https://github.com/ceph/ceph/pull/28026), Ricardo
    Marques)
-   mgr/dashboard: iSCSI form is showing a warning
    ([issue#39452](http://tracker.ceph.com/issues/39452),
    [issue#39324](http://tracker.ceph.com/issues/39324),
    [pr#27758](https://github.com/ceph/ceph/pull/27758), Tiago Melo)
-   mgr/dashboard: iSCSI should allow exporting an RBD image with
    Journaling enabled
    ([pr#28011](https://github.com/ceph/ceph/pull/28011), Ricardo
    Marques)
-   mgr/dashboard: inconsistent result when editing a RBD image\'s
    features ([issue#39993](http://tracker.ceph.com/issues/39993),
    [issue#39933](http://tracker.ceph.com/issues/39933),
    [pr#28218](https://github.com/ceph/ceph/pull/28218), Kiefer Chang\')
-   mgr/dashboard: incorrect help message for minimum blob size
    ([issue#39624](http://tracker.ceph.com/issues/39624),
    [issue#39664](http://tracker.ceph.com/issues/39664),
    [pr#28062](https://github.com/ceph/ceph/pull/28062), Kiefer Chang)
-   mgr/dashboard: local variable \'cluster_id\' referenced before
    assignment error when trying to list NFS Ganesha daemons
    ([issue#40031](http://tracker.ceph.com/issues/40031),
    [pr#28261](https://github.com/ceph/ceph/pull/28261), Nur Faizin\')
-   mgr/dashboard: make auth token work with UTC times only
    ([issue#39524](http://tracker.ceph.com/issues/39524),
    [issue#39300](http://tracker.ceph.com/issues/39300),
    [pr#27942](https://github.com/ceph/ceph/pull/27942), Ricardo Dias)
-   mgr/dashboard: openssl exception when verifying certificates of
    HTTPS requests ([issue#39962](http://tracker.ceph.com/issues/39962),
    [issue#39628](http://tracker.ceph.com/issues/39628),
    [pr#28163](https://github.com/ceph/ceph/pull/28163), Ricardo Dias)
-   mgr/dashboard: orchestrator mgr modules assert failure on iscsi
    service request
    ([issue#40037](http://tracker.ceph.com/issues/40037),
    [pr#28552](https://github.com/ceph/ceph/pull/28552), Sebastian
    Wagner)
-   mgr/dashboard: show degraded/misplaced/unfound objects
    ([pr#28584](https://github.com/ceph/ceph/pull/28584), Alfonso
    Martxc3xadnez)
-   mgr/orchestrator: Remove \"(addremove)\_stateful_service_rule
    ([issue#38808](http://tracker.ceph.com/issues/38808),
    [pr#27043](https://github.com/ceph/ceph/pull/27043), Sebastian
    Wagner)
-   mgr/orchestrator: add progress events to all orchestrators
    ([pr#28040](https://github.com/ceph/ceph/pull/28040), Sebastian
    Wagner)
-   mgr/progress: behave if pgs disappear (due to a racing pg merge)
    ([issue#38157](http://tracker.ceph.com/issues/38157),
    [issue#39344](http://tracker.ceph.com/issues/39344),
    [pr#27608](https://github.com/ceph/ceph/pull/27608), Sage Weil)
-   mgr/prometheus: replace whitespaces in metrics\' names
    ([pr#27886](https://github.com/ceph/ceph/pull/27886), Alfonso
    Martxc3xadnez\')
-   mgr/rook: Added missing rgw daemons in service ls
    ([issue#39171](http://tracker.ceph.com/issues/39171),
    [issue#39312](http://tracker.ceph.com/issues/39312),
    [pr#27864](https://github.com/ceph/ceph/pull/27864), Sebastian
    Wagner)
-   mgr/rook: Fix RGW creation
    ([issue#39158](http://tracker.ceph.com/issues/39158),
    [issue#39313](http://tracker.ceph.com/issues/39313),
    [pr#27863](https://github.com/ceph/ceph/pull/27863), Sebastian
    Wagner)
-   mgr/rook: Remove support for Rook older than v0.9
    ([issue#39356](http://tracker.ceph.com/issues/39356),
    [issue#39278](http://tracker.ceph.com/issues/39278),
    [pr#27862](https://github.com/ceph/ceph/pull/27862), Sebastian
    Wagner)
-   mgr/test_orchestrator: AttributeError: \'TestWriteCompletion\'
    object has no attribute \'id
    ([issue#39536](http://tracker.ceph.com/issues/39536),
    [pr#27920](https://github.com/ceph/ceph/pull/27920), Sebastian
    Wagner\')
-   mgr/volumes: FS subvolumes enhancements
    ([issue#40429](http://tracker.ceph.com/issues/40429),
    [pr#28767](https://github.com/ceph/ceph/pull/28767), Ramana Raja)
-   mgr/volumes: add CephFS subvolumes library
    ([issue#39750](http://tracker.ceph.com/issues/39750),
    [issue#40152](http://tracker.ceph.com/issues/40152),
    [issue#39949](http://tracker.ceph.com/issues/39949),
    [issue#40014](http://tracker.ceph.com/issues/40014),
    [issue#39610](http://tracker.ceph.com/issues/39610),
    [pr#28429](https://github.com/ceph/ceph/pull/28429), Sage Weil,
    Venky Shankar, Ramana Raja, Rishabh Dave)
-   mgr/volumes: refactor volume module
    ([issue#40378](http://tracker.ceph.com/issues/40378),
    [issue#39969](http://tracker.ceph.com/issues/39969),
    [pr#28595](https://github.com/ceph/ceph/pull/28595), Venky Shankar)
-   mgr: Update the restful module in nautilus
    ([pr#28291](https://github.com/ceph/ceph/pull/28291), Kefu Chai,
    Boris Ranto)
-   mgr: deadlock ([issue#39040](http://tracker.ceph.com/issues/39040),
    [issue#39425](http://tracker.ceph.com/issues/39425),
    [pr#28098](https://github.com/ceph/ceph/pull/28098), xie xingguo)
-   mgr: fix pgp_num adjustments
    ([issue#38626](http://tracker.ceph.com/issues/38626),
    [pr#27876](https://github.com/ceph/ceph/pull/27876), Sage Weil,
    Marius Schiffer)
-   mgr: log an error if we can\'t find any modules to load
    ([issue#40090](http://tracker.ceph.com/issues/40090),
    [pr#28347](https://github.com/ceph/ceph/pull/28347), Tim Serong\')
-   monitoring: pybind/mgr: fix format for rbd-mirror prometheus metrics
    ([pr#28485](https://github.com/ceph/ceph/pull/28485), Mykola Golub)
-   msg/async: connection race + winner fault can leave connection stuck
    at replacing foreve
    ([issue#39241](http://tracker.ceph.com/issues/39241),
    [issue#37499](http://tracker.ceph.com/issues/37499),
    [issue#39448](http://tracker.ceph.com/issues/39448),
    [issue#38493](http://tracker.ceph.com/issues/38493),
    [pr#27915](https://github.com/ceph/ceph/pull/27915), Jason Dillaman,
    xie xingguo)
-   msg/async/ProtocolV\[12\]: add ms_learn_addr_from_peer
    ([pr#28589](https://github.com/ceph/ceph/pull/28589), Sage Weil)
-   msg: output peer address when detecting bad CRCs
    ([issue#39367](http://tracker.ceph.com/issues/39367),
    [pr#27857](https://github.com/ceph/ceph/pull/27857), Greg Farnum)
-   pybind: Add \'RBD_FEATURE_MIGRATING\' to rbd.pyx
    ([issue#39609](http://tracker.ceph.com/issues/39609),
    [issue#39736](http://tracker.ceph.com/issues/39736),
    [pr#28482](https://github.com/ceph/ceph/pull/28482), Ricardo
    Marques\')
-   pybind: Rados.get_fsid() returning bytes in python3
    ([issue#40192](http://tracker.ceph.com/issues/40192),
    [issue#38381](http://tracker.ceph.com/issues/38381),
    [pr#28476](https://github.com/ceph/ceph/pull/28476), Jason Dillaman)
-   rbd: krbd: fix rbd map hang due to udev return subsystem unordered
    ([issue#39089](http://tracker.ceph.com/issues/39089),
    [issue#39315](http://tracker.ceph.com/issues/39315),
    [pr#28019](https://github.com/ceph/ceph/pull/28019), Zhi Zhang)
-   rbd: librbd: async open/close should free ImageCtx before issuing
    callback ([issue#39428](http://tracker.ceph.com/issues/39428),
    [issue#39031](http://tracker.ceph.com/issues/39031),
    [pr#28121](https://github.com/ceph/ceph/pull/28121), Jason Dillaman)
-   rbd: librbd: avoid dereferencing an empty container during deep-copy
    ([issue#40368](http://tracker.ceph.com/issues/40368),
    [issue#40379](http://tracker.ceph.com/issues/40379),
    [pr#28577](https://github.com/ceph/ceph/pull/28577), Jason Dillaman)
-   rbd: librbd: do not allow to deep copy migrating image
    ([issue#39224](http://tracker.ceph.com/issues/39224),
    [pr#27882](https://github.com/ceph/ceph/pull/27882), Mykola Golub)
-   rbd: librbd: fix issues with object-map/fast-diff feature interlock
    ([issue#39946](http://tracker.ceph.com/issues/39946),
    [issue#39521](http://tracker.ceph.com/issues/39521),
    [pr#28127](https://github.com/ceph/ceph/pull/28127), Jason Dillaman)
-   rbd: librbd: fixed several race conditions related to copyup
    ([issue#39195](http://tracker.ceph.com/issues/39195),
    [issue#39021](http://tracker.ceph.com/issues/39021),
    [pr#28132](https://github.com/ceph/ceph/pull/28132), Jason Dillaman)
-   rbd: librbd: make flush be queued by QOS throttler
    ([issue#38869](http://tracker.ceph.com/issues/38869),
    [pr#28120](https://github.com/ceph/ceph/pull/28120), Mykola Golub)
-   rbd: librbd: re-add support for nautilus clients talking to jewel
    clusters ([issue#39450](http://tracker.ceph.com/issues/39450),
    [pr#27936](https://github.com/ceph/ceph/pull/27936), Jason Dillaman)
-   rbd: librbd: support EC data pool images sparsify
    ([issue#39226](http://tracker.ceph.com/issues/39226),
    [pr#27903](https://github.com/ceph/ceph/pull/27903), Mykola Golub)
-   rbd: rbd-mirror: clear out bufferlist prior to listing mirror images
    ([issue#39462](http://tracker.ceph.com/issues/39462),
    [issue#39407](http://tracker.ceph.com/issues/39407),
    [pr#28122](https://github.com/ceph/ceph/pull/28122), Jason Dillaman)
-   rbd: rbd-mirror: image replayer should periodically flush IO and
    commit positions
    ([issue#39257](http://tracker.ceph.com/issues/39257),
    [issue#39288](http://tracker.ceph.com/issues/39288),
    [pr#27937](https://github.com/ceph/ceph/pull/27937), Jason Dillaman)
-   rgw: Evaluating bucket policies also while reading permissions for
    anxe2x80xa6 ([issue#38638](http://tracker.ceph.com/issues/38638),
    [issue#39273](http://tracker.ceph.com/issues/39273),
    [pr#27918](https://github.com/ceph/ceph/pull/27918), Pritha
    Srivastava)
-   rgw: admin: handle delete_at attr in object stat output
    ([pr#27827](https://github.com/ceph/ceph/pull/27827), Abhishek
    Lekshmanan)
-   rgw: beast: multiple v4 and v6 endpoints with the same port will
    cause failure ([issue#39746](http://tracker.ceph.com/issues/39746),
    [issue#39038](http://tracker.ceph.com/issues/39038),
    [pr#28541](https://github.com/ceph/ceph/pull/28541), Abhishek
    Lekshmanan)
-   rgw: beast: set a default port for endpoints
    ([issue#39048](http://tracker.ceph.com/issues/39048),
    [issue#39000](http://tracker.ceph.com/issues/39000),
    [pr#27660](https://github.com/ceph/ceph/pull/27660), Abhishek
    Lekshmanan)
-   rgw: bucket stats report mtime in UTC
    ([pr#27826](https://github.com/ceph/ceph/pull/27826), Alfonso
    Martxc3xadnez, Casey Bodley)
-   rgw: clean up some logging
    ([issue#39503](http://tracker.ceph.com/issues/39503),
    [pr#27953](https://github.com/ceph/ceph/pull/27953), J. Eric
    Ivancich)
-   rgw: cloud sync module fails to sync multipart objects
    ([issue#39684](http://tracker.ceph.com/issues/39684),
    [pr#28064](https://github.com/ceph/ceph/pull/28064), Abhishek
    Lekshmanan)
-   rgw: cloud sync module logs attrs in the log
    ([issue#39574](http://tracker.ceph.com/issues/39574),
    [pr#27954](https://github.com/ceph/ceph/pull/27954), Nathan Cutler)
-   rgw: crypto: throw DigestException from Digest and HMAC
    ([issue#39676](http://tracker.ceph.com/issues/39676),
    [issue#39456](http://tracker.ceph.com/issues/39456),
    [pr#28309](https://github.com/ceph/ceph/pull/28309), Matt Benjamin)
-   rgw: document CreateBucketConfiguration for s3 PUT Bucket request
    ([issue#39597](http://tracker.ceph.com/issues/39597),
    [issue#39601](http://tracker.ceph.com/issues/39601),
    [pr#28512](https://github.com/ceph/ceph/pull/28512), Casey Bodley)
-   rgw: fix Multisite sync corruption
    ([pr#28383](https://github.com/ceph/ceph/pull/28383), Tianshan Qu,
    Casey Bodley, Xiaoxi CHEN)
-   rgw: fix bucket may redundantly list keys after BI_PREFIX_CHAR
    ([issue#39984](http://tracker.ceph.com/issues/39984),
    [issue#40148](http://tracker.ceph.com/issues/40148),
    [pr#28410](https://github.com/ceph/ceph/pull/28410), Casey Bodley,
    Tianshan Qu)
-   rgw: fix default_placement containing \"/\" when storage_class is
    standard ([issue#39745](http://tracker.ceph.com/issues/39745),
    [issue#39380](http://tracker.ceph.com/issues/39380),
    [pr#28538](https://github.com/ceph/ceph/pull/28538), mkogan1)
-   rgw: inefficient unordered bucket listing
    ([issue#39410](http://tracker.ceph.com/issues/39410),
    [issue#39393](http://tracker.ceph.com/issues/39393),
    [pr#27924](https://github.com/ceph/ceph/pull/27924), Casey Bodley)
-   rgw: librgw: unexpected crash when creating bucket
    ([issue#39575](http://tracker.ceph.com/issues/39575),
    [pr#27955](https://github.com/ceph/ceph/pull/27955), Tao CHEN)
-   rgw: limit entries in remove_olh_pending_entries()
    ([issue#39178](http://tracker.ceph.com/issues/39178),
    [issue#39118](http://tracker.ceph.com/issues/39118),
    [pr#27664](https://github.com/ceph/ceph/pull/27664), Casey Bodley)
-   rgw: list bucket with start marker and delimiter will miss next
    object with char \'0\'
    ([issue#40762](http://tracker.ceph.com/issues/40762),
    [issue#39989](http://tracker.ceph.com/issues/39989),
    [pr#29022](https://github.com/ceph/ceph/pull/29022), Tianshan Qu)
-   rgw: multisite log trimming only checks peers that sync from us
    ([issue#39283](http://tracker.ceph.com/issues/39283),
    [pr#27814](https://github.com/ceph/ceph/pull/27814), Casey Bodley)
-   rgw: multisite: add perf counters to data sync
    ([issue#38549](http://tracker.ceph.com/issues/38549),
    [issue#38918](http://tracker.ceph.com/issues/38918),
    [pr#27921](https://github.com/ceph/ceph/pull/27921), Abhishek
    Lekshmanan, Casey Bodley)
-   rgw: multisite: mismatch of bucket creation times from List Buckets
    ([issue#39635](http://tracker.ceph.com/issues/39635),
    [issue#39735](http://tracker.ceph.com/issues/39735),
    [pr#28444](https://github.com/ceph/ceph/pull/28444), Casey Bodley)
-   rgw: multisite: period pusher gets 403 Forbidden against other
    zonegroups ([issue#39287](http://tracker.ceph.com/issues/39287),
    [issue#39414](http://tracker.ceph.com/issues/39414),
    [pr#27952](https://github.com/ceph/ceph/pull/27952), Casey Bodley)
-   rgw: race condition between resharding and ops waiting on resharding
    ([issue#39202](http://tracker.ceph.com/issues/39202),
    [pr#27800](https://github.com/ceph/ceph/pull/27800), J. Eric
    Ivancich)
-   rgw: radosgw-admin: add tenant argument to reshard cancel
    ([issue#39018](http://tracker.ceph.com/issues/39018),
    [pr#27630](https://github.com/ceph/ceph/pull/27630), Abhishek
    Lekshmanan)
-   rgw: rgw_file: save etag and acl info in setattr
    ([issue#39228](http://tracker.ceph.com/issues/39228),
    [pr#27904](https://github.com/ceph/ceph/pull/27904), Tao Chen)
-   rgw: swift object expiry fails when a bucket reshards
    ([issue#39740](http://tracker.ceph.com/issues/39740),
    [pr#28537](https://github.com/ceph/ceph/pull/28537), Abhishek
    Lekshmanan)
-   rgw: unittest_rgw_dmclock_scheduler does not need Boost_LIBRARIES
    ([issue#39577](http://tracker.ceph.com/issues/39577),
    [pr#27944](https://github.com/ceph/ceph/pull/27944), Willem Jan
    Withagen)
-   rgw: update resharding documentation
    ([issue#39046](http://tracker.ceph.com/issues/39046),
    [pr#27923](https://github.com/ceph/ceph/pull/27923), J. Eric
    Ivancich)
-   tests: added [bluestore_warn_on_legacy_statfs: false]{.title-ref}
    setting ([issue#40467](http://tracker.ceph.com/issues/40467),
    [pr#28723](https://github.com/ceph/ceph/pull/28723), Yuri Weinstein)
-   tests: added ragweed coverage to stress-split\\\* upgrade suites
    ([issue#40452](http://tracker.ceph.com/issues/40452),
    [issue#40467](http://tracker.ceph.com/issues/40467),
    [pr#28661](https://github.com/ceph/ceph/pull/28661), Yuri Weinstein)
-   tests: added v14.2.1
    ([issue#40181](http://tracker.ceph.com/issues/40181),
    [pr#28416](https://github.com/ceph/ceph/pull/28416), Yuri Weinstein)
-   tests: cannot schedule kcephfs/multimds
    ([issue#40116](http://tracker.ceph.com/issues/40116),
    [pr#28369](https://github.com/ceph/ceph/pull/28369), Patrick
    Donnelly)
-   tests: centos 7.6 etc
    ([pr#27439](https://github.com/ceph/ceph/pull/27439), Sage Weil)
-   tests: ceph-ansible: ceph-ansible requires ansible 2.8
    ([issue#40602](http://tracker.ceph.com/issues/40602),
    [issue#40669](http://tracker.ceph.com/issues/40669),
    [pr#28871](https://github.com/ceph/ceph/pull/28871), Brad Hubbard)
-   tests: ceph-ansible: cephfs_pools variable pgs should be pg_num
    ([issue#40670](http://tracker.ceph.com/issues/40670),
    [issue#40605](http://tracker.ceph.com/issues/40605),
    [pr#28872](https://github.com/ceph/ceph/pull/28872), Brad Hubbard)
-   tests: cephfs-shell: teuthology tests
    ([issue#39935](http://tracker.ceph.com/issues/39935),
    [issue#39526](http://tracker.ceph.com/issues/39526),
    [pr#28614](https://github.com/ceph/ceph/pull/28614), Milind
    Changire)
-   tests: cephfs: TestMisc.test_evict_client fails
    ([issue#40220](http://tracker.ceph.com/issues/40220),
    [pr#28613](https://github.com/ceph/ceph/pull/28613), \"Yan, Zheng\")
-   tests: cleaned up supported distro for nautilus
    ([pr#28065](https://github.com/ceph/ceph/pull/28065), Yuri
    Weinstein)
-   tests: ignore legacy bluestore stats errors
    ([issue#40374](http://tracker.ceph.com/issues/40374),
    [pr#28563](https://github.com/ceph/ceph/pull/28563), Patrick
    Donnelly)
-   tests: librbd: drop \'ceph_test_librbd_api\' target
    ([issue#39423](http://tracker.ceph.com/issues/39423),
    [issue#39072](http://tracker.ceph.com/issues/39072),
    [pr#28091](https://github.com/ceph/ceph/pull/28091), Jason
    Dillaman\')
-   tests: mgr: tox failures when running make check
    ([issue#39323](http://tracker.ceph.com/issues/39323),
    [issue#39530](http://tracker.ceph.com/issues/39530),
    [pr#27884](https://github.com/ceph/ceph/pull/27884), Nathan Cutler)
-   tests: pass \--ssh-config to pytest to resolve hosts when connecting
    ([pr#28923](https://github.com/ceph/ceph/pull/28923), Alfredo Deza)
-   tests: rbd: qemu-iotests tests fail under latest Ubuntu kernel
    ([issue#39541](http://tracker.ceph.com/issues/39541),
    [issue#24668](http://tracker.ceph.com/issues/24668),
    [pr#27988](https://github.com/ceph/ceph/pull/27988), Jason Dillaman)
-   tests: removed [1node]{.title-ref} and [systemd]{.title-ref} tests
    as ceph-deploy is not axe2x80xa6
    ([pr#28458](https://github.com/ceph/ceph/pull/28458), Yuri
    Weinstein)
-   tests: rgw: fix race in test_rgw_reshard_wait and
    test_rgw_reshard_wait uses same clock for timing
    ([issue#39479](http://tracker.ceph.com/issues/39479),
    [pr#27779](https://github.com/ceph/ceph/pull/27779), Casey Bodley)
-   tests: rgw: fix swift warning message
    ([issue#40304](http://tracker.ceph.com/issues/40304),
    [pr#28698](https://github.com/ceph/ceph/pull/28698), Casey Bodley)
-   tests: rgw: more fixes for swift task
    ([issue#40304](http://tracker.ceph.com/issues/40304),
    [pr#28922](https://github.com/ceph/ceph/pull/28922), Casey Bodley)
-   tests: rgw: skip swift tests on rhel 7.6+
    ([issue#40402](http://tracker.ceph.com/issues/40402),
    [issue#40304](http://tracker.ceph.com/issues/40304),
    [pr#28604](https://github.com/ceph/ceph/pull/28604), Casey Bodley)
-   tests: stop testing simple messenger in fs qa
    ([issue#40373](http://tracker.ceph.com/issues/40373),
    [pr#28562](https://github.com/ceph/ceph/pull/28562), Patrick
    Donnelly)
-   tests: tasks/rbd_fio: fixed missing delimiter between \'cd\' and
    \'configure ([issue#39590](http://tracker.ceph.com/issues/39590),
    [pr#27989](https://github.com/ceph/ceph/pull/27989), Jason
    Dillaman\')
-   tests: test_sessionmap assumes simple messenger
    ([issue#39430](http://tracker.ceph.com/issues/39430),
    [pr#27772](https://github.com/ceph/ceph/pull/27772), Patrick
    Donnelly)
-   tests: use curl in wait_for_radosgw() in util/rgw.py
    ([issue#40346](http://tracker.ceph.com/issues/40346),
    [pr#28598](https://github.com/ceph/ceph/pull/28598), Ali Maredia)
-   tests: workunits/rbd: use https protocol for devstack git operations
    ([issue#39656](http://tracker.ceph.com/issues/39656),
    [issue#39729](http://tracker.ceph.com/issues/39729),
    [pr#28128](https://github.com/ceph/ceph/pull/28128), Jason Dillaman)
-   tests: workunits/rbd: wait for rbd-nbd unmap to complete
    ([issue#39675](http://tracker.ceph.com/issues/39675),
    [issue#39598](http://tracker.ceph.com/issues/39598),
    [pr#28273](https://github.com/ceph/ceph/pull/28273), Jason Dillaman)

## v14.2.1 Nautilus

This is the first bug fix release of Ceph Nautilus release series. We
recommend all nautilus users upgrade to this release. For upgrading from
older releases of ceph, general guidelines for upgrade to nautilus must
be followed `nautilus-old-upgrade`{.interpreted-text role="ref"}.

### Notable Changes

-   Ceph now packages python bindings for python3.6 instead of
    python3.4, because EPEL7 recently switched from python3.4 to
    python3.6 as the native python3. see the
    [announcement](https://lists.fedoraproject.org/archives/list/epel-announce@lists.fedoraproject.org/message/EGUMKAIMPK2UD5VSHXM53BH2MBDGDWMO/)
    for more details on the background of this change.

### Known Issues

-   Nautilus-based librbd clients cannot open images stored on
    pre-Luminous clusters

### Changelog

-   bluestore: ceph-bluestore-tool: bluefs-bdev-expand cmd might assert
    if no WAL is configured
    ([issue#39253](http://tracker.ceph.com/issues/39253),
    [pr#27523](https://github.com/ceph/ceph/pull/27523), Igor Fedotov)
-   bluestore: os/bluestore: fix bitmap allocator issues
    ([pr#27139](https://github.com/ceph/ceph/pull/27139), Igor Fedotov)
-   build/ops,rgw: rgw: build async scheduler only when beast is built
    ([pr#27191](https://github.com/ceph/ceph/pull/27191), Abhishek
    Lekshmanan)
-   build/ops: build/ops: Running ceph under Pacemaker control not
    supported by SUSE Linux Enterprise
    ([issue#38862](http://tracker.ceph.com/issues/38862),
    [pr#27127](https://github.com/ceph/ceph/pull/27127), Nathan Cutler)
-   build/ops: build/ops: ceph-mgr-diskprediction-local requires numpy
    and scipy on SUSE, but these packages do not exist on SUSE
    ([issue#38863](http://tracker.ceph.com/issues/38863),
    [pr#27125](https://github.com/ceph/ceph/pull/27125), Nathan Cutler)
-   build/ops: cmake/FindRocksDB: fix IMPORTED_LOCATION for
    ROCKSDB_LIBRARIES
    ([issue#38993](http://tracker.ceph.com/issues/38993),
    [pr#27601](https://github.com/ceph/ceph/pull/27601), dudengke)
-   build/ops: cmake: revert librados_tp.so version from 3 to 2
    ([issue#39291](http://tracker.ceph.com/issues/39291),
    [issue#39293](http://tracker.ceph.com/issues/39293),
    [pr#27597](https://github.com/ceph/ceph/pull/27597), Nathan Cutler)
-   build/ops: qa,rpm,cmake: switch over to python3.6
    ([issue#39236](http://tracker.ceph.com/issues/39236),
    [issue#39164](http://tracker.ceph.com/issues/39164),
    [pr#27505](https://github.com/ceph/ceph/pull/27505), Boris Ranto,
    Kefu Chai)
-   cephfs: fs: we lack a feature bit for nautilus
    ([issue#39078](http://tracker.ceph.com/issues/39078),
    [issue#39187](http://tracker.ceph.com/issues/39187),
    [pr#27497](https://github.com/ceph/ceph/pull/27497), Patrick
    Donnelly)
-   cephfs: ls -S command produces AttributeError: \'str\' object has no
    attribute \'decode\'
    ([pr#27531](https://github.com/ceph/ceph/pull/27531), Varsha Rao)
-   cephfs: mds\|kclient: MDS_CLIENT_LATE_RELEASE warning caused by
    inline bug on RHEL 7.5
    ([issue#39225](http://tracker.ceph.com/issues/39225),
    [pr#27500](https://github.com/ceph/ceph/pull/27500), \"Yan, Zheng\")
-   common,core: crush: various fixes for weight-sets, the
    osd_crush_update_weight_set option, and tests
    ([pr#27119](https://github.com/ceph/ceph/pull/27119), Sage Weil)
-   common/blkdev: get_device_id: behave if model is lvm and
    id_model_enc isn\'t there
    ([pr#27158](https://github.com/ceph/ceph/pull/27158), Sage Weil)
-   common/config: parse \--default-\$option as a default value
    ([pr#27217](https://github.com/ceph/ceph/pull/27217), Sage Weil)
-   core,mgr: mgr: autoscale down can lead to max_pg_per_osd limit
    ([issue#39271](http://tracker.ceph.com/issues/39271),
    [issue#38786](http://tracker.ceph.com/issues/38786),
    [pr#27547](https://github.com/ceph/ceph/pull/27547), Sage Weil)
-   core,mon: mon/Monitor.cc: print min_mon_release correctly
    ([pr#27168](https://github.com/ceph/ceph/pull/27168), Neha Ojha)
-   core,tests: tests: osd-markdown.sh can fail with CLI_DUP_COMMAND=1
    ([issue#38359](http://tracker.ceph.com/issues/38359),
    [issue#39275](http://tracker.ceph.com/issues/39275),
    [pr#27550](https://github.com/ceph/ceph/pull/27550), Sage Weil)
-   core: Improvements to auto repair
    ([issue#38616](http://tracker.ceph.com/issues/38616),
    [pr#27220](https://github.com/ceph/ceph/pull/27220), xie xingguo,
    David Zafman)
-   core: Rook: Fix creation of Bluestore OSDs
    ([issue#39167](http://tracker.ceph.com/issues/39167),
    [issue#39062](http://tracker.ceph.com/issues/39062),
    [pr#27486](https://github.com/ceph/ceph/pull/27486), Sebastian
    Wagner)
-   core: ceph-objectstore-tool: rename dump-import to dump-export
    ([issue#39325](http://tracker.ceph.com/issues/39325),
    [issue#39284](http://tracker.ceph.com/issues/39284),
    [pr#27610](https://github.com/ceph/ceph/pull/27610), David Zafman)
-   core: common/blkdev: handle devices with ID_MODEL as \"LVM PV \...\"
    but valid ID_MODEL_ENC
    ([pr#27096](https://github.com/ceph/ceph/pull/27096), Sage Weil)
-   core: common: fix deferred log starting
    ([pr#27388](https://github.com/ceph/ceph/pull/27388), Sage Weil,
    Jason Dillaman)
-   core: crush/CrushCompiler: Fix \_\_replacement_assert
    ([issue#39174](http://tracker.ceph.com/issues/39174),
    [pr#27620](https://github.com/ceph/ceph/pull/27620), Brad Hubbard)
-   core: global: explicitly call out EIO events in crash dumps
    ([pr#27440](https://github.com/ceph/ceph/pull/27440), Sage Weil)
-   core: log: log_to_file + \--default-\* + fixes and improvements
    ([pr#27278](https://github.com/ceph/ceph/pull/27278), Sage Weil)
-   core: mon/MgrStatMonitor: ensure only one copy of initial service
    map ([issue#38839](http://tracker.ceph.com/issues/38839),
    [pr#27116](https://github.com/ceph/ceph/pull/27116), Sage Weil)
-   core: mon/OSDMonitor: allow \'osd pool set pgp_num_actual\'
    ([pr#27060](https://github.com/ceph/ceph/pull/27060), Sage Weil)
-   core: mon: make mon_osd_down_out_subtree_limit update at runtime
    ([pr#27582](https://github.com/ceph/ceph/pull/27582), Sage Weil)
-   core: mon: ok-to-stop commands for mon and mds
    ([pr#27347](https://github.com/ceph/ceph/pull/27347), Sage Weil)
-   core: mon: quiet devname log noise
    ([pr#27314](https://github.com/ceph/ceph/pull/27314), Sage Weil)
-   core: osd/OSDMap: add \'zone\' to default crush map
    ([pr#27117](https://github.com/ceph/ceph/pull/27117), Sage Weil)
-   core: osd/PGLog.h: print olog_can_rollback_to before deciding to
    rollback ([issue#38906](http://tracker.ceph.com/issues/38906),
    [issue#38894](http://tracker.ceph.com/issues/38894),
    [pr#27302](https://github.com/ceph/ceph/pull/27302), Neha Ojha)
-   core: osd/osd_types: fix object_stat_sum_t fast-path decode
    ([issue#39320](http://tracker.ceph.com/issues/39320),
    [issue#39281](http://tracker.ceph.com/issues/39281),
    [pr#27555](https://github.com/ceph/ceph/pull/27555), David Zafman)
-   core: osd: backport recent upmap fixes
    ([issue#38860](http://tracker.ceph.com/issues/38860),
    [issue#38967](http://tracker.ceph.com/issues/38967),
    [issue#38897](http://tracker.ceph.com/issues/38897),
    [issue#38826](http://tracker.ceph.com/issues/38826),
    [pr#27225](https://github.com/ceph/ceph/pull/27225), huangjun, xie
    xingguo)
-   core: osd: process_copy_chunk remove obc ref before pg unlock
    ([issue#38842](http://tracker.ceph.com/issues/38842),
    [issue#38973](http://tracker.ceph.com/issues/38973),
    [pr#27478](https://github.com/ceph/ceph/pull/27478), Zengran Zhang)
-   dashboard: NFS: failed to disable NFSv3 in export create
    ([issue#39104](http://tracker.ceph.com/issues/39104),
    [issue#38997](http://tracker.ceph.com/issues/38997),
    [pr#27368](https://github.com/ceph/ceph/pull/27368), Tiago Melo)
-   doc/releases/nautilus: fix config update step
    ([pr#27502](https://github.com/ceph/ceph/pull/27502), Sage Weil)
-   doc: doc/orchestrator: Fix broken bullet points
    ([issue#39168](http://tracker.ceph.com/issues/39168),
    [pr#27487](https://github.com/ceph/ceph/pull/27487), Sebastian
    Wagner)
-   doc: doc: Minor rados related documentation fixes
    ([issue#38896](http://tracker.ceph.com/issues/38896),
    [issue#38903](http://tracker.ceph.com/issues/38903),
    [pr#27189](https://github.com/ceph/ceph/pull/27189), David Zafman)
-   doc: doc: rgw: Added library/package for Golang
    ([issue#38730](http://tracker.ceph.com/issues/38730),
    [issue#38867](http://tracker.ceph.com/issues/38867),
    [pr#27549](https://github.com/ceph/ceph/pull/27549), Irek Fasikhov)
-   install-deps.sh: install \'\*rpm-macros\'
    ([issue#39164](http://tracker.ceph.com/issues/39164),
    [pr#27544](https://github.com/ceph/ceph/pull/27544), Kefu Chai)
-   mgr/dashboard add polish language
    ([issue#39052](http://tracker.ceph.com/issues/39052),
    [pr#27287](https://github.com/ceph/ceph/pull/27287), Sebastian Krah)
-   mgr/dashboard/qa: Improve
    tasks.mgr.test_dashboard.TestDashboard.test_standby
    ([pr#27237](https://github.com/ceph/ceph/pull/27237), Volker Theile)
-   mgr/dashboard: 1 osds exist in the crush map but not in the osdmap
    breaks OSD page
    ([issue#38885](http://tracker.ceph.com/issues/38885),
    [issue#36086](http://tracker.ceph.com/issues/36086),
    [pr#27543](https://github.com/ceph/ceph/pull/27543), Patrick
    Nawracay)
-   mgr/dashboard: Adapt iSCSI overview page to make use of ceph-iscsi
    ([pr#27541](https://github.com/ceph/ceph/pull/27541), Ricardo
    Marques)
-   mgr/dashboard: Add date range and log search functionality
    ([issue#37387](http://tracker.ceph.com/issues/37387),
    [issue#38878](http://tracker.ceph.com/issues/38878),
    [pr#27283](https://github.com/ceph/ceph/pull/27283), guodan1)
-   mgr/dashboard: Add refresh interval to the dashboard landing page
    ([issue#26872](http://tracker.ceph.com/issues/26872),
    [issue#38988](http://tracker.ceph.com/issues/38988),
    [pr#27267](https://github.com/ceph/ceph/pull/27267), guodan1)
-   mgr/dashboard: Add separate option to config SSL port
    ([issue#39001](http://tracker.ceph.com/issues/39001),
    [pr#27393](https://github.com/ceph/ceph/pull/27393), Volker Theile)
-   mgr/dashboard: Added breadcrumb tests to NFS menu
    ([issue#38981](http://tracker.ceph.com/issues/38981),
    [pr#27589](https://github.com/ceph/ceph/pull/27589), Nathan
    Weinberg)
-   mgr/dashboard: Back button component
    ([issue#39058](http://tracker.ceph.com/issues/39058),
    [pr#27405](https://github.com/ceph/ceph/pull/27405), Stephan Müller)
-   mgr/dashboard: Cannot submit NFS export form when NFSv4 is not
    selected ([issue#39105](http://tracker.ceph.com/issues/39105),
    [issue#39063](http://tracker.ceph.com/issues/39063),
    [pr#27370](https://github.com/ceph/ceph/pull/27370), Tiago Melo)
-   mgr/dashboard: Error creating NFS export without UDP
    ([issue#39107](http://tracker.ceph.com/issues/39107),
    [issue#39090](http://tracker.ceph.com/issues/39090),
    [pr#27372](https://github.com/ceph/ceph/pull/27372), Tiago Melo)
-   mgr/dashboard: Error on iSCSI disk diff
    ([pr#27460](https://github.com/ceph/ceph/pull/27460), Ricardo
    Marques)
-   mgr/dashboard: Filter iSCSI target images based on required features
    ([issue#39002](http://tracker.ceph.com/issues/39002),
    [pr#27363](https://github.com/ceph/ceph/pull/27363), Ricardo
    Marques)
-   mgr/dashboard: Fix env vars of [run-tox.sh]{.title-ref}
    ([issue#38798](http://tracker.ceph.com/issues/38798),
    [issue#38864](http://tracker.ceph.com/issues/38864),
    [pr#27361](https://github.com/ceph/ceph/pull/27361), Patrick
    Nawracay)
-   mgr/dashboard: Fixes tooltip behavior
    ([pr#27395](https://github.com/ceph/ceph/pull/27395), Stephan
    Müller)
-   mgr/dashboard: FixtureHelper
    ([issue#39041](http://tracker.ceph.com/issues/39041),
    [pr#27398](https://github.com/ceph/ceph/pull/27398), Stephan Müller)
-   mgr/dashboard: NFS Squash field should be required
    ([issue#39106](http://tracker.ceph.com/issues/39106),
    [issue#39064](http://tracker.ceph.com/issues/39064),
    [pr#27371](https://github.com/ceph/ceph/pull/27371), Tiago Melo)
-   mgr/dashboard: PreventDefault isn\'t working on 400 errors
    ([pr#27389](https://github.com/ceph/ceph/pull/27389), Stephan
    Müller)
-   mgr/dashboard: Typo in \"CephFS Name\" field on NFS form
    ([issue#39067](http://tracker.ceph.com/issues/39067),
    [pr#27449](https://github.com/ceph/ceph/pull/27449), Tiago Melo)
-   mgr/dashboard: dashboard giving 401 unauthorized
    ([issue#38871](http://tracker.ceph.com/issues/38871),
    [pr#27219](https://github.com/ceph/ceph/pull/27219), ming416)
-   mgr/dashboard: fix sparkline component
    ([issue#38866](http://tracker.ceph.com/issues/38866),
    [pr#27260](https://github.com/ceph/ceph/pull/27260), Alfonso
    Martínez)
-   mgr/dashboard: readonly user can\'t see any pages
    ([issue#39240](http://tracker.ceph.com/issues/39240),
    [pr#27611](https://github.com/ceph/ceph/pull/27611), Stephan Müller)
-   mgr/dashboard: unify button/URL actions naming + bugfix (add
    whitelist to guard)
    ([issue#37337](http://tracker.ceph.com/issues/37337),
    [issue#39003](http://tracker.ceph.com/issues/39003),
    [pr#27492](https://github.com/ceph/ceph/pull/27492), Ernesto Puerta)
-   mgr/dashboard: update vstart to use new ssl_server_port
    ([issue#39124](http://tracker.ceph.com/issues/39124),
    [pr#27394](https://github.com/ceph/ceph/pull/27394), Ernesto Puerta)
-   mgr/deepsea: use ceph_volume output in get_inventory()
    ([issue#39083](http://tracker.ceph.com/issues/39083),
    [pr#27319](https://github.com/ceph/ceph/pull/27319), Tim Serong)
-   mgr/diskprediction_cloud: Correct base64 encode translate table
    ([pr#27167](https://github.com/ceph/ceph/pull/27167), Rick Chen)
-   mgr/orchestrator: Add error handling to interface
    ([issue#38837](http://tracker.ceph.com/issues/38837),
    [pr#27095](https://github.com/ceph/ceph/pull/27095), Sebastian
    Wagner)
-   mgr/pg_autoscaler: add pg_autoscale_bias
    ([pr#27387](https://github.com/ceph/ceph/pull/27387), Sage Weil)
-   mgr: mgr/dashboard: Error on iSCSI target submission
    ([pr#27461](https://github.com/ceph/ceph/pull/27461), Ricardo
    Marques)
-   mgr: ceph-mgr: ImportError: Interpreter change detected - this
    module can only be loaded into one interprer per process
    ([issue#38865](http://tracker.ceph.com/issues/38865),
    [pr#27128](https://github.com/ceph/ceph/pull/27128), Tim Serong)
-   mgr: mgr/DaemonServer: handle_conf_change - fix broken locking
    ([issue#38964](http://tracker.ceph.com/issues/38964),
    [issue#38899](http://tracker.ceph.com/issues/38899),
    [pr#27454](https://github.com/ceph/ceph/pull/27454), xie xingguo)
-   mgr: mgr/balancer: Python 3 compatibility fix
    ([issue#38831](http://tracker.ceph.com/issues/38831),
    [issue#38855](http://tracker.ceph.com/issues/38855),
    [pr#27227](https://github.com/ceph/ceph/pull/27227), Marius
    Schiffer)
-   mgr: mgr/dashboard: Check if gateway is in use before allowing the
    deletion via [iscsi-gateway-rm]{.title-ref} command
    ([pr#27457](https://github.com/ceph/ceph/pull/27457), Ricardo
    Marques)
-   mgr: mgr/dashboard: Display the number of active sessions for each
    iSCSI target ([pr#27450](https://github.com/ceph/ceph/pull/27450),
    Ricardo Marques)
-   mgr: mgr/devicehealth: Fix python 3 incompatiblity
    ([issue#38957](http://tracker.ceph.com/issues/38957),
    [issue#38939](http://tracker.ceph.com/issues/38939),
    [pr#27390](https://github.com/ceph/ceph/pull/27390), Marius
    Schiffer)
-   mgr: mgr/telemetry: add report_timestamp to sent reports
    ([pr#27701](https://github.com/ceph/ceph/pull/27701), Dan Mick)
-   mgr: mgr/telemetry: use list; redact host; 24h default interval
    ([pr#27709](https://github.com/ceph/ceph/pull/27709), Sage Weil, Dan
    Mick)
-   mgr: mgr: Configure Py root logger for Mgr modules
    ([issue#38969](http://tracker.ceph.com/issues/38969),
    [pr#27261](https://github.com/ceph/ceph/pull/27261), Volker Theile)
-   mgr: mgr: Diskprediction unable to transfer data into the cloud
    server ([issue#38970](http://tracker.ceph.com/issues/38970),
    [pr#27240](https://github.com/ceph/ceph/pull/27240), Rick Chen)
-   mon/MonClient: do not dereference auth_supported.end()
    ([pr#27215](https://github.com/ceph/ceph/pull/27215), Kefu Chai)
-   mon/MonmapMonitor: clean up empty created stamp in monmap
    ([issue#39085](http://tracker.ceph.com/issues/39085),
    [pr#27399](https://github.com/ceph/ceph/pull/27399), Sage Weil)
-   mon: mon: add cluster log to file option
    ([pr#27346](https://github.com/ceph/ceph/pull/27346), Sage Weil)
-   msg/async v2: make v2 work on rdma
    ([pr#27216](https://github.com/ceph/ceph/pull/27216), Jianpeng Ma)
-   msg: default to debug_ms=0
    ([pr#27197](https://github.com/ceph/ceph/pull/27197), Sage Weil)
-   osd: OSDMapRef access by multiple threads is unsafe
    ([pr#27402](https://github.com/ceph/ceph/pull/27402), Zengran Zhang,
    Kefu Chai)
-   qa/valgrind ([pr#27320](https://github.com/ceph/ceph/pull/27320),
    Radoslaw Zarzynski)
-   rbd,tests: backport krbd discard qa fixes to nautilus
    ([issue#38861](http://tracker.ceph.com/issues/38861),
    [pr#27258](https://github.com/ceph/ceph/pull/27258), Ilya Dryomov)
-   rbd,tests: backport krbd discard qa fixes to stable branches
    ([issue#38956](http://tracker.ceph.com/issues/38956),
    [pr#27239](https://github.com/ceph/ceph/pull/27239), Ilya Dryomov)
-   rbd: librbd: ignore -EOPNOTSUPP errors when retrieving image group
    membership ([issue#38834](http://tracker.ceph.com/issues/38834),
    [pr#27080](https://github.com/ceph/ceph/pull/27080), Jason Dillaman)
-   rbd: librbd: look for pool metadata in default namespace
    ([issue#38961](http://tracker.ceph.com/issues/38961),
    [pr#27423](https://github.com/ceph/ceph/pull/27423), Mykola Golub)
-   rbd: librbd: trash move return EBUSY instead of EINVAL for migrating
    image ([issue#38968](http://tracker.ceph.com/issues/38968),
    [pr#27475](https://github.com/ceph/ceph/pull/27475), Mykola Golub)
-   rbd: rbd: krbd: return -ETIMEDOUT in polling
    ([issue#38792](http://tracker.ceph.com/issues/38792),
    [issue#38977](http://tracker.ceph.com/issues/38977),
    [pr#27539](https://github.com/ceph/ceph/pull/27539), Dongsheng Yang)
-   rgw: Adding tcp_nodelay option to Beast
    ([issue#38926](http://tracker.ceph.com/issues/38926),
    [pr#27355](https://github.com/ceph/ceph/pull/27355), Or Friedmann)
-   rgw: Fix S3 compatibility bug when CORS is not found
    ([issue#38923](http://tracker.ceph.com/issues/38923),
    [issue#37945](http://tracker.ceph.com/issues/37945),
    [pr#27331](https://github.com/ceph/ceph/pull/27331), Nick Janus)
-   rgw: LC: handle resharded buckets
    ([pr#27559](https://github.com/ceph/ceph/pull/27559), Abhishek
    Lekshmanan)
-   rgw: Make rgw admin ops api get user info consistent with the
    command line ([issue#39135](http://tracker.ceph.com/issues/39135),
    [pr#27501](https://github.com/ceph/ceph/pull/27501), Li Shuhao)
-   rgw: don\'t crash on missing /etc/mime.types
    ([issue#38921](http://tracker.ceph.com/issues/38921),
    [issue#38328](http://tracker.ceph.com/issues/38328),
    [pr#27329](https://github.com/ceph/ceph/pull/27329), Casey Bodley)
-   rgw: don\'t recalculate etags for slo/dlo
    ([pr#27561](https://github.com/ceph/ceph/pull/27561), Casey Bodley)
-   rgw: fix RGWDeleteMultiObj::verify_permission()
    ([issue#38980](http://tracker.ceph.com/issues/38980),
    [pr#27586](https://github.com/ceph/ceph/pull/27586), Irek Fasikhov)
-   rgw: fix read not exists null version return wrong
    ([issue#38811](http://tracker.ceph.com/issues/38811),
    [issue#38909](http://tracker.ceph.com/issues/38909),
    [pr#27306](https://github.com/ceph/ceph/pull/27306), Tianshan Qu)
-   rgw: ldap: fix early return in LDAPAuthEngine::init w/uri not
    empty() ([issue#38754](http://tracker.ceph.com/issues/38754),
    [pr#26972](https://github.com/ceph/ceph/pull/26972), Matt Benjamin)
-   rgw: multisite: data sync loops back to the start of the datalog
    after reaching the end
    ([issue#39075](http://tracker.ceph.com/issues/39075),
    [issue#39033](http://tracker.ceph.com/issues/39033),
    [pr#27498](https://github.com/ceph/ceph/pull/27498), Casey Bodley)
-   rgw: nfs: skip empty (non-POSIX) path segments
    ([issue#38744](http://tracker.ceph.com/issues/38744),
    [issue#38773](http://tracker.ceph.com/issues/38773),
    [pr#27208](https://github.com/ceph/ceph/pull/27208), Matt Benjamin)
-   rgw: nfs: svc-enable RGWLib
    ([issue#38774](http://tracker.ceph.com/issues/38774),
    [pr#27232](https://github.com/ceph/ceph/pull/27232), Matt Benjamin)
-   rgw: orphans find perf improvements
    ([issue#39181](http://tracker.ceph.com/issues/39181),
    [pr#27560](https://github.com/ceph/ceph/pull/27560), Abhishek
    Lekshmanan)
-   rgw: rgw admin: disable stale instance deletion in multisite
    ([issue#39015](http://tracker.ceph.com/issues/39015),
    [pr#27602](https://github.com/ceph/ceph/pull/27602), Abhishek
    Lekshmanan)
-   rgw: sse c fixes
    ([issue#38700](http://tracker.ceph.com/issues/38700),
    [pr#27296](https://github.com/ceph/ceph/pull/27296), Adam Kupczyk,
    Casey Bodley, Abhishek Lekshmanan)
-   rgw: support delimiter longer then one symbol
    ([issue#38777](http://tracker.ceph.com/issues/38777),
    [pr#27548](https://github.com/ceph/ceph/pull/27548), Matt Benjamin)
-   rook-ceph-system namespace hardcoded in the rook orchestrator
    ([issue#38799](http://tracker.ceph.com/issues/38799),
    [issue#39250](http://tracker.ceph.com/issues/39250),
    [pr#27496](https://github.com/ceph/ceph/pull/27496), Sebastian
    Wagner)
-   rpm,cmake: use specified python3 version if any
    ([pr#27382](https://github.com/ceph/ceph/pull/27382), Kefu Chai)

## v14.2.0 Nautilus

This is the first stable release of Ceph Nautilus.

### Major Changes from Mimic

-   *Dashboard*:

    The `mgr-dashboard`{.interpreted-text role="ref"} has gained a lot
    of new functionality:

    -   Support for multiple users / roles
    -   SSO (SAMLv2) for user authentication
    -   Auditing support
    -   New landing page, showing more metrics and health info
    -   I18N support
    -   REST API documentation with Swagger API

    New Ceph management features include:

    -   OSD management (mark as down/out, change OSD settings, recovery
        profiles)
    -   Cluster config settings editor
    -   Ceph Pool management (create/modify/delete)
    -   ECP management
    -   RBD mirroring configuration
    -   Embedded Grafana Dashboards (derived from Ceph Metrics)
    -   CRUSH map viewer
    -   NFS Ganesha management
    -   iSCSI target management (via `ceph-iscsi`{.interpreted-text
        role="ref"})
    -   RBD QoS configuration
    -   Ceph Manager (ceph-mgr) module management
    -   Prometheus alert Management

    Also, the Ceph Dashboard is now split into its own package named
    `ceph-mgr-dashboard`. You might want to install it separately, if
    your package management software fails to do so when it installs
    `ceph-mgr`.

-   *RADOS*:

    -   The number of placement groups (PGs) per pool can now be
        decreased at any time, and the cluster can
        `automatically tune the PG count <pg-autoscaler>`{.interpreted-text
        role="ref"} based on cluster utilization or administrator hints.
    -   The new `v2 wire protocol <msgr2>`{.interpreted-text role="ref"}
        brings support for encryption on the wire.
    -   Physical `storage devices <devices>`{.interpreted-text
        role="ref"} consumed by OSD and Monitor daemons are now tracked
        by the cluster along with health metrics (i.e., SMART), and the
        cluster can apply a pre-trained prediction model or a
        cloud-based prediction service to `warn about expected
        HDD or SSD failures <diskprediction>`{.interpreted-text
        role="ref"}.
    -   The NUMA node for OSD daemons can easily be monitored via the
        `ceph osd numa-status` command, and configured via the
        `osd_numa_node` config option.
    -   When BlueStore OSDs are used, space utilization is now broken
        down by object data, omap data, and internal metadata, by pool,
        and by pre- and post- compression sizes.
    -   OSDs more effectively prioritize the most important PGs and
        objects when performing recovery and backfill.
    -   Progress for long-running background processes\--like recovery
        after a device failure\--is now reported as part of
        `ceph status`.
    -   An experimental [Coupled-Layer \"Clay\" erasure
        code](https://www.usenix.org/conference/fast18/presentation/vajha)
        plugin has been added that reduces network bandwidth and IO
        needed for most recovery operations.

-   *RGW*:

    -   S3 lifecycle transition for tiering between storage classes.
    -   A new web frontend (Beast) has replaced civetweb as the default,
        improving overall performance.
    -   A new publish/subscribe infrastructure allows RGW to feed events
        to serverless frameworks like knative or data pipelies like
        Kafka.
    -   A range of authentication features, including STS federation
        using OAuth2 and OpenID::connect and an OPA (Open Policy Agent)
        authentication delegation prototype.
    -   The new archive zone federation feature enables full
        preservation of all objects (including history) in a separate
        zone.

-   *CephFS*:

    -   MDS stability has been greatly improved for large caches and
        long-running clients with a lot of RAM. Cache trimming and
        client capability recall is now throttled to prevent overloading
        the MDS.
    -   CephFS may now be exported via NFS-Ganesha clusters in
        environments managed by Rook. Ceph manages the clusters and
        ensures high-availability and scalability. An [introductory
        demo](https://ceph.com/community/deploying-a-cephnfs-server-cluster-with-rook/)
        is available. More automation of this feature is expected to be
        forthcoming in future minor releases of Nautilus.
    -   The MDS `mds_standby_for_*`, `mon_force_standby_active`, and
        `mds_standby_replay` configuration options have been obsoleted.
        Instead, the operator
        `may now set <mds-standby-replay>`{.interpreted-text role="ref"}
        the new `allow_standby_replay` flag on the CephFS file system.
        This setting causes standbys to become standby-replay for any
        available rank in the file system.
    -   MDS now supports dropping its cache which concurrently asks
        clients to trim their caches. This is done using MDS admin
        socket `cache drop` command.
    -   It is now possible to check the progress of an on-going scrub in
        the MDS. Additionally, a scrub may be paused or aborted. See
        `the scrub
        documentation <mds-scrub>`{.interpreted-text role="ref"} for
        more information.
    -   A new interface for creating volumes is provided via the
        `ceph volume` command-line-interface.
    -   A new cephfs-shell tool is available for manipulating a CephFS
        file system without mounting.
    -   CephFS-related output from `ceph status` has been reformatted
        for brevity, clarity, and usefulness.
    -   Lazy IO has been revamped. It can be turned on by the client
        using the new CEPH_O_LAZY flag to the `ceph_open` C/C++ API or
        via the config option `client_force_lazyio`.
    -   CephFS file system can now be brought down rapidly via the
        `ceph fs fail` command. See
        `the administration page <cephfs-administration>`{.interpreted-text
        role="ref"} for more information.

-   *RBD*:

    -   Images can be live-migrated with minimal downtime to assist with
        moving images between pools or to new layouts.
    -   New `rbd perf image iotop` and `rbd perf image iostat` commands
        provide an iotop- and iostat-like IO monitor for all RBD images.
    -   The *ceph-mgr* Prometheus exporter now optionally includes an IO
        monitor for all RBD images.
    -   Support for separate image namespaces within a pool for tenant
        isolation.

-   *Misc*:

    -   Ceph has a new set of `orchestrator modules
        <orchestrator-cli-module>`{.interpreted-text role="ref"} to
        directly interact with external orchestrators like ceph-ansible,
        DeepSea, Rook, or simply ssh via a consistent CLI (and,
        eventually, Dashboard) interface.

### Upgrading from Mimic or Luminous {#nautilus-old-upgrade}

#### Notes

-   During the upgrade from Luminous to Nautilus, it will not be
    possible to create a new OSD using a Luminous ceph-osd daemon after
    the monitors have been upgraded to Nautilus. We recommend you avoid
    adding or replacing any OSDs while the upgrade is in progress.
-   We recommend you avoid creating any RADOS pools while the upgrade is
    in progress.
-   You can monitor the progress of your upgrade at each stage with the
    `ceph versions` command, which will tell you what ceph version(s)
    are running for each type of daemon.

#### Instructions

1.  If your cluster was originally installed with a version prior to
    Luminous, ensure that it has completed at least one full scrub of
    all PGs while running Luminous. Failure to do so will cause your
    monitor daemons to refuse to join the quorum on start, leaving them
    non-functional.

    If you are unsure whether or not your Luminous cluster has completed
    a full scrub of all PGs, you can check your cluster\'s state by
    running:

        # ceph osd dump | grep ^flags

    In order to be able to proceed to Nautilus, your OSD map must
    include the `recovery_deletes` and `purged_snapdirs` flags.

    If your OSD map does not contain both these flags, you can simply
    wait for approximately 24-48 hours, which in a standard cluster
    configuration should be ample time for all your placement groups to
    be scrubbed at least once, and then repeat the above process to
    recheck.

    However, if you have just completed an upgrade to Luminous and want
    to proceed to Mimic in short order, you can force a scrub on all
    placement groups with a one-line shell command, like:

        # ceph pg dump pgs_brief | cut -d " " -f 1 | xargs -n1 ceph pg scrub

    You should take into consideration that this forced scrub may
    possibly have a negative impact on your Ceph clients\' performance.

2.  Make sure your cluster is stable and healthy (no down or recovering
    OSDs). (Optional, but recommended.)

3.  Set the `noout` flag for the duration of the upgrade. (Optional, but
    recommended.):

        # ceph osd set noout

4.  Upgrade monitors by installing the new packages and restarting the
    monitor daemons. For example, on each monitor host,:

        # systemctl restart ceph-mon.target

    Once all monitors are up, verify that the monitor upgrade is
    complete by looking for the `nautilus` string in the mon map. The
    command:

        # ceph mon dump | grep min_mon_release

    should report:

        min_mon_release 14 (nautilus)

    If it doesn\'t, that implies that one or more monitors hasn\'t been
    upgraded and restarted and/or the quorum does not include all
    monitors.

5.  Upgrade `ceph-mgr` daemons by installing the new packages and
    restarting all manager daemons. For example, on each manager host,:

        # systemctl restart ceph-mgr.target

    Please note, if you are using Ceph Dashboard, you will probably need
    to install `ceph-mgr-dashboard` separately after upgrading
    `ceph-mgr` package. The install script of `ceph-mgr-dashboard` will
    restart the manager daemons automatically for you. So in this case,
    you can just skip the step to restart the daemons.

    Verify the `ceph-mgr` daemons are running by checking `ceph -s`:

        # ceph -s

        ...
          services:
           mon: 3 daemons, quorum foo,bar,baz
           mgr: foo(active), standbys: bar, baz
        ...

6.  Upgrade all OSDs by installing the new packages and restarting the
    ceph-osd daemons on all OSD hosts:

        # systemctl restart ceph-osd.target

    You can monitor the progress of the OSD upgrades with the
    `ceph versions` or `ceph osd versions` commands:

        # ceph osd versions
        {
           "ceph version 13.2.5 (...) mimic (stable)": 12,
           "ceph version 14.2.0 (...) nautilus (stable)": 22,
        }

7.  If there are any OSDs in the cluster deployed with ceph-disk (e.g.,
    almost any OSDs that were created before the Mimic release), you
    need to tell ceph-volume to adopt responsibility for starting the
    daemons. On each host containing OSDs, ensure the OSDs are currently
    running, and then:

        # ceph-volume simple scan
        # ceph-volume simple activate --all

    We recommend that each OSD host be rebooted following this step to
    verify that the OSDs start up automatically.

    Note that ceph-volume doesn\'t have the same hot-plug capability
    that ceph-disk did, where a newly attached disk is automatically
    detected via udev events. If the OSD isn\'t currently running when
    the above `scan` command is run, or a ceph-disk-based OSD is moved
    to a new host, or the host OSD is reinstalled, or the
    `/etc/ceph/osd` directory is lost, you will need to scan the main
    data partition for each ceph-disk OSD explicitly. For example,:

        # ceph-volume simple scan /dev/sdb1

    The output will include the appropriate
    `ceph-volume simple activate` command to enable the OSD.

8.  Upgrade all CephFS MDS daemons. For each CephFS file system,

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

            # systemctl restart ceph-mds.target

    2.  Restart all standby MDS daemons that were taken offline:

    > \# systemctl start ceph-mds.target

    1.  Restore the original value of `max_mds` for the volume:

    > \# ceph fs set \<fs_name\> max_mds \<original_max_mds\>

9.  Upgrade all radosgw daemons by upgrading packages and restarting
    daemons on all hosts:

        # systemctl restart ceph-radosgw.target

10. Complete the upgrade by disallowing pre-Nautilus OSDs and enabling
    all new Nautilus-only functionality:

        # ceph osd require-osd-release nautilus

    :::: important
    ::: title
    Important
    :::

    This step is mandatory. Failure to execute this step will make it
    impossible for OSDs to communicate after msgrv2 is enabled.
    ::::

11. If you set `noout` at the beginning, be sure to clear it with:

        # ceph osd unset noout

12. Verify the cluster is healthy with `ceph health`.

    If your CRUSH tunables are older than Hammer, Ceph will now issue a
    health warning. If you see a health alert to that effect, you can
    revert this change with:

        ceph config set mon mon_crush_min_required_version firefly

    If Ceph does not complain, however, then we recommend you also
    switch any existing CRUSH buckets to straw2, which was added back in
    the Hammer release. If you have any \'straw\' buckets, this will
    result in a modest amount of data movement, but generally nothing
    too severe.:

        ceph osd getcrushmap -o backup-crushmap
        ceph osd crush set-all-straw-buckets-to-straw2

    If there are problems, you can easily revert with:

        ceph osd setcrushmap -i backup-crushmap

    Moving to \'straw2\' buckets will unlock a few recent features, like
    the [crush-compat]{.title-ref}
    `balancer <balancer>`{.interpreted-text role="ref"} mode added back
    in Luminous.

13. To enable the new `v2 network protocol <msgr2>`{.interpreted-text
    role="ref"}, issue the following command:

        ceph mon enable-msgr2

    This will instruct all monitors that bind to the old default port
    6789 for the legacy v1 protocol to also bind to the new 3300 v2
    protocol port. To see if all monitors have been updated,:

        ceph mon dump

    and verify that each monitor has both a `v2:` and `v1:` address
    listed.

    Running nautilus OSDs will not bind to their v2 address
    automatically. They must be restarted for that to happen.

    :::: important
    ::: title
    Important
    :::

    Before this step is run, the following command must already have
    been run:

    \# ceph osd require-osd-release nautilus

    If this command (step 10 in this procedure) has not been run, OSDs
    will lose the ability to communicate.
    ::::

14. For each host that has been upgraded, you should update your
    `ceph.conf` file so that it either specifies no monitor port (if you
    are running the monitors on the default ports) or references both
    the v2 and v1 addresses and ports explicitly. Things will still work
    if only the v1 IP and port are listed, but each CLI instantiation or
    daemon will need to reconnect after learning the monitors also speak
    the v2 protocol, slowing things down a bit and preventing a full
    transition to the v2 protocol.

    This is also a good time to fully transition any config options in
    `ceph.conf` into the cluster\'s configuration database. On each
    host, you can use the following command to import any options into
    the monitors with:

        ceph config assimilate-conf -i /etc/ceph/ceph.conf

    You can see the cluster\'s configuration database with:

        ceph config dump

    To create a minimal but sufficient `ceph.conf` for each host,:

        ceph config generate-minimal-conf > /etc/ceph/ceph.conf.new
        mv /etc/ceph/ceph.conf.new /etc/ceph/ceph.conf

    Be sure to use this new config only on hosts that have been upgraded
    to Nautilus, as it may contain a `mon_host` value that includes the
    new `v2:` and `v1:` prefixes for IP addresses that is only
    understood by Nautilus.

    For more information, see `msgr2_ceph_conf`{.interpreted-text
    role="ref"}.

15. Consider enabling the
    `telemetry module <telemetry>`{.interpreted-text role="ref"} to send
    anonymized usage statistics and crash information to the Ceph
    upstream developers. To see what would be reported (without actually
    sending any information to anyone),:

        ceph mgr module enable telemetry
        ceph telemetry show

    If you are comfortable with the data that is reported, you can
    opt-in to automatically report the high-level cluster metadata with:

        ceph telemetry on

    For more information about the telemetry module, see `the
    documentation <telemetry>`{.interpreted-text role="ref"}.

### Upgrading from pre-Luminous releases (like Jewel)

You *must* first upgrade to Luminous (12.2.z) before attempting an
upgrade to Nautilus. In addition, your cluster must have completed at
least one scrub of all PGs while running Luminous, setting the
`recovery_deletes` and `purged_snapdirs` flags in the OSD map.

### Upgrade compatibility notes

These changes occurred between the Mimic and Nautilus releases.

-   `ceph pg stat` output has been modified in json format to match
    `ceph df` output:

    -   \"raw_bytes\" field renamed to \"total_bytes\"

    -   \"raw_bytes_avail\" field renamed to \"total_bytes_avail\"

    -   \"raw_bytes_avail\" field renamed to \"total_bytes_avail\"

    -   \"raw_bytes_used\" field renamed to \"total_bytes_raw_used\"

    -   

        \"total_bytes_used\" field added to represent the space (accumulated over

        :   all OSDs) allocated purely for data objects kept at
            block(slow) device

-   `ceph df [detail]` output (GLOBAL section) has been modified in
    plain format:

    -   new \'USED\' column shows the space (accumulated over all OSDs)
        allocated purely for data objects kept at block(slow) device.

    -   

        \'RAW USED\' is now a sum of \'USED\' space and space allocated/reserved at

        :   block device for Ceph purposes, e.g. BlueFS part for
            BlueStore.

-   `ceph df [detail]` output (GLOBAL section) has been modified in json
    format:

    -   \'total_used_bytes\' column now shows the space (accumulated
        over all OSDs) allocated purely for data objects kept at
        block(slow) device
    -   new \'total_used_raw_bytes\' column shows a sum of \'USED\'
        space and space allocated/reserved at block device for Ceph
        purposes, e.g. BlueFS part for BlueStore.

-   `ceph df [detail]` output (POOLS section) has been modified in plain
    format:

    -   \'BYTES USED\' column renamed to \'STORED\'. Represents amount
        of data stored by the user.
    -   \'USED\' column now represent amount of space allocated purely
        for data by all OSD nodes in KB.
    -   \'QUOTA BYTES\', \'QUOTA OBJECTS\' aren\'t showed anymore in
        non-detailed mode.
    -   new column \'USED COMPR\' - amount of space allocated for
        compressed data. i.e., compressed data plus all the allocation,
        replication and erasure coding overhead.
    -   new column \'UNDER COMPR\' - amount of data passed through
        compression (summed over all replicas) and beneficial enough to
        be stored in a compressed form.
    -   Some columns reordering

-   `ceph df [detail]` output (POOLS section) has been modified in json
    format:

    -   \'bytes used\' column renamed to \'stored\'. Represents amount
        of data stored by the user.

    -   

        \'raw bytes used\' column renamed to \"stored_raw\". Totals of user data

        :   over all OSD excluding degraded.

    -   new \'bytes_used\' column now represent amount of space
        allocated by all OSD nodes.

    -   \'kb_used\' column - the same as \'bytes_used\' but in KB.

    -   new column \'compress_bytes_used\' - amount of space allocated
        for compressed data. i.e., compressed data plus all the
        allocation, replication and erasure coding overhead.

    -   new column \'compress_under_bytes\' amount of data passed
        through compression (summed over all replicas) and beneficial
        enough to be stored in a compressed form.

-   `rados df [detail]` output (POOLS section) has been modified in
    plain format:

    -   \'USED\' column now shows the space (accumulated over all OSDs)
        allocated purely for data objects kept at block(slow) device.
    -   new column \'USED COMPR\' - amount of space allocated for
        compressed data. i.e., compressed data plus all the allocation,
        replication and erasure coding overhead.
    -   new column \'UNDER COMPR\' - amount of data passed through
        compression (summed over all replicas) and beneficial enough to
        be stored in a compressed form.

-   `rados df [detail]` output (POOLS section) has been modified in json
    format:

    -   \'size_bytes\' and \'size_kb\' columns now show the space
        (accumulated over all OSDs) allocated purely for data objects
        kept at block device.
    -   new column \'compress_bytes_used\' - amount of space allocated
        for compressed data. i.e., compressed data plus all the
        allocation, replication and erasure coding overhead.
    -   new column \'compress_under_bytes\' amount of data passed
        through compression (summed over all replicas) and beneficial
        enough to be stored in a compressed form.

-   `ceph pg dump` output (totals section) has been modified in json
    format:

    -   new \'USED\' column shows the space (accumulated over all OSDs)
        allocated purely for data objects kept at block(slow) device.
    -   \'USED_RAW\' is now a sum of \'USED\' space and space
        allocated/reserved at block device for Ceph purposes, e.g.
        BlueFS part for BlueStore.

-   The `ceph osd rm` command has been deprecated. Users should use
    `ceph osd destroy` or `ceph osd purge` (but after first confirming
    it is safe to do so via the `ceph osd safe-to-destroy` command).

-   The MDS now supports dropping its cache for the purposes of
    benchmarking.:

        ceph tell mds.* cache drop <timeout>

    Note that the MDS cache is cooperatively managed by the clients. It
    is necessary for clients to give up capabilities in order for the
    MDS to fully drop its cache. This is accomplished by asking all
    clients to trim as many caps as possible. The timeout argument to
    the `cache drop` command controls how long the MDS waits for clients
    to complete trimming caps. This is optional and is 0 by default (no
    timeout). Keep in mind that clients may still retain caps to open
    files which will prevent the metadata for those files from being
    dropped by both the client and the MDS. (This is an equivalent
    scenario to dropping the Linux page/buffer/inode/dentry caches with
    some processes pinning some inodes/dentries/pages in cache.)

-   The `mon_health_preluminous_compat` and
    `mon_health_preluminous_compat_warning` config options are removed,
    as the related functionality is more than two versions old. Any
    legacy monitoring system expecting Jewel-style health output will
    need to be updated to work with Nautilus.

-   Nautilus is not supported on any distros still running upstart so
    upstart specific files and references have been removed.

-   The `ceph pg <pgid> list_missing` command has been renamed to
    `ceph pg <pgid> list_unfound` to better match its behaviour.

-   The *rbd-mirror* daemon can now retrieve remote peer cluster
    configuration secrets from the monitor. To use this feature, the
    rbd-mirror daemon CephX user for the local cluster must use the
    `profile rbd-mirror` mon cap. The secrets can be set using the
    `rbd mirror pool peer add` and `rbd mirror pool peer set` actions.

-   The \'rbd-mirror\' daemon will now run in active/active mode by
    default, where mirrored images are evenly distributed between all
    active \'rbd-mirror\' daemons. To revert to active/passive mode,
    override the \'rbd_mirror_image_policy_type\' config key to
    \'none\'.

-   The `ceph mds deactivate` is fully obsolete and references to it in
    the docs have been removed or clarified.

-   The libcephfs bindings added the `ceph_select_filesystem` function
    for use with multiple filesystems.

-   The cephfs python bindings now include `mount_root` and
    `filesystem_name` options in the mount() function.

-   erasure-code: add experimental *Coupled LAYer (CLAY)* erasure codes
    support. It features less network traffic and disk I/O when
    performing recovery.

-   The `cache drop` OSD command has been added to drop an OSD\'s
    caches:

    > -   `ceph tell osd.x cache drop`

-   The `cache status` OSD command has been added to get the cache stats
    of an OSD:

    > -   `ceph tell osd.x cache status`

-   The libcephfs added several functions that allow restarted client to
    destroy or reclaim state held by a previous incarnation. These
    functions are for NFS servers.

-   The `ceph` command line tool now accepts keyword arguments in the
    format `--arg=value` or `--arg value`.

-   `librados::IoCtx::nobjects_begin()` and `librados::NObjectIterator`
    now communicate errors by throwing a `std::system_error` exception
    instead of `std::runtime_error`.

-   The callback function passed to `LibRGWFS.readdir()` now accepts a
    `flags` parameter. it will be the last parameter passed to
    `readdir()` method.

-   The `cephfs-data-scan scan_links` now automatically repair inotables
    and snaptable.

-   Configuration values `mon_warn_not_scrubbed` and
    `mon_warn_not_deep_scrubbed` have been renamed. They are now
    `mon_warn_pg_not_scrubbed_ratio` and
    `mon_warn_pg_not_deep_scrubbed_ratio` respectively. This is to
    clarify that these warnings are related to pg scrubbing and are a
    ratio of the related interval. These options are now enabled by
    default.

-   The MDS cache trimming is now throttled. Dropping the MDS cache via
    the `ceph tell mds.<foo> cache drop` command or large reductions in
    the cache size will no longer cause service unavailability.

-   The CephFS MDS behavior with recalling caps has been significantly
    improved to not attempt recalling too many caps at once, leading to
    instability. MDS with a large cache (64GB+) should be more stable.

-   MDS now provides a config option `mds_max_caps_per_client` (default:
    1M) to limit the number of caps a client session may hold. Long
    running client sessions with a large number of caps have been a
    source of instability in the MDS when all of these caps need to be
    processed during certain session events. It is recommended to not
    unnecessarily increase this value.

-   The MDS config `mds_recall_state_timeout` has been removed. Late
    client recall warnings are now generated based on the number of caps
    the MDS has recalled which have not been released. The new configs
    `mds_recall_warning_threshold` (default: 32K) and
    `mds_recall_warning_decay_rate` (default: 60s) sets the threshold
    for this warning.

-   The Telegraf module for the Manager allows for sending statistics to
    an Telegraf Agent over TCP, UDP or a UNIX Socket. Telegraf can then
    send the statistics to databases like InfluxDB, ElasticSearch,
    Graphite and many more.

-   The graylog fields naming the originator of a log event have
    changed: the string-form name is now included (e.g.,
    `"name": "mgr.foo"`), and the rank-form name is now in a nested
    section (e.g., `"rank": {"type": "mgr", "num": 43243}`).

-   If the cluster log is directed at syslog, the entries are now
    prefixed by both the string-form name and the rank-form name (e.g.,
    `mgr.x mgr.12345 ...` instead of just `mgr.12345 ...`).

-   The JSON output of the `ceph osd find` command has replaced the `ip`
    field with an `addrs` section to reflect that OSDs may bind to
    multiple addresses.

-   CephFS clients without the \'s\' flag in their authentication
    capability string will no longer be able to create/delete snapshots.
    To allow `client.foo` to create/delete snapshots in the `bar`
    directory of filesystem `cephfs_a`, use command:

    > -   `ceph auth caps client.foo mon 'allow r' osd 'allow rw tag cephfs data=cephfs_a' mds 'allow rw, allow rws path=/bar'`

-   The `osd_heartbeat_addr` option has been removed as it served no
    (good) purpose: the OSD should always check heartbeats on both the
    public and cluster networks.

-   The `rados` tool\'s `mkpool` and `rmpool` commands have been removed
    because they are redundant; please use the `ceph osd pool create`
    and `ceph osd pool rm` commands instead.

-   The `auid` property for cephx users and RADOS pools has been
    removed. This was an undocumented and partially implemented
    capability that allowed cephx users to map capabilities to RADOS
    pools that they \"owned\". Because there are no users we have
    removed this support. If any cephx capabilities exist in the cluster
    that restrict based on auid then they will no longer parse, and the
    cluster will report a health warning like:

        AUTH_BAD_CAPS 1 auth entities have invalid capabilities
            client.bad osd capability parse failed, stopped at 'allow rwx auid 123' of 'allow rwx auid 123'

    The capability can be adjusted with the `ceph auth caps` command.
    For example,:

        ceph auth caps client.bad osd 'allow rwx pool foo'

-   The `ceph-kvstore-tool` `repair` command has been renamed
    `destructive-repair` since we have discovered it can corrupt an
    otherwise healthy rocksdb database. It should be used only as a
    last-ditch attempt to recover data from an otherwise corrupted
    store.

-   The default memory utilization for the mons has been increased
    somewhat. Rocksdb now uses 512 MB of RAM by default, which should be
    sufficient for small to medium-sized clusters; large clusters should
    tune this up. Also, the `mon_osd_cache_size` has been increase from
    10 OSDMaps to 500, which will translate to an additional 500 MB to 1
    GB of RAM for large clusters, and much less for small clusters.

-   The `mgr/balancer/max_misplaced` option has been replaced by a new
    global `target_max_misplaced_ratio` option that throttles both
    balancer activity and automated adjustments to `pgp_num` (normally
    as a result of `pg_num` changes). If you have customized the
    balancer module option, you will need to adjust your config to set
    the new global option or revert to the default of .05 (5%).

-   By default, Ceph no longer issues a health warning when there are
    misplaced objects (objects that are fully replicated but not stored
    on the intended OSDs). You can reenable the old warning by setting
    `mon_warn_on_misplaced` to `true`.

-   The `ceph-create-keys` tool is now obsolete. The monitors
    automatically create these keys on their own. For now the script
    prints a warning message and exits, but it will be removed in the
    next release. Note that `ceph-create-keys` would also write the
    admin and bootstrap keys to /etc/ceph and /var/lib/ceph, but this
    script no longer does that. Any deployment tools that relied on this
    behavior should instead make use of the
    `ceph auth export <entity-name>` command for whichever key(s) they
    need.

-   The `mon_osd_pool_ec_fast_read` option has been renamed
    `osd_pool_default_ec_fast_read` to be more consistent with other
    `osd_pool_default_*` options that affect default values for newly
    created RADOS pools.

-   The `mon addr` configuration option is now deprecated. It can still
    be used to specify an address for each monitor in the `ceph.conf`
    file, but it only affects cluster creation and bootstrapping, and it
    does not support listing multiple addresses (e.g., both a v2 and v1
    protocol address). We strongly recommend the option be removed and
    instead a single `mon host` option be specified in the `[global]`
    section to allow daemons and clients to discover the monitors.

-   New command `ceph fs fail` has been added to quickly bring down a
    file system. This is a single command that unsets the joinable flag
    on the file system and brings down all of its ranks.

-   The `cache drop` admin socket command has been removed. The
    `ceph tell mds.X cache drop` remains.

### Detailed Changelog

-   add monitoring subdir and Grafana cluster dashboard
    ([pr#21850](https://github.com/ceph/ceph/pull/21850), Jan Fajerski)
-   auth,common: include cleanups
    ([pr#23774](https://github.com/ceph/ceph/pull/23774), Kefu Chai)
-   bluestore: bluestore/NVMEDevice.cc: fix ceph_assert() when enable
    SPDK with 64KB kernel page size
    ([issue#36624](http://tracker.ceph.com/issues/36624),
    [pr#24817](https://github.com/ceph/ceph/pull/24817), tone.zhang)
-   bluestore: bluestore/NVMEDevice.cc: fix NVMEManager thread hang
    ([issue#37720](http://tracker.ceph.com/issues/37720),
    [pr#25646](https://github.com/ceph/ceph/pull/25646), tone.zhang,
    Steve Capper)
-   bluestore: bluestore/NVMe: use PCIe selector as the path name
    ([pr#24144](https://github.com/ceph/ceph/pull/24144), Kefu Chai)
-   bluestore,cephfs,core,rbd,rgw: buffer,denc: use ptr::const_iterator
    for decode ([pr#22015](https://github.com/ceph/ceph/pull/22015),
    Kefu Chai, Casey Bodley)
-   bluestore: ceph-kvstore-tool: dump fixes
    ([pr#25262](https://github.com/ceph/ceph/pull/25262), Adam Kupczyk)
-   bluestore: common/blkdev: check retval of stat()
    ([pr#26040](https://github.com/ceph/ceph/pull/26040), Kefu Chai)
-   bluestore,core: ceph-dencoder: add bluefs types
    ([pr#22463](https://github.com/ceph/ceph/pull/22463), Sage Weil)
-   bluestore,core,mon,performance: osd,mon: enable
    level_compaction_dynamic_level_bytes for rocksdb
    ([issue#24361](http://tracker.ceph.com/issues/24361),
    [pr#22337](https://github.com/ceph/ceph/pull/22337), Kefu Chai)
-   bluestore,core: os/bluestore: don\'t store/use path_block.{db,wal}
    from meta ([pr#22462](https://github.com/ceph/ceph/pull/22462), Sage
    Weil, Alfredo Deza)
-   bluestore: os/bluestore: add bluestore_ignore_data_csum option
    ([pr#26233](https://github.com/ceph/ceph/pull/26233), Sage Weil)
-   bluestore: os/bluestore: add boundary check for cache-autotune
    related settings
    ([issue#37507](http://tracker.ceph.com/issues/37507),
    [pr#25421](https://github.com/ceph/ceph/pull/25421), xie xingguo)
-   bluestore: os/bluestore/BlueFS: only flush dirty devices when do
    \_fsync ([pr#22110](https://github.com/ceph/ceph/pull/22110),
    Jianpeng Ma)
-   bluestore: os/bluestore: bluestore_buffer_hit_bytes perf counter
    doesn\'t reset ([pr#23576](https://github.com/ceph/ceph/pull/23576),
    Igor Fedotov)
-   bluestore: os/bluestore: check return value of \_open_bluefs
    ([pr#25471](https://github.com/ceph/ceph/pull/25471), Jianpeng Ma)
-   bluestore: os/bluestore: cleanups
    ([pr#22556](https://github.com/ceph/ceph/pull/22556), Jianpeng Ma)
-   bluestore: os/bluestore: deep fsck fails on inspecting very large
    onodes ([pr#26170](https://github.com/ceph/ceph/pull/26170), Igor
    Fedotov)
-   bluestore: os/bluestore: do not assert on non-zero err codes from
    compress() call
    ([pr#25891](https://github.com/ceph/ceph/pull/25891), Igor Fedotov)
-   bluestore: os/bluestore: firstly delete db then delete bluefs if
    open db met error
    ([pr#22336](https://github.com/ceph/ceph/pull/22336), Jianpeng Ma)
-   bluestore: os/bluestore: fix and unify log output on allocation
    failure ([pr#25335](https://github.com/ceph/ceph/pull/25335), Igor
    Fedotov)
-   bluestore: os/bluestore: fix assertion in
    StupidAllocator::get_fragmentation
    ([pr#23606](https://github.com/ceph/ceph/pull/23606), Igor Fedotov)
-   bluestore: os/bluestore: fix bloom filter num entry miscalculation
    in repairer ([issue#25001](http://tracker.ceph.com/issues/25001),
    [pr#24076](https://github.com/ceph/ceph/pull/24076), Igor Fedotov)
-   bluestore: os/bluestore: fix bluefs extent miscalculations on small
    slow device ([pr#22563](https://github.com/ceph/ceph/pull/22563),
    Igor Fedotov)
-   bluestore: os/bluestore: fix race between remove_collection and
    object removals
    ([pr#23257](https://github.com/ceph/ceph/pull/23257), Igor Fedotov)
-   bluestore: os/bluestore: fixup access a destroy cond cause deadlock
    or undefine behavior
    ([pr#25659](https://github.com/ceph/ceph/pull/25659), linbing)
-   bluestore: os/bluestore: introduce new BlueFS perf counter to track
    the amount of ([pr#22086](https://github.com/ceph/ceph/pull/22086),
    Igor Fedotov)
-   bluestore: os/bluestore/KernelDevice: misc cleanup
    ([pr#21491](https://github.com/ceph/ceph/pull/21491), Jianpeng Ma)
-   bluestore: os/bluestore/KernelDevice: use flock(2) for block device
    lock ([issue#38150](http://tracker.ceph.com/issues/38150),
    [pr#26245](https://github.com/ceph/ceph/pull/26245), Sage Weil)
-   bluestore: os/bluestore: misc cleanup
    ([pr#22472](https://github.com/ceph/ceph/pull/22472), Jianpeng Ma)
-   bluestore: os/bluestore: Only use F_SET_FILE_RW_HINT when available
    ([pr#26431](https://github.com/ceph/ceph/pull/26431), Willem Jan
    Withagen)
-   bluestore: os/bluestore: Only use `WRITE_LIFE_` when available
    ([pr#25735](https://github.com/ceph/ceph/pull/25735), Willem Jan
    Withagen)
-   bluestore: os/bluestore: remove redundant fault_range
    ([pr#22898](https://github.com/ceph/ceph/pull/22898), Jianpeng Ma)
-   bluestore: os/bluestore: remove useless condtion
    ([pr#22335](https://github.com/ceph/ceph/pull/22335), Jianpeng Ma)
-   bluestore: os/bluestore: simplify and fix SharedBlob::put()
    ([issue#24211](http://tracker.ceph.com/issues/24211),
    [pr#22123](https://github.com/ceph/ceph/pull/22123), Sage Weil)
-   bluestore: os/bluestore: support for FreeBSD
    ([pr#25608](https://github.com/ceph/ceph/pull/25608), Alan Somers,
    Kefu Chai)
-   bluestore: osd/osd_types: fix pg_t::contains() to check pool id too
    ([issue#32731](http://tracker.ceph.com/issues/32731),
    [pr#24085](https://github.com/ceph/ceph/pull/24085), Sage Weil)
-   bluestore: os/objectstore: add a new op OP_CREATE
    ([pr#22385](https://github.com/ceph/ceph/pull/22385), Jianpeng Ma)
-   bluestore,performance: common/PriorityCache: First Step toward
    priority based caching
    ([pr#22009](https://github.com/ceph/ceph/pull/22009), Mark Nelson)
-   bluestore,performance: os/bluestore: allocator pruning
    ([pr#21854](https://github.com/ceph/ceph/pull/21854), Igor Fedotov)
-   bluestore,performance: os/bluestore/BlueFS: reduce bufferlist
    rebuilds during WAL writes
    ([pr#21689](https://github.com/ceph/ceph/pull/21689), Piotr Dałek)
-   bluestore,performance: os/bluestore: use the monotonic clock for
    perf counters latencies
    ([pr#22121](https://github.com/ceph/ceph/pull/22121), Mohamad Gebai)
-   bluestore: silence Clang warning on possible uninitialize usuage
    ([pr#25702](https://github.com/ceph/ceph/pull/25702), Willem Jan
    Withagen)
-   bluestore: spdk: fix ceph-osd crash when activate SPDK
    ([issue#24371](http://tracker.ceph.com/issues/24371),
    [pr#22356](https://github.com/ceph/ceph/pull/22356), tone-zhang)
-   bluestore: test/fio: add option single_pool_mode in
    ceph-bluestore.fio
    ([pr#21929](https://github.com/ceph/ceph/pull/21929), Jianpeng Ma)
-   bluestore,tests: test/objectstore: fix random generator in
    allocator_bench
    ([pr#22544](https://github.com/ceph/ceph/pull/22544), Igor Fedotov)
-   bluestore,tools: os/bluestore: allow ceph-bluestore-tool to
    coalesce, add and migrate BlueFS backing volumes
    ([pr#23103](https://github.com/ceph/ceph/pull/23103), Igor Fedotov)
-   bluestore,tools: tools/ceph-bluestore-tool: avoid mon/config access
    when calling global...
    ([pr#22085](https://github.com/ceph/ceph/pull/22085), Igor Fedotov)
-   build/ops: Add new OpenSUSE Leap id for install-deps.sh
    ([issue#25064](http://tracker.ceph.com/issues/25064),
    [pr#22793](https://github.com/ceph/ceph/pull/22793), Kyr Shatskyy)
-   build/ops: arch/arm: Allow ceph_crc32c_aarch64 to be chosen only if
    it is compil...
    ([pr#24126](https://github.com/ceph/ceph/pull/24126), David Wang)
-   build/ops: auth: do not use GSS/KRB5 if ! HAVE_GSSAPI
    ([pr#25460](https://github.com/ceph/ceph/pull/25460), Kefu Chai)
-   build/ops: build: 32 bit architecture fixes
    ([pr#23485](https://github.com/ceph/ceph/pull/23485), James Page)
-   build/ops: build: further removal of [subman]{.title-ref}
    configuration ([issue#38261](http://tracker.ceph.com/issues/38261),
    [pr#26368](https://github.com/ceph/ceph/pull/26368), Alfredo Deza)
-   build/ops: build: LLVM ld does not like the versioning scheme
    ([pr#26801](https://github.com/ceph/ceph/pull/26801), Willem Jan
    Withagen)
-   build/ops: ceph-create-keys: Misc Python 3 fixes
    ([issue#37641](http://tracker.ceph.com/issues/37641),
    [pr#25411](https://github.com/ceph/ceph/pull/25411), James Page)
-   build/ops,cephfs: deb,rpm: fix python-cephfs dependencies
    ([issue#24919](http://tracker.ceph.com/issues/24919),
    [issue#24918](http://tracker.ceph.com/issues/24918),
    [pr#23043](https://github.com/ceph/ceph/pull/23043), Kefu Chai)
-   build/ops: ceph.in: Add support for python 3
    ([pr#24739](https://github.com/ceph/ceph/pull/24739), Tiago Melo)
-   build/ops: ceph.spec.in: Don\'t use noarch for mgr module
    subpackages, fix /usr/lib64/ceph/mgr dir ownership
    ([pr#26398](https://github.com/ceph/ceph/pull/26398), Tim Serong)
-   build/ops: change ceph-mgr package depency from py-bcrypt to
    python2-bcrypt ([issue#27206](http://tracker.ceph.com/issues/27206),
    [pr#23648](https://github.com/ceph/ceph/pull/23648), Konstantin
    Sakhinov)
-   build/ops: civetweb: pull up to ceph-master
    ([pr#26515](https://github.com/ceph/ceph/pull/26515), Abhishek
    Lekshmanan)
-   build/ops: cmake,do_freebsd.sh: disable rdma features
    ([pr#22752](https://github.com/ceph/ceph/pull/22752), Kefu Chai)
-   build/ops: cmake/modules/BuildDPDK.cmake: Build required DPDK
    libraries ([issue#36341](http://tracker.ceph.com/issues/36341),
    [pr#24487](https://github.com/ceph/ceph/pull/24487), Brad Hubbard)
-   build/ops: cmake/modules/BuildRocksDB.cmake: enable compressions for
    rocksdb ([issue#24025](http://tracker.ceph.com/issues/24025),
    [pr#22181](https://github.com/ceph/ceph/pull/22181), Kefu Chai)
-   build/ops: cmake,rgw: make amqp support optional
    ([pr#26555](https://github.com/ceph/ceph/pull/26555), Kefu Chai)
-   build/ops: cmake,rpm,deb: install mgr plugins into
    /usr/share/ceph/mgr
    ([pr#26446](https://github.com/ceph/ceph/pull/26446), Kefu Chai)
-   build/ops: cmake,seastar: pick up latest seastar
    ([pr#25474](https://github.com/ceph/ceph/pull/25474), Kefu Chai)
-   build/ops,common: compressor: Fix build of Brotli Compressor
    ([pr#24967](https://github.com/ceph/ceph/pull/24967), BI SHUN KE)
-   build/ops,common,core: test: make readable.sh fail if it doesn\'t
    run anything ([pr#24812](https://github.com/ceph/ceph/pull/24812),
    Greg Farnum)
-   build/ops,core: cmake,common,filestore: silence gcc-8
    warnings/errors
    ([pr#21837](https://github.com/ceph/ceph/pull/21837), Kefu Chai)
-   build/ops,core,rbd: include/memory.h: remove memory.h
    ([pr#22690](https://github.com/ceph/ceph/pull/22690), Kefu Chai)
-   build/ops,core: systemd: only restart 3 times in 30 minutes, as fast
    as possible ([issue#24368](http://tracker.ceph.com/issues/24368),
    [pr#22349](https://github.com/ceph/ceph/pull/22349), Greg Farnum)
-   build/ops,core,tests: objectstore/test/fio: Fixed fio compilation
    when tcmalloc is used
    ([pr#23962](https://github.com/ceph/ceph/pull/23962), Adam Kupczyk)
-   build/ops: credits.sh: Ignore package-lock.json and .xlf files
    ([pr#24762](https://github.com/ceph/ceph/pull/24762), Tiago Melo)
-   build/ops: deb: drop redundant ceph-common recommends
    ([pr#20133](https://github.com/ceph/ceph/pull/20133), Nathan Cutler)
-   build/ops: debian/control: change Architecture python plugins to
    \"all\" ([pr#26377](https://github.com/ceph/ceph/pull/26377), Kefu
    Chai)
-   build/ops: debian/control: require fuse for ceph-fuse
    ([issue#21057](http://tracker.ceph.com/issues/21057),
    [pr#23675](https://github.com/ceph/ceph/pull/23675), Thomas Serlin)
-   build/ops: debian: correct ceph-common relationship with older
    radosgw package
    ([pr#24996](https://github.com/ceph/ceph/pull/24996), Matthew
    Vernon)
-   build/ops: debian: drop \'-DUSE_CRYPTOPP=OFF\' from cmake options
    ([pr#22471](https://github.com/ceph/ceph/pull/22471), Kefu Chai)
-   build/ops: debian: librados-dev should replace librados2-dev
    ([pr#25916](https://github.com/ceph/ceph/pull/25916), Kefu Chai)
-   build/ops: debian/rules: fix ceph-mgr .pyc files left behind
    ([issue#26883](http://tracker.ceph.com/issues/26883),
    [pr#23615](https://github.com/ceph/ceph/pull/23615), Dan Mick)
-   build/ops: deb,rpm,do_cmake: switch to cmake3
    ([pr#22896](https://github.com/ceph/ceph/pull/22896), Kefu Chai)
-   build/ops: dmclock, cmake: sync up with ceph/dmclock, dmclock
    related cleanups
    ([issue#26998](http://tracker.ceph.com/issues/26998),
    [pr#23643](https://github.com/ceph/ceph/pull/23643), Kefu Chai)
-   build/ops: dmclock: update dmclock submodule sha1 to tip of
    ceph/dmclock.git master
    ([pr#23837](https://github.com/ceph/ceph/pull/23837), Ricardo Dias)
-   build/ops: do_cmake.sh: automate py3 build options for certain
    distros ([pr#25205](https://github.com/ceph/ceph/pull/25205), Nathan
    Cutler)
-   build/ops: do_cmake.sh: SUSE builds need
    WITH_RADOSGW_AMQP_ENDPOINT=OFF
    ([pr#26695](https://github.com/ceph/ceph/pull/26695), Nathan Cutler)
-   build/ops: do_freebsd.sh: FreeBSD building needs the llvm linker
    ([pr#25247](https://github.com/ceph/ceph/pull/25247), Willem Jan
    Withagen)
-   build/ops: dout: declare dpp using [decltype(auto)]{.title-ref}
    instead of [auto]{.title-ref}
    ([pr#22207](https://github.com/ceph/ceph/pull/22207), Kefu Chai)
-   build/ops: dpdk: drop dpdk submodule
    ([issue#24032](http://tracker.ceph.com/issues/24032),
    [pr#21856](https://github.com/ceph/ceph/pull/21856), Kefu Chai)
-   build/ops: examples/Makefile: add -Wno-unused-parameter to avoid
    compile error ([pr#23581](https://github.com/ceph/ceph/pull/23581),
    You Ji)
-   build/ops: Improving make check reliability
    ([pr#22441](https://github.com/ceph/ceph/pull/22441), Erwan Velu)
-   build/ops: include: define errnos if not defined for better
    portablity ([pr#25302](https://github.com/ceph/ceph/pull/25302),
    Willem Jan Withagen)
-   build/ops: install-deps: check the exit status for the \$builddepcmd
    ([pr#22682](https://github.com/ceph/ceph/pull/22682), Yunchuan Wen)
-   build/ops: install-deps: do not specify unknown options
    ([pr#24315](https://github.com/ceph/ceph/pull/24315), Kefu Chai)
-   build/ops: install-deps: install setuptools before upgrading
    virtualenv ([pr#25039](https://github.com/ceph/ceph/pull/25039),
    Kefu Chai)
-   build/ops: install-deps: nuke wheelhouse if it\'s stale
    ([pr#22028](https://github.com/ceph/ceph/pull/22028), Kefu Chai)
-   build/ops: install-deps,run-make-check: use ceph-libboost repo
    ([issue#25186](http://tracker.ceph.com/issues/25186),
    [pr#23995](https://github.com/ceph/ceph/pull/23995), Kefu Chai)
-   build/ops: install-deps.sh: Add Kerberos requirement for FreeBSD
    ([pr#25688](https://github.com/ceph/ceph/pull/25688), Willem Jan
    Withagen)
-   build/ops: install-deps.sh: disable centos-sclo-rh-source
    ([issue#37707](http://tracker.ceph.com/issues/37707),
    [pr#25629](https://github.com/ceph/ceph/pull/25629), Brad Hubbard)
-   build/ops: install-deps.sh: fix gcc detection and install pre-built
    libboost on bionic
    ([pr#25169](https://github.com/ceph/ceph/pull/25169), Changcheng
    Liu, Kefu Chai)
-   build/ops: install-deps.sh: fix installing gcc on ubuntu when no old
    compiler ([pr#22488](https://github.com/ceph/ceph/pull/22488),
    Tomasz Setkowski)
-   build/ops: install-deps.sh: import ubuntu-toolchain-r\'s key without
    keyserver ([pr#22964](https://github.com/ceph/ceph/pull/22964), Kefu
    Chai)
-   build/ops: install-deps.sh: install libtool-ltdl-devel for building
    python-saml ([pr#25071](https://github.com/ceph/ceph/pull/25071),
    Kefu Chai)
-   build/ops: install-deps.sh: refrain from installing/using
    lsb_release, and other cleanup
    ([issue#18163](http://tracker.ceph.com/issues/18163),
    [pr#23361](https://github.com/ceph/ceph/pull/23361), Nathan Cutler)
-   build/ops: install-deps.sh: Remove CR repo
    ([issue#13997](http://tracker.ceph.com/issues/13997),
    [pr#25211](https://github.com/ceph/ceph/pull/25211), Brad Hubbard,
    Alfredo Deza)
-   build/ops: install-deps.sh: selectively install dependencies
    ([pr#26402](https://github.com/ceph/ceph/pull/26402), Kefu Chai)
-   build/ops: install-deps.sh: set with_seastar
    ([pr#23079](https://github.com/ceph/ceph/pull/23079), Nathan Cutler)
-   build/ops: install-deps.sh: support install gcc7 in xenial aarch64
    ([pr#22451](https://github.com/ceph/ceph/pull/22451), Yunchuan Wen)
-   build/ops: install-deps.sh: Update python requirements for FreeBSD
    ([pr#25245](https://github.com/ceph/ceph/pull/25245), Willem Jan
    Withagen)
-   build/ops: install-deps.sh: use the latest setuptools
    ([pr#26156](https://github.com/ceph/ceph/pull/26156), Kefu Chai)
-   build/ops: install-deps: s/openldap-client/openldap24-client/
    ([pr#23912](https://github.com/ceph/ceph/pull/23912), Kefu Chai)
-   build/ops: libradosstriper: conditional compile
    ([pr#21983](https://github.com/ceph/ceph/pull/21983), Jesse
    Williamson)
-   build/ops: make-debs.sh: clean dir to allow building deb packages
    multiple times ([pr#25177](https://github.com/ceph/ceph/pull/25177),
    Changcheng Liu)
-   build/ops: man: skip directive starting with \"..\"
    ([pr#23580](https://github.com/ceph/ceph/pull/23580), Kefu Chai)
-   build/ops,mgr: build: mgr: check for python\'s ssl version linkage
    ([issue#24282](http://tracker.ceph.com/issues/24282),
    [pr#22659](https://github.com/ceph/ceph/pull/22659), Kefu Chai,
    Abhishek Lekshmanan)
-   build/ops,mgr: cmake,deb,rpm: remove cython 0.29\'s subinterpreter
    check, re-enable build with cython 0.29+
    ([pr#25585](https://github.com/ceph/ceph/pull/25585), Tim Serong)
-   build/ops: mgr/dashboard: Add html-linter
    ([pr#24273](https://github.com/ceph/ceph/pull/24273), Tiago Melo)
-   build/ops: mgr/dashboard: Add i18n validation script
    ([pr#25179](https://github.com/ceph/ceph/pull/25179), Tiago Melo)
-   build/ops: mgr/dashboard: Add package-lock.json
    ([pr#23285](https://github.com/ceph/ceph/pull/23285), Tiago Melo)
-   build/ops: mgr/dashboard: Disable showing xi18n\'s progress
    ([pr#25427](https://github.com/ceph/ceph/pull/25427), Tiago Melo)
-   build/ops: mgr/dashboard: Fix run-frontend-e2e-tests.sh
    ([pr#25157](https://github.com/ceph/ceph/pull/25157), Tiago Melo)
-   build/ops: mgr/dashboard: fix the version of all frontend
    dependencies ([pr#22712](https://github.com/ceph/ceph/pull/22712),
    Tiago Melo)
-   build/ops: mgr/dashboard: Remove angular build progress logs during
    cmake ([pr#23115](https://github.com/ceph/ceph/pull/23115), Tiago
    Melo)
-   build/ops: mgr/dashboard: Update Node.js to current LTS
    ([pr#24932](https://github.com/ceph/ceph/pull/24932), Tiago Melo)
-   build/ops: mgr/dashboard: Update node version
    ([pr#22639](https://github.com/ceph/ceph/pull/22639), Tiago Melo)
-   build/ops: mgr/diskprediction: Replace local predictor model file
    ([pr#24484](https://github.com/ceph/ceph/pull/24484), Rick Chen)
-   build/ops,mgr: mgr/dashboard: Fix building under FreeBSD
    ([pr#22562](https://github.com/ceph/ceph/pull/22562), Willem Jan
    Withagen)
-   build/ops: move dmclock subtree into submodule
    ([pr#21651](https://github.com/ceph/ceph/pull/21651), Danny Al-Gaaf)
-   build/ops,pybind: ceph: do not raise StopIteration within generator
    ([pr#25400](https://github.com/ceph/ceph/pull/25400), Jason
    Dillaman)
-   build/ops,rbd: osd,mon,pybind: Make able to compile with Clang
    ([pr#21861](https://github.com/ceph/ceph/pull/21861), Adam C.
    Emerson)
-   build/ops,rbd: selinux: add support for ceph iscsi
    ([pr#24936](https://github.com/ceph/ceph/pull/24936), Mike Christie)
-   build/ops,rbd: systemd: enable ceph-rbd-mirror.target
    ([pr#24935](https://github.com/ceph/ceph/pull/24935), Sébastien Han)
-   build/ops,rgw: build/rgw: unittest_rgw_dmclock_scheduler does not
    need Boost_LIBRARIES
    ([pr#26799](https://github.com/ceph/ceph/pull/26799), Willem Jan
    Withagen)
-   build/ops,rgw: cls: build cls_otp only WITH_RADOSGW
    ([pr#22548](https://github.com/ceph/ceph/pull/22548), Piotr Dałek)
-   build/ops,rgw: deb,rpm: package librgw_admin_user.{h,so.\*}
    ([pr#22205](https://github.com/ceph/ceph/pull/22205), Kefu Chai)
-   build/ops: rocksdb: sync with upstream
    ([issue#23653](http://tracker.ceph.com/issues/23653),
    [pr#22236](https://github.com/ceph/ceph/pull/22236), Kefu Chai)
-   build/ops: rpm: bump up required GCC version to 7.3.1
    ([pr#24130](https://github.com/ceph/ceph/pull/24130), Kefu Chai)
-   build/ops: rpm,deb: remove python-jinja2 dependency
    ([pr#26379](https://github.com/ceph/ceph/pull/26379), Kefu Chai)
-   build/ops: rpm: do not exclude s390x build on openSUSE
    ([pr#26268](https://github.com/ceph/ceph/pull/26268), Nathan Cutler)
-   build/ops: rpm: Fix Fedora error \"No matching package to install:
    \'Cython3\'\" ([issue#35831](http://tracker.ceph.com/issues/35831),
    [pr#23993](https://github.com/ceph/ceph/pull/23993), Brad Hubbard)
-   build/ops: rpm: fix libradospp-devel runtime dependency
    ([pr#25491](https://github.com/ceph/ceph/pull/25491), Nathan Cutler)
-   build/ops: rpm: fix seastar build dependencies for SUSE
    ([pr#23089](https://github.com/ceph/ceph/pull/23089), Nathan Cutler)
-   build/ops: rpm: fix seastar build dependencies
    ([pr#23386](https://github.com/ceph/ceph/pull/23386), Nathan Cutler)
-   build/ops: rpm: fix xmlsec1 build dependency for dashboard make
    check ([pr#26119](https://github.com/ceph/ceph/pull/26119), Nathan
    Cutler)
-   build/ops: rpm: Install python2-Cython on f28
    ([pr#26756](https://github.com/ceph/ceph/pull/26756), Brad Hubbard)
-   build/ops: rpm: make ceph-grafana-dashboards own its directories
    ([issue#37485](http://tracker.ceph.com/issues/37485),
    [pr#25347](https://github.com/ceph/ceph/pull/25347), Nathan Cutler,
    Tim Serong)
-   build/ops: rpm: make Python dependencies somewhat less confusing
    ([pr#25963](https://github.com/ceph/ceph/pull/25963), Nathan Cutler)
-   build/ops: rpm: make sudo a build dependency
    ([pr#23077](https://github.com/ceph/ceph/pull/23077), Nathan Cutler)
-   build/ops: rpm: package crypto libraries for all archs
    ([pr#26202](https://github.com/ceph/ceph/pull/26202), Nathan Cutler)
-   build/ops: rpm: Package grafana dashboards
    ([pr#24735](https://github.com/ceph/ceph/pull/24735), Boris Ranto)
-   build/ops: rpm: provide files moved from ceph-test ...
    ([issue#22558](http://tracker.ceph.com/issues/22558),
    [pr#20401](https://github.com/ceph/ceph/pull/20401), Nathan Cutler)
-   build/ops: rpm: RHEL 8 fixes
    ([pr#26520](https://github.com/ceph/ceph/pull/26520), Ken Dreyer)
-   build/ops: rpm: RHEL 8 needs Python 3 build
    ([pr#25223](https://github.com/ceph/ceph/pull/25223), Nathan Cutler)
-   build/ops: rpm: stop install-deps.sh clobbering spec file Python
    build setting ([issue#37301](http://tracker.ceph.com/issues/37301),
    [pr#25181](https://github.com/ceph/ceph/pull/25181), Nathan Cutler,
    Brad Hubbard)
-   build/ops: rpm: Use hardened LDFLAGS
    ([issue#36316](http://tracker.ceph.com/issues/36316),
    [pr#24425](https://github.com/ceph/ceph/pull/24425), Boris Ranto)
-   build/ops: rpm: use updated gperftools
    ([issue#35969](http://tracker.ceph.com/issues/35969),
    [pr#24124](https://github.com/ceph/ceph/pull/24124), Kefu Chai)
-   build/ops: rpm: Use updated gperftools-libs at runtime
    ([issue#36508](http://tracker.ceph.com/issues/36508),
    [pr#24652](https://github.com/ceph/ceph/pull/24652), Brad Hubbard)
-   build/ops: run-make-check: enable \--with-seastar option
    ([pr#22809](https://github.com/ceph/ceph/pull/22809), Kefu Chai)
-   build/ops: run-make-check: set WITH_SEASTAR with a non-empty string
    ([pr#23108](https://github.com/ceph/ceph/pull/23108), Kefu Chai)
-   build/ops: run-make-check.sh: Adding ccache tuning for the CI
    ([pr#22847](https://github.com/ceph/ceph/pull/22847), Erwan Velu)
-   build/ops: run-make-check.sh: ccache goodness for everyone
    ([issue#24817](http://tracker.ceph.com/issues/24817),
    [issue#24777](http://tracker.ceph.com/issues/24777),
    [pr#22867](https://github.com/ceph/ceph/pull/22867), Nathan Cutler)
-   build/ops: run-make-check: should use sudo for running sysctl
    ([pr#23708](https://github.com/ceph/ceph/pull/23708), Kefu Chai)
-   build/ops: run-make-check: Showing configuration before the build
    ([pr#23609](https://github.com/ceph/ceph/pull/23609), Erwan Velu)
-   build/ops: seastar: lower the required yaml-cpp version to 0.5.1
    ([pr#23255](https://github.com/ceph/ceph/pull/23255), Kefu Chai)
-   build/ops: seastar: pickup the change to link pthread
    ([pr#25671](https://github.com/ceph/ceph/pull/25671), Kefu Chai)
-   build/ops: selinux: Allow ceph to execute ldconfig
    ([pr#20118](https://github.com/ceph/ceph/pull/20118), Boris Ranto)
-   build/ops: spdk: update to latest spdk-18.05 branch
    ([pr#22547](https://github.com/ceph/ceph/pull/22547), Kefu Chai)
-   build/ops: spec: requires ceph base instead of common
    ([issue#37620](http://tracker.ceph.com/issues/37620),
    [pr#25503](https://github.com/ceph/ceph/pull/25503), Sébastien Han)
-   build/ops: test: move ceph-dencoder to src/tools
    ([pr#23228](https://github.com/ceph/ceph/pull/23228), Kefu Chai)
-   build/ops: test,qa: s/.libs/lib/
    ([pr#20734](https://github.com/ceph/ceph/pull/20734), Kefu Chai)
-   build/ops,tests: cmake,run-make-check: always enable
    WITH_GTEST_PARALLEL
    ([pr#23382](https://github.com/ceph/ceph/pull/23382), Kefu Chai)
-   build/ops,tests: deb,rpm,qa: split dashboard package
    ([pr#26380](https://github.com/ceph/ceph/pull/26380), Kefu Chai)
-   build/ops,tests: mgr/dashboard: Fix localStorage problem in Jest
    ([pr#23281](https://github.com/ceph/ceph/pull/23281), Tiago Melo)
-   build/ops,tests: mgr/dashboard: Object Gateway user configuration
    ([pr#25494](https://github.com/ceph/ceph/pull/25494), Laura Paduano)
-   build/ops,tests: src/test: Using gtest-parallel to speedup unittests
    ([pr#22577](https://github.com/ceph/ceph/pull/22577), Kefu Chai,
    Erwan Velu)
-   build/ops,tests: tests/fio: fix build failures and ensure this is
    covered by run-make-check.sh
    ([pr#23231](https://github.com/ceph/ceph/pull/23231), Kefu Chai,
    Igor Fedotov)
-   build/ops,tests: tests/qa: Adding \$ distro mix - rgw
    ([pr#21932](https://github.com/ceph/ceph/pull/21932), Yuri
    Weinstein)
-   build/ops,tests: tools/ceph-dencoder: conditionally link against mds
    ([pr#25255](https://github.com/ceph/ceph/pull/25255), Kefu Chai)
-   build/ops,tools: tool: link rbd-ggate against librados-cxx
    ([pr#24901](https://github.com/ceph/ceph/pull/24901), Willem Jan
    Withagen)
-   ceph-disk: get_partition_dev() should fail until
    get_dev_path(partnam...
    ([pr#21415](https://github.com/ceph/ceph/pull/21415), Erwan Velu)
-   cephfs: doc/releases: update CephFS mimic notes
    ([issue#23775](http://tracker.ceph.com/issues/23775),
    [pr#22232](https://github.com/ceph/ceph/pull/22232), Patrick
    Donnelly)
-   cephfs: mgr/dashboard: NFS Ganesha management REST API
    ([pr#25918](https://github.com/ceph/ceph/pull/25918), Lenz Grimmer,
    Ricardo Dias, Jeff Layton)
-   cephfs,mgr,pybind: pybind/mgr: Unified bits of volumes and
    orchestrator ([pr#25492](https://github.com/ceph/ceph/pull/25492),
    Sebastian Wagner)
-   cephfs,mon: MDSMonitor: silence unable to load metadata
    ([pr#25693](https://github.com/ceph/ceph/pull/25693), Song Shun)
-   cephfs,mon: mon/MDSMonitor: do not send redundant MDS health
    messages to cluster log
    ([issue#24308](http://tracker.ceph.com/issues/24308),
    [pr#22252](https://github.com/ceph/ceph/pull/22252), Sage Weil)
-   cephfs: qa: fix symlink
    ([pr#23997](https://github.com/ceph/ceph/pull/23997), Patrick
    Donnelly)
-   cephfs,rbd: osdc: Fix the wrong BufferHead offset
    ([pr#22495](https://github.com/ceph/ceph/pull/22495), dongdong tao)
-   cephfs,rbd: osdc: optimize the code doing the BufferHead mapping
    ([pr#22509](https://github.com/ceph/ceph/pull/22509), dongdong tao)
-   cephfs,rbd: osdc: reduce ObjectCacher\'s memory fragments
    ([issue#36192](http://tracker.ceph.com/issues/36192),
    [pr#24297](https://github.com/ceph/ceph/pull/24297), \"Yan, Zheng\")
-   cephfs,tests: qa: fix run call args
    ([issue#36450](http://tracker.ceph.com/issues/36450),
    [pr#24597](https://github.com/ceph/ceph/pull/24597), Patrick
    Donnelly)
-   cephfs,tests: qa: install python3-cephfs for fs suite
    ([pr#23411](https://github.com/ceph/ceph/pull/23411), Kefu Chai)
-   cephfs,tests: qa/suites/powercycle: whitelist MDS_SLOW_REQUEST
    ([pr#23151](https://github.com/ceph/ceph/pull/23151), Neha Ojha)
-   cephfs,tests: qa/workunits/suites/pjd.sh: use correct dir name
    ([pr#22233](https://github.com/ceph/ceph/pull/22233), Neha Ojha)
-   ceph-volume: activate option \--auto-detect-objectstore respects
    \--no-systemd ([issue#36249](http://tracker.ceph.com/issues/36249),
    [pr#24355](https://github.com/ceph/ceph/pull/24355), Alfredo Deza)
-   ceph-volume: Adapt code to support Python3
    ([pr#25324](https://github.com/ceph/ceph/pull/25324), Volker Theile)
-   ceph-volume: add \--all flag to simple activate
    ([pr#26225](https://github.com/ceph/ceph/pull/26225), Jan Fajerski)
-   ceph-volume add a \_\_release\_\_ string, to help
    version-conditional calls
    ([issue#25171](http://tracker.ceph.com/issues/25171),
    [pr#23332](https://github.com/ceph/ceph/pull/23332), Alfredo Deza)
-   ceph-volume: add inventory command
    ([issue#24972](http://tracker.ceph.com/issues/24972),
    [pr#24859](https://github.com/ceph/ceph/pull/24859), Jan Fajerski)
-   ceph-volume: Additional work on ceph-volume to add some choose_disk
    capabilities ([issue#36446](http://tracker.ceph.com/issues/36446),
    [pr#24504](https://github.com/ceph/ceph/pull/24504), Erwan Velu)
-   ceph-volume add new ceph-handlers role from ceph-ansible
    ([issue#36251](http://tracker.ceph.com/issues/36251),
    [pr#24336](https://github.com/ceph/ceph/pull/24336), Alfredo Deza)
-   ceph-volume: adds a \--prepare flag to [lvm batch]{.title-ref}
    ([issue#36363](http://tracker.ceph.com/issues/36363),
    [pr#24587](https://github.com/ceph/ceph/pull/24587), Andrew Schoen)
-   ceph-volume: add space between words
    ([pr#26246](https://github.com/ceph/ceph/pull/26246), Sébastien Han)
-   ceph-volume: adds test for [ceph-volume lvm list
    /dev/sda]{.title-ref}
    ([issue#24784](http://tracker.ceph.com/issues/24784),
    [issue#24957](http://tracker.ceph.com/issues/24957),
    [pr#23348](https://github.com/ceph/ceph/pull/23348), Andrew Schoen)
-   ceph-volume: Add unit test
    ([pr#25321](https://github.com/ceph/ceph/pull/25321), Volker Theile)
-   ceph-volume: allow to specify \--cluster-fsid instead of reading
    from ceph.conf ([issue#26953](http://tracker.ceph.com/issues/26953),
    [pr#24407](https://github.com/ceph/ceph/pull/24407), Alfredo Deza)
-   ceph-volume: an OSD ID must be exist and be destroyed before reuse
    ([pr#23093](https://github.com/ceph/ceph/pull/23093), Andrew Schoen,
    Ron Allred)
-   ceph-volume batch: allow journal+block.db sizing on the CLI
    ([issue#36088](http://tracker.ceph.com/issues/36088),
    [pr#24201](https://github.com/ceph/ceph/pull/24201), Alfredo Deza)
-   ceph-volume batch: allow \--osds-per-device, default it to 1
    ([issue#35913](http://tracker.ceph.com/issues/35913),
    [pr#24060](https://github.com/ceph/ceph/pull/24060), Alfredo Deza)
-   ceph-volume batch carve out lvs for bluestore
    ([pr#24019](https://github.com/ceph/ceph/pull/24019), Alfredo Deza)
-   ceph-volume batch command
    ([issue#24492](http://tracker.ceph.com/issues/24492),
    [pr#23075](https://github.com/ceph/ceph/pull/23075), Alfredo Deza)
-   ceph-volume: batch tests for mixed-type of devices
    ([issue#35535](http://tracker.ceph.com/issues/35535),
    [issue#27210](http://tracker.ceph.com/issues/27210),
    [pr#23963](https://github.com/ceph/ceph/pull/23963), Alfredo Deza)
-   ceph-volume custom cluster names fail on filestore trigger
    ([issue#27210](http://tracker.ceph.com/issues/27210),
    [pr#24251](https://github.com/ceph/ceph/pull/24251), Alfredo Deza)
-   ceph-volume: do not pin the testinfra version for the simple tests
    ([pr#23268](https://github.com/ceph/ceph/pull/23268), Andrew Schoen)
-   ceph-volume: do not send (lvm) stderr/stdout to the terminal, use
    the logfile ([issue#36492](http://tracker.ceph.com/issues/36492),
    [pr#24738](https://github.com/ceph/ceph/pull/24738), Alfredo Deza)
-   ceph-volume do not use stdin in luminous
    ([issue#25173](http://tracker.ceph.com/issues/25173),
    [pr#23355](https://github.com/ceph/ceph/pull/23355), Alfredo Deza)
-   ceph-volume: don\'t create osd\[\'block.db\'\] by default
    ([issue#38472](http://tracker.ceph.com/issues/38472),
    [pr#26627](https://github.com/ceph/ceph/pull/26627), Jan Fajerski)
-   ceph-volume: earlier detection for \--journal and \--filestore flag
    requirements ([issue#24794](http://tracker.ceph.com/issues/24794),
    [pr#24150](https://github.com/ceph/ceph/pull/24150), Alfredo Deza)
-   ceph-volume: enable device discards
    ([issue#36532](http://tracker.ceph.com/issues/36532),
    [pr#24676](https://github.com/ceph/ceph/pull/24676), Jonas Jelten)
-   ceph-volume enable \--no-systemd flag for simple sub-command
    ([issue#36470](http://tracker.ceph.com/issues/36470),
    [pr#24998](https://github.com/ceph/ceph/pull/24998), Alfredo Deza)
-   ceph-volume: enable the ceph-osd during lvm activation
    ([issue#24152](http://tracker.ceph.com/issues/24152),
    [pr#23321](https://github.com/ceph/ceph/pull/23321), Dan van der
    Ster)
-   ceph-volume ensure encoded bytes are always used
    ([issue#24993](http://tracker.ceph.com/issues/24993),
    [pr#23289](https://github.com/ceph/ceph/pull/23289), Alfredo Deza)
-   ceph-volume: error on commands that need ceph.conf to operate
    ([issue#23941](http://tracker.ceph.com/issues/23941),
    [pr#22724](https://github.com/ceph/ceph/pull/22724), Andrew Schoen)
-   ceph-volume expand auto engine for multiple devices on filestore
    ([issue#24553](http://tracker.ceph.com/issues/24553),
    [pr#23731](https://github.com/ceph/ceph/pull/23731), Andrew Schoen,
    Alfredo Deza)
-   ceph-volume: expand auto engine for single type devices on filestore
    ([issue#24960](http://tracker.ceph.com/issues/24960),
    [pr#23532](https://github.com/ceph/ceph/pull/23532), Alfredo Deza)
-   ceph-volume expand on the LVM API to create multiple LVs at
    different sizes
    ([issue#24020](http://tracker.ceph.com/issues/24020),
    [pr#22426](https://github.com/ceph/ceph/pull/22426), Alfredo Deza)
-   ceph-volume: extract flake8 config
    ([pr#24674](https://github.com/ceph/ceph/pull/24674), Mehdi
    Abaakouk)
-   ceph-volume: fix Batch object in py3 environments
    ([pr#25203](https://github.com/ceph/ceph/pull/25203), Jan Fajerski)
-   ceph-volume: fix journal and filestore data size in [lvm batch
    \--report]{.title-ref}
    ([issue#36242](http://tracker.ceph.com/issues/36242),
    [pr#24274](https://github.com/ceph/ceph/pull/24274), Andrew Schoen)
-   ceph-volume: fix JSON output in [inventory]{.title-ref}
    ([issue#37390](http://tracker.ceph.com/issues/37390),
    [pr#25224](https://github.com/ceph/ceph/pull/25224), Sebastian
    Wagner)
-   ceph-volume: Fix TypeError: join() takes exactly one argument (2
    given) ([issue#37595](http://tracker.ceph.com/issues/37595),
    [pr#25469](https://github.com/ceph/ceph/pull/25469), Sebastian
    Wagner)
-   ceph-volume fix TypeError on dmcrypt when using Python3
    ([pr#26034](https://github.com/ceph/ceph/pull/26034), Alfredo Deza)
-   ceph-volume fix zap not working with LVs
    ([issue#35970](http://tracker.ceph.com/issues/35970),
    [pr#24077](https://github.com/ceph/ceph/pull/24077), Alfredo Deza)
-   ceph-volume: implement \_\_format\_\_ in Size to format sizes in py3
    ([issue#38291](http://tracker.ceph.com/issues/38291),
    [pr#26401](https://github.com/ceph/ceph/pull/26401), Jan Fajerski)
-   ceph-volume initial take on auto sub-command
    ([pr#21803](https://github.com/ceph/ceph/pull/21803), Alfredo Deza)
-   ceph-volume: introduce class hierachy for strategies
    ([issue#37389](http://tracker.ceph.com/issues/37389),
    [pr#25238](https://github.com/ceph/ceph/pull/25238), Jan Fajerski)
-   ceph-volume: lsblk can fail to find PARTLABEL, must fallback to
    blkid ([issue#36098](http://tracker.ceph.com/issues/36098),
    [pr#24330](https://github.com/ceph/ceph/pull/24330), Alfredo Deza)
-   ceph-volume lvm.activate conditional mon-config on prime-osd-dir
    ([issue#25216](http://tracker.ceph.com/issues/25216),
    [pr#23375](https://github.com/ceph/ceph/pull/23375), Alfredo Deza)
-   ceph-volume lvm.activate Do not search for a MON configuration
    ([pr#22393](https://github.com/ceph/ceph/pull/22393), Wido den
    Hollander)
-   ceph-volume: [lvm batch]{.title-ref} allow extra flags (like
    dmcrypt) for bluestore
    ([issue#26862](http://tracker.ceph.com/issues/26862),
    [pr#23448](https://github.com/ceph/ceph/pull/23448), Alfredo Deza)
-   ceph-volume lvm.batch remove non-existent sys_api property
    ([issue#34310](http://tracker.ceph.com/issues/34310),
    [pr#23787](https://github.com/ceph/ceph/pull/23787), Alfredo Deza)
-   ceph-volume lvm.listing only include devices if they exist
    ([issue#24952](http://tracker.ceph.com/issues/24952),
    [pr#23129](https://github.com/ceph/ceph/pull/23129), Alfredo Deza)
-   ceph-volume lvm.prepare update help to indicate partitions are
    needed, not devices
    ([issue#24795](http://tracker.ceph.com/issues/24795),
    [pr#24394](https://github.com/ceph/ceph/pull/24394), Alfredo Deza)
-   ceph-volume: make Device hashable to allow set of Device list in py3
    ([issue#38290](http://tracker.ceph.com/issues/38290),
    [pr#26399](https://github.com/ceph/ceph/pull/26399), Jan Fajerski)
-   ceph-volume: make [lvm batch]{.title-ref} idempotent
    ([issue#26864](http://tracker.ceph.com/issues/26864),
    [pr#24404](https://github.com/ceph/ceph/pull/24404), Andrew Schoen)
-   ceph-volume: mark a device not available if it belongs to ceph-disk
    ([pr#26084](https://github.com/ceph/ceph/pull/26084), Andrew Schoen)
-   ceph-volume normalize comma to dot for string to int conversions
    ([issue#37442](http://tracker.ceph.com/issues/37442),
    [pr#25674](https://github.com/ceph/ceph/pull/25674), Alfredo Deza)
-   ceph-volume: patch Device when testing
    ([issue#36768](http://tracker.ceph.com/issues/36768),
    [pr#25063](https://github.com/ceph/ceph/pull/25063), Alfredo Deza)
-   ceph-volume process.call with stdin in Python 3 fix
    ([issue#24993](http://tracker.ceph.com/issues/24993),
    [pr#23141](https://github.com/ceph/ceph/pull/23141), Alfredo Deza)
-   ceph-volume: provide a nice errror message when missing ceph.conf
    ([pr#22828](https://github.com/ceph/ceph/pull/22828), Andrew Schoen)
-   ceph-volume: PVolumes.get() should return one PV when using name or
    uuid ([issue#24784](http://tracker.ceph.com/issues/24784),
    [pr#23234](https://github.com/ceph/ceph/pull/23234), Andrew Schoen)
-   ceph-volume: refuse to zap mapper devices
    ([issue#24504](http://tracker.ceph.com/issues/24504),
    [pr#22764](https://github.com/ceph/ceph/pull/22764), Andrew Schoen)
-   ceph-volume: reject devices that have existing GPT headers
    ([issue#27062](http://tracker.ceph.com/issues/27062),
    [pr#25098](https://github.com/ceph/ceph/pull/25098), Andrew Schoen)
-   ceph-volume: remove iteritems instances
    ([issue#38299](http://tracker.ceph.com/issues/38299),
    [pr#26403](https://github.com/ceph/ceph/pull/26403), Jan Fajerski)
-   ceph-volume: remove LVs when using zap \--destroy
    ([pr#25093](https://github.com/ceph/ceph/pull/25093), Alfredo Deza)
-   ceph-volume remove version reporting from help menu
    ([issue#36386](http://tracker.ceph.com/issues/36386),
    [pr#24531](https://github.com/ceph/ceph/pull/24531), Alfredo Deza)
-   ceph-volume: rename Device property valid to available
    ([issue#36701](http://tracker.ceph.com/issues/36701),
    [pr#25007](https://github.com/ceph/ceph/pull/25007), Jan Fajerski)
-   ceph-volume: replace testinfra command with py.test
    ([issue#38568](http://tracker.ceph.com/issues/38568),
    [pr#26739](https://github.com/ceph/ceph/pull/26739), Alfredo Deza)
-   ceph-volume: Restore SELinux context
    ([pr#23278](https://github.com/ceph/ceph/pull/23278), Boris Ranto)
-   ceph-volume: revert partition as disk
    ([issue#37506](http://tracker.ceph.com/issues/37506),
    [pr#25390](https://github.com/ceph/ceph/pull/25390), Jan Fajerski)
-   ceph-volume: run tests without waiting on ceph repos
    ([pr#23697](https://github.com/ceph/ceph/pull/23697), Andrew Schoen)
-   ceph-volume: set number of osd ports in the tests
    ([pr#26753](https://github.com/ceph/ceph/pull/26753), Andrew Schoen)
-   ceph-volume: set permissions right before prime-osd-dir
    ([issue#37486](http://tracker.ceph.com/issues/37486),
    [pr#25477](https://github.com/ceph/ceph/pull/25477), Andrew Schoen,
    Alfredo Deza)
-   ceph-volume: [simple scan]{.title-ref} will now scan all running
    ceph-disk OSDs ([pr#26826](https://github.com/ceph/ceph/pull/26826),
    Andrew Schoen)
-   ceph-volume: skip processing devices that don\'t exist when scanning
    system disks ([issue#36247](http://tracker.ceph.com/issues/36247),
    [pr#24372](https://github.com/ceph/ceph/pull/24372), Alfredo Deza)
-   ceph-volume: sort and align [lvm list]{.title-ref} output
    ([pr#21812](https://github.com/ceph/ceph/pull/21812), Theofilos
    Mouratidis)
-   ceph-volume systemd import main so console_scripts work for
    executable ([issue#36648](http://tracker.ceph.com/issues/36648),
    [pr#24840](https://github.com/ceph/ceph/pull/24840), Alfredo Deza)
-   ceph-volume tests destroy osds on monitor hosts
    ([pr#22437](https://github.com/ceph/ceph/pull/22437), Alfredo Deza)
-   ceph-volume tests do not include admin keyring in OSD nodes
    ([issue#24417](http://tracker.ceph.com/issues/24417),
    [pr#22399](https://github.com/ceph/ceph/pull/22399), Alfredo Deza)
-   ceph-volume tests/functional add mgrs daemons to lvm tests
    ([issue#26879](http://tracker.ceph.com/issues/26879),
    [pr#23489](https://github.com/ceph/ceph/pull/23489), Alfredo Deza)
-   ceph-volume tests.functional add notario dep for ceph-ansible
    ([pr#22116](https://github.com/ceph/ceph/pull/22116), Alfredo Deza)
-   ceph-volume tests/functional declare ceph-ansible roles instead of
    importing them ([issue#37805](http://tracker.ceph.com/issues/37805),
    [pr#25820](https://github.com/ceph/ceph/pull/25820), Alfredo Deza)
-   ceph-volume tests.functional fix typo when stopping osd.0 in
    filestore ([issue#37675](http://tracker.ceph.com/issues/37675),
    [pr#25594](https://github.com/ceph/ceph/pull/25594), Alfredo Deza)
-   ceph-volume: tests.functional inherit SSH_ARGS from ansible
    ([issue#34311](http://tracker.ceph.com/issues/34311),
    [pr#23788](https://github.com/ceph/ceph/pull/23788), Alfredo Deza)
-   ceph-volume tests/functional run lvm list after OSD provisioning
    ([issue#24961](http://tracker.ceph.com/issues/24961),
    [pr#23116](https://github.com/ceph/ceph/pull/23116), Alfredo Deza)
-   ceph-volume tests/functional use Ansible 2.6
    ([pr#23182](https://github.com/ceph/ceph/pull/23182), Alfredo Deza)
-   ceph-volume tests install ceph-ansible\'s requirements.txt
    dependencies ([issue#36672](http://tracker.ceph.com/issues/36672),
    [pr#24881](https://github.com/ceph/ceph/pull/24881), Alfredo Deza)
-   ceph-volume tests patch \_\_release\_\_ to mimic always for stdin
    keys ([pr#23398](https://github.com/ceph/ceph/pull/23398), Alfredo
    Deza)
-   ceph-volume tests.systemd update imports for systemd module
    ([issue#36704](http://tracker.ceph.com/issues/36704),
    [pr#24937](https://github.com/ceph/ceph/pull/24937), Alfredo Deza)
-   ceph-volume: test with multiple NVME drives
    ([issue#37409](http://tracker.ceph.com/issues/37409),
    [pr#25354](https://github.com/ceph/ceph/pull/25354), Andrew Schoen)
-   ceph-volume: unmount lvs correctly before zapping
    ([issue#24796](http://tracker.ceph.com/issues/24796),
    [pr#23117](https://github.com/ceph/ceph/pull/23117), Andrew Schoen)
-   ceph-volume: update testing playbook \'deploy.yml\'
    ([pr#26397](https://github.com/ceph/ceph/pull/26397), Guillaume
    Abrioux)
-   ceph-volume: update version of ansible to 2.6.x for simple tests
    ([pr#23263](https://github.com/ceph/ceph/pull/23263), Andrew Schoen)
-   ceph-volume: use console_scripts
    ([issue#36601](http://tracker.ceph.com/issues/36601),
    [pr#24773](https://github.com/ceph/ceph/pull/24773), Mehdi Abaakouk)
-   ceph-volume: use our own testinfra suite for functional testing
    ([pr#26685](https://github.com/ceph/ceph/pull/26685), Andrew Schoen)
-   ceph-volume util.encryption don\'t push stderr to terminal
    ([issue#36246](http://tracker.ceph.com/issues/36246),
    [pr#24399](https://github.com/ceph/ceph/pull/24399), Alfredo Deza)
-   ceph-volume util.encryption robust blkid+lsblk detection of lockbox
    ([pr#24977](https://github.com/ceph/ceph/pull/24977), Alfredo Deza)
-   ceph-volume zap devices associated with an OSD ID and/or OSD FSID
    ([pr#25429](https://github.com/ceph/ceph/pull/25429), Alfredo Deza)
-   ceph-volume zap: improve zapping to remove all partitions and all
    LVs, encrypted or not
    ([issue#37449](http://tracker.ceph.com/issues/37449),
    [pr#25330](https://github.com/ceph/ceph/pull/25330), Alfredo Deza)
-   cleanup: Clean up warnings
    ([pr#23919](https://github.com/ceph/ceph/pull/23919), Adam C.
    Emerson)
-   cli: dump osd-fsid as part of osd find \<id\>
    ([pr#26015](https://github.com/ceph/ceph/pull/26015), Noah Watkins)
-   cmake: add \"add_npm_command()\" command
    ([pr#22636](https://github.com/ceph/ceph/pull/22636), Kefu Chai)
-   cmake: Add cls_opt for vstart target
    ([pr#22538](https://github.com/ceph/ceph/pull/22538), Ali Maredia)
-   cmake: add dpdk::dpdk if dpdk is built or found
    ([issue#24948](http://tracker.ceph.com/issues/24948),
    [pr#23620](https://github.com/ceph/ceph/pull/23620), Nathan Cutler,
    Kefu Chai)
-   cmake: add option WITH_LIBRADOSSTRIPER
    ([pr#23732](https://github.com/ceph/ceph/pull/23732), Kefu Chai)
-   cmake: allow setting of the CTest timeout during building
    ([pr#22800](https://github.com/ceph/ceph/pull/22800), Willem Jan
    Withagen)
-   cmake: always prefer local symbols
    ([issue#25154](http://tracker.ceph.com/issues/25154),
    [pr#23320](https://github.com/ceph/ceph/pull/23320), Kefu Chai)
-   cmake: always turn off bjam debugging output
    ([pr#22204](https://github.com/ceph/ceph/pull/22204), Kefu Chai)
-   cmake: bump up the required boost version to 1.67
    ([pr#22392](https://github.com/ceph/ceph/pull/22392), Kefu Chai)
-   cmake: bump up the required fmt version
    ([pr#23283](https://github.com/ceph/ceph/pull/23283), Kefu Chai)
-   cmake: cleanups
    ([pr#23166](https://github.com/ceph/ceph/pull/23166), Kefu Chai)
-   cmake: cleanups
    ([pr#23279](https://github.com/ceph/ceph/pull/23279), Kefu Chai)
-   cmake: cleanups
    ([pr#23300](https://github.com/ceph/ceph/pull/23300), Kefu Chai)
-   cmake,crimson/net: add keepalive support, and enable
    unittest_seastar_messenger in \"make check\"
    ([pr#23642](https://github.com/ceph/ceph/pull/23642), Kefu Chai)
-   cmake: detect armv8 crc and crypto feature using
    CHECK_C_COMPILER_FLAG
    ([issue#17516](http://tracker.ceph.com/issues/17516),
    [pr#24168](https://github.com/ceph/ceph/pull/24168), Kefu Chai)
-   cmake: disable -Werror-stringop-truncation for rocksdb
    ([pr#22591](https://github.com/ceph/ceph/pull/22591), Kefu Chai)
-   cmake: do not check for aligned_alloc() anymore
    ([issue#23653](http://tracker.ceph.com/issues/23653),
    [pr#22046](https://github.com/ceph/ceph/pull/22046), Kefu Chai)
-   cmake: do not depend on \${DPDK_LIBRARIES} if not using bundled dpdk
    ([issue#24449](http://tracker.ceph.com/issues/24449),
    [pr#22938](https://github.com/ceph/ceph/pull/22938), Kefu Chai)
-   cmake: do not install [hello]{.title-ref} demo module
    ([pr#21886](https://github.com/ceph/ceph/pull/21886), John Spray)
-   cmake: do not link against common_crc_aarch64
    ([pr#23366](https://github.com/ceph/ceph/pull/23366), Kefu Chai)
-   cmake: do not pass -B{symbolic,symbolic-functions} to linker on
    FreeBSD ([pr#24920](https://github.com/ceph/ceph/pull/24920), Willem
    Jan Withagen)
-   cmake: do not pass unnecessary param to setup.py
    ([pr#25186](https://github.com/ceph/ceph/pull/25186), Kefu Chai)
-   cmake: do not use Findfmt.cmake for checking libfmt-dev
    ([pr#23390](https://github.com/ceph/ceph/pull/23390), Kefu Chai)
-   cmake: do not use plain target_link_libraries(rgw_a \...)
    ([pr#24515](https://github.com/ceph/ceph/pull/24515), Kefu Chai)
-   cmake: enable RTTI for both debug and release RocksDB builds
    ([pr#22286](https://github.com/ceph/ceph/pull/22286), Igor Fedotov)
-   cmake: find a python2 interpreter for gtest-parallel
    ([pr#22931](https://github.com/ceph/ceph/pull/22931), Kefu Chai)
-   cmake: find liboath using the correct name
    ([pr#22430](https://github.com/ceph/ceph/pull/22430), Kefu Chai)
-   cmake: fix a cmake error when with -DALLOCATOR=jemalloc
    ([pr#23380](https://github.com/ceph/ceph/pull/23380), Jianpeng Ma)
-   cmake: fix build WITH_SYSTEM_BOOST=ON
    ([pr#23510](https://github.com/ceph/ceph/pull/23510), Kefu Chai)
-   cmake: fix compilation with distcc and other compiler wrappers
    ([pr#24605](https://github.com/ceph/ceph/pull/24605), Alexey
    Sheplyakov, Kefu Chai)
-   cmake: fix cython target in test/CMakeFile.txt
    ([pr#22295](https://github.com/ceph/ceph/pull/22295), Jan Fajerski)
-   cmake: fix Debug build [WITH_SEASTAR=ON]{.title-ref}
    ([pr#23567](https://github.com/ceph/ceph/pull/23567), Kefu Chai)
-   cmake: fixes to enable WITH_ASAN with clang and GCC
    ([pr#24692](https://github.com/ceph/ceph/pull/24692), Kefu Chai)
-   cmake: fix find system rockdb
    ([pr#22439](https://github.com/ceph/ceph/pull/22439), Alexey
    Shabalin)
-   cmake: fix std::filesystem detection and extract sanitizer detection
    into its own module
    ([pr#23384](https://github.com/ceph/ceph/pull/23384), Kefu Chai)
-   cmake: fix syntax error of set()
    ([pr#26582](https://github.com/ceph/ceph/pull/26582), Kefu Chai)
-   cmake: fix the build WITH_DPDK=ON
    ([pr#23650](https://github.com/ceph/ceph/pull/23650), Kefu Chai,
    Casey Bodley)
-   cmake: fix version matching for Findfmt
    ([pr#23996](https://github.com/ceph/ceph/pull/23996), Mohamad Gebai)
-   cmake: fix \"WITH_STATIC_LIBSTDCXX\"
    ([pr#22990](https://github.com/ceph/ceph/pull/22990), Kefu Chai)
-   cmake: let rbd_api depend on librbd-tp
    ([pr#25641](https://github.com/ceph/ceph/pull/25641), Kefu Chai)
-   cmake: link against gtest in a better way
    ([pr#23628](https://github.com/ceph/ceph/pull/23628), Kefu Chai)
-   cmake: link ceph-osd with common statically
    ([pr#22720](https://github.com/ceph/ceph/pull/22720), Radoslaw
    Zarzynski)
-   cmake: link compressor plugins against lib the modern way
    ([pr#23852](https://github.com/ceph/ceph/pull/23852), Kefu Chai)
-   cmake: make -DWITH_MGR=OFF work
    ([pr#22077](https://github.com/ceph/ceph/pull/22077), Jianpeng Ma)
-   cmake: Make the tests for finding Filesystem with more serious
    functions ([pr#26316](https://github.com/ceph/ceph/pull/26316),
    Willem Jan Withagen)
-   cmake: modularize src/perfglue
    ([pr#23254](https://github.com/ceph/ceph/pull/23254), Kefu Chai)
-   cmake: move ceph-osdomap-tool, ceph-monstore-tool out of ceph-test
    ([pr#19964](https://github.com/ceph/ceph/pull/19964), runsisi)
-   cmake: move crypto_plugins target
    ([pr#21891](https://github.com/ceph/ceph/pull/21891), Casey Bodley)
-   cmake: no libradosstriper headers if WITH_LIBRADOSSTRIPER=OFF
    ([issue#35922](http://tracker.ceph.com/issues/35922),
    [pr#24029](https://github.com/ceph/ceph/pull/24029), Nathan Cutler,
    Kefu Chai)
-   cmake: no need to add \"-D\" before definitions
    ([pr#23795](https://github.com/ceph/ceph/pull/23795), Kefu Chai)
-   cmake: oath lives in liboath
    ([pr#22494](https://github.com/ceph/ceph/pull/22494), Willem Jan
    Withagen)
-   cmake: only build extra boost libraries only if WITH_SEASTAR
    ([pr#22521](https://github.com/ceph/ceph/pull/22521), Kefu Chai)
-   cmake: remove checking for GCC 5.1
    ([pr#24477](https://github.com/ceph/ceph/pull/24477), Kefu Chai)
-   cmake: remove deleted rgw_request.cc from CMakeLists.txt
    ([pr#22186](https://github.com/ceph/ceph/pull/22186), Casey Bodley)
-   cmake: Remove embedded \'cephd\' code
    ([pr#21940](https://github.com/ceph/ceph/pull/21940), Dan Mick)
-   cmake: remove workarounds for supporting cmake 2.x
    ([pr#22912](https://github.com/ceph/ceph/pull/22912), Kefu Chai)
-   cmake: rgw_common should depend on tracing headers
    ([pr#22367](https://github.com/ceph/ceph/pull/22367), Kefu Chai)
-   cmake: rocksdb related cleanup
    ([pr#23441](https://github.com/ceph/ceph/pull/23441), Kefu Chai)
-   cmake: should link against libatomic if libcxx/libstdc++ does not
    off... ([pr#22952](https://github.com/ceph/ceph/pull/22952), Kefu
    Chai)
-   cmake: update fio version from 3.5 to 540e235dcd276e63c57
    ([pr#22019](https://github.com/ceph/ceph/pull/22019), Jianpeng Ma)
-   cmake: use \$CMAKE_BINARY_DIR for default \$CEPH_BUILD_VIRTUALENV
    ([issue#36737](http://tracker.ceph.com/issues/36737),
    [pr#26091](https://github.com/ceph/ceph/pull/26091), Kefu Chai)
-   cmake: use javac -h for creating JNI native headers
    ([issue#24012](http://tracker.ceph.com/issues/24012),
    [pr#21822](https://github.com/ceph/ceph/pull/21822), Kefu Chai)
-   cmake: use OpenSSL::Crypto instead of OPENSSL_LIBRARIES
    ([pr#24368](https://github.com/ceph/ceph/pull/24368), Kefu Chai)
-   cmake: vstart target can build WITH_CEPHFS/RBD/MGR=OFF
    ([pr#25204](https://github.com/ceph/ceph/pull/25204), Casey Bodley)
-   common: add adaptor for seastar::temporary_buffer
    ([pr#22454](https://github.com/ceph/ceph/pull/22454), Kefu Chai,
    Casey Bodley)
-   common: add a generic async Completion for use with boost::asio
    ([pr#21914](https://github.com/ceph/ceph/pull/21914), Casey Bodley)
-   common: add lockless [md_config_t]{.title-ref}
    ([pr#22710](https://github.com/ceph/ceph/pull/22710), Kefu Chai)
-   common: async/dpdk: when enable dpdk, multiple message queue defect
    ([pr#25404](https://github.com/ceph/ceph/pull/25404),
    zhangyongsheng)
-   common: auth/cephx: minor code cleanup
    ([pr#21155](https://github.com/ceph/ceph/pull/21155), runsisi)
-   common: auth, common: cleanups
    ([pr#26383](https://github.com/ceph/ceph/pull/26383), Kefu Chai)
-   common: auth,common: use ceph::mutex instead of LockMutex
    ([pr#24263](https://github.com/ceph/ceph/pull/24263), Kefu Chai)
-   common: avoid the overhead of `ANNOTATE_HAPPENS_*` in NDEBUG builds
    ([pr#25129](https://github.com/ceph/ceph/pull/25129), Radoslaw
    Zarzynski)
-   common: be more informative if set PID-file fails
    ([pr#23647](https://github.com/ceph/ceph/pull/23647), Willem Jan
    Withagen)
-   common: blkdev: Rework API and add FreeBSD support
    ([pr#24658](https://github.com/ceph/ceph/pull/24658), Alan Somers)
-   common: buffer: mark the iterator traits \"public\"
    ([pr#25409](https://github.com/ceph/ceph/pull/25409), Kefu Chai)
-   common: calculate stddev on the fly
    ([pr#21461](https://github.com/ceph/ceph/pull/21461), Yao Zongyou)
-   common: ceph.in: use correct module for cmd flags
    ([pr#26454](https://github.com/ceph/ceph/pull/26454), Patrick
    Donnelly)
-   common: ceph-volume add device_id to inventory listing
    ([pr#25201](https://github.com/ceph/ceph/pull/25201), Jan Fajerski)
-   common: changes to address FTBFS on fc30
    ([pr#26301](https://github.com/ceph/ceph/pull/26301), Kefu Chai)
-   common: common/admin_socket: add new api
    unregister_commands(AdminSocketHook ...
    ([pr#21718](https://github.com/ceph/ceph/pull/21718), Jianpeng Ma)
-   common: common,auth,crimson: add logging to crimson
    ([pr#23957](https://github.com/ceph/ceph/pull/23957), Kefu Chai)
-   common: common/buffer: fix compiler bug when enable DEBUG_BUFFER
    ([pr#25848](https://github.com/ceph/ceph/pull/25848), Jianpeng Ma)
-   common: common/buffer: remove repeated condtion-check
    ([pr#25420](https://github.com/ceph/ceph/pull/25420), Jianpeng Ma)
-   common: common/config: add ConfigProxy for crimson
    ([pr#23074](https://github.com/ceph/ceph/pull/23074), Kefu Chai)
-   common: common/config: fix the lock in ConfigProxy::diff()
    ([pr#23276](https://github.com/ceph/ceph/pull/23276), Kefu Chai)
-   common: common/config_values: friend md_config_impl\<\>
    ([pr#23020](https://github.com/ceph/ceph/pull/23020), Mykola Golub,
    Kefu Chai)
-   common: common: drop the unused methods from SharedLRU
    ([pr#26224](https://github.com/ceph/ceph/pull/26224), Radoslaw
    Zarzynski)
-   common: common/KeyValueDB: Get rid of validate parameter
    ([pr#25377](https://github.com/ceph/ceph/pull/25377), Adam Kupczyk)
-   common: common/numa: Add shim routines for NUMA on FreeBSD
    ([pr#25920](https://github.com/ceph/ceph/pull/25920), Willem Jan
    Withagen)
-   common: common, osd: set mclock priority as 1 by default
    ([pr#26022](https://github.com/ceph/ceph/pull/26022), Abhishek
    Lekshmanan)
-   common: common/random_cache: remove unused RandomCache
    ([pr#26253](https://github.com/ceph/ceph/pull/26253), Kefu Chai)
-   common: common/shared_cache: add lockless SharedLRU
    ([pr#22736](https://github.com/ceph/ceph/pull/22736), Kefu Chai)
-   common: common/shared_cache: bumps it to the front of the LRU if key
    existed ([pr#25370](https://github.com/ceph/ceph/pull/25370),
    Jianpeng Ma)
-   common: common/shared_cache: fix racing issues
    ([pr#25150](https://github.com/ceph/ceph/pull/25150), Jianpeng Ma)
-   common: common/util: pass real hostname when running in
    kubernetes/rook container
    ([pr#23798](https://github.com/ceph/ceph/pull/23798), Sage Weil)
-   common: complete all throttle blockers when we set average or max to
    0 ([issue#36715](http://tracker.ceph.com/issues/36715),
    [pr#24965](https://github.com/ceph/ceph/pull/24965), Dongsheng Yang)
-   common,core: msg/async: clean up local buffers on dispatch
    ([issue#35987](http://tracker.ceph.com/issues/35987),
    [pr#24111](https://github.com/ceph/ceph/pull/24111), Greg Farnum)
-   common,core,tests: qa/tests: update links for centos latest to point
    to 7.5 ([pr#22923](https://github.com/ceph/ceph/pull/22923), Vasu
    Kulkarni)
-   common/crc/aarch64: Added cpu feature pmull and make aarch64
    specific... ([pr#22178](https://github.com/ceph/ceph/pull/22178),
    Adam Kupczyk)
-   common: crimson/common: write configs synchronously on shard.0
    ([pr#23284](https://github.com/ceph/ceph/pull/23284), Kefu Chai)
-   common,crimson: port perfcounters to seastar
    ([pr#24141](https://github.com/ceph/ceph/pull/24141), chunmei Liu)
-   common: crypto: QAT based Encryption for RGW
    ([pr#19386](https://github.com/ceph/ceph/pull/19386), Ganesh Maharaj
    Mahalingam)
-   common: crypto: use ceph_assert_always for assertions
    ([pr#23654](https://github.com/ceph/ceph/pull/23654), Casey Bodley)
-   common: define BOOST_COROUTINES_NO_DEPRECATION_WARNING if not yet
    ([pr#26502](https://github.com/ceph/ceph/pull/26502), Kefu Chai)
-   common: drop allocation tracking from bufferlist
    ([pr#25454](https://github.com/ceph/ceph/pull/25454), Radoslaw
    Zarzynski)
-   common: drop append_buffer from bufferlist. Use simple carriage
    instead ([pr#25077](https://github.com/ceph/ceph/pull/25077),
    Radoslaw Zarzynski)
-   common: drop [at_buffer](){head,tail} from buffer::ptr
    ([pr#25422](https://github.com/ceph/ceph/pull/25422), Radoslaw
    Zarzynski)
-   common: drop/mark-as-final getters of buffer::raw for palign
    ([pr#24087](https://github.com/ceph/ceph/pull/24087), Radoslaw
    Zarzynski)
-   common: drop static_assert.h as it looks unused
    ([pr#22743](https://github.com/ceph/ceph/pull/22743), Radoslaw
    Zarzynski)
-   common: drop the unused buffer::raw_mmap_pages
    ([pr#24040](https://github.com/ceph/ceph/pull/24040), Radoslaw
    Zarzynski)
-   common: drop the unused zero-copy facilities in ceph::bufferlist
    ([pr#24031](https://github.com/ceph/ceph/pull/24031), Radoslaw
    Zarzynski)
-   common: drop unused get_max_pipe_size() in buffer.cc
    ([pr#25432](https://github.com/ceph/ceph/pull/25432), Radoslaw
    Zarzynski)
-   common: ec: lrc doesn\'t depend on crosstalks between bufferlists
    anymore ([pr#25595](https://github.com/ceph/ceph/pull/25595),
    Radoslaw Zarzynski)
-   common: expand meta in parse_argv()
    ([pr#23474](https://github.com/ceph/ceph/pull/23474), Kefu Chai)
-   common: fix access and add name for the token bucket throttle
    ([pr#25372](https://github.com/ceph/ceph/pull/25372), Shiyang Ruan)
-   common: Fix Alpine compatability for TEMP_FAILURE_RETRY and
    ACCESSPERMS ([pr#24813](https://github.com/ceph/ceph/pull/24813),
    Willem Jan Withagen)
-   common: fix a racing in
    PerfCounters::perf_counter_data_any_d::read_avg
    ([issue#25211](http://tracker.ceph.com/issues/25211),
    [pr#23362](https://github.com/ceph/ceph/pull/23362), ludehp)
-   common: fix for broken rbdmap parameter parsing
    ([pr#24446](https://github.com/ceph/ceph/pull/24446), Marc
    Schoechlin)
-   common: fix missing include boost/noncopyable.hpp
    ([pr#24278](https://github.com/ceph/ceph/pull/24278), Willem Jan
    Withagen)
-   common: fix typo in rados bench write JSON output
    ([issue#24199](http://tracker.ceph.com/issues/24199),
    [pr#22112](https://github.com/ceph/ceph/pull/22112), Sandor
    Zeestraten)
-   common: fix typos in BackoffThrottle
    ([pr#24691](https://github.com/ceph/ceph/pull/24691), Shiyang Ruan)
-   common: Formatters: improve precision of double numbers
    ([pr#25745](https://github.com/ceph/ceph/pull/25745), Коренберг
    Марк)
-   common: .gitignore: Ignore .idea directory
    ([pr#24237](https://github.com/ceph/ceph/pull/24237), Volker Theile)
-   common: hint bufferlist\'s buffer_track_c_str accordingly
    ([pr#25424](https://github.com/ceph/ceph/pull/25424), Radoslaw
    Zarzynski)
-   common: hypercombined bufferlist
    ([pr#24882](https://github.com/ceph/ceph/pull/24882), Radoslaw
    Zarzynski)
-   common: include/compat.h: make pthread_get_name_np work when
    available ([pr#23641](https://github.com/ceph/ceph/pull/23641),
    Willem Jan Withagen)
-   common: include include/types.h early, otherwise Clang will error
    ([pr#22493](https://github.com/ceph/ceph/pull/22493), Willem Jan
    Withagen)
-   common: include/types: move operator\<\< into the proper namespace
    ([pr#23767](https://github.com/ceph/ceph/pull/23767), Kefu Chai)
-   common: include/types: space between number and units
    ([pr#22063](https://github.com/ceph/ceph/pull/22063), Sage Weil)
-   common: librados,rpm,deb: various fixes to address librados3
    transition and cleanups in librados
    ([pr#24896](https://github.com/ceph/ceph/pull/24896), Kefu Chai)
-   common: make CEPH_BUFFER_ALLOC_UNIT known at compile-time
    ([pr#26259](https://github.com/ceph/ceph/pull/26259), Radoslaw
    Zarzynski)
-   common: mark BlkDev::serial() const to match with its declaration
    ([pr#24702](https://github.com/ceph/ceph/pull/24702), Willem Jan
    Withagen)
-   common: messages: define HEAD_VERSION and COMPAT_VERSION inlined
    ([pr#23623](https://github.com/ceph/ceph/pull/23623), Kefu Chai)
-   common,mgr: mgr/MgrClient: make some noise for a user if no mgr
    daemon is running
    ([pr#23492](https://github.com/ceph/ceph/pull/23492), Sage Weil)
-   common: mon/MonClient: set configs via finisher
    ([issue#24118](http://tracker.ceph.com/issues/24118),
    [pr#21984](https://github.com/ceph/ceph/pull/21984), Sage Weil)
-   common: msg/async: fix FTBFS of dpdk
    ([pr#23168](https://github.com/ceph/ceph/pull/23168), Kefu Chai)
-   common: msg/async: Skip the duplicated processing of the same link
    ([pr#20952](https://github.com/ceph/ceph/pull/20952), shangfufei)
-   common: msg/msg_types.h: do not cast [ceph_entity_name]{.title-ref}
    to [entity_name_t]{.title-ref} for printing
    ([pr#26315](https://github.com/ceph/ceph/pull/26315), Kefu Chai)
-   common: msgr/async/rdma: Return from poll system call with EINTR
    should be retried
    ([pr#25138](https://github.com/ceph/ceph/pull/25138), Stig Telfer)
-   common: Mutex -\> ceph::mutex
    ([issue#12614](http://tracker.ceph.com/issues/12614),
    [pr#25105](https://github.com/ceph/ceph/pull/25105), Kefu Chai, Sage
    Weil)
-   common: optimize reference counting in bufferlist
    ([pr#25082](https://github.com/ceph/ceph/pull/25082), Radoslaw
    Zarzynski)
-   common: OpTracker doesn\'t visit TrackedOp when nref == 0
    ([issue#24037](http://tracker.ceph.com/issues/24037),
    [pr#22156](https://github.com/ceph/ceph/pull/22156), Radoslaw
    Zarzynski)
-   common: os/filestore: fix throttle configurations
    ([pr#21926](https://github.com/ceph/ceph/pull/21926), Li Wang)
-   common,performance: auth,common: add lockless auth
    ([pr#23591](https://github.com/ceph/ceph/pull/23591), Kefu Chai)
-   common,performance: common/assert: mark assert helpers with
    \[\[gnu::cold\]\]
    ([pr#23326](https://github.com/ceph/ceph/pull/23326), Kefu Chai)
-   common,performance: compressor: add QAT support
    ([pr#19714](https://github.com/ceph/ceph/pull/19714), Qiaowei Ren)
-   common,performance: denc: fix internal fragmentation when decoding
    ptr in bl ([pr#25264](https://github.com/ceph/ceph/pull/25264), Kefu
    Chai)
-   common,rbd: misc: mark constructors as explicit
    ([pr#21637](https://github.com/ceph/ceph/pull/21637), Danny Al-Gaaf)
-   common: reinit StackStringStream on clear
    ([pr#25751](https://github.com/ceph/ceph/pull/25751), Patrick
    Donnelly)
-   common: reintroduce async SharedMutex
    ([issue#24124](http://tracker.ceph.com/issues/24124),
    [pr#22698](https://github.com/ceph/ceph/pull/22698), Casey Bodley)
-   common: Reverse deleted include
    ([pr#23838](https://github.com/ceph/ceph/pull/23838), Willem Jan
    Withagen)
-   common: Revert \"common: add an async SharedMutex\"
    ([issue#24124](http://tracker.ceph.com/issues/24124),
    [pr#21986](https://github.com/ceph/ceph/pull/21986), Casey Bodley)
-   common,rgw: cls/rbd: init local var with known value
    ([pr#25588](https://github.com/ceph/ceph/pull/25588), Kefu Chai)
-   common,tests: run-standalone.sh: Need double-quotes to handle \| in
    core_pattern on all distributions
    ([issue#38325](http://tracker.ceph.com/issues/38325),
    [pr#26436](https://github.com/ceph/ceph/pull/26436), David Zafman)
-   common,tests: test_shared_cache: fix memory leak
    ([pr#25215](https://github.com/ceph/ceph/pull/25215), Jianpeng Ma)
-   common: vstart: do not attempt to re-initialize dashboard for
    existing cluster
    ([pr#23261](https://github.com/ceph/ceph/pull/23261), Jason
    Dillaman)
-   core: Add support for osd_delete_sleep configuration value
    ([issue#36474](http://tracker.ceph.com/issues/36474),
    [pr#24749](https://github.com/ceph/ceph/pull/24749), David Zafman)
-   core: auth: drop the RWLock in AuthClientHandler
    ([pr#23699](https://github.com/ceph/ceph/pull/23699), Kefu Chai)
-   core: auth/krb: Fix Kerberos build warnings
    ([pr#25639](https://github.com/ceph/ceph/pull/25639), Daniel
    Oliveira)
-   core: build: disable kerberos for nautilus
    ([pr#26258](https://github.com/ceph/ceph/pull/26258), Sage Weil)
-   core: ceph_argparse: fix \--verbose
    ([pr#25961](https://github.com/ceph/ceph/pull/25961), Patrick
    Nawracay)
-   core: ceph.in: friendlier message on EPERM
    ([issue#25172](http://tracker.ceph.com/issues/25172),
    [pr#23330](https://github.com/ceph/ceph/pull/23330), John Spray)
-   core: ceph.in: write bytes to stdout in raw_write()
    ([pr#25280](https://github.com/ceph/ceph/pull/25280), Kefu Chai)
-   core: ceph_test_rados_api_misc: remove obsolete
    LibRadosMiscPool.PoolCreationRace
    ([issue#24150](http://tracker.ceph.com/issues/24150),
    [pr#22042](https://github.com/ceph/ceph/pull/22042), Sage Weil)
-   core: Clang misses \<optional\> include
    ([pr#23768](https://github.com/ceph/ceph/pull/23768), Willem Jan
    Withagen)
-   core: common/blkdev.h: use std::string
    ([pr#25783](https://github.com/ceph/ceph/pull/25783), Neha Ojha)
-   core: common/options: remove unused ms async affinity options
    ([pr#26099](https://github.com/ceph/ceph/pull/26099), Josh Durgin)
-   core: common/util.cc: add CONTAINER_NAME processing for metadata
    ([pr#25383](https://github.com/ceph/ceph/pull/25383), Dan Mick)
-   core: compressor: building error for QAT decompress
    ([pr#22609](https://github.com/ceph/ceph/pull/22609), Qiaowei Ren)
-   core: crush, osd: handle multiple parents properly when applying pg
    upmaps ([issue#23921](http://tracker.ceph.com/issues/23921),
    [pr#21815](https://github.com/ceph/ceph/pull/21815), xiexingguo)
-   core: erasure-code: add clay codes
    ([issue#19278](http://tracker.ceph.com/issues/19278),
    [pr#24291](https://github.com/ceph/ceph/pull/24291), Myna V, Sage
    Weil)
-   core: erasure-code: fixes alignment issue when clay code is used
    with jerasure, cauchy_orig
    ([pr#24586](https://github.com/ceph/ceph/pull/24586), Myna)
-   core: global/signal_handler.cc: report assert_file as correct name
    ([pr#23738](https://github.com/ceph/ceph/pull/23738), Dan Mick)
-   core: include/rados: clarify which flags go where for copy_from
    ([pr#24497](https://github.com/ceph/ceph/pull/24497), Ilya Dryomov)
-   core: include/rados.h: hide CEPH_OSDMAP_PGLOG_HARDLIMIT from ceph -s
    ([pr#25887](https://github.com/ceph/ceph/pull/25887), Neha Ojha)
-   core: kv/KeyValueDB: Move PriCache implementation to ShardedCache
    ([pr#25925](https://github.com/ceph/ceph/pull/25925), Mark Nelson)
-   core: kv/KeyValueDB: return const char\* from MergeOperator::name()
    ([issue#26875](http://tracker.ceph.com/issues/26875),
    [pr#23477](https://github.com/ceph/ceph/pull/23477), Sage Weil)
-   core: messages/MOSDPGScan: fix initialization of query_epoch
    ([pr#22408](https://github.com/ceph/ceph/pull/22408), wumingqiao)
-   core: mgr/balancer: add cmd to list all plans
    ([issue#37418](http://tracker.ceph.com/issues/37418),
    [pr#21937](https://github.com/ceph/ceph/pull/21937), Yang Honggang)
-   core: mgr/BaseMgrModule: drop GIL for ceph_send_command
    ([issue#38537](http://tracker.ceph.com/issues/38537),
    [pr#26723](https://github.com/ceph/ceph/pull/26723), Sage Weil)
-   core: mgr/MgrClient: Protect daemon_health_metrics
    ([issue#23352](http://tracker.ceph.com/issues/23352),
    [pr#23404](https://github.com/ceph/ceph/pull/23404), Kjetil
    Joergensen, Brad Hubbard)
-   core,mgr: mon/MgrMonitor: change \'unresponsive\' message to info
    level ([issue#24222](http://tracker.ceph.com/issues/24222),
    [pr#22158](https://github.com/ceph/ceph/pull/22158), Sage Weil)
-   core,mgr,rbd: mgr: generalize osd perf query and make counters
    accessible from modules
    ([pr#25114](https://github.com/ceph/ceph/pull/25114), Mykola Golub)
-   core,mgr,rbd: osd: support more dynamic perf query subkey types
    ([pr#25371](https://github.com/ceph/ceph/pull/25371), Mykola Golub)
-   core,mgr,rbd,rgw: rgw, common: Fixes SCA issues
    ([pr#22007](https://github.com/ceph/ceph/pull/22007), Danny Al-Gaaf)
-   core: mgr/smart: remove obsolete smart module
    ([pr#26411](https://github.com/ceph/ceph/pull/26411), Sage Weil)
-   core: mon/LogMonitor: call no_reply() on ignored log message
    ([pr#22098](https://github.com/ceph/ceph/pull/22098), Sage Weil)
-   core: mon/MonClient: avoid using magic number for the
    [MAuth::protocol]{.title-ref}
    ([pr#23747](https://github.com/ceph/ceph/pull/23747), Kefu Chai)
-   core: mon/MonClient: extract MonSub out
    ([pr#23688](https://github.com/ceph/ceph/pull/23688), Kefu Chai)
-   core: mon/MonClient: use scoped_guard instead of goto
    ([pr#24304](https://github.com/ceph/ceph/pull/24304), Kefu Chai)
-   core,mon: mon,osd: dump \"compression_algorithms\" in \"mon
    metadata\" ([issue#22420](http://tracker.ceph.com/issues/22420),
    [pr#21809](https://github.com/ceph/ceph/pull/21809), Kefu Chai,
    Casey Bodley)
-   core,mon: mon/OSDMonitor: no_reply on MOSDFailure messages
    ([issue#24322](http://tracker.ceph.com/issues/24322),
    [pr#22259](https://github.com/ceph/ceph/pull/22259), Sage Weil)
-   core,mon: mon/OSDMonitor: Warnings for expected_num_objects
    ([issue#24687](http://tracker.ceph.com/issues/24687),
    [pr#23072](https://github.com/ceph/ceph/pull/23072), Douglas Fuller)
-   core: mon/OSDMonitor: two \"ceph osd crush class rm\" fixes
    ([pr#24657](https://github.com/ceph/ceph/pull/24657), xie xingguo)
-   core: mon/PGMap: fix PGMapDigest decode
    ([pr#22066](https://github.com/ceph/ceph/pull/22066), Sage Weil)
-   core: mon/PGMap: include unknown PGs in \'pg ls\'
    ([pr#24032](https://github.com/ceph/ceph/pull/24032), Sage Weil)
-   core: msg/async: do not trigger RESETSESSION from connect fault
    during connection phase
    ([issue#36612](http://tracker.ceph.com/issues/36612),
    [pr#25343](https://github.com/ceph/ceph/pull/25343), Sage Weil)
-   core: msg/async/Event: clear time_events on shutdown
    ([issue#24162](http://tracker.ceph.com/issues/24162),
    [pr#22093](https://github.com/ceph/ceph/pull/22093), Sage Weil)
-   core: msg/async: fix banner_v1 check in ProtocolV2
    ([pr#26714](https://github.com/ceph/ceph/pull/26714), Yingxin Cheng)
-   core: msg/async: fix include in frames_v2.h
    ([pr#26711](https://github.com/ceph/ceph/pull/26711), Yingxin Cheng)
-   core: msg/async: fix is_queued() semantics
    ([pr#24693](https://github.com/ceph/ceph/pull/24693), Ilya Dryomov)
-   core: msg/async: keep connection alive only actually sending
    ([pr#24301](https://github.com/ceph/ceph/pull/24301), Haomai Wang,
    Kefu Chai)
-   core: os/bluestore: fix deep-scrub operation againest disk silent
    errors ([pr#23629](https://github.com/ceph/ceph/pull/23629),
    Xiaoguang Wang)
-   core: os/bluestore: fix flush_commit locking
    ([issue#21480](http://tracker.ceph.com/issues/21480),
    [pr#22083](https://github.com/ceph/ceph/pull/22083), Sage Weil)
-   core: OSD: add impl for filestore to get dbstatistics
    ([issue#24591](http://tracker.ceph.com/issues/24591),
    [pr#22633](https://github.com/ceph/ceph/pull/22633), lvshuhua)
-   core: osdc: Change \'bool budgeted\' to \'int budget\' to avoid
    recalculating ([pr#21242](https://github.com/ceph/ceph/pull/21242),
    Jianpeng Ma)
-   core: OSD: ceph-osd parent process need to restart log service after
    fork ([issue#24956](http://tracker.ceph.com/issues/24956),
    [pr#23090](https://github.com/ceph/ceph/pull/23090), redickwang)
-   core: osdc/Objecter: fix split vs reconnect race
    ([issue#22544](http://tracker.ceph.com/issues/22544),
    [pr#23850](https://github.com/ceph/ceph/pull/23850), Sage Weil)
-   core: osdc/Objecter: no need null pointer check for op-\>session
    anymore ([pr#25230](https://github.com/ceph/ceph/pull/25230),
    runsisi)
-   core: osdc/Objecter: possible race condition with connection reset
    ([issue#36183](http://tracker.ceph.com/issues/36183),
    [pr#24276](https://github.com/ceph/ceph/pull/24276), Jason Dillaman)
-   core: osdc: self-managed snapshot helper should catch decode
    exception ([issue#24000](http://tracker.ceph.com/issues/24000),
    [pr#21804](https://github.com/ceph/ceph/pull/21804), Jason Dillaman)
-   core: osd, librados: add unset-manifest op
    ([pr#21999](https://github.com/ceph/ceph/pull/21999), Myoungwon Oh)
-   core: osd,mds: make \'config rm \...\' idempotent
    ([issue#24408](http://tracker.ceph.com/issues/24408),
    [pr#22395](https://github.com/ceph/ceph/pull/22395), Sage Weil)
-   core: osd/mon: fix upgrades for pg log hard limit
    ([issue#36686](http://tracker.ceph.com/issues/36686),
    [pr#25816](https://github.com/ceph/ceph/pull/25816), Neha Ojha, Yuri
    Weinstein)
-   core: osd,mon: increase mon_max_pg_per_osd to 250
    ([pr#23251](https://github.com/ceph/ceph/pull/23251), Neha Ojha)
-   core: osd,mon,msg: use intrusive_ptr for holding Connection::priv
    ([issue#20924](http://tracker.ceph.com/issues/20924),
    [pr#22292](https://github.com/ceph/ceph/pull/22292), Kefu Chai)
-   core: osd/OSD: choose heartbeat peers more carefully
    ([pr#23487](https://github.com/ceph/ceph/pull/23487), xie xingguo)
-   core: osd/OSD: drop extra/wrong \*unregister_pg\*
    ([pr#21816](https://github.com/ceph/ceph/pull/21816), xiexingguo)
-   core: osd/OSDMap: be more aggressive when trying to balance
    ([issue#37940](http://tracker.ceph.com/issues/37940),
    [pr#26039](https://github.com/ceph/ceph/pull/26039), xie xingguo)
-   core: osd/OSDMap: drop local pool filter in calc_pg_upmaps
    ([pr#26605](https://github.com/ceph/ceph/pull/26605), xie xingguo)
-   core: osd/OSDMap: fix CEPHX_V2 osd requirement to nautilus, not
    mimic ([pr#23249](https://github.com/ceph/ceph/pull/23249), Sage
    Weil)
-   core: osd/OSDMap: fix upmap mis-killing for erasure-coded PGs
    ([pr#25365](https://github.com/ceph/ceph/pull/25365), ningtao, xie
    xingguo)
-   core: osd/OSDMap: potential access violation fix
    ([issue#37881](http://tracker.ceph.com/issues/37881),
    [pr#25930](https://github.com/ceph/ceph/pull/25930), xie xingguo)
-   core: osd/OSDMap: using std::vector::reserve to reduce memory
    reallocation ([pr#26478](https://github.com/ceph/ceph/pull/26478),
    xie xingguo)
-   core: osd/OSD: ping monitor if we are stuck at
    \_\_waiting_for_healthy\_\_
    ([pr#23958](https://github.com/ceph/ceph/pull/23958), xie xingguo)
-   core: osd/OSD: preallocate for \_get_pgs/\_get_pgids to avoid
    reallocate ([pr#25434](https://github.com/ceph/ceph/pull/25434),
    Jianpeng Ma)
-   core: osd/PG: async-recovery should respect historical missing
    objects ([pr#24004](https://github.com/ceph/ceph/pull/24004), xie
    xingguo)
-   core: osd/PG.cc: account for missing set irrespective of
    last_complete ([issue#37919](http://tracker.ceph.com/issues/37919),
    [pr#26175](https://github.com/ceph/ceph/pull/26175), Neha Ojha)
-   core: osd/PG: create new PGs from activate in last_peering_reset
    epoch ([issue#24452](http://tracker.ceph.com/issues/24452),
    [pr#22478](https://github.com/ceph/ceph/pull/22478), Sage Weil)
-   core: osd/PG: do not choose stray osds as async_recovery_targets
    ([pr#22330](https://github.com/ceph/ceph/pull/22330), Neha Ojha)
-   core: osd/PG: fix misused FORCE_RECOVERY\[BACKFILL\] flags
    ([issue#27985](http://tracker.ceph.com/issues/27985),
    [pr#23904](https://github.com/ceph/ceph/pull/23904), xie xingguo)
-   core: osd/PGLog.cc: check if complete_to points to log.end()
    ([pr#23450](https://github.com/ceph/ceph/pull/23450), Neha Ojha)
-   core: osd/PGLog: trim - avoid dereferencing invalid iter
    ([pr#23546](https://github.com/ceph/ceph/pull/23546), xie xingguo)
-   core: osd/PG: remove unused functions
    ([pr#26155](https://github.com/ceph/ceph/pull/26155), Kefu Chai)
-   core: osd/PG: reset PG on osd down-\>up; normalize query processing
    ([issue#24373](http://tracker.ceph.com/issues/24373),
    [pr#22456](https://github.com/ceph/ceph/pull/22456), Sage Weil)
-   core: osd/PG: restrict async_recovery_targets to up osds
    ([pr#22664](https://github.com/ceph/ceph/pull/22664), Neha Ojha)
-   core: osd/PG: unset history_les_bound if local-les is used
    ([pr#22524](https://github.com/ceph/ceph/pull/22524), Kefu Chai)
-   core: osd/PG: write pg epoch when resurrecting pg after delete vs
    merge race ([issue#35923](http://tracker.ceph.com/issues/35923),
    [pr#24061](https://github.com/ceph/ceph/pull/24061), Sage Weil)
-   core: osd/PrimaryLogPG: do not count failed read in delta_stats
    ([pr#25687](https://github.com/ceph/ceph/pull/25687), Kefu Chai)
-   core: osd/PrimaryLogPG: fix last_peering_reset checking on manifest
    flushing ([pr#26778](https://github.com/ceph/ceph/pull/26778), xie
    xingguo)
-   core: osd/PrimaryLogPG: fix on_local_recover crash on stray clone
    ([pr#22396](https://github.com/ceph/ceph/pull/22396), Sage Weil)
-   core: osd/PrimaryLogPG: fix potential pg-log overtrimming
    ([pr#23317](https://github.com/ceph/ceph/pull/23317), xie xingguo)
-   core: osd/PrimaryLogPG: fix the extent length error of the sync read
    ([pr#25584](https://github.com/ceph/ceph/pull/25584), Xiaofei Cui)
-   core: osd/PrimaryLogPG: fix try_flush_mark_clean write contention
    case ([issue#24174](http://tracker.ceph.com/issues/24174),
    [pr#22084](https://github.com/ceph/ceph/pull/22084), Sage Weil)
-   core: osd/PrimaryLogPG: optimize recover order
    ([pr#23587](https://github.com/ceph/ceph/pull/23587), xie xingguo)
-   core: osd/PrimaryLogPG: update missing_loc more carefully
    ([issue#35546](http://tracker.ceph.com/issues/35546),
    [pr#23895](https://github.com/ceph/ceph/pull/23895), xie xingguo)
-   core: osd/ReplicatedBackend: remove useless assert
    ([pr#21243](https://github.com/ceph/ceph/pull/21243), Jianpeng Ma)
-   core: osd/Session: fix invalid iterator dereference in
    <Session::have_backoff>()
    ([issue#24486](http://tracker.ceph.com/issues/24486),
    [pr#22497](https://github.com/ceph/ceph/pull/22497), Sage Weil)
-   core: osd: write \"debug dump_missing\" output to stdout
    ([pr#21960](https://github.com/ceph/ceph/pull/21960), Коренберг
    Маркr)
-   core: os/kstore: support db statistic
    ([pr#21487](https://github.com/ceph/ceph/pull/21487), Yang Honggang)
-   core: os/memstore: use ceph::mutex and friends
    ([pr#26026](https://github.com/ceph/ceph/pull/26026), Kefu Chai)
-   core,performance: core: avoid unnecessary refcounting of OSDMap on
    OSD\'s hot paths
    ([pr#24743](https://github.com/ceph/ceph/pull/24743), Radoslaw
    Zarzynski)
-   core,performance: msg/async: avoid put message within write_lock
    ([pr#20731](https://github.com/ceph/ceph/pull/20731), Haomai Wang)
-   core,performance: os/bluestore: make osd shard-thread do oncommits
    ([pr#22739](https://github.com/ceph/ceph/pull/22739), Jianpeng Ma)
-   core,performance: osd/filestore: Change default
    filestore_merge_threshold to -10
    ([issue#24686](http://tracker.ceph.com/issues/24686),
    [pr#22761](https://github.com/ceph/ceph/pull/22761), Douglas Fuller)
-   core,performance: osd/OSDMap: map pgs with smaller batchs in
    calc_pg_upmaps ([pr#23734](https://github.com/ceph/ceph/pull/23734),
    huangjun)
-   core: PG: release reservations after backfill completes
    ([issue#23614](http://tracker.ceph.com/issues/23614),
    [pr#22255](https://github.com/ceph/ceph/pull/22255), Neha Ojha)
-   core: pg stuck in backfill_wait with plenty of disk space
    ([issue#38034](http://tracker.ceph.com/issues/38034),
    [pr#26375](https://github.com/ceph/ceph/pull/26375), xie xingguo,
    David Zafman)
-   core,pybind: pybind/rados: new methods for manipulating self-managed
    snapshots ([pr#22579](https://github.com/ceph/ceph/pull/22579),
    Jason Dillaman)
-   core: qa/suites/rados: minor fixes
    ([pr#22195](https://github.com/ceph/ceph/pull/22195), Neha Ojha)
-   core: qa/suites/rados/thrash-erasure-code\*/thrashers/\*: less
    likely resv rejection injection
    ([pr#24667](https://github.com/ceph/ceph/pull/24667), Sage Weil)
-   core: qa/suites/rados/thrash-old-clients: only centos and 16.04
    ([pr#22106](https://github.com/ceph/ceph/pull/22106), Sage Weil)
-   core: qa/suites: set osd_pg_log_dups_tracked in
    cfuse_workunit_suites_fsync.yaml
    ([pr#21909](https://github.com/ceph/ceph/pull/21909), Neha Ojha)
-   core: qa/suites/upgrade/luminous-x: disable c-o-t import/export
    tests between versions
    ([issue#38294](http://tracker.ceph.com/issues/38294),
    [pr#27018](https://github.com/ceph/ceph/pull/27018), Sage Weil)
-   core: qa/suites/upgrade/mimic-x/parallel: enable all classes
    ([pr#27011](https://github.com/ceph/ceph/pull/27011), Sage Weil)
-   core: qa/workunits/mgr/test_localpool.sh: use new config syntax
    ([pr#22496](https://github.com/ceph/ceph/pull/22496), Sage Weil)
-   core: qa/workunits/rados/test_health_warnings: prevent out osds
    ([issue#37776](http://tracker.ceph.com/issues/37776),
    [pr#25732](https://github.com/ceph/ceph/pull/25732), Sage Weil)
-   core: rados.pyx: make all exceptions accept keyword arguments
    ([issue#24033](http://tracker.ceph.com/issues/24033),
    [pr#21853](https://github.com/ceph/ceph/pull/21853), Rishabh Dave)
-   core: rados: return legacy address in \'lock info\'
    ([pr#26150](https://github.com/ceph/ceph/pull/26150), Jason
    Dillaman)
-   core: scrub warning check incorrectly uses mon scrub interval
    ([issue#37264](http://tracker.ceph.com/issues/37264),
    [pr#25112](https://github.com/ceph/ceph/pull/25112), David Zafman)
-   core: src: no \'dne\' acronym in user cmd output
    ([pr#21094](https://github.com/ceph/ceph/pull/21094), Gu Zhongyan)
-   core,tests: Minor cleanups in tests and log output
    ([issue#38631](http://tracker.ceph.com/issues/38631),
    [issue#38678](http://tracker.ceph.com/issues/38678),
    [pr#26899](https://github.com/ceph/ceph/pull/26899), David Zafman)
-   core,tests: qa/overrides/short_pg_log.yaml: reduce
    [osd](){min,max}\_pg_log_entries
    ([issue#38025](http://tracker.ceph.com/issues/38025),
    [pr#26101](https://github.com/ceph/ceph/pull/26101), Neha Ojha)
-   core,tests: qa/suites/rados/thrash: change crush_tunables to jewel
    in rados_api_tests
    ([issue#38042](http://tracker.ceph.com/issues/38042),
    [pr#26122](https://github.com/ceph/ceph/pull/26122), Neha Ojha)
-   core,tests: qa/suites/upgrade/luminous-x: a few fixes
    ([pr#22092](https://github.com/ceph/ceph/pull/22092), Sage Weil)
-   core,tests: qa/tests: Set ansible-version: 2.5
    ([issue#24926](http://tracker.ceph.com/issues/24926),
    [pr#23123](https://github.com/ceph/ceph/pull/23123), Yuri Weinstein)
-   core,tests: Removal of snapshot with corrupt replica crashes osd
    ([issue#23875](http://tracker.ceph.com/issues/23875),
    [pr#22476](https://github.com/ceph/ceph/pull/22476), David Zafman)
-   core,tests: test: Verify a log trim trims the dup_index
    ([pr#26533](https://github.com/ceph/ceph/pull/26533), Brad Hubbard)
-   core,tools: osdmaptool: fix wrong test_map_pgs_dump_all output
    ([pr#22280](https://github.com/ceph/ceph/pull/22280), huangjun)
-   core,tools: rados: provide user with more meaningful error message
    ([pr#26275](https://github.com/ceph/ceph/pull/26275), Mykola Golub)
-   core,tools: tools/rados: allow reuse object for write test
    ([pr#25128](https://github.com/ceph/ceph/pull/25128), Li Wang)
-   core: vstart.sh: Support SPDK in Ceph development deployment
    ([pr#22975](https://github.com/ceph/ceph/pull/22975), tone.zhang)
-   crimson: add MonClient
    ([pr#23849](https://github.com/ceph/ceph/pull/23849), Kefu Chai)
-   crimson: cache osdmap using LRU cache
    ([pr#26254](https://github.com/ceph/ceph/pull/26254), Kefu Chai,
    Jianpeng Ma)
-   crimson/common: apply config changes also on shard.0
    ([pr#23631](https://github.com/ceph/ceph/pull/23631), Yingxin)
-   crimson/connection: misc changes
    ([pr#23044](https://github.com/ceph/ceph/pull/23044), Kefu Chai)
-   crimson: crimson/mon: remove timeout support from
    mon::Client::authenticate()
    ([pr#24660](https://github.com/ceph/ceph/pull/24660), Kefu Chai)
-   crimson/mon: move mon::Connection into .cc
    ([pr#24619](https://github.com/ceph/ceph/pull/24619), Kefu Chai)
-   crimson/net: concurrent dispatch for SocketMessenger
    ([pr#24090](https://github.com/ceph/ceph/pull/24090), Casey Bodley)
-   crimson/net: encapsulate protocol implementations with states
    ([pr#25176](https://github.com/ceph/ceph/pull/25176), Yingxin, Kefu
    Chai)
-   crimson/net: encapsulate protocol implementations with states
    (remaining part)
    ([pr#25207](https://github.com/ceph/ceph/pull/25207), Yingxin)
-   crimson/net: fix addresses during banner exchange
    ([pr#25580](https://github.com/ceph/ceph/pull/25580), Yingxin)
-   crimson/net: fix compile errors in test_alien_echo.cc
    ([pr#24629](https://github.com/ceph/ceph/pull/24629), Yingxin)
-   crimson/net: fix crimson msgr error leaks to caller
    ([pr#25716](https://github.com/ceph/ceph/pull/25716), Yingxin)
-   crimson/net: fix misc issues for segment-fault and test-failures
    ([pr#25939](https://github.com/ceph/ceph/pull/25939), Yingxin Cheng,
    Kefu Chai)
-   crimson/net: Fix racing for promise on_message
    ([pr#24097](https://github.com/ceph/ceph/pull/24097), Yingxin)
-   crimson/net: fix unittest_seastar_messenger errors
    ([pr#23539](https://github.com/ceph/ceph/pull/23539), Yingxin)
-   crimson/net: implement accepting/connecting states
    ([pr#24608](https://github.com/ceph/ceph/pull/24608), Yingxin)
-   crimson/net: miscellaneous fixes to seastar-msgr
    ([pr#23816](https://github.com/ceph/ceph/pull/23816), Yingxin, Casey
    Bodley)
-   crimson/net: misc fixes and features for crimson-messenger tests
    ([pr#26221](https://github.com/ceph/ceph/pull/26221), Yingxin Cheng)
-   crimson/net: seastar-msgr refactoring
    ([pr#24576](https://github.com/ceph/ceph/pull/24576), Yingxin)
-   crimson/net: s/repeat/keep_doing/
    ([pr#23898](https://github.com/ceph/ceph/pull/23898), Kefu Chai)
-   crimson/osd: add heartbeat support
    ([pr#26222](https://github.com/ceph/ceph/pull/26222), Kefu Chai)
-   crimson/osd: add more heartbeat peers
    ([pr#26255](https://github.com/ceph/ceph/pull/26255), Kefu Chai)
-   crimson/osd: correct the order of parameters passed to
    OSD::\_preboot()
    ([pr#26774](https://github.com/ceph/ceph/pull/26774), chunmei Liu)
-   crimson/osd: crimson osd driver
    ([pr#25304](https://github.com/ceph/ceph/pull/25304), Radoslaw
    Zarzynski, Kefu Chai)
-   crimson/osd: remove \"force_new\" from ms_get_authorizer()
    ([pr#26054](https://github.com/ceph/ceph/pull/26054), Kefu Chai)
-   crimson/osd: send known addresses at boot
    ([pr#26452](https://github.com/ceph/ceph/pull/26452), Kefu Chai)
-   crimson: persist/load osdmap to/from store
    ([pr#26090](https://github.com/ceph/ceph/pull/26090), Kefu Chai)
-   crimson: port messenger to seastar
    ([pr#22491](https://github.com/ceph/ceph/pull/22491), Kefu Chai,
    Casey Bodley)
-   crimson/thread: add thread pool
    ([pr#22565](https://github.com/ceph/ceph/pull/22565), Kefu Chai)
-   crimson/thread: pin thread pool to given CPU
    ([pr#22776](https://github.com/ceph/ceph/pull/22776), Kefu Chai)
-   crush/CrushWrapper: silence compiler warning
    ([pr#25336](https://github.com/ceph/ceph/pull/25336), Li Wang)
-   crush: fix device_class_clone for unpopulated/empty weight-sets
    ([issue#23386](http://tracker.ceph.com/issues/23386),
    [pr#22127](https://github.com/ceph/ceph/pull/22127), Sage Weil)
-   crush: fix memory leak
    ([pr#25959](https://github.com/ceph/ceph/pull/25959), xie xingguo)
-   crush: fix upmap overkill
    ([issue#37968](http://tracker.ceph.com/issues/37968),
    [pr#26179](https://github.com/ceph/ceph/pull/26179), xie xingguo)
-   dashboard/mgr: Save button doesn\'t prevent saving an invalid form
    ([issue#36426](http://tracker.ceph.com/issues/36426),
    [pr#24577](https://github.com/ceph/ceph/pull/24577), Patrick
    Nawracay)
-   dashboard: Return float if rate not available
    ([pr#22313](https://github.com/ceph/ceph/pull/22313), Boris Ranto)
-   doc: add Ceph Manager Dashboard to top-level TOC
    ([pr#26390](https://github.com/ceph/ceph/pull/26390), Nathan Cutler)
-   doc: add ceph-volume inventory sections
    ([pr#25092](https://github.com/ceph/ceph/pull/25092), Jan Fajerski)
-   doc: add documentation for iostat
    ([pr#22034](https://github.com/ceph/ceph/pull/22034), Mohamad Gebai)
-   doc: added demo document changes section
    ([pr#24791](https://github.com/ceph/ceph/pull/24791), James McClune)
-   doc: added rbd default features
    ([pr#24720](https://github.com/ceph/ceph/pull/24720), Gaurav
    Sitlani)
-   doc: added some Civetweb configuration options
    ([pr#24073](https://github.com/ceph/ceph/pull/24073), Anton Oks)
-   doc: Added some hints on how to further accelerate builds with
    ccache ([pr#25394](https://github.com/ceph/ceph/pull/25394), Lenz
    Grimmer)
-   doc: add instructions about using \"serve-doc\" to preview built
    document ([pr#24471](https://github.com/ceph/ceph/pull/24471), Kefu
    Chai)
-   doc: add mds state transition diagram
    ([issue#22989](http://tracker.ceph.com/issues/22989),
    [pr#22996](https://github.com/ceph/ceph/pull/22996), Patrick
    Donnelly)
-   doc: Add mention of ceph osd pool stats
    ([pr#25575](https://github.com/ceph/ceph/pull/25575), Thore Kruess)
-   doc: add missing 12.2.11 release note
    ([pr#26596](https://github.com/ceph/ceph/pull/26596), Nathan Cutler)
-   doc: add note about LVM volumes to ceph-deploy quick start
    ([pr#23879](https://github.com/ceph/ceph/pull/23879), David Wahler)
-   doc: add release notes for 12.2.11 luminous
    ([pr#26228](https://github.com/ceph/ceph/pull/26228), Abhishek
    Lekshmanan)
-   doc: add spacing to subcommand references
    ([pr#24669](https://github.com/ceph/ceph/pull/24669), James McClune)
-   doc: add \"\--timeout\" option to rbd-nbd
    ([pr#24302](https://github.com/ceph/ceph/pull/24302), Stefan Kooman)
-   doc/bluestore: fix minor typos in compression section
    ([pr#22874](https://github.com/ceph/ceph/pull/22874), David
    Disseldorp)
-   doc: broken link on troubleshooting-mon page
    ([pr#25312](https://github.com/ceph/ceph/pull/25312), James McClune)
-   doc: bump up sphinx and pyyaml versions
    ([pr#26044](https://github.com/ceph/ceph/pull/26044), Kefu Chai)
-   doc: ceph-deploy would not support \--cluster option anymore
    ([pr#26471](https://github.com/ceph/ceph/pull/26471), Tatsuya
    Naganawa)
-   doc: ceph: describe application subcommand in ceph man page
    ([pr#20645](https://github.com/ceph/ceph/pull/20645), Rishabh Dave)
-   doc: ceph-iscsi-api ports should not be public facing
    ([pr#24248](https://github.com/ceph/ceph/pull/24248), Jason
    Dillaman)
-   doc: ceph-volume describe better the options for migrating away from
    ceph-disk ([issue#24036](http://tracker.ceph.com/issues/24036),
    [pr#21890](https://github.com/ceph/ceph/pull/21890), Alfredo Deza)
-   doc: ceph-volume dmcrypt and activate \--all documentation updates
    ([issue#24031](http://tracker.ceph.com/issues/24031),
    [pr#22062](https://github.com/ceph/ceph/pull/22062), Alfredo Deza)
-   doc: ceph-volume: expand on why ceph-disk was replaced
    ([pr#23194](https://github.com/ceph/ceph/pull/23194), Alfredo Deza)
-   doc: ceph-volume: [lvm batch]{.title-ref} documentation and man page
    updates ([issue#24970](http://tracker.ceph.com/issues/24970),
    [pr#23443](https://github.com/ceph/ceph/pull/23443), Alfredo Deza)
-   doc: ceph-volume: update batch documentation to explain filestore
    strategies ([issue#34309](http://tracker.ceph.com/issues/34309),
    [pr#23785](https://github.com/ceph/ceph/pull/23785), Alfredo Deza)
-   doc: ceph-volume: zfs, the initial first submit
    ([pr#23674](https://github.com/ceph/ceph/pull/23674), Willem Jan
    Withagen)
-   doc: cleaned up troubleshooting OSDs documentation
    ([pr#23519](https://github.com/ceph/ceph/pull/23519), James McClune)
-   doc: Clean up field names in ServiceDescription and add a service
    field ([pr#26006](https://github.com/ceph/ceph/pull/26006), Jeff
    Layton)
-   doc: cleanup: prune Argonaut-specific verbiage
    ([pr#22899](https://github.com/ceph/ceph/pull/22899), Nathan Cutler)
-   doc: cleanup rendering syntax
    ([pr#22389](https://github.com/ceph/ceph/pull/22389), Mahati
    Chamarthy)
-   doc: Clean up the snapshot consistency note
    ([pr#25655](https://github.com/ceph/ceph/pull/25655), Greg Farnum)
-   doc: common,mon: add implicit [#include]{.title-ref} headers
    ([pr#23930](https://github.com/ceph/ceph/pull/23930), Kefu Chai)
-   doc: common/options: add description of osd objectstore backends
    ([issue#24147](http://tracker.ceph.com/issues/24147),
    [pr#22040](https://github.com/ceph/ceph/pull/22040), Alfredo Deza)
-   doc: corrected options of iscsiadm command
    ([pr#26395](https://github.com/ceph/ceph/pull/26395), ZhuJieWen)
-   doc: correct rbytes description
    ([pr#24966](https://github.com/ceph/ceph/pull/24966), Xiang Dai)
-   doc: describe RBD QoS settings
    ([pr#25202](https://github.com/ceph/ceph/pull/25202), Mykola Golub)
-   doc: doc/bluestore: data doesn\'t use two partitions (ceph-disk era)
    ([pr#22604](https://github.com/ceph/ceph/pull/22604), Alfredo Deza)
-   doc: doc/cephfs: fixup add/remove mds docs
    ([pr#23836](https://github.com/ceph/ceph/pull/23836), liu wei)
-   doc: doc/cephfs: remove lingering \"experimental\" note about
    multimds ([pr#22852](https://github.com/ceph/ceph/pull/22852), John
    Spray)
-   doc: doc/dashboard: don\'t advise mgr_initial_modules
    ([pr#22808](https://github.com/ceph/ceph/pull/22808), John Spray)
-   doc: doc/dashboard: fix formatting on Grafana instructions-2
    ([pr#22706](https://github.com/ceph/ceph/pull/22706), Jos Collin)
-   doc: doc/dashboard: fix formatting on Grafana instructions
    ([pr#22657](https://github.com/ceph/ceph/pull/22657), John Spray)
-   doc: doc/dev/cephx_protocol: fix couple errors
    ([pr#23750](https://github.com/ceph/ceph/pull/23750), Kefu Chai)
-   doc: doc/dev/index: update rados lead
    ([pr#24160](https://github.com/ceph/ceph/pull/24160), Josh Durgin)
-   doc: doc/dev/msgr2.rst: update of the banner and authentication
    phases ([pr#20094](https://github.com/ceph/ceph/pull/20094), Ricardo
    Dias)
-   doc: doc/dev/seastore.rst: initial draft notes
    ([pr#21381](https://github.com/ceph/ceph/pull/21381), Sage Weil)
-   doc: doc/dev: Updated component leads table
    ([pr#24238](https://github.com/ceph/ceph/pull/24238), Lenz Grimmer)
-   doc: doc: fix the links in releases/schedule.rst
    ([pr#22364](https://github.com/ceph/ceph/pull/22364), Kefu Chai)
-   doc: doc/man: mention import and export commands in rados manpage
    ([issue#4640](http://tracker.ceph.com/issues/4640),
    [pr#23186](https://github.com/ceph/ceph/pull/23186), Nathan Cutler)
-   doc: doc: Mention PURGED_SNAPDIRS and RECOVERY_DELETES in Mimic
    release notes ([pr#22711](https://github.com/ceph/ceph/pull/22711),
    Florian Haas)
-   doc: doc/mgr/dashboard: fix typo in mgr ssl setup
    ([pr#24790](https://github.com/ceph/ceph/pull/24790), Mehdi
    Abaakouk)
-   doc: doc/mgr: mention how to clear config setting
    ([pr#22157](https://github.com/ceph/ceph/pull/22157), John Spray)
-   doc: doc/mgr: note need for module.py file in plugins
    ([pr#22622](https://github.com/ceph/ceph/pull/22622), John Spray)
-   doc: doc/mgr/orchestrator: Add Architecture Image
    ([pr#26331](https://github.com/ceph/ceph/pull/26331), Sebastian
    Wagner, Kefu Chai)
-   doc: doc/mgr/orchestrator: add [wal]{.title-ref} to blink lights
    ([pr#25634](https://github.com/ceph/ceph/pull/25634), Sebastian
    Wagner)
-   doc: doc/mgr/prometheus: readd section about custom instance labels
    ([pr#25182](https://github.com/ceph/ceph/pull/25182), Jan Fajerski)
-   doc: doc/orchestrator: Aligned Documentation with specification
    ([pr#25893](https://github.com/ceph/ceph/pull/25893), Sebastian
    Wagner)
-   doc: doc/orchestrator: Integrate CLI specification into the
    documentation ([pr#25119](https://github.com/ceph/ceph/pull/25119),
    Sebastian Wagner)
-   doc: doc: purge subcommand link broken
    ([pr#24785](https://github.com/ceph/ceph/pull/24785), James McClune)
-   doc: doc/rados: Add bluestore memory autotuning docs
    ([pr#25069](https://github.com/ceph/ceph/pull/25069), Mark Nelson)
-   doc: doc/rados/configuration: add osd scrub {begin,end} week day
    ([pr#25924](https://github.com/ceph/ceph/pull/25924), Neha Ojha)
-   doc: doc/rados/configuration/msgr2: some documentation about msgr2
    ([pr#26867](https://github.com/ceph/ceph/pull/26867), Sage Weil)
-   doc: doc/rados/configuration: refresh osdmap section
    ([pr#26120](https://github.com/ceph/ceph/pull/26120), Ilya Dryomov)
-   doc: doc/rados: correct osd path in troubleshooting-mon.rst
    ([pr#24964](https://github.com/ceph/ceph/pull/24964), songweibin)
-   doc: doc/rados: fixed hit set type link
    ([pr#23833](https://github.com/ceph/ceph/pull/23833), James McClune)
-   doc: doc/radosgw/s3.rst: Adding AWS S3 [Storage Class]{.title-ref}
    as [Not Supported]{.title-ref}
    ([pr#19571](https://github.com/ceph/ceph/pull/19571), Katie Holly)
-   doc: doc/rados/operations: add balancer.rst to TOC
    ([pr#23684](https://github.com/ceph/ceph/pull/23684), Kefu Chai)
-   doc: doc/rados/operations: add clay to erasure-code-profile
    ([pr#26902](https://github.com/ceph/ceph/pull/26902), Kefu Chai)
-   doc: doc/rados/operations/crush-map-edits: fix \'take\' syntax
    ([pr#24868](https://github.com/ceph/ceph/pull/24868), Remy Zandwijk,
    Sage Weil)
-   doc: doc/rados/operations/pg-states: fix PG state names, part 2
    ([pr#23165](https://github.com/ceph/ceph/pull/23165), Nathan Cutler)
-   doc: doc/rados/operations/pg-states: fix PG state names
    ([pr#21520](https://github.com/ceph/ceph/pull/21520), Jan Fajerski)
-   doc: doc/rados update invalid bash on bluestore migration
    ([issue#34317](http://tracker.ceph.com/issues/34317),
    [pr#23801](https://github.com/ceph/ceph/pull/23801), Alfredo Deza)
-   doc: doc/rbd: corrected OpenStack Cinder permissions for Glance pool
    ([pr#22443](https://github.com/ceph/ceph/pull/22443), Jason
    Dillaman)
-   doc: doc/rbd: explicitly state that mirroring requires connectivity
    to clusters ([pr#24433](https://github.com/ceph/ceph/pull/24433),
    Jason Dillaman)
-   doc: doc/rbd/iscsi-target-cli: Update auth command
    ([pr#26788](https://github.com/ceph/ceph/pull/26788), Ricardo
    Marques)
-   doc: doc/rbd/iscsi-target-cli: Update disk separator
    ([pr#26669](https://github.com/ceph/ceph/pull/26669), Ricardo
    Marques)
-   doc: doc/release/luminous: v12.2.6 and v12.2.7 release notes
    ([pr#23057](https://github.com/ceph/ceph/pull/23057), Abhishek
    Lekshmanan, Sage Weil)
-   doc: doc/releases: Add luminous releases 12.2.9 and 10
    ([pr#25361](https://github.com/ceph/ceph/pull/25361), Brad Hubbard)
-   doc: doc/releases: Add Mimic release 13.2.2
    ([pr#24509](https://github.com/ceph/ceph/pull/24509), Brad Hubbard)
-   doc: doc/releases: Mark Jewel EOL
    ([pr#23698](https://github.com/ceph/ceph/pull/23698), Brad Hubbard)
-   doc: doc/releases: Mark Mimic first release as June
    ([pr#24099](https://github.com/ceph/ceph/pull/24099), Brad Hubbard)
-   doc: doc/releases/mimic.rst: make note of 13.2.2 upgrade bug
    ([pr#24979](https://github.com/ceph/ceph/pull/24979), Neha Ojha)
-   doc: doc/releases/mimic: tweak RBD major features
    ([pr#22011](https://github.com/ceph/ceph/pull/22011), Jason
    Dillaman)
-   doc: doc/releases/mimic: Updated dashboard description
    ([pr#22016](https://github.com/ceph/ceph/pull/22016), Lenz Grimmer)
-   doc: doc/releases/mimic: upgrade steps
    ([pr#21987](https://github.com/ceph/ceph/pull/21987), Sage Weil)
-   doc: doc/releases/nautilus: dashboard package notes
    ([pr#26815](https://github.com/ceph/ceph/pull/26815), Kefu Chai)
-   doc: doc/releases/schedule: Add Luminous 12.2.8
    ([pr#23972](https://github.com/ceph/ceph/pull/23972), Brad Hubbard)
-   doc: doc/releases/schedule: add mimic column
    ([pr#22006](https://github.com/ceph/ceph/pull/22006), Sage Weil)
-   doc: doc/releases: Update releases to August \'18
    ([pr#23360](https://github.com/ceph/ceph/pull/23360), Brad Hubbard)
-   doc: doc/rgw: document placement targets and storage classes
    ([issue#24508](http://tracker.ceph.com/issues/24508),
    [issue#38008](http://tracker.ceph.com/issues/38008),
    [pr#26997](https://github.com/ceph/ceph/pull/26997), Casey Bodley)
-   doc: docs: add Clay code plugin documentation
    ([pr#24422](https://github.com/ceph/ceph/pull/24422), Myna)
-   doc: docs: Fixed swift client authentication fail
    ([pr#23729](https://github.com/ceph/ceph/pull/23729), Dai Dang Van)
-   doc: docs: radosgw: ldap-auth: fixed option name
    \'rgw_ldap_searchfilter\'
    ([issue#23081](http://tracker.ceph.com/issues/23081),
    [pr#20526](https://github.com/ceph/ceph/pull/20526), Konstantin
    Shalygin)
-   doc: doc/start: fix kube-helm.rst typo: docuiment -\> document
    ([pr#23423](https://github.com/ceph/ceph/pull/23423), Zhou Peng)
-   doc: doc/SubmittingPatches.rst: use Google style guide for doc
    patches ([pr#22190](https://github.com/ceph/ceph/pull/22190), Nathan
    Cutler)
-   doc: Document correction
    ([pr#23926](https://github.com/ceph/ceph/pull/23926), Gangbiao Liu)
-   doc: Document mappings of S3 Operations to ACL grants
    ([pr#26827](https://github.com/ceph/ceph/pull/26827), Adam C.
    Emerson)
-   doc: document sizing for [block.db]{.title-ref}
    ([pr#23210](https://github.com/ceph/ceph/pull/23210), Alfredo Deza)
-   doc: document vstart options
    ([pr#22467](https://github.com/ceph/ceph/pull/22467), Mao Zhongyi)
-   doc: doc/user-management: Remove obsolete reset caps command
    ([issue#37663](http://tracker.ceph.com/issues/37663),
    [pr#25550](https://github.com/ceph/ceph/pull/25550), Brad Hubbard)
-   doc: edit on github
    ([pr#24452](https://github.com/ceph/ceph/pull/24452), Neha Ojha,
    Noah Watkins)
-   doc: erasure-code-clay fixes typos
    ([pr#24653](https://github.com/ceph/ceph/pull/24653), Myna)
-   doc: erasure-code-jerasure: removed default section of
    crush-device-class
    ([pr#21279](https://github.com/ceph/ceph/pull/21279), Junyoung Sung)
-   doc: examples/librados: Remove not needed else clauses
    ([pr#24939](https://github.com/ceph/ceph/pull/24939), Marcos Paulo
    de Souza)
-   doc: explain \'firstn v indep\' in the CRUSH docs
    ([pr#24255](https://github.com/ceph/ceph/pull/24255), Greg Farnum)
-   doc: Fix a couple typos and improve diagram formatting
    ([pr#23496](https://github.com/ceph/ceph/pull/23496), Bryan
    Stillwell)
-   doc: fix a typo in doc/mgr/telegraf.rst
    ([pr#22267](https://github.com/ceph/ceph/pull/22267), Enming Zhang)
-   doc: fix cephfs spelling errors
    ([pr#23763](https://github.com/ceph/ceph/pull/23763), Chen Zhenghua)
-   doc: fix/cleanup freebsd osd disk creation
    ([pr#23600](https://github.com/ceph/ceph/pull/23600), Willem Jan
    Withagen)
-   doc: Fix Create a Cluster url in Running Multiple Clusters
    ([issue#37764](http://tracker.ceph.com/issues/37764),
    [pr#25705](https://github.com/ceph/ceph/pull/25705), Jos Collin)
-   doc: Fix EC k=3 m=2 profile overhead calculation example
    ([pr#20581](https://github.com/ceph/ceph/pull/20581), Charles Alva)
-   doc: fixed broken urls
    ([pr#23564](https://github.com/ceph/ceph/pull/23564), James McClune)
-   doc: fixed grammar in restore rbd image section
    ([pr#22944](https://github.com/ceph/ceph/pull/22944), James McClune)
-   doc: fixed links in Pools section
    ([pr#23431](https://github.com/ceph/ceph/pull/23431), James McClune)
-   doc: fixed minor typo in Debian packages section
    ([pr#22878](https://github.com/ceph/ceph/pull/22878), James McClune)
-   doc: fixed restful mgr module SSL configuration commands
    ([pr#21864](https://github.com/ceph/ceph/pull/21864), Lenz Grimmer)
-   doc: Fixed spelling errors in configuration section
    ([pr#23719](https://github.com/ceph/ceph/pull/23719), Bryan
    Stillwell)
-   doc: Fixed syntax in iscsi initiator windows doc
    ([pr#25467](https://github.com/ceph/ceph/pull/25467), Michel Raabe)
-   doc: Fixed the paragraph and boxes
    ([pr#25094](https://github.com/ceph/ceph/pull/25094), Scoots
    Hamilton)
-   doc: Fixed the wrong numbers in mgr/dashboard.rst
    ([pr#22658](https://github.com/ceph/ceph/pull/22658), Jos Collin)
-   doc: fixed typo in add-or-rm-mons.rst
    ([pr#26250](https://github.com/ceph/ceph/pull/26250), James McClune)
-   doc: fixed typo in cephfs snapshots
    ([pr#23764](https://github.com/ceph/ceph/pull/23764), Kai Wagner)
-   doc: fixed typo in CRUSH map docs
    ([pr#25953](https://github.com/ceph/ceph/pull/25953), James McClune)
-   doc: fixed typo in man page
    ([pr#24792](https://github.com/ceph/ceph/pull/24792), James McClune)
-   doc: Fix incorrect mention of \'osd_deep_mon_scrub_interval\'
    ([pr#26522](https://github.com/ceph/ceph/pull/26522), Ashish Singh)
-   doc: Fix iSCSI docs URL
    ([pr#26296](https://github.com/ceph/ceph/pull/26296), Ricardo
    Marques)
-   doc: fix iscsi target name when configuring target
    ([pr#21906](https://github.com/ceph/ceph/pull/21906), Venky Shankar)
-   doc: fix long description error for rgw_period_root_pool
    ([pr#23814](https://github.com/ceph/ceph/pull/23814), yuliyang)
-   doc: fix some it\'s -\> its typos
    ([pr#22802](https://github.com/ceph/ceph/pull/22802), Brad
    Fitzpatrick)
-   doc: Fix some typos
    ([pr#25060](https://github.com/ceph/ceph/pull/25060), mooncake)
-   doc: Fix Spelling Error In File \"ceph.rst\"
    ([pr#23917](https://github.com/ceph/ceph/pull/23917), Gangbiao Liu)
-   doc: Fix Spelling Error In File dynamicresharding.rst
    ([pr#24175](https://github.com/ceph/ceph/pull/24175), xiaomanh)
-   doc: Fix Spelling Error of Rados Deployment/Operations
    ([pr#23746](https://github.com/ceph/ceph/pull/23746), Li Bingyang)
-   doc: Fix Spelling Error of Radosgw
    ([pr#23948](https://github.com/ceph/ceph/pull/23948), Li Bingyang)
-   doc: Fix Spelling Error of Radosgw
    ([pr#24000](https://github.com/ceph/ceph/pull/24000), Li Bingyang)
-   doc: Fix Spelling Error of Radosgw
    ([pr#24021](https://github.com/ceph/ceph/pull/24021), Li Bingyang)
-   doc: Fix Spelling Error of Rados Operations
    ([pr#23891](https://github.com/ceph/ceph/pull/23891), Li Bingyang)
-   doc: Fix Spelling Error of Rados Operations
    ([pr#23900](https://github.com/ceph/ceph/pull/23900), Li Bingyang)
-   doc: Fix Spelling Error of Rados Operations
    ([pr#23903](https://github.com/ceph/ceph/pull/23903), Li Bingyang)
-   doc: fix spelling errors in rbd doc
    ([pr#23765](https://github.com/ceph/ceph/pull/23765), Chen Zhenghua)
-   doc: fix spelling errors of cephfs
    ([pr#23745](https://github.com/ceph/ceph/pull/23745), Chen Zhenghua)
-   doc: fix the broken urls
    ([issue#25185](http://tracker.ceph.com/issues/25185),
    [pr#23310](https://github.com/ceph/ceph/pull/23310), Jos Collin)
-   doc: fix the formatting of HTTP Frontends documentation
    ([pr#25723](https://github.com/ceph/ceph/pull/25723), James McClune)
-   doc: fix typo and format issues in quick start documentation
    ([pr#23705](https://github.com/ceph/ceph/pull/23705), Chen Zhenghua)
-   doc: fix typo in add-or-rm-mons
    ([pr#25661](https://github.com/ceph/ceph/pull/25661), Jos Collin)
-   doc: Fix typo in ceph-fuse(8)
    ([pr#22214](https://github.com/ceph/ceph/pull/22214), Jos Collin)
-   doc: fix typo in erasure coding example
    ([pr#25737](https://github.com/ceph/ceph/pull/25737), Arthur Liu)
-   doc: Fix typos in Developer Guide
    ([pr#24067](https://github.com/ceph/ceph/pull/24067), Li Bingyang)
-   doc: fix typos in doc/releases
    ([pr#24186](https://github.com/ceph/ceph/pull/24186), Li Bingyang)
-   doc: \*/: fix typos in docs,messages,logs,comments
    ([pr#24139](https://github.com/ceph/ceph/pull/24139), Kefu Chai)
-   doc: Fix Typos of Developer Guide
    ([pr#24094](https://github.com/ceph/ceph/pull/24094), Li Bingyang)
-   doc: fix typos ([pr#22174](https://github.com/ceph/ceph/pull/22174),
    Mao Zhongyi)
-   doc: .githubmap, .mailmap, .organizationmap: update contributors
    ([pr#24756](https://github.com/ceph/ceph/pull/24756), Tiago Melo)
-   doc: githubmap, organizationmap: cleanup and add/update
    contributors/affiliation
    ([pr#22734](https://github.com/ceph/ceph/pull/22734), Tatjana
    Dehler)
-   doc: give pool name if default pool rbd is not created
    ([pr#24750](https://github.com/ceph/ceph/pull/24750), Changcheng
    Liu)
-   doc: Improve docs osd_recovery_priority, osd_recovery_op_priority
    and related ([pr#26705](https://github.com/ceph/ceph/pull/26705),
    David Zafman)
-   doc: Improve OpenStack integration and multitenancy docs for radosgw
    ([issue#36765](http://tracker.ceph.com/issues/36765),
    [pr#25056](https://github.com/ceph/ceph/pull/25056), Florian Haas)
-   doc: install build-doc deps without git clone
    ([pr#24416](https://github.com/ceph/ceph/pull/24416), Noah Watkins)
-   doc: Luminous v12.2.10 release notes
    ([pr#25034](https://github.com/ceph/ceph/pull/25034), Nathan Cutler)
-   doc: Luminous v12.2.9 release notes
    ([pr#24779](https://github.com/ceph/ceph/pull/24779), Nathan Cutler)
-   doc: make it easier to reach the old dev doc TOC
    ([pr#23253](https://github.com/ceph/ceph/pull/23253), Nathan Cutler)
-   doc: mention CVEs in luminous v12.2.11 release notes
    ([pr#26312](https://github.com/ceph/ceph/pull/26312), Nathan Cutler,
    Abhishek Lekshmanan)
-   doc: mgr/dashboard: Add documentation about supported browsers
    ([issue#27207](http://tracker.ceph.com/issues/27207),
    [pr#23712](https://github.com/ceph/ceph/pull/23712), Tiago Melo)
-   doc: mgr/dashboard: Added missing tooltip to settings icon
    ([pr#23935](https://github.com/ceph/ceph/pull/23935), Lenz Grimmer)
-   doc: mgr/dashboard: Add hints to resolve unit test failures
    ([pr#23627](https://github.com/ceph/ceph/pull/23627), Stephan
    Müller)
-   doc: mgr/dashboard: Cleaner notifications
    ([pr#23315](https://github.com/ceph/ceph/pull/23315), Stephan
    Müller)
-   doc: mgr/dashboard: Cleanup of summary refresh test
    ([pr#25504](https://github.com/ceph/ceph/pull/25504), Stephan
    Müller)
-   doc: mgr/dashboard: Document custom RESTController endpoints
    ([pr#25322](https://github.com/ceph/ceph/pull/25322), Stephan
    Müller)
-   doc: mgr/dashboard: Fixed documentation link on RGW page
    ([pr#24612](https://github.com/ceph/ceph/pull/24612), Tina Kallio)
-   doc: mgr/dashboard: Fix some setup steps in HACKING.rst
    ([pr#24788](https://github.com/ceph/ceph/pull/24788), Ranjitha G)
-   doc: mgr/dashboard: Improve prettier scripts and documentation
    ([pr#22994](https://github.com/ceph/ceph/pull/22994), Tiago Melo)
-   doc: mgr/dashboard/qa: add missing dashboard suites
    ([pr#25084](https://github.com/ceph/ceph/pull/25084), Tatjana
    Dehler)
-   doc: mgr/dashboard: updated SSO documentation
    ([pr#25943](https://github.com/ceph/ceph/pull/25943), Alfonso
    Martínez)
-   doc: mgr/dashboard: Update I18N documentation
    ([pr#25159](https://github.com/ceph/ceph/pull/25159), Tiago Melo)
-   doc: mgr/orch: Fix remote_host doc reference
    ([issue#38254](http://tracker.ceph.com/issues/38254),
    [pr#26360](https://github.com/ceph/ceph/pull/26360), Ernesto Puerta)
-   doc/mgr/plugins.rst: explain more about the plugin command protocol
    ([pr#22629](https://github.com/ceph/ceph/pull/22629), Dan Mick)
-   doc: mimic is stable!
    ([pr#22350](https://github.com/ceph/ceph/pull/22350), Abhishek
    Lekshmanan)
-   doc: mimic rc1 release notes
    ([pr#20975](https://github.com/ceph/ceph/pull/20975), Abhishek
    Lekshmanan)
-   doc: Multiple spelling fixes
    ([pr#23514](https://github.com/ceph/ceph/pull/23514), Bryan
    Stillwell)
-   doc: numbered eviction situations
    ([pr#24618](https://github.com/ceph/ceph/pull/24618), Scoots
    Hamilton)
-   doc: osdmaptool/cleanup: Completed osdmaptool\'s usage
    ([issue#3214](http://tracker.ceph.com/issues/3214),
    [pr#13925](https://github.com/ceph/ceph/pull/13925), Vedant Nanda)
-   doc: osd/PrimaryLogPG: avoid dereferencing invalid complete_to
    ([pr#23894](https://github.com/ceph/ceph/pull/23894), xie xingguo)
-   doc: osd/PrimaryLogPG: rename list_missing -\> list_unfound command
    ([pr#23723](https://github.com/ceph/ceph/pull/23723), xie xingguo)
-   doc: PendingReleaseNotes: note newly added CLAY code
    ([pr#24491](https://github.com/ceph/ceph/pull/24491), Kefu Chai)
-   doc: print pg peering in SVG instead of PNG
    ([pr#20366](https://github.com/ceph/ceph/pull/20366), Aleksei
    Gutikov)
-   doc: Put command template into literal block
    ([pr#24999](https://github.com/ceph/ceph/pull/24999), Alexey
    Stupnikov)
-   doc: qa/mgr/selftest: handle always-on module fall out
    ([issue#26994](http://tracker.ceph.com/issues/26994),
    [pr#23681](https://github.com/ceph/ceph/pull/23681), Noah Watkins)
-   doc: qa: Task to emulate network delay and packet drop between two
    given h... ([pr#23602](https://github.com/ceph/ceph/pull/23602),
    Shilpa Jagannath)
-   doc: qa/workunits/rbd: replace usage of \'rados rmpool\'
    ([pr#23942](https://github.com/ceph/ceph/pull/23942), Mykola Golub)
-   doc: release/mimic: correct the changelog to the latest version
    ([pr#22319](https://github.com/ceph/ceph/pull/22319), Abhishek
    Lekshmanan)
-   doc: release notes for 12.2.8 luminous
    ([pr#23909](https://github.com/ceph/ceph/pull/23909), Abhishek
    Lekshmanan)
-   doc: release notes for 13.2.2 mimic
    ([pr#24266](https://github.com/ceph/ceph/pull/24266), Abhishek
    Lekshmanan)
-   doc: releases: mimic 13.2.1 release notes
    ([pr#23288](https://github.com/ceph/ceph/pull/23288), Abhishek
    Lekshmanan)
-   doc: releases: release notes for v10.2.11 Jewel
    ([pr#22989](https://github.com/ceph/ceph/pull/22989), Abhishek
    Lekshmanan)
-   doc: remove CZ mirror
    ([pr#21797](https://github.com/ceph/ceph/pull/21797), Tomáš Kukrál)
-   doc: remove deprecated \'scrubq\' from ceph(8)
    ([issue#35813](http://tracker.ceph.com/issues/35813),
    [pr#23959](https://github.com/ceph/ceph/pull/23959), Ruben Kerkhof)
-   doc: remove documentation for installing google-perftools on Debian
    systems ([pr#22701](https://github.com/ceph/ceph/pull/22701), James
    McClune)
-   doc: remove duplicate python packages
    ([pr#22203](https://github.com/ceph/ceph/pull/22203), Stefan Kooman)
-   doc: Remove upstart files and references
    ([pr#23582](https://github.com/ceph/ceph/pull/23582), Brad Hubbard)
-   doc: Remove value \'mon_osd_max_split_count\'
    ([pr#26584](https://github.com/ceph/ceph/pull/26584), Kai Wagner)
-   doc: replace rgw_namespace_expire_secs with
    rgw_nfs_namespace_expire_secs
    ([pr#20794](https://github.com/ceph/ceph/pull/20794), chnmagnus)
-   doc: rewrote the iscsi-target-cli installation
    ([pr#23190](https://github.com/ceph/ceph/pull/23190), Massimiliano
    Cuttini)
-   doc: rgw: fix tagging support status
    ([issue#24164](http://tracker.ceph.com/issues/24164),
    [pr#22206](https://github.com/ceph/ceph/pull/22206), Abhishek
    Lekshmanan)
-   doc: rgw: fix the default value of usage log setting
    ([issue#37856](http://tracker.ceph.com/issues/37856),
    [pr#25892](https://github.com/ceph/ceph/pull/25892), Abhishek
    Lekshmanan)
-   doc: Rook/orchestrator doc fixes
    ([pr#23472](https://github.com/ceph/ceph/pull/23472), John Spray)
-   doc: s/doc/ref for dashboard urls
    ([pr#22772](https://github.com/ceph/ceph/pull/22772), Jos Collin)
-   doc: sort releases by date and version
    ([pr#25972](https://github.com/ceph/ceph/pull/25972), Noah Watkins)
-   doc: Spelling fixes in BlueStore config reference
    ([pr#23715](https://github.com/ceph/ceph/pull/23715), Bryan
    Stillwell)
-   doc: Spelling fixes in Network config reference
    ([pr#23727](https://github.com/ceph/ceph/pull/23727), libingyang)
-   doc: SubmittingPatches: added inline markup to important references
    ([pr#25978](https://github.com/ceph/ceph/pull/25978), James McClune)
-   docs: update rgw info for mimic
    ([pr#22305](https://github.com/ceph/ceph/pull/22305), Yehuda Sadeh)
-   doc: test/crimson: do not use unit.cc as the driver of
    unittest_seastar_denc
    ([pr#23937](https://github.com/ceph/ceph/pull/23937), Kefu Chai)
-   doc: test/fio: Added tips for compilation of fio with \'rados\'
    engine ([pr#24199](https://github.com/ceph/ceph/pull/24199), Adam
    Kupczyk)
-   doc: test/msgr: add missing #include
    ([pr#23947](https://github.com/ceph/ceph/pull/23947), Kefu Chai)
-   doc: Tidy up description wording and spelling
    ([pr#22599](https://github.com/ceph/ceph/pull/22599), Anthony
    D\'Atri)
-   doc: tweak RBD iSCSI docs to point to merged tooling repo
    ([pr#24963](https://github.com/ceph/ceph/pull/24963), Jason
    Dillaman)
-   doc: typo fixes, s/Requered/Required/
    ([pr#26406](https://github.com/ceph/ceph/pull/26406), Drunkard
    Zhang)
-   doc: update blkin changes
    ([pr#22317](https://github.com/ceph/ceph/pull/22317), Mahati
    Chamarthy)
-   doc: Update cpp.rst to accommodate the new APIs in libs3
    ([pr#22162](https://github.com/ceph/ceph/pull/22162), Zhanhao Liu)
-   doc: Updated Ceph Dashboard documentation
    ([pr#26626](https://github.com/ceph/ceph/pull/26626), Lenz Grimmer)
-   doc: updated Ceph documentation links
    ([pr#25797](https://github.com/ceph/ceph/pull/25797), James McClune)
-   doc: updated cluster map reference link
    ([pr#24460](https://github.com/ceph/ceph/pull/24460), James McClune)
-   doc: updated crush map tunables link
    ([pr#24462](https://github.com/ceph/ceph/pull/24462), James McClune)
-   doc: Updated dashboard documentation (features, SSL config)
    ([pr#22059](https://github.com/ceph/ceph/pull/22059), Lenz Grimmer)
-   doc: Updated feature list and overview in dashboard.rst
    ([pr#26143](https://github.com/ceph/ceph/pull/26143), Lenz Grimmer)
-   doc: updated get-involved.rst for ceph-dashboard
    ([pr#22663](https://github.com/ceph/ceph/pull/22663), Jos Collin)
-   doc: Updated Mgr Dashboard documentation
    ([pr#24030](https://github.com/ceph/ceph/pull/24030), Lenz Grimmer)
-   doc: updated multisite documentation
    ([issue#26997](http://tracker.ceph.com/issues/26997),
    [pr#23660](https://github.com/ceph/ceph/pull/23660), James McClune)
-   doc: updated reference link for creating new disk offerings in
    cloudstack ([pr#22250](https://github.com/ceph/ceph/pull/22250),
    James McClune)
-   doc: updated reference link for log based PG
    ([pr#26611](https://github.com/ceph/ceph/pull/26611), James McClune)
-   doc: updated rgw multitenancy link
    ([pr#25929](https://github.com/ceph/ceph/pull/25929), James McClune)
-   doc: updated the overview and glossary for dashboard
    ([pr#22750](https://github.com/ceph/ceph/pull/22750), Jos Collin)
-   doc: updated wording from federated to multisite
    ([pr#24670](https://github.com/ceph/ceph/pull/24670), James McClune)
-   doc: Update mgr/zabbix plugin documentation with link to Zabbix
    template ([pr#24584](https://github.com/ceph/ceph/pull/24584), Wido
    den Hollander)
-   doc: update the description for SPDK in bluestore-config-ref.rst
    ([pr#22365](https://github.com/ceph/ceph/pull/22365), tone-zhang)
-   doc: use :command: for subcommands in ceph-bluestore-tool manpage
    ([issue#24800](http://tracker.ceph.com/issues/24800),
    [pr#23114](https://github.com/ceph/ceph/pull/23114), Nathan Cutler)
-   doc: use preferred commands for ceph config-key
    ([pr#26527](https://github.com/ceph/ceph/pull/26527), Changcheng
    Liu)
-   doc: warn about how \'rados put\' works in the manpage
    ([pr#25757](https://github.com/ceph/ceph/pull/25757), Greg Farnum)
-   doc: Wip githubmap
    ([pr#25950](https://github.com/ceph/ceph/pull/25950), Greg Farnum)
-   erasure-code,test: silence -Wunused-variable warnings
    ([pr#25200](https://github.com/ceph/ceph/pull/25200), Kefu Chai)
-   example/librados: remove dependency on Boost system library
    ([issue#25054](http://tracker.ceph.com/issues/25054),
    [pr#23159](https://github.com/ceph/ceph/pull/23159), Nathan Cutler)
-   githubmap: update contributors
    ([pr#22522](https://github.com/ceph/ceph/pull/22522), Kefu Chai)
-   git: Ignore tags anywhere
    ([pr#26159](https://github.com/ceph/ceph/pull/26159), David Zafman)
-   include/buffer.h: do not use ceph_assert() unless \_\_CEPH\_\_ is
    defined ([pr#23803](https://github.com/ceph/ceph/pull/23803), Kefu
    Chai)
-   install-deps.sh: Fixes for RHEL 7
    ([pr#26393](https://github.com/ceph/ceph/pull/26393), Zack Cerza)
-   kv/MemDB: add perfcounter
    ([pr#10305](https://github.com/ceph/ceph/pull/10305), Jianpeng Ma)
-   librados: add a rados_omap_iter_size function
    ([issue#26948](http://tracker.ceph.com/issues/26948),
    [pr#23593](https://github.com/ceph/ceph/pull/23593), Jeff Layton)
-   librados: block MgrClient::start_command until mgrmap
    ([pr#21811](https://github.com/ceph/ceph/pull/21811), John Spray,
    Kefu Chai)
-   librados: fix admin/build-doc warning
    ([pr#25706](https://github.com/ceph/ceph/pull/25706), Jos Collin)
-   librados: fix buffer overflow for aio_exec python binding
    ([pr#21775](https://github.com/ceph/ceph/pull/21775), Aleksei
    Gutikov)
-   librados: fix unitialized timeout in wait_for_osdmap
    ([pr#24721](https://github.com/ceph/ceph/pull/24721), Casey Bodley)
-   librados: Include memory for unique_ptr definition
    ([issue#35833](http://tracker.ceph.com/issues/35833),
    [pr#23992](https://github.com/ceph/ceph/pull/23992), Brad Hubbard)
-   librados: Reject the invalid pool create request at client side,
    rath... ([pr#21299](https://github.com/ceph/ceph/pull/21299), Yang
    Honggang)
-   librados: return ENOENT if pool_id invalid
    ([pr#21609](https://github.com/ceph/ceph/pull/21609), Li Wang)
-   librados: split C++ and C APIs into different source files
    ([pr#24616](https://github.com/ceph/ceph/pull/24616), Kefu Chai)
-   librados: use ceph::async::Completion for asio bindings
    ([pr#21920](https://github.com/ceph/ceph/pull/21920), Casey Bodley)
-   librados: use steady clock for rados_mon_op_timeout
    ([pr#20004](https://github.com/ceph/ceph/pull/20004), Mohamad Gebai)
-   librbd: add missing shutdown states to managed lock helper
    ([issue#38387](http://tracker.ceph.com/issues/38387),
    [pr#26523](https://github.com/ceph/ceph/pull/26523), Jason Dillaman)
-   librbd: add new configuration option to always move deleted items to
    the trash ([pr#24476](https://github.com/ceph/ceph/pull/24476),
    Jason Dillaman)
-   librbd: add rbd image access/modified timestamps
    ([pr#21114](https://github.com/ceph/ceph/pull/21114), Julien Collet)
-   librbd: add trash purge api calls
    ([pr#24427](https://github.com/ceph/ceph/pull/24427), Julien Collet,
    Theofilos Mouratidis, Jason Dillaman)
-   librbd: always open first parent image if it exists for a snapshot
    ([pr#23733](https://github.com/ceph/ceph/pull/23733), Jason
    Dillaman)
-   librbd: avoid aggregate-initializing any static_visitor
    ([pr#26876](https://github.com/ceph/ceph/pull/26876), Willem Jan
    Withagen)
-   librbd: blacklisted client might not notice it lost the lock
    ([issue#34534](http://tracker.ceph.com/issues/34534),
    [pr#23829](https://github.com/ceph/ceph/pull/23829), Jason Dillaman)
-   librbd: block_name_prefix is not created randomly
    ([issue#24634](http://tracker.ceph.com/issues/24634),
    [pr#22675](https://github.com/ceph/ceph/pull/22675), hyun-ha)
-   librbd: bypass pool validation if \"rbd_validate_pool\" is false
    ([pr#26878](https://github.com/ceph/ceph/pull/26878), Jason
    Dillaman)
-   librbd: commit IO as safe when complete if writeback cache is
    disabled ([issue#23516](http://tracker.ceph.com/issues/23516),
    [pr#22342](https://github.com/ceph/ceph/pull/22342), Jason Dillaman)
-   librbd: corrected usage of ImageState::open flag parameter
    ([pr#25428](https://github.com/ceph/ceph/pull/25428), Mykola Golub)
-   librbd: deep_copy: don\'t hide parent if zero overlap for snapshot
    ([issue#24545](http://tracker.ceph.com/issues/24545),
    [pr#22587](https://github.com/ceph/ceph/pull/22587), Mykola Golub)
-   librbd: deep copy optionally support flattening cloned image
    ([issue#22787](http://tracker.ceph.com/issues/22787),
    [pr#21624](https://github.com/ceph/ceph/pull/21624), Mykola Golub)
-   librbd: deep_copy: resize head object map if needed
    ([issue#24399](http://tracker.ceph.com/issues/24399),
    [pr#22415](https://github.com/ceph/ceph/pull/22415), Mykola Golub)
-   librbd: deep-copy should not write to objects that cannot exist
    ([issue#25000](http://tracker.ceph.com/issues/25000),
    [pr#23132](https://github.com/ceph/ceph/pull/23132), Jason Dillaman)
-   librbd: disable image mirroring when moving to trash
    ([pr#25509](https://github.com/ceph/ceph/pull/25509), Mykola Golub)
-   librbd: disallow trash restoring when image being migrated
    ([pr#25529](https://github.com/ceph/ceph/pull/25529), songweibin)
-   librbd: don\'t do create+truncate for discards with copyup
    ([pr#26825](https://github.com/ceph/ceph/pull/26825), Ilya Dryomov)
-   librbd: ensure compare-and-write doesn\'t skip compare after copyup
    ([issue#38383](http://tracker.ceph.com/issues/38383),
    [pr#26519](https://github.com/ceph/ceph/pull/26519), Ilya Dryomov)
-   librbd: extend API to include parent/child namespaces and image ids
    ([issue#36650](http://tracker.ceph.com/issues/36650),
    [pr#25194](https://github.com/ceph/ceph/pull/25194), Jason Dillaman)
-   librbd: fix crash when opening nonexistent snapshot
    ([issue#24637](http://tracker.ceph.com/issues/24637),
    [pr#22676](https://github.com/ceph/ceph/pull/22676), Mykola Golub)
-   librbd: fixed assert when flattening clone with zero overlap
    ([issue#35702](http://tracker.ceph.com/issues/35702),
    [pr#24045](https://github.com/ceph/ceph/pull/24045), Jason Dillaman)
-   librbd: fix missing unblock_writes if shrink is not allowed
    ([issue#36778](http://tracker.ceph.com/issues/36778),
    [pr#25055](https://github.com/ceph/ceph/pull/25055), runsisi)
-   librbd: fix possible unnecessary latency when requeue request
    ([pr#23815](https://github.com/ceph/ceph/pull/23815), Song Shun)
-   librbd: fix potential live migration after commit issues due to not
    refreshed image header
    ([pr#23839](https://github.com/ceph/ceph/pull/23839), Mykola Golub)
-   librbd: fix were_all_throttled() to avoid incorrect ret-value
    ([issue#38504](http://tracker.ceph.com/issues/38504),
    [pr#26688](https://github.com/ceph/ceph/pull/26688), Dongsheng Yang)
-   librbd: flatten operation should use object map
    ([issue#23445](http://tracker.ceph.com/issues/23445),
    [pr#23941](https://github.com/ceph/ceph/pull/23941), Mykola Golub)
-   librbd: force \'invalid object map\' flag on-disk update
    ([issue#24434](http://tracker.ceph.com/issues/24434),
    [pr#22444](https://github.com/ceph/ceph/pull/22444), Mykola Golub)
-   librbd: get_parent API method should properly handle migrating image
    ([issue#37998](http://tracker.ceph.com/issues/37998),
    [pr#26337](https://github.com/ceph/ceph/pull/26337), Jason Dillaman)
-   librbd: handle aio failure in ManagedLock and PreReleaseRequest
    ([pr#20112](https://github.com/ceph/ceph/pull/20112), liyichao)
-   librbd: improve object map performance under high IOPS workloads
    ([issue#38538](http://tracker.ceph.com/issues/38538),
    [pr#26721](https://github.com/ceph/ceph/pull/26721), Jason Dillaman)
-   librbd: journaling unable request can not be sent to remote lock
    owner ([issue#26939](http://tracker.ceph.com/issues/26939),
    [pr#23649](https://github.com/ceph/ceph/pull/23649), Mykola Golub)
-   librbd: keep access/modified timestamp updates out of IO path
    ([issue#37745](http://tracker.ceph.com/issues/37745),
    [pr#25883](https://github.com/ceph/ceph/pull/25883), Jason Dillaman)
-   librbd: make it possible to migrate parent images
    ([pr#25945](https://github.com/ceph/ceph/pull/25945), Mykola Golub)
-   librbd: move mirror peer attribute handling from CLI to API
    ([pr#25096](https://github.com/ceph/ceph/pull/25096), Jason
    Dillaman)
-   librbd: namespace create/remove/list support
    ([pr#22608](https://github.com/ceph/ceph/pull/22608), Jason
    Dillaman)
-   librbd: object copy state machine might dereference a deleted object
    ([issue#36220](http://tracker.ceph.com/issues/36220),
    [pr#24293](https://github.com/ceph/ceph/pull/24293), Jason Dillaman)
-   librbd: object map improperly flagged as invalidated
    ([issue#24516](http://tracker.ceph.com/issues/24516),
    [pr#24105](https://github.com/ceph/ceph/pull/24105), Jason Dillaman)
-   librbd: optionally limit journal in-flight appends
    ([pr#22983](https://github.com/ceph/ceph/pull/22983), Mykola Golub)
-   librbd:optionally support FUA (force unit access) on write requests
    ([issue#19366](http://tracker.ceph.com/issues/19366),
    [pr#22945](https://github.com/ceph/ceph/pull/22945), ningtao)
-   librbd: pool and image level config overrides
    ([pr#23743](https://github.com/ceph/ceph/pull/23743), Mykola Golub)
-   librbd: potential object map race with copyup state machine
    ([issue#24516](http://tracker.ceph.com/issues/24516),
    [pr#24253](https://github.com/ceph/ceph/pull/24253), Jason Dillaman)
-   librbd: potential race on image create request complete
    ([issue#24910](http://tracker.ceph.com/issues/24910),
    [pr#23639](https://github.com/ceph/ceph/pull/23639), Mykola Golub)
-   librbd: prevent the use of internal feature bits from external users
    ([issue#24165](http://tracker.ceph.com/issues/24165),
    [pr#22072](https://github.com/ceph/ceph/pull/22072), Jason Dillaman)
-   librbd: prevent use of namespaces on pre-nautilus OSDs
    ([pr#23823](https://github.com/ceph/ceph/pull/23823), Jason
    Dillaman)
-   librbd: properly filter out trashed non-user images on purge
    ([pr#26079](https://github.com/ceph/ceph/pull/26079), Mykola Golub)
-   librbd: properly handle potential object map failures
    ([issue#36074](http://tracker.ceph.com/issues/36074),
    [pr#24179](https://github.com/ceph/ceph/pull/24179), Jason Dillaman)
-   librbd: race condition possible when validating RBD pool
    ([issue#38500](http://tracker.ceph.com/issues/38500),
    [pr#26683](https://github.com/ceph/ceph/pull/26683), Jason Dillaman)
-   librbd: reduce the TokenBucket fill cycle and support bursting io
    configuration ([pr#24214](https://github.com/ceph/ceph/pull/24214),
    Shiyang Ruan)
-   librbd: remove template declaration of a non-template function
    ([pr#23790](https://github.com/ceph/ceph/pull/23790), Shiyang Ruan)
-   librbd: reset snaps in rbd_snap_list()
    ([issue#37508](http://tracker.ceph.com/issues/37508),
    [pr#25379](https://github.com/ceph/ceph/pull/25379), Kefu Chai)
-   librbd: restart io if migration parent gone
    ([issue#36710](http://tracker.ceph.com/issues/36710),
    [pr#25175](https://github.com/ceph/ceph/pull/25175), Mykola Golub)
-   librbd: send_copyup() fixes and cleanups
    ([pr#26483](https://github.com/ceph/ceph/pull/26483), Ilya Dryomov)
-   librbd: simplify config override handling
    ([pr#24450](https://github.com/ceph/ceph/pull/24450), Jason
    Dillaman)
-   librbd: skip small, unaligned discard extents by default
    ([issue#38146](http://tracker.ceph.com/issues/38146),
    [pr#26432](https://github.com/ceph/ceph/pull/26432), Jason Dillaman)
-   librbd: support bps throttle and throttle read and write seperately
    ([pr#21635](https://github.com/ceph/ceph/pull/21635), Dongsheng
    Yang)
-   librbd: support migrating images with minimal downtime
    ([issue#18430](http://tracker.ceph.com/issues/18430),
    [issue#24439](http://tracker.ceph.com/issues/24439),
    [issue#26874](http://tracker.ceph.com/issues/26874),
    [issue#23659](http://tracker.ceph.com/issues/23659),
    [pr#15831](https://github.com/ceph/ceph/pull/15831), Patrick
    Donnelly, Sage Weil, Alfredo Deza, Kefu Chai, Patrick Nawracay,
    Pavani Rajula, Mykola Golub, Casey Bodley, Yingxin, Jason Dillaman)
-   librbd: support v2 cloning across namespaces
    ([pr#23662](https://github.com/ceph/ceph/pull/23662), Jason
    Dillaman)
-   librbd: use object map when doing snap rollback
    ([pr#23110](https://github.com/ceph/ceph/pull/23110), songweibin)
-   librbd: utilize the journal disabled policy when removing images
    ([issue#23512](http://tracker.ceph.com/issues/23512),
    [pr#22327](https://github.com/ceph/ceph/pull/22327), Jason Dillaman)
-   librbd: validate data pool for self-managed snapshot support
    ([pr#22737](https://github.com/ceph/ceph/pull/22737), Mykola Golub)
-   librbd: workaround an ICE of GCC
    ([issue#37719](http://tracker.ceph.com/issues/37719),
    [pr#25733](https://github.com/ceph/ceph/pull/25733), Kefu Chai)
-   log: avoid heap allocations for most log entries
    ([pr#23721](https://github.com/ceph/ceph/pull/23721), Patrick
    Donnelly)
-   lvm: when osd creation fails log the exception
    ([issue#24456](http://tracker.ceph.com/issues/24456),
    [pr#22627](https://github.com/ceph/ceph/pull/22627), Andrew Schoen)
-   mailmap,organization: Update sangfor affiliation
    ([pr#25225](https://github.com/ceph/ceph/pull/25225), Zengran Zhang)
-   mds: add reference when setting Connection::priv to existing session
    ([pr#22384](https://github.com/ceph/ceph/pull/22384), \"Yan,
    Zheng\")
-   mds: fix leak of MDSCacheObject::waiting
    ([issue#24289](http://tracker.ceph.com/issues/24289),
    [pr#22307](https://github.com/ceph/ceph/pull/22307), \"Yan, Zheng\")
-   mds: fix some memory leak
    ([issue#24289](http://tracker.ceph.com/issues/24289),
    [pr#22240](https://github.com/ceph/ceph/pull/22240), \"Yan, Zheng\")
-   mds,messages: silence -Wclass-memaccess warnings
    ([pr#21845](https://github.com/ceph/ceph/pull/21845), Kefu Chai)
-   mds: properly journal root inode\'s snaprealm
    ([issue#24343](http://tracker.ceph.com/issues/24343),
    [pr#22320](https://github.com/ceph/ceph/pull/22320), \"Yan, Zheng\")
-   mds: remove obsolete comments
    ([pr#25549](https://github.com/ceph/ceph/pull/25549), Patrick
    Donnelly)
-   mds: reply session reject for open request from blacklisted client
    ([pr#21941](https://github.com/ceph/ceph/pull/21941), Yan, Zheng,
    \"Yan, Zheng\")
-   mgr: Add ability to trigger a cluster/audit log message from Python
    ([pr#24239](https://github.com/ceph/ceph/pull/24239), Volker Theile)
-   mgr: Add [HandleCommandResult]{.title-ref} namedtuple
    ([pr#25261](https://github.com/ceph/ceph/pull/25261), Sebastian
    Wagner)
-   mgr: add limit param to osd perf query
    ([pr#25151](https://github.com/ceph/ceph/pull/25151), Mykola Golub)
-   mgr: add per pool force-recovery/backfill commands
    ([issue#38456](http://tracker.ceph.com/issues/38456),
    [pr#26560](https://github.com/ceph/ceph/pull/26560), xie xingguo)
-   mgr: add per pool scrub commands
    ([pr#26532](https://github.com/ceph/ceph/pull/26532), xie xingguo)
-   mgr: Allow modules to get/set other module options
    ([pr#25651](https://github.com/ceph/ceph/pull/25651), Volker Theile)
-   mgr: Allow rook to scale the mon count
    ([pr#26405](https://github.com/ceph/ceph/pull/26405), Jeff Layton)
-   mgr: always on modules v2
    ([pr#23970](https://github.com/ceph/ceph/pull/23970), Noah Watkins)
-   mgr/ansible: Add/remove hosts
    ([pr#26241](https://github.com/ceph/ceph/pull/26241), Juan Miguel
    Olmo Martínez)
-   mgr/ansible: Replace Ansible playbook used to retrieve storage
    devices data ([pr#26023](https://github.com/ceph/ceph/pull/26023),
    Juan Miguel Olmo Martínez)
-   mgr/ansible: Replace deprecated \<get_config\> calls
    ([pr#25964](https://github.com/ceph/ceph/pull/25964), Juan Miguel
    Olmo Martínez)
-   mgr: Centralize PG_STATES to MgrModule
    ([pr#22594](https://github.com/ceph/ceph/pull/22594), Wido den
    Hollander)
-   mgr: ceph-mgr: hold lock while accessing the request list and
    submitting request
    ([pr#25048](https://github.com/ceph/ceph/pull/25048), Jerry Lee)
-   mgr: change \'bytes\' dynamic perf counters to COUNTER type
    ([pr#25908](https://github.com/ceph/ceph/pull/25908), Mykola Golub)
-   mgr: create always on class of modules
    ([pr#23106](https://github.com/ceph/ceph/pull/23106), Noah Watkins)
-   mgr: create shell OSD performance query class
    ([pr#24117](https://github.com/ceph/ceph/pull/24117), Mykola Golub)
-   mgr/dashboard: About modal proposed changes
    ([issue#35693](http://tracker.ceph.com/issues/35693),
    [pr#25376](https://github.com/ceph/ceph/pull/25376), Kanika Murarka)
-   mgr/dashboard: Add ability to list,set and unset cluster-wide OSD
    flags to the backend
    ([issue#24056](http://tracker.ceph.com/issues/24056),
    [pr#21998](https://github.com/ceph/ceph/pull/21998), Patrick
    Nawracay)
-   mgr/dashboard: Add a \'clear filter\' button to configuration page
    ([issue#36173](http://tracker.ceph.com/issues/36173),
    [pr#25712](https://github.com/ceph/ceph/pull/25712), familyuu)
-   mgr/dashboard: add a script to run an API request on a rook cluster
    ([pr#25991](https://github.com/ceph/ceph/pull/25991), Jeff Layton)
-   mgr/dashboard: Add a unit test form helper class
    ([pr#24633](https://github.com/ceph/ceph/pull/24633), Stephan
    Müller)
-   mgr/dashboard: Add backend support for changing dashboard
    configuration settings via the REST API
    ([pr#22457](https://github.com/ceph/ceph/pull/22457), Patrick
    Nawracay)
-   mgr/dashboard: Add breadcrumbs component
    ([issue#24781](http://tracker.ceph.com/issues/24781),
    [pr#23414](https://github.com/ceph/ceph/pull/23414), Tiago Melo)
-   mgr/dashboard: add columns to Pools table
    ([pr#25791](https://github.com/ceph/ceph/pull/25791), Alfonso
    Martínez)
-   mgr/dashboard: Add decorator to skip parameter encoding
    ([issue#26856](http://tracker.ceph.com/issues/26856),
    [pr#23419](https://github.com/ceph/ceph/pull/23419), Tiago Melo)
-   mgr/dashboard: Add description to menu items on mobile navigation
    ([pr#26198](https://github.com/ceph/ceph/pull/26198), Sebastian
    Krah)
-   mgr/dashboard: added command to tox.ini
    ([pr#26073](https://github.com/ceph/ceph/pull/26073), Alfonso
    Martínez)
-   mgr/dashboard: added \'env_build\' to \'npm run e2e\'
    ([pr#26165](https://github.com/ceph/ceph/pull/26165), Alfonso
    Martínez)
-   mgr/dashboard: Added new validators
    ([pr#22526](https://github.com/ceph/ceph/pull/22526), Stephan
    Müller)
-   mgr/dashboard: Add error handling on the frontend
    ([pr#21820](https://github.com/ceph/ceph/pull/21820), Tiago Melo)
-   mgr/dashboard: add Feature Toggles
    ([issue#37530](http://tracker.ceph.com/issues/37530),
    [pr#26102](https://github.com/ceph/ceph/pull/26102), Ernesto Puerta)
-   mgr/dashboard: Add Filesystems list component
    ([pr#21913](https://github.com/ceph/ceph/pull/21913), Tiago Melo)
-   mgr/dashboard: Add filtered rows number in table footer
    ([pr#22504](https://github.com/ceph/ceph/pull/22504), Tiago Melo)
-   mgr/dashboard: Add gap between panel footer buttons
    ([pr#23796](https://github.com/ceph/ceph/pull/23796), Volker Theile)
-   mgr/dashboard: Add guideline how to brand the UI and update the
    color scheme ([pr#25988](https://github.com/ceph/ceph/pull/25988),
    Sebastian Krah)
-   mgr/dashboard: Add help menu entry
    ([pr#22303](https://github.com/ceph/ceph/pull/22303), Ricardo
    Marques)
-   mgr/dashboard: Add i18n support
    ([pr#24803](https://github.com/ceph/ceph/pull/24803), Sebastian
    Krah, Tiago Melo)
-   mgr/dashboard: Add implicit wait in e2e tests
    ([pr#26384](https://github.com/ceph/ceph/pull/26384), Tiago Melo)
-   mgr/dashboard: Add info to Pools table
    ([pr#25489](https://github.com/ceph/ceph/pull/25489), Alfonso
    Martínez)
-   mgr/dashboard: Add iSCSI discovery authentication UI
    ([pr#26320](https://github.com/ceph/ceph/pull/26320), Tiago Melo)
-   mgr/dashboard: Add iSCSI Target Edit UI
    ([issue#38014](http://tracker.ceph.com/issues/38014),
    [pr#26367](https://github.com/ceph/ceph/pull/26367), Tiago Melo)
-   mgr/dashboard: Add left padding to helper icon
    ([pr#24631](https://github.com/ceph/ceph/pull/24631), Stephan
    Müller)
-   mgr/dashboard: Add missing frontend I18N
    ([issue#36719](http://tracker.ceph.com/issues/36719),
    [pr#25654](https://github.com/ceph/ceph/pull/25654), Tiago Melo)
-   mgr/dashboard: Add missing test requirement \"werkzeug\"
    ([pr#24628](https://github.com/ceph/ceph/pull/24628), Stephan
    Müller)
-   mgr/dashboard: Add NFS status endpoint
    ([issue#38399](http://tracker.ceph.com/issues/38399),
    [pr#26539](https://github.com/ceph/ceph/pull/26539), Tiago Melo)
-   mgr/dashboard: Add \'no-unused-variable\' rule to tslint
    ([pr#22328](https://github.com/ceph/ceph/pull/22328), Tiago Melo)
-   mgr/dashboard: Add permission validation to the \"Purge Trash\"
    button ([issue#36272](http://tracker.ceph.com/issues/36272),
    [pr#24370](https://github.com/ceph/ceph/pull/24370), Tiago Melo)
-   mgr/dashboard: Add pool cache tiering details tab
    ([issue#25158](http://tracker.ceph.com/issues/25158),
    [pr#25602](https://github.com/ceph/ceph/pull/25602), familyuu)
-   mgr/dashboard: Add Pool update endpoint
    ([pr#21881](https://github.com/ceph/ceph/pull/21881), Sebastian
    Wagner, Stephan Müller)
-   mgr/dashboard: Add Prettier formatter to the frontend
    ([pr#21819](https://github.com/ceph/ceph/pull/21819), Tiago Melo)
-   mgr/dashboard: add profiles to set cluster\'s rebuild performance
    ([pr#24968](https://github.com/ceph/ceph/pull/24968), Tatjana
    Dehler)
-   mgr/dashboard: add pytest plugin: faulthandler
    ([pr#25053](https://github.com/ceph/ceph/pull/25053), Alfonso
    Martínez)
-   mgr/dashboard: Add REST API for role management
    ([pr#23322](https://github.com/ceph/ceph/pull/23322), Ricardo
    Marques)
-   mgr/dashboard: Add scrub action to the OSDs table
    ([pr#22122](https://github.com/ceph/ceph/pull/22122), Tiago Melo)
-   mgr/dashboard: Adds custom timepicker for grafana iframes
    ([pr#25583](https://github.com/ceph/ceph/pull/25583), Kanika
    Murarka)
-   mgr/dashboard: Adds ECP management to the frontend
    ([pr#24627](https://github.com/ceph/ceph/pull/24627), Stephan
    Müller)
-   mgr/dashboard: Add shared Confirmation Modal
    ([pr#22601](https://github.com/ceph/ceph/pull/22601), Tiago Melo)
-   mgr/dashboard: add supported flag information to config options
    documentation ([pr#22760](https://github.com/ceph/ceph/pull/22760),
    Tatjana Dehler)
-   mgr/dashboard: Add support for iSCSI\'s multi backstores (UI)
    ([pr#26575](https://github.com/ceph/ceph/pull/26575), Tiago Melo)
-   mgr/dashboard: Add support for managing individual OSD
    settings/characteristics in the frontend
    ([issue#36487](http://tracker.ceph.com/issues/36487),
    [issue#36444](http://tracker.ceph.com/issues/36444),
    [issue#35448](http://tracker.ceph.com/issues/35448),
    [issue#36188](http://tracker.ceph.com/issues/36188),
    [issue#35811](http://tracker.ceph.com/issues/35811),
    [issue#35816](http://tracker.ceph.com/issues/35816),
    [issue#36086](http://tracker.ceph.com/issues/36086),
    [pr#24606](https://github.com/ceph/ceph/pull/24606), Patrick
    Nawracay)
-   mgr/dashboard: Add support for managing individual OSD settings in
    the backend ([issue#24270](http://tracker.ceph.com/issues/24270),
    [pr#23491](https://github.com/ceph/ceph/pull/23491), Patrick
    Nawracay)
-   mgr/dashboard: Add support for managing RBD QoS
    ([issue#37572](http://tracker.ceph.com/issues/37572),
    [issue#38004](http://tracker.ceph.com/issues/38004),
    [issue#37570](http://tracker.ceph.com/issues/37570),
    [issue#37936](http://tracker.ceph.com/issues/37936),
    [issue#37574](http://tracker.ceph.com/issues/37574),
    [issue#36191](http://tracker.ceph.com/issues/36191),
    [issue#37845](http://tracker.ceph.com/issues/37845),
    [issue#37569](http://tracker.ceph.com/issues/37569),
    [pr#25233](https://github.com/ceph/ceph/pull/25233), Patrick
    Nawracay)
-   mgr/dashboard: Add support for RBD Trash
    ([issue#24272](http://tracker.ceph.com/issues/24272),
    [pr#23351](https://github.com/ceph/ceph/pull/23351), Tiago Melo)
-   mgr/dashboard: Add support for URI encode
    ([issue#24621](http://tracker.ceph.com/issues/24621),
    [pr#22672](https://github.com/ceph/ceph/pull/22672), Tiago Melo)
-   mgr/dashboard: Add table actions component
    ([pr#23779](https://github.com/ceph/ceph/pull/23779), Stephan
    Müller)
-   mgr/dashboard: Add table of contents to HACKING.rst
    ([pr#25812](https://github.com/ceph/ceph/pull/25812), Sebastian
    Krah)
-   mgr/dashboard: Add token authentication to Grafana proxy
    ([pr#22459](https://github.com/ceph/ceph/pull/22459), Patrick
    Nawracay)
-   mgr/dashboard: Add TSLint rule \"no-unused-variable\"
    ([pr#24699](https://github.com/ceph/ceph/pull/24699), Alfonso
    Martínez)
-   mgr/dashboard: Add UI for Cluster-wide OSD Flags configuration
    ([pr#22461](https://github.com/ceph/ceph/pull/22461), Tiago Melo)
-   mgr/dashboard: Add UI for disabling ACL authentication
    ([issue#38218](http://tracker.ceph.com/issues/38218),
    [pr#26388](https://github.com/ceph/ceph/pull/26388), Tiago Melo)
-   mgr/dashboard: Add UI to configure the telemetry mgr plugin
    ([pr#25989](https://github.com/ceph/ceph/pull/25989), Volker Theile)
-   mgr/dashboard: Add unique validator
    ([pr#23802](https://github.com/ceph/ceph/pull/23802), Volker Theile)
-   mgr/dashboard: Allow \"/\" in pool name
    ([issue#38302](http://tracker.ceph.com/issues/38302),
    [pr#26408](https://github.com/ceph/ceph/pull/26408), Tiago Melo)
-   mgr/dashboard: Allow insecure HTTPS in run-backend-api-request
    ([pr#21882](https://github.com/ceph/ceph/pull/21882), Sebastian
    Wagner)
-   mgr/dashboard: Allow renaming an existing Pool
    ([issue#36560](http://tracker.ceph.com/issues/36560),
    [pr#25107](https://github.com/ceph/ceph/pull/25107), guodan1)
-   mgr/dashboard: Audit REST API calls
    ([pr#24475](https://github.com/ceph/ceph/pull/24475), Volker Theile)
-   mgr/dashboard: Auto-create a name for RBD image snapshots
    ([pr#23735](https://github.com/ceph/ceph/pull/23735), Volker Theile)
-   mgr/dashboard: avoid blank content in Read/Write Card
    ([pr#25563](https://github.com/ceph/ceph/pull/25563), Alfonso
    Martínez)
-   mgr/dashboard: awsauth: fix python3 string decode problem
    ([pr#21794](https://github.com/ceph/ceph/pull/21794), Ricardo Dias)
-   mgr/dashboard: Can\'t handle user editing when tenants are specified
    ([pr#24757](https://github.com/ceph/ceph/pull/24757), Volker Theile)
-   mgr/dashboard: Catch LookupError when checking the RGW status
    ([pr#24028](https://github.com/ceph/ceph/pull/24028), Volker Theile)
-   mgr/dashboard: CdFormGroup
    ([pr#22644](https://github.com/ceph/ceph/pull/22644), Stephan
    Müller)
-   mgr/dashboard: Ceph dashboard user management from the UI
    ([pr#22758](https://github.com/ceph/ceph/pull/22758), Ricardo
    Marques)
-   mgr/dashboard: Change \'Client Recovery\' title
    ([pr#26883](https://github.com/ceph/ceph/pull/26883), Ernesto
    Puerta)
-   mgr/dashboard: Changed background color of Masthead to brand gray
    ([issue#35690](http://tracker.ceph.com/issues/35690),
    [pr#25628](https://github.com/ceph/ceph/pull/25628), Neha Gupta)
-   mgr/dashboard: Changed default value of decimal point to 1
    ([pr#22386](https://github.com/ceph/ceph/pull/22386), Tiago Melo)
-   mgr/dashboard: Change icon color in notifications
    ([pr#26586](https://github.com/ceph/ceph/pull/26586), Volker Theile)
-   mgr/dashboard: Check content-type before decode json response
    ([pr#24350](https://github.com/ceph/ceph/pull/24350), Ricardo
    Marques)
-   mgr/dashboard: check for existence of Grafana dashboard
    ([issue#36356](http://tracker.ceph.com/issues/36356),
    [pr#25154](https://github.com/ceph/ceph/pull/25154), Kanika Murarka)
-   mgr/dashboard: Cleanup of OSD list methods
    ([pr#24823](https://github.com/ceph/ceph/pull/24823), Stephan
    Müller)
-   mgr/dashboard: Cleanup of the cluster and audit log
    ([pr#26188](https://github.com/ceph/ceph/pull/26188), Sebastian
    Krah)
-   mgr/dashboard: Cleanup
    ([pr#24831](https://github.com/ceph/ceph/pull/24831), Patrick
    Nawracay)
-   mgr/dashboard: Clean up pylint\'s
    [disable:no-else-return]{.title-ref}
    ([pr#26509](https://github.com/ceph/ceph/pull/26509), Patrick
    Nawracay)
-   mgr/dashboard: Cleanup Python code
    ([pr#26743](https://github.com/ceph/ceph/pull/26743), Volker Theile)
-   mgr/dashboard: Cleanup RGW config checks
    ([pr#22669](https://github.com/ceph/ceph/pull/22669), Volker Theile)
-   mgr/dashboard: Close modal dialogs on login screen
    ([pr#23328](https://github.com/ceph/ceph/pull/23328), Volker Theile)
-   mgr/dashboard: code cleanup
    ([pr#25502](https://github.com/ceph/ceph/pull/25502), Alfonso
    Martínez)
-   mgr/dashboard: Color variables for color codes
    ([issue#24575](http://tracker.ceph.com/issues/24575),
    [pr#22695](https://github.com/ceph/ceph/pull/22695), Kanika Murarka)
-   mgr/dashboard config options add
    ([issue#34528](http://tracker.ceph.com/issues/34528),
    [issue#24996](http://tracker.ceph.com/issues/24996),
    [issue#24455](http://tracker.ceph.com/issues/24455),
    [issue#36173](http://tracker.ceph.com/issues/36173),
    [pr#23230](https://github.com/ceph/ceph/pull/23230), Tatjana Dehler)
-   mgr/dashboard: Config options integration (read-only) depends on
    #22422 ([pr#21460](https://github.com/ceph/ceph/pull/21460), Tatjana
    Dehler)
-   mgr/dashboard: config options table cleanup
    ([issue#34533](http://tracker.ceph.com/issues/34533),
    [pr#24523](https://github.com/ceph/ceph/pull/24523), Tatjana Dehler)
-   mgr/dashboard: config option type names update
    ([issue#37843](http://tracker.ceph.com/issues/37843),
    [pr#25876](https://github.com/ceph/ceph/pull/25876), Tatjana Dehler)
-   mgr/dashboard: configs textarea disallow horizontal resize
    ([issue#36452](http://tracker.ceph.com/issues/36452),
    [pr#24614](https://github.com/ceph/ceph/pull/24614), Tatjana Dehler)
-   mgr/dashboard: Configure all mgr modules in UI
    ([pr#26116](https://github.com/ceph/ceph/pull/26116), Volker Theile)
-   mgr/dashboard: Confirmation modal doesn\'t close
    ([pr#24544](https://github.com/ceph/ceph/pull/24544), Volker Theile)
-   mgr/dashboard: Confusing tilted time stamps in the CephFS
    performance graph
    ([pr#25909](https://github.com/ceph/ceph/pull/25909), Volker Theile)
-   mgr/dashboard: consider config option default values
    ([issue#37683](http://tracker.ceph.com/issues/37683),
    [pr#25616](https://github.com/ceph/ceph/pull/25616), Tatjana Dehler)
-   mgr/dashboard: controller infrastructure refactor and new features
    ([pr#22210](https://github.com/ceph/ceph/pull/22210), Patrick
    Nawracay, Ricardo Dias)
-   mgr/dashboard: Correct permission decorator
    ([pr#26135](https://github.com/ceph/ceph/pull/26135), Tina Kallio)
-   mgr/dashboard: CRUSH map viewer
    ([issue#35684](http://tracker.ceph.com/issues/35684),
    [pr#24766](https://github.com/ceph/ceph/pull/24766), familyuu)
-   mgr/dashboard: CRUSH map viewer RFE
    ([issue#37794](http://tracker.ceph.com/issues/37794),
    [pr#26162](https://github.com/ceph/ceph/pull/26162), familyuu)
-   mgr/dashboard: Dashboard info cards refactoring
    ([pr#22902](https://github.com/ceph/ceph/pull/22902), Alfonso
    Martínez)
-   mgr/dashboard: Datatable error panel blinking on page loading
    ([pr#23316](https://github.com/ceph/ceph/pull/23316), Volker Theile)
-   mgr/dashboard: Deletion dialog falsely executes deletion when
    pressing \'Cancel\'
    ([pr#22003](https://github.com/ceph/ceph/pull/22003), Volker Theile)
-   mgr/dashboard: Disable package-lock.json creation
    ([pr#22061](https://github.com/ceph/ceph/pull/22061), Tiago Melo)
-   mgr/dashboard: Disable RBD actions during task execution
    ([pr#23445](https://github.com/ceph/ceph/pull/23445), Ricardo
    Marques)
-   mgr/dashboard: disallow editing read-only config options (part 2)
    ([pr#26450](https://github.com/ceph/ceph/pull/26450), Tatjana
    Dehler)
-   mgr/dashboard: disallow editing read-only config options
    ([pr#26297](https://github.com/ceph/ceph/pull/26297), Tatjana
    Dehler)
-   mgr/dashboard: Display logged in user
    ([issue#24822](http://tracker.ceph.com/issues/24822),
    [pr#24213](https://github.com/ceph/ceph/pull/24213), guodan1,
    guodan)
-   mgr/dashboard: Display notification if RGW is not configured
    ([pr#21785](https://github.com/ceph/ceph/pull/21785), Volker Theile)
-   mgr/dashboard: Display RGW user/bucket quota max size in human
    readable form ([pr#23842](https://github.com/ceph/ceph/pull/23842),
    Volker Theile)
-   mgr/dashboard: Do not fetch pool list on RBD edit
    ([pr#22404](https://github.com/ceph/ceph/pull/22404), Ricardo
    Marques)
-   mgr/dashboard: Do not require cert for http
    ([issue#36069](http://tracker.ceph.com/issues/36069),
    [pr#24103](https://github.com/ceph/ceph/pull/24103), Boris Ranto)
-   mgr/dashboard: Drop iSCSI gateway name parameter
    ([pr#26984](https://github.com/ceph/ceph/pull/26984), Ricardo
    Marques)
-   mgr/dashboard: enable coverage for API tests
    ([pr#26851](https://github.com/ceph/ceph/pull/26851), Alfonso
    Martínez)
-   mgr/dashboard: Escape regex pattern in DeletionModalComponent
    ([issue#24902](http://tracker.ceph.com/issues/24902),
    [pr#23420](https://github.com/ceph/ceph/pull/23420), Tiago Melo)
-   mgr/dashboard: Exception.message doesn\'t exist on Python 3
    ([pr#24349](https://github.com/ceph/ceph/pull/24349), Ricardo
    Marques)
-   mgr/dashboard: Extract/Refactor Task merge
    ([pr#23555](https://github.com/ceph/ceph/pull/23555), Stephan
    Müller, Tiago Melo)
-   mgr/dashboard: Filter out tasks depending on permissions
    ([pr#25426](https://github.com/ceph/ceph/pull/25426), Tina Kallio)
-   mgr/dashboard: Fix /api/grafana/validation
    ([pr#25997](https://github.com/ceph/ceph/pull/25997), Zack Cerza)
-   mgr/dashboard: Fix bug in user form when changing password
    ([pr#23939](https://github.com/ceph/ceph/pull/23939), Volker Theile)
-   mgr/dashboard: Fix cherrypy static content URL prefix config
    ([pr#23183](https://github.com/ceph/ceph/pull/23183), Ricardo
    Marques)
-   mgr/dashboard: Fix duplicate error messages
    ([pr#23287](https://github.com/ceph/ceph/pull/23287), Stephan
    Müller)
-   mgr/dashboard: Fix duplicate tasks
    ([pr#24930](https://github.com/ceph/ceph/pull/24930), Tiago Melo)
-   mgr/dashboard: Fix e2e script
    ([pr#22903](https://github.com/ceph/ceph/pull/22903), Tiago Melo)
-   mgr/dashboard: Fixed performance details context for host list row
    selection ([issue#37854](http://tracker.ceph.com/issues/37854),
    [pr#26020](https://github.com/ceph/ceph/pull/26020), Neha Gupta)
-   mgr/dashboard: Fixed typos in environment.build.js
    ([pr#26650](https://github.com/ceph/ceph/pull/26650), Lenz Grimmer)
-   mgr/dashboard: Fix error when clicking on newly created OSD
    ([issue#36245](http://tracker.ceph.com/issues/36245),
    [pr#24369](https://github.com/ceph/ceph/pull/24369), Patrick
    Nawracay)
-   mgr/dashboard: Fixes documentation link- to open in new tab
    ([pr#22237](https://github.com/ceph/ceph/pull/22237), a2batic)
-   mgr/dashboard: Fixes Grafana 500 error
    ([issue#37809](http://tracker.ceph.com/issues/37809),
    [pr#25830](https://github.com/ceph/ceph/pull/25830), Kanika Murarka)
-   mgr/dashboard: Fix failing QA test: test_safe_to_destroy
    ([issue#37290](http://tracker.ceph.com/issues/37290),
    [pr#25149](https://github.com/ceph/ceph/pull/25149), Patrick
    Nawracay)
-   mgr/dashboard: Fix flaky QA tests
    ([pr#24024](https://github.com/ceph/ceph/pull/24024), Patrick
    Nawracay)
-   mgr/dashboard: Fix Forbidden Error with some roles
    ([issue#37293](http://tracker.ceph.com/issues/37293),
    [pr#25141](https://github.com/ceph/ceph/pull/25141), Ernesto Puerta)
-   mgr/dashboard: fix for \'Cluster \>\> Hosts\' page
    ([pr#24974](https://github.com/ceph/ceph/pull/24974), Alfonso
    Martínez)
-   mgr/dashboard: Fix formatter service unit test
    ([pr#22323](https://github.com/ceph/ceph/pull/22323), Tiago Melo)
-   mgr/dashboard: fix for using \'::\' on hosts without ipv6
    ([pr#26635](https://github.com/ceph/ceph/pull/26635), Noah Watkins)
-   mgr/dashboard: Fix growing table in firefox
    ([issue#26999](http://tracker.ceph.com/issues/26999),
    [pr#23711](https://github.com/ceph/ceph/pull/23711), Tiago Melo)
-   mgr/dashboard: Fix HttpClient Module imports in unit tests
    ([pr#24679](https://github.com/ceph/ceph/pull/24679), Tiago Melo)
-   mgr/dashboard: Fix iSCSI mutual password input type
    ([pr#26854](https://github.com/ceph/ceph/pull/26854), Ricardo
    Marques)
-   mgr/dashboard: Fix iSCSI service unit tests
    ([pr#26319](https://github.com/ceph/ceph/pull/26319), Tiago Melo)
-   mgr/dashboard: Fix issues in controllers/docs
    ([pr#26738](https://github.com/ceph/ceph/pull/26738), Volker Theile)
-   mgr/dashboard: Fix Jest conflict with coverage files
    ([pr#22155](https://github.com/ceph/ceph/pull/22155), Tiago Melo)
-   mgr/dashboard: Fix layout issues in UI
    ([issue#24525](http://tracker.ceph.com/issues/24525),
    [pr#22597](https://github.com/ceph/ceph/pull/22597), Volker Theile)
-   mgr/dashboard: Fix links to external documentation
    ([pr#24829](https://github.com/ceph/ceph/pull/24829), Patrick
    Nawracay)
-   mgr/dashboard: fix lint error caused by codelyzer update
    ([pr#22693](https://github.com/ceph/ceph/pull/22693), Tiago Melo)
-   mgr/dashboard: fix lint error
    ([pr#22417](https://github.com/ceph/ceph/pull/22417), Tiago Melo)
-   mgr/dashboard: Fix long running RBD cloning / copying message
    ([pr#24641](https://github.com/ceph/ceph/pull/24641), Ricardo
    Marques)
-   mgr/dashboard: Fix missing failed restore notification
    ([issue#36513](http://tracker.ceph.com/issues/36513),
    [pr#24664](https://github.com/ceph/ceph/pull/24664), Tiago Melo)
-   mgr/dashboard: Fix modified files only (frontend)
    ([pr#25346](https://github.com/ceph/ceph/pull/25346), Patrick
    Nawracay)
-   mgr/dashboard: Fix moment.js deprecation warning
    ([pr#21981](https://github.com/ceph/ceph/pull/21981), Tiago Melo)
-   mgr/dashboard: Fix more layout issues in UI
    ([pr#22600](https://github.com/ceph/ceph/pull/22600), Volker Theile)
-   mgr/dashboard: Fix navbar focused color
    ([pr#25769](https://github.com/ceph/ceph/pull/25769), Volker Theile)
-   mgr/dashboard: Fix notifications in user list and form
    ([pr#23797](https://github.com/ceph/ceph/pull/23797), Volker Theile)
-   mgr/dashboard: Fix OSD down error display
    ([issue#24530](http://tracker.ceph.com/issues/24530),
    [pr#23754](https://github.com/ceph/ceph/pull/23754), Patrick
    Nawracay)
-   mgr/dashboard: Fix pool usage not displaying on filesystem page
    ([pr#22453](https://github.com/ceph/ceph/pull/22453), Tiago Melo)
-   mgr/dashboard: Fix problem with ErasureCodeProfileService
    ([pr#24694](https://github.com/ceph/ceph/pull/24694), Tiago Melo)
-   mgr/dashboard: Fix Python3 issue
    ([pr#24617](https://github.com/ceph/ceph/pull/24617), Patrick
    Nawracay)
-   mgr/dashboard: fix query parameters in task annotated endpoints
    ([issue#25096](http://tracker.ceph.com/issues/25096),
    [pr#23229](https://github.com/ceph/ceph/pull/23229), Ricardo Dias)
-   mgr/dashboard: Fix RBD actions disable
    ([pr#24637](https://github.com/ceph/ceph/pull/24637), Ricardo
    Marques)
-   mgr/dashboard: Fix RBD features style
    ([pr#22759](https://github.com/ceph/ceph/pull/22759), Ricardo
    Marques)
-   mgr/dashboard: Fix RBD object size dropdown options
    ([pr#22830](https://github.com/ceph/ceph/pull/22830), Ricardo
    Marques)
-   mgr/dashboard: Fix RBD task metadata
    ([pr#22088](https://github.com/ceph/ceph/pull/22088), Tiago Melo)
-   mgr/dashboard: Fix redirect to login page on session lost
    ([pr#23388](https://github.com/ceph/ceph/pull/23388), Ricardo
    Marques)
-   mgr/dashboard: fix reference to oA
    ([pr#24343](https://github.com/ceph/ceph/pull/24343), Joao Eduardo
    Luis)
-   mgr/dashboard: Fix regression on rbd form component
    ([issue#24757](http://tracker.ceph.com/issues/24757),
    [pr#22829](https://github.com/ceph/ceph/pull/22829), Tiago Melo)
-   mgr/dashboard: Fix reloading of pool listing
    ([pr#26182](https://github.com/ceph/ceph/pull/26182), Patrick
    Nawracay)
-   mgr/dashboard: Fix renaming of pools
    ([pr#25423](https://github.com/ceph/ceph/pull/25423), Patrick
    Nawracay)
-   mgr/dashboard: Fix search in [Source]{.title-ref} column of RBD
    configuration list
    ([issue#37569](http://tracker.ceph.com/issues/37569),
    [pr#26765](https://github.com/ceph/ceph/pull/26765), Patrick
    Nawracay)
-   mgr/dashboard: fix skipped backend API tests
    ([pr#26172](https://github.com/ceph/ceph/pull/26172), Alfonso
    Martínez)
-   mgr/dashboard: Fix some datatable CSS issues
    ([pr#22216](https://github.com/ceph/ceph/pull/22216), Volker Theile)
-   mgr/dashboard: Fix spaces around status labels on OSD list
    ([pr#24607](https://github.com/ceph/ceph/pull/24607), Patrick
    Nawracay)
-   mgr/dashboard: Fix summary refresh call stack
    ([pr#25984](https://github.com/ceph/ceph/pull/25984), Tiago Melo)
-   mgr/dashboard: Fix test_full_health test
    ([issue#37872](http://tracker.ceph.com/issues/37872),
    [pr#25913](https://github.com/ceph/ceph/pull/25913), Tatjana Dehler)
-   mgr/dashboard: Fix test_remove_not_expired_trash qa test
    ([issue#37354](http://tracker.ceph.com/issues/37354),
    [pr#25221](https://github.com/ceph/ceph/pull/25221), Tiago Melo)
-   mgr/dashboard: fix: toast notifications hiding utility menu
    ([pr#26429](https://github.com/ceph/ceph/pull/26429), Alfonso
    Martínez)
-   mgr/dashboard: fix: tox not detecting deps changes
    ([pr#26409](https://github.com/ceph/ceph/pull/26409), Alfonso
    Martínez)
-   mgr/dashboard: Fix ts error on iSCSI page
    ([pr#24715](https://github.com/ceph/ceph/pull/24715), Ricardo
    Marques)
-   mgr/dashboard: Fix typo in NoOrchesrtatorConfiguredException class
    name ([pr#26334](https://github.com/ceph/ceph/pull/26334), Volker
    Theile)
-   mgr/dashboard: Fix typo in pools management
    ([pr#26323](https://github.com/ceph/ceph/pull/26323), Lenz Grimmer)
-   mgr/dashboard: Fix typo
    ([pr#23363](https://github.com/ceph/ceph/pull/23363), Volker Theile)
-   mgr/dashboard: Fix unit tests cli warnings
    ([pr#21933](https://github.com/ceph/ceph/pull/21933), Tiago Melo)
-   mgr/dashboard: Format small numbers correctly
    ([issue#24081](http://tracker.ceph.com/issues/24081),
    [pr#21980](https://github.com/ceph/ceph/pull/21980), Stephan Müller)
-   mgr/dashboard: Get user ID via RGW Admin Ops API
    ([pr#22416](https://github.com/ceph/ceph/pull/22416), Volker Theile)
-   mgr/dashboard: Grafana dashboard updates and additions
    ([pr#24314](https://github.com/ceph/ceph/pull/24314), Paul Cuzner)
-   mgr/dashboard: Grafana graphs integration with dashboard
    ([pr#23666](https://github.com/ceph/ceph/pull/23666), Kanika
    Murarka)
-   mgr/dashboard: Grafana proxy backend
    ([pr#21644](https://github.com/ceph/ceph/pull/21644), Patrick
    Nawracay)
-   mgr/dashboard: Group buttons together into one menu on OSD page
    ([issue#37380](http://tracker.ceph.com/issues/37380),
    [pr#26189](https://github.com/ceph/ceph/pull/26189), Tatjana Dehler)
-   mgr/dashboard: Handle class objects as regular objects in KV-table
    ([pr#24632](https://github.com/ceph/ceph/pull/24632), Stephan
    Müller)
-   mgr/dashboard: Handle errors during deletion
    ([pr#22002](https://github.com/ceph/ceph/pull/22002), Volker Theile)
-   mgr/dashboard: Hide empty fields and render all objects in KV-table
    ([pr#25894](https://github.com/ceph/ceph/pull/25894), Stephan
    Müller)
-   mgr/dashboard: Hide progress bar in case of an error
    ([pr#22419](https://github.com/ceph/ceph/pull/22419), Volker Theile)
-   mgr/dashboard: Implement OSD purge
    ([issue#35811](http://tracker.ceph.com/issues/35811),
    [pr#26242](https://github.com/ceph/ceph/pull/26242), Patrick
    Nawracay)
-   mgr/dashboard: Improve CRUSH map viewer
    ([pr#24934](https://github.com/ceph/ceph/pull/24934), Volker Theile)
-   mgr/dashboard: Improved support for generating OpenAPI Spec
    documentation ([issue#24763](http://tracker.ceph.com/issues/24763),
    [pr#26227](https://github.com/ceph/ceph/pull/26227), Tina Kallio)
-   mgr/dashboard: Improve error message handling
    ([pr#24322](https://github.com/ceph/ceph/pull/24322), Volker Theile)
-   mgr/dashboard: Improve error panel
    ([pr#21851](https://github.com/ceph/ceph/pull/21851), Volker Theile)
-   mgr/dashboard: Improve exception handling in /api/rgw/status
    ([pr#25836](https://github.com/ceph/ceph/pull/25836), Volker Theile)
-   mgr/dashboard: Improve exception handling
    ([issue#23823](http://tracker.ceph.com/issues/23823),
    [pr#21066](https://github.com/ceph/ceph/pull/21066), Sebastian
    Wagner)
-   mgr/dashboard: Improve [HACKING.rst]{.title-ref}
    ([pr#22281](https://github.com/ceph/ceph/pull/22281), Patrick
    Nawracay)
-   mgr/dashboard: Improve \'no pool\' message on rbd form
    ([pr#22150](https://github.com/ceph/ceph/pull/22150), Ricardo
    Marques)
-   mgr/dashboard: Improve RBD form
    ([issue#38303](http://tracker.ceph.com/issues/38303),
    [pr#26433](https://github.com/ceph/ceph/pull/26433), Tiago Melo)
-   mgr/dashboard: Improve RGW address parser
    ([pr#25870](https://github.com/ceph/ceph/pull/25870), Volker Theile)
-   mgr/dashboard: Improve RgwUser controller
    ([pr#25300](https://github.com/ceph/ceph/pull/25300), Volker Theile)
-   mgr/dashboard: Improves documentation for Grafana Setting
    ([issue#36371](http://tracker.ceph.com/issues/36371),
    [pr#24511](https://github.com/ceph/ceph/pull/24511), Kanika Murarka)
-   mgr/dashboard: Improve str_to_bool
    ([pr#22757](https://github.com/ceph/ceph/pull/22757), Volker Theile)
-   mgr/dashboard: Improve SummaryService and TaskWrapperService
    ([pr#22906](https://github.com/ceph/ceph/pull/22906), Tiago Melo)
-   mgr/dashboard: Improve table pagination style
    ([pr#22065](https://github.com/ceph/ceph/pull/22065), Ricardo
    Marques)
-   mgr/dashboard: Introduce pipe to convert bool to text
    ([pr#26507](https://github.com/ceph/ceph/pull/26507), Volker Theile)
-   mgr/dashboard: iscsi: adds CLI command to enable/disable API SSL
    verification ([pr#26891](https://github.com/ceph/ceph/pull/26891),
    Ricardo Dias)
-   mgr/dashboard: iSCSI - Adds support for pool/image names with dots
    ([pr#26503](https://github.com/ceph/ceph/pull/26503), Ricardo
    Marques)
-   mgr/dashboard: iSCSI - Add support for disabling ACL authentication
    (backend) ([pr#26382](https://github.com/ceph/ceph/pull/26382),
    Ricardo Marques)
-   mgr/dashboard: iSCSI discovery authentication API
    ([pr#26115](https://github.com/ceph/ceph/pull/26115), Ricardo
    Marques)
-   mgr/dashboard: iSCSI - Infrastructure for multiple backstores
    (backend) ([pr#26506](https://github.com/ceph/ceph/pull/26506),
    Ricardo Marques)
-   mgr/dashboard: iSCSI management API
    ([pr#25638](https://github.com/ceph/ceph/pull/25638), Ricardo
    Marques, Ricardo Dias)
-   mgr/dashboard: iSCSI management UI
    ([pr#25995](https://github.com/ceph/ceph/pull/25995), Ricardo
    Marques, Tiago Melo)
-   mgr/dashboard: iSCSI - Support iSCSI passwords with \'/\'
    ([pr#26790](https://github.com/ceph/ceph/pull/26790), Ricardo
    Marques)
-   mgr/dashboard: JWT authentication
    ([pr#22833](https://github.com/ceph/ceph/pull/22833), Ricardo Dias)
-   mgr/dashboard: Landing Page: chart improvements
    ([pr#24810](https://github.com/ceph/ceph/pull/24810), Alfonso
    Martínez)
-   mgr/dashboard: Landing Page: info visibility
    ([pr#24513](https://github.com/ceph/ceph/pull/24513), Alfonso
    Martínez)
-   mgr/dashboard: Log frontend errors + \@UiController
    ([pr#22285](https://github.com/ceph/ceph/pull/22285), Ricardo
    Marques)
-   mgr/dashboard: Login failure should return HTTP 400
    ([pr#22403](https://github.com/ceph/ceph/pull/22403), Ricardo
    Marques)
-   mgr/dashboard: \'Logs\' links permission in Landing Page
    ([pr#25231](https://github.com/ceph/ceph/pull/25231), Alfonso
    Martínez)
-   mgr/dashboard: Make deletion dialog more touch device friendly
    ([pr#23897](https://github.com/ceph/ceph/pull/23897), Volker Theile)
-   mgr/dashboard: Map dev \'releases\' to master
    ([pr#24763](https://github.com/ceph/ceph/pull/24763), Zack Cerza)
-   mgr/dashboard: Module dashboard.services.ganesha has several lint
    issues ([pr#26378](https://github.com/ceph/ceph/pull/26378), Volker
    Theile)
-   mgr/dashboard: More configs for table
    [updateSelectionOnRefresh]{.title-ref}
    ([pr#24015](https://github.com/ceph/ceph/pull/24015), Ricardo
    Marques)
-   mgr/dashboard: Move Cluster/Audit logs from front page to dedicated
    Logs page ([pr#23834](https://github.com/ceph/ceph/pull/23834),
    Diksha Godbole)
-   mgr/dashboard: Move unit-test-helper into the new testing folder
    ([pr#22857](https://github.com/ceph/ceph/pull/22857), Tiago Melo)
-   mgr/dashboard: Navbar dropdown button does not respond for mobile
    browsers ([pr#21967](https://github.com/ceph/ceph/pull/21967),
    Volker Theile)
-   mgr/dashboard: New Landing Page: Milestone 2
    ([pr#24326](https://github.com/ceph/ceph/pull/24326), Alfonso
    Martínez)
-   mgr/dashboard: New Landing Page
    ([pr#23568](https://github.com/ceph/ceph/pull/23568), Alfonso
    Martínez)
-   mgr/dashboard: nfs-ganesha: controller API documentation
    ([pr#26716](https://github.com/ceph/ceph/pull/26716), Ricardo Dias)
-   mgr/dashboard: NFS management UI
    ([pr#26085](https://github.com/ceph/ceph/pull/26085), Tiago Melo)
-   mgr/dashboard: ng serve bind to 0.0.0.0
    ([pr#22058](https://github.com/ceph/ceph/pull/22058), Ricardo
    Marques)
-   mgr/dashboard: no side-effects on failed user creation
    ([pr#24200](https://github.com/ceph/ceph/pull/24200), Joao Eduardo
    Luis)
-   mgr/dashboard: Notification queue
    ([pr#25325](https://github.com/ceph/ceph/pull/25325), Stephan
    Müller)
-   mgr/dashboard: npm run e2e:dev
    ([pr#25136](https://github.com/ceph/ceph/pull/25136), Stephan
    Müller)
-   mgr/dashboard: Performance counter progress bar keeps infinitely
    looping ([pr#24448](https://github.com/ceph/ceph/pull/24448), Volker
    Theile)
-   mgr/dashboard: permanent pie chart slice hiding
    ([pr#25276](https://github.com/ceph/ceph/pull/25276), Alfonso
    Martínez)
-   mgr/dashboard: PGs will update as expected
    ([pr#26589](https://github.com/ceph/ceph/pull/26589), Stephan
    Müller)
-   mgr/dashboard: Pool management
    ([pr#21614](https://github.com/ceph/ceph/pull/21614), Stephan
    Müller)
-   mgr/dashboard: pool stats not returned by default
    ([pr#25635](https://github.com/ceph/ceph/pull/25635), Alfonso
    Martínez)
-   mgr/dashboard: Possible fix for some dashboard timing issues
    ([issue#36107](http://tracker.ceph.com/issues/36107),
    [pr#24219](https://github.com/ceph/ceph/pull/24219), Patrick
    Nawracay)
-   mgr/dashboard: Prettify package.json
    ([pr#22401](https://github.com/ceph/ceph/pull/22401), Ricardo
    Marques)
-   mgr/dashboard: Prettify RGW JS code
    ([pr#22278](https://github.com/ceph/ceph/pull/22278), Volker Theile)
-   mgr/dashboard: Prevent API call on every keystroke
    ([pr#23391](https://github.com/ceph/ceph/pull/23391), Volker Theile)
-   mgr/dashboard: Print a blank space between value and unit
    ([pr#22387](https://github.com/ceph/ceph/pull/22387), Volker Theile)
-   mgr/dashboard: Progress bar does not stop in TableKeyValueComponent
    ([pr#24016](https://github.com/ceph/ceph/pull/24016), Volker Theile)
-   mgr/dashboard: Prometheus integration
    ([pr#25309](https://github.com/ceph/ceph/pull/25309), Stephan
    Müller)
-   mgr/dashboard: Provide all four \'mandatory\' OSD flags
    ([issue#37857](http://tracker.ceph.com/issues/37857),
    [pr#25905](https://github.com/ceph/ceph/pull/25905), Tatjana Dehler)
-   mgr/dashboard/qa: Fix ECP creation test
    ([pr#25120](https://github.com/ceph/ceph/pull/25120), Stephan
    Müller)
-   mgr/dashboard/qa: Fix various vstart_runner.py issues
    ([issue#36581](http://tracker.ceph.com/issues/36581),
    [pr#24767](https://github.com/ceph/ceph/pull/24767), Volker Theile)
-   mgr/dashboard: Redirect /block to /block/rbd
    ([pr#24722](https://github.com/ceph/ceph/pull/24722), Zack Cerza)
-   mgr/dashboard: Reduce Jest logs in CI
    ([pr#24764](https://github.com/ceph/ceph/pull/24764), Tiago Melo)
-   mgr/dashboard: Refactor autofocus directive
    ([pr#23910](https://github.com/ceph/ceph/pull/23910), Volker Theile)
-   mgr/dashboard: Refactoring of [DeletionModalComponent]{.title-ref}
    ([pr#24005](https://github.com/ceph/ceph/pull/24005), Patrick
    Nawracay)
-   mgr/dashboard: Refactor perf counters
    ([pr#21673](https://github.com/ceph/ceph/pull/21673), Volker Theile)
-   mgr/dashboard: Refactor RGW backend
    ([pr#21784](https://github.com/ceph/ceph/pull/21784), Volker Theile)
-   mgr/dashboard: Refactor role management
    ([pr#23960](https://github.com/ceph/ceph/pull/23960), Volker Theile)
-   mgr/dashboard: Relocate empty pipe
    ([pr#26588](https://github.com/ceph/ceph/pull/26588), Volker Theile)
-   mgr/dashboard: Removed unnecessary fake services from unit tests
    ([pr#22473](https://github.com/ceph/ceph/pull/22473), Stephan
    Müller)
-   mgr/dashboard: Remove fieldsets when using CdTable
    ([pr#23730](https://github.com/ceph/ceph/pull/23730), Tiago Melo)
-   mgr/dashboard: Remove \_filterValue from CdFormGroup
    ([issue#26861](http://tracker.ceph.com/issues/26861),
    [pr#24719](https://github.com/ceph/ceph/pull/24719), Stephan Müller)
-   mgr/dashboard: Remove husky package
    ([pr#21971](https://github.com/ceph/ceph/pull/21971), Tiago Melo)
-   mgr/dashboard: Remove karma packages
    ([pr#23181](https://github.com/ceph/ceph/pull/23181), Tiago Melo)
-   mgr/dashboard: Remove param when calling notificationService.show
    ([pr#26447](https://github.com/ceph/ceph/pull/26447), Volker Theile)
-   mgr/dashboard: Remove top-right actions text and add \"About\" page
    ([pr#22762](https://github.com/ceph/ceph/pull/22762), Ricardo
    Marques)
-   mgr/dashboard: Remove unused code
    ([pr#25439](https://github.com/ceph/ceph/pull/25439), Patrick
    Nawracay)
-   mgr/dashboard: Remove useless code
    ([pr#23911](https://github.com/ceph/ceph/pull/23911), Volker Theile)
-   mgr/dashboard: Remove useless observable unsubscriptions
    ([pr#21928](https://github.com/ceph/ceph/pull/21928), Ricardo
    Marques)
-   mgr/dashboard: replace configuration html table with cd-table
    ([pr#21643](https://github.com/ceph/ceph/pull/21643), Tatjana
    Dehler)
-   mgr/dashboard: Replaced \"Pool\" with \"Pools\" in navigation bar
    ([pr#22715](https://github.com/ceph/ceph/pull/22715), Lenz Grimmer)
-   mgr/dashboard: Replace RGW proxy controller
    ([issue#24436](http://tracker.ceph.com/issues/24436),
    [pr#22470](https://github.com/ceph/ceph/pull/22470), Volker Theile)
-   mgr/dashboard: Reset settings to their default values
    ([pr#22298](https://github.com/ceph/ceph/pull/22298), Patrick
    Nawracay)
-   mgr/dashboard: Resolve TestBed performance issue
    ([pr#21783](https://github.com/ceph/ceph/pull/21783), Stephan
    Müller)
-   mgr/dashboard: rest: add support for query params
    ([pr#22318](https://github.com/ceph/ceph/pull/22318), Ricardo Dias)
-   mgr/dashboard: RestClient can\'t handle ProtocolError exceptions
    ([pr#23347](https://github.com/ceph/ceph/pull/23347), Volker Theile)
-   mgr/dashboard: restcontroller: minor improvements and bug fixes
    ([pr#22528](https://github.com/ceph/ceph/pull/22528), Ricardo Dias)
-   mgr/dashboard: RGW is not working if an URL prefix is defined
    ([pr#23200](https://github.com/ceph/ceph/pull/23200), Volker Theile)
-   mgr/dashboard: RGW proxy can\'t handle self-signed SSL certificates
    ([pr#22735](https://github.com/ceph/ceph/pull/22735), Volker Theile)
-   mgr/dashboard: role based authentication/authorization system
    ([issue#23796](http://tracker.ceph.com/issues/23796),
    [pr#22283](https://github.com/ceph/ceph/pull/22283), Ricardo
    Marques, Ricardo Dias)
-   mgr/dashboard: Role management from the UI
    ([pr#23409](https://github.com/ceph/ceph/pull/23409), Ricardo
    Marques)
-   mgr/dashboard: Search broken for entries with null values
    ([issue#38583](http://tracker.ceph.com/issues/38583),
    [pr#26766](https://github.com/ceph/ceph/pull/26766), Patrick
    Nawracay)
-   mgr/dashboard: set errno via the parent class
    ([pr#21945](https://github.com/ceph/ceph/pull/21945), Kefu Chai,
    Ricardo Dias)
-   mgr/dashboard: Set MODULE_OPTIONS types and defaults
    ([pr#26386](https://github.com/ceph/ceph/pull/26386), Volker Theile)
-   mgr/dashboard: Set timeout in RestClient calls
    ([pr#23224](https://github.com/ceph/ceph/pull/23224), Volker Theile)
-   mgr/dashboard: Settings service
    ([pr#25327](https://github.com/ceph/ceph/pull/25327), Stephan
    Müller)
-   mgr/dashboard: Show/Hide Grafana tabs according to user role
    ([issue#36655](http://tracker.ceph.com/issues/36655),
    [pr#24851](https://github.com/ceph/ceph/pull/24851), Kanika Murarka)
-   mgr/dashboard: Show pool dropdown for block-mgr
    ([issue#37295](http://tracker.ceph.com/issues/37295),
    [pr#25144](https://github.com/ceph/ceph/pull/25144), Ernesto Puerta)
-   mgr/dashboard: Show success notification in RGW forms
    ([pr#26482](https://github.com/ceph/ceph/pull/26482), Volker Theile)
-   mgr/dashboard: Simplification of PoolForm method
    ([pr#24892](https://github.com/ceph/ceph/pull/24892), Patrick
    Nawracay)
-   mgr/dashboard: Simplify OSD disabled action test
    ([pr#24824](https://github.com/ceph/ceph/pull/24824), Stephan
    Müller)
-   mgr/dashboard: special casing for minikube in
    run-backend-rook-api-request.sh
    ([pr#26600](https://github.com/ceph/ceph/pull/26600), Jeff Layton)
-   mgr/dashboard: SSO - SAML 2.0 support
    ([pr#24489](https://github.com/ceph/ceph/pull/24489), Ricardo
    Marques, Ricardo Dias)
-   mgr/dashboard: SSO - UserDoesNotExist page
    ([pr#26058](https://github.com/ceph/ceph/pull/26058), Alfonso
    Martínez)
-   mgr/dashboard: Stacktrace is optional on \'js-error\' endpoint
    ([pr#22402](https://github.com/ceph/ceph/pull/22402), Ricardo
    Marques)
-   mgr/dashboard: Status info cards\' improvements
    ([pr#25155](https://github.com/ceph/ceph/pull/25155), Alfonso
    Martínez)
-   mgr/dashboard: Store user table configurations
    ([pr#20822](https://github.com/ceph/ceph/pull/20822), Stephan
    Müller)
-   mgr/dashboard: Stringify object\[\] in KV-table
    ([pr#22422](https://github.com/ceph/ceph/pull/22422), Stephan
    Müller)
-   mgr/dashboard: Swagger-UI based Dashboard REST API page
    ([issue#23898](http://tracker.ceph.com/issues/23898),
    [pr#22282](https://github.com/ceph/ceph/pull/22282), Ricardo Dias)
-   mgr/dashboard: Sync column style with the rest of the UI
    ([pr#26407](https://github.com/ceph/ceph/pull/26407), Volker Theile)
-   mgr/dashboard: tasks.mgr.dashboard.test_osd.OsdTest failures
    ([pr#24947](https://github.com/ceph/ceph/pull/24947), Volker Theile)
-   mgr/dashboard: Task wrapper service
    ([pr#22014](https://github.com/ceph/ceph/pull/22014), Stephan
    Müller)
-   mgr/dashboard: The RGW backend doesn\'t handle IPv6 properly
    ([pr#24222](https://github.com/ceph/ceph/pull/24222), Volker Theile)
-   mgr/dashboard: typescript cleanup
    ([pr#26338](https://github.com/ceph/ceph/pull/26338), Alfonso
    Martínez)
-   mgr/dashboard: Unit Tests cleanup
    ([pr#24591](https://github.com/ceph/ceph/pull/24591), Tiago Melo)
-   mgr/dashboard: Update Angular packages
    ([pr#23706](https://github.com/ceph/ceph/pull/23706), Tiago Melo)
-   mgr/dashboard: Update Angular to version 6
    ([pr#22082](https://github.com/ceph/ceph/pull/22082), Tiago Melo)
-   mgr/dashboard: Update bootstrap to v3.4.1
    ([pr#26410](https://github.com/ceph/ceph/pull/26410), Tiago Melo)
-   mgr/dashboard: Updated colors in PG Status chart
    ([pr#26203](https://github.com/ceph/ceph/pull/26203), Alfonso
    Martínez)
-   mgr/dashboard: updated health API test
    ([pr#25813](https://github.com/ceph/ceph/pull/25813), Alfonso
    Martínez)
-   mgr/dashboard: Updated image on 404 page
    ([pr#23820](https://github.com/ceph/ceph/pull/23820), Lenz Grimmer)
-   mgr/dashboard: Update frontend packages
    ([pr#23466](https://github.com/ceph/ceph/pull/23466), Tiago Melo)
-   mgr/dashboard: Update I18N translation
    ([pr#26649](https://github.com/ceph/ceph/pull/26649), Tiago Melo)
-   mgr/dashboard: Update npm packages
    ([pr#24681](https://github.com/ceph/ceph/pull/24681), Tiago Melo)
-   mgr/dashboard: Update npm packages
    ([pr#25656](https://github.com/ceph/ceph/pull/25656), Tiago Melo)
-   mgr/dashboard: Update npm packages
    ([pr#26437](https://github.com/ceph/ceph/pull/26437), Tiago Melo)
-   mgr/dashboard: Update npm packages
    ([pr#26647](https://github.com/ceph/ceph/pull/26647), Tiago Melo)
-   mgr/dashboard: update python dependency
    ([pr#24928](https://github.com/ceph/ceph/pull/24928), Alfonso
    Martínez)
-   mgr/dashboard: Update RxJS to version 6
    ([pr#21826](https://github.com/ceph/ceph/pull/21826), Tiago Melo)
-   mgr/dashboard: upgraded python dev dependencies
    ([pr#26007](https://github.com/ceph/ceph/pull/26007), Alfonso
    Martínez)
-   mgr/dashboard: Upgrade Swimlane\'s data-table
    ([pr#21880](https://github.com/ceph/ceph/pull/21880), Volker Theile)
-   mgr/dashboard: Use HTTPS in dev proxy configuration and HACKING.rst
    ([pr#21777](https://github.com/ceph/ceph/pull/21777), Volker Theile)
-   mgr/dashboard: Use human readable units on the sparkline graphs
    ([issue#25075](http://tracker.ceph.com/issues/25075),
    [pr#23446](https://github.com/ceph/ceph/pull/23446), Tiago Melo)
-   mgr/dashboard: User password should be optional
    ([pr#24128](https://github.com/ceph/ceph/pull/24128), Ricardo
    Marques)
-   mgr/dashboard: Validate the OSD recovery priority form input values
    ([issue#37436](http://tracker.ceph.com/issues/37436),
    [pr#25472](https://github.com/ceph/ceph/pull/25472), Tatjana Dehler)
-   mgr/dashboard: Validation for duplicate RGW user email
    ([issue#37369](http://tracker.ceph.com/issues/37369),
    [pr#25334](https://github.com/ceph/ceph/pull/25334), Kanika Murarka)
-   mgr: define option defaults for MgrStandbyModule as well
    ([pr#25734](https://github.com/ceph/ceph/pull/25734), Kefu Chai)
-   mgr: devicehealth: dont error on dict iteritems
    ([pr#22827](https://github.com/ceph/ceph/pull/22827), Abhishek
    Lekshmanan)
-   mgr: Diskprediction cloud activate when config changes
    ([pr#25165](https://github.com/ceph/ceph/pull/25165), Rick Chen)
-   mgr: don\'t write to output if EOPNOTSUPP
    ([issue#37444](http://tracker.ceph.com/issues/37444),
    [pr#25317](https://github.com/ceph/ceph/pull/25317), Kefu Chai)
-   mgr: enable inter-module calls
    ([pr#22951](https://github.com/ceph/ceph/pull/22951), John Spray)
-   mgr: Expose avgcount to the python modules
    ([pr#22010](https://github.com/ceph/ceph/pull/22010), Boris Ranto)
-   mgr: expose avg data for long running avgs
    ([pr#22420](https://github.com/ceph/ceph/pull/22420), Boris Ranto)
-   mgr: expose ec profiles through manager
    ([pr#23010](https://github.com/ceph/ceph/pull/23010), Noah Watkins)
-   mgr: Extend batch to accept explicit device lists
    ([issue#37502](http://tracker.ceph.com/issues/37502),
    [issue#37086](http://tracker.ceph.com/issues/37086),
    [issue#37590](http://tracker.ceph.com/issues/37590),
    [pr#25542](https://github.com/ceph/ceph/pull/25542), Jan Fajerski)
-   mgr: fix beacon interruption caused by deadlock
    ([pr#23482](https://github.com/ceph/ceph/pull/23482), Yan Jun)
-   mgr: fix crash due to multiple sessions from daemons with same name
    ([pr#25534](https://github.com/ceph/ceph/pull/25534), Mykola Golub)
-   mgr: fix permissions on [balancer execute]{.title-ref}
    ([issue#25345](http://tracker.ceph.com/issues/25345),
    [pr#23387](https://github.com/ceph/ceph/pull/23387), John Spray)
-   mgr: Fix rook spec and have service_describe provide
    rados_config_location field for nfs services
    ([pr#25970](https://github.com/ceph/ceph/pull/25970), Jeff Layton)
-   mgr: fix typo in variable name and cleanups
    ([pr#22069](https://github.com/ceph/ceph/pull/22069), Kefu Chai)
-   mgr: fixup pgs show in unknown state
    ([issue#25103](http://tracker.ceph.com/issues/25103),
    [pr#23622](https://github.com/ceph/ceph/pull/23622), huanwen ren)
-   mgr: Ignore daemon if no metadata was returned
    ([pr#22794](https://github.com/ceph/ceph/pull/22794), Wido den
    Hollander)
-   mgr: Ignore \_\_pycache\_\_ and wheelhouse dirs
    ([pr#26481](https://github.com/ceph/ceph/pull/26481), Volker Theile)
-   mgr: Improve ActivePyModules::get_typed_config implementation
    ([pr#26149](https://github.com/ceph/ceph/pull/26149), Volker Theile)
-   mgr: improve docs for MgrModule methods
    ([pr#22792](https://github.com/ceph/ceph/pull/22792), John Spray)
-   mgr: improvements for dynamic osd perf counters
    ([pr#25488](https://github.com/ceph/ceph/pull/25488), Mykola Golub)
-   mgr: Include daemon details in SLOW_OPS output
    ([issue#23205](http://tracker.ceph.com/issues/23205),
    [pr#21750](https://github.com/ceph/ceph/pull/21750), Brad Hubbard)
-   mgr: [#include \<vector\>]{.title-ref} for clang
    ([pr#22756](https://github.com/ceph/ceph/pull/22756), Willem Jan
    Withagen)
-   mgr: keep status, balancer always on
    ([pr#23558](https://github.com/ceph/ceph/pull/23558), Sage Weil)
-   mgr: make module error message more descriptive
    ([pr#25537](https://github.com/ceph/ceph/pull/25537), Joao Eduardo
    Luis)
-   mgr: mgr/ansible: Ansible orchestrator module
    ([pr#24445](https://github.com/ceph/ceph/pull/24445), Juan Miguel
    Olmo Martínez)
-   mgr: mgr/ansible: Create/Remove OSDs
    ([pr#25497](https://github.com/ceph/ceph/pull/25497), Juan Miguel
    Olmo Martínez)
-   mgr: mgr/ansible: Python 3 fix
    ([pr#25645](https://github.com/ceph/ceph/pull/25645), Sebastian
    Wagner)
-   mgr: mgr/balancer: add min/max fields for weekday and be compatible
    with C ([pr#26505](https://github.com/ceph/ceph/pull/26505), xie
    xingguo)
-   mgr: mgr/balancer: auto balance a list of pools
    ([pr#25940](https://github.com/ceph/ceph/pull/25940), xie xingguo)
-   mgr: mgr/balancer: blame if upmap won\'t actually work
    ([pr#25941](https://github.com/ceph/ceph/pull/25941), xie xingguo)
-   mgr: mgr/balancer: deepcopy best plan - otherwise we get latest
    ([issue#27000](http://tracker.ceph.com/issues/27000),
    [pr#23682](https://github.com/ceph/ceph/pull/23682), Stefan Priebe)
-   mgr: mgr/balancer: restrict automatic balancing to specific weekdays
    ([pr#26440](https://github.com/ceph/ceph/pull/26440), xie xingguo)
-   mgr: mgr/balancer: skip auto-balancing for pools with pending
    pg-merge ([pr#25626](https://github.com/ceph/ceph/pull/25626), xie
    xingguo)
-   mgr: mgrc: enable disabling stats via mgr_stats_threshold
    ([issue#25197](http://tracker.ceph.com/issues/25197),
    [pr#23352](https://github.com/ceph/ceph/pull/23352), John Spray)
-   mgr: mgr/crash: add hour granularity crash summary
    ([pr#23121](https://github.com/ceph/ceph/pull/23121), Noah Watkins)
-   mgr: mgr/crash: add process name to crash metadata
    ([pr#25244](https://github.com/ceph/ceph/pull/25244), Mykola Golub)
-   mgr: mgr/crash: fix python3 invalid syntax problems
    ([pr#23800](https://github.com/ceph/ceph/pull/23800), Ricardo Dias)
-   mgr: mgr/DaemonServer: add js-output for \"ceph osd
    safe-to-destroy\"
    ([pr#24799](https://github.com/ceph/ceph/pull/24799), xie xingguo)
-   mgr: mgr/DaemonServer: log pgmap usage to cluster log
    ([pr#26105](https://github.com/ceph/ceph/pull/26105), Neha Ojha)
-   mgr: mgr/dashboard: Add option to disable SSL
    ([pr#22593](https://github.com/ceph/ceph/pull/22593), Wido den
    Hollander)
-   mgr: mgr/dashboard: disable backend tests coverage
    ([pr#24193](https://github.com/ceph/ceph/pull/24193), Alfonso
    Martínez)
-   mgr: mgr/dashboard: Fix dashboard shutdown/restart
    ([pr#22159](https://github.com/ceph/ceph/pull/22159), Boris Ranto)
-   mgr: mgr/dashboard: Listen on port 8443 by default and not 8080
    ([pr#22409](https://github.com/ceph/ceph/pull/22409), Wido den
    Hollander)
-   mgr: mgr/dashboard: use the orchestrator_cli backend setting
    ([pr#26325](https://github.com/ceph/ceph/pull/26325), Jeff Layton)
-   mgr: mgr/deepsea: always use \'password\' parameter for salt-api
    auth ([pr#26904](https://github.com/ceph/ceph/pull/26904), Tim
    Serong)
-   mgr: mgr/deepsea: check for inflight completions when starting event
    reader, cleanup logging and comments
    ([pr#25391](https://github.com/ceph/ceph/pull/25391), Tim Serong)
-   mgr: mgr/deepsea: DeepSea orchestrator module
    ([pr#24610](https://github.com/ceph/ceph/pull/24610), Tim Serong)
-   mgr: mgr/devicehealth: clean up error handling
    ([pr#23205](https://github.com/ceph/ceph/pull/23205), John Spray)
-   mgr: mgr/devicehealth: fix is_valid_daemon_name typo error
    ([pr#24822](https://github.com/ceph/ceph/pull/24822), Lan Liu)
-   mgr: mgr/diskprediction_cloud: fix divide by zero when total_size is
    0 ([pr#26045](https://github.com/ceph/ceph/pull/26045), Rick Chen)
-   mgr: mgr/diskprediction_cloud: Remove needless library in the
    requirements file
    ([issue#37533](http://tracker.ceph.com/issues/37533),
    [pr#25433](https://github.com/ceph/ceph/pull/25433), Rick Chen)
-   mgr: mgr/influx: Use Queue to store points which need to be written
    ([pr#23464](https://github.com/ceph/ceph/pull/23464), Wido den
    Hollander)
-   mgr: mgr/insights: insights reporting module
    ([pr#23497](https://github.com/ceph/ceph/pull/23497), Noah Watkins)
-   mgr: mgr/mgr_module.py: fix doc for set_store/set_store_json
    ([pr#22654](https://github.com/ceph/ceph/pull/22654), Dan Mick)
-   mgr: mgr/orchestrator: Add RGW service support
    ([pr#23702](https://github.com/ceph/ceph/pull/23702), Rubab-Syed)
-   mgr: mgr/orchestrator: Add service_action method
    ([pr#25649](https://github.com/ceph/ceph/pull/25649), Tim Serong)
-   mgr: mgr/orchestrator: Add support for \"ceph orchestrator service
    ls\" ([pr#24863](https://github.com/ceph/ceph/pull/24863), Jeff
    Layton)
-   mgr: mgr/orchestrator: Improve debuggability
    ([pr#24147](https://github.com/ceph/ceph/pull/24147), Sebastian
    Wagner)
-   mgr: mgr/orchestrator: Improve docstrings, add type hinting
    ([pr#25669](https://github.com/ceph/ceph/pull/25669), Sebastian
    Wagner)
-   mgr: mgr/orchestrator: Simplify Orchestrator wait implementation
    ([pr#25401](https://github.com/ceph/ceph/pull/25401), Juan Miguel
    Olmo Martínez)
-   mgr: mgr/orchestrator: use result property in Completion classes
    ([pr#24672](https://github.com/ceph/ceph/pull/24672), Tim Serong)
-   mgr: mgr/progress: improve+test OSD out handling
    ([pr#23146](https://github.com/ceph/ceph/pull/23146), John Spray)
-   mgr: mgr/progress: introduce the [progress]{.title-ref} module
    ([pr#22993](https://github.com/ceph/ceph/pull/22993), John Spray)
-   mgr: mgr/prometheus: Add recovery metrics
    ([pr#26880](https://github.com/ceph/ceph/pull/26880), Paul Cuzner)
-   mgr: mgr/prometheus: get osd_objectstore once instead twice
    ([pr#26558](https://github.com/ceph/ceph/pull/26558), Konstantin
    Shalygin)
-   mgr: mgr/restful: Fix deep-scrub typo
    ([issue#36720](http://tracker.ceph.com/issues/36720),
    [pr#24841](https://github.com/ceph/ceph/pull/24841), Boris Ranto)
-   mgr: mgr/restful: fix py got exception when get osd info
    ([pr#21138](https://github.com/ceph/ceph/pull/21138), zouaiguo)
-   mgr: mgr/restful: updated string formatting to str.format()
    ([pr#26210](https://github.com/ceph/ceph/pull/26210), James McClune)
-   mgr: mgr/rook: fix API version and object types for recent rook
    changes ([pr#25452](https://github.com/ceph/ceph/pull/25452), Jeff
    Layton)
-   mgr: mgr/rook: Fix Rook cluster name detection
    ([pr#24560](https://github.com/ceph/ceph/pull/24560), Sebastian
    Wagner)
-   mgr: mgr/rook: update for v1beta1 API
    ([pr#23570](https://github.com/ceph/ceph/pull/23570), John Spray)
-   mgr: mgr/status: Add standby-replay MDS ceph version
    ([pr#23624](https://github.com/ceph/ceph/pull/23624), Zhi Zhang)
-   mgr: mgr/status: output to stdout, not stderr
    ([issue#24175](http://tracker.ceph.com/issues/24175),
    [pr#22089](https://github.com/ceph/ceph/pull/22089), John Spray)
-   mgr: mgr/telegraf: Send more PG status information to Telegraf
    ([pr#22436](https://github.com/ceph/ceph/pull/22436), Wido den
    Hollander)
-   mgr: mgr/telegraf: Telegraf module for Ceph Mgr
    ([pr#21782](https://github.com/ceph/ceph/pull/21782), Wido den
    Hollander)
-   mgr: mgr/telegraf: Use Python generator and catch OSError
    ([pr#22418](https://github.com/ceph/ceph/pull/22418), Wido den
    Hollander)
-   mgr: mgr/telemetry: Add Ceph Telemetry module to send reports back
    to project ([pr#21982](https://github.com/ceph/ceph/pull/21982),
    Wido den Hollander)
-   mgr: mgr/telemetry: Check if boolean is False or not present
    ([pr#22223](https://github.com/ceph/ceph/pull/22223), Wido den
    Hollander)
-   mgr: mgr/telemetry: Fix various issues
    ([pr#25770](https://github.com/ceph/ceph/pull/25770), Volker Theile)
-   mgr: mgr/volumes: fix orchestrator remove operation
    ([pr#25339](https://github.com/ceph/ceph/pull/25339), Jeff Layton)
-   mgr: mgr/zabbix: drop \"total_objects\" field
    ([pr#26052](https://github.com/ceph/ceph/pull/26052), Kefu Chai)
-   mgr: mgr/zabbix: Send more PG information to Zabbix
    ([pr#22434](https://github.com/ceph/ceph/pull/22434), Wido den
    Hollander)
-   mgr: Miscellaneous small mgr fixes
    ([pr#22893](https://github.com/ceph/ceph/pull/22893), John Spray)
-   mgr: modules CLI commands declaration using \@CLICommand decorator
    ([pr#25543](https://github.com/ceph/ceph/pull/25543), Ricardo Dias)
-   mgr,mon: mgr,mon: fix to apply changed mon_stat_smooth_intervals
    ([pr#23481](https://github.com/ceph/ceph/pull/23481), Yan Jun)
-   mgr/orchestrator: added useful attributes to ServiceDescription
    ([pr#25468](https://github.com/ceph/ceph/pull/25468), Ricardo Dias)
-   mgr/orchestrator: Add host mon mgr management to interface
    ([pr#26314](https://github.com/ceph/ceph/pull/26314), Sebastian
    Wagner, Noah Watkins)
-   mgr/orchestrator: Add JSON output to CLI commands
    ([pr#25340](https://github.com/ceph/ceph/pull/25340), Sebastian
    Wagner)
-   mgr: orchestrator: add the ability to remove services
    ([pr#25366](https://github.com/ceph/ceph/pull/25366), Jeff Layton)
-   mgr/orchestrator: Allow the orchestrator to scale the NFS server
    count ([pr#26633](https://github.com/ceph/ceph/pull/26633), Jeff
    Layton)
-   mgr/orchestrator: clarify error message about kubernetes python
    module ([pr#24525](https://github.com/ceph/ceph/pull/24525), Jeff
    Layton)
-   mgr/orchestrator_cli: Fix README.md
    ([pr#26443](https://github.com/ceph/ceph/pull/26443), Sebastian
    Wagner)
-   mgr/orchestrator: Extend DriveGroupSpec
    ([pr#25912](https://github.com/ceph/ceph/pull/25912), Sebastian
    Wagner)
-   mgr/orchestrator: fix device pretty print with None attributes
    ([pr#26357](https://github.com/ceph/ceph/pull/26357), Ricardo Dias)
-   mgr/orchestrator: fix \_list_services display
    ([pr#25610](https://github.com/ceph/ceph/pull/25610), Jeff Layton)
-   mgr/orchestrator: Fix up rook osd create dispatcher
    ([pr#26317](https://github.com/ceph/ceph/pull/26317), Jeff Layton)
-   mgr/orchestrator: make use of \@CLICommand
    ([pr#26094](https://github.com/ceph/ceph/pull/26094), Sebastian
    Wagner)
-   mgr/orchestrator: remove unicode whitespaces
    ([pr#25323](https://github.com/ceph/ceph/pull/25323), Sebastian
    Wagner)
-   mgr/orchestrator/rook: allow the creation of OSDs in directories
    ([pr#26570](https://github.com/ceph/ceph/pull/26570), Jeff Layton)
-   mgr/orchestrator: Unify [osd create]{.title-ref} and [osd
    add]{.title-ref}
    ([pr#26171](https://github.com/ceph/ceph/pull/26171), Sebastian
    Wagner)
-   mgr/orch: refresh option for inventory query
    ([pr#26346](https://github.com/ceph/ceph/pull/26346), Noah Watkins)
-   mgr: prometheus: added bluestore db and wal/journal devices to
    ceph_disk_occupation metric
    ([issue#36627](http://tracker.ceph.com/issues/36627),
    [pr#24821](https://github.com/ceph/ceph/pull/24821), Konstantin
    Shalygin)
-   mgr: prometheus: Expose number of degraded/misplaced/unfound objects
    ([pr#21793](https://github.com/ceph/ceph/pull/21793), Boris Ranto)
-   mgr: prometheus: Fix metric resets
    ([pr#22732](https://github.com/ceph/ceph/pull/22732), Boris Ranto)
-   mgr: prometheus: Fix prometheus shutdown/restart
    ([pr#21748](https://github.com/ceph/ceph/pull/21748), Boris Ranto)
-   mgr: pybind/mgr: add osd space utilization to insights report
    ([pr#25122](https://github.com/ceph/ceph/pull/25122), Noah Watkins)
-   mgr: pybind/mgr: PEP 8 code clean and fix typo
    ([pr#26181](https://github.com/ceph/ceph/pull/26181), Lei Liu)
-   mgr,pybind: mgr/prometheus: add interface and objectstore to osd
    metadata ([pr#25234](https://github.com/ceph/ceph/pull/25234), Jan
    Fajerski)
-   mgr: pybind/mgr/restful: Decode the output of b64decode
    ([issue#38522](http://tracker.ceph.com/issues/38522),
    [pr#26712](https://github.com/ceph/ceph/pull/26712), Brad Hubbard)
-   mgr,pybind: mgr/rook: fix urljoin import
    ([pr#24626](https://github.com/ceph/ceph/pull/24626), Jeff Layton)
-   mgr,pybind: mgr/volumes: Fix Python 3 import error
    ([pr#25344](https://github.com/ceph/ceph/pull/25344), Sebastian
    Wagner)
-   mgr,pybind: pybind/mgr: drop unnecessary iterkeys usage to make py-3
    compatible ([issue#37581](http://tracker.ceph.com/issues/37581),
    [pr#25457](https://github.com/ceph/ceph/pull/25457), Mykola Golub)
-   mgr,pybind: pybind/mgr: identify invalid fs
    ([pr#24392](https://github.com/ceph/ceph/pull/24392), Jos Collin)
-   mgr,pybind: src/script: add run_mypy to run static type checking on
    Python code ([pr#26715](https://github.com/ceph/ceph/pull/26715),
    Sebastian Wagner)
-   mgr: race between daemon state and service map in \'service status\'
    ([issue#36656](http://tracker.ceph.com/issues/36656),
    [pr#24878](https://github.com/ceph/ceph/pull/24878), Mykola Golub)
-   mgr,rbd: mgr/prometheus: provide RBD stats via osd dynamic perf
    counters ([pr#25358](https://github.com/ceph/ceph/pull/25358),
    Mykola Golub)
-   mgr,rbd: pybind/mgr/prometheus: improve \'rbd_stats_pools\' param
    parsing ([pr#25860](https://github.com/ceph/ceph/pull/25860), Mykola
    Golub)
-   mgr,rbd: pybind/mgr/prometheus: rbd stats namespace support
    ([pr#25636](https://github.com/ceph/ceph/pull/25636), Mykola Golub)
-   mgr: replace \"Unknown error\" string on always_on
    ([pr#23645](https://github.com/ceph/ceph/pull/23645), John Spray)
-   mgr: restful: Fix regression when traversing leaf nodes
    ([pr#26421](https://github.com/ceph/ceph/pull/26421), Boris Ranto)
-   mgr/rook: remove dead code and fix bug in url fetching code
    ([pr#26032](https://github.com/ceph/ceph/pull/26032), Jeff Layton)
-   mgr: silence GCC warning
    ([pr#25199](https://github.com/ceph/ceph/pull/25199), Kefu Chai)
-   mgr/ssh: fix type and doc errors
    ([pr#26630](https://github.com/ceph/ceph/pull/26630), Sebastian
    Wagner)
-   mgr/telemetry: fix total_objects
    ([issue#37976](http://tracker.ceph.com/issues/37976),
    [pr#26046](https://github.com/ceph/ceph/pull/26046), Sage Weil)
-   mgr,tests: mgr/dashboard: use dedicated tox working dir
    ([pr#25290](https://github.com/ceph/ceph/pull/25290), Noah Watkins)
-   mgr,tests: mgr/insights: use dedicated tox working dir
    ([pr#25146](https://github.com/ceph/ceph/pull/25146), Noah Watkins)
-   mgr,tests: mgr/selftest: fix disabled module selection
    ([pr#24517](https://github.com/ceph/ceph/pull/24517), John Spray)
-   mgr: timely health updates between monitor and manager
    ([pr#23294](https://github.com/ceph/ceph/pull/23294), Noah Watkins)
-   mgr: update daemon_state when necessary
    ([issue#37753](http://tracker.ceph.com/issues/37753),
    [pr#25725](https://github.com/ceph/ceph/pull/25725), Xinying Song)
-   mgr: update MMgrConfigure message to include optional OSD perf
    queries ([pr#24180](https://github.com/ceph/ceph/pull/24180), Julien
    Collet)
-   mgr: Use Py_BuildValue to create the argument tuple
    ([pr#26240](https://github.com/ceph/ceph/pull/26240), Volker Theile)
-   mgr: volumes mgr module fixes
    ([pr#25331](https://github.com/ceph/ceph/pull/25331), Jeff Layton)
-   misc: mark functions with \'override\' specifier
    ([pr#21790](https://github.com/ceph/ceph/pull/21790), Danny Al-Gaaf)
-   mon: add \'osd destroy-new\' command that only destroys NEW osd
    slots ([issue#24428](http://tracker.ceph.com/issues/24428),
    [pr#22429](https://github.com/ceph/ceph/pull/22429), Sage Weil)
-   mon: A PG with PG_STATE_REPAIR doesn\'t mean damaged data,
    PG_STATE_IN... ([issue#38070](http://tracker.ceph.com/issues/38070),
    [pr#26178](https://github.com/ceph/ceph/pull/26178), David Zafman)
-   mon: change monitor compact command to run asynchronously
    ([issue#24160](http://tracker.ceph.com/issues/24160),
    [issue#24159](http://tracker.ceph.com/issues/24159),
    [pr#22056](https://github.com/ceph/ceph/pull/22056), penglaiyxy)
-   mon: common/cmdparse: cmd_getval_throws -\> cmd_getval
    ([pr#23557](https://github.com/ceph/ceph/pull/23557), Sage Weil)
-   mon: don\'t commit osdmap on no-op application ops
    ([pr#23528](https://github.com/ceph/ceph/pull/23528), John Spray)
-   mon: fix mgr module config option handling
    ([issue#35076](http://tracker.ceph.com/issues/35076),
    [pr#23846](https://github.com/ceph/ceph/pull/23846), Sage Weil)
-   mon: fix pg_sum_old not copied correctly
    ([pr#26110](https://github.com/ceph/ceph/pull/26110), Yao Zongyou)
-   monitoring/grafana: Fix OSD Capacity Utlization Grafana graph
    ([pr#24426](https://github.com/ceph/ceph/pull/24426), Maxime)
-   mon: make rank ordering explicit (not tied to mon address sort
    order) ([pr#22193](https://github.com/ceph/ceph/pull/22193), Sage
    Weil)
-   mon: mon/config-key: increase max key entry size
    ([pr#24250](https://github.com/ceph/ceph/pull/24250), Joao Eduardo
    Luis)
-   mon: mon/MonClient: drop my_addr
    ([pr#26449](https://github.com/ceph/ceph/pull/26449), Kefu Chai)
-   mon: mon/MonClient: use mon_client_ping_timeout during ping_monitor
    ([pr#23563](https://github.com/ceph/ceph/pull/23563), Yao Zongyou)
-   mon: mon/MonMap: add more const\'ness to its methods
    ([pr#23709](https://github.com/ceph/ceph/pull/23709), Kefu Chai)
-   mon: mon/MonMap: remove duplicate code in get_rank
    ([pr#23547](https://github.com/ceph/ceph/pull/23547), Yao Zongyou)
-   mon: mon,osd: avoid str copy in parse
    ([pr#25640](https://github.com/ceph/ceph/pull/25640), Jos Collin)
-   mon: mon/OSDMonitor: add boundary check for pool recovery_priority
    ([issue#38578](http://tracker.ceph.com/issues/38578),
    [pr#26729](https://github.com/ceph/ceph/pull/26729), xie xingguo)
-   mon: mon/PGMap: add more #include
    ([pr#26420](https://github.com/ceph/ceph/pull/26420), Kefu Chai)
-   mon: mon/PGMap: command \'ceph df -f json\' output add
    total_percent_used
    ([pr#23588](https://github.com/ceph/ceph/pull/23588), Yanhu Cao)
-   mon: only share monmap after authenticating
    ([pr#23741](https://github.com/ceph/ceph/pull/23741), Sage Weil)
-   mon: shutdown messenger early to avoid accessing deleted logger
    ([issue#37780](http://tracker.ceph.com/issues/37780),
    [pr#25760](https://github.com/ceph/ceph/pull/25760), ningtao)
-   mon: some tiny cleanups related class forward declaration
    ([pr#26219](https://github.com/ceph/ceph/pull/26219), Yao Zongyou)
-   mon,tests: qa/cephtool: test bounds on pool\'s
    [hit_set\_\*]{.title-ref}
    ([pr#24858](https://github.com/ceph/ceph/pull/24858), Joao Eduardo
    Luis)
-   mon:validate hit_set values before set
    ([issue#22659](http://tracker.ceph.com/issues/22659),
    [pr#19983](https://github.com/ceph/ceph/pull/19983), lijing)
-   msg: addr -\> addrvec (part 1)
    ([pr#22306](https://github.com/ceph/ceph/pull/22306), Sage Weil)
-   msg/async: do not force updating rotating keys inline
    ([pr#25859](https://github.com/ceph/ceph/pull/25859), yanjun, xie
    xingguo)
-   msg/async/Protocol\*: send keep alive if existing wins
    ([issue#38493](http://tracker.ceph.com/issues/38493),
    [pr#26668](https://github.com/ceph/ceph/pull/26668), xie xingguo)
-   msg/async/rdma: add iWARP RDMA protocol support
    ([pr#20297](https://github.com/ceph/ceph/pull/20297), Haodong Tang)
-   msg/async/rdma: Delete duplicate header file
    ([pr#25392](https://github.com/ceph/ceph/pull/25392), Jianpeng Ma)
-   msg/async/rdma: parse IBSYNMsg.lid as hex when receiving message
    ([pr#26525](https://github.com/ceph/ceph/pull/26525), Peng Liu)
-   msg/async: reduce additional ceph_msg_header copy
    ([pr#25938](https://github.com/ceph/ceph/pull/25938), Jianpeng Ma)
-   msg/async: the ceph_abort is needless in handle_connect_msg
    ([pr#21751](https://github.com/ceph/ceph/pull/21751), shangfufei)
-   msg: ceph_abort() when there are enough accepter errors in msg
    server ([issue#23649](http://tracker.ceph.com/issues/23649),
    [pr#23306](https://github.com/ceph/ceph/pull/23306),
    <penglaiyxy@gmail.com>)
-   msg: clear message middle when clearing encoded message buffer
    ([pr#24289](https://github.com/ceph/ceph/pull/24289), \"Yan,
    Zheng\")
-   msg: entity_addr_t::parse doesn\'t do memset(this, 0, \...) for
    clean-up ([issue#26937](http://tracker.ceph.com/issues/26937),
    [pr#23573](https://github.com/ceph/ceph/pull/23573), Radoslaw
    Zarzynski)
-   nautilus: mgr/dashboard: Validate [ceph-iscsi]{.title-ref} config
    version ([pr#26951](https://github.com/ceph/ceph/pull/26951),
    Ricardo Marques)
-   objecter: avoid race when reset down osd\'s session
    ([pr#25437](https://github.com/ceph/ceph/pull/25437), Zengran Zhang)
-   orchestrator_cli: fix HandleCommandResult invocations in \_status()
    ([pr#25329](https://github.com/ceph/ceph/pull/25329), Jeff Layton)
-   osd: add creating to pg_string_state
    ([issue#36174](http://tracker.ceph.com/issues/36174),
    [pr#24262](https://github.com/ceph/ceph/pull/24262), Dan van der
    Ster)
-   osd: add \--dump-journal option in ceph-osd help info
    ([pr#24969](https://github.com/ceph/ceph/pull/24969), yuliyang)
-   osd: Additional fields for osd \"bench\" command
    ([pr#21962](https://github.com/ceph/ceph/pull/21962), Коренберг
    Маркr)
-   osd: add log when pg reg next scrub
    ([pr#23690](https://github.com/ceph/ceph/pull/23690), lvshuhua)
-   osd: add required cls libraries as dependencies of osd
    ([pr#24373](https://github.com/ceph/ceph/pull/24373), Mohamad Gebai)
-   osd: Allow repair of an object with a bad data_digest in object_info
    on all replicas
    ([pr#23217](https://github.com/ceph/ceph/pull/23217), David Zafman)
-   osd: always set query_epoch explicitly for MOSDPGLog
    ([pr#22487](https://github.com/ceph/ceph/pull/22487), Kefu Chai)
-   osd: avoid using null agent_state
    ([pr#25393](https://github.com/ceph/ceph/pull/25393), Zengran Zhang)
-   osd: Change assert() to ceph_assert() missed in the transition
    ([pr#23918](https://github.com/ceph/ceph/pull/23918), David Zafman)
-   osd: Change osd_skip_data_digest default to false and make it
    LEVEL_DEV ([issue#24950](http://tracker.ceph.com/issues/24950),
    [pr#23083](https://github.com/ceph/ceph/pull/23083), Sage Weil,
    David Zafman)
-   osdc: invoke notify finish context on linger commit failure
    ([issue#23966](http://tracker.ceph.com/issues/23966),
    [pr#21831](https://github.com/ceph/ceph/pull/21831), Kefu Chai,
    Jason Dillaman)
-   osd: clean up and avoid extra ref-counting in
    PrimaryLogPG::log_op_stats
    ([pr#23016](https://github.com/ceph/ceph/pull/23016), Radoslaw
    Zarzynski)
-   osd: clean up smart probe
    ([issue#23899](http://tracker.ceph.com/issues/23899),
    [pr#21950](https://github.com/ceph/ceph/pull/21950), Sage Weil, Gu
    Zhongyan)
-   osd: collect client perf stats when query is enabled
    ([pr#24265](https://github.com/ceph/ceph/pull/24265), Julien Collet,
    Mykola Golub)
-   osd: combine recovery/scrub/snap sleep timer into one
    ([pr#21711](https://github.com/ceph/ceph/pull/21711), Jianpeng Ma)
-   osd: Deny reservation if expected backfill size would put us over
    bac... ([issue#24801](http://tracker.ceph.com/issues/24801),
    [issue#19753](http://tracker.ceph.com/issues/19753),
    [pr#22797](https://github.com/ceph/ceph/pull/22797), David Zafman)
-   osd: do not include Messenger.h if not necessary
    ([pr#22483](https://github.com/ceph/ceph/pull/22483), Kefu Chai)
-   osd: do not overestimate the size of the object for reads with
    trimtrunc ([issue#21931](http://tracker.ceph.com/issues/21931),
    [issue#22330](http://tracker.ceph.com/issues/22330),
    [pr#24564](https://github.com/ceph/ceph/pull/24564), Neha Ojha)
-   osd: do not treat an IO hint as an IOP for PG stats
    ([issue#24909](http://tracker.ceph.com/issues/24909),
    [pr#23029](https://github.com/ceph/ceph/pull/23029), Jason Dillaman)
-   osd: don\'t check overwrite flag when handling copy-get
    ([issue#21756](http://tracker.ceph.com/issues/21756),
    [pr#18241](https://github.com/ceph/ceph/pull/18241), huangjun)
-   osd: Don\'t evict even when preemption has restarted with smaller
    chunk ([pr#21892](https://github.com/ceph/ceph/pull/21892), David
    Zafman)
-   osd: do_sparse_read(): Verify checksum earlier so we will try to
    repair ([issue#24875](http://tracker.ceph.com/issues/24875),
    [pr#23377](https://github.com/ceph/ceph/pull/23377), David Zafman)
-   osd: drop the unused request_redirect_t::osd_instructions
    ([pr#24458](https://github.com/ceph/ceph/pull/24458), Radoslaw
    Zarzynski)
-   osd: ec saves a write access to the memory under most circumstances
    ([pr#26053](https://github.com/ceph/ceph/pull/26053), Zengran Zhang,
    Kefu Chai)
-   osd: fix build_incremental_map_msg
    ([issue#38282](http://tracker.ceph.com/issues/38282),
    [pr#26413](https://github.com/ceph/ceph/pull/26413), Sage Weil)
-   osd: fix memory leak in EC fast and error read
    ([pr#22500](https://github.com/ceph/ceph/pull/22500), xiaofei cui)
-   osd: Fix recovery and backfill priority handling
    ([issue#38041](http://tracker.ceph.com/issues/38041),
    [pr#26213](https://github.com/ceph/ceph/pull/26213), David Zafman)
-   osd: fix shard_info_wrapper encode
    ([issue#37653](http://tracker.ceph.com/issues/37653),
    [pr#25548](https://github.com/ceph/ceph/pull/25548), David Zafman)
-   osd: Handle omap and data digests independently
    ([issue#24366](http://tracker.ceph.com/issues/24366),
    [pr#22346](https://github.com/ceph/ceph/pull/22346), David Zafman)
-   osd: increase default hard pg limit
    ([pr#22187](https://github.com/ceph/ceph/pull/22187), Josh Durgin)
-   osd: keep using cache even if op will invalid cache
    ([pr#25490](https://github.com/ceph/ceph/pull/25490), Zengran Zhang)
-   osd: limit pg log length under all circumstances
    ([pr#23098](https://github.com/ceph/ceph/pull/23098), Neha Ojha)
-   osd: make OSD::HEARTBEAT_MAX_CONN inline
    ([pr#23424](https://github.com/ceph/ceph/pull/23424), Kefu Chai)
-   osd: make random shuffle comply with C++17
    ([pr#23533](https://github.com/ceph/ceph/pull/23533), Willem Jan
    Withagen)
-   osd/OSDMap: add osd status to utilization dumper
    ([issue#35544](http://tracker.ceph.com/issues/35544),
    [pr#23921](https://github.com/ceph/ceph/pull/23921), Paul Emmerich)
-   osd: per-pool osd stats collection
    ([pr#19454](https://github.com/ceph/ceph/pull/19454), Igor Fedotv,
    Igor Fedotov)
-   osd: Prevent negative local num_bytes sent to peer for backfill
    reser... ([issue#38344](http://tracker.ceph.com/issues/38344),
    [pr#26465](https://github.com/ceph/ceph/pull/26465), David Zafman)
-   osd: read object attrs failed at EC recovery
    ([pr#22196](https://github.com/ceph/ceph/pull/22196), xiaofei cui)
-   osd: refuse to start if we\'re \> N+2 from recorded
    require_osd_release
    ([issue#38076](http://tracker.ceph.com/issues/38076),
    [pr#26177](https://github.com/ceph/ceph/pull/26177), Sage Weil)
-   osd: reliably send pg_created messages to the mon
    ([issue#37775](http://tracker.ceph.com/issues/37775),
    [pr#25731](https://github.com/ceph/ceph/pull/25731), Sage Weil)
-   osd: Remove old bft= which has been superceded by backfill
    ([issue#36170](http://tracker.ceph.com/issues/36170),
    [pr#24256](https://github.com/ceph/ceph/pull/24256), David Zafman)
-   osd: remove stray derr
    ([pr#24042](https://github.com/ceph/ceph/pull/24042), Sage Weil)
-   osd: remove unused class read_log_and_missing_error
    ([pr#26057](https://github.com/ceph/ceph/pull/26057), Yao Zongyou)
-   osd: remove unused fields
    ([pr#26021](https://github.com/ceph/ceph/pull/26021), Jianpeng Ma)
-   osd: remove unused function
    ([pr#26223](https://github.com/ceph/ceph/pull/26223), Jianpeng Ma)
-   osd: Remove useless conditon
    ([pr#21766](https://github.com/ceph/ceph/pull/21766), Jianpeng Ma)
-   osd: some recovery improvements and cleanups
    ([pr#23663](https://github.com/ceph/ceph/pull/23663), xie xingguo)
-   osd: two heartbeat fixes
    ([pr#25126](https://github.com/ceph/ceph/pull/25126), xie xingguo)
-   osd: unlock osd_lock when tweaking osd settings
    ([issue#37751](http://tracker.ceph.com/issues/37751),
    [pr#25726](https://github.com/ceph/ceph/pull/25726), Kefu Chai)
-   osd: unmount store after service.shutdown()
    ([issue#37975](http://tracker.ceph.com/issues/37975),
    [pr#26043](https://github.com/ceph/ceph/pull/26043), Kefu Chai)
-   osd: Weighted Random Sampling for dynamic perf stats
    ([pr#25582](https://github.com/ceph/ceph/pull/25582), Mykola Golub)
-   osd: When possible check CRC in build_push_op() so repair can
    eventually stop
    ([issue#25084](http://tracker.ceph.com/issues/25084),
    [pr#23518](https://github.com/ceph/ceph/pull/23518), David Zafman)
-   osd: write \"bench\" output to stdout
    ([issue#24022](http://tracker.ceph.com/issues/24022),
    [pr#21905](https://github.com/ceph/ceph/pull/21905), John Spray)
-   os: Minor fixes in comments describing a transaction
    ([pr#22329](https://github.com/ceph/ceph/pull/22329), Bryan
    Stillwell)
-   performance: Add performance counters breadcrumb
    ([pr#22060](https://github.com/ceph/ceph/pull/22060), Ricardo
    Marques)
-   performance: mgr/dashboard: Enable gzip compression
    ([issue#36453](http://tracker.ceph.com/issues/36453),
    [pr#24727](https://github.com/ceph/ceph/pull/24727), Zack Cerza)
-   performance: mgr/dashboard: Replace dashboard service
    ([issue#36675](http://tracker.ceph.com/issues/36675),
    [pr#24900](https://github.com/ceph/ceph/pull/24900), Zack Cerza)
-   performance: msg/async: improve read-prefetch logic
    ([pr#25758](https://github.com/ceph/ceph/pull/25758), xie xingguo)
-   performance: qa/tasks/cbt.py: changes to run on bionic
    ([pr#22405](https://github.com/ceph/ceph/pull/22405), Neha Ojha)
-   performance,rbd: common/Throttle: TokenBucketThrottle: use reference
    to m_blockers.front()
    ([issue#36475](http://tracker.ceph.com/issues/36475),
    [pr#24604](https://github.com/ceph/ceph/pull/24604), Dongsheng Yang)
-   performance,rbd: pybind/rbd: optimize rbd_list2
    ([pr#25445](https://github.com/ceph/ceph/pull/25445), Mykola Golub)
-   Prevent duplicated rows during async tasks
    ([pr#22148](https://github.com/ceph/ceph/pull/22148), Ricardo
    Marques)
-   prometheus: Fix order of occupation values
    ([pr#22149](https://github.com/ceph/ceph/pull/22149), Boris Ranto)
-   pybind: do not check MFLAGS
    ([pr#23601](https://github.com/ceph/ceph/pull/23601), Kefu Chai)
-   pybind: pybind/ceph_daemon: expand the order of magnitude of
    daemonperf statistics to ZB
    ([issue#23962](http://tracker.ceph.com/issues/23962),
    [pr#21765](https://github.com/ceph/ceph/pull/21765), Guan yunfei)
-   pybind: pybind/rbd: make the code more concise
    ([pr#23664](https://github.com/ceph/ceph/pull/23664), Zheng Yin)
-   pybind,rbd: pybind/rbd: add allow_shrink=True as a parameter to def
    resize ([pr#23605](https://github.com/ceph/ceph/pull/23605), Zheng
    Yin)
-   pybind,rbd: pybind/rbd: fix a typo in metadata_get comments
    ([pr#26138](https://github.com/ceph/ceph/pull/26138), songweibin)
-   pybind,rgw: pybind/rgw: pass the flags to callback function
    ([pr#25766](https://github.com/ceph/ceph/pull/25766), Kefu Chai)
-   pybind: simplify timeout handling in run_in_thread()
    ([pr#24733](https://github.com/ceph/ceph/pull/24733), Kefu Chai)
-   qa/btrfs/test_rmdir_async_snap: remove binary file
    ([pr#24108](https://github.com/ceph/ceph/pull/24108), Cleber Rosa)
-   qa,pybind,tools: Correct usage of collections.abc
    ([pr#25318](https://github.com/ceph/ceph/pull/25318), James Page)
-   qa/test: Added rados, rbd and fs to run two time a week only
    ([pr#21839](https://github.com/ceph/ceph/pull/21839), Yuri
    Weinstein)
-   qa/tests: added 1st draft of mimic-x suite
    ([pr#23292](https://github.com/ceph/ceph/pull/23292), Yuri
    Weinstein)
-   qa/tests - added all supported distro
    ([pr#22647](https://github.com/ceph/ceph/pull/22647), Yuri
    Weinstein)
-   qa/tests - added all supported distro to the mix, ...
    ([pr#22674](https://github.com/ceph/ceph/pull/22674), Yuri
    Weinstein)
-   qa/tests: added client-upgrade-luminous suit
    ([pr#21947](https://github.com/ceph/ceph/pull/21947), Yuri
    Weinstein)
-   qa/tests: added \--filter-out=\"ubuntu_14.04\"
    ([pr#21949](https://github.com/ceph/ceph/pull/21949), Yuri
    Weinstein)
-   qa/tests - added luminous-p2p suite to the schedule
    ([pr#22666](https://github.com/ceph/ceph/pull/22666), Yuri
    Weinstein)
-   qa/tests: added mimic-x to the schedule
    ([pr#23302](https://github.com/ceph/ceph/pull/23302), Yuri
    Weinstein)
-   qa/tests - added powercycle suite to run on weekly basis on master
    and mimic ([pr#22606](https://github.com/ceph/ceph/pull/22606), Yuri
    Weinstein)
-   qa/tests: added supported distro for powercycle suite
    ([pr#22185](https://github.com/ceph/ceph/pull/22185), Yuri
    Weinstein)
-   qa/tests: changed ceph qa email address to bypass dreamhost\'s spam
    filter ([pr#23456](https://github.com/ceph/ceph/pull/23456), Yuri
    Weinstein)
-   qa/tests: changed disto symlink to point to new way using supported
    OS\'es ([pr#22536](https://github.com/ceph/ceph/pull/22536), Yuri
    Weinstein)
-   qa/tests: fixed typo
    ([pr#21858](https://github.com/ceph/ceph/pull/21858), Yuri
    Weinstein)
-   qa/tests: removed all jewel runs and reduced runs on ovh
    ([pr#22531](https://github.com/ceph/ceph/pull/22531), Yuri
    Weinstein)
-   rbd: add \'config global\' command to get/store overrides in mon
    config db ([pr#24428](https://github.com/ceph/ceph/pull/24428),
    Mykola Golub)
-   rbd: add data pool support to trash purge
    ([issue#22872](http://tracker.ceph.com/issues/22872),
    [pr#21247](https://github.com/ceph/ceph/pull/21247), Mahati
    Chamarthy)
-   rbd: add group snap rollback method
    ([issue#23550](http://tracker.ceph.com/issues/23550),
    [pr#23896](https://github.com/ceph/ceph/pull/23896), songweibin)
-   rbd: add protected in snap list
    ([pr#23853](https://github.com/ceph/ceph/pull/23853), Zheng Yin)
-   rbd: add snapshot count in rbd info
    ([pr#21292](https://github.com/ceph/ceph/pull/21292), Zheng Yin)
-   rbd: add the judgment of resizing the image
    ([pr#21770](https://github.com/ceph/ceph/pull/21770), zhengyin)
-   rbd: basic support for images within namespaces
    ([issue#24558](http://tracker.ceph.com/issues/24558),
    [pr#22673](https://github.com/ceph/ceph/pull/22673), Jason Dillaman)
-   rbd: close image when bench is interrupted
    ([pr#26693](https://github.com/ceph/ceph/pull/26693), Mykola Golub)
-   rbd: cls/lock: always store v1 addr in locker_info_t
    ([pr#25948](https://github.com/ceph/ceph/pull/25948), Sage Weil)
-   rbd: cls/rbd: fix build
    ([pr#22078](https://github.com/ceph/ceph/pull/22078), Kefu Chai)
-   rbd: cls/rbd: fixed uninitialized variable compiler warning
    ([pr#26896](https://github.com/ceph/ceph/pull/26896), Jason
    Dillaman)
-   rbd: cls/rbd: fix method comment
    ([pr#23277](https://github.com/ceph/ceph/pull/23277), Zheng Yin)
-   rbd: cls/rbd: silence the log of get metadata error
    ([pr#25436](https://github.com/ceph/ceph/pull/25436), songweibin)
-   rbd: correct parameter of namespace and verify it before
    set_namespace ([pr#23770](https://github.com/ceph/ceph/pull/23770),
    songweibin)
-   rbd: dashboard: support configuring block mirroring pools and peers
    ([pr#25210](https://github.com/ceph/ceph/pull/25210), Jason
    Dillaman)
-   rbd: disable cache for actions that open multiple images
    ([issue#24092](http://tracker.ceph.com/issues/24092),
    [pr#21946](https://github.com/ceph/ceph/pull/21946), Jason Dillaman)
-   rbd: disk-usage can now optionally compute exact on-disk usage
    ([issue#24064](http://tracker.ceph.com/issues/24064),
    [pr#21912](https://github.com/ceph/ceph/pull/21912), Jason Dillaman)
-   rbd: Document new RBD feature flags and version support
    ([pr#25192](https://github.com/ceph/ceph/pull/25192), Valentin
    Lorentz)
-   rbd: don\'t load config overrides from monitor initially
    ([pr#21910](https://github.com/ceph/ceph/pull/21910), Jason
    Dillaman)
-   rbd: error if new size is equal to original size
    ([pr#22637](https://github.com/ceph/ceph/pull/22637), zhengyin)
-   rbd: expose pool stats summary tool
    ([pr#24830](https://github.com/ceph/ceph/pull/24830), Jason
    Dillaman)
-   rbd: filter out group/trash snapshots from snap_list
    ([pr#23638](https://github.com/ceph/ceph/pull/23638), songweibin)
-   rbd: fix a typo in error output
    ([pr#25931](https://github.com/ceph/ceph/pull/25931), Dongsheng
    Yang)
-   rbd: fix delay time calculation for trash move
    ([pr#25896](https://github.com/ceph/ceph/pull/25896), Mykola Golub)
-   rbd: fix error import when the input is a pipe
    ([issue#34536](http://tracker.ceph.com/issues/34536),
    [pr#23835](https://github.com/ceph/ceph/pull/23835), songweibin)
-   rbd: fix segmentation fault when rbd_group_image_list() getting
    -ENOENT ([issue#38468](http://tracker.ceph.com/issues/38468),
    [pr#26622](https://github.com/ceph/ceph/pull/26622), songweibin)
-   rbd: fix some typos
    ([pr#25083](https://github.com/ceph/ceph/pull/25083), Shiyang Ruan)
-   rbd: implement new \'rbd perf image iostat/iotop\' commands
    ([issue#37913](http://tracker.ceph.com/issues/37913),
    [pr#26133](https://github.com/ceph/ceph/pull/26133), Jason Dillaman)
-   rbd: improved trash snapshot namespace handling
    ([issue#23398](http://tracker.ceph.com/issues/23398),
    [pr#23191](https://github.com/ceph/ceph/pull/23191), Jason Dillaman)
-   rbd: interlock object-map/fast-diff features together
    ([pr#21969](https://github.com/ceph/ceph/pull/21969), Mao Zhongyi)
-   rbd: introduce abort_on_full option for rbd map
    ([pr#25662](https://github.com/ceph/ceph/pull/25662), Dongsheng
    Yang)
-   rbd: journal: allow remove set when jounal pool is full
    ([pr#25166](https://github.com/ceph/ceph/pull/25166), kungf)
-   rbd: journal: fix potential race when closing object recorder
    ([pr#26425](https://github.com/ceph/ceph/pull/26425), Mykola Golub)
-   rbd: journal: set max journal order to 26
    ([issue#37541](http://tracker.ceph.com/issues/37541),
    [pr#25743](https://github.com/ceph/ceph/pull/25743), Mykola Golub)
-   rbd: krbd: support for images within namespaces
    ([pr#23841](https://github.com/ceph/ceph/pull/23841), Ilya Dryomov)
-   rbd: librbd/api: misc fix migration
    ([pr#25765](https://github.com/ceph/ceph/pull/25765), songweibin)
-   rbd: librbd: ensure exclusive lock acquired when removing sync point
    snapshots ([issue#24898](http://tracker.ceph.com/issues/24898),
    [pr#23095](https://github.com/ceph/ceph/pull/23095), Mykola Golub)
-   rbd: librbd: misc fix potential invalid pointer
    ([pr#25462](https://github.com/ceph/ceph/pull/25462), songweibin)
-   rbd: make sure the return-value \'r\' will be returned
    ([pr#24891](https://github.com/ceph/ceph/pull/24891), Shiyang Ruan)
-   rbd: mgr/dashboard: incorporate RBD overall performance grafana
    dashboard ([issue#37867](http://tracker.ceph.com/issues/37867),
    [pr#25927](https://github.com/ceph/ceph/pull/25927), Jason Dillaman)
-   rbd-mirror: always attempt to restart canceled status update task
    ([issue#36500](http://tracker.ceph.com/issues/36500),
    [pr#24646](https://github.com/ceph/ceph/pull/24646), Jason Dillaman)
-   rbd-mirror: bootstrap needs to handle local image id collision
    ([issue#24139](http://tracker.ceph.com/issues/24139),
    [pr#22043](https://github.com/ceph/ceph/pull/22043), Jason Dillaman)
-   rbd-mirror: create and export replication perf counters to mgr
    ([pr#25834](https://github.com/ceph/ceph/pull/25834), Mykola Golub)
-   rbd-mirror: ensure daemon can cleanly exit if pool is deleted
    ([pr#22348](https://github.com/ceph/ceph/pull/22348), Jason
    Dillaman)
-   rbd-mirror: ensure remote demotion is replayed locally
    ([issue#24009](http://tracker.ceph.com/issues/24009),
    [pr#21823](https://github.com/ceph/ceph/pull/21823), Jason Dillaman)
-   rbd-mirror: fixed potential crashes during shut down
    ([issue#24008](http://tracker.ceph.com/issues/24008),
    [pr#21817](https://github.com/ceph/ceph/pull/21817), Jason Dillaman)
-   rbd-mirror: guard access to image replayer perf counters
    ([pr#26097](https://github.com/ceph/ceph/pull/26097), Mykola Golub)
-   rbd-mirror: instantiate the status formatter before changing state
    ([issue#36084](http://tracker.ceph.com/issues/36084),
    [pr#24181](https://github.com/ceph/ceph/pull/24181), Jason Dillaman)
-   rbd-mirror: optionally extract peer secrets from config-key
    ([issue#24688](http://tracker.ceph.com/issues/24688),
    [pr#24036](https://github.com/ceph/ceph/pull/24036), Jason Dillaman)
-   rbd-mirror: optionally support active/active replication
    ([pr#21915](https://github.com/ceph/ceph/pull/21915), Mykola Golub,
    Jason Dillaman)
-   rbd-mirror: potential deadlock when running asok \'flush\' command
    ([issue#24141](http://tracker.ceph.com/issues/24141),
    [pr#22027](https://github.com/ceph/ceph/pull/22027), Mykola Golub)
-   rbd-mirror: prevent creation of clones when parents are syncing
    ([issue#24140](http://tracker.ceph.com/issues/24140),
    [pr#24063](https://github.com/ceph/ceph/pull/24063), Jason Dillaman)
-   rbd-mirror: schedule rebalancer to level-load instances
    ([issue#24161](http://tracker.ceph.com/issues/24161),
    [pr#22304](https://github.com/ceph/ceph/pull/22304), Venky Shankar)
-   rbd-mirror: update mirror status when stopping
    ([issue#36659](http://tracker.ceph.com/issues/36659),
    [pr#24864](https://github.com/ceph/ceph/pull/24864), Jason Dillaman)
-   rbd-mirror: use active/active policy by default
    ([issue#38453](http://tracker.ceph.com/issues/38453),
    [pr#26603](https://github.com/ceph/ceph/pull/26603), Jason Dillaman)
-   rbd: move image to trash as first step when removing
    ([issue#24226](http://tracker.ceph.com/issues/24226),
    [issue#38404](http://tracker.ceph.com/issues/38404),
    [pr#25438](https://github.com/ceph/ceph/pull/25438), Mahati
    Chamarthy, Jason Dillaman)
-   rbd-nbd: do not ceph_abort() after print the usages
    ([issue#36660](http://tracker.ceph.com/issues/36660),
    [pr#24815](https://github.com/ceph/ceph/pull/24815), Shiyang Ruan)
-   rbd-nbd: support namespaces
    ([issue#24609](http://tracker.ceph.com/issues/24609),
    [pr#25260](https://github.com/ceph/ceph/pull/25260), Mykola Golub)
-   rbd: not allowed to restore an image when it is being deleted
    ([issue#25346](http://tracker.ceph.com/issues/25346),
    [pr#24078](https://github.com/ceph/ceph/pull/24078), songweibin)
-   rbd: online re-sparsify of images
    ([pr#26226](https://github.com/ceph/ceph/pull/26226), Mykola Golub)
-   rbd: pybind/rbd: add namespace helper API methods
    ([issue#36622](http://tracker.ceph.com/issues/36622),
    [pr#25206](https://github.com/ceph/ceph/pull/25206), Jason Dillaman)
-   rbd: qa/workunits: fixed mon address parsing for rbd-mirror
    ([issue#38385](http://tracker.ceph.com/issues/38385),
    [pr#26521](https://github.com/ceph/ceph/pull/26521), Jason Dillaman)
-   rbd: rbd: fix error parse arg when getting key
    ([pr#25152](https://github.com/ceph/ceph/pull/25152), songweibin)
-   rbd: rbd-fuse: look for ceph.conf in standard locations
    ([issue#12219](http://tracker.ceph.com/issues/12219),
    [pr#20598](https://github.com/ceph/ceph/pull/20598), Jason Dillaman)
-   rbd: rbd-fuse: namespace support
    ([pr#25265](https://github.com/ceph/ceph/pull/25265), Mykola Golub)
-   rbd: rbd-ggate: support namespaces
    ([issue#24608](http://tracker.ceph.com/issues/24608),
    [pr#25266](https://github.com/ceph/ceph/pull/25266), Mykola Golub)
-   rbd: rbd-ggate: tag \"level\" with need_dynamic
    ([pr#22557](https://github.com/ceph/ceph/pull/22557), Kefu Chai)
-   rbd: rbd_mirror: assert no requests on destroying InstanceWatcher
    ([pr#25666](https://github.com/ceph/ceph/pull/25666), Mykola Golub)
-   rbd: rbd_mirror: don\'t report error if image replay canceled
    ([pr#25789](https://github.com/ceph/ceph/pull/25789), Mykola Golub)
-   rbd: rbd-mirror: use pool level config overrides
    ([pr#24348](https://github.com/ceph/ceph/pull/24348), Mykola Golub)
-   rbd: rbd: show info about mirror daemon instance in image mirror
    status output ([pr#24717](https://github.com/ceph/ceph/pull/24717),
    Mykola Golub)
-   rbd: return error code when the source and distination namespace are
    different ([pr#24893](https://github.com/ceph/ceph/pull/24893),
    Shiyang Ruan)
-   rbd: simplified code to remove do_clear_limit function
    ([pr#23954](https://github.com/ceph/ceph/pull/23954), Zheng Yin)
-   rbd: support namespaces for image migration
    ([issue#26951](http://tracker.ceph.com/issues/26951),
    [pr#24836](https://github.com/ceph/ceph/pull/24836), Jason Dillaman)
-   rbd: systemd/rbdmap.service: order us before remote-fs-pre.target
    ([issue#24713](http://tracker.ceph.com/issues/24713),
    [pr#22769](https://github.com/ceph/ceph/pull/22769), Ilya Dryomov)
-   rbd: test/librbd: drop unused variable 'num_aios'
    ([pr#23085](https://github.com/ceph/ceph/pull/23085), songweibin)
-   rbd,tests: krbd: alloc_size map option and tests
    ([pr#26244](https://github.com/ceph/ceph/pull/26244), Ilya Dryomov)
-   rbd,tests: librbd,test: remove unused context_cb() function, silence
    GCC warnings ([pr#24673](https://github.com/ceph/ceph/pull/24673),
    Kefu Chai)
-   rbd,tests: pybind/rbd: add assert_raise in test set_snap
    ([pr#22570](https://github.com/ceph/ceph/pull/22570), Zheng Yin)
-   rbd,tests: qa: krbd_exclusive_option.sh: bump lock_timeout to 60
    seconds ([issue#25080](http://tracker.ceph.com/issues/25080),
    [pr#22648](https://github.com/ceph/ceph/pull/22648), Ilya Dryomov)
-   rbd,tests: qa: krbd_msgr_segments.t: filter lvcreate output
    ([pr#22665](https://github.com/ceph/ceph/pull/22665), Ilya Dryomov)
-   rbd,tests: qa: krbd namespaces test
    ([pr#26339](https://github.com/ceph/ceph/pull/26339), Ilya Dryomov)
-   rbd,tests: qa: objectstore snippets for krbd
    ([pr#26279](https://github.com/ceph/ceph/pull/26279), Ilya Dryomov)
-   rbd,tests: qa: rbd_workunit_kernel_untar_build: install build
    dependencies ([issue#35074](http://tracker.ceph.com/issues/35074),
    [pr#23840](https://github.com/ceph/ceph/pull/23840), Ilya Dryomov)
-   rbd,tests: qa: rbd/workunits : Replace \"rbd bench-write\" with
    \"rbd bench \--io-type write\"
    ([pr#26168](https://github.com/ceph/ceph/pull/26168), Shyukri
    Shyukriev)
-   rbd,tests: qa/suites/krbd: more fsx tests
    ([pr#24354](https://github.com/ceph/ceph/pull/24354), Ilya Dryomov)
-   rbd,tests: qa/suites/rbd: randomly select a supported distro
    ([pr#22008](https://github.com/ceph/ceph/pull/22008), Jason
    Dillaman)
-   rbd,tests: qa/tasks/cram: tasks now must live in the repository
    ([pr#23976](https://github.com/ceph/ceph/pull/23976), Ilya Dryomov)
-   rbd,tests: qa/tasks/cram: use suite_repo repository for all cram
    jobs ([pr#23905](https://github.com/ceph/ceph/pull/23905), Ilya
    Dryomov)
-   rbd,tests: qa/tasks/qemu: use unique clone directory to avoid race
    with workunit ([issue#36542](http://tracker.ceph.com/issues/36542),
    [pr#24696](https://github.com/ceph/ceph/pull/24696), Jason Dillaman)
-   rbd,tests: qa/workunits/rbd: fix cli generic namespace test
    ([pr#24457](https://github.com/ceph/ceph/pull/24457), Mykola Golub)
-   rbd,tests: qa/workunits/rbd: force v2 image format for namespace
    test ([pr#24512](https://github.com/ceph/ceph/pull/24512), Mykola
    Golub)
-   rbd,tests: qa/workunits/rbd: replace usage of \'rados mkpool\'
    ([pr#23938](https://github.com/ceph/ceph/pull/23938), Jason
    Dillaman)
-   rbd,tests: qa/workunits: replace \'realpath\' with \'readlink -f\'
    in fsstress.sh ([issue#36409](http://tracker.ceph.com/issues/36409),
    [pr#24550](https://github.com/ceph/ceph/pull/24550), Jason Dillaman)
-   rbd,tests: test/cli-integration/rbd: added new parent image
    attributes ([pr#25415](https://github.com/ceph/ceph/pull/25415),
    Jason Dillaman)
-   rbd,tests: test/librados_test_stub: deterministically load cls
    shared libraries
    ([pr#21524](https://github.com/ceph/ceph/pull/21524), Jason
    Dillaman)
-   rbd,tests: test/librados_test_stub: handle object doesn\'t exist
    gracefully ([pr#25667](https://github.com/ceph/ceph/pull/25667),
    Mykola Golub)
-   rbd,tests: test/librbd: fix compiler -Wsign-compare warnings
    ([pr#23657](https://github.com/ceph/ceph/pull/23657), Mykola Golub)
-   rbd,tests: test/librbd: fix gmock warning in snapshot rollback test
    ([pr#23736](https://github.com/ceph/ceph/pull/23736), Jason
    Dillaman)
-   rbd,tests: test/librbd: fix gmock warning in
    TestMockIoImageRequestWQ.AcquireLockError
    ([pr#22778](https://github.com/ceph/ceph/pull/22778), Mykola Golub)
-   rbd,tests: test/librbd: fix gmock warnings for get_modify_timestamp
    call ([pr#23707](https://github.com/ceph/ceph/pull/23707), Mykola
    Golub)
-   rbd,tests: test/librbd: fix \'Uninteresting mock function call\'
    warning ([pr#26322](https://github.com/ceph/ceph/pull/26322), Mykola
    Golub)
-   rbd,tests: test/librbd: fix valgrind warnings
    ([pr#23827](https://github.com/ceph/ceph/pull/23827), Mykola Golub)
-   rbd,tests: test/librbd: fix -Wsign-compare warnings
    ([pr#23608](https://github.com/ceph/ceph/pull/23608), Kefu Chai)
-   rbd,tests: test/librbd: metadata key for config should be prefixed
    with `conf_` ([pr#25209](https://github.com/ceph/ceph/pull/25209),
    runsisi)
-   rbd,tests: test/librbd: migration supporting namespace tests
    ([pr#24919](https://github.com/ceph/ceph/pull/24919), Mykola Golub)
-   rbd,tests: test/librbd: migration tests did not delete additional
    pool ([pr#24009](https://github.com/ceph/ceph/pull/24009), Mykola
    Golub)
-   rbd,tests: test: move OpenStack devstack test to rocky release
    ([issue#36410](http://tracker.ceph.com/issues/36410),
    [pr#24563](https://github.com/ceph/ceph/pull/24563), Jason Dillaman)
-   rbd,tests: test/pybind: fix test_rbd.TestClone.test_trash_snapshot
    ([issue#25114](http://tracker.ceph.com/issues/25114),
    [pr#23256](https://github.com/ceph/ceph/pull/23256), Mykola Golub)
-   rbd,tests: test/pybind/test_rbd: filter out unknown list_children2
    keys ([issue#37729](http://tracker.ceph.com/issues/37729),
    [pr#25832](https://github.com/ceph/ceph/pull/25832), Mykola Golub)
-   rbd,tests: test/rbd-mirror: disable use of gtest-parallel
    ([pr#22694](https://github.com/ceph/ceph/pull/22694), Jason
    Dillaman)
-   rbd,tests: test/rbd_mirror: fix gmock warnings
    ([pr#25863](https://github.com/ceph/ceph/pull/25863), Mykola Golub)
-   rbd,tests: test/rbd_mirror: race in
    TestMockImageMap.AddInstancePingPongImageTest
    ([issue#36683](http://tracker.ceph.com/issues/36683),
    [pr#24897](https://github.com/ceph/ceph/pull/24897), Mykola Golub)
-   rbd,tests: test/rbd_mirror: race in WaitingOnLeaderReleaseLeader
    ([issue#36236](http://tracker.ceph.com/issues/36236),
    [pr#24300](https://github.com/ceph/ceph/pull/24300), Mykola Golub)
-   rbd,tests: test/rbd_mirror: wait for release leader lock fully
    complete ([pr#25935](https://github.com/ceph/ceph/pull/25935),
    Mykola Golub)
-   rbd,tests: test/rbd: rbd_ggate test improvements
    ([pr#23630](https://github.com/ceph/ceph/pull/23630), Willem Jan
    Withagen)
-   rbd,tests: test: silence -Wsign-compare warnings
    ([pr#23655](https://github.com/ceph/ceph/pull/23655), Kefu Chai)
-   rbd: tools/rbd/action: align column headers left
    ([pr#22566](https://github.com/ceph/ceph/pull/22566), Sage Weil)
-   rbd: tools/rbd: assert(g_ceph_context) not g_conf
    ([pr#23167](https://github.com/ceph/ceph/pull/23167), Kefu Chai)
-   rbd: tools/rbd: minor fixes for rbd du display
    ([pr#23311](https://github.com/ceph/ceph/pull/23311), songweibin)
-   rbd,tools: rbd-mirror,common: fix typos in logging messages and
    comments ([pr#25197](https://github.com/ceph/ceph/pull/25197),
    Shiyang Ruan)
-   rbd,tools: tools/rbd: assert(g_ceph_context) not g_conf
    ([pr#23008](https://github.com/ceph/ceph/pull/23008), Kefu Chai)
-   rbd: wait for all io complete when bench is interrupted
    ([pr#26918](https://github.com/ceph/ceph/pull/26918), Mykola Golub)
-   rbd: workaround for llvm linker problem, avoid std:pair dtor
    ([pr#25301](https://github.com/ceph/ceph/pull/25301), Willem Jan
    Withagen)
-   Revert \"cephfs-journal-tool: enable purge_queue journal\'s event
    comma... ([pr#23465](https://github.com/ceph/ceph/pull/23465),
    \"Yan, Zheng\")
-   Revert \"ceph-fuse: Delete inode\'s bufferhead was in Tx state would
    le... ([pr#21975](https://github.com/ceph/ceph/pull/21975), \"Yan,
    Zheng\")
-   rgw: abort_bucket_multiparts() ignores individual NoSuchUpload
    errors ([issue#35986](http://tracker.ceph.com/issues/35986),
    [pr#24110](https://github.com/ceph/ceph/pull/24110), Casey Bodley)
-   rgw: adapt AioThrottle for RGWGetObj
    ([pr#25208](https://github.com/ceph/ceph/pull/25208), Casey Bodley)
-   rgw: Add append object api
    ([pr#22755](https://github.com/ceph/ceph/pull/22755), zhang Shaowen,
    Zhang Shaowen)
-   rgw: add bucket as option when show/trim usage
    ([pr#23819](https://github.com/ceph/ceph/pull/23819), lvshuhua)
-   rgw: add configurable AWS-compat invalid range get behavior
    ([issue#24317](http://tracker.ceph.com/issues/24317),
    [pr#22231](https://github.com/ceph/ceph/pull/22231), Matt Benjamin)
-   rgw: add curl_low_speed_limit and curl_low_speed_time config to
    avoid ([pr#23058](https://github.com/ceph/ceph/pull/23058), Mark
    Kogan, Zhang Shaowen)
-   rgw: add Http header \'Server\' in response headers
    ([pr#23282](https://github.com/ceph/ceph/pull/23282), Zhang Shaowen)
-   rgw: Adding documentation for Roles
    ([pr#24714](https://github.com/ceph/ceph/pull/24714), Pritha
    Srivastava)
-   rgw: add latency info in the log of req done
    ([pr#23906](https://github.com/ceph/ceph/pull/23906), lvshuhua)
-   rgw: add list user admin OP API
    ([pr#25073](https://github.com/ceph/ceph/pull/25073), Oshyn Song)
-   rgw: add \--op-mask in radosgw-admin help info
    ([pr#24848](https://github.com/ceph/ceph/pull/24848), yuliyang)
-   rgw: add optional_yield to block_while_resharding()
    ([pr#25357](https://github.com/ceph/ceph/pull/25357), Casey Bodley)
-   rgw: add option for relaxed region enforcement
    ([issue#24507](http://tracker.ceph.com/issues/24507),
    [pr#22533](https://github.com/ceph/ceph/pull/22533), Matt Benjamin)
-   rgw: Add rgw xml unit tests
    ([pr#26682](https://github.com/ceph/ceph/pull/26682), Yuval
    Lifshitz)
-   rgw: add s3 notification sub resources
    ([pr#23405](https://github.com/ceph/ceph/pull/23405), yuliyang)
-   rgw: admin rest api support op-mask
    ([pr#24869](https://github.com/ceph/ceph/pull/24869), yuliyang)
-   rgw: admin/user ops dump user \'system\' flag
    ([pr#17414](https://github.com/ceph/ceph/pull/17414), fang.yuxiang)
-   rgw: All Your Fault
    ([issue#24962](http://tracker.ceph.com/issues/24962),
    [pr#23099](https://github.com/ceph/ceph/pull/23099), Adam C.
    Emerson)
-   rgw: apply quota config to users created via external auth
    ([issue#24595](http://tracker.ceph.com/issues/24595),
    [pr#24177](https://github.com/ceph/ceph/pull/24177), Casey Bodley)
-   rgw: archive zone
    ([pr#25137](https://github.com/ceph/ceph/pull/25137), Yehuda Sadeh,
    Javier M. Mellid)
-   rgw: async sync_object and remove_object does not access coroutine
    me... ([issue#35905](http://tracker.ceph.com/issues/35905),
    [pr#24007](https://github.com/ceph/ceph/pull/24007), Tianshan Qu)
-   rgw: async watch registration
    ([pr#21838](https://github.com/ceph/ceph/pull/21838), Yehuda Sadeh)
-   rgw: avoid race condition in RGWHTTPClient::wait()
    ([pr#21767](https://github.com/ceph/ceph/pull/21767), cfanz)
-   rgw: beast frontend logs socket errors at level 4
    ([pr#24677](https://github.com/ceph/ceph/pull/24677), Casey Bodley)
-   rgw: beast frontend parses ipv6 addrs
    ([issue#36662](http://tracker.ceph.com/issues/36662),
    [pr#24887](https://github.com/ceph/ceph/pull/24887), Casey Bodley)
-   rgw: beast frontend reworks pause/stop and yields during body io
    ([pr#21271](https://github.com/ceph/ceph/pull/21271), Casey Bodley)
-   rgw: bucket full sync handles delete markers
    ([issue#38007](http://tracker.ceph.com/issues/38007),
    [pr#26081](https://github.com/ceph/ceph/pull/26081), Casey Bodley)
-   rgw: bucket limit check misbehaves for \> max-entries buckets
    (usually... ([pr#26800](https://github.com/ceph/ceph/pull/26800),
    Matt Benjamin)
-   rgw: bucket sync status improvements, part 1
    ([pr#21788](https://github.com/ceph/ceph/pull/21788), Casey Bodley)
-   rgw: bug in versioning concurrent, list and get have consistency
    issue ([pr#26197](https://github.com/ceph/ceph/pull/26197), Wang
    Hao)
-   rgw: catch exceptions from librados::NObjectIterator
    ([issue#37091](http://tracker.ceph.com/issues/37091),
    [pr#25081](https://github.com/ceph/ceph/pull/25081), Casey Bodley)
-   rgw: change default rgw_thread_pool_size to 512
    ([issue#24544](http://tracker.ceph.com/issues/24544),
    [pr#22581](https://github.com/ceph/ceph/pull/22581), Douglas Fuller)
-   rgw: change the \"rgw admin status\" \'num_shards\' output to signed
    int ([issue#37645](http://tracker.ceph.com/issues/37645),
    [pr#25538](https://github.com/ceph/ceph/pull/25538), Mark Kogan)
-   rgw: check for non-existent bucket in RGWGetACLs
    ([pr#26212](https://github.com/ceph/ceph/pull/26212), Matt Benjamin)
-   rgw: civetweb: update for url validation fixes
    ([issue#24158](http://tracker.ceph.com/issues/24158),
    [pr#22054](https://github.com/ceph/ceph/pull/22054), Abhishek
    Lekshmanan)
-   rgw: civetweb: use poll instead of select while waiting on sockets
    ([issue#24364](http://tracker.ceph.com/issues/24364),
    [pr#24027](https://github.com/ceph/ceph/pull/24027), Abhishek
    Lekshmanan)
-   rgw: clean-up \-- insure C++ source code files contain editor
    directives ([pr#25495](https://github.com/ceph/ceph/pull/25495), J.
    Eric Ivancich)
-   rgw: cleanups for sync tracing
    ([pr#23828](https://github.com/ceph/ceph/pull/23828), Casey Bodley)
-   rgw: clean-up \-- use enum class for stats category
    ([pr#25450](https://github.com/ceph/ceph/pull/25450), J. Eric
    Ivancich)
-   rgw: cls/rgw: don\'t assert in decode_list_index_key()
    ([issue#24117](http://tracker.ceph.com/issues/24117),
    [pr#22440](https://github.com/ceph/ceph/pull/22440), Yehuda Sadeh)
-   rgw: cls/rgw: raise debug level of bi_log_iterate_entries output
    ([pr#25570](https://github.com/ceph/ceph/pull/25570), Casey Bodley)
-   rgw: cls/user: cls_user_remove_bucket writes modified header
    ([issue#36496](http://tracker.ceph.com/issues/36496),
    [pr#24645](https://github.com/ceph/ceph/pull/24645), Casey Bodley)
-   rgw: Code for STS Authentication
    ([pr#23504](https://github.com/ceph/ceph/pull/23504), Pritha
    Srivastava)
-   rgw: common/options: correct the description of
    rgw_enable_lc_threads option
    ([pr#23511](https://github.com/ceph/ceph/pull/23511), excellentkf)
-   rgw: continue enoent index in dir_suggest
    ([issue#24640](http://tracker.ceph.com/issues/24640),
    [pr#22937](https://github.com/ceph/ceph/pull/22937), Tianshan Qu)
-   rgw: copy actual stats from the source shards during reshard
    ([issue#36290](http://tracker.ceph.com/issues/36290),
    [pr#24444](https://github.com/ceph/ceph/pull/24444), Abhishek
    Lekshmanan)
-   rgw: Copying object data should generate new tail tag for the new
    object ([issue#24562](http://tracker.ceph.com/issues/24562),
    [pr#22613](https://github.com/ceph/ceph/pull/22613), Zhang Shaowen)
-   rgw: Correcting logic for signature calculation for non s3 ops
    ([pr#26098](https://github.com/ceph/ceph/pull/26098), Pritha
    Srivastava)
-   rgw: cors rules num limit
    ([pr#23434](https://github.com/ceph/ceph/pull/23434), yuliyang)
-   rgw: crypto: add openssl support for RGW encryption
    ([pr#15168](https://github.com/ceph/ceph/pull/15168), Qiaowei Ren)
-   rgw: data sync accepts ERR_PRECONDITION_FAILED on remove_object()
    ([issue#37448](http://tracker.ceph.com/issues/37448),
    [pr#25310](https://github.com/ceph/ceph/pull/25310), Casey Bodley)
-   rgw: data sync drains lease stack on lease failure
    ([issue#38479](http://tracker.ceph.com/issues/38479),
    [pr#26639](https://github.com/ceph/ceph/pull/26639), Casey Bodley)
-   rgw: data sync respects error_retry_time for backoff on error_repo
    ([issue#26938](http://tracker.ceph.com/issues/26938),
    [pr#23571](https://github.com/ceph/ceph/pull/23571), Casey Bodley)
-   rgw: delete multi object num limit
    ([pr#23544](https://github.com/ceph/ceph/pull/23544), yuliyang)
-   rgw: delete some unused code about std::regex
    ([pr#23221](https://github.com/ceph/ceph/pull/23221), Xueyu Bai)
-   rgw: \[DNM\] rgw: Controlling STS authentication via a Policy
    ([pr#24818](https://github.com/ceph/ceph/pull/24818), Pritha
    Srivastava)
-   rgw: do not ignore EEXIST in RGWPutObj::execute
    ([issue#22790](http://tracker.ceph.com/issues/22790),
    [pr#23033](https://github.com/ceph/ceph/pull/23033), Matt Benjamin)
-   rgw: Do not modify email if argument is not set
    ([pr#22024](https://github.com/ceph/ceph/pull/22024), Volker Theile)
-   rgw: dont access rgw_http_req\_<data::client> of canceled request
    ([issue#35851](http://tracker.ceph.com/issues/35851),
    [pr#23988](https://github.com/ceph/ceph/pull/23988), Casey Bodley)
-   rgw: Don\'t treat colons specially when matching resource field of
    ARNs in S3 Policy
    ([issue#23817](http://tracker.ceph.com/issues/23817),
    [pr#25145](https://github.com/ceph/ceph/pull/25145), Adam C.
    Emerson)
-   rgw: drop unused tmp in main()
    ([pr#23899](https://github.com/ceph/ceph/pull/23899), luomuyao)
-   rgw: escape markers in RGWOp_Metadata_List::execute
    ([issue#23099](http://tracker.ceph.com/issues/23099),
    [pr#22721](https://github.com/ceph/ceph/pull/22721), Matt Benjamin)
-   rgw: ES sync: be more restrictive on object system attrs
    ([issue#36233](http://tracker.ceph.com/issues/36233),
    [pr#24492](https://github.com/ceph/ceph/pull/24492), Abhishek
    Lekshmanan)
-   rgw: etag in rgw copy result response body rather in header
    ([pr#23751](https://github.com/ceph/ceph/pull/23751), yuliyang)
-   rgw: feature \-- log successful bucket resharding events
    ([pr#25510](https://github.com/ceph/ceph/pull/25510), J. Eric
    Ivancich)
-   rgw: fetch_remote_obj filters out olh attrs
    ([issue#37792](http://tracker.ceph.com/issues/37792),
    [pr#25794](https://github.com/ceph/ceph/pull/25794), Casey Bodley)
-   rgw: fix bad user stats on versioned bucket after reshard
    ([pr#25414](https://github.com/ceph/ceph/pull/25414), J. Eric
    Ivancich)
-   rgw: fix build ([pr#22194](https://github.com/ceph/ceph/pull/22194),
    Yehuda Sadeh)
-   rgw: fix build ([pr#23248](https://github.com/ceph/ceph/pull/23248),
    Matt Benjamin)
-   rgw: fix chunked-encoding for chunks \>1MiB
    ([issue#35990](http://tracker.ceph.com/issues/35990),
    [pr#24114](https://github.com/ceph/ceph/pull/24114), Robin H.
    Johnson)
-   rgw: fix compilation after pubsub conflict
    ([pr#25568](https://github.com/ceph/ceph/pull/25568), Casey Bodley)
-   rgw: fix copy response header etag format not correct
    ([issue#24563](http://tracker.ceph.com/issues/24563),
    [pr#22614](https://github.com/ceph/ceph/pull/22614), Tianshan Qu)
-   rgw: fix CreateBucket with BucketLocation parameter failed under
    default zonegroup
    ([pr#22312](https://github.com/ceph/ceph/pull/22312), Enming Zhang)
-   rgw: fix deadlock on RGWIndexCompletionManager::stop
    ([issue#26949](http://tracker.ceph.com/issues/26949),
    [pr#23590](https://github.com/ceph/ceph/pull/23590), Yao Zongyou)
-   rgw: fix dependencies/target_link_libraries
    ([pr#23056](https://github.com/ceph/ceph/pull/23056), Michal
    Jarzabek)
-   rgw: fixes for sync of versioned objects
    ([issue#24367](http://tracker.ceph.com/issues/24367),
    [pr#22347](https://github.com/ceph/ceph/pull/22347), Casey Bodley)
-   rgw: Fixes to permission evaluation related to user policies
    ([pr#25180](https://github.com/ceph/ceph/pull/25180), Pritha
    Srivastava)
-   rgw: fix Etag error in multipart copy response
    ([pr#23749](https://github.com/ceph/ceph/pull/23749), yuliyang)
-   rgw: Fix for buffer overflow in STS op_post()
    ([issue#36579](http://tracker.ceph.com/issues/36579),
    [pr#24510](https://github.com/ceph/ceph/pull/24510), Pritha
    Srivastava, Marcus Watts)
-   rgw: Fix for SignatureMismatchError in s3 commands
    ([pr#26204](https://github.com/ceph/ceph/pull/26204), Pritha
    Srivastava)
-   rgw: fix FTBFS introduced by abca9805
    ([pr#23046](https://github.com/ceph/ceph/pull/23046), Kefu Chai)
-   rgw: fix index complete miss zones_trace set
    ([issue#24590](http://tracker.ceph.com/issues/24590),
    [pr#22632](https://github.com/ceph/ceph/pull/22632), Tianshan Qu)
-   rgw: fix index update in dir_suggest_changes
    ([issue#24280](http://tracker.ceph.com/issues/24280),
    [pr#22217](https://github.com/ceph/ceph/pull/22217), Tianshan Qu)
-   rgw: fix ldap secret parsing
    ([pr#25796](https://github.com/ceph/ceph/pull/25796), Matt Benjamin)
-   rgw: fix leak of curl handle on shutdown
    ([issue#35715](http://tracker.ceph.com/issues/35715),
    [pr#23986](https://github.com/ceph/ceph/pull/23986), Casey Bodley)
-   rgw: Fix log level of gc_iterate_entries
    ([issue#23801](http://tracker.ceph.com/issues/23801),
    [pr#22868](https://github.com/ceph/ceph/pull/22868), iliul)
-   rgw: fix max-size in radosgw-admin and REST Admin API
    ([pr#24062](https://github.com/ceph/ceph/pull/24062), Nick Erdmann)
-   rgw: fix meta and data notify thread miss stop cr manager
    ([issue#24589](http://tracker.ceph.com/issues/24589),
    [pr#22631](https://github.com/ceph/ceph/pull/22631), Tianshan Qu)
-   rgw: fix obj can still be deleted even if deleteobject policy is set
    ([issue#37403](http://tracker.ceph.com/issues/37403),
    [pr#25278](https://github.com/ceph/ceph/pull/25278), Enming.Zhang)
-   rgw: fix radosgw-admin build error
    ([pr#21599](https://github.com/ceph/ceph/pull/21599), cfanz)
-   rgw: fix rgw_data_sync\_<info::json_decode>()
    ([issue#38373](http://tracker.ceph.com/issues/38373),
    [pr#26494](https://github.com/ceph/ceph/pull/26494), Casey Bodley)
-   rgw: fix RGWSyncTraceNode crash in reload
    ([issue#24432](http://tracker.ceph.com/issues/24432),
    [pr#22432](https://github.com/ceph/ceph/pull/22432), Tianshan Qu)
-   rgw: fix stats for versioned buckets after reshard
    ([pr#25333](https://github.com/ceph/ceph/pull/25333), J. Eric
    Ivancich)
-   rgw: fix uninitialized access
    ([pr#25002](https://github.com/ceph/ceph/pull/25002), Yehuda Sadeh)
-   rgw: fix unordered bucket listing when object names are adorned
    ([issue#38486](http://tracker.ceph.com/issues/38486),
    [pr#26658](https://github.com/ceph/ceph/pull/26658), J. Eric
    Ivancich)
-   rgw: fix vector index out of range in
    RGWReadDataSyncRecoveringShardsCR
    ([issue#36537](http://tracker.ceph.com/issues/36537),
    [pr#24680](https://github.com/ceph/ceph/pull/24680), Casey Bodley)
-   rgw: fix version bucket stats
    ([issue#21429](http://tracker.ceph.com/issues/21429),
    [pr#17789](https://github.com/ceph/ceph/pull/17789), Shasha Lu)
-   rgw: fix versioned obj copy generating tags
    ([issue#37588](http://tracker.ceph.com/issues/37588),
    [pr#25473](https://github.com/ceph/ceph/pull/25473), Abhishek
    Lekshmanan)
-   rgw: fix wrong debug related to user ACLs in
    rgw_build_bucket_policies()
    ([issue#19514](http://tracker.ceph.com/issues/19514),
    [pr#14369](https://github.com/ceph/ceph/pull/14369), Radoslaw
    Zarzynski)
-   rgw: get or set realm zonegroup zone need check user\'s caps
    ([pr#25178](https://github.com/ceph/ceph/pull/25178), yuliyang,
    Casey Bodley)
-   rgw: Get the user metadata of the user used to sign the request
    ([pr#22390](https://github.com/ceph/ceph/pull/22390), Volker Theile)
-   rgw: handle cases around zone deletion
    ([issue#37328](http://tracker.ceph.com/issues/37328),
    [pr#25160](https://github.com/ceph/ceph/pull/25160), Abhishek
    Lekshmanan)
-   rgw: handle S3 version 2 pre-signed urls with meta-data
    ([pr#24683](https://github.com/ceph/ceph/pull/24683), Matt Benjamin)
-   rgw: have a configurable authentication order
    ([issue#23089](http://tracker.ceph.com/issues/23089),
    [pr#21494](https://github.com/ceph/ceph/pull/21494), Abhishek
    Lekshmanan)
-   rgw: http client: print curl error messages during curl failures
    ([pr#23318](https://github.com/ceph/ceph/pull/23318), Abhishek
    Lekshmanan)
-   rgw: Improvements to STS Lite documentation
    ([pr#24847](https://github.com/ceph/ceph/pull/24847), Pritha
    Srivastava)
-   rgw: Initial commit for AssumeRoleWithWebIdentity
    ([pr#26002](https://github.com/ceph/ceph/pull/26002), Pritha
    Srivastava)
-   rgw: initial RGWRados refactoring work
    ([pr#24014](https://github.com/ceph/ceph/pull/24014), Yehuda Sadeh,
    Casey Bodley)
-   rgw: Initial work for OPA-Ceph integration
    ([pr#22624](https://github.com/ceph/ceph/pull/22624), Ashutosh
    Narkar)
-   rgw: librgw: initialize curl and http client for multisite
    ([issue#36302](http://tracker.ceph.com/issues/36302),
    [pr#24402](https://github.com/ceph/ceph/pull/24402), Casey Bodley)
-   rgw: librgw: support symbolic link
    ([pr#19684](https://github.com/ceph/ceph/pull/19684), Tao Chen)
-   rgw: lifcycle: don\'t reject compound rules with empty prefix
    ([issue#37879](http://tracker.ceph.com/issues/37879),
    [pr#25926](https://github.com/ceph/ceph/pull/25926), Matt Benjamin)
-   rgw: Limit the number of lifecycle rules on one bucket
    ([issue#24572](http://tracker.ceph.com/issues/24572),
    [pr#22623](https://github.com/ceph/ceph/pull/22623), Zhang Shaowen)
-   rgw: list bucket can not show the object uploaded by RGWPostObj when
    enable bucket versioning
    ([pr#24341](https://github.com/ceph/ceph/pull/24341), yuliyang)
-   rgw: log http status with op prefix if available
    ([pr#25102](https://github.com/ceph/ceph/pull/25102), Casey Bodley)
-   rgw: log refactoring for data sync
    ([pr#23843](https://github.com/ceph/ceph/pull/23843), Casey Bodley)
-   rgw: log refactoring for meta sync
    ([pr#23950](https://github.com/ceph/ceph/pull/23950), Casey Bodley,
    Ali Maredia)
-   rgw: make beast the default for rgw_frontends
    ([pr#26599](https://github.com/ceph/ceph/pull/26599), Casey Bodley)
-   rgw: Minor fixes to AssumeRole for boto compliance
    ([pr#24845](https://github.com/ceph/ceph/pull/24845), Pritha
    Srivastava)
-   rgw: Minor fixes to radosgw-admin commands for a role
    ([pr#24730](https://github.com/ceph/ceph/pull/24730), Pritha
    Srivastava)
-   rgw: move all reshard config options out of legacy_config_options
    ([pr#25356](https://github.com/ceph/ceph/pull/25356), J. Eric
    Ivancich)
-   rgw: move keystone secrets from ceph.conf to files
    ([issue#36621](http://tracker.ceph.com/issues/36621),
    [pr#24816](https://github.com/ceph/ceph/pull/24816), Matt Benjamin)
-   rgw: multiple es related fixes and improvements
    ([issue#22877](http://tracker.ceph.com/issues/22877),
    [issue#38028](http://tracker.ceph.com/issues/38028),
    [issue#38030](http://tracker.ceph.com/issues/38030),
    [issue#36092](http://tracker.ceph.com/issues/36092),
    [pr#26106](https://github.com/ceph/ceph/pull/26106), Yehuda Sadeh,
    Abhishek Lekshmanan)
-   rgw: need to give a type in list constructor
    ([pr#25161](https://github.com/ceph/ceph/pull/25161), Willem Jan
    Withagen)
-   rgw: new librgw_admin_us
    ([pr#21439](https://github.com/ceph/ceph/pull/21439), Orit
    Wasserman, Matt Benjamin)
-   rgw: policy: fix NotAction, NotPricipal, NotResource does not take
    effect ([pr#23625](https://github.com/ceph/ceph/pull/23625),
    xiangxiang)
-   rgw: policy: fix s3:x-amz-grant-read-acp keyword error
    ([pr#23610](https://github.com/ceph/ceph/pull/23610), xiangxiang)
-   rgw: policy: modify some operation permission keyword
    ([issue#24061](http://tracker.ceph.com/issues/24061),
    [pr#20974](https://github.com/ceph/ceph/pull/20974), xiangxiang)
-   rgw: pub-sub ([pr#23298](https://github.com/ceph/ceph/pull/23298),
    Yehuda Sadeh)
-   rgw: qa/suites/rgw/verify/tasks/cls_rgw: test cls_rgw
    ([pr#22919](https://github.com/ceph/ceph/pull/22919), Sage Weil)
-   rgw: radogw-admin reshard status command should print text for
    reshard status ([issue#23257](http://tracker.ceph.com/issues/23257),
    [pr#20779](https://github.com/ceph/ceph/pull/20779), Orit Wasserman)
-   rgw: radosgw-admin: add mfa related command and options
    ([pr#23416](https://github.com/ceph/ceph/pull/23416), Enming.Zhang)
-   rgw: [radosgw-admin bucket rm \... \--purge-objects]{.title-ref} can
    hang ([issue#38134](http://tracker.ceph.com/issues/38134),
    [pr#26231](https://github.com/ceph/ceph/pull/26231), J. Eric
    Ivancich)
-   rgw: \"radosgw-admin objects expire\" always returns ok even if the
    process fails ([issue#24592](http://tracker.ceph.com/issues/24592),
    [pr#22635](https://github.com/ceph/ceph/pull/22635), Zhang Shaowen)
-   rgw: radosgw-admin: \'sync error trim\' loops until complete
    ([issue#24873](http://tracker.ceph.com/issues/24873),
    [pr#23032](https://github.com/ceph/ceph/pull/23032), Casey Bodley)
-   rgw: radosgw-admin: translate reshard status codes (trivial)
    ([issue#36486](http://tracker.ceph.com/issues/36486),
    [pr#24638](https://github.com/ceph/ceph/pull/24638), Matt Benjamin)
-   rgw: RADOS::Obj::operate takes optional_yield
    ([pr#25068](https://github.com/ceph/ceph/pull/25068), Casey Bodley)
-   rgw: rados tiering
    ([issue#19510](http://tracker.ceph.com/issues/19510),
    [pr#25774](https://github.com/ceph/ceph/pull/25774), yuliyang,
    Yehuda Sadeh, Zhang Shaowen)
-   rgw: raise debug level on redundant data sync error messages
    ([issue#35830](http://tracker.ceph.com/issues/35830),
    [pr#23981](https://github.com/ceph/ceph/pull/23981), Casey Bodley)
-   rgw: raise default rgw_curl_low_speed_time to 300 seconds
    ([issue#27989](http://tracker.ceph.com/issues/27989),
    [pr#23759](https://github.com/ceph/ceph/pull/23759), Casey Bodley)
-   rgw: refactor logging in gc and lc
    ([pr#24530](https://github.com/ceph/ceph/pull/24530), Ali Maredia)
-   rgw: refactor PutObjProcessor stack
    ([pr#24453](https://github.com/ceph/ceph/pull/24453), Casey Bodley)
-   rgw: reject invalid methods in validate_cors_rule_method
    ([issue#24223](http://tracker.ceph.com/issues/24223),
    [pr#22145](https://github.com/ceph/ceph/pull/22145), Jeegn Chen)
-   rgw: remove all traces of cls replica_log
    ([pr#21680](https://github.com/ceph/ceph/pull/21680), Casey Bodley)
-   rgw: remove duplicated `RGWRados::list_buckets_` helpers
    ([pr#25240](https://github.com/ceph/ceph/pull/25240), Casey Bodley)
-   rgw: remove expired entries from the cache
    ([issue#23379](http://tracker.ceph.com/issues/23379),
    [pr#22410](https://github.com/ceph/ceph/pull/22410), Mark Kogan)
-   rgw: remove repetitive conditional statement in
    RGWHandler_REST_Obj_S3
    ([pr#24162](https://github.com/ceph/ceph/pull/24162), Zhang Shaowen)
-   rgw: remove rgw_aclparser.cc
    ([issue#36665](http://tracker.ceph.com/issues/36665),
    [pr#24866](https://github.com/ceph/ceph/pull/24866), Matt Benjamin)
-   rgw: remove the useless is_cors_op in RGWHandler_REST_Obj_S3
    ([pr#22114](https://github.com/ceph/ceph/pull/22114), Zhang Shaowen)
-   rgw: remove unused aio helper functions
    ([pr#25239](https://github.com/ceph/ceph/pull/25239), Casey Bodley)
-   rgw: renew resharding locks to prevent expiration
    ([issue#27219](http://tracker.ceph.com/issues/27219),
    [issue#34307](http://tracker.ceph.com/issues/34307),
    [pr#24406](https://github.com/ceph/ceph/pull/24406), Orit
    Wasserman, J. Eric Ivancich)
-   rgw: repair olh attributes that were broken by sync
    ([issue#37792](http://tracker.ceph.com/issues/37792),
    [pr#26157](https://github.com/ceph/ceph/pull/26157), Casey Bodley)
-   rgw: require \--yes-i-really-mean-it to run radosgw-admin orphans
    find ([issue#24146](http://tracker.ceph.com/issues/24146),
    [pr#22036](https://github.com/ceph/ceph/pull/22036), Matt Benjamin)
-   rgw: reshard add: fail correctly on a non existant bucket
    ([issue#36449](http://tracker.ceph.com/issues/36449),
    [pr#24594](https://github.com/ceph/ceph/pull/24594), Abhishek
    Lekshmanan)
-   rgw: reshard clean-up and associated commits
    ([pr#25142](https://github.com/ceph/ceph/pull/25142), J. Eric
    Ivancich)
-   rgw: reshard improvements
    ([pr#25003](https://github.com/ceph/ceph/pull/25003), J. Eric
    Ivancich)
-   rgw: reshard stale instance cleanup
    ([issue#24082](http://tracker.ceph.com/issues/24082),
    [pr#24662](https://github.com/ceph/ceph/pull/24662), Abhishek
    Lekshmanan)
-   rgw: resolve bugs and clean up garbage collection code
    ([issue#38454](http://tracker.ceph.com/issues/38454),
    [pr#26601](https://github.com/ceph/ceph/pull/26601), J. Eric
    Ivancich)
-   rgw: resolve bug where marker was not advanced during garbage
    collection ([issue#38408](http://tracker.ceph.com/issues/38408),
    [pr#26545](https://github.com/ceph/ceph/pull/26545), J. Eric
    Ivancich)
-   rgw: return err_malformed_xml when MaxAgeSeconds is an invalid
    integer ([issue#26957](http://tracker.ceph.com/issues/26957),
    [pr#23626](https://github.com/ceph/ceph/pull/23626), Chang Liu)
-   rgw: Return tenant field in bucket_stats function
    ([pr#24895](https://github.com/ceph/ceph/pull/24895), Volker Theile)
-   rgw: return valid Location element, PostObj
    ([issue#22927](http://tracker.ceph.com/issues/22927),
    [pr#20330](https://github.com/ceph/ceph/pull/20330), yuliyang)
-   rgw: return x-amz-version-id: null when delete obj in versioning
    suspended bucket
    ([issue#35814](http://tracker.ceph.com/issues/35814),
    [pr#23927](https://github.com/ceph/ceph/pull/23927), yuliyang)
-   rgw: Revert \"rgw: lifcycle: don\'t reject compound rules with empty
    prefix\" ([pr#26491](https://github.com/ceph/ceph/pull/26491), Matt
    Benjamin)
-   rgw: rgw-admin: add \"\--trim-delay-ms\" introduction for \'sync
    error trim\' ([pr#23342](https://github.com/ceph/ceph/pull/23342),
    Enming.Zhang)
-   rgw: rgw-admin: fix data sync report for master zone
    ([pr#23925](https://github.com/ceph/ceph/pull/23925), cfanz)
-   rgw: RGWAsyncGetBucketInstanceInfo does not access coroutine memory
    ([issue#35812](http://tracker.ceph.com/issues/35812),
    [pr#23987](https://github.com/ceph/ceph/pull/23987), Casey Bodley)
-   rgw: rgw/beast: drop privileges after binding ports
    ([issue#36041](http://tracker.ceph.com/issues/36041),
    [pr#24271](https://github.com/ceph/ceph/pull/24271), Paul Emmerich)
-   rgw: RGWBucket::link supports tenant
    ([issue#22666](http://tracker.ceph.com/issues/22666),
    [pr#23119](https://github.com/ceph/ceph/pull/23119), Casey Bodley)
-   rgw: rgw: change the way sysobj filters raw attributes, fix bucket
    sync state xattrs
    ([issue#37281](http://tracker.ceph.com/issues/37281),
    [pr#25123](https://github.com/ceph/ceph/pull/25123), Yehuda Sadeh)
-   rgw: rgw, cls: remove cls_statelog and rgw opstate tracking
    ([pr#24059](https://github.com/ceph/ceph/pull/24059), Casey Bodley)
-   rgw: rgw_file: deep stat handling
    ([issue#24915](http://tracker.ceph.com/issues/24915),
    [pr#23038](https://github.com/ceph/ceph/pull/23038), Matt Benjamin)
-   rgw: rgw_file: not check max_objects when creating file
    ([pr#24846](https://github.com/ceph/ceph/pull/24846), Tao Chen)
-   rgw: rgw_file: use correct secret key to check auth
    ([pr#26130](https://github.com/ceph/ceph/pull/26130), MinSheng Lin)
-   rgw: rgw_file: user info never synced since librgw init
    ([pr#25406](https://github.com/ceph/ceph/pull/25406), Tao Chen)
-   rgw: \[rgw\]: Fix help of radosgw-admin user info in case no uid
    ([pr#25078](https://github.com/ceph/ceph/pull/25078), Marc Koderer)
-   rgw: rgwgc:process coredump in some special case
    ([issue#23199](http://tracker.ceph.com/issues/23199),
    [pr#25430](https://github.com/ceph/ceph/pull/25430), zhaokun)
-   rgw: rgw multisite: async rados requests don\'t access coroutine
    memory ([issue#35543](http://tracker.ceph.com/issues/35543),
    [pr#23920](https://github.com/ceph/ceph/pull/23920), Casey Bodley)
-   rgw: rgw multisite: bucket sync transitions back to StateInit on
    OP_SYNCSTOP ([issue#26895](http://tracker.ceph.com/issues/26895),
    [pr#23574](https://github.com/ceph/ceph/pull/23574), Casey Bodley)
-   rgw: rgw multisite: enforce spawn_window for data full sync
    ([issue#26897](http://tracker.ceph.com/issues/26897),
    [pr#23534](https://github.com/ceph/ceph/pull/23534), Casey Bodley)
-   rgw: rgw-multisite: fix endless loop in
    RGWBucketShardIncrementalSyncCR
    ([issue#24603](http://tracker.ceph.com/issues/24603),
    [pr#22660](https://github.com/ceph/ceph/pull/22660), cfanz)
-   rgw: rgw multisite: incremental data sync uses truncated flag to
    detect end of listing
    ([issue#26952](http://tracker.ceph.com/issues/26952),
    [pr#23596](https://github.com/ceph/ceph/pull/23596), Casey Bodley)
-   rgw: rgw multisite: only update last_trim marker on ENODATA
    ([issue#38075](http://tracker.ceph.com/issues/38075),
    [pr#26190](https://github.com/ceph/ceph/pull/26190), Casey Bodley)
-   rgw: rgw multisite: uses local DataChangesLog to track active
    buckets for trim
    ([issue#36034](http://tracker.ceph.com/issues/36034),
    [pr#24221](https://github.com/ceph/ceph/pull/24221), Casey Bodley)
-   rgw: rgw/pubsub: add amqp push endpoint
    ([pr#25866](https://github.com/ceph/ceph/pull/25866), Yuval
    Lifshitz)
-   rgw: rgw/pubsub: add pubsub tests
    ([pr#26299](https://github.com/ceph/ceph/pull/26299), Yuval
    Lifshitz)
-   rgw: RGWRadosGetOmapKeysCR takes result by shared_ptr
    ([issue#21154](http://tracker.ceph.com/issues/21154),
    [pr#23634](https://github.com/ceph/ceph/pull/23634), Casey Bodley)
-   rgw: RGWRadosGetOmapKeysCR uses \'more\' flag from omap_get_keys2()
    ([pr#23401](https://github.com/ceph/ceph/pull/23401), Casey Bodley,
    Sage Weil)
-   rgw: remove duplicate include header files in rgw_rados.cc
    ([pr#18578](https://github.com/ceph/ceph/pull/18578), Sibei Gao)
-   rgw: rgw_sync: drop ENOENT error logs from mdlog
    ([pr#26971](https://github.com/ceph/ceph/pull/26971), Abhishek
    Lekshmanan)
-   rgw: Robustly notify
    ([issue#24963](http://tracker.ceph.com/issues/24963),
    [pr#23100](https://github.com/ceph/ceph/pull/23100), Adam C.
    Emerson)
-   rgw: s3: awsv4 drop special handling for x-amz-credential
    ([issue#26965](http://tracker.ceph.com/issues/26965),
    [pr#23652](https://github.com/ceph/ceph/pull/23652), Abhishek
    Lekshmanan)
-   rgw: sanitize customer encryption keys from log output in v4 auth
    ([issue#37847](http://tracker.ceph.com/issues/37847),
    [pr#25881](https://github.com/ceph/ceph/pull/25881), Casey Bodley)
-   rgw: scheduler ([pr#26008](https://github.com/ceph/ceph/pull/26008),
    Casey Bodley, Abhishek Lekshmanan)
-   rgw: set cr state if aio_read err return in RGWCloneMetaLogCoroutine
    ([issue#24566](http://tracker.ceph.com/issues/24566),
    [pr#22617](https://github.com/ceph/ceph/pull/22617), Tianshan Qu)
-   rgw: set default objecter_inflight_ops = 24576
    ([issue#25109](http://tracker.ceph.com/issues/25109),
    [pr#23242](https://github.com/ceph/ceph/pull/23242), Matt Benjamin)
-   rgw: should recode canonical_uri when caculate s3 v4 auth
    ([issue#23587](http://tracker.ceph.com/issues/23587),
    [pr#21286](https://github.com/ceph/ceph/pull/21286), yuliyang)
-   rgw: some fix for es sync
    ([issue#23842](http://tracker.ceph.com/issues/23842),
    [issue#23841](http://tracker.ceph.com/issues/23841),
    [pr#21622](https://github.com/ceph/ceph/pull/21622), Tianshan Qu,
    Shang Ding)
-   rgw: support admin rest api get user info through user\'s access-key
    ([pr#22790](https://github.com/ceph/ceph/pull/22790), yuliyang)
-   rgw: support server-side encryption when SSL is terminated in a
    proxy ([issue#27221](http://tracker.ceph.com/issues/27221),
    [pr#24700](https://github.com/ceph/ceph/pull/24700), Casey Bodley)
-   rgw: Swift SLO size_bytes member is optional
    ([issue#18936](http://tracker.ceph.com/issues/18936),
    [pr#22967](https://github.com/ceph/ceph/pull/22967), Matt Benjamin)
-   rgw: Swift\'s TempURL can handle temp_url_expires written in ISO8601
    ([issue#20795](http://tracker.ceph.com/issues/20795),
    [pr#16658](https://github.com/ceph/ceph/pull/16658), Radoslaw
    Zarzynski)
-   rgw: sync module: avoid printing attrs of objects in log
    ([issue#37646](http://tracker.ceph.com/issues/37646),
    [pr#25541](https://github.com/ceph/ceph/pull/25541), Abhishek
    Lekshmanan)
-   rgw: test bi list
    ([issue#24483](http://tracker.ceph.com/issues/24483),
    [pr#21772](https://github.com/ceph/ceph/pull/21772), Orit Wasserman)
-   rgw: test/rgw: add ifdef for HAVE_BOOST_CONTEXT
    ([pr#25744](https://github.com/ceph/ceph/pull/25744), Casey Bodley)
-   rgw,tests: qa: add test for
    <https://github.com/ceph/ceph/pull/22790>
    ([pr#23143](https://github.com/ceph/ceph/pull/23143), yuliyang)
-   rgw,tests: qa/rgw: add cls_lock/log/refcount/version tests to verify
    suite ([pr#25381](https://github.com/ceph/ceph/pull/25381), Casey
    Bodley)
-   rgw,tests: qa/rgw: add missing import line
    ([pr#25298](https://github.com/ceph/ceph/pull/25298), Shilpa
    Jagannath)
-   rgw,tests: qa/rgw: add radosgw-admin-rest task to singleton suite
    ([pr#23145](https://github.com/ceph/ceph/pull/23145), Casey Bodley)
-   rgw,tests: qa/rgw: disable testing on ec-cache pools
    ([issue#23965](http://tracker.ceph.com/issues/23965),
    [pr#22126](https://github.com/ceph/ceph/pull/22126), Casey Bodley)
-   rgw,tests: qa/rgw: fix invalid syntax error in radosgw_admin_rest.py
    ([issue#37440](http://tracker.ceph.com/issues/37440),
    [pr#25305](https://github.com/ceph/ceph/pull/25305), Casey Bodley)
-   rgw,tests: qa/rgw: move ragweed upgrade test into upgrade/luminous-x
    ([pr#21707](https://github.com/ceph/ceph/pull/21707), Casey Bodley)
-   rgw,tests: qa/rgw: override valgrind \--max-threads for radosgw
    ([issue#25214](http://tracker.ceph.com/issues/25214),
    [pr#23372](https://github.com/ceph/ceph/pull/23372), Casey Bodley)
-   rgw,tests: qa/rgw: patch keystone requirements.txt
    ([issue#23659](http://tracker.ceph.com/issues/23659),
    [pr#23402](https://github.com/ceph/ceph/pull/23402), Casey Bodley)
-   rgw,tests: qa/rgw: reduce number of multisite log shards
    ([pr#24011](https://github.com/ceph/ceph/pull/24011), Casey Bodley)
-   rgw,tests: qa/rgw: reorganize verify tasks
    ([pr#22249](https://github.com/ceph/ceph/pull/22249), Casey Bodley)
-   rgw,tests: qa/rgw/tempest: either force os_type or select random
    distro ([pr#25996](https://github.com/ceph/ceph/pull/25996), Yehuda
    Sadeh)
-   rgw,tests: test/rgw: fix for bucket checkpoints
    ([issue#24212](http://tracker.ceph.com/issues/24212),
    [pr#22124](https://github.com/ceph/ceph/pull/22124), Casey Bodley)
-   rgw,tests: test/rgw: fix race in test_rgw_reshard_wait
    ([pr#26741](https://github.com/ceph/ceph/pull/26741), Casey Bodley)
-   rgw,tests: test/rgw: silence -Wsign-compare warnings
    ([pr#26364](https://github.com/ceph/ceph/pull/26364), Kefu Chai)
-   rgw: The delete markers generated by object expiration should have
    owner attribute
    ([issue#24568](http://tracker.ceph.com/issues/24568),
    [pr#22619](https://github.com/ceph/ceph/pull/22619), Zhang Shaowen)
-   rgw: the error code returned by rgw is different from amz s3 when
    getting cors ([issue#26964](http://tracker.ceph.com/issues/26964),
    [pr#23646](https://github.com/ceph/ceph/pull/23646), ashitakasam)
-   rgw: thread DoutPrefixProvider into RGW::Auth_S3::authorize
    ([pr#24409](https://github.com/ceph/ceph/pull/24409), Ali Maredia)
-   rgw,tools: ceph-dencoder: add RGWRealm and RGWPeriod support
    ([pr#25057](https://github.com/ceph/ceph/pull/25057), yuliyang)
-   rgw,tools: cls: refcount: add obj_refcount to ceph-dencoder
    ([pr#25441](https://github.com/ceph/ceph/pull/25441), Abhishek
    Lekshmanan)
-   rgw,tools: cls/rgw: ready rgw_usage_log_entry for extraction via
    ceph-dencoder ([issue#34537](http://tracker.ceph.com/issues/34537),
    [pr#22344](https://github.com/ceph/ceph/pull/22344), Vaibhav
    Bhembre)
-   rgw,tools: vstart: make beast as the default frontend for rgw
    ([pr#26566](https://github.com/ceph/ceph/pull/26566), Abhishek
    Lekshmanan)
-   rgw,tools: vstart: rgw: disable the lc debug interval option
    ([pr#25487](https://github.com/ceph/ceph/pull/25487), Abhishek
    Lekshmanan)
-   rgw,tools: vstart: set admin socket for RGW in conf
    ([pr#23983](https://github.com/ceph/ceph/pull/23983), Abhishek
    Lekshmanan)
-   rgw: update cls_rgw.cc and cls_rgw_const.h
    ([pr#24001](https://github.com/ceph/ceph/pull/24001), yuliyang)
-   rgw: update ObjectCacheInfo::time_added on overwrite
    ([issue#24346](http://tracker.ceph.com/issues/24346),
    [pr#22324](https://github.com/ceph/ceph/pull/22324), Casey Bodley)
-   rgw: update \--url in usage and doc
    ([pr#22100](https://github.com/ceph/ceph/pull/22100), Jos Collin)
-   rgw: use chunked encoding to get partial results out faster
    ([issue#12713](http://tracker.ceph.com/issues/12713),
    [pr#23940](https://github.com/ceph/ceph/pull/23940), Robin H.
    Johnson)
-   rgw: use coarse_real_clock for req_state::time
    ([pr#21893](https://github.com/ceph/ceph/pull/21893), Casey Bodley)
-   rgw: use DoutPrefixProvider to add more context to log output
    ([pr#21700](https://github.com/ceph/ceph/pull/21700), Casey Bodley)
-   rgw: use partial-order bucket listing in RGWLC, add configurable
    processing delay
    ([issue#23956](http://tracker.ceph.com/issues/23956),
    [pr#21755](https://github.com/ceph/ceph/pull/21755), Matt Benjamin)
-   rgw: User Policy
    ([pr#21379](https://github.com/ceph/ceph/pull/21379), Pritha
    Srivastava)
-   rgw: user stats account for resharded buckets
    ([pr#24595](https://github.com/ceph/ceph/pull/24595), Casey Bodley)
-   rgw: warn if zone doesn\'t contain all zg\'s placement targets
    ([pr#22452](https://github.com/ceph/ceph/pull/22452), Abhishek
    Lekshmanan)
-   rgw: website routing rules num limit
    ([pr#23429](https://github.com/ceph/ceph/pull/23429), yuliyang)
-   rgw: when exclusive lock fails due existing lock, log add\'l info
    ([issue#38171](http://tracker.ceph.com/issues/38171),
    [pr#26272](https://github.com/ceph/ceph/pull/26272), J. Eric
    Ivancich)
-   rgw: zone service only provides const access to its data
    ([pr#25412](https://github.com/ceph/ceph/pull/25412), Casey Bodley)
-   rocksdb: pick up a fix to be backward compatible
    ([issue#25146](http://tracker.ceph.com/issues/25146),
    [pr#25070](https://github.com/ceph/ceph/pull/25070), Kefu Chai)
-   script: build-integration-branch: avoid Unicode error
    ([issue#24003](http://tracker.ceph.com/issues/24003),
    [pr#21807](https://github.com/ceph/ceph/pull/21807), Nathan Cutler)
-   script/kubejacker: Add openSUSE based images
    ([pr#24055](https://github.com/ceph/ceph/pull/24055), Sebastian
    Wagner)
-   scripts: backport-create-issue: complain about duplicates and
    support mimic ([issue#24071](http://tracker.ceph.com/issues/24071),
    [pr#21634](https://github.com/ceph/ceph/pull/21634), Nathan Cutler)
-   seastar: pickup fix for segfault in POSIX stack
    ([pr#25861](https://github.com/ceph/ceph/pull/25861), Kefu Chai)
-   spec: add missing rbd mirror bootstrap directory
    ([pr#24856](https://github.com/ceph/ceph/pull/24856), Sébastien Han)
-   src: balance std::hex and std::dec manipulators
    ([pr#22287](https://github.com/ceph/ceph/pull/22287), Kefu Chai)
-   src/ceph.in: dev mode: add build path to beginning of PATH, not end
    ([issue#24578](http://tracker.ceph.com/issues/24578),
    [pr#22628](https://github.com/ceph/ceph/pull/22628), Dan Mick)
-   src: Eliminate new warnings in Fedora 28
    ([pr#21898](https://github.com/ceph/ceph/pull/21898), Adam C.
    Emerson)
-   test/crimson: fixes of unittest_seastar_echo
    ([pr#26419](https://github.com/ceph/ceph/pull/26419), Yingxin Cheng,
    Kefu Chai)
-   test/fio: fix compiler failure
    ([pr#22728](https://github.com/ceph/ceph/pull/22728), Jianpeng Ma)
-   test/fio: new option to control file preallocation
    ([pr#23410](https://github.com/ceph/ceph/pull/23410), Igor Fedotov)
-   tests: Add hashinfo testing for dump command of
    ceph-objectstore-tool
    ([issue#38053](http://tracker.ceph.com/issues/38053),
    [pr#26158](https://github.com/ceph/ceph/pull/26158), David Zafman)
-   tests: add ubuntu 18.04 dockerfile
    ([pr#25251](https://github.com/ceph/ceph/pull/25251), Kefu Chai)
-   tests: auth, test: fix building on ARMs after the NSS -\> OpenSSL
    transition ([pr#22129](https://github.com/ceph/ceph/pull/22129),
    Radoslaw Zarzynski)
-   tests: ceph_kvstorebench: include \<errno.h\> not
    asm-generic/errno.h
    ([pr#25256](https://github.com/ceph/ceph/pull/25256), Kefu Chai)
-   tests: ceph-volume: functional tests, add libvirt customization
    ([pr#25895](https://github.com/ceph/ceph/pull/25895), Jan Fajerski)
-   tests: do not check for invalid k/m combinations
    ([issue#16500](http://tracker.ceph.com/issues/16500),
    [pr#25046](https://github.com/ceph/ceph/pull/25046), Kefu Chai)
-   tests: Fixes for standalone tests
    ([pr#22480](https://github.com/ceph/ceph/pull/22480), David Zafman)
-   tests: fix to check server_conn in MessengerTest.NameAddrTest
    ([pr#23931](https://github.com/ceph/ceph/pull/23931), Yingxin)
-   tests: make ceph-admin-commands.sh log what it does
    ([issue#37089](http://tracker.ceph.com/issues/37089),
    [pr#25080](https://github.com/ceph/ceph/pull/25080), Nathan Cutler)
-   tests: make test_ceph_argparse.py pass on py3-only systems
    ([issue#24816](http://tracker.ceph.com/issues/24816),
    [pr#22922](https://github.com/ceph/ceph/pull/22922), Nathan Cutler)
-   tests: mgr/ansible: add install tox==2.9.1
    ([pr#26313](https://github.com/ceph/ceph/pull/26313), Kefu Chai)
-   tests: mgr/dashboard: Added additional breadcrumb and tab tests to
    Cluster menu ([pr#26151](https://github.com/ceph/ceph/pull/26151),
    Nathan Weinberg)
-   tests: mgr/dashboard: Added additional breadcrumb tests to Cluster
    ([pr#25010](https://github.com/ceph/ceph/pull/25010), Nathan
    Weinberg)
-   tests: mgr/dashboard: Added breadcrumb and tab tests to Pools menu
    ([pr#25572](https://github.com/ceph/ceph/pull/25572), Nathan
    Weinberg)
-   tests: mgr/dashboard: Added breadcrumb tests to Block menu items
    ([pr#25143](https://github.com/ceph/ceph/pull/25143), Nathan
    Weinberg)
-   tests: mgr/dashboard: Added breadcrumb tests to Filesystems menu
    ([pr#26592](https://github.com/ceph/ceph/pull/26592), Nathan
    Weinberg)
-   tests: mgr/dashboard: Added NFS Ganesha suite to QA tests
    ([pr#26510](https://github.com/ceph/ceph/pull/26510), Laura Paduano)
-   tests: mgr/dashboard: Added tab tests to Block menu items
    ([pr#26243](https://github.com/ceph/ceph/pull/26243), Nathan
    Weinberg)
-   tests: mgr/dashboard: Add Jest Runner
    ([pr#22031](https://github.com/ceph/ceph/pull/22031), Tiago Melo)
-   tests: mgr/dashboard: Add unit test case for
    controller/erasure_code_profile.py
    ([pr#24789](https://github.com/ceph/ceph/pull/24789), Ranjitha G)
-   tests: mgr/dashboard: Add unit test for frontend api services
    ([pr#22284](https://github.com/ceph/ceph/pull/22284), Tiago Melo)
-   tests: mgr/dashboard: Add unit tests for all frontend pipes
    ([pr#22182](https://github.com/ceph/ceph/pull/22182), Tiago Melo)
-   tests: mgr/dashboard: Add unit test to the frontend services
    ([pr#22244](https://github.com/ceph/ceph/pull/22244), Tiago Melo)
-   tests: mgr/dashboard: Fix a broken ECP controller test
    ([pr#25363](https://github.com/ceph/ceph/pull/25363), Zack Cerza)
-   tests: mgr/dashboard: Fix PYTHONPATH for test runner
    ([pr#25359](https://github.com/ceph/ceph/pull/25359), Zack Cerza)
-   tests: mgr/dashboard: Improve max-line-length tslint rule
    ([pr#22279](https://github.com/ceph/ceph/pull/22279), Tiago Melo)
-   tests: mgr/dashboard: RbdMirroringService test suite fails in dev
    mode ([issue#37841](http://tracker.ceph.com/issues/37841),
    [pr#25865](https://github.com/ceph/ceph/pull/25865), Stephan Müller)
-   tests: mgr/dashboard: Small improvements for running teuthology
    tests ([pr#25121](https://github.com/ceph/ceph/pull/25121), Zack
    Cerza)
-   tests: mgr/dashboard: updated API test
    ([pr#25653](https://github.com/ceph/ceph/pull/25653), Alfonso
    Martínez)
-   tests: mgr/dashboard: updated API test to reflect changes in
    ModuleInfo ([pr#25761](https://github.com/ceph/ceph/pull/25761),
    Kefu Chai)
-   tests: mgr/test_orchestrator: correct ceph-volume path
    ([issue#37773](http://tracker.ceph.com/issues/37773),
    [pr#25839](https://github.com/ceph/ceph/pull/25839), Kefu Chai)
-   tests: object errors found in be_select_auth_object() aren\'t logged
    the same ([issue#25108](http://tracker.ceph.com/issues/25108),
    [pr#23376](https://github.com/ceph/ceph/pull/23376), David Zafman)
-   tests: osd/OSDMap: set pg_autoscale_mode with setting from conf
    ([pr#25746](https://github.com/ceph/ceph/pull/25746), Kefu Chai)
-   tests: os/tests: fix garbageCollection test case from store_test
    suite ([pr#23752](https://github.com/ceph/ceph/pull/23752), Igor
    Fedotov)
-   tests: os/tests: silence -Wsign-compare warning
    ([pr#25072](https://github.com/ceph/ceph/pull/25072), Kefu Chai)
-   tests: qa: add librados3 to exclude_packages for ugprade tests
    ([pr#25037](https://github.com/ceph/ceph/pull/25037), Kefu Chai)
-   tests: qa: add test that builds example librados programs
    ([issue#35989](http://tracker.ceph.com/issues/35989),
    [issue#15100](http://tracker.ceph.com/issues/15100),
    [pr#23131](https://github.com/ceph/ceph/pull/23131), Nathan Cutler)
-   tests: qa/ceph-ansible: Set ceph_stable_release to mimic
    ([issue#38231](http://tracker.ceph.com/issues/38231),
    [pr#26328](https://github.com/ceph/ceph/pull/26328), Brad Hubbard)
-   tests: qa/distros: add openSUSE Leap 42.3 and 15.0
    ([pr#24380](https://github.com/ceph/ceph/pull/24380), Nathan Cutler)
-   tests: qa: Don\'t use sudo when moving logs
    ([pr#22763](https://github.com/ceph/ceph/pull/22763), David Zafman)
-   tests: qa: downgrade librados2,librbd1 for thrash-old-clients tests
    ([issue#37618](http://tracker.ceph.com/issues/37618),
    [pr#25463](https://github.com/ceph/ceph/pull/25463), Kefu Chai)
-   tests: qa: fix manager module paths
    ([pr#23637](https://github.com/ceph/ceph/pull/23637), Noah Watkins,
    David Zafman)
-   tests/qa - fix mimic subset for nightlies
    ([pr#21931](https://github.com/ceph/ceph/pull/21931), Yuri
    Weinstein)
-   tests: qa: fix test on \"ceph fs set cephfs allow_new_snaps\"
    ([pr#21829](https://github.com/ceph/ceph/pull/21829), Kefu Chai)
-   tests: qa: fix upgrade tests and test_envlibrados_for_rocksdb.sh
    ([pr#25106](https://github.com/ceph/ceph/pull/25106), Kefu Chai)
-   tests: qa: For teuthology copy logs to teuthology expected location
    ([pr#22702](https://github.com/ceph/ceph/pull/22702), David Zafman)
-   tests: qa/mgr/dashboard: Fix type annotation error
    ([pr#25235](https://github.com/ceph/ceph/pull/25235), Sebastian
    Wagner)
-   tests: qa/mon: fix cluster support for monmap bootstrap
    ([issue#38115](http://tracker.ceph.com/issues/38115),
    [pr#26205](https://github.com/ceph/ceph/pull/26205), Casey Bodley)
-   tests: qa/standalone: Minor test improvements
    ([issue#35912](http://tracker.ceph.com/issues/35912),
    [pr#24018](https://github.com/ceph/ceph/pull/24018), David Zafman)
-   tests: qa/standalone/scrub: When possible show side-by-side diff in
    addition to regular diff
    ([pr#22727](https://github.com/ceph/ceph/pull/22727), David Zafman)
-   tests: qa/standalone: Standalone test corrections
    ([issue#35982](http://tracker.ceph.com/issues/35982),
    [pr#24088](https://github.com/ceph/ceph/pull/24088), David Zafman)
-   tests: qa/suites/rados/upgrade: remove stray link
    ([pr#22460](https://github.com/ceph/ceph/pull/22460), Sage Weil)
-   tests: qa/suites/rados/upgrade: set require-osd-release to nautilus
    ([issue#37432](http://tracker.ceph.com/issues/37432),
    [pr#25314](https://github.com/ceph/ceph/pull/25314), Kefu Chai)
-   tests: qa/suites/rados/verify: remove random-distro\$
    ([pr#22057](https://github.com/ceph/ceph/pull/22057), Kefu Chai)
-   tests: qa/suites/upgrade/mimic-x: fix rhel runs
    ([pr#25781](https://github.com/ceph/ceph/pull/25781), Neha Ojha)
-   tests: qa/tasks/mgr: fix test_pool.py
    ([issue#24077](http://tracker.ceph.com/issues/24077),
    [pr#21943](https://github.com/ceph/ceph/pull/21943), Kefu Chai)
-   tests: qa/tasks/thrashosds-health.yaml: whitelist slow requests
    ([issue#25104](http://tracker.ceph.com/issues/25104),
    [pr#23237](https://github.com/ceph/ceph/pull/23237), Neha Ojha)
-   tests: qa/tasks: update mirror link for maven
    ([pr#23944](https://github.com/ceph/ceph/pull/23944), Vasu Kulkarni)
-   tests: qa/tests: added filters to support distro tests for
    client-upgrade tests
    ([pr#22096](https://github.com/ceph/ceph/pull/22096), Yuri
    Weinstein)
-   tests: qa/tests - added mimic-p2p suite
    ([pr#22726](https://github.com/ceph/ceph/pull/22726), Yuri
    Weinstein)
-   tests: qa/tests: Added mimic runs, removed large suites (rados, rbd,
    etc) ru... ([pr#21827](https://github.com/ceph/ceph/pull/21827),
    Yuri Weinstein)
-   tests: qa/tests: added \"-n 7\" to make sure mimic-x runs on built
    master branch ([pr#25038](https://github.com/ceph/ceph/pull/25038),
    Yuri Weinstein)
-   tests: qa/tests: added rhel 7.6
    ([pr#25919](https://github.com/ceph/ceph/pull/25919), Yuri
    Weinstein)
-   tests: qa/tests: fix volume size when running in ovh
    ([pr#21961](https://github.com/ceph/ceph/pull/21961), Vasu Kulkarni)
-   tests: qa/tests: Move ceph-ansible tests to ansible version 2.7
    ([issue#37973](http://tracker.ceph.com/issues/37973),
    [pr#26068](https://github.com/ceph/ceph/pull/26068), Brad Hubbard)
-   tests: qa/tests: remove ceph-disk tests from ceph-deploy and default
    all tests to use ceph-volume
    ([pr#22921](https://github.com/ceph/ceph/pull/22921), Vasu Kulkarni)
-   tests: qa/upgrade: cleanup for nautilus
    ([pr#23305](https://github.com/ceph/ceph/pull/23305), Nathan Cutler)
-   tests: qa: use \$TESTDIR for testing mkfs
    ([pr#22246](https://github.com/ceph/ceph/pull/22246), Kefu Chai)
-   tests: qa: wait longer for osd to flush pg stats
    ([issue#24321](http://tracker.ceph.com/issues/24321),
    [pr#22275](https://github.com/ceph/ceph/pull/22275), Kefu Chai)
-   tests: qa/workunits/ceph-disk: \--no-mon-config
    ([pr#21942](https://github.com/ceph/ceph/pull/21942), Kefu Chai)
-   tests: qa/workunits/mon/test_mon_config_key.py: bump up the size
    limit ([issue#36260](http://tracker.ceph.com/issues/36260),
    [pr#24340](https://github.com/ceph/ceph/pull/24340), Kefu Chai)
-   tests: qa/workunits/rados/test_envlibrados_for_rocksdb: install g++
    not g++-4.7 ([pr#22103](https://github.com/ceph/ceph/pull/22103),
    Kefu Chai)
-   tests: qa/workunits/rados/test_librados_build.sh: grab files from
    explicit git branch
    ([pr#25268](https://github.com/ceph/ceph/pull/25268), Nathan Cutler)
-   tests: run-make-check: increase fs.aio-max-nr to 1048576
    ([pr#23689](https://github.com/ceph/ceph/pull/23689), Kefu Chai)
-   tests: test,common: silence GCC warnings
    ([pr#23692](https://github.com/ceph/ceph/pull/23692), Kefu Chai)
-   tests: test/crimson: add dummy_auth to test_async_echo
    ([pr#26783](https://github.com/ceph/ceph/pull/26783), Yingxin Cheng)
-   tests: test/crimson: fix build failure of test_alien_echo
    ([pr#26308](https://github.com/ceph/ceph/pull/26308), chunmei Liu)
-   tests: test/crimson: fix FTBFS of unittest_seastar_perfcounters on
    arm64 ([pr#25647](https://github.com/ceph/ceph/pull/25647), Kefu
    Chai)
-   tests: test/crimson: split async-msgr out of alien_echo
    ([pr#26620](https://github.com/ceph/ceph/pull/26620), Yingxin Cheng)
-   tests: test/dashboard: fix segfault when importing dm.xmlsec.binding
    ([issue#37081](http://tracker.ceph.com/issues/37081),
    [pr#25139](https://github.com/ceph/ceph/pull/25139), Kefu Chai)
-   tests: test: Disable duplicate request command test during scrub
    testing ([pr#25675](https://github.com/ceph/ceph/pull/25675), David
    Zafman)
-   tests: test/docker-test-helper.sh: move \"cp .git/HEAD\" out of loop
    ([pr#22978](https://github.com/ceph/ceph/pull/22978), Kefu Chai)
-   tests: test/encoding: Fix typo in encoding/types.h file
    ([pr#22332](https://github.com/ceph/ceph/pull/22332), TommyLike)
-   tests: test/fio: pass config params to object store in a different
    manner ([pr#23267](https://github.com/ceph/ceph/pull/23267), Igor
    Fedotov)
-   tests: test: fix compile error in test/crimson/test_config.cc
    ([pr#23724](https://github.com/ceph/ceph/pull/23724), Yingxin)
-   tests: test: fix libc++ crash in Log.GarbleRecovery
    ([pr#25135](https://github.com/ceph/ceph/pull/25135), Casey Bodley)
-   tests: test/librados: fix LibRadosList.ListObjectsNS
    ([pr#22771](https://github.com/ceph/ceph/pull/22771), Kefu Chai)
-   tests: test: Limit loops waiting for force-backfill/force-recovery
    to happen ([issue#38309](http://tracker.ceph.com/issues/38309),
    [pr#26416](https://github.com/ceph/ceph/pull/26416), David Zafman)
-   tests: test: Need to escape parens in log-whitelist for grep
    ([pr#22074](https://github.com/ceph/ceph/pull/22074), David Zafman)
-   tests: test: osd-backfill-stats.sh Fix check of multi backfill OSDs,
    skip re... ([pr#26330](https://github.com/ceph/ceph/pull/26330),
    David Zafman)
-   tests: test/pybind/test_rados.py: collect output in stdout for
    \"bench\" cmd ([pr#21957](https://github.com/ceph/ceph/pull/21957),
    Kefu Chai)
-   tests: test: run-standalone.sh: point LD_LIBRARY_PATH to \$(pwd)/lib
    ([issue#38262](http://tracker.ceph.com/issues/38262),
    [pr#26371](https://github.com/ceph/ceph/pull/26371), David Zafman)
-   tests: tests/qa: trying \$ distro mix
    ([pr#21895](https://github.com/ceph/ceph/pull/21895), Yuri
    Weinstein)
-   tests: test: Start using GNU awk and fix archiving directory
    ([pr#23955](https://github.com/ceph/ceph/pull/23955), Willem Jan
    Withagen)
-   tests: test/strtol: add test case for parsing hex numbers
    ([pr#21582](https://github.com/ceph/ceph/pull/21582), Jan Fajerski)
-   tests: test: suppress core dumping in there tests as well
    ([pr#25311](https://github.com/ceph/ceph/pull/25311), Willem Jan
    Withagen)
-   tests: test: switch to GNU sed on FreeBSD
    ([pr#26318](https://github.com/ceph/ceph/pull/26318), Willem Jan
    Withagen)
-   tests: test: test_get_timeout_delays() fix
    ([pr#22837](https://github.com/ceph/ceph/pull/22837), David Zafman)
-   tests: test: Use a file that should be on all OSes
    ([pr#22428](https://github.com/ceph/ceph/pull/22428), David Zafman)
-   tests: test: Use a grep pattern that works across releases
    ([issue#35845](http://tracker.ceph.com/issues/35845),
    [pr#24013](https://github.com/ceph/ceph/pull/24013), David Zafman)
-   tests: test: Use pids instead of jobspecs which were wrong
    ([issue#27056](http://tracker.ceph.com/issues/27056),
    [pr#23695](https://github.com/ceph/ceph/pull/23695), David Zafman)
-   tests: test: wait_for_pg_stats() should do another check after last
    13 secon... ([pr#22198](https://github.com/ceph/ceph/pull/22198),
    David Zafman)
-   tests: test: Whitelist corrections
    ([pr#22164](https://github.com/ceph/ceph/pull/22164), David Zafman)
-   tests: test: write log file to current directory
    ([issue#36737](http://tracker.ceph.com/issues/36737),
    [pr#25704](https://github.com/ceph/ceph/pull/25704), Kefu Chai)
-   tests,tools: ceph-objectstore-tool: Dump hashinfo
    ([issue#37597](http://tracker.ceph.com/issues/37597),
    [pr#25483](https://github.com/ceph/ceph/pull/25483), David Zafman)
-   tests: update Dockerfile to support fc-29
    ([pr#26311](https://github.com/ceph/ceph/pull/26311), Kefu Chai)
-   tests: upgrade/luminous-x: fix order of final-workload directory
    ([pr#23162](https://github.com/ceph/ceph/pull/23162), Nathan Cutler)
-   tests: upgrade/luminous-x: whitelist REQUEST_SLOW for
    rados_mon_thrash
    ([issue#25051](http://tracker.ceph.com/issues/25051),
    [pr#23160](https://github.com/ceph/ceph/pull/23160), Nathan Cutler)
-   tests: Wip 38027 38195: osd/osd-backfill-space.sh fails
    ([issue#38027](http://tracker.ceph.com/issues/38027),
    [issue#38195](http://tracker.ceph.com/issues/38195),
    [pr#26290](https://github.com/ceph/ceph/pull/26290), David Zafman)
-   tools: Add clear-data-digest command to objectstore tool
    ([pr#25403](https://github.com/ceph/ceph/pull/25403), Li Yichao)
-   tools: add offset-align option to \"rados\" load-gen
    ([pr#20683](https://github.com/ceph/ceph/pull/20683), Zengran Zhang)
-   tools: backport-create-issue: rate-limit to avoid seeming like a
    spammer ([pr#24243](https://github.com/ceph/ceph/pull/24243), Nathan
    Cutler)
-   tools: ceph-menv: mrun shell environment
    ([pr#22132](https://github.com/ceph/ceph/pull/22132), Yehuda Sadeh)
-   tools: ceph-objectstore-tool: Allow target level as first positional
    argument ([issue#35846](http://tracker.ceph.com/issues/35846),
    [pr#23989](https://github.com/ceph/ceph/pull/23989), David Zafman)
-   tools: correct the description of Allowed options in osdomap tool
    ([pr#23488](https://github.com/ceph/ceph/pull/23488), xiaomanh)
-   tools, mgr: silence clang warnings
    ([pr#23430](https://github.com/ceph/ceph/pull/23430), Kefu Chai)
-   tools: mstop.sh allow kill -9 after failing to kill procs
    ([pr#26680](https://github.com/ceph/ceph/pull/26680), Yuval
    Lifshitz)
-   tools/rados: fix memory leak in error path
    ([pr#25410](https://github.com/ceph/ceph/pull/25410), Li Wang)
-   tools: script/kubejacker: include cls libs
    ([pr#23569](https://github.com/ceph/ceph/pull/23569), John Spray)
-   tools: script: new ceph-backport.sh script
    ([pr#22875](https://github.com/ceph/ceph/pull/22875), Nathan Cutler)
-   tools: tools: ceph-authtool: report correct number of caps when
    creating keyring
    ([pr#23304](https://github.com/ceph/ceph/pull/23304), Nathan Cutler)
-   tools: tools/ceph_kvstore_tool: do not open rocksdb when repairing
    it ([pr#25108](https://github.com/ceph/ceph/pull/25108), Kefu Chai)
-   tools: tools/ceph_kvstore_tool: extract StoreTool into
    kvstore_tool.cc
    ([pr#26041](https://github.com/ceph/ceph/pull/26041), Kefu Chai)
-   tools: tools/ceph_kvstore_tool: Move summary output to print_summary
    ([pr#26666](https://github.com/ceph/ceph/pull/26666), Brad Hubbard)
-   tools: tools/rados: allow list objects in a specific pg in a pool
    ([pr#19041](https://github.com/ceph/ceph/pull/19041), Li Wang)
-   tools: tools/rados: always call rados.shutdown() before exit()
    ([issue#36732](http://tracker.ceph.com/issues/36732),
    [pr#24990](https://github.com/ceph/ceph/pull/24990), Li Wang)
-   tools: tools/rados: correct the read offset of bench
    ([pr#23667](https://github.com/ceph/ceph/pull/23667), Xiaofei Cui)
-   tools: tools/rados: fix the unit of target-throughput
    ([pr#23683](https://github.com/ceph/ceph/pull/23683), Xiaofei Cui)
-   vstart: disable dashboard when rbd not built
    ([pr#23336](https://github.com/ceph/ceph/pull/23336), Noah Watkins)
-   vstart.sh: fix params generation for monmaptool
    ([issue#38174](http://tracker.ceph.com/issues/38174),
    [pr#26273](https://github.com/ceph/ceph/pull/26273), Yehuda Sadeh)

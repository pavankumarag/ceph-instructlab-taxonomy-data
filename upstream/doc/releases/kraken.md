# Kraken

Kraken is the 11th stable release of Ceph. It is named after the
mythical kraken, a legendary sea monster in Scandinavian folklore with
cephalopod-like appearance.

## v11.2.1 Kraken

This is the first bugfix release for Kraken, and probably the last
release of the Kraken series (Kraken will be declared \"End Of Life\"
(EOL) when Luminous is declared stable). It contains a large number of
bugfixes across all Ceph components.

We recommend that all v11.2.x users upgrade.

For more detailed information, see
`the complete changelog <../changelog/v11.2.1.txt>`{.interpreted-text
role="download"}.

### Notable Changes

-   In previous versions, if a client sent an op to the wrong OSD, the
    OSD would reply with ENXIO. The rationale here is that the client or
    OSD is clearly buggy and we want to surface the error as clearly as
    possible. We now only send the ENXIO reply if the
    osd_enxio_on_misdirected_op option is enabled (it\'s off by
    default). This means that a VM using librbd that previously would
    have gotten an EIO and gone read-only will now see a blocked/hung IO
    instead.

-   There was a bug introduced in Jewel (#19119) that broke the mapping
    behavior when an \"out\" OSD that still existed in the CRUSH map was
    removed with \'osd rm\'. This could result in \'misdirected op\' and
    other errors. The bug is now fixed, but the fix itself introduces
    the same risk because the behavior may vary between clients and
    OSDs. To avoid problems, please ensure that all OSDs are removed
    from the CRUSH map before deleting them. That is, be sure to do:

        ceph osd crush rm osd.123

    before:

        ceph osd rm osd.123

-   This release greatly improves control and throttling of the snap
    trimmer. It introduces the \"osd max trimming pgs\" option
    (defaulting to 2), which limits how many PGs on an OSD can be
    trimming snapshots at a time. And it restores the safe use of the
    \"osd snap trim sleep\" option, which defaults to 0 but otherwise
    adds the given number of seconds in delay between every dispatch of
    trim operations to the underlying system.

### Other Notable Changes

-   build/ops: ceph-base missing dependency for psmisc in Ubuntu Xenial
    ([issue#19129](http://tracker.ceph.com/issues/19129),
    [issue#19564](http://tracker.ceph.com/issues/19564),
    [pr#14425](https://github.com/ceph/ceph/pull/14425), Nathan Cutler)
-   build/ops: logrotate is missing from debian package (kraken, master)
    ([issue#19670](http://tracker.ceph.com/issues/19670),
    [issue#19390](http://tracker.ceph.com/issues/19390),
    [pr#14734](https://github.com/ceph/ceph/pull/14734), Kefu Chai)
-   build/ops: selinux: Do parallel relabel on package install
    ([issue#20077](http://tracker.ceph.com/issues/20077),
    [issue#20184](http://tracker.ceph.com/issues/20184),
    [issue#20191](http://tracker.ceph.com/issues/20191),
    [issue#20193](http://tracker.ceph.com/issues/20193),
    [pr#15509](https://github.com/ceph/ceph/pull/15509), Boris Ranto)
-   build/ops: spec file mentions non-existent ceph-create-keys systemd
    unit file, causing ceph-mon units to not be enabled via preset
    ([issue#19460](http://tracker.ceph.com/issues/19460),
    [pr#14315](https://github.com/ceph/ceph/pull/14315), Sébastien Han)
-   build/ops: systemd restarts Ceph Mon to quickly after failing to
    start ([issue#18635](http://tracker.ceph.com/issues/18635),
    [issue#18721](http://tracker.ceph.com/issues/18721),
    [pr#13185](https://github.com/ceph/ceph/pull/13185), Wido den
    Hollander)
-   build/ops: systemd: Start OSDs after MONs
    ([issue#18907](http://tracker.ceph.com/issues/18907),
    [issue#18516](http://tracker.ceph.com/issues/18516),
    [pr#13494](https://github.com/ceph/ceph/pull/13494), Boris Ranto)
-   ceph-disk: Add fix subcommand kraken back-port
    ([issue#19544](http://tracker.ceph.com/issues/19544),
    [pr#14345](https://github.com/ceph/ceph/pull/14345), Boris Ranto)
-   ceph-disk: does not support cluster names different than \'ceph\'
    ([issue#18973](http://tracker.ceph.com/issues/18973),
    [issue#17821](http://tracker.ceph.com/issues/17821),
    [pr#13497](https://github.com/ceph/ceph/pull/13497), Loic Dachary)
-   ceph-disk: enable directory backed OSD at boot time
    ([issue#19628](http://tracker.ceph.com/issues/19628),
    [issue#19647](http://tracker.ceph.com/issues/19647),
    [pr#14604](https://github.com/ceph/ceph/pull/14604), Loic Dachary)
-   ceph-disk: error on \_bytes2str
    ([issue#18431](http://tracker.ceph.com/issues/18431),
    [issue#18371](http://tracker.ceph.com/issues/18371),
    [pr#13501](https://github.com/ceph/ceph/pull/13501), Kefu Chai)
-   ceph-disk: fails if OSD udev rule triggers prior to mount of /var
    ([issue#20150](http://tracker.ceph.com/issues/20150),
    [issue#19941](http://tracker.ceph.com/issues/19941),
    [pr#16092](https://github.com/ceph/ceph/pull/16092), Loic Dachary)
-   ceph-disk: Fix getting wrong group name when \--setgroup in
    bluestore ([issue#18956](http://tracker.ceph.com/issues/18956),
    [pr#13488](https://github.com/ceph/ceph/pull/13488), craigchi)
-   ceph-disk list reports mount error for OSD having mount options with
    SELinux context
    ([issue#19537](http://tracker.ceph.com/issues/19537),
    [issue#17331](http://tracker.ceph.com/issues/17331),
    [pr#14403](https://github.com/ceph/ceph/pull/14403), Brad Hubbard)
-   ceph-disk prepare get wrong group name in bluestore
    ([issue#18997](http://tracker.ceph.com/issues/18997),
    [pr#13543](https://github.com/ceph/ceph/pull/13543), craigchi)
-   ceph-disk: Racing between partition creation & device node creation
    ([issue#20034](http://tracker.ceph.com/issues/20034),
    [pr#16138](https://github.com/ceph/ceph/pull/16138), Erwan Velu)
-   ceph-disk: separate ceph-osd \--check-needs-\* logs
    ([issue#20010](http://tracker.ceph.com/issues/20010),
    [issue#19888](http://tracker.ceph.com/issues/19888),
    [pr#16135](https://github.com/ceph/ceph/pull/16135), Loic Dachary)
-   cephfs: buffer overflow in test LibCephFS.DirLs
    ([issue#18941](http://tracker.ceph.com/issues/18941),
    [issue#19045](http://tracker.ceph.com/issues/19045),
    [pr#14571](https://github.com/ceph/ceph/pull/14571), \"Yan, Zheng\")
-   cephfs: ceph-fuse crash during snapshot tests
    ([issue#18552](http://tracker.ceph.com/issues/18552),
    [issue#18460](http://tracker.ceph.com/issues/18460),
    [pr#14563](https://github.com/ceph/ceph/pull/14563), Yan, Zheng)
-   cephfs: ceph-fuse does not recover after lost connection to MDS
    ([issue#19678](http://tracker.ceph.com/issues/19678),
    [issue#18757](http://tracker.ceph.com/issues/18757),
    [pr#16105](https://github.com/ceph/ceph/pull/16105), Henrik Korkuc)
-   cephfs: client: fix the cross-quota rename boundary check conditions
    ([issue#18700](http://tracker.ceph.com/issues/18700),
    [pr#14567](https://github.com/ceph/ceph/pull/14567), Greg Farnum)
-   cephfs: Deadlock on two ceph-fuse clients accessing the same file
    ([issue#20028](http://tracker.ceph.com/issues/20028),
    [issue#19635](http://tracker.ceph.com/issues/19635),
    [pr#16191](https://github.com/ceph/ceph/pull/16191), \"Yan, Zheng\")
-   cephfs: fragment space check can cause replayed request fail
    ([issue#18660](http://tracker.ceph.com/issues/18660),
    [issue#18706](http://tracker.ceph.com/issues/18706),
    [pr#14568](https://github.com/ceph/ceph/pull/14568), \"Yan, Zheng\")
-   cephfs: MDS crashes on missing metadata object
    ([issue#18179](http://tracker.ceph.com/issues/18179),
    [issue#18566](http://tracker.ceph.com/issues/18566),
    [pr#14565](https://github.com/ceph/ceph/pull/14565), Yan, Zheng)
-   cephfs: MDS heartbeat timeout during rejoin, when working with large
    amount of caps/inodes
    ([issue#19118](http://tracker.ceph.com/issues/19118),
    [issue#19335](http://tracker.ceph.com/issues/19335),
    [pr#14572](https://github.com/ceph/ceph/pull/14572), John Spray)
-   cephfs: mds is crushed, after I set about 400 64KB xattr kv pairs to
    a file ([issue#19674](http://tracker.ceph.com/issues/19674),
    [issue#19033](http://tracker.ceph.com/issues/19033),
    [pr#16103](https://github.com/ceph/ceph/pull/16103), Yang Honggang)
-   cephfs: MDS server crashes due to inconsistent metadata
    ([issue#19406](http://tracker.ceph.com/issues/19406),
    [issue#19620](http://tracker.ceph.com/issues/19620),
    [pr#14574](https://github.com/ceph/ceph/pull/14574), John Spray)
-   cephfs: mds/StrayManager: avoid reusing deleted inode in
    StrayManager::\_purge_stray_logged
    ([issue#18950](http://tracker.ceph.com/issues/18950),
    [pr#14570](https://github.com/ceph/ceph/pull/14570), Zhi Zhang)
-   cephfs: mount point break off problem after mds switch
    ([issue#19667](http://tracker.ceph.com/issues/19667),
    [issue#19437](http://tracker.ceph.com/issues/19437),
    [pr#16100](https://github.com/ceph/ceph/pull/16100), Guan yunfei,
    Sage Weil)
-   cephfs: non-local quota changes not visible until some IO is done
    ([issue#17939](http://tracker.ceph.com/issues/17939),
    [issue#19763](http://tracker.ceph.com/issues/19763),
    [pr#16108](https://github.com/ceph/ceph/pull/16108), John Spray)
-   cephfs: No output for ceph mds rmfailed 0 \--yes-i-really-mean-it
    command ([issue#19483](http://tracker.ceph.com/issues/19483),
    [issue#16709](http://tracker.ceph.com/issues/16709),
    [pr#14573](https://github.com/ceph/ceph/pull/14573), John Spray)
-   cephfs: normalize file open flags internally used by cephfs
    ([issue#19845](http://tracker.ceph.com/issues/19845),
    [pr#14998](https://github.com/ceph/ceph/pull/14998), Jan Fajerski)
-   cephfs: segfault in handle_client_caps
    ([issue#18306](http://tracker.ceph.com/issues/18306),
    [issue#18616](http://tracker.ceph.com/issues/18616),
    [pr#14566](https://github.com/ceph/ceph/pull/14566), Yan, Zheng)
-   cephfs: speed up readdir by skipping unwanted dn
    ([issue#18531](http://tracker.ceph.com/issues/18531),
    [pr#13028](https://github.com/ceph/ceph/pull/13028), Xiaoxi Chen)
-   cephfs: src/test/pybind/test_cephfs.py fails
    ([issue#20500](http://tracker.ceph.com/issues/20500),
    [issue#19890](http://tracker.ceph.com/issues/19890),
    [pr#16114](https://github.com/ceph/ceph/pull/16114), \"Yan, Zheng\")
-   cephfs: test_client_recovery.TestClientRecovery fails
    ([issue#18562](http://tracker.ceph.com/issues/18562),
    [issue#18396](http://tracker.ceph.com/issues/18396),
    [pr#14564](https://github.com/ceph/ceph/pull/14564), Yan, Zheng)
-   cephfs test failures (ceph.com/qa is broken, should be
    download.ceph.com/qa)
    ([issue#18574](http://tracker.ceph.com/issues/18574),
    [issue#18604](http://tracker.ceph.com/issues/18604),
    [pr#13024](https://github.com/ceph/ceph/pull/13024), John Spray)
-   cephfs: Test failure: test_data_isolated
    (tasks.cephfs.test_volume_client.TestVolumeClient)
    ([issue#18914](http://tracker.ceph.com/issues/18914),
    [issue#19676](http://tracker.ceph.com/issues/19676),
    [pr#16104](https://github.com/ceph/ceph/pull/16104), \"Yan, Zheng\")
-   cephfs: test_open_inode fails
    ([issue#18899](http://tracker.ceph.com/issues/18899),
    [issue#18661](http://tracker.ceph.com/issues/18661),
    [pr#14569](https://github.com/ceph/ceph/pull/14569), John Spray)
-   client: populate metadata during mount
    ([issue#18361](http://tracker.ceph.com/issues/18361),
    [issue#18540](http://tracker.ceph.com/issues/18540),
    [pr#12951](https://github.com/ceph/ceph/pull/12951), John Spray)
-   client: segfault on ceph_rmdir path /
    ([issue#18612](http://tracker.ceph.com/issues/18612),
    [issue#9935](http://tracker.ceph.com/issues/9935),
    [pr#13030](https://github.com/ceph/ceph/pull/13030), Michal
    Jarzabek)
-   cls_rbd: default initialize snapshot namespace for legacy clients
    ([issue#19413](http://tracker.ceph.com/issues/19413),
    [issue#19833](http://tracker.ceph.com/issues/19833),
    [pr#14934](https://github.com/ceph/ceph/pull/14934), Jason Dillaman)
-   cls/rgw: list_plain_entries() stops before bi_log entries
    ([issue#19876](http://tracker.ceph.com/issues/19876),
    [issue#20015](http://tracker.ceph.com/issues/20015),
    [pr#15384](https://github.com/ceph/ceph/pull/15384), Casey Bodley)
-   common: monitor creation with IPv6 public network segfaults
    ([issue#19465](http://tracker.ceph.com/issues/19465),
    [issue#19371](http://tracker.ceph.com/issues/19371),
    [pr#14323](https://github.com/ceph/ceph/pull/14323), Fabian
    Grünbichler)
-   common: possible lockdep false alarm for ThreadPool lock
    ([issue#18819](http://tracker.ceph.com/issues/18819),
    [issue#18894](http://tracker.ceph.com/issues/18894),
    [pr#13487](https://github.com/ceph/ceph/pull/13487), Mykola Golub)
-   core: api_misc: \[ FAILED \]
    LibRadosMiscConnectFailure.ConnectFailure
    ([issue#19561](http://tracker.ceph.com/issues/19561),
    [issue#15368](http://tracker.ceph.com/issues/15368),
    [pr#14733](https://github.com/ceph/ceph/pull/14733), Sage Weil)
-   core: bluestore bdev: flush no-op optimization is racy
    ([issue#20495](http://tracker.ceph.com/issues/20495),
    [issue#19326](http://tracker.ceph.com/issues/19326),
    [issue#19327](http://tracker.ceph.com/issues/19327),
    [issue#19250](http://tracker.ceph.com/issues/19250),
    [issue#19251](http://tracker.ceph.com/issues/19251),
    [pr#14736](https://github.com/ceph/ceph/pull/14736), Sage Weil)
-   core: improve control and throttling of the snap trimmer
    ([issue#19329](http://tracker.ceph.com/issues/19329),
    [issue#19931](http://tracker.ceph.com/issues/19931),
    [pr#14597](https://github.com/ceph/ceph/pull/14597), Samuel Just,
    Greg Farnum)
-   core: two instances of omap_digest mismatch
    ([issue#19391](http://tracker.ceph.com/issues/19391),
    [pr#14200](https://github.com/ceph/ceph/pull/14200), Samuel Just,
    David Zafman)
-   doc: PendingReleaseNotes: warning about \'osd rm \...\' and #13733
    ([issue#19119](http://tracker.ceph.com/issues/19119),
    [pr#14506](https://github.com/ceph/ceph/pull/14506), Sage Weil)
-   doc: Python Swift client commands in Quick Developer Guide don\'t
    match configuration in vstart.sh
    ([issue#17746](http://tracker.ceph.com/issues/17746),
    [issue#18571](http://tracker.ceph.com/issues/18571),
    [pr#13044](https://github.com/ceph/ceph/pull/13044), Ronak Jain)
-   doc: rgw: admin ops: fix the quota section
    ([issue#19397](http://tracker.ceph.com/issues/19397),
    [issue#19462](http://tracker.ceph.com/issues/19462),
    [pr#14521](https://github.com/ceph/ceph/pull/14521), Chu, Hua-Rong)
-   fix: rgw crashed caused by shard id out of range when listing data
    log ([issue#20156](http://tracker.ceph.com/issues/20156),
    [issue#19732](http://tracker.ceph.com/issues/19732),
    [pr#16173](https://github.com/ceph/ceph/pull/16173), redickwang)
-   fuse: TestVolumeClient.test_evict_client failure creating pidfile
    ([issue#18439](http://tracker.ceph.com/issues/18439),
    [issue#18309](http://tracker.ceph.com/issues/18309),
    [pr#12813](https://github.com/ceph/ceph/pull/12813), Nathan Cutler)
-   librbd: allow to open an image without opening parent image
    ([issue#18609](http://tracker.ceph.com/issues/18609),
    [issue#18325](http://tracker.ceph.com/issues/18325),
    [pr#13132](https://github.com/ceph/ceph/pull/13132), Ricardo Dias)
-   librbd: corrected resize RPC message backwards compatibility
    ([issue#19636](http://tracker.ceph.com/issues/19636),
    [issue#19659](http://tracker.ceph.com/issues/19659),
    [pr#14620](https://github.com/ceph/ceph/pull/14620), Jason Dillaman)
-   librbd: Incomplete declaration for ContextWQ in librbd/Journal.h
    ([issue#18862](http://tracker.ceph.com/issues/18862),
    [issue#18892](http://tracker.ceph.com/issues/18892),
    [pr#14153](https://github.com/ceph/ceph/pull/14153), Boris Ranto)
-   librbd: is_exclusive_lock_owner API should ping OSD
    ([issue#19467](http://tracker.ceph.com/issues/19467),
    [issue#19287](http://tracker.ceph.com/issues/19287),
    [pr#14480](https://github.com/ceph/ceph/pull/14480), Jason Dillaman)
-   librbd: possible race in ExclusiveLock handle_peer_notification
    ([issue#19368](http://tracker.ceph.com/issues/19368),
    [pr#14163](https://github.com/ceph/ceph/pull/14163), Mykola Golub)
-   librbd: prevent self-blacklisting during break lock
    ([issue#18703](http://tracker.ceph.com/issues/18703),
    [issue#18666](http://tracker.ceph.com/issues/18666),
    [pr#13201](https://github.com/ceph/ceph/pull/13201), Jason Dillaman)
-   make check fails with Error EIO: load
    dlopen(build/lib/libec_FAKE.so): build/lib/libec_FAKE.so: cannot
    open shared object file: No such file or directory
    ([issue#20487](http://tracker.ceph.com/issues/20487),
    [issue#20345](http://tracker.ceph.com/issues/20345),
    [issue#18876](http://tracker.ceph.com/issues/18876),
    [pr#16069](https://github.com/ceph/ceph/pull/16069), Kefu Chai, Kyr
    Shatskyy)
-   mds: assert fail when shutting down
    ([issue#19672](http://tracker.ceph.com/issues/19672),
    [issue#19204](http://tracker.ceph.com/issues/19204),
    [pr#16102](https://github.com/ceph/ceph/pull/16102), John Spray)
-   mds: C_MDSInternalNoop::complete doesn\'t free itself
    ([issue#19664](http://tracker.ceph.com/issues/19664),
    [issue#19501](http://tracker.ceph.com/issues/19501),
    [pr#16099](https://github.com/ceph/ceph/pull/16099), \"Yan, Zheng\")
-   mds: daemon goes readonly writing backtrace for a file whose data
    pool has been removed
    ([issue#19669](http://tracker.ceph.com/issues/19669),
    [issue#19401](http://tracker.ceph.com/issues/19401),
    [pr#16101](https://github.com/ceph/ceph/pull/16101), John Spray)
-   mds: damage reporting by ino number is useless
    ([issue#18509](http://tracker.ceph.com/issues/18509),
    [issue#19680](http://tracker.ceph.com/issues/19680),
    [pr#16106](https://github.com/ceph/ceph/pull/16106), John Spray)
-   mds: Decode errors on backtrace will crash MDS
    ([issue#18311](http://tracker.ceph.com/issues/18311),
    [issue#18463](http://tracker.ceph.com/issues/18463),
    [pr#12835](https://github.com/ceph/ceph/pull/12835), John Spray)
-   mds: enable daemon to start when session ino info is corrupt
    ([issue#19710](http://tracker.ceph.com/issues/19710),
    [issue#16842](http://tracker.ceph.com/issues/16842),
    [pr#16107](https://github.com/ceph/ceph/pull/16107), John Spray)
-   mds: failed filelock.can_read(-1) assertion in
    Server::\_dir_is_nonempty
    ([issue#18707](http://tracker.ceph.com/issues/18707),
    [issue#18578](http://tracker.ceph.com/issues/18578),
    [pr#13555](https://github.com/ceph/ceph/pull/13555), Yan, Zheng)
-   mds: finish clientreplay requests before requesting active state
    ([issue#18678](http://tracker.ceph.com/issues/18678),
    [issue#18461](http://tracker.ceph.com/issues/18461),
    [pr#13112](https://github.com/ceph/ceph/pull/13112), Yan, Zheng)
-   mds: unresponsive when truncating a very large file
    ([issue#19755](http://tracker.ceph.com/issues/19755),
    [issue#20026](http://tracker.ceph.com/issues/20026),
    [pr#16190](https://github.com/ceph/ceph/pull/16190), \"Yan, Zheng\")
-   mon: cache tiering: base pool last_force_resend not respected
    (racing read got wrong version)
    ([issue#18366](http://tracker.ceph.com/issues/18366),
    [issue#18403](http://tracker.ceph.com/issues/18403),
    [pr#13116](https://github.com/ceph/ceph/pull/13116), Sage Weil)
-   mon crash on shutdown, lease_ack_timeout event
    ([issue#19928](http://tracker.ceph.com/issues/19928),
    [issue#19825](http://tracker.ceph.com/issues/19825),
    [pr#15084](https://github.com/ceph/ceph/pull/15084), Kefu Chai,
    Alexey Sheplyakov)
-   mon: fail to form large quorum; msg/async busy loop
    ([issue#20230](http://tracker.ceph.com/issues/20230),
    [issue#20315](http://tracker.ceph.com/issues/20315),
    [pr#15729](https://github.com/ceph/ceph/pull/15729), Haomai Wang)
-   mon: force_create_pg could leave pg stuck in creating state
    ([issue#19181](http://tracker.ceph.com/issues/19181),
    [issue#18298](http://tracker.ceph.com/issues/18298),
    [pr#13790](https://github.com/ceph/ceph/pull/13790), Adam C.
    Emerson, Sage Weil)
-   mon/MonClient: make get_mon_log_message() atomic
    ([issue#19618](http://tracker.ceph.com/issues/19618),
    [issue#19427](http://tracker.ceph.com/issues/19427),
    [pr#14588](https://github.com/ceph/ceph/pull/14588), Kefu Chai)
-   mon: \'osd crush move \...\' doesnt work on osds
    ([issue#18682](http://tracker.ceph.com/issues/18682),
    [issue#18587](http://tracker.ceph.com/issues/18587),
    [pr#13500](https://github.com/ceph/ceph/pull/13500), Sage Weil)
-   mon: osd crush set crushmap need sanity check
    ([issue#19302](http://tracker.ceph.com/issues/19302),
    [issue#20365](http://tracker.ceph.com/issues/20365),
    [pr#16143](https://github.com/ceph/ceph/pull/16143), Loic Dachary)
-   mon: peon wrongly delete routed pg stats op before receive pg stats
    ack ([issue#18554](http://tracker.ceph.com/issues/18554),
    [issue#18458](http://tracker.ceph.com/issues/18458),
    [pr#13046](https://github.com/ceph/ceph/pull/13046), Mingxin Liu)
-   mon/PGMap: factor mon_osd_full_ratio into MAX AVAIL calc
    ([issue#18522](http://tracker.ceph.com/issues/18522),
    [issue#20035](http://tracker.ceph.com/issues/20035),
    [pr#15237](https://github.com/ceph/ceph/pull/15237), Sage Weil)
-   msg/simple/SimpleMessenger.cc: 239: FAILED assert(!cleared)
    ([issue#15784](http://tracker.ceph.com/issues/15784),
    [issue#18378](http://tracker.ceph.com/issues/18378),
    [pr#16133](https://github.com/ceph/ceph/pull/16133), Sage Weil)
-   multisite: rest api fails to decode large period on \'period
    commit\' ([issue#19505](http://tracker.ceph.com/issues/19505),
    [issue#19616](http://tracker.ceph.com/issues/19616),
    [issue#19614](http://tracker.ceph.com/issues/19614),
    [issue#20244](http://tracker.ceph.com/issues/20244),
    [issue#19488](http://tracker.ceph.com/issues/19488),
    [issue#19776](http://tracker.ceph.com/issues/19776),
    [issue#20293](http://tracker.ceph.com/issues/20293),
    [issue#19746](http://tracker.ceph.com/issues/19746),
    [pr#16161](https://github.com/ceph/ceph/pull/16161), Casey Bodley,
    Abhishek Lekshmanan)
-   objecter: full_try behavior not consistent with osd
    ([issue#19560](http://tracker.ceph.com/issues/19560),
    [issue#19430](http://tracker.ceph.com/issues/19430),
    [pr#14732](https://github.com/ceph/ceph/pull/14732), Sage Weil)
-   ojecter: epoch_barrier isn\'t respected in \_op_submit()
    ([issue#19396](http://tracker.ceph.com/issues/19396),
    [issue#19496](http://tracker.ceph.com/issues/19496),
    [pr#14331](https://github.com/ceph/ceph/pull/14331), Ilya Dryomov)
-   os/bluestore: deep decode onode value
    ([issue#20366](http://tracker.ceph.com/issues/20366),
    [pr#15792](https://github.com/ceph/ceph/pull/15792), Sage Weil)
-   os/bluestore: fix Allocator::allocate() int truncation
    ([issue#20884](http://tracker.ceph.com/issues/20884),
    [issue#18595](http://tracker.ceph.com/issues/18595),
    [pr#13011](https://github.com/ceph/ceph/pull/13011), Sage Weil)
-   osd: allow client throttler to be adjusted on-fly, without restart
    ([issue#18791](http://tracker.ceph.com/issues/18791),
    [issue#18793](http://tracker.ceph.com/issues/18793),
    [pr#13216](https://github.com/ceph/ceph/pull/13216), Piotr Dałek)
-   osd: An OSD was seen getting ENOSPC even with
    osd_failsafe_full_ratio passed
    ([issue#20544](http://tracker.ceph.com/issues/20544),
    [issue#16878](http://tracker.ceph.com/issues/16878),
    [issue#19340](http://tracker.ceph.com/issues/19340),
    [issue#19841](http://tracker.ceph.com/issues/19841),
    [issue#20672](http://tracker.ceph.com/issues/20672),
    [pr#16134](https://github.com/ceph/ceph/pull/16134), Sage Weil,
    David Zafman)
-   osd: bogus assert when checking acting set on recovery completion in
    rados/upgrade ([issue#18999](http://tracker.ceph.com/issues/18999),
    [pr#13542](https://github.com/ceph/ceph/pull/13542), Sage Weil)
-   osd: calc_clone_subsets misuses try_read_lock vs missing
    ([issue#18610](http://tracker.ceph.com/issues/18610),
    [issue#18583](http://tracker.ceph.com/issues/18583),
    [issue#18723](http://tracker.ceph.com/issues/18723),
    [issue#17831](http://tracker.ceph.com/issues/17831),
    [pr#14616](https://github.com/ceph/ceph/pull/14616), Samuel Just)
-   osd: ceph degraded and misplaced status output inaccurate
    ([issue#18619](http://tracker.ceph.com/issues/18619),
    [issue#19480](http://tracker.ceph.com/issues/19480),
    [pr#14322](https://github.com/ceph/ceph/pull/14322), David Zafman)
-   osd: condition object_info_t encoding on required (not up) features
    ([issue#18842](http://tracker.ceph.com/issues/18842),
    [issue#18831](http://tracker.ceph.com/issues/18831),
    [issue#18814](http://tracker.ceph.com/issues/18814),
    [pr#13485](https://github.com/ceph/ceph/pull/13485), Ilya Dryomov)
-   osd: do not send ENXIO on misdirected op by default
    ([issue#19622](http://tracker.ceph.com/issues/19622),
    [pr#13253](https://github.com/ceph/ceph/pull/13253), Sage Weil)
-   osd: FAILED assert(object_contexts.empty()) (live on master only
    from Jan-Feb 2017, all other instances are different)
    ([issue#20522](http://tracker.ceph.com/issues/20522),
    [issue#20523](http://tracker.ceph.com/issues/20523),
    [issue#18927](http://tracker.ceph.com/issues/18927),
    [issue#18809](http://tracker.ceph.com/issues/18809),
    [pr#16132](https://github.com/ceph/ceph/pull/16132), Samuel Just)
-   osd: \--flush-journal: sporadic segfaults on exit
    ([issue#18952](http://tracker.ceph.com/issues/18952),
    [issue#18820](http://tracker.ceph.com/issues/18820),
    [pr#13490](https://github.com/ceph/ceph/pull/13490), Alexey
    Sheplyakov)
-   osd: Give requested scrubs a higher priority
    ([issue#19685](http://tracker.ceph.com/issues/19685),
    [issue#15789](http://tracker.ceph.com/issues/15789),
    [pr#14735](https://github.com/ceph/ceph/pull/14735), David Zafman)
-   osd: Implement asynchronous scrub sleep
    ([issue#20033](http://tracker.ceph.com/issues/20033),
    [issue#19986](http://tracker.ceph.com/issues/19986),
    [issue#20173](http://tracker.ceph.com/issues/20173),
    [issue#19497](http://tracker.ceph.com/issues/19497),
    [pr#15526](https://github.com/ceph/ceph/pull/15526), Brad Hubbard)
-   osd: leaked MOSDMap
    ([issue#19760](http://tracker.ceph.com/issues/19760),
    [issue#18293](http://tracker.ceph.com/issues/18293),
    [pr#14942](https://github.com/ceph/ceph/pull/14942), Sage Weil)
-   osd: leveldb corruption leads to Operation not permitted not handled
    and assert ([issue#18037](http://tracker.ceph.com/issues/18037),
    [issue#18418](http://tracker.ceph.com/issues/18418),
    [pr#12790](https://github.com/ceph/ceph/pull/12790), Nathan Cutler)
-   osd: metadata reports filestore when using bluestore
    ([issue#18677](http://tracker.ceph.com/issues/18677),
    [issue#18638](http://tracker.ceph.com/issues/18638),
    [pr#16083](https://github.com/ceph/ceph/pull/16083), Wido den
    Hollander)
-   osd: New added OSD always down when full flag is set
    ([issue#19485](http://tracker.ceph.com/issues/19485),
    [pr#14321](https://github.com/ceph/ceph/pull/14321), Mingxin Liu)
-   osd: Object level shard errors are tracked and used if no auth
    available ([issue#20089](http://tracker.ceph.com/issues/20089),
    [pr#15421](https://github.com/ceph/ceph/pull/15421), David Zafman)
-   osd: os/bluestore: fix statfs to not include DB partition in free
    space ([issue#18599](http://tracker.ceph.com/issues/18599),
    [issue#18722](http://tracker.ceph.com/issues/18722),
    [pr#13284](https://github.com/ceph/ceph/pull/13284), Sage Weil)
-   osd: osd/PrimaryLogPG: do not call on_shutdown() if (pg.deleting)
    ([issue#19902](http://tracker.ceph.com/issues/19902),
    [issue#19916](http://tracker.ceph.com/issues/19916),
    [pr#15066](https://github.com/ceph/ceph/pull/15066), Kefu Chai)
-   osd: pg log split does not rebuild index for parent or child
    ([issue#19315](http://tracker.ceph.com/issues/19315),
    [issue#18975](http://tracker.ceph.com/issues/18975),
    [pr#14048](https://github.com/ceph/ceph/pull/14048), Sage Weil)
-   osd: pglog: with config, don\'t assert in the presence of stale
    diverg... ([issue#17916](http://tracker.ceph.com/issues/17916),
    [issue#19702](http://tracker.ceph.com/issues/19702),
    [pr#14646](https://github.com/ceph/ceph/pull/14646), Greg Farnum)
-   osd: publish PG stats when backfill-related states change
    ([issue#18497](http://tracker.ceph.com/issues/18497),
    [issue#18369](http://tracker.ceph.com/issues/18369),
    [pr#13295](https://github.com/ceph/ceph/pull/13295), Sage Weil)
-   osd: Revert \"PrimaryLogPG::failed_push: update missing as well\"
    ([issue#18659](http://tracker.ceph.com/issues/18659),
    [pr#13091](https://github.com/ceph/ceph/pull/13091), David Zafman)
-   osd: unlock sdata_op_ordering_lock with sdata_lock hold to avoid
    missing wakeup signal
    ([issue#20443](http://tracker.ceph.com/issues/20443),
    [pr#15962](https://github.com/ceph/ceph/pull/15962), Alexey
    Sheplyakov)
-   pre-jewel \"osd rm\" incrementals are misinterpreted
    ([issue#19209](http://tracker.ceph.com/issues/19209),
    [issue#19119](http://tracker.ceph.com/issues/19119),
    [pr#13883](https://github.com/ceph/ceph/pull/13883), Ilya Dryomov)
-   rbd: Add missing parameter feedback to \'rbd snap limit\'
    ([issue#18601](http://tracker.ceph.com/issues/18601),
    [pr#14537](https://github.com/ceph/ceph/pull/14537), Tang Jin)
-   rbd: \[api\] is_exclusive_lock_owner shouldn\'t return -EBUSY
    ([issue#20266](http://tracker.ceph.com/issues/20266),
    [issue#20182](http://tracker.ceph.com/issues/20182),
    [pr#16187](https://github.com/ceph/ceph/pull/16187), Jason Dillaman)
-   rbd: \[api\] temporarily restrict (rbd\_)mirror_peer_add from adding
    multiple peers ([issue#19256](http://tracker.ceph.com/issues/19256),
    [issue#19324](http://tracker.ceph.com/issues/19324),
    [pr#14545](https://github.com/ceph/ceph/pull/14545), Jason Dillaman)
-   rbd: attempting to remove an image with incompatible features
    results in partial removal
    ([issue#18456](http://tracker.ceph.com/issues/18456),
    [issue#18315](http://tracker.ceph.com/issues/18315),
    [pr#13247](https://github.com/ceph/ceph/pull/13247), Dongsheng Yang)
-   rbd: \[cli\] ensure positional arguments exist before casting
    ([issue#20264](http://tracker.ceph.com/issues/20264),
    [issue#20185](http://tracker.ceph.com/issues/20185),
    [pr#16186](https://github.com/ceph/ceph/pull/16186), Jason Dillaman)
-   rbd: cli: map with cephx disabled results in error message
    ([issue#19035](http://tracker.ceph.com/issues/19035),
    [issue#20517](http://tracker.ceph.com/issues/20517),
    [pr#16298](https://github.com/ceph/ceph/pull/16298), Jason Dillaman)
-   rbd: \[ FAILED \] TestJournalTrimmer.RemoveObjectsWithOtherClient
    ([issue#18769](http://tracker.ceph.com/issues/18769),
    [issue#18738](http://tracker.ceph.com/issues/18738),
    [pr#14147](https://github.com/ceph/ceph/pull/14147), Jason Dillaman)
-   rbd: Improve compatibility between librbd + krbd for the data pool
    ([issue#18771](http://tracker.ceph.com/issues/18771),
    [issue#18653](http://tracker.ceph.com/issues/18653),
    [pr#14539](https://github.com/ceph/ceph/pull/14539), Jason Dillaman)
-   rbd: Issues with C API image metadata retrieval functions
    ([issue#19588](http://tracker.ceph.com/issues/19588),
    [issue#19611](http://tracker.ceph.com/issues/19611),
    [pr#15612](https://github.com/ceph/ceph/pull/15612), Mykola Golub)
-   rbd: \'metadata_set\' API operation should not change global config
    setting ([issue#18465](http://tracker.ceph.com/issues/18465),
    [issue#18549](http://tracker.ceph.com/issues/18549),
    [pr#14534](https://github.com/ceph/ceph/pull/14534), Mykola Golub)
-   rbd-mirror: additional test stability improvements
    ([issue#18935](http://tracker.ceph.com/issues/18935),
    [issue#18947](http://tracker.ceph.com/issues/18947),
    [pr#14155](https://github.com/ceph/ceph/pull/14155), Jason Dillaman)
-   rbd-mirror: deleting a snapshot during sync can result in read
    errors ([issue#19037](http://tracker.ceph.com/issues/19037),
    [issue#18990](http://tracker.ceph.com/issues/18990),
    [pr#14622](https://github.com/ceph/ceph/pull/14622), Jason Dillaman)
-   rbd-mirror: ensure missing images are re-synced when detected
    ([issue#20022](http://tracker.ceph.com/issues/20022),
    [issue#19811](http://tracker.ceph.com/issues/19811),
    [pr#15486](https://github.com/ceph/ceph/pull/15486), Jason Dillaman)
-   rbd-mirror: failover and failback of unmodified image results in
    split-brain ([issue#19872](http://tracker.ceph.com/issues/19872),
    [issue#19858](http://tracker.ceph.com/issues/19858),
    [pr#14974](https://github.com/ceph/ceph/pull/14974), Jason Dillaman)
-   rbd-mirror: potential race mirroring cloned image
    ([issue#18501](http://tracker.ceph.com/issues/18501),
    [issue#17993](http://tracker.ceph.com/issues/17993),
    [pr#14533](https://github.com/ceph/ceph/pull/14533), Jason Dillaman)
-   rbd-mirror: sporadic image replayer shut down failure
    ([issue#18493](http://tracker.ceph.com/issues/18493),
    [issue#18441](http://tracker.ceph.com/issues/18441),
    [pr#14531](https://github.com/ceph/ceph/pull/14531), Jason Dillaman)
-   rbd-nbd: add signal handler
    ([issue#19621](http://tracker.ceph.com/issues/19621),
    [issue#19349](http://tracker.ceph.com/issues/19349),
    [pr#16098](https://github.com/ceph/ceph/pull/16098), Kefu Chai, Pan
    Liu)
-   rbd-nbd: check /sys/block/nbdX/size to ensure kernel mapped
    correctly ([issue#18970](http://tracker.ceph.com/issues/18970),
    [issue#17951](http://tracker.ceph.com/issues/17951),
    [issue#18910](http://tracker.ceph.com/issues/18910),
    [issue#18335](http://tracker.ceph.com/issues/18335),
    [pr#14540](https://github.com/ceph/ceph/pull/14540), Mykola Golub,
    Pan Liu)
-   rbd: Possible deadlock performing a synchronous API action while
    refresh in-progress
    ([issue#18495](http://tracker.ceph.com/issues/18495),
    [issue#18419](http://tracker.ceph.com/issues/18419),
    [pr#14532](https://github.com/ceph/ceph/pull/14532), Jason Dillaman)
-   rbd: Potential IO hang if image is flattened while read request is
    in-flight ([issue#19832](http://tracker.ceph.com/issues/19832),
    [issue#20154](http://tracker.ceph.com/issues/20154),
    [pr#16184](https://github.com/ceph/ceph/pull/16184), Jason Dillaman)
-   rbd: \[qa\] crash in journal-enabled fsx run
    ([issue#18618](http://tracker.ceph.com/issues/18618),
    [issue#18632](http://tracker.ceph.com/issues/18632),
    [pr#14538](https://github.com/ceph/ceph/pull/14538), Jason Dillaman)
-   rbd: qemu crash triggered by network issues
    ([issue#18776](http://tracker.ceph.com/issues/18776),
    [issue#18436](http://tracker.ceph.com/issues/18436),
    [pr#13245](https://github.com/ceph/ceph/pull/13245), Jason Dillaman)
-   rbd: \'rbd bench-write\' will crash if \--io-size is 4G
    ([issue#18422](http://tracker.ceph.com/issues/18422),
    [issue#18557](http://tracker.ceph.com/issues/18557),
    [pr#14536](https://github.com/ceph/ceph/pull/14536), Gaurav Kumar
    Garg)
-   rbd: rbd_clone_copy_on_read ineffective with exclusive-lock
    ([issue#19173](http://tracker.ceph.com/issues/19173),
    [issue#18888](http://tracker.ceph.com/issues/18888),
    [pr#14543](https://github.com/ceph/ceph/pull/14543), Venky Shankar)
-   rbd: rbd \--pool=x rename y z does not work
    ([issue#18777](http://tracker.ceph.com/issues/18777),
    [issue#18326](http://tracker.ceph.com/issues/18326),
    [pr#14149](https://github.com/ceph/ceph/pull/14149), Gaurav Kumar
    Garg)
-   rbd: refuse to use an ec pool that doesn\'t support overwrites
    ([issue#19081](http://tracker.ceph.com/issues/19081),
    [issue#19336](http://tracker.ceph.com/issues/19336),
    [pr#16096](https://github.com/ceph/ceph/pull/16096), Jason Dillaman)
-   rgw: add apis to support ragweed suite
    ([issue#19809](http://tracker.ceph.com/issues/19809),
    [pr#14852](https://github.com/ceph/ceph/pull/14852), Yehuda Sadeh)
-   rgw: add the remove-x-delete feature to cancel swift object
    expiration ([issue#19472](http://tracker.ceph.com/issues/19472),
    [issue#19074](http://tracker.ceph.com/issues/19074),
    [pr#14522](https://github.com/ceph/ceph/pull/14522), Jing Wenjun)
-   rgw: a few cases where rgw_obj is incorrectly initialized
    ([issue#19146](http://tracker.ceph.com/issues/19146),
    [issue#19096](http://tracker.ceph.com/issues/19096),
    [pr#13843](https://github.com/ceph/ceph/pull/13843), Yehuda Sadeh)
-   rgw: anonymous user error code of getting object is not consistent
    with SWIFT ([issue#18806](http://tracker.ceph.com/issues/18806),
    [issue#19178](http://tracker.ceph.com/issues/19178),
    [pr#13877](https://github.com/ceph/ceph/pull/13877), Jing Wenjun)
-   rgw: civetweb frontend segfaults in Luminous
    ([issue#19749](http://tracker.ceph.com/issues/19749),
    [issue#19840](http://tracker.ceph.com/issues/19840),
    [pr#16166](https://github.com/ceph/ceph/pull/16166), Abhishek
    Lekshmanan, Jesse Williamson)
-   rgw: civetweb: move to post 1.8 version
    ([issue#19704](http://tracker.ceph.com/issues/19704),
    [pr#14960](https://github.com/ceph/ceph/pull/14960), Yehuda Sadeh)
-   rgw: \"cluster \[WRN\] bad locator \@X on object \@X\....\" in
    cluster log ([issue#19212](http://tracker.ceph.com/issues/19212),
    [issue#18980](http://tracker.ceph.com/issues/18980),
    [pr#14065](https://github.com/ceph/ceph/pull/14065), Casey Bodley)
-   rgw: crash when updating period with placement group
    ([issue#18772](http://tracker.ceph.com/issues/18772),
    [issue#18631](http://tracker.ceph.com/issues/18631),
    [pr#14511](https://github.com/ceph/ceph/pull/14511), Orit Wasserman)
-   rgw: Custom data header support
    ([issue#19843](http://tracker.ceph.com/issues/19843),
    [pr#15985](https://github.com/ceph/ceph/pull/15985), Pavan
    Rallabhandi)
-   rgw: datalog trim can\'t work as expected
    ([issue#20263](http://tracker.ceph.com/issues/20263),
    [issue#20190](http://tracker.ceph.com/issues/20190),
    [pr#16175](https://github.com/ceph/ceph/pull/16175), Zhang Shaowen)
-   rgw: DUMPABLE flag is cleared by setuid preventing coredumps
    ([issue#19147](http://tracker.ceph.com/issues/19147),
    [issue#19089](http://tracker.ceph.com/issues/19089),
    [pr#13845](https://github.com/ceph/ceph/pull/13845), Brad Hubbard)
-   rgw: Error parsing xml when get bucket lifecycle
    ([issue#19363](http://tracker.ceph.com/issues/19363),
    [issue#19534](http://tracker.ceph.com/issues/19534),
    [pr#14528](https://github.com/ceph/ceph/pull/14528), liuchang0812)
-   rgw: first write also tries to read object
    ([issue#18904](http://tracker.ceph.com/issues/18904),
    [issue#18622](http://tracker.ceph.com/issues/18622),
    [issue#18623](http://tracker.ceph.com/issues/18623),
    [issue#18621](http://tracker.ceph.com/issues/18621),
    [pr#14515](https://github.com/ceph/ceph/pull/14515), Yehuda Sadeh)
-   rgw: fix break inside of yield in RGWFetchAllMetaCR
    ([issue#19322](http://tracker.ceph.com/issues/19322),
    [issue#17655](http://tracker.ceph.com/issues/17655),
    [pr#14067](https://github.com/ceph/ceph/pull/14067), Casey Bodley)
-   rgw: fix handling RGWUserInfo::system in RGWHandler_REST_SWIFT
    ([issue#18476](http://tracker.ceph.com/issues/18476),
    [pr#13006](https://github.com/ceph/ceph/pull/13006), Radoslaw
    Zarzynski)
-   rgw: fix RadosGW hang during multi-chunk upload of AWSv4
    ([issue#19837](http://tracker.ceph.com/issues/19837),
    [issue#19754](http://tracker.ceph.com/issues/19754),
    [pr#14939](https://github.com/ceph/ceph/pull/14939), Radoslaw
    Zarzynski)
-   rgw: fix use of marker in List::list_objects()
    ([issue#19047](http://tracker.ceph.com/issues/19047),
    [issue#18331](http://tracker.ceph.com/issues/18331),
    [pr#14517](https://github.com/ceph/ceph/pull/14517), Yehuda Sadeh)
-   rgw: \'gc list \--include-all\' command infinite loop the first 1000
    items ([issue#19978](http://tracker.ceph.com/issues/19978),
    [issue#20147](http://tracker.ceph.com/issues/20147),
    [pr#16139](https://github.com/ceph/ceph/pull/16139), Shasha Lu, fang
    yuxiang)
-   rgw: get wrong content when download object with specific range when
    compression was enabled
    ([issue#20100](http://tracker.ceph.com/issues/20100),
    [issue#20268](http://tracker.ceph.com/issues/20268),
    [pr#16178](https://github.com/ceph/ceph/pull/16178), fang yuxiang)
-   rgw: health check errors out incorrectly
    ([issue#19025](http://tracker.ceph.com/issues/19025),
    [issue#19157](http://tracker.ceph.com/issues/19157),
    [pr#13866](https://github.com/ceph/ceph/pull/13866), Pavan
    Rallabhandi)
-   rgw: Lifecycle thread will still handle the bucket even if it has
    been removed ([issue#20285](http://tracker.ceph.com/issues/20285),
    [issue#20405](http://tracker.ceph.com/issues/20405),
    [pr#16183](https://github.com/ceph/ceph/pull/16183), Zhang Shaowen)
-   rgw: make sending Content-Length in 204 and 304 controllable
    ([issue#18985](http://tracker.ceph.com/issues/18985),
    [issue#16602](http://tracker.ceph.com/issues/16602),
    [pr#13514](https://github.com/ceph/ceph/pull/13514), Radoslaw
    Zarzynski)
-   rgw: meta sync thread crash at RGWMetaSyncShardCR
    ([issue#20251](http://tracker.ceph.com/issues/20251),
    [issue#20347](http://tracker.ceph.com/issues/20347),
    [pr#16180](https://github.com/ceph/ceph/pull/16180), Fang Yuxiang,
    Nathan Cutler)
-   rgw: multisite: after CreateBucket is forwarded to master, local
    bucket may use different value for bucket index shards
    ([issue#19745](http://tracker.ceph.com/issues/19745),
    [issue#19759](http://tracker.ceph.com/issues/19759),
    [pr#16290](https://github.com/ceph/ceph/pull/16290), Shasha Lu)
-   rgw: multisite: EPERM when trying to read SLO objects as
    system/admin user
    ([issue#19027](http://tracker.ceph.com/issues/19027),
    [issue#19475](http://tracker.ceph.com/issues/19475),
    [pr#14523](https://github.com/ceph/ceph/pull/14523), Casey Bodley)
-   rgw: multisite: fetch_remote_obj() gets wrong version when copying
    from remote ([issue#19608](http://tracker.ceph.com/issues/19608),
    [pr#14606](https://github.com/ceph/ceph/pull/14606), Zhang Shaowen,
    Casey Bodley)
-   rgw: multisite: RGWMetaSyncShardControlCR gives up on EIO
    ([issue#19160](http://tracker.ceph.com/issues/19160),
    [issue#19019](http://tracker.ceph.com/issues/19019),
    [pr#13868](https://github.com/ceph/ceph/pull/13868), Casey Bodley)
-   rgw: multisite: segfault after changing value of
    rgw_data_log_num_shards
    ([issue#18488](http://tracker.ceph.com/issues/18488),
    [issue#18548](http://tracker.ceph.com/issues/18548),
    [pr#13181](https://github.com/ceph/ceph/pull/13181), Casey Bodley)
-   rgw: multisite: some \'radosgw-admin data sync\' commands hang
    ([issue#19236](http://tracker.ceph.com/issues/19236),
    [issue#19354](http://tracker.ceph.com/issues/19354),
    [pr#14142](https://github.com/ceph/ceph/pull/14142), Shasha Lu)
-   rgw: multisite: some yields in RGWMetaSyncShardCR::full_sync()
    resume in incremental_sync()
    ([issue#19049](http://tracker.ceph.com/issues/19049),
    [issue#18076](http://tracker.ceph.com/issues/18076),
    [pr#13838](https://github.com/ceph/ceph/pull/13838), Casey Bodley)
-   rgw: multisite: sync status reports master is on a different period
    ([issue#18709](http://tracker.ceph.com/issues/18709),
    [issue#18064](http://tracker.ceph.com/issues/18064),
    [pr#13176](https://github.com/ceph/ceph/pull/13176), Abhishek
    Lekshmanan)
-   rgw: no http referer info in container metadata dump in swift API
    ([issue#18665](http://tracker.ceph.com/issues/18665),
    [issue#18898](http://tracker.ceph.com/issues/18898),
    [pr#13829](https://github.com/ceph/ceph/pull/13829), Jing Wenjun)
-   rgw: \"period update\" does not remove short_zone_ids of deleted
    zones ([issue#15618](http://tracker.ceph.com/issues/15618),
    [issue#19342](http://tracker.ceph.com/issues/19342),
    [pr#14141](https://github.com/ceph/ceph/pull/14141), Casey Bodley)
-   rgw: radosgw-admin: add the \'object stat\' command to usage
    ([issue#19164](http://tracker.ceph.com/issues/19164),
    [issue#19013](http://tracker.ceph.com/issues/19013),
    [pr#13873](https://github.com/ceph/ceph/pull/13873), Pavan
    Rallabhandi)
-   rgw: radosgw-admin period update reverts deleted zonegroup
    ([issue#18713](http://tracker.ceph.com/issues/18713),
    [issue#17239](http://tracker.ceph.com/issues/17239),
    [pr#13172](https://github.com/ceph/ceph/pull/13172), Orit Wasserman)
-   rgw: \'radosgw-admin usage show\' listing 0 bytes_sent/received
    ([issue#20261](http://tracker.ceph.com/issues/20261),
    [pr#16174](https://github.com/ceph/ceph/pull/16174), Pritha
    Srivastava)
-   rgw: \'radosgw-admin zone create\' command with specified zone-id
    creates a zone with different id
    ([issue#19524](http://tracker.ceph.com/issues/19524),
    [issue#19498](http://tracker.ceph.com/issues/19498),
    [pr#14526](https://github.com/ceph/ceph/pull/14526), Orit Wasserman)
-   rgw: Realm set does not create a new period
    ([issue#18333](http://tracker.ceph.com/issues/18333),
    [issue#18499](http://tracker.ceph.com/issues/18499),
    [pr#14509](https://github.com/ceph/ceph/pull/14509), Orit Wasserman)
-   rgw: reduce log level of \'storing entry at\' in cls_log
    ([issue#19835](http://tracker.ceph.com/issues/19835),
    [issue#19839](http://tracker.ceph.com/issues/19839),
    [pr#16165](https://github.com/ceph/ceph/pull/16165), Willem Jan
    Withagen)
-   rgw: Response header of swift API returned by radosgw does not
    contain x-openstack-request-id. But Swift returns it
    ([issue#19443](http://tracker.ceph.com/issues/19443),
    [issue#19573](http://tracker.ceph.com/issues/19573),
    [pr#14529](https://github.com/ceph/ceph/pull/14529), tone-zhang)
-   rgw: rgw_file: fix marker computation
    ([issue#20158](http://tracker.ceph.com/issues/20158),
    [issue#19526](http://tracker.ceph.com/issues/19526),
    [issue#18989](http://tracker.ceph.com/issues/18989),
    [issue#19470](http://tracker.ceph.com/issues/19470),
    [issue#19471](http://tracker.ceph.com/issues/19471),
    [issue#18651](http://tracker.ceph.com/issues/18651),
    [issue#20195](http://tracker.ceph.com/issues/20195),
    [issue#19059](http://tracker.ceph.com/issues/19059),
    [issue#19112](http://tracker.ceph.com/issues/19112),
    [issue#19018](http://tracker.ceph.com/issues/19018),
    [issue#19036](http://tracker.ceph.com/issues/19036),
    [issue#19154](http://tracker.ceph.com/issues/19154),
    [issue#19170](http://tracker.ceph.com/issues/19170),
    [issue#19663](http://tracker.ceph.com/issues/19663),
    [issue#19661](http://tracker.ceph.com/issues/19661),
    [issue#19111](http://tracker.ceph.com/issues/19111),
    [issue#18992](http://tracker.ceph.com/issues/18992),
    [issue#18650](http://tracker.ceph.com/issues/18650),
    [issue#18991](http://tracker.ceph.com/issues/18991),
    [issue#19623](http://tracker.ceph.com/issues/19623),
    [issue#19149](http://tracker.ceph.com/issues/19149),
    [issue#19270](http://tracker.ceph.com/issues/19270),
    [issue#19723](http://tracker.ceph.com/issues/19723),
    [issue#19625](http://tracker.ceph.com/issues/19625),
    [issue#19624](http://tracker.ceph.com/issues/19624),
    [issue#19060](http://tracker.ceph.com/issues/19060),
    [issue#19166](http://tracker.ceph.com/issues/19166),
    [issue#18810](http://tracker.ceph.com/issues/18810),
    [issue#19168](http://tracker.ceph.com/issues/19168),
    [issue#19162](http://tracker.ceph.com/issues/19162),
    [issue#19066](http://tracker.ceph.com/issues/19066),
    [issue#18808](http://tracker.ceph.com/issues/18808),
    [issue#19634](http://tracker.ceph.com/issues/19634),
    [issue#19435](http://tracker.ceph.com/issues/19435),
    [issue#19144](http://tracker.ceph.com/issues/19144),
    [issue#19229](http://tracker.ceph.com/issues/19229),
    [issue#18902](http://tracker.ceph.com/issues/18902),
    [pr#13871](https://github.com/ceph/ceph/pull/13871), Gui Hecheng,
    Matt Benjamin)
-   rgw: S3 create bucket should not do response in json
    ([issue#19172](http://tracker.ceph.com/issues/19172),
    [issue#18889](http://tracker.ceph.com/issues/18889),
    [pr#13875](https://github.com/ceph/ceph/pull/13875), Abhishek
    Lekshmanan)
-   rgw: S3 v4 authentication issue with X-Amz-Expires
    ([issue#19477](http://tracker.ceph.com/issues/19477),
    [issue#18828](http://tracker.ceph.com/issues/18828),
    [pr#14524](https://github.com/ceph/ceph/pull/14524), liuchang0812)
-   rgw: S3 v4 authentication issue with X-Amz-Expires
    ([issue#19725](http://tracker.ceph.com/issues/19725),
    [issue#18828](http://tracker.ceph.com/issues/18828),
    [pr#16162](https://github.com/ceph/ceph/pull/16162), liuchang0812)
-   rgw: should parse the url to http host to compare with the container
    referer acl ([issue#18896](http://tracker.ceph.com/issues/18896),
    [issue#18685](http://tracker.ceph.com/issues/18685),
    [pr#13780](https://github.com/ceph/ceph/pull/13780), Jing Wenjun)
-   rgw: slave zonegroup cannot enable the bucket versioning
    ([issue#18711](http://tracker.ceph.com/issues/18711),
    [issue#18003](http://tracker.ceph.com/issues/18003),
    [pr#13174](https://github.com/ceph/ceph/pull/13174), Orit Wasserman)
-   rgw: Swift API: spurious newline after http body causes weird errors
    ([issue#18780](http://tracker.ceph.com/issues/18780),
    [issue#18473](http://tracker.ceph.com/issues/18473),
    [pr#13224](https://github.com/ceph/ceph/pull/13224), Marcus Watts,
    Matt Benjamin)
-   rgw: swift API: cannot disable object versioning with empty
    X-Versions-Location
    ([issue#18852](http://tracker.ceph.com/issues/18852),
    [issue#19175](http://tracker.ceph.com/issues/19175),
    [pr#14519](https://github.com/ceph/ceph/pull/14519), Jing Wenjun)
-   rgw: swift: disable revocation thread under certain circumstances
    ([issue#19499](http://tracker.ceph.com/issues/19499),
    [issue#9493](http://tracker.ceph.com/issues/9493),
    [issue#19777](http://tracker.ceph.com/issues/19777),
    [pr#16164](https://github.com/ceph/ceph/pull/16164), Marcus Watts)
-   rgw: Swift\'s at-root features (/crossdomain.xml, /info,
    /healthcheck) are broken
    ([issue#20031](http://tracker.ceph.com/issues/20031),
    [issue#19520](http://tracker.ceph.com/issues/19520),
    [pr#16168](https://github.com/ceph/ceph/pull/16168), Radoslaw
    Zarzynski)
-   rgw: the swift container acl does not support field .ref
    ([issue#18909](http://tracker.ceph.com/issues/18909),
    [issue#19180](http://tracker.ceph.com/issues/19180),
    [issue#18484](http://tracker.ceph.com/issues/18484),
    [issue#18796](http://tracker.ceph.com/issues/18796),
    [pr#14516](https://github.com/ceph/ceph/pull/14516), Jing Wenjun,
    Radoslaw Zarzynski)
-   rgw: typo in rgw_admin.cc
    ([issue#19156](http://tracker.ceph.com/issues/19156),
    [issue#19026](http://tracker.ceph.com/issues/19026),
    [pr#13864](https://github.com/ceph/ceph/pull/13864), Ronak Jain)
-   rgw: unsafe access in RGWListBucket_ObjStore_SWIFT::send_response()
    ([issue#19574](http://tracker.ceph.com/issues/19574),
    [issue#19249](http://tracker.ceph.com/issues/19249),
    [pr#14530](https://github.com/ceph/ceph/pull/14530), Yehuda Sadeh)
-   rgw: upgrade to multisite v2 fails if there is a zone without zone
    info ([issue#19331](http://tracker.ceph.com/issues/19331),
    [issue#19231](http://tracker.ceph.com/issues/19231),
    [pr#14137](https://github.com/ceph/ceph/pull/14137), Danny Al-Gaaf,
    Orit Wasserman)
-   rgw: usage stats and quota are not operational for multi-tenant
    users ([issue#18364](http://tracker.ceph.com/issues/18364),
    [issue#18843](http://tracker.ceph.com/issues/18843),
    [issue#16355](http://tracker.ceph.com/issues/16355),
    [pr#14513](https://github.com/ceph/ceph/pull/14513), Radoslaw
    Zarzynski)
-   rgw: Use decoded URI when verifying TempURL
    ([issue#18590](http://tracker.ceph.com/issues/18590),
    [issue#18627](http://tracker.ceph.com/issues/18627),
    [pr#12986](https://github.com/ceph/ceph/pull/12986), Michal Koutný)
-   rgw: VersionIdMarker and NextVersionIdMarker are not returned when
    listing object versions
    ([issue#20363](http://tracker.ceph.com/issues/20363),
    [issue#19886](http://tracker.ceph.com/issues/19886),
    [pr#16181](https://github.com/ceph/ceph/pull/16181), Zhang Shaowen)
-   rgw: when converting region_map we need to use rgw_zone_root_pool
    ([issue#19195](http://tracker.ceph.com/issues/19195),
    [issue#19356](http://tracker.ceph.com/issues/19356),
    [pr#14144](https://github.com/ceph/ceph/pull/14144), Orit Wasserman)
-   rgw: when uploading the objects continuesly in the versioned bucket,
    some objects will not sync
    ([issue#19766](http://tracker.ceph.com/issues/19766),
    [issue#18208](http://tracker.ceph.com/issues/18208),
    [pr#16163](https://github.com/ceph/ceph/pull/16163), lvshuhua)
-   rgw: wrong object size after copy of uncompressed multipart objects
    ([issue#20269](http://tracker.ceph.com/issues/20269),
    [issue#20071](http://tracker.ceph.com/issues/20071),
    [pr#16179](https://github.com/ceph/ceph/pull/16179), fang yuxiang)
-   rgw: zonegroupmap set does not work
    ([issue#18725](http://tracker.ceph.com/issues/18725),
    [issue#19479](http://tracker.ceph.com/issues/19479),
    [pr#14525](https://github.com/ceph/ceph/pull/14525), Casey Bodley)
-   tests: AttributeError: Thrasher instance has no attribute
    \'ceph_objectstore_tool\'
    ([issue#19064](http://tracker.ceph.com/issues/19064),
    [issue#18799](http://tracker.ceph.com/issues/18799),
    [pr#13609](https://github.com/ceph/ceph/pull/13609), Nathan Cutler)
-   tests: backport Sage\'s fixes to qa/suites/upgrade/jewel-x
    ([issue#19651](http://tracker.ceph.com/issues/19651),
    [pr#14612](https://github.com/ceph/ceph/pull/14612), Sage Weil)
-   tests: ceph-object-corpus: kraken objects
    ([issue#20878](http://tracker.ceph.com/issues/20878),
    [pr#14983](https://github.com/ceph/ceph/pull/14983), Sage Weil)
-   tests: CMakeLists.txt: disable memstore make check test
    ([issue#17743](http://tracker.ceph.com/issues/17743),
    [pr#16215](https://github.com/ceph/ceph/pull/16215), Sage Weil)
-   tests: HEALTH_WARN pool rbd pg_num 244 \> pgp_num 224 during upgrade
    ([issue#19771](http://tracker.ceph.com/issues/19771),
    [issue#20024](http://tracker.ceph.com/issues/20024),
    [pr#16137](https://github.com/ceph/ceph/pull/16137), Kefu Chai)
-   tests: ignore bogus ceph-objectstore-tool error in ceph_manager
    ([issue#18805](http://tracker.ceph.com/issues/18805),
    [issue#16263](http://tracker.ceph.com/issues/16263),
    [pr#13239](https://github.com/ceph/ceph/pull/13239), Nathan Cutler,
    Kefu Chai)
-   tests: insufficient timeout in radosbench task
    ([issue#20497](http://tracker.ceph.com/issues/20497),
    [pr#16111](https://github.com/ceph/ceph/pull/16111), Sage Weil)
-   tests: LibRadosMiscConnectFailure.ConnectFailure hang
    ([issue#20271](http://tracker.ceph.com/issues/20271),
    [issue#19901](http://tracker.ceph.com/issues/19901),
    [pr#16140](https://github.com/ceph/ceph/pull/16140), Sage Weil)
-   tests: \[librados_test_stub\] cls_cxx_map_get_XYZ methods don\'t
    return correct value
    ([issue#19597](http://tracker.ceph.com/issues/19597),
    [issue#19609](http://tracker.ceph.com/issues/19609),
    [pr#16097](https://github.com/ceph/ceph/pull/16097), Jason Dillaman)
-   tests: move swift.py task from teuthology to ceph, phase one
    (kraken) ([issue#20392](http://tracker.ceph.com/issues/20392),
    [pr#15869](https://github.com/ceph/ceph/pull/15869), Nathan Cutler,
    Sage Weil, Warren Usui, Greg Farnum, Ali Maredia, Tommi Virtanen,
    Zack Cerza, Sam Lang, Yehuda Sadeh, Joe Buck, Josh Durgin)
-   tests: ObjectStore/StoreTest.OnodeSizeTracking/2 fails on bluestore
    ([issue#20499](http://tracker.ceph.com/issues/20499),
    [pr#16112](https://github.com/ceph/ceph/pull/16112), xie xingguo)
-   tests: qa: ceph-ansible test tweaks
    ([issue#20882](http://tracker.ceph.com/issues/20882),
    [pr#12984](https://github.com/ceph/ceph/pull/12984),
    [pr#13618](https://github.com/ceph/ceph/pull/13618), Tamil
    Muthamizhan, Yuri Weinstein)
-   tests: qa/suites/upgrade: add tiering test to hammer-jewel-x
    ([issue#20879](http://tracker.ceph.com/issues/20879),
    [issue#19185](http://tracker.ceph.com/issues/19185),
    [pr#14692](https://github.com/ceph/ceph/pull/14692), Kefu Chai)
-   tests: qa/tasks: misc systemd updates
    ([issue#19719](http://tracker.ceph.com/issues/19719),
    [pr#14702](https://github.com/ceph/ceph/pull/14702), Vasu Kulkarni)
-   tests: qa/tasks: rbd-mirror daemon not properly run in foreground
    mode ([issue#20638](http://tracker.ceph.com/issues/20638),
    [issue#20630](http://tracker.ceph.com/issues/20630),
    [issue#20634](http://tracker.ceph.com/issues/20634),
    [pr#16342](https://github.com/ceph/ceph/pull/16342), Jason Dillaman)
-   tests: qa/tasks: set pgp = pg num on thrashing finish
    ([issue#20881](http://tracker.ceph.com/issues/20881),
    [pr#13757](https://github.com/ceph/ceph/pull/13757), Kefu Chai)
-   tests: qa/tasks/workunit: Backport repo fixes from master
    ([issue#19429](http://tracker.ceph.com/issues/19429),
    [issue#19531](http://tracker.ceph.com/issues/19531),
    [pr#14487](https://github.com/ceph/ceph/pull/14487), Kefu Chai, Dan
    Mick)
-   tests: remove hard-coded image name from TestLibRBD.Mirror
    ([issue#18555](http://tracker.ceph.com/issues/18555),
    [issue#19130](http://tracker.ceph.com/issues/19130),
    [issue#19227](http://tracker.ceph.com/issues/19227),
    [issue#18447](http://tracker.ceph.com/issues/18447),
    [issue#19807](http://tracker.ceph.com/issues/19807),
    [issue#19798](http://tracker.ceph.com/issues/19798),
    [pr#16113](https://github.com/ceph/ceph/pull/16113), Mykola Golub,
    Jason Dillaman)
-   tests: remove qa/suites/buildpackages
    ([issue#18849](http://tracker.ceph.com/issues/18849),
    [issue#18846](http://tracker.ceph.com/issues/18846),
    [pr#13298](https://github.com/ceph/ceph/pull/13298), Loic Dachary)
-   tests: run certain upgrade/jewel-x tests on Xenial only
    ([issue#20877](http://tracker.ceph.com/issues/20877),
    [pr#16493](https://github.com/ceph/ceph/pull/16493), Nathan Cutler)
-   tests: run-rbd-unit-tests.sh assert in lockdep_will_lock,
    TestLibRBD.ObjectMapConsistentSnap
    ([issue#18822](http://tracker.ceph.com/issues/18822),
    [issue#17447](http://tracker.ceph.com/issues/17447),
    [pr#14151](https://github.com/ceph/ceph/pull/14151), Jason Dillaman)
-   tests: SUSE yaml facets in qa/distros/all are out of date
    ([issue#18849](http://tracker.ceph.com/issues/18849),
    [issue#18870](http://tracker.ceph.com/issues/18870),
    [issue#18846](http://tracker.ceph.com/issues/18846),
    [issue#18856](http://tracker.ceph.com/issues/18856),
    [pr#13330](https://github.com/ceph/ceph/pull/13330), Nathan Cutler)
-   tests: swift.py: clone the ceph-kraken branch
    ([issue#20520](http://tracker.ceph.com/issues/20520),
    [pr#16131](https://github.com/ceph/ceph/pull/16131), Nathan Cutler)
-   tests: test/librbd: decouple ceph_test_librbd_api from
    libceph-common ([issue#20175](http://tracker.ceph.com/issues/20175),
    [issue#20351](http://tracker.ceph.com/issues/20351),
    [pr#16195](https://github.com/ceph/ceph/pull/16195), Kefu Chai)
-   tests: test_notify.py: assert(not image.is_exclusive_lock_owner())
    on line 147 ([issue#19716](http://tracker.ceph.com/issues/19716),
    [issue#19794](http://tracker.ceph.com/issues/19794),
    [pr#14833](https://github.com/ceph/ceph/pull/14833), Mykola Golub)
-   tests: test_notify.py: rbd.InvalidArgument: error updating features
    for image test_notify_clone2
    ([issue#19692](http://tracker.ceph.com/issues/19692),
    [issue#19693](http://tracker.ceph.com/issues/19693),
    [pr#14641](https://github.com/ceph/ceph/pull/14641), Jason Dillaman)
-   tests: use ceph-kraken branch for s3tests
    ([issue#18387](http://tracker.ceph.com/issues/18387),
    [pr#12746](https://github.com/ceph/ceph/pull/12746), Nathan Cutler)
-   tests: use librados API to retrieve config params
    ([issue#18668](http://tracker.ceph.com/issues/18668),
    [issue#18617](http://tracker.ceph.com/issues/18617),
    [pr#13102](https://github.com/ceph/ceph/pull/13102), Jason Dillaman)
-   tests: various OpenStack tweaks
    ([issue#20882](http://tracker.ceph.com/issues/20882),
    [pr#13707](https://github.com/ceph/ceph/pull/13707),
    [pr#13641](https://github.com/ceph/ceph/pull/13641),
    [pr#13635](https://github.com/ceph/ceph/pull/13635),
    [pr#13633](https://github.com/ceph/ceph/pull/13633),
    [pr#13613](https://github.com/ceph/ceph/pull/13613),
    [pr#13283](https://github.com/ceph/ceph/pull/13283),
    [pr#13673](https://github.com/ceph/ceph/pull/13673),
    [pr#13638](https://github.com/ceph/ceph/pull/13638),
    [pr#14485](https://github.com/ceph/ceph/pull/14485), Zack Cerza)
-   tools: ceph-brag fails to count \"in\" mds
    ([issue#19333](http://tracker.ceph.com/issues/19333),
    [issue#19192](http://tracker.ceph.com/issues/19192),
    [pr#14098](https://github.com/ceph/ceph/pull/14098), Peng Zhang)
-   tools: ceph-disk prepare writes osd log 0 with root owner
    ([issue#18538](http://tracker.ceph.com/issues/18538),
    [issue#18606](http://tracker.ceph.com/issues/18606),
    [pr#13026](https://github.com/ceph/ceph/pull/13026), Samuel Matzek)
-   tools: RadosImport::import should return an error if Rados::connect
    fails ([issue#19351](http://tracker.ceph.com/issues/19351),
    [issue#19319](http://tracker.ceph.com/issues/19319),
    [pr#14095](https://github.com/ceph/ceph/pull/14095), Brad Hubbard)

## v11.2.0 Kraken

This is the first release of the Kraken series. It is a stable release
that will be maintained with bugfixes and backports until the next
stable release, Luminous, is completed in the Spring of 2017.

### Major Changes from Jewel

-   *RADOS*:
    -   The new *BlueStore* backend now has a stable disk format and is
        passing our failure and stress testing. Although the backend is
        still flagged as experimental, we encourage users to try it out
        for non-production clusters and non-critical data sets.
    -   RADOS now has experimental support for *overwrites on
        erasure-coded* pools. Because the disk format and implementation
        are not yet finalized, there is a special pool option that must
        be enabled to test the new feature.  Enabling this option on a
        cluster will permanently bar that cluster from being upgraded to
        future versions.
    -   We now default to the AsyncMessenger (`ms type = async`) instead
        of the legacy SimpleMessenger.  The most noticeable difference
        is that we now use a fixed sized thread pool for network
        connections (instead of two threads per socket with
        SimpleMessenger).
    -   Some OSD failures are now detected almost immediately, whereas
        previously the heartbeat timeout (which defaults to 20 seconds)
        had to expire.  This prevents IO from blocking for an extended
        period for failures where the host remains up but the ceph-osd
        process is no longer running.
    -   There is a new `ceph-mgr` daemon.  It is currently collocated
        with the monitors by default, and is not yet used for much, but
        the basic infrastructure is now in place.
    -   The size of encoded OSDMaps has been reduced.
    -   The OSDs now quiesce scrubbing when recovery or rebalancing is
        in progress.
-   *RGW*:
    -   RGW now supports a new zone type that can be used for metadata
        indexing via ElasticSearch.
    -   RGW now supports the S3 multipart object copy-part API.
    -   It is possible now to reshard an existing bucket. Note that
        bucket resharding currently requires that all IO (especially
        writes) to the specific bucket is quiesced.
    -   RGW now supports data compression for objects.
    -   Civetweb version has been upgraded to 1.8
    -   The Swift static website API is now supported (S3 support has
        been added previously).
    -   S3 bucket lifecycle API has been added. Note that currently it
        only supports object expiration.
    -   Support for custom search filters has been added to the LDAP
        auth implementation.
    -   Support for NFS version 3 has been added to the RGW NFS gateway.
    -   A Python binding has been created for librgw.
-   *RBD*:
    -   RBD now supports images stored in an *erasure-coded* RADOS pool
        using the new (experimental) overwrite support. Images must be
        created using the new rbd CLI \"\--data-pool \<ec pool\>\"
        option to specify the EC pool where the backing data objects are
        stored. Attempting to create an image directly on an EC pool
        will not be successful since the image\'s backing metadata is
        only supported on a replicated pool.
    -   The rbd-mirror daemon now supports replicating dynamic image
        feature updates and image metadata key/value pairs from the
        primary image to the non-primary image.
    -   The number of image snapshots can be optionally restricted to a
        configurable maximum.
    -   The rbd Python API now supports asynchronous IO operations.
-   *CephFS*:
    -   libcephfs function definitions have been changed to enable
        proper uid/gid control. The library version has been increased
        to reflect the interface change.
    -   Standby replay MDS daemons now consume less memory on workloads
        doing deletions.
    -   Scrub now repairs backtrace, and populates [damage
        ls]{.title-ref} with discovered errors.
    -   A new [pg_files]{.title-ref} subcommand to
        [cephfs-data-scan]{.title-ref} can identify files affected by a
        damaged or lost RADOS PG.
    -   The false-positive \"failing to respond to cache pressure\"
        warnings have been fixed.

### Upgrading from Kraken release candidate 11.1.0

-   The new *BlueStore* backend had an on-disk format change after
    11.1.0. Any BlueStore OSDs created with 11.1.0 will need to be
    destroyed and recreated.

### Upgrading from Jewel

-   All clusters must first be upgraded to Jewel 10.2.z before upgrading
    to Kraken 11.2.z (or, eventually, Luminous 12.2.z).
-   The `sortbitwise` flag must be set on the Jewel cluster before
    upgrading to Kraken. The latest Jewel (10.2.8+) releases issue a
    health warning if the flag is not set, so this is probably already
    set. If it is not, Kraken OSDs will refuse to start and will print
    and error message in their log.
-   You may upgrade OSDs, Monitors, and MDSs in any order. RGW daemons
    should be upgraded last.
-   When upgrading, new ceph-mgr daemon instances will be created
    automatically alongside any monitors. This will be true for Jewel to
    Kraken and Jewel to Luminous upgrades, but likely not be true for
    future upgrades beyond Luminous. You are, of course, free to create
    new ceph-mgr daemon instances and destroy the auto-created ones if
    you do not with them to be colocated with the ceph-mon daemons.

### BlueStore

BlueStore is a new backend for managing data stored by each OSD on the
directly hard disk or SSD. Unlike the existing FileStore implementation,
which makes use of an XFS file system to store objects as files,
BlueStore manages the underlying block device directly. Implements its
own file system-like on-disk structure the is designed specifically for
Ceph OSD workloads. Key features of BlueStore include:

> -   Checksums on all data written to disk, with checksum verifications
>     on all reads, enabled by default.
> -   Inline compression support, which can be enabled on a per-pool or
>     per-object basis via pool properties or client hints,
>     respectively.
> -   Efficient journaling. Unlike FileStore, which writes *all* data to
>     its journal device, BlueStore only journals metadata and (in some
>     cases) small writes, reducing the size and throughput requirements
>     for its journal. As with FileStore, the journal can be colocated
>     on the same device as other data or allocated on a smaller,
>     high-performance device (e.g., an SSD or NVMe device). BlueStore
>     journals are only 512 MB by default.

The BlueStore on-disk format is expected to continue to evolve. However,
we will provide support in the OSD to migrate to the new format on
upgrade.

In order to enable BlueStore, add the following to ceph.conf:

    enable experimental unrecoverable data corrupting features = bluestore

To create a BlueStore OSD, pass the \--bluestore option to ceph-disk or
ceph-deploy during OSD creation.

### Upgrade notes

-   The OSDs now avoid starting new scrubs while recovery is in
    progress. To revert to the old behavior (and do not let recovery
    activity affect the scrub scheduling) you can set the following
    option:

        osd scrub during recovery = true

-   The list of monitor hosts/addresses for building the monmap can now
    be obtained from DNS SRV records. The service name used when
    querying the DNS is defined in the \"mon_dns_srv_name\" config
    option, which defaults to \"ceph-mon\".

-   The \'osd class load list\' config option is a list of object class
    names that the OSD is permitted to load (or \'\*\' for all classes).
    By default it contains all existing in-tree classes for backwards
    compatibility.

-   The \'osd class default list\' config option is a list of object
    class names (or \'\*\' for all classes) that clients may invoke
    having only the \'\*\', \'x\', \'class-read\', or \'class-write\'
    capabilities. By default it contains all existing in-tree classes
    for backwards compatibility. Invoking classes not listed in \'osd
    class default list\' requires a capability naming the class (e.g.
    \'allow class foo\').

-   The \'rgw rest getusage op compat\' config option allows you to dump
    (or not dump) the description of user stats in the S3 GetUsage API.
    This option defaults to false. If the value is true, the response
    data for GetUsage looks like:

        "stats": {
                    "TotalBytes": 516,
                    "TotalBytesRounded": 1024,
                    "TotalEntries": 1
                 }

    If the value is false, the response for GetUsage looks as it did
    before:

        {
             516,
             1024,
             1
        }

-   The \'osd out \...\' and \'osd in \...\' commands now preserve the
    OSD weight. That is, after marking an OSD out and then in, the
    weight will be the same as before (instead of being reset to 1.0).
    Previously the mons would only preserve the weight if the mon
    automatically marked and OSD out and then in, but not when an admin
    did so explicitly.

-   The \'ceph osd perf\' command will display \'commit_latency(ms)\'
    and \'apply_latency(ms)\'. Previously, the names of these two
    columns are \'fs_commit_latency(ms)\' and \'fs_apply_latency(ms)\'.
    We remove the prefix \'fs\_\', because they are not filestore
    specific.

-   Monitors will no longer allow pools to be removed by default. The
    setting mon_allow_pool_delete has to be set to true (defaults to
    false) before they allow pools to be removed. This is a additional
    safeguard against pools being removed by accident.

-   If you have manually specified the monitor user rocksdb via the
    `mon keyvaluedb = rocksdb` option, you will need to manually add a
    file to the mon data directory to preserve this option:

        echo rocksdb > /var/lib/ceph/mon/ceph-`hostname`/kv_backend

    New monitors will now use rocksdb by default, but if that file is
    not present, existing monitors will use leveldb. The
    `mon keyvaluedb` option now only affects the backend chosen when a
    monitor is created.

-   The \'osd crush initial weight\' option allows you to specify a
    CRUSH weight for a newly added OSD. Previously a value of 0 (the
    default) meant that we should use the size of the OSD\'s store to
    weight the new OSD. Now, a value of 0 means it should have a weight
    of 0, and a negative value (the new default) means we should
    automatically weight the OSD based on its size. If your
    configuration file explicitly specifies a value of 0 for this option
    you will need to change it to a negative value (e.g., -1) to
    preserve the current behavior.

-   The `osd crush location` config option is no longer supported.
    Please update your ceph.conf to use the `crush location` option
    instead.

-   The static libraries are no longer included by the debian
    development packages (lib\*-dev) as it is not required per debian
    packaging policy. The shared (.so) versions are packaged as before.

-   The libtool pseudo-libraries (.la files) are no longer included by
    the debian development packages (lib\*-dev) as they are not required
    per <https://wiki.debian.org/ReleaseGoals/LAFileRemoval> and
    <https://www.debian.org/doc/manuals/maint-guide/advanced.en.html>.

-   The jerasure and shec plugins can now detect SIMD instruction at
    runtime and no longer need to be explicitly configured for different
    processors. The following plugins are now deprecated:
    jerasure_generic, jerasure_sse3, jerasure_sse4, jerasure_neon,
    shec_generic, shec_sse3, shec_sse4, and shec_neon. If you use any of
    these plugins directly you will see a warning in the mon log file.
    Please switch to using just \'jerasure\' or \'shec\'.

-   The librados omap get_keys and get_vals operations include a start
    key and a limit on the number of keys to return. The OSD now imposes
    a configurable limit on the number of keys and number of total bytes
    it will respond with, which means that a librados user might get
    fewer keys than they asked for. This is necessary to prevent
    careless users from requesting an unreasonable amount of data from
    the cluster in a single operation. The new limits are configured
    with `osd_max_omap_entries_per_request`, defaulting to 131,072, and
    `osd_max_omap_bytes_per_request`, defaulting to 4MB.

-   Calculation of recovery priorities has been updated. This could lead
    to unintuitive recovery prioritization during cluster upgrade. In
    case of such recovery, OSDs in the old version would operate on
    different priority ranges than new ones. Once upgraded, the cluster
    will operate on consistent values.

### Notable Changes

-   bluestore: add counter to trace blob splitting
    ([pr#11718](http://github.com/ceph/ceph/pull/11718), xie xingguo)
-   bluestore: a few more cleanups
    ([pr#11780](http://github.com/ceph/ceph/pull/11780), xie xingguo)
-   bluestore: avoid polluting shard info if need resharding
    ([pr#11439](http://github.com/ceph/ceph/pull/11439), xie xingguo)
-   bluestore: avoid unnecessary call to init_csum()
    ([pr#12015](http://github.com/ceph/ceph/pull/12015), xie xingguo)
-   bluestore: ceph-disk: adjust bluestore default device sizes
    ([pr#12530](http://github.com/ceph/ceph/pull/12530), Sage Weil)
-   bluestore: ceph_test_objectstore: smaller device
    ([pr#11591](http://github.com/ceph/ceph/pull/11591), Sage Weil)
-   bluestore: clean up Allocator::dump
    ([issue#18054](http://tracker.ceph.com/issues/18054),
    [pr#12282](http://github.com/ceph/ceph/pull/12282), Sage Weil)
-   bluestore: clear extent map on object removal
    ([pr#11603](http://github.com/ceph/ceph/pull/11603), Sage Weil)
-   bluestore: compressor/ZLibCompressor: fix broken isal-l
    ([pr#11445](http://github.com/ceph/ceph/pull/11445), Igor Fedotov)
-   bluestore: dedup if space overlap truly exists
    ([pr#11986](http://github.com/ceph/ceph/pull/11986), xie xingguo)
-   bluestore: dedup omap_head, reuse nid instead
    ([pr#12275](http://github.com/ceph/ceph/pull/12275), xie xingguo)
-   bluestore: deep fsck
    ([pr#11724](http://github.com/ceph/ceph/pull/11724), Sage Weil)
-   bluestore: default bluestore_clone_cow=true
    ([pr#11540](http://github.com/ceph/ceph/pull/11540), Sage Weil)
-   bluestore: drop inline_dirty from struct ExtentMap
    ([pr#11377](http://github.com/ceph/ceph/pull/11377), xie xingguo)
-   bluestore: drop member \"space\" from Onode
    ([pr#12185](http://github.com/ceph/ceph/pull/12185), xie xingguo)
-   bluestore: fix alloc release timing on sync submits
    ([pr#11983](http://github.com/ceph/ceph/pull/11983), Sage Weil)
-   bluestore: fix bufferspace stats leak due to blob splitting
    ([pr#12039](http://github.com/ceph/ceph/pull/12039), xie xingguo)
-   bluestore: fix collection_list end bound off-by-one
    ([pr#11771](http://github.com/ceph/ceph/pull/11771), Sage Weil)
-   bluestore: fix compiler warnings
    ([pr#11905](http://github.com/ceph/ceph/pull/11905), xie xingguo)
-   bluestore: fixes and cleanups
    ([pr#11761](http://github.com/ceph/ceph/pull/11761), xie xingguo)
-   bluestore: fix escaping of chars \> 0x80
    ([pr#11502](http://github.com/ceph/ceph/pull/11502), Sage Weil)
-   bluestore: fix extent shard span check
    ([pr#11725](http://github.com/ceph/ceph/pull/11725), Sage Weil)
-   bluestore: fix has_aios
    ([pr#11317](http://github.com/ceph/ceph/pull/11317), Sage Weil)
-   bluestore: Fix invalid compression statfs caused by clone op
    ([pr#11351](http://github.com/ceph/ceph/pull/11351), Igor Fedotov)
-   bluestore: fix lack of resharding
    ([pr#11597](http://github.com/ceph/ceph/pull/11597), Igor Fedotov)
-   bluestore: fix latency calculation
    ([pr#12040](http://github.com/ceph/ceph/pull/12040), Pan Liu)
-   bluestore: fix onode vs extent key suffix
    ([pr#11452](http://github.com/ceph/ceph/pull/11452), Sage Weil)
-   bluestore: fix potential memory leak
    ([pr#11893](http://github.com/ceph/ceph/pull/11893), xie xingguo)
-   bluestore: fix race condtion during blob spliting
    ([pr#11422](http://github.com/ceph/ceph/pull/11422), xiexingguo, xie
    xingguo)
-   bluestore: fix remove_collection to properly detect collection e...
    ([pr#11398](http://github.com/ceph/ceph/pull/11398), Igor Fedotov)
-   bluestore: fix \_split_collections race with osr_reap
    ([pr#11748](http://github.com/ceph/ceph/pull/11748), Sage Weil)
-   bluestore: fix up compression tests and debug output
    ([pr#11350](http://github.com/ceph/ceph/pull/11350), Sage Weil)
-   bluestore: fix writes that span existing shard boundaries
    ([pr#11451](http://github.com/ceph/ceph/pull/11451), Sage Weil)
-   bluestore: flush before enumerating omap values
    ([issue#18140](http://tracker.ceph.com/issues/18140),
    [pr#12328](http://github.com/ceph/ceph/pull/12328), Sage Weil)
-   bluestore: formatting nits
    ([pr#11514](http://github.com/ceph/ceph/pull/11514), xie xingguo)
-   bluestore: fsck: fix omap_head check
    ([pr#11726](http://github.com/ceph/ceph/pull/11726), Sage Weil)
-   bluestore: GC infra refactor, more UTs and GC range calculation
    fixes ([pr#11482](http://github.com/ceph/ceph/pull/11482), Igor
    Fedotov)
-   bluestore: KernelDevice: fix race in aio_thread vs aio_wait
    ([issue#17824](http://tracker.ceph.com/issues/17824),
    [pr#12204](http://github.com/ceph/ceph/pull/12204), Sage Weil)
-   bluestore: kv: dump rocksdb stats
    ([pr#12287](http://github.com/ceph/ceph/pull/12287), Varada Kari,
    Jianpeng Ma, Sage Weil)
-   bluestore: kv/rocksdb: enable rocksdb write path breakdown
    ([pr#11696](http://github.com/ceph/ceph/pull/11696), Haodong Tang)
-   bluestore: kv/RocksDBStore: rename option
    ([pr#11769](http://github.com/ceph/ceph/pull/11769), Sage Weil)
-   bluestore: less code redundancy
    ([pr#11740](http://github.com/ceph/ceph/pull/11740), xie xingguo)
-   bluestore: make 2q cache kin/kout size tunable
    ([pr#11599](http://github.com/ceph/ceph/pull/11599), Haodong Tang)
-   bluestore: mark ops that can\'t tolerate ENOENT
    ([pr#12114](http://github.com/ceph/ceph/pull/12114), Sage Weil)
-   bluestore: mempool: changes for bitmap allocator
    ([pr#11922](http://github.com/ceph/ceph/pull/11922), Ramesh Chander)
-   bluestore: misc. fixes and cleanups
    ([pr#11964](http://github.com/ceph/ceph/pull/11964), xie xingguo)
-   bluestore: move bluefs into its own mempool
    ([pr#11834](http://github.com/ceph/ceph/pull/11834), Sage Weil)
-   bluestore: no garbage collection for uncompressed blobs
    ([pr#11539](http://github.com/ceph/ceph/pull/11539), Roushan Ali,
    Sage Weil)
-   bluestore: optional debug mode to identify aio stalls
    ([pr#11818](http://github.com/ceph/ceph/pull/11818), Sage Weil)
-   bluestore: os/bluestore: a few cleanups
    ([pr#11483](http://github.com/ceph/ceph/pull/11483), Sage Weil)
-   bluestore: os/bluestore: avoid resharding if the last shard size
    fall below shar...
    ([pr#12447](http://github.com/ceph/ceph/pull/12447), Igor Fedotov)
-   bluestore: os/bluestore: bitmap allocator dump functionality
    ([pr#12298](http://github.com/ceph/ceph/pull/12298), Ramesh Chander)
-   bluestore: os/bluestore: bluestore_sync_submit_transaction = false
    ([pr#12367](http://github.com/ceph/ceph/pull/12367), Sage Weil)
-   bluestore: os/bluestore: cleanup around <Blob::ref_map>
    ([pr#11896](http://github.com/ceph/ceph/pull/11896), Igor Fedotov)
-   bluestore: os/bluestore: clear omap flag if parent has none
    ([pr#12351](http://github.com/ceph/ceph/pull/12351), xie xingguo)
-   bluestore: os/bluestore: don\'t implicitly create the source object
    for clone ([pr#12353](http://github.com/ceph/ceph/pull/12353), xie
    xingguo)
-   bluestore: os/bluestore: drop old bluestore preconditioning; replace
    with wal preextension of file size
    ([pr#12265](http://github.com/ceph/ceph/pull/12265), Sage Weil)
-   bluestore: os/bluestore: fix global commit latency
    ([pr#12356](http://github.com/ceph/ceph/pull/12356), xie xingguo)
-   bluestore: os/bluestore: fix ondisk encoding for blobs
    ([pr#12488](http://github.com/ceph/ceph/pull/12488), Varada Kari,
    Sage Weil)
-   bluestore: os/bluestore: fix potential csum_order overflow
    ([pr#12333](http://github.com/ceph/ceph/pull/12333), xie xingguo)
-   bluestore: os/bluestore: fix target_buffer value overflow in
    Cache::trim() ([pr#12507](http://github.com/ceph/ceph/pull/12507),
    Igor Fedotov)
-   bluestore: os/bluestore: include modified objects in flush list even
    if onode unchanged
    ([pr#12541](http://github.com/ceph/ceph/pull/12541), Sage Weil)
-   bluestore: os/bluestore: kill dead gc-related counters
    ([pr#12065](http://github.com/ceph/ceph/pull/12065), xie xingguo)
-   bluestore: os/bluestore: kill overlay related options
    ([pr#11557](http://github.com/ceph/ceph/pull/11557), xie xingguo)
-   bluestore: os/bluestore: misc coverity fixes/cleanups
    ([pr#12202](http://github.com/ceph/ceph/pull/12202), Sage Weil)
-   bluestore: os/bluestore: preserve source collection cache during
    split ([pr#12574](http://github.com/ceph/ceph/pull/12574), Sage
    Weil)
-   bluestore: os/bluestore: remove \'extents\' from shard_info
    ([pr#12629](http://github.com/ceph/ceph/pull/12629), Sage Weil)
-   bluestore: os/bluestore: simplified allocator interfaces to single
    apis ([pr#12355](http://github.com/ceph/ceph/pull/12355), Ramesh
    Chander)
-   bluestore: os/bluestore: simplify allocator release flow
    ([pr#12343](http://github.com/ceph/ceph/pull/12343), Sage Weil)
-   bluestore: os/bluestore: simplify can_split_at()
    ([pr#11607](http://github.com/ceph/ceph/pull/11607), xie xingguo)
-   bluestore: os/bluestore: use iterator for erase() method directly
    ([pr#11490](http://github.com/ceph/ceph/pull/11490), xie xingguo)
-   bluestore: os/kstore: rmcoll fix to satisfy store_test
    ([pr#11533](http://github.com/ceph/ceph/pull/11533), Igor Fedotov)
-   bluestore: os: make filestore_blackhole -\> objectstore_blackhole
    ([pr#11788](http://github.com/ceph/ceph/pull/11788), Sage Weil)
-   bluestore: os: move_ranges_destroy_src
    ([pr#11237](http://github.com/ceph/ceph/pull/11237), Manali
    Kulkarni, Sage Weil)
-   bluestore: readability improvements and doxygen fix
    ([pr#11895](http://github.com/ceph/ceph/pull/11895), xie xingguo)
-   bluestore: reap collection after all pending ios done
    ([pr#11797](http://github.com/ceph/ceph/pull/11797), Haomai Wang)
-   bluestore: reap ioc when stopping aio_thread.
    ([pr#11811](http://github.com/ceph/ceph/pull/11811), Haodong Tang)
-   bluestore: refactor \_do_write(); move initializaiton of csum out of
    loop ([pr#11823](http://github.com/ceph/ceph/pull/11823), xie
    xingguo)
-   bluestore: remove duplicated namespace of tx state
    ([pr#11845](http://github.com/ceph/ceph/pull/11845), xie xingguo)
-   bluestore: remove garbage collector staff
    ([pr#12042](http://github.com/ceph/ceph/pull/12042), Igor Fedotov)
-   bluestore: set next object as ghobject_t::get_max() when
    start.hobj.i... ([pr#11495](http://github.com/ceph/ceph/pull/11495),
    Xinze Chi, Haomai Wang)
-   bluestore: simplify blob status checking for small writes
    ([pr#11366](http://github.com/ceph/ceph/pull/11366), xie xingguo)
-   bluestore: some more cleanups
    ([pr#11910](http://github.com/ceph/ceph/pull/11910), xie xingguo)
-   bluestore: spdk: a few fixes
    ([pr#11882](http://github.com/ceph/ceph/pull/11882), Yehuda Sadeh)
-   bluestore: speed up omap-key generation for same onode
    ([pr#11807](http://github.com/ceph/ceph/pull/11807), xie xingguo)
-   bluestore: traverse buffer_map in reverse order when spliting
    BufferSpace ([pr#11468](http://github.com/ceph/ceph/pull/11468), xie
    xingguo)
-   bluestore: update cache logger after \'trim_cache\' operation
    ([pr#11695](http://github.com/ceph/ceph/pull/11695), Haodong Tang)
-   bluestore: use bitmap allocator for bluefs
    ([pr#12285](http://github.com/ceph/ceph/pull/12285), Sage Weil)
-   bluestore: use std::unordered_map for SharedBlob lookup
    ([pr#11394](http://github.com/ceph/ceph/pull/11394), Sage Weil)
-   build/ops: AArch64: Detect crc32 extension support from assembler
    ([issue#17516](http://tracker.ceph.com/issues/17516),
    [pr#11391](http://github.com/ceph/ceph/pull/11391), Alexander Graf)
-   build/ops: boost: embedded
    ([pr#11817](http://github.com/ceph/ceph/pull/11817), Sage Weil, Matt
    Benjamin)
-   build/ops: build: dump env during build
    ([issue#18084](http://tracker.ceph.com/issues/18084),
    [pr#12284](http://github.com/ceph/ceph/pull/12284), Sage Weil)
-   build/ops: ceph-detect-init: FreeBSD introduction of bsdrc
    ([pr#11906](http://github.com/ceph/ceph/pull/11906), Willem Jan
    Withagen, Kefu Chai)
-   build/ops: ceph-disk: enable \--runtime ceph-osd systemd units
    ([issue#17889](http://tracker.ceph.com/issues/17889),
    [pr#12241](http://github.com/ceph/ceph/pull/12241), Loic Dachary)
-   build/ops: ceph.spec: add pybind rgwfile
    ([pr#11847](http://github.com/ceph/ceph/pull/11847), Haomai Wang)
-   build/ops,cleanup,bluestore: os/bluestore: remove build warning in a
    better way ([pr#11920](http://github.com/ceph/ceph/pull/11920), Igor
    Fedotov)
-   build/ops: CMakeLists: add vstart-base target
    ([pr#12476](http://github.com/ceph/ceph/pull/12476), Sage Weil)
-   build/ops: CMakeLists.txt: enable LTTNG by default
    ([pr#11500](http://github.com/ceph/ceph/pull/11500), Sage Weil)
-   build/ops: common/buffer.cc: raw_pipe depends on splice(2)
    ([pr#11967](http://github.com/ceph/ceph/pull/11967), Willem Jan
    Withagen)
-   build/ops,common: common/str_list.h: fix clang warning about
    std::move ([pr#12570](http://github.com/ceph/ceph/pull/12570),
    Willem Jan Withagen)
-   build/ops,core: xio: fix build
    ([pr#11768](http://github.com/ceph/ceph/pull/11768), Matt Benjamin)
-   build/ops: deb: add python dependencies where needed
    ([issue#17579](http://tracker.ceph.com/issues/17579),
    [pr#11507](http://github.com/ceph/ceph/pull/11507), Nathan Cutler,
    Kefu Chai)
-   build/ops: deb: add python-rgw packages
    ([pr#11832](http://github.com/ceph/ceph/pull/11832), Sage Weil)
-   build/ops: debian: apply dh_python to python-rgw also
    ([pr#12260](http://github.com/ceph/ceph/pull/12260), Kefu Chai)
-   build/ops: deb: update python-rgw dependencies to librgw2
    ([pr#11885](http://github.com/ceph/ceph/pull/11885), Casey Bodley)
-   build/ops: do_freebsd.sh: Build with SYSTEM Boost on FreeBSD
    ([pr#11942](http://github.com/ceph/ceph/pull/11942), Willem Jan
    Withagen)
-   build/ops: do_freebsd.sh: Do not use LTTNG on FreeBSD
    ([pr#11551](http://github.com/ceph/ceph/pull/11551), Willem Jan
    Withagen)
-   build/ops: do_freebsd.sh: Set options for debug building.
    ([pr#11443](http://github.com/ceph/ceph/pull/11443), Willem Jan
    Withagen)
-   build/ops: FreeBSD: do_freebsd.sh
    ([pr#12090](http://github.com/ceph/ceph/pull/12090), Willem Jan
    Withagen)
-   build/ops: FreeBSD:test/encoding/readable.sh\": fix nproc and ls -v
    calls ([pr#11522](http://github.com/ceph/ceph/pull/11522), Willem
    Jan Withagen)
-   build/ops: FreeBSD: update require packages
    ([pr#11512](http://github.com/ceph/ceph/pull/11512), Willem Jan
    Withagen)
-   build/ops: git-archive-all.sh: use an actually unique tmp dir
    ([pr#12011](http://github.com/ceph/ceph/pull/12011), Dan Mick)
-   build/ops: include/enc: make clang happy
    ([pr#11638](http://github.com/ceph/ceph/pull/11638), Kefu Chai, Sage
    Weil)
-   build/ops: install-deps.sh: allow building on SLES systems
    ([pr#11708](http://github.com/ceph/ceph/pull/11708), Nitin A Kamble)
-   build/ops: install-deps.sh: JQ is needed in one script
    ([pr#12080](http://github.com/ceph/ceph/pull/12080), Willem Jan
    Withagen)
-   build/ops: Log: Replace namespace log with logging
    ([pr#11650](http://github.com/ceph/ceph/pull/11650), Willem Jan
    Withagen)
-   build/ops: Merging before make check because it clearly breaks the
    build and the build part is done
    ([pr#11924](http://github.com/ceph/ceph/pull/11924), Sage Weil)
-   build/ops: ok, w/upstream acks, merging\--jenkins build did succeed
    (this is a build-only change)
    ([pr#12008](http://github.com/ceph/ceph/pull/12008), Matt Benjamin)
-   build/ops: qa: Add ceph-ansible installer.
    ([issue#16770](http://tracker.ceph.com/issues/16770),
    [pr#10402](http://github.com/ceph/ceph/pull/10402), Warren Usui)
-   build/ops: rocksdb: do not build with \--march=native
    ([pr#11677](http://github.com/ceph/ceph/pull/11677), Kefu Chai)
-   build/ops: rocksdb: update to latest
    ([pr#12100](http://github.com/ceph/ceph/pull/12100), Kefu Chai)
-   build/ops: rpm: Remove trailing whitespace in usermod command (SUSE)
    ([pr#10707](http://github.com/ceph/ceph/pull/10707), Tim Serong)
-   build/ops: scripts/release-notes: allow title guesses from gh tags &
    description update
    ([pr#11399](http://github.com/ceph/ceph/pull/11399), Abhishek
    Lekshmanan)
-   build/ops: systemd: Fix startup of ceph-mgr on Debian 8
    ([pr#12555](http://github.com/ceph/ceph/pull/12555), Mark Korenberg)
-   build/ops: tracing/objectstore.tp: add missing move_ranges\_\... tp
    ([pr#11484](http://github.com/ceph/ceph/pull/11484), Sage Weil)
-   build/ops: upstart: fix ceph-crush-location default
    ([issue#6698](http://tracker.ceph.com/issues/6698),
    [pr#803](http://github.com/ceph/ceph/pull/803), Jason Dillaman)
-   build/ops: upstart: start ceph-all after static-network-up
    ([issue#17689](http://tracker.ceph.com/issues/17689),
    [pr#11631](http://github.com/ceph/ceph/pull/11631), Billy Olsen)
-   cephfs: add gid to asok status
    ([pr#11487](http://github.com/ceph/ceph/pull/11487), Patrick
    Donnelly)
-   cephfs: API cleanup for libcephfs interfaces
    ([issue#17911](http://tracker.ceph.com/issues/17911),
    [pr#12106](http://github.com/ceph/ceph/pull/12106), Jeff Layton)
-   cephfs: ceph-fuse: start up log on parent process before shutdown
    ([issue#18157](http://tracker.ceph.com/issues/18157),
    [pr#12347](http://github.com/ceph/ceph/pull/12347), Greg Farnum)
-   cephfs: ceph_fuse: use sizeof get the buf length
    ([pr#11176](http://github.com/ceph/ceph/pull/11176), LeoZhang)
-   cephfs,cleanup: ceph-fuse: start up log on parent process before
    shutdown ([issue#18157](http://tracker.ceph.com/issues/18157),
    [pr#12358](http://github.com/ceph/ceph/pull/12358), Kefu Chai)
-   cephfs: client: add pid to metadata
    ([issue#17276](http://tracker.ceph.com/issues/17276),
    [pr#11359](http://github.com/ceph/ceph/pull/11359), Patrick
    Donnelly)
-   cephfs: client: Client.cc: remove duplicated op type checking
    against CEPH_MD...
    ([pr#11608](http://github.com/ceph/ceph/pull/11608), Weibing Zhang)
-   cephfs: client: don\'t take extra target inode reference in ll_link
    ([pr#11440](http://github.com/ceph/ceph/pull/11440), Jeff Layton)
-   cephfs: client: fix mutex name typos
    ([pr#12401](http://github.com/ceph/ceph/pull/12401), Yunchuan Wen)
-   cephfs: client: get caller\'s uid/gid on every libcephfs operation
    ([issue#17591](http://tracker.ceph.com/issues/17591),
    [pr#11526](http://github.com/ceph/ceph/pull/11526), Yan, Zheng)
-   cephfs: client: get gid from MonClient
    ([pr#11486](http://github.com/ceph/ceph/pull/11486), Patrick
    Donnelly)
-   cephfs: client: improve failure messages/debugging
    ([pr#12110](http://github.com/ceph/ceph/pull/12110), Patrick
    Donnelly)
-   cephfs: client/mds: Clear setuid bits when writing or truncating
    ([issue#18131](http://tracker.ceph.com/issues/18131),
    [pr#12412](http://github.com/ceph/ceph/pull/12412), Jeff Layton)
-   cephfs: client: put CapSnap not ptr in cap_snaps map
    ([pr#12111](http://github.com/ceph/ceph/pull/12111), Patrick
    Donnelly)
-   cephfs: client: remove redundant initialization
    ([pr#12028](http://github.com/ceph/ceph/pull/12028), Patrick
    Donnelly)
-   cephfs: client: remove unnecessary bufferptr\[\] for writev
    ([pr#11836](http://github.com/ceph/ceph/pull/11836), Patrick
    Donnelly)
-   cephfs: client: remove unneeded layout on MClientCaps
    ([pr#11790](http://github.com/ceph/ceph/pull/11790), John Spray)
-   cephfs: client: set metadata\[\"root\"\] from mount method when
    it\'s called with ...
    ([pr#12505](http://github.com/ceph/ceph/pull/12505), Jeff Layton)
-   cephfs: client: trim_caps() do not dereference cap if it\'s removed
    ([pr#12145](http://github.com/ceph/ceph/pull/12145), Kefu Chai)
-   cephfs: client: use unique_ptr
    ([pr#11837](http://github.com/ceph/ceph/pull/11837), Patrick
    Donnelly)
-   cephfs: common/ceph_string: add ceph string constants for
    CEPH_SESSION_FORCE_RO
    ([pr#11516](http://github.com/ceph/ceph/pull/11516), Zhi Zhang)
-   cephfs: Fix #17562 (backtrace check fails when scrubbing directory
    created by fsstress)
    ([issue#17562](http://tracker.ceph.com/issues/17562),
    [pr#11517](http://github.com/ceph/ceph/pull/11517), Yan, Zheng)
-   cephfs: fix missing ll_get for ll_walk
    ([issue#18086](http://tracker.ceph.com/issues/18086),
    [pr#12061](http://github.com/ceph/ceph/pull/12061), Gui Hecheng)
-   cephfs: get new fsmap after marking clusters down
    ([issue#7271](http://tracker.ceph.com/issues/7271),
    [issue#17894](http://tracker.ceph.com/issues/17894),
    [pr#1262](http://github.com/ceph/ceph/pull/1262), Patrick Donnelly)
-   cephfs: Have ceph clear setuid/setgid bits on chown
    ([issue#18131](http://tracker.ceph.com/issues/18131),
    [pr#12331](http://github.com/ceph/ceph/pull/12331), Jeff Layton)
-   cephfs: libcephfs: add ceph_fsetattr&&ceph_lchmod&&ceph_lutime
    ([pr#11191](http://github.com/ceph/ceph/pull/11191), huanwen ren)
-   cephfs: libcephfs: add readlink function in cephfs.pyx
    ([pr#12384](http://github.com/ceph/ceph/pull/12384), huanwen ren)
-   cephfs: libcephfs and test suite fixes
    ([issue#18013](http://tracker.ceph.com/issues/18013),
    [issue#17982](http://tracker.ceph.com/issues/17982),
    [pr#12228](http://github.com/ceph/ceph/pull/12228), Jeff Layton)
-   cephfs: libcephfs client API overhaul and update
    ([pr#11647](http://github.com/ceph/ceph/pull/11647), Jeff Layton)
-   cephfs: lua: use simpler lua_next traversal structure
    ([pr#11958](http://github.com/ceph/ceph/pull/11958), Patrick
    Donnelly)
-   cephfs: mds/Beacon: move C_MDS_BeaconSender class to .cc
    ([pr#10940](http://github.com/ceph/ceph/pull/10940), Michal
    Jarzabek)
-   cephfs: mds/CDir.cc: remove unneeded use of count
    ([pr#11613](http://github.com/ceph/ceph/pull/11613), Michal
    Jarzabek)
-   cephfs: mds/CInode.h: remove unneeded use of count
    ([pr#11371](http://github.com/ceph/ceph/pull/11371), Michal
    Jarzabek)
-   cephfs: mds/DamageTable.cc: move shared ptrs
    ([pr#11435](http://github.com/ceph/ceph/pull/11435), Michal
    Jarzabek)
-   cephfs: mds/DamageTable.cc: remove unneeded use of count
    ([pr#11625](http://github.com/ceph/ceph/pull/11625), Michal
    Jarzabek)
-   cephfs: mds/DamageTable: move classes to .cc file
    ([pr#11450](http://github.com/ceph/ceph/pull/11450), Michal
    Jarzabek)
-   cephfs: mds/flock: add const to member functions
    ([pr#11692](http://github.com/ceph/ceph/pull/11692), Michal
    Jarzabek)
-   cephfs: mds/FSMap.cc: remove unneeded use of count
    ([pr#11402](http://github.com/ceph/ceph/pull/11402), Michal
    Jarzabek)
-   cephfs: mds/FSMapUser.h: remove copy ctr and assign op
    ([pr#11509](http://github.com/ceph/ceph/pull/11509), Michal
    Jarzabek)
-   cephfs: mds/InfoTable.h: add override to virtual functs
    ([pr#11496](http://github.com/ceph/ceph/pull/11496), Michal
    Jarzabek)
-   cephfs: mds/InoTable.h: add override to virtual functs
    ([pr#11604](http://github.com/ceph/ceph/pull/11604), Michal
    Jarzabek)
-   cephfs: mds/Mantle.h: include correct header files
    ([pr#11886](http://github.com/ceph/ceph/pull/11886), Michal
    Jarzabek)
-   cephfs: mds/Mantle: pass parameters by const ref
    ([pr#11713](http://github.com/ceph/ceph/pull/11713), Michal
    Jarzabek)
-   cephfs: mds/MDCache.h: remove unneeded call to clear func
    ([pr#11954](http://github.com/ceph/ceph/pull/11954), Michal
    Jarzabek)
-   cephfs: mds/MDCache.h: remove unused functions
    ([pr#11908](http://github.com/ceph/ceph/pull/11908), Michal
    Jarzabek)
-   cephfs: mds/MDLog: add const to member functions
    ([pr#11663](http://github.com/ceph/ceph/pull/11663), Michal
    Jarzabek)
-   cephfs: mds/MDSMap.h: add const to member functions
    ([pr#11511](http://github.com/ceph/ceph/pull/11511), Michal
    Jarzabek)
-   cephfs: mds/MDSRank: add const to member functions
    ([pr#11752](http://github.com/ceph/ceph/pull/11752), Michal
    Jarzabek)
-   cephfs: mds/MDSRank.h: add override to virtual function
    ([pr#11727](http://github.com/ceph/ceph/pull/11727), Michal
    Jarzabek)
-   cephfs: mds/MDSRank.h: make destructor protected
    ([pr#11651](http://github.com/ceph/ceph/pull/11651), Michal
    Jarzabek)
-   cephfs: mds/MDSTableClient.h: add const to member funct
    ([pr#11681](http://github.com/ceph/ceph/pull/11681), Michal
    Jarzabek)
-   cephfs: mds/Migrator.cc: remove unneeded use of count
    ([pr#11523](http://github.com/ceph/ceph/pull/11523), Michal
    Jarzabek)
-   cephfs: mds/Migrator.h: add const to member functions
    ([pr#11819](http://github.com/ceph/ceph/pull/11819), Michal
    Jarzabek)
-   cephfs: mds/Migrator.h: remove unneeded use of count
    ([pr#11833](http://github.com/ceph/ceph/pull/11833), Michal
    Jarzabek)
-   cephfs: mds/Mutation.h: add const to member functions
    ([pr#11670](http://github.com/ceph/ceph/pull/11670), Michal
    Jarzabek)
-   cephfs: mds/Mutation.h: simplify constructors
    ([pr#11455](http://github.com/ceph/ceph/pull/11455), Michal
    Jarzabek)
-   cephfs: MDS: reduce usage of context wrapper
    ([pr#11560](http://github.com/ceph/ceph/pull/11560), Yan, Zheng)
-   cephfs: mds/ScrubHeader.h: pass string by const reference
    ([pr#11904](http://github.com/ceph/ceph/pull/11904), Michal
    Jarzabek)
-   cephfs: mds/server: merge the snapshot request judgment
    ([pr#11150](http://github.com/ceph/ceph/pull/11150), huanwen ren)
-   cephfs: mds/SessionMap: add const to member functions
    ([pr#11541](http://github.com/ceph/ceph/pull/11541), Michal
    Jarzabek)
-   cephfs: mds/SessionMap.cc: avoid copying and add const
    ([pr#11297](http://github.com/ceph/ceph/pull/11297), Michal
    Jarzabek)
-   cephfs: mds/SessionMap.cc:put classes in unnamed namespace
    ([pr#11316](http://github.com/ceph/ceph/pull/11316), Michal
    Jarzabek)
-   cephfs: mds/SessionMap.cc: remove unneeded use of count
    ([pr#11338](http://github.com/ceph/ceph/pull/11338), Michal
    Jarzabek)
-   cephfs: mds/SessionMap.h: remove unneeded function
    ([pr#11565](http://github.com/ceph/ceph/pull/11565), Michal
    Jarzabek)
-   cephfs: mds/SessionMap.h: remove unneeded use of count
    ([pr#11358](http://github.com/ceph/ceph/pull/11358), Michal
    Jarzabek)
-   cephfs: mds/SnapRealm: remove unneeded use of count
    ([pr#11609](http://github.com/ceph/ceph/pull/11609), Michal
    Jarzabek)
-   cephfs: mds/SnapServer.h: add override to virtual functs
    ([pr#11380](http://github.com/ceph/ceph/pull/11380), Michal
    Jarzabek)
-   cephfs: mds/SnapServer.h: add override to virtual functs
    ([pr#11583](http://github.com/ceph/ceph/pull/11583), Michal
    Jarzabek)
-   cephfs: mon/MDSMonitor: fix iterating over mutated map
    ([issue#18166](http://tracker.ceph.com/issues/18166),
    [pr#12395](http://github.com/ceph/ceph/pull/12395), John Spray)
-   cephfs: multimds: fix state check in
    Migrator::find_stale_export_freeze()
    ([pr#12098](http://github.com/ceph/ceph/pull/12098), Yan, Zheng)
-   cephfs: osdc: After write try merge bh.
    ([issue#17270](http://tracker.ceph.com/issues/17270),
    [pr#11545](http://github.com/ceph/ceph/pull/11545), Jianpeng Ma)
-   cephfs: Partial organization of mds/ header sections
    ([pr#11959](http://github.com/ceph/ceph/pull/11959), Patrick
    Donnelly)
-   cephfs: Port/bootstrap
    ([pr#827](http://github.com/ceph/ceph/pull/827), Yan, Zheng)
-   cephfs: Revert \"osdc: After write try merge bh.\"
    ([issue#17270](http://tracker.ceph.com/issues/17270),
    [pr#11262](http://github.com/ceph/ceph/pull/11262), John Spray)
-   cephfs: Small pile of random cephfs fixes and cleanup
    ([pr#11421](http://github.com/ceph/ceph/pull/11421), Jeff Layton)
-   cephfs: src/mds: fix MDSMap upgrade decoding
    ([issue#17837](http://tracker.ceph.com/issues/17837),
    [pr#12097](http://github.com/ceph/ceph/pull/12097), John Spray)
-   cephfs: systemd: add ceph-fuse service file
    ([pr#11542](http://github.com/ceph/ceph/pull/11542), Patrick
    Donnelly)
-   cephfs: test fragment size limit
    ([issue#16164](http://tracker.ceph.com/issues/16164),
    [pr#1069](http://github.com/ceph/ceph/pull/1069), Patrick Donnelly)
-   cephfs: test readahead is working
    ([issue#16024](http://tracker.ceph.com/issues/16024),
    [pr#1046](http://github.com/ceph/ceph/pull/1046), Patrick Donnelly)
-   cephfs: test: temporarily remove fork()ing flock tests
    ([issue#16556](http://tracker.ceph.com/issues/16556),
    [pr#11211](http://github.com/ceph/ceph/pull/11211), John Spray)
-   cephfs: tool/cephfs: displaying \"list\" in journal event mode
    ([pr#11236](http://github.com/ceph/ceph/pull/11236), huanwen ren)
-   cephfs: tools/cephfs: add pg_files command
    ([issue#17249](http://tracker.ceph.com/issues/17249),
    [pr#11026](http://github.com/ceph/ceph/pull/11026), John Spray)
-   cephfs: tools/cephfs: add scan_links command which fixes linkages
    errors ([pr#11446](http://github.com/ceph/ceph/pull/11446), Yan,
    Zheng)
-   cephfs: update tests to enable multimds when needed
    ([pr#933](http://github.com/ceph/ceph/pull/933), Greg Farnum)
-   cleanup: build: The Light Clangtastic
    ([pr#11921](http://github.com/ceph/ceph/pull/11921), Adam C.
    Emerson)
-   cleanup,common: common/blkdev: use realpath instead of readlink to
    resolve the recurs...
    ([pr#12462](http://github.com/ceph/ceph/pull/12462), Xinze Chi)
-   cleanup,common: common/throttle: simplify Throttle::\_wait()
    ([pr#11165](http://github.com/ceph/ceph/pull/11165), xie xingguo)
-   cleanup,common: src/common: remove nonused config option
    ([pr#12311](http://github.com/ceph/ceph/pull/12311), Wei Jin)
-   cleanup: coverity fix: fixing few coverity issue
    ([pr#9624](http://github.com/ceph/ceph/pull/9624), Gaurav Kumar
    Garg)
-   cleanup: deprecate readdir_r() with readdir()
    ([pr#11805](http://github.com/ceph/ceph/pull/11805), Kefu Chai)
-   cleanup: erasure-code: fix gf-complete warning
    ([pr#12150](http://github.com/ceph/ceph/pull/12150), Kefu Chai)
-   cleanup: fix typos
    ([pr#12502](http://github.com/ceph/ceph/pull/12502), xianxiaxiao)
-   cleanup: mds/FSMap.cc: prevent unneeded copy of map entry
    ([pr#11798](http://github.com/ceph/ceph/pull/11798), Michal
    Jarzabek)
-   cleanup: mds/FSMap.h: add const and reference
    ([pr#11802](http://github.com/ceph/ceph/pull/11802), Michal
    Jarzabek)
-   cleanup: mds/FSMap: pass shared_ptr by const ref
    ([pr#11383](http://github.com/ceph/ceph/pull/11383), Michal
    Jarzabek)
-   cleanup: mds/SnapServer: add const to member function
    ([pr#11688](http://github.com/ceph/ceph/pull/11688), Michal
    Jarzabek)
-   cleanup: mon/MonCap.h: add std::move for std::string
    ([pr#10722](http://github.com/ceph/ceph/pull/10722), Michal
    Jarzabek)
-   cleanup: mon/OSDMonitor: only show interesting flags in health
    warning ([issue#18175](http://tracker.ceph.com/issues/18175),
    [pr#12365](http://github.com/ceph/ceph/pull/12365), Sage Weil)
-   cleanup: msg/async: assert(0) -\> ceph_abort()
    ([pr#12339](http://github.com/ceph/ceph/pull/12339), Li Wang)
-   cleanup: msg/AsyncMessenger: remove unneeded include
    ([pr#9846](http://github.com/ceph/ceph/pull/9846), Michal Jarzabek)
-   cleanup: msg/async/rdma: fix disconnect log line
    ([pr#12254](http://github.com/ceph/ceph/pull/12254), Adir Lev)
-   cleanup: msg/async: remove unused member variable
    ([pr#12387](http://github.com/ceph/ceph/pull/12387), Kefu Chai)
-   cleanup: msg: fix format specifier for unsigned value id
    ([pr#11145](http://github.com/ceph/ceph/pull/11145), Weibing Zhang)
-   cleanup: msg/Pipe: move DelayedDelivery class to cc file
    ([pr#10447](http://github.com/ceph/ceph/pull/10447), Michal
    Jarzabek)
-   cleanup: msg/test: fix the guided compile-command to ceph_test_msgr
    ([pr#10490](http://github.com/ceph/ceph/pull/10490), Yan Jun)
-   cleanup: osd/PGBackend: build_push_op segment fault
    ([pr#9357](http://github.com/ceph/ceph/pull/9357), Zengran Zhang)
-   cleanup: osd/PG.h: change PGRecoveryStats struct to class
    ([pr#11178](http://github.com/ceph/ceph/pull/11178), Michal
    Jarzabek)
-   cleanup: osd/PG.h: remove unneeded forward declaration
    ([pr#12135](http://github.com/ceph/ceph/pull/12135), Li Wang)
-   cleanup: osd/ReplicatedPG: remove unneeded use of count
    ([pr#11251](http://github.com/ceph/ceph/pull/11251), Michal
    Jarzabek)
-   cleanup: os/filestore: clean filestore perfcounters
    ([pr#11524](http://github.com/ceph/ceph/pull/11524), Wei Jin)
-   cleanup: os/fs/FS.cc: condition on WITH_AIO for FreeBSD
    ([pr#11913](http://github.com/ceph/ceph/pull/11913), Willem Jan
    Withagen)
-   cleanup,rbd: cls_rbd: silence compiler warnings
    ([pr#11363](http://github.com/ceph/ceph/pull/11363), xiexingguo)
-   cleanup,rbd: journal: avoid logging an error when a watch is
    blacklisted ([issue#18243](http://tracker.ceph.com/issues/18243),
    [pr#12473](http://github.com/ceph/ceph/pull/12473), Jason Dillaman)
-   cleanup,rbd: journal: prevent repetitive error messages after being
    blacklisted ([issue#18243](http://tracker.ceph.com/issues/18243),
    [pr#12497](http://github.com/ceph/ceph/pull/12497), Jason Dillaman)
-   cleanup,rbd: librbd/ImageCtx: no need for virtual dtor
    ([pr#12220](http://github.com/ceph/ceph/pull/12220), Sage Weil)
-   cleanup,rbd: rbd-mirror: configuration overrides for hard coded
    timers ([pr#11840](http://github.com/ceph/ceph/pull/11840),
    Dongsheng Yang)
-   cleanup,rbd: rbd-mirror: set SEQUENTIAL and NOCACHE advise flags on
    image sync ([issue#17127](http://tracker.ceph.com/issues/17127),
    [pr#12280](http://github.com/ceph/ceph/pull/12280), Mykola Golub)
-   cleanup: remove unneeded forward declaration
    ([pr#12257](http://github.com/ceph/ceph/pull/12257), Li Wang,
    Yunchuan Wen)
-   cleanup: remove unused declaration
    ([pr#12466](http://github.com/ceph/ceph/pull/12466), Li Wang,
    Yunchuan Wen)
-   cleanup,rgw: rgw multisite: move lease up to RunBucketSync instead
    of child crs ([pr#11598](http://github.com/ceph/ceph/pull/11598),
    Casey Bodley)
-   cleanup,rgw: rgw/rest: don\'t print empty x-amz-request-id
    ([pr#10674](http://github.com/ceph/ceph/pull/10674), Marcus Watts)
-   cleanup,rgw: verified: f23
    ([pr#12103](http://github.com/ceph/ceph/pull/12103), Radoslaw
    Zarzynski)
-   cleanup: src/common/perf_counters.h: fix wrong word
    ([pr#11690](http://github.com/ceph/ceph/pull/11690), zhang.zezhu)
-   cleanup: Wip ctypos
    ([pr#12495](http://github.com/ceph/ceph/pull/12495), xianxiaxiao)
-   cleanup: xio: provide dout_prefix for XioConnection
    ([pr#9444](http://github.com/ceph/ceph/pull/9444), Avner BenHanoch)
-   cleanup: yasm-wrapper: translate \"-isystem \$1\" to \"-i \$1\"
    ([pr#12093](http://github.com/ceph/ceph/pull/12093), Kefu Chai)
-   cmake: add -Wno-unknown-pragmas to CMAKE_CXX_FLAGS
    ([pr#12128](http://github.com/ceph/ceph/pull/12128), Kefu Chai)
-   cmake: check WITH_RADOSGW for fcgi and expat dependencies
    ([pr#11481](http://github.com/ceph/ceph/pull/11481), David
    Disseldorp)
-   cmake: compile C code with c99
    ([pr#12369](http://github.com/ceph/ceph/pull/12369), Kefu Chai)
-   cmake: detect keyutils if WITH_LIBCEPHFS OR WITH_RBD
    ([pr#12359](http://github.com/ceph/ceph/pull/12359), Kefu Chai)
-   cmake: do not link erasure tests again libosd
    ([pr#11738](http://github.com/ceph/ceph/pull/11738), Kefu Chai)
-   cmake: find gperftools package for tcmalloc_minimal too
    ([pr#11403](http://github.com/ceph/ceph/pull/11403), Bassam Tabbara)
-   cmake: fix boost build on ubuntu 16.10 yakkety
    ([pr#12143](http://github.com/ceph/ceph/pull/12143), Bassam Tabbara)
-   cmake: Fix for cross compiling
    ([pr#11404](http://github.com/ceph/ceph/pull/11404), Bassam Tabbara)
-   cmake: fix git version string, cleanup
    ([pr#11661](http://github.com/ceph/ceph/pull/11661), Sage Weil)
-   cmake: librbd cleanup
    ([pr#11842](http://github.com/ceph/ceph/pull/11842), Kefu Chai)
-   cmake: link tests against static librados
    ([issue#17260](http://tracker.ceph.com/issues/17260),
    [pr#11575](http://github.com/ceph/ceph/pull/11575), Kefu Chai)
-   cmake: pass CMAKE_BUILD_TYPE down to rocksdb
    ([pr#11767](http://github.com/ceph/ceph/pull/11767), Kefu Chai)
-   cmake: remove include/Makefile.am
    ([pr#11666](http://github.com/ceph/ceph/pull/11666), Kefu Chai)
-   cmake: replace civetweb symlink w/file copy
    ([pr#11900](http://github.com/ceph/ceph/pull/11900), Matt Benjamin)
-   cmake: should link against \${ALLOC_LIBS}
    ([pr#11978](http://github.com/ceph/ceph/pull/11978), Kefu Chai)
-   cmake: src/test/CMakeLists.txt: Exclude test on HAVE_BLKID
    ([pr#12301](http://github.com/ceph/ceph/pull/12301), Willem Jan
    Withagen)
-   cmake: Support for embedding Ceph Daemons
    ([pr#11764](http://github.com/ceph/ceph/pull/11764), Bassam Tabbara)
-   cmake: use external project for rocksdb
    ([pr#11385](http://github.com/ceph/ceph/pull/11385), Bassam Tabbara)
-   common: Add throttle_get_started perf counter
    ([pr#12163](http://github.com/ceph/ceph/pull/12163), Bartłomiej
    Święcki)
-   common: assert(0) -\> ceph_abort()
    ([pr#12031](http://github.com/ceph/ceph/pull/12031), Sage Weil)
-   common: auth: fix NULL pointer access when trying to delete
    CryptoAESKeyHandler instance
    ([pr#11614](http://github.com/ceph/ceph/pull/11614), runsisi)
-   common,bluestore: compressor: fixes and tests; disable zlib isal
    (it\'s broken) ([pr#11349](http://github.com/ceph/ceph/pull/11349),
    Sage Weil)
-   common,bluestore: mempool: mempool infrastructure, bluestore changes
    to use it ([pr#11331](http://github.com/ceph/ceph/pull/11331), Allen
    Samuels, Sage Weil)
-   common: buffer: add advance(unsigned) back
    ([issue#17809](http://tracker.ceph.com/issues/17809),
    [pr#11993](http://github.com/ceph/ceph/pull/11993), Kefu Chai)
-   common: buffer: add copy(unsigned, ptr) back
    ([issue#17809](http://tracker.ceph.com/issues/17809),
    [pr#12246](http://github.com/ceph/ceph/pull/12246), Kefu Chai)
-   common: client/Client.cc: fix/silence \"logically dead code\"
    CID-Error ([pr#291](http://github.com/ceph/ceph/pull/291), Yehuda
    Sadeh)
-   common: common/strtol.cc: Get error testing also to work on FreeBSD
    ([pr#12034](http://github.com/ceph/ceph/pull/12034), Willem Jan
    Withagen)
-   common: fix clang compilation error
    ([pr#12565](http://github.com/ceph/ceph/pull/12565), Mykola Golub)
-   common: FreeBSD/EventKqueue.{h,cc} Added code to restore events on
    (thread)fork ([pr#11430](http://github.com/ceph/ceph/pull/11430),
    Willem Jan Withagen)
-   common: log/LogClient: fill seq & who for syslog and graylog
    ([issue#16609](http://tracker.ceph.com/issues/16609),
    [pr#10196](http://github.com/ceph/ceph/pull/10196), Xiaoxi Chen)
-   common: make l_finisher_complete_lat more accurate
    ([pr#11637](http://github.com/ceph/ceph/pull/11637), Pan Liu)
-   common: msg/simple/Accepter.cc: replace shutdown() with selfpipe
    event in poll() (FreeBSD)
    ([pr#10720](http://github.com/ceph/ceph/pull/10720), Willem Jan
    Withagen)
-   common: osdc/Objecter: fix relock race
    ([issue#17942](http://tracker.ceph.com/issues/17942),
    [pr#12234](http://github.com/ceph/ceph/pull/12234), Sage Weil)
-   common: osdc/Objecter: handle race between calc_target and
    handle_osd_map ([issue#17942](http://tracker.ceph.com/issues/17942),
    [pr#12055](http://github.com/ceph/ceph/pull/12055), Sage Weil)
-   common: osd/osdmap: fix divide by zero error
    ([pr#12521](http://github.com/ceph/ceph/pull/12521), Yunchuan Wen)
-   common: release g_ceph_context before returns
    ([issue#17762](http://tracker.ceph.com/issues/17762),
    [pr#11733](http://github.com/ceph/ceph/pull/11733), Kefu Chai)
-   common: Remove the runtime dependency on lsb_release
    ([issue#17425](http://tracker.ceph.com/issues/17425),
    [pr#11365](http://github.com/ceph/ceph/pull/11365), Brad Hubbard)
-   common: test/fio: fix global CephContext life cycle
    ([pr#12245](http://github.com/ceph/ceph/pull/12245), Igor Fedotov)
-   core: auth: tolerate missing MGR keys during upgrade
    ([pr#11401](http://github.com/ceph/ceph/pull/11401), Sage Weil)
-   core,bluestore: os/bluestore: fix warning and uninit variable
    ([pr#12032](http://github.com/ceph/ceph/pull/12032), Sage Weil)
-   core,bluestore: os: fix offsets for move_ranges operation
    ([pr#11595](http://github.com/ceph/ceph/pull/11595), Sage Weil)
-   core,bluestore: os: remove move_ranges_destroy_src
    ([pr#11791](http://github.com/ceph/ceph/pull/11791), Sage Weil)
-   core: ceph-disk: allow using a regular file as a journal
    ([issue#17662](http://tracker.ceph.com/issues/17662),
    [pr#11619](http://github.com/ceph/ceph/pull/11619), Jayashree
    Candadai, Loic Dachary)
-   core: ceph-disk: resolve race conditions
    ([issue#17889](http://tracker.ceph.com/issues/17889),
    [issue#17813](http://tracker.ceph.com/issues/17813),
    [pr#12136](http://github.com/ceph/ceph/pull/12136), Loic Dachary)
-   core,cephfs: osdc/ObjectCacher: wake up dirty stat waiters after
    removing buffers
    ([issue#17275](http://tracker.ceph.com/issues/17275),
    [pr#11593](http://github.com/ceph/ceph/pull/11593), Yan, Zheng)
-   core: ceph.in: allow \'flags\' to not be present in cmddescs
    ([issue#18297](http://tracker.ceph.com/issues/18297),
    [pr#12540](http://github.com/ceph/ceph/pull/12540), Dan Mick)
-   core,cleanup: ceph-disk: do not create bluestore wal/db partitions
    by default ([issue#18291](http://tracker.ceph.com/issues/18291),
    [pr#12531](http://github.com/ceph/ceph/pull/12531), Loic Dachary)
-   core,cleanup,common: common/TrackedOp: remove unused \'now\' in
    \_dump() ([pr#12007](http://github.com/ceph/ceph/pull/12007), John
    Spray)
-   core,cleanup: FileStore: Only verify split when it has been really
    done and done correctly
    ([pr#11731](http://github.com/ceph/ceph/pull/11731), Li Wang)
-   core,cleanup: kv: remove snapshot iterator
    ([pr#12049](http://github.com/ceph/ceph/pull/12049), Sage Weil)
-   core,cleanup: mon/MonClient.h: remove repeated searching of map
    ([pr#10601](http://github.com/ceph/ceph/pull/10601), Michal
    Jarzabek)
-   core,cleanup: msg: Fix typos in socket creation error message
    ([pr#11907](http://github.com/ceph/ceph/pull/11907), Brad Hubbard)
-   core,cleanup: osd/command tell: check pgid at the right time
    ([pr#11547](http://github.com/ceph/ceph/pull/11547), Javeme)
-   core,cleanup: osd/OSDMap.cc: fix duplicated assignment for
    new_blacklist_entries
    ([pr#11799](http://github.com/ceph/ceph/pull/11799), Ker Liu)
-   core,cleanup: osd/PG.cc: prevent repeated searching of map/set
    ([pr#11203](http://github.com/ceph/ceph/pull/11203), Michal
    Jarzabek)
-   core,cleanup: osd/ReplicatedPG: remove redundant check for
    balance/localize read
    ([pr#10209](http://github.com/ceph/ceph/pull/10209), runsisi)
-   core,cleanup: osd/ReplicatedPG: remove unneeded use of count
    ([pr#11242](http://github.com/ceph/ceph/pull/11242), Michal
    Jarzabek)
-   core,cleanup: os/filestore: handle EINTR returned by io_getevents()
    ([pr#11890](http://github.com/ceph/ceph/pull/11890), Pan Liu)
-   core,cleanup: os/ObjectStore: remove legacy tbl support
    ([pr#11770](http://github.com/ceph/ceph/pull/11770), Jianpeng Ma)
-   core,cleanup: scan build fixes
    ([pr#12148](http://github.com/ceph/ceph/pull/12148), Kefu Chai)
-   core,cleanup: src: rename ReplicatedPG to PrimaryLogPG
    ([pr#12487](http://github.com/ceph/ceph/pull/12487), Samuel Just)
-   core,cleanup: Wip scrub misc
    ([pr#11397](http://github.com/ceph/ceph/pull/11397), David Zafman)
-   core,common: buffer: put buffers in [buffer](){data,meta} mempools
    ([pr#11839](http://github.com/ceph/ceph/pull/11839), Sage Weil)
-   core,common: msg: add entity_addr_t types; add new entity_addrvec_t
    type ([pr#9825](http://github.com/ceph/ceph/pull/9825), Zhao
    Junwang, Sage Weil)
-   core,common: msg/simple/Pipe: handle addr decode error
    ([issue#18072](http://tracker.ceph.com/issues/18072),
    [pr#12221](http://github.com/ceph/ceph/pull/12221), Sage Weil)
-   core: compress: Fix compilation failure from missing header
    ([pr#12108](http://github.com/ceph/ceph/pull/12108), Adam C.
    Emerson)
-   core: denc: don\'t pass null instances into encoder fns
    ([issue#17636](http://tracker.ceph.com/issues/17636),
    [pr#11577](http://github.com/ceph/ceph/pull/11577), John Spray)
-   core: erasure-code: synchronize with upstream gf-complete
    ([issue#18092](http://tracker.ceph.com/issues/18092),
    [pr#12382](http://github.com/ceph/ceph/pull/12382), Loic Dachary)
-   core: FreeBSD/OSD.cc: add client_messenger to the avoid_ports set.
    ([pr#12463](http://github.com/ceph/ceph/pull/12463), Willem Jan
    Withagen)
-   core: include/object: pass \"snapid_t&\" to bound_encode()
    ([pr#11552](http://github.com/ceph/ceph/pull/11552), Kefu Chai)
-   core: kv/RocksDBStore: Don\'t update rocksdb perf_context if
    rocksdb_perf di...
    ([pr#12064](http://github.com/ceph/ceph/pull/12064), Jianpeng Ma)
-   core: librados-dev: install inline_memory.h
    ([issue#17654](http://tracker.ceph.com/issues/17654),
    [pr#11730](http://github.com/ceph/ceph/pull/11730), Josh Durgin)
-   core: messages/MForward: reencode forwarded message if target has
    differing features
    ([pr#11610](http://github.com/ceph/ceph/pull/11610), Sage Weil)
-   core,mgr: messages: fix out of range assertion
    ([pr#11345](http://github.com/ceph/ceph/pull/11345), John Spray)
-   core: mon,ceph-disk: add lockbox permissions to bootstrap-osd
    ([issue#17849](http://tracker.ceph.com/issues/17849),
    [pr#11996](http://github.com/ceph/ceph/pull/11996), Loic Dachary)
-   core: mon: make it more clearly to debug for paxos state
    ([pr#12438](http://github.com/ceph/ceph/pull/12438), song baisen)
-   core: mon/OSDMonitor: encode full osdmaps with features all OSDs can
    understand ([pr#11284](http://github.com/ceph/ceph/pull/11284), Sage
    Weil)
-   core: mon/OSDMonitor: encode OSDMap::Incremental with same features
    as OSDMap ([pr#11596](http://github.com/ceph/ceph/pull/11596), Sage
    Weil)
-   core: mon/OSDMonitor: newly created osd should not be wrongly marked
    in ([pr#11795](http://github.com/ceph/ceph/pull/11795), runsisi)
-   core: mon/OSDMonitor: remove duplicate jewel/kraken flag warning
    ([pr#11775](http://github.com/ceph/ceph/pull/11775), Josh Durgin)
-   core: mon/PGMap: PGs can be stuck more than one thing
    ([issue#17515](http://tracker.ceph.com/issues/17515),
    [pr#11339](http://github.com/ceph/ceph/pull/11339), Sage Weil)
-   core: mon: print the num_pools and num_objects in \'ceph -s -f
    json/json-p... ([issue#17703](http://tracker.ceph.com/issues/17703),
    [pr#11654](http://github.com/ceph/ceph/pull/11654), huangjun)
-   core: msg/async/AsyncConnection: dispatch write handler on
    keepalive2 ([issue#17664](http://tracker.ceph.com/issues/17664),
    [pr#11601](http://github.com/ceph/ceph/pull/11601), Ilya Dryomov)
-   core: msg/async: DPDKStack as AsyncMessenger backend
    ([pr#10748](http://github.com/ceph/ceph/pull/10748), Haomai Wang)
-   core: msg/async/rdma: change log level: 0 -\> 1
    ([pr#12334](http://github.com/ceph/ceph/pull/12334), Avner
    BenHanoch)
-   core: msg/async/rdma: don\'t use more buffers than what device
    capabilities ...
    ([pr#12263](http://github.com/ceph/ceph/pull/12263), Avner
    BenHanoch)
-   core: msg/async/rdma: ensure CephContext existed
    ([pr#12068](http://github.com/ceph/ceph/pull/12068), Haomai Wang)
-   core: msg/async/rdma: event polling thread can block on event
    ([pr#12270](http://github.com/ceph/ceph/pull/12270), Haomai Wang)
-   core: msg/async/rdma: fixup memory free
    ([pr#12236](http://github.com/ceph/ceph/pull/12236), gongchuang)
-   core: msg/async/rdma: set correct value to memory manager
    ([pr#12299](http://github.com/ceph/ceph/pull/12299), Adir Lev)
-   core: msg/async: set nonce before starting the workers
    ([pr#12390](http://github.com/ceph/ceph/pull/12390), Kefu Chai)
-   core: msg: make loopback Connection feature accurate all the time
    ([pr#11183](http://github.com/ceph/ceph/pull/11183), Sage Weil)
-   core: msg: seed random engine used for ms_type=\"random\"
    ([pr#11880](http://github.com/ceph/ceph/pull/11880), Casey Bodley)
-   core: msg/simple/Pipe: avoid returning 0 on poll timeout
    ([issue#18184](http://tracker.ceph.com/issues/18184),
    [pr#12375](http://github.com/ceph/ceph/pull/12375), Sage Weil)
-   core: msg/simple/Pipe::stop_and_wait: unlock pipe_lock for
    stop_fast_dispatching()
    ([issue#18042](http://tracker.ceph.com/issues/18042),
    [pr#12307](http://github.com/ceph/ceph/pull/12307), Samuel Just)
-   core: msg/simple: save the errno in case being changed by subsequent
    codes ([pr#10297](http://github.com/ceph/ceph/pull/10297), Yan Jun)
-   core: osd/ECTransaction: only write out the hinfo if not delete
    ([issue#17983](http://tracker.ceph.com/issues/17983),
    [pr#12141](http://github.com/ceph/ceph/pull/12141), Samuel Just)
-   core: OSDMonitor: only reject MOSDBoot based on up_from if inst
    matches ([issue#17899](http://tracker.ceph.com/issues/17899),
    [pr#12003](http://github.com/ceph/ceph/pull/12003), Samuel Just)
-   core: osd,mon: require sortbitwise flag to upgrade beyond jewel
    ([pr#11772](http://github.com/ceph/ceph/pull/11772), Sage Weil)
-   core: osd/osd_types: fix the osd_stat_t::decode()
    ([pr#12235](http://github.com/ceph/ceph/pull/12235), Kefu Chai)
-   core: osd/PG: add \"down\" pg state (distinct from down+peering)
    ([pr#12289](http://github.com/ceph/ceph/pull/12289), Sage Weil)
-   core: osd/PGLog::proc_replica_log,merge_log: fix bound for
    last_update ([issue#18127](http://tracker.ceph.com/issues/18127),
    [pr#12340](http://github.com/ceph/ceph/pull/12340), Samuel Just)
-   core: osd/ReplicatedPG: do_update_log_missing: take the pg lock in
    the callback ([issue#17789](http://tracker.ceph.com/issues/17789),
    [pr#11754](http://github.com/ceph/ceph/pull/11754), Samuel Just)
-   core: osd/ReplicatedPG::record_write_error: don\'t leak orig_reply
    on cancel ([issue#18180](http://tracker.ceph.com/issues/18180),
    [pr#12450](http://github.com/ceph/ceph/pull/12450), Samuel Just)
-   core: os/filestore: avoid to get the wrong hardlink number.
    ([pr#11841](http://github.com/ceph/ceph/pull/11841), huangjun)
-   core: os/filestore/chain_xattr.h:uses ENODATA, so include compat.h
    ([pr#12279](http://github.com/ceph/ceph/pull/12279), Willem Jan
    Withagen)
-   core: os/filestore: Fix erroneous WARNING: max attr too small
    ([issue#17420](http://tracker.ceph.com/issues/17420),
    [pr#11246](http://github.com/ceph/ceph/pull/11246), Brad Hubbard)
-   core: os/FileStore: fix fiemap issue in xfs when #extents \> 1364
    ([pr#11554](http://github.com/ceph/ceph/pull/11554), Ning Yao)
-   core: os/filestore: fix journal logger
    ([pr#12099](http://github.com/ceph/ceph/pull/12099), Wei Jin)
-   core: os/filestore: fix potential result code overwriting
    ([pr#11491](http://github.com/ceph/ceph/pull/11491), xie xingguo)
-   core: os/filestore/HashIndex: fix [list_by_hash]()\* termination on
    reaching end ([issue#17859](http://tracker.ceph.com/issues/17859),
    [pr#11898](http://github.com/ceph/ceph/pull/11898), Sage Weil)
-   core: os/ObjectStore: properly clear object map when replaying
    OP_REMOVE ([issue#17177](http://tracker.ceph.com/issues/17177),
    [pr#11388](http://github.com/ceph/ceph/pull/11388), Yan, Zheng)
-   core,performance: msg/async: ibverbs/rdma support
    ([pr#11531](http://github.com/ceph/ceph/pull/11531), Haomai Wang,
    Zhi Wang)
-   core,performance: osd/OSDMap.cc: remove unneeded use of count
    ([pr#11221](http://github.com/ceph/ceph/pull/11221), Michal
    Jarzabek)
-   core,performance: osd/PrimaryLogPG: don\'t truncate if we don\'t
    have to for WRITEFULL
    ([pr#12534](http://github.com/ceph/ceph/pull/12534), Samuel Just)
-   core,performance: os/fs/FS: optimize aio::pwritev which make caller
    provide length. ([pr#9062](http://github.com/ceph/ceph/pull/9062),
    Jianpeng Ma)
-   core,pybind,common: python-rados: implement new aio_execute
    ([pr#12140](http://github.com/ceph/ceph/pull/12140), Iain Buclaw)
-   core,rbd,bluestore,rgw,performance,cephfs: fast denc encoding
    ([pr#11027](http://github.com/ceph/ceph/pull/11027), Sage Weil)
-   core: remove spurious executable permissions on source code files
    ([pr#1061](http://github.com/ceph/ceph/pull/1061), Samuel Just)
-   core: ReplicatedPG::failed_push: release read lock on failure
    ([issue#17857](http://tracker.ceph.com/issues/17857),
    [pr#11914](http://github.com/ceph/ceph/pull/11914), Kefu Chai)
-   core: rocksdb: update to latest, and make it the default for the
    mons ([pr#11354](http://github.com/ceph/ceph/pull/11354), Sage Weil)
-   core: set dumpable flag after setuid
    ([issue#17650](http://tracker.ceph.com/issues/17650),
    [pr#11582](http://github.com/ceph/ceph/pull/11582), Patrick
    Donnelly)
-   core: systemd/ceph-disk: reduce ceph-disk flock contention
    ([issue#18049](http://tracker.ceph.com/issues/18049),
    [issue#13160](http://tracker.ceph.com/issues/13160),
    [pr#12200](http://github.com/ceph/ceph/pull/12200), David
    Disseldorp)
-   core: tchaikov ([issue#17713](http://tracker.ceph.com/issues/17713),
    [pr#11382](http://github.com/ceph/ceph/pull/11382), Haomai Wang)
-   core,tests: ceph_test_rados_api_tier: dump hitset that we fail to
    decode ([issue#17945](http://tracker.ceph.com/issues/17945),
    [pr#12057](http://github.com/ceph/ceph/pull/12057), Sage Weil)
-   core,tests: common osd: Improve scrub analysis,
    list-inconsistent-obj output and osd-scrub-repair test
    ([issue#18114](http://tracker.ceph.com/issues/18114),
    [pr#9613](http://github.com/ceph/ceph/pull/9613), Kefu Chai, David
    Zafman)
-   core,tests: test,cmake: turn unit.h into unit.cc to speed up
    compilation ([pr#12194](http://github.com/ceph/ceph/pull/12194),
    Kefu Chai)
-   core,tests: test/rados/list.cc: Memory leak in
    ceph_test_rados_api_list
    ([issue#18250](http://tracker.ceph.com/issues/18250),
    [pr#12479](http://github.com/ceph/ceph/pull/12479), Brad Hubbard)
-   core,tests: workunits/ceph-helpers.sh: Fixes for FreeBSD
    ([pr#12085](http://github.com/ceph/ceph/pull/12085), Willem Jan
    Withagen)
-   core,tools: Added append functionality to rados tool.
    ([pr#11036](http://github.com/ceph/ceph/pull/11036), Tomy Cheru)
-   core,tools: Tested-by: Huawen Ren \<<ren.huanwen@zte.com.cn>\>
    ([issue#17400](http://tracker.ceph.com/issues/17400),
    [pr#11276](http://github.com/ceph/ceph/pull/11276), Kefu Chai)
-   core,tools: vstart: decrease pool size if \<3 OSDs
    ([pr#11528](http://github.com/ceph/ceph/pull/11528), John Spray)
-   crush: make counting of choose_tries consistent
    ([issue#17229](http://tracker.ceph.com/issues/17229),
    [pr#10993](http://github.com/ceph/ceph/pull/10993), Vicente Cheng)
-   crush: remove the crush_lock
    ([pr#11830](http://github.com/ceph/ceph/pull/11830), Adam C.
    Emerson)
-   crush: Silence coverity warnings for test/crush/crush.cc
    ([pr#12436](http://github.com/ceph/ceph/pull/12436), Brad Hubbard)
-   doc: Add doc about osd scrub {during recoverymax}\| sleep}
    ([pr#12176](http://github.com/ceph/ceph/pull/12176), Paweł Sadowski)
-   doc: Add docs about looking up Monitors through DNS
    ([issue#14527](http://tracker.ceph.com/issues/14527),
    [pr#10852](http://github.com/ceph/ceph/pull/10852), Wido den
    Hollander)
-   doc: add docs for raw compression
    ([pr#12244](http://github.com/ceph/ceph/pull/12244), Casey Bodley)
-   doc: Add documentation about mon_allow_pool_delete before pool
    remove ([pr#11943](http://github.com/ceph/ceph/pull/11943), Wido den
    Hollander)
-   doc: add infernalis EOL date
    ([pr#11925](http://github.com/ceph/ceph/pull/11925), Ken Dreyer)
-   doc: adding changelog for v10.2.4
    ([pr#12346](http://github.com/ceph/ceph/pull/12346), Abhishek
    Lekshmanan)
-   doc: Add MON docs about pool flags and pool removal config settings
    ([pr#10853](http://github.com/ceph/ceph/pull/10853), Wido den
    Hollander)
-   doc: add python-rgw doc
    ([pr#11859](http://github.com/ceph/ceph/pull/11859), Kefu Chai)
-   doc: change the osd_max_backfills default to 1
    ([issue#17701](http://tracker.ceph.com/issues/17701),
    [pr#11658](http://github.com/ceph/ceph/pull/11658), huangjun)
-   doc: clarify file deletion from OSD restricted pool behaviour
    ([issue#17937](http://tracker.ceph.com/issues/17937),
    [pr#12054](http://github.com/ceph/ceph/pull/12054), David
    Disseldorp)
-   doc: clarify mds deactivate purpose
    ([pr#11957](http://github.com/ceph/ceph/pull/11957), Patrick
    Donnelly)
-   doc: common/Throttle: fix typo for BackoffThrottle
    ([pr#12129](http://github.com/ceph/ceph/pull/12129), Wei Jin)
-   doc: correcting the object name
    ([pr#12354](http://github.com/ceph/ceph/pull/12354), Uday Mullangi)
-   doc: Correcting the sample python tempurl generation script.
    ([issue#15258](http://tracker.ceph.com/issues/15258),
    [pr#8712](http://github.com/ceph/ceph/pull/8712), Diwakar Goel)
-   doc: Coverity and SCA fixes
    ([pr#7784](http://github.com/ceph/ceph/pull/7784), Danny Al-Gaaf)
-   doc: doc/dev/osd_internals: add pgpool.rst
    ([pr#12500](http://github.com/ceph/ceph/pull/12500), Brad Hubbard)
-   doc: doc/dev/perf: a few notes on perf
    ([pr#12168](http://github.com/ceph/ceph/pull/12168), Sage Weil)
-   doc: doc/dev/perf: fix dittography
    ([pr#12317](http://github.com/ceph/ceph/pull/12317), xie xingguo)
-   doc: doc/man: avoid file builtin to solve build error
    ([pr#11984](http://github.com/ceph/ceph/pull/11984), Patrick
    Donnelly)
-   doc: doc/rados/configuration/ms-ref.rst: document a few async msgr
    options ([pr#12126](http://github.com/ceph/ceph/pull/12126), Piotr
    Dałek)
-   doc: doc/rados/configuration/osd-config-ref.rst: document the fast
    mark down ([pr#12124](http://github.com/ceph/ceph/pull/12124), Piotr
    Dałek)
-   doc: doc/release-notes: kraken release notes (draft)
    ([pr#12338](http://github.com/ceph/ceph/pull/12338), Sage Weil)
-   doc: doc/releases: add links to kraken and v10.2.4
    ([pr#12409](http://github.com/ceph/ceph/pull/12409), Kefu Chai)
-   doc: doc/start/hardware-recommentdations: cosmetic
    ([pr#10585](http://github.com/ceph/ceph/pull/10585), Zhao Junwang)
-   doc: Documentation syntax cleanup
    ([pr#11784](http://github.com/ceph/ceph/pull/11784), John Spray)
-   doc: document osd tell bench
    ([issue#5431](http://tracker.ceph.com/issues/5431),
    [pr#16](http://github.com/ceph/ceph/pull/16), Sage Weil)
-   doc: drop \--journal-check from ceph-mds man page
    ([issue#17747](http://tracker.ceph.com/issues/17747),
    [pr#11912](http://github.com/ceph/ceph/pull/11912), Nathan Cutler)
-   doc: explain rgw_fcgi_socket_backlog in rgw/config-ref.rst
    ([pr#12548](http://github.com/ceph/ceph/pull/12548), liuchang0812)
-   doc: final additions to 11.1.0-rc release notes
    ([pr#12448](http://github.com/ceph/ceph/pull/12448), Abhishek
    Lekshmanan)
-   doc: Fix broken link for caps
    ([issue#17587](http://tracker.ceph.com/issues/17587),
    [pr#11546](http://github.com/ceph/ceph/pull/11546), Uday Mullangi)
-   doc: fix broken links
    ([issue#17587](http://tracker.ceph.com/issues/17587),
    [pr#11518](http://github.com/ceph/ceph/pull/11518), Uday Mullangi)
-   doc: fix dead link \"Hardware Recommendations\"
    ([pr#11379](http://github.com/ceph/ceph/pull/11379), Leo Zhang)
-   doc: fix dead link of \"os-recommendations\" in troubleshooting-osd
    ([pr#11454](http://github.com/ceph/ceph/pull/11454), Leo Zhang)
-   doc: Fixed mapping error in legacy mds command
    ([pr#11668](http://github.com/ceph/ceph/pull/11668), Malte Fiala)
-   doc: Fix for worker arguments to cephfs-data-scan tool
    ([pr#12360](http://github.com/ceph/ceph/pull/12360), Wido den
    Hollander)
-   doc: fix grammar/spelling in RGW sections
    ([pr#12329](http://github.com/ceph/ceph/pull/12329), Ken Dreyer)
-   doc: Fixing the broken hyperlinks by pointing to correct
    documentation. ([pr#11617](http://github.com/ceph/ceph/pull/11617),
    Uday Mullangi)
-   doc: fix librados example programs
    ([pr#11302](http://github.com/ceph/ceph/pull/11302), Alexey
    Sheplyakov)
-   doc: fix mgr literal block rST syntax
    ([pr#11652](http://github.com/ceph/ceph/pull/11652), Ken Dreyer)
-   doc: fix start development cluster operation in index.rst
    ([pr#11233](http://github.com/ceph/ceph/pull/11233), Leo Zhang)
-   doc: fix the script for rebuild monitor db
    ([pr#11962](http://github.com/ceph/ceph/pull/11962), Kefu Chai)
-   doc: fix typos ([pr#8751](http://github.com/ceph/ceph/pull/8751), Li
    Peng)
-   doc: Flag deprecated mds commands and omit deprecated mon commands
    in help output ([pr#11434](http://github.com/ceph/ceph/pull/11434),
    Patrick Donnelly)
-   doc: mailmap: change personal info
    ([pr#12310](http://github.com/ceph/ceph/pull/12310), Wei Jin)
-   doc: mailmap updates sept
    ([pr#10955](http://github.com/ceph/ceph/pull/10955), Yann Dupont)
-   doc: mds: fixup \"mds bal mode\" Description
    ([pr#12127](http://github.com/ceph/ceph/pull/12127), huanwen ren)
-   doc: mention corresponding libvirt section in nova.conf
    ([pr#12584](http://github.com/ceph/ceph/pull/12584), Marc Koderer)
-   doc: Modify documentation for mon_osd_down_out_interval
    ([pr#12408](http://github.com/ceph/ceph/pull/12408), Brad Hubbard)
-   doc: network-protocol typos
    ([pr#9837](http://github.com/ceph/ceph/pull/9837), Zhao Junwang)
-   doc: openstack glance mitaka uses show_multiple_locations
    ([pr#12020](http://github.com/ceph/ceph/pull/12020), Sébastien Han)
-   doc: README.FreeBSD: update to match the bimonthly FreeBSD status
    report ([pr#11442](http://github.com/ceph/ceph/pull/11442), Willem
    Jan Withagen)
-   doc: README: hint at where to look to diagnose test failures
    ([pr#11903](http://github.com/ceph/ceph/pull/11903), Dan Mick)
-   doc: reformat SubmittingPatches with more rst syntax
    ([pr#11570](http://github.com/ceph/ceph/pull/11570), Kefu Chai)
-   doc: release notes for 10.2.4
    ([pr#12053](http://github.com/ceph/ceph/pull/12053), Abhishek
    Lekshmanan)
-   doc: release notes for 10.2.5
    ([issue#18207](http://tracker.ceph.com/issues/18207),
    [pr#12410](http://github.com/ceph/ceph/pull/12410), Loic Dachary)
-   doc: release notes for 11.0.2
    ([pr#11369](http://github.com/ceph/ceph/pull/11369), Abhishek
    Lekshmanan)
-   doc: Remove duplicate command for Ubuntu
    ([pr#12186](http://github.com/ceph/ceph/pull/12186), chrone)
-   doc: reviewed-by: John Wilkins \<<jowilkin@redhat.com>\>
    ([issue#17526](http://tracker.ceph.com/issues/17526),
    [pr#11352](http://github.com/ceph/ceph/pull/11352), Loic Dachary)
-   doc: reviewed-by: John Wilkins \<<jowilkin@redhat.com>\>
    ([issue#17665](http://tracker.ceph.com/issues/17665),
    [pr#11602](http://github.com/ceph/ceph/pull/11602), Jason Dillaman)
-   doc: rgw: fix a typo in S3 java api example
    ([pr#11762](http://github.com/ceph/ceph/pull/11762), Weibing Zhang)
-   doc: rm \"type=rpm-md\" from yum repositories
    ([pr#10248](http://github.com/ceph/ceph/pull/10248), Ken Dreyer)
-   doc: Small styling fix to mirror documentation
    ([pr#9714](http://github.com/ceph/ceph/pull/9714), Wido den
    Hollander)
-   doc: src/doc: fix class names in exports.txt
    ([pr#12000](http://github.com/ceph/ceph/pull/12000), John Spray)
-   doc: standardize EPEL instructions
    ([pr#11653](http://github.com/ceph/ceph/pull/11653), Ken Dreyer)
-   doc: update cinder key permissions for mitaka
    ([pr#12211](http://github.com/ceph/ceph/pull/12211), Sébastien Han)
-   doc: Update crush-map.rst, fix a typo mistake
    ([pr#11785](http://github.com/ceph/ceph/pull/11785), whu_liuchang)
-   doc: Update filestore xattr config documentation.
    ([pr#11826](http://github.com/ceph/ceph/pull/11826), Bartłomiej
    Święcki)
-   doc: Update install-ceph-gateway.rst
    ([pr#11432](http://github.com/ceph/ceph/pull/11432), Hans van den
    Bogert)
-   doc: Update keystone doc about v3 options
    ([pr#11392](http://github.com/ceph/ceph/pull/11392), Proskurin
    Kirill)
-   doc: Update layout.rst, move commands to CODE block
    ([pr#11987](http://github.com/ceph/ceph/pull/11987), liuchang0812)
-   doc: we can now run multiple MDS, so qualify warning
    ([issue#18040](http://tracker.ceph.com/issues/18040),
    [pr#12184](http://github.com/ceph/ceph/pull/12184), Nathan Cutler)
-   fs: add snapshot tests to mds thrashing
    ([pr#1073](http://github.com/ceph/ceph/pull/1073), Yan, Zheng)
-   fs: enable ceph-fuse permission checking for all pjd suites
    ([pr#1187](http://github.com/ceph/ceph/pull/1187), Greg Farnum)
-   fs: fix two frag_enable fragments
    ([issue#6143](http://tracker.ceph.com/issues/6143),
    [pr#656](http://github.com/ceph/ceph/pull/656), Sage Weil)
-   fs: fix up dd testing again
    ([issue#10861](http://tracker.ceph.com/issues/10861),
    [pr#373](http://github.com/ceph/ceph/pull/373), Greg Farnum)
-   fs: fuse_default_permissions = 0 for kernel build test
    ([pr#1109](http://github.com/ceph/ceph/pull/1109), Patrick Donnelly)
-   fs: Mantle: A Programmable Metadata Load Balancer
    ([pr#10887](http://github.com/ceph/ceph/pull/10887), Michael
    Sevilla)
-   fs: unify common parts of sub-suites
    ([issue#1737](http://tracker.ceph.com/issues/1737),
    [pr#1282](http://github.com/ceph/ceph/pull/1282), Patrick Donnelly)
-   librados: Add rados_aio_exec to the C API
    ([pr#11709](http://github.com/ceph/ceph/pull/11709), Iain Buclaw)
-   librados: add timeout to watch/notify
    ([pr#11378](http://github.com/ceph/ceph/pull/11378), Ryne Li)
-   librados: do not request osd ack if no completed completion is set
    ([pr#11204](http://github.com/ceph/ceph/pull/11204), Sage Weil)
-   librados: For C-API, expose LIBRADOS_OPERATION_FULL_FORCE flag
    ([pr#9172](http://github.com/ceph/ceph/pull/9172), Jianpeng Ma)
-   librados: improvements async IO in librados and libradosstriper
    ([pr#10049](http://github.com/ceph/ceph/pull/10049), Sebastien
    Ponce)
-   librados: Memory leaks in object_list_begin and object_list_end
    ([issue#18252](http://tracker.ceph.com/issues/18252),
    [pr#12482](http://github.com/ceph/ceph/pull/12482), Brad Hubbard)
-   librados: postpone cct deletion
    ([pr#11659](http://github.com/ceph/ceph/pull/11659), Kefu Chai)
-   librados: remove new setxattr overload to avoid breaking the C++ ABI
    ([issue#18058](http://tracker.ceph.com/issues/18058),
    [pr#12206](http://github.com/ceph/ceph/pull/12206), Josh Durgin)
-   librados: remove unused bufferlist from rados_write_op_rmxattr
    ([pr#12030](http://github.com/ceph/ceph/pull/12030), Piotr Dałek)
-   librbd: add support for snapshot namespaces
    ([pr#11160](http://github.com/ceph/ceph/pull/11160), Victor Denisov)
-   librbd: API changes to support separate data pool
    ([pr#11353](http://github.com/ceph/ceph/pull/11353), Jason Dillaman)
-   librbd: batch object map updates during trim
    ([issue#17356](http://tracker.ceph.com/issues/17356),
    [pr#11510](http://github.com/ceph/ceph/pull/11510), Venky Shankar)
-   librbd: bug fixes for optional data pool support
    ([pr#11960](http://github.com/ceph/ceph/pull/11960), Venky Shankar)
-   librbd: cannot access non-primary image when mirroring force
    disabled ([issue#16740](http://tracker.ceph.com/issues/16740),
    [issue#17588](http://tracker.ceph.com/issues/17588),
    [pr#11568](http://github.com/ceph/ceph/pull/11568), Jason Dillaman)
-   librbd: cls_rbd updates for separate data pool
    ([issue#17422](http://tracker.ceph.com/issues/17422),
    [pr#11327](http://github.com/ceph/ceph/pull/11327), Jason Dillaman)
-   librbd: default features should be negotiated with the OSD
    ([issue#17010](http://tracker.ceph.com/issues/17010),
    [pr#11808](http://github.com/ceph/ceph/pull/11808), Mykola Golub)
-   librbd: diffs to clone\'s first snapshot should include parent diffs
    ([issue#18068](http://tracker.ceph.com/issues/18068),
    [pr#12218](http://github.com/ceph/ceph/pull/12218), Jason Dillaman)
-   librbd: do not create empty object map object on image creation
    ([issue#17752](http://tracker.ceph.com/issues/17752),
    [pr#11704](http://github.com/ceph/ceph/pull/11704), Jason Dillaman)
-   librbd: enabling/disabling rbd feature should report missing
    dependency ([issue#16985](http://tracker.ceph.com/issues/16985),
    [pr#12238](http://github.com/ceph/ceph/pull/12238), Gaurav Kumar
    Garg)
-   librbd: ensure consistency groups will gracefully fail on older OSDs
    ([pr#11623](http://github.com/ceph/ceph/pull/11623), Jason Dillaman)
-   librbd: exclusive lock incorrectly initialized when switching to
    head revision ([issue#17618](http://tracker.ceph.com/issues/17618),
    [pr#11559](http://github.com/ceph/ceph/pull/11559), Jason Dillaman)
-   librbd: fix rollback if failed to disable mirroring for image
    ([pr#11260](http://github.com/ceph/ceph/pull/11260), runsisi)
-   librbd: ignore error when object map is already locked by current
    client ([issue#16179](http://tracker.ceph.com/issues/16179),
    [pr#12484](http://github.com/ceph/ceph/pull/12484), runsisi)
-   librbd: ignore notify errors on missing image header
    ([issue#17549](http://tracker.ceph.com/issues/17549),
    [pr#11395](http://github.com/ceph/ceph/pull/11395), Jason Dillaman)
-   librbd: keep rbd_default_features setting as bitmask
    ([issue#18247](http://tracker.ceph.com/issues/18247),
    [pr#12486](http://github.com/ceph/ceph/pull/12486), Jason Dillaman)
-   librbd: mark request as finished after failed refresh
    ([issue#17973](http://tracker.ceph.com/issues/17973),
    [pr#12160](http://github.com/ceph/ceph/pull/12160), Venky Shankar)
-   librbd: minor cleanup
    ([pr#12078](http://github.com/ceph/ceph/pull/12078), Dongsheng Yang)
-   librbd: new API method to force break a peer\'s exclusive lock
    ([issue#18429](http://tracker.ceph.com/issues/18429),
    [issue#16988](http://tracker.ceph.com/issues/16988),
    [issue#18327](http://tracker.ceph.com/issues/18327),
    [pr#12889](http://github.com/ceph/ceph/pull/12889), Jason Dillaman)
-   librbd: parse rbd_default_features config option as a string
    ([pr#11175](http://github.com/ceph/ceph/pull/11175), Alyona
    Kiseleva, Alexey Sheplyakov)
-   librbd: possible assert failure creating image when using data pool
    ([pr#11641](http://github.com/ceph/ceph/pull/11641), Venky Shankar)
-   librbd: proper check for get_data_pool compatibility
    ([issue#17791](http://tracker.ceph.com/issues/17791),
    [pr#11755](http://github.com/ceph/ceph/pull/11755), Mykola Golub)
-   librbd: properly order concurrent updates to the object map
    ([issue#16176](http://tracker.ceph.com/issues/16176),
    [pr#12420](http://github.com/ceph/ceph/pull/12420), Jason Dillaman)
-   librbd: release lock after demote
    ([issue#17880](http://tracker.ceph.com/issues/17880),
    [pr#11940](http://github.com/ceph/ceph/pull/11940), Mykola Golub)
-   librbd: remove consistency group rbd cli and API support
    ([issue#18231](http://tracker.ceph.com/issues/18231),
    [pr#12475](http://github.com/ceph/ceph/pull/12475), Jason Dillaman)
-   librbd: remove image header lock assertions
    ([issue#18244](http://tracker.ceph.com/issues/18244),
    [pr#12472](http://github.com/ceph/ceph/pull/12472), Jason Dillaman)
-   librbd: remove unused local variable
    ([pr#12388](http://github.com/ceph/ceph/pull/12388), Yunchuan Wen)
-   librbd: silence the unused variable warning
    ([pr#11678](http://github.com/ceph/ceph/pull/11678), Kefu Chai)
-   librbd: snap_get_limit compatibility check
    ([pr#11766](http://github.com/ceph/ceph/pull/11766), Mykola Golub)
-   librbd: update internals to use optional separate data pool
    ([pr#11356](http://github.com/ceph/ceph/pull/11356), Jason Dillaman)
-   librbd: use proper snapshot when computing diff parent overlap
    ([issue#18200](http://tracker.ceph.com/issues/18200),
    [pr#12396](http://github.com/ceph/ceph/pull/12396), Xiaoxi Chen)
-   log: optimize header file dependency
    ([pr#9768](http://github.com/ceph/ceph/pull/9768), Xiaowei Chen)
-   mds: add debug assertion for issue #17636
    ([pr#11576](http://github.com/ceph/ceph/pull/11576), Yan, Zheng)
-   mds: add tests for mantle (programmable balancer)
    ([pr#1145](http://github.com/ceph/ceph/pull/1145), Michael Sevilla)
-   mds: check if down mds is known
    ([issue#17670](http://tracker.ceph.com/issues/17670),
    [pr#11611](http://github.com/ceph/ceph/pull/11611), Patrick
    Donnelly)
-   mds: don\'t access mdsmap from log submit thread
    ([issue#18047](http://tracker.ceph.com/issues/18047),
    [pr#12208](http://github.com/ceph/ceph/pull/12208), Yan, Zheng)
-   mds: don\'t maintain bloom filters in standby replay
    ([issue#16924](http://tracker.ceph.com/issues/16924),
    [pr#12133](http://github.com/ceph/ceph/pull/12133), John Spray)
-   mds: enable rmxattr on pool_namespace attrs
    ([issue#17797](http://tracker.ceph.com/issues/17797),
    [pr#11783](http://github.com/ceph/ceph/pull/11783), John Spray)
-   mds: fix dropping events in standby replay
    ([issue#17954](http://tracker.ceph.com/issues/17954),
    [pr#12077](http://github.com/ceph/ceph/pull/12077), John Spray)
-   mds: fix EMetaBlob::fullbit xattr dump
    ([pr#11536](http://github.com/ceph/ceph/pull/11536), Sage Weil)
-   mds: fix false \"failing to respond to cache pressure\" warning
    ([pr#11373](http://github.com/ceph/ceph/pull/11373), Yan, Zheng)
-   mds: force client flush snap data before truncating objects
    ([issue#17193](http://tracker.ceph.com/issues/17193),
    [pr#11994](http://github.com/ceph/ceph/pull/11994), Yan, Zheng)
-   mds: handle bad standby_for_fscids in fsmap
    ([issue#17466](http://tracker.ceph.com/issues/17466),
    [pr#11281](http://github.com/ceph/ceph/pull/11281), John Spray)
-   mds: ignore \'session evict\' when mds is replaying log
    ([issue#17801](http://tracker.ceph.com/issues/17801),
    [pr#11813](http://github.com/ceph/ceph/pull/11813), Yan, Zheng)
-   mds: include legacy client fsid in FSMap print
    ([pr#11283](http://github.com/ceph/ceph/pull/11283), John Spray)
-   mds: more deterministic timing on frag split/join
    ([issue#17853](http://tracker.ceph.com/issues/17853),
    [pr#12022](http://github.com/ceph/ceph/pull/12022), John Spray)
-   mds: more unique_pointer changes
    ([pr#11635](http://github.com/ceph/ceph/pull/11635), Patrick
    Donnelly)
-   mds: properly commit new dirfrag before splitting it
    ([issue#17990](http://tracker.ceph.com/issues/17990),
    [pr#12125](http://github.com/ceph/ceph/pull/12125), Yan, Zheng)
-   mds: release pool allocator memory after exceeding size limit
    ([issue#18225](http://tracker.ceph.com/issues/18225),
    [pr#12443](http://github.com/ceph/ceph/pull/12443), John Spray)
-   mds: remove duplicated log in handle_client_readdir
    ([pr#11806](http://github.com/ceph/ceph/pull/11806), Zhi Zhang)
-   mds: remove \"\--journal-check\" help text
    ([issue#17747](http://tracker.ceph.com/issues/17747),
    [pr#11739](http://github.com/ceph/ceph/pull/11739), Nathan Cutler)
-   mds: remove unused EFragment::OP_ONESHOT
    ([pr#11887](http://github.com/ceph/ceph/pull/11887), John Spray)
-   mds: repair backtraces during scrub
    ([issue#17639](http://tracker.ceph.com/issues/17639),
    [pr#11578](http://github.com/ceph/ceph/pull/11578), John Spray)
-   mds: require MAY_SET_POOL to set pool_ns
    ([issue#17798](http://tracker.ceph.com/issues/17798),
    [pr#11789](http://github.com/ceph/ceph/pull/11789), John Spray)
-   mds: respawn using /proc/self/exe
    ([issue#17531](http://tracker.ceph.com/issues/17531),
    [pr#11362](http://github.com/ceph/ceph/pull/11362), Patrick
    Donnelly)
-   mds: revert \"mds/Mutation: remove redundant \_dump method\"
    ([issue#17906](http://tracker.ceph.com/issues/17906),
    [pr#11985](http://github.com/ceph/ceph/pull/11985), Patrick
    Donnelly)
-   mds: use parse_filesystem in parse_role to handle exceptions and
    reuse parsing code
    ([issue#17518](http://tracker.ceph.com/issues/17518),
    [pr#11357](http://github.com/ceph/ceph/pull/11357), Patrick
    Donnelly)
-   mds: use projected path construction for access
    ([issue#17858](http://tracker.ceph.com/issues/17858),
    [pr#12063](http://github.com/ceph/ceph/pull/12063), Patrick
    Donnelly)
-   mds: use unique_ptr to simplify resource mgmt
    ([pr#11543](http://github.com/ceph/ceph/pull/11543), Patrick
    Donnelly)
-   mgr: doc/mgr: fix mgr how long to wait to failover
    ([pr#11550](http://github.com/ceph/ceph/pull/11550), huanwen ren)
-   mgr: init() return when connection daemons failed && add some err
    info ([pr#11424](http://github.com/ceph/ceph/pull/11424), huanwen
    ren)
-   mgr: misc minor changes
    ([issue#17455](http://tracker.ceph.com/issues/17455),
    [pr#11386](http://github.com/ceph/ceph/pull/11386), xie xingguo)
-   mgr: PyModules.cc: remove duplicated if condition for fs_map
    ([pr#11639](http://github.com/ceph/ceph/pull/11639), Weibing Zhang)
-   mgr: remove unnecessary C_StdFunction
    ([pr#11883](http://github.com/ceph/ceph/pull/11883), John Spray)
-   mon: add missing space in warning message
    ([pr#11361](http://github.com/ceph/ceph/pull/11361), Patrick
    Donnelly)
-   mon: clean legacy code
    ([pr#9643](http://github.com/ceph/ceph/pull/9643), Wei Jin)
-   mon: clear duplicated logic in MDSMonitor
    ([pr#11209](http://github.com/ceph/ceph/pull/11209), Zhi Zhang)
-   mon: Do not allow pools to be deleted by default
    ([pr#11665](http://github.com/ceph/ceph/pull/11665), Wido den
    Hollander)
-   mon: fix \"OSDs marked OUT wrongly after monitor failover\"
    ([issue#17719](http://tracker.ceph.com/issues/17719),
    [pr#11664](http://github.com/ceph/ceph/pull/11664), Dong Wu)
-   mon: Forbidden copy and assignment function in monoprequest
    ([pr#9513](http://github.com/ceph/ceph/pull/9513), song baisen)
-   mon: have mon-specific features & rework internal monmap structures
    ([pr#10907](http://github.com/ceph/ceph/pull/10907), Joao Eduardo
    Luis)
-   mon: if crushtool config is empty use internal crush test
    ([pr#11765](http://github.com/ceph/ceph/pull/11765), Bassam Tabbara)
-   mon: make MDSMonitor tolerant of slow mon elections
    ([issue#17308](http://tracker.ceph.com/issues/17308),
    [pr#11167](http://github.com/ceph/ceph/pull/11167), John Spray)
-   mon: MonmapMonitor: return success when monitor will be removed
    ([issue#17725](http://tracker.ceph.com/issues/17725),
    [pr#11747](http://github.com/ceph/ceph/pull/11747), Joao Eduardo
    Luis)
-   mon: move case CEPH_MSG_POOLOP to OSDs group
    ([pr#11848](http://github.com/ceph/ceph/pull/11848), Javeme)
-   mon: osdmap\'s epoch should be more than 0
    ([pr#9859](http://github.com/ceph/ceph/pull/9859), Na Xie)
-   mon: OSDMonitor: fix the check error of pg creating
    ([issue#17169](http://tracker.ceph.com/issues/17169),
    [pr#10916](http://github.com/ceph/ceph/pull/10916), DesmondS)
-   mon: paxos add the timeout function when peon recovery
    ([pr#10359](http://github.com/ceph/ceph/pull/10359), song baisen)
-   mon: preserve osd weight when marking osd out, then in
    ([pr#11293](http://github.com/ceph/ceph/pull/11293), Sage Weil)
-   mon: prevent post-jewel OSDs from booting if require_jewel_osds is
    not set ([pr#11498](http://github.com/ceph/ceph/pull/11498), Sage
    Weil)
-   mon: remove ceph-create-keys from mon startup
    ([issue#16036](http://tracker.ceph.com/issues/16036),
    [pr#9345](http://github.com/ceph/ceph/pull/9345), Owen Synge)
-   mon: remove the redudant jugement in LogMonitor tick function
    ([pr#10474](http://github.com/ceph/ceph/pull/10474), song baisen)
-   mon: remove utime_t param in \_dump
    ([pr#12029](http://github.com/ceph/ceph/pull/12029), Patrick
    Donnelly)
-   mon: send updated monmap to its subscribers
    ([issue#17558](http://tracker.ceph.com/issues/17558),
    [pr#11456](http://github.com/ceph/ceph/pull/11456), Kefu Chai)
-   mon: small change on the HealthMonitor start_epoch function
    ([pr#10296](http://github.com/ceph/ceph/pull/10296), songbaisen)
-   mon: support for building without leveldb + mon mkfs bug fix
    ([pr#11800](http://github.com/ceph/ceph/pull/11800), Bassam Tabbara)
-   osd: add a pg \_fastinfo attribute to reduce per-io metadata updates
    ([pr#11213](http://github.com/ceph/ceph/pull/11213), Sage Weil)
-   osd: Add config option to disable new scrubs during recovery
    ([issue#17866](http://tracker.ceph.com/issues/17866),
    [pr#11874](http://github.com/ceph/ceph/pull/11874), Wido den
    Hollander)
-   osd: a few fast dispatch optimizations
    ([pr#12052](http://github.com/ceph/ceph/pull/12052), Sage Weil)
-   osd: cleanup C_CompleteSplits::finish()
    ([pr#12094](http://github.com/ceph/ceph/pull/12094), Jie Wang)
-   osd: clean up PeeringWQ::\_dequeue(), remove unnecessary variable
    ([pr#12117](http://github.com/ceph/ceph/pull/12117), Jie Wang)
-   osd: clean up process_peering_events
    ([pr#12009](http://github.com/ceph/ceph/pull/12009), Jie Wang)
-   osdc/Objecter: resend pg commands on interval change
    ([issue#18358](http://tracker.ceph.com/issues/18358),
    [pr#12910](http://github.com/ceph/ceph/pull/12910), Samuel Just)
-   osd: condition OSDMap encoding on features
    ([pr#12166](http://github.com/ceph/ceph/pull/12166), Sage Weil)
-   osd: default osd_scrub_during_recovery=false
    ([pr#12402](http://github.com/ceph/ceph/pull/12402), Sage Weil)
-   osd: do not open pgs when the pg is not in pg_map
    ([issue#17806](http://tracker.ceph.com/issues/17806),
    [pr#11803](http://github.com/ceph/ceph/pull/11803), Xinze Chi)
-   osd: drop stray debug message
    ([pr#11296](http://github.com/ceph/ceph/pull/11296), Sage Weil)
-   osd: EC Overwrites
    ([issue#17668](http://tracker.ceph.com/issues/17668),
    [pr#11701](http://github.com/ceph/ceph/pull/11701), Tomy Cheru,
    Samuel Just)
-   osd: enhance logging for osd network error
    ([pr#12458](http://github.com/ceph/ceph/pull/12458), liuchang0812)
-   osd: fix CEPH_OSD_FLAG_RWORDERED
    ([pr#12603](http://github.com/ceph/ceph/pull/12603), Sage Weil)
-   osd: fix duplicated id of incompat feature \"fastinfo\"
    ([pr#11588](http://github.com/ceph/ceph/pull/11588), xie xingguo)
-   osd: fix ec scrub errors
    ([issue#17999](http://tracker.ceph.com/issues/17999),
    [pr#12306](http://github.com/ceph/ceph/pull/12306), Samuel Just)
-   osd: fixes to make rbd on ec work
    ([pr#12305](http://github.com/ceph/ceph/pull/12305), Samuel Just)
-   osd: Fix map gaps again (bug 15943)
    ([issue#15943](http://tracker.ceph.com/issues/15943),
    [pr#12571](http://github.com/ceph/ceph/pull/12571), Samuel Just)
-   osd: fix memory leak from EC write workload
    ([issue#18093](http://tracker.ceph.com/issues/18093),
    [pr#12256](http://github.com/ceph/ceph/pull/12256), Sage Weil)
-   osd: fix rados write op hang
    ([pr#11143](http://github.com/ceph/ceph/pull/11143), Yunchuan Wen)
-   osd: Fix read error propogation in ECBackend
    ([issue#17966](http://tracker.ceph.com/issues/17966),
    [pr#12142](http://github.com/ceph/ceph/pull/12142), Samuel Just)
-   osd: fix scrub boundary to not include a SnapSet
    ([pr#11255](http://github.com/ceph/ceph/pull/11255), Samuel Just)
-   osd: fix signed/unsigned comparison warning
    ([pr#12400](http://github.com/ceph/ceph/pull/12400), Greg Farnum)
-   osd: fix typo in PG::clear_primary_state
    ([pr#11513](http://github.com/ceph/ceph/pull/11513), Brad Hubbard)
-   osd: Fix typos in PG::find_best_info
    ([pr#11515](http://github.com/ceph/ceph/pull/11515), Brad Hubbard)
-   osd: fix typos in \"struct OSDOp\" comments
    ([pr#12350](http://github.com/ceph/ceph/pull/12350), Chanyoung Park)
-   osd: Flush Journal on shutdown
    ([pr#11249](http://github.com/ceph/ceph/pull/11249), Wido den
    Hollander)
-   osd: force watch PING to be write ordered
    ([issue#18310](http://tracker.ceph.com/issues/18310),
    [pr#12590](http://github.com/ceph/ceph/pull/12590), Samuel Just)
-   osd: handle EC recovery read errors
    ([issue#13937](http://tracker.ceph.com/issues/13937),
    [pr#9304](http://github.com/ceph/ceph/pull/9304), David Zafman)
-   osd: heartbeat peers need to be updated when a new OSD added into an
    existed cluster
    ([issue#18004](http://tracker.ceph.com/issues/18004),
    [pr#12069](http://github.com/ceph/ceph/pull/12069), Pan Liu)
-   osd: Increase priority for inactive PGs backfill
    ([pr#12389](http://github.com/ceph/ceph/pull/12389), Bartłomiej
    Święcki)
-   osd: kill PG_STATE_SPLITTING
    ([pr#11824](http://github.com/ceph/ceph/pull/11824), xie xingguo)
-   osd: mark queued flag for op
    ([pr#12352](http://github.com/ceph/ceph/pull/12352), Yunchuan Wen)
-   osd: osdc: pass a string reference type to
    \"osdmap-\>lookup_pg_pool_name\"
    ([pr#12219](http://github.com/ceph/ceph/pull/12219), Leo Zhang)
-   osd: osd/OSDMonitor: accept \'osd pool set \...\' value as string
    ([pr#911](http://github.com/ceph/ceph/pull/911), David Zafman)
-   osd: PGLog: initialize writeout_from in PGLog constructor
    ([issue#12973](http://tracker.ceph.com/issues/12973),
    [pr#558](http://github.com/ceph/ceph/pull/558), Sage Weil)
-   osd/PrimaryLogPG: don\'t update digests for objects with mismatched
    names ([issue#18409](http://tracker.ceph.com/issues/18409),
    [pr#12803](http://github.com/ceph/ceph/pull/12803), Samuel Just)
-   osd/PrimaryLogPG::failed_push: update missing as well
    ([issue#18165](http://tracker.ceph.com/issues/18165),
    [pr#12911](http://github.com/ceph/ceph/pull/12911), Samuel Just)
-   osd: print log when osd want to kill self
    ([pr#9288](http://github.com/ceph/ceph/pull/9288), Haomai Wang)
-   osd: Remove extra call to reg_next_scrub() during splits
    ([issue#16474](http://tracker.ceph.com/issues/16474),
    [pr#11206](http://github.com/ceph/ceph/pull/11206), David Zafman)
-   osd: remove redudant call of heartbeat_check
    ([pr#12130](http://github.com/ceph/ceph/pull/12130), Pan Liu)
-   osd: remove the lock heartbeat_update_lock, and change
    heatbeat_need\_...
    ([pr#12461](http://github.com/ceph/ceph/pull/12461), Pan Liu)
-   osd: remove the redundant clear method in consume_map function
    ([pr#10553](http://github.com/ceph/ceph/pull/10553), song baisen)
-   osd: Remove unused \'\_[lsb_release]()\' declarations
    ([pr#11364](http://github.com/ceph/ceph/pull/11364), Brad Hubbard)
-   osd: replace hb_out and hb_in with a single hb_peers
    ([issue#18057](http://tracker.ceph.com/issues/18057),
    [pr#12178](http://github.com/ceph/ceph/pull/12178), Pan Liu)
-   osd: ReplicatedPG: don\'t bless C_OSD_SendMessageOnConn
    ([issue#13304](http://tracker.ceph.com/issues/13304),
    [pr#669](http://github.com/ceph/ceph/pull/669), Jason Dillaman)
-   osd: set server-side limits on omap get operations
    ([pr#12059](http://github.com/ceph/ceph/pull/12059), Sage Weil)
-   osd: When deep-scrub errors present upgrade regular scrubs
    ([pr#12268](http://github.com/ceph/ceph/pull/12268), David Zafman)
-   performance,bluestore: kv/MemDB: making memdb code adapt to generic
    maps ([pr#11436](http://github.com/ceph/ceph/pull/11436), Ramesh
    Chander)
-   performance,bluestore: os/bluestore: allow default to buffered write
    ([pr#11301](http://github.com/ceph/ceph/pull/11301), Sage Weil)
-   performance,bluestore: os/bluestore: bluestore_cache_meta_ratio = .5
    ([pr#11919](http://github.com/ceph/ceph/pull/11919), Sage Weil)
-   performance,bluestore: os/bluestore: reduce Onode in-memory
    footprint ([pr#12568](http://github.com/ceph/ceph/pull/12568), Igor
    Fedotov)
-   performance,bluestore: os/bluestore: refactor
    bluestore_sync_submit_transaction
    ([pr#11537](http://github.com/ceph/ceph/pull/11537), Sage Weil)
-   performance,bluestore: os/bluestore: speed up omap-key generation
    for same onode(the read paths)
    ([pr#11894](http://github.com/ceph/ceph/pull/11894), xie xingguo)
-   performance,bluestore: os/bluestore: speedup the performance of
    multi-replication flow by switc...
    ([pr#11844](http://github.com/ceph/ceph/pull/11844), Pan Liu)
-   performance,cephfs: Fix long stalls when calling ceph_fsync()
    ([issue#17563](http://tracker.ceph.com/issues/17563),
    [pr#11710](http://github.com/ceph/ceph/pull/11710), Jeff Layton)
-   performance,cleanup: Context: std::move the callback param in
    FunctionContext\'s ctor
    ([pr#11892](http://github.com/ceph/ceph/pull/11892), Kefu Chai)
-   performance,cleanup: osd/PG.h: move shared ptr instead of copying it
    ([pr#11154](http://github.com/ceph/ceph/pull/11154), Michal
    Jarzabek)
-   performance,common: common/config_opts.h: Optimized RocksDB WAL
    settings. ([pr#11530](http://github.com/ceph/ceph/pull/11530), Mark
    Nelson)
-   performance,common: osd/OSDMap: improve the performance of
    pg_to_acting_osds
    ([pr#12190](http://github.com/ceph/ceph/pull/12190), Pan Liu)
-   performance: msg/async: set ms_async_send_inline to false to improve
    small randread iops
    ([pr#11521](http://github.com/ceph/ceph/pull/11521), Mark Nelson)
-   performance,tools: rados: add hints to rados bench
    ([pr#12169](http://github.com/ceph/ceph/pull/12169), Sage Weil)
-   pybind: avoid \"exception \'int\' object is not iterable\"
    ([pr#11532](http://github.com/ceph/ceph/pull/11532), Javeme)
-   pybind,cephfs: ceph_volume_client: fix recovery from partial auth
    update ([issue#17216](http://tracker.ceph.com/issues/17216),
    [pr#11304](http://github.com/ceph/ceph/pull/11304), Ramana Raja)
-   pybind,cephfs: ceph_volume_client: set an existing auth ID\'s
    default mon caps
    ([issue#17800](http://tracker.ceph.com/issues/17800),
    [pr#11917](http://github.com/ceph/ceph/pull/11917), Ramana Raja)
-   pybind: ceph-rest-api: understand the new style entity_addr_t
    representation ([issue#17742](http://tracker.ceph.com/issues/17742),
    [pr#11686](http://github.com/ceph/ceph/pull/11686), Kefu Chai)
-   pybind: clean up mgr stuff for flake8
    ([pr#11314](http://github.com/ceph/ceph/pull/11314), John Spray)
-   pybind: fix build failure of rgwfile binding
    ([pr#11825](http://github.com/ceph/ceph/pull/11825), Kefu Chai)
-   pybind: pybind/rados: add missing \"length\" requires for
    aio_execute() ([pr#12439](http://github.com/ceph/ceph/pull/12439),
    Kefu Chai)
-   pybind: pybind/rados: Add \@requires for all aio methods
    ([pr#12327](http://github.com/ceph/ceph/pull/12327), Iain Buclaw)
-   qa: fixed distros links
    ([pr#12773](http://github.com/ceph/ceph/pull/12773), Yuri Weinstein)
-   qa: Fixed link to centos distro
    ([pr#12768](http://github.com/ceph/ceph/pull/12768), Yuri Weinstein)
-   qa/suites: switch from centos 7.2 to 7.x
    ([pr#12632](http://github.com/ceph/ceph/pull/12632), Sage Weil)
-   qa/tasks/peer: update task based on current peering behavior
    ([issue#18330](http://tracker.ceph.com/issues/18330),
    [pr#12614](http://github.com/ceph/ceph/pull/12614), Sage Weil)
-   qa/tasks/workunit: clear clone dir before retrying checkout
    ([issue#18336](http://tracker.ceph.com/issues/18336),
    [pr#12630](http://github.com/ceph/ceph/pull/12630), Sage Weil)
-   qa: update Ubuntu image url after ceph.com refactor
    ([issue#18542](http://tracker.ceph.com/issues/18542),
    [pr#12960](http://github.com/ceph/ceph/pull/12960), Jason Dillaman)
-   qa/workunits/rbd/test_lock_fence.sh fails
    ([issue#18388](http://tracker.ceph.com/issues/18388),
    [pr#12752](http://github.com/ceph/ceph/pull/12752), Nathan Cutler)
-   rbd: added rbd-nbd fsx test case
    ([pr#1049](http://github.com/ceph/ceph/pull/1049), Jason Dillaman)
-   rbd: add fsx journal replay test case
    ([pr#821](http://github.com/ceph/ceph/pull/821), Jason Dillaman)
-   rbd: add singleton to assert no rbdmap regression
    ([issue#14984](http://tracker.ceph.com/issues/14984),
    [pr#902](http://github.com/ceph/ceph/pull/902), Nathan Cutler)
-   rbd: add some missing workunits
    ([pr#870](http://github.com/ceph/ceph/pull/870), Josh Durgin)
-   rbd: add support for separate image data pool
    ([issue#17424](http://tracker.ceph.com/issues/17424),
    [pr#11355](http://github.com/ceph/ceph/pull/11355), Jason Dillaman)
-   rbd: expose rbd unmap options
    ([issue#17554](http://tracker.ceph.com/issues/17554),
    [pr#11370](http://github.com/ceph/ceph/pull/11370), Ilya Dryomov)
-   rbd: fix json formatting for image and journal status output
    ([issue#18261](http://tracker.ceph.com/issues/18261),
    [pr#12525](http://github.com/ceph/ceph/pull/12525), Mykola Golub)
-   rbd: fix parsing of group and image specific pools
    ([pr#11632](http://github.com/ceph/ceph/pull/11632), Victor Denisov)
-   rbd: journal: do not prematurely flag object recorder as closed
    ([issue#17590](http://tracker.ceph.com/issues/17590),
    [pr#11520](http://github.com/ceph/ceph/pull/11520), Jason Dillaman)
-   rbd: krbd: kernel client expects ip\[:port\], not an entity_addr_t
    ([pr#11902](http://github.com/ceph/ceph/pull/11902), Ilya Dryomov)
-   rbd: \--max_part and \--nbds_max options for nbd map
    ([issue#18186](http://tracker.ceph.com/issues/18186),
    [pr#12379](http://github.com/ceph/ceph/pull/12379), Pan Liu)
-   rbd: move nbd test workload to separate client host from OSDs
    ([pr#1170](http://github.com/ceph/ceph/pull/1170), Jason Dillaman)
-   rbd: provision volumes to format as XFS
    ([issue#6693](http://tracker.ceph.com/issues/6693),
    [pr#1028](http://github.com/ceph/ceph/pull/1028), Loic Dachary)
-   rbd: rbd-mirror: fix sparse read optimization in image sync
    ([issue#18146](http://tracker.ceph.com/issues/18146),
    [pr#12368](http://github.com/ceph/ceph/pull/12368), Mykola Golub)
-   rbd: rbd-mirror HA: move librbd::image_watcher::Notifier to
    librbd::object_watcher
    ([issue#17017](http://tracker.ceph.com/issues/17017),
    [pr#11290](http://github.com/ceph/ceph/pull/11290), Mykola Golub)
-   rbd: rbd-mirror: recovering after split-brain
    ([issue#16991](http://tracker.ceph.com/issues/16991),
    [issue#18051](http://tracker.ceph.com/issues/18051),
    [pr#12212](http://github.com/ceph/ceph/pull/12212), Mykola Golub)
-   rbd: rbd-mirror: snap protect of non-layered image results in
    split-brain ([issue#16962](http://tracker.ceph.com/issues/16962),
    [pr#11744](http://github.com/ceph/ceph/pull/11744), Mykola Golub)
-   rbd: rbd-nbd: disallow mapping images \>2TB in size
    ([issue#17219](http://tracker.ceph.com/issues/17219),
    [pr#11741](http://github.com/ceph/ceph/pull/11741), Mykola Golub)
-   rbd: rbd-nbd: invalid error code for \"failed to read nbd request\"
    messages ([issue#18242](http://tracker.ceph.com/issues/18242),
    [pr#12483](http://github.com/ceph/ceph/pull/12483), Mykola Golub)
-   rbd: rbd-nbd: restart parent process logger after forking
    ([issue#18070](http://tracker.ceph.com/issues/18070),
    [pr#12222](http://github.com/ceph/ceph/pull/12222), Jason Dillaman)
-   rbd: rbd-nbd: support disabling auto-exclusive lock transition logic
    ([issue#17488](http://tracker.ceph.com/issues/17488),
    [pr#11438](http://github.com/ceph/ceph/pull/11438), Mykola Golub)
-   rbd: rbd-nbd: support partition for rbd-nbd mapped raw block device
    ([issue#18115](http://tracker.ceph.com/issues/18115),
    [pr#12259](http://github.com/ceph/ceph/pull/12259), Pan Liu)
-   rbd: tests with rbd_skip_partial_discard option enabled
    ([pr#1077](http://github.com/ceph/ceph/pull/1077), Mykola Golub)
-   rbd,tools: rbd : make option \--stripe-unit w/ B/K/M work
    ([pr#12407](http://github.com/ceph/ceph/pull/12407), Jianpeng Ma)
-   rbd: updated tests to use new rbd default feature set
    ([pr#842](http://github.com/ceph/ceph/pull/842), Jason Dillaman)
-   rbd: use snap_remove implementation from internal
    ([pr#12035](http://github.com/ceph/ceph/pull/12035), Victor Denisov)
-   rgw: add default zone name
    ([issue#7009](http://tracker.ceph.com/issues/7009),
    [pr#954](http://github.com/ceph/ceph/pull/954), Orit Wasserman)
-   rgw: add documentation for upgrading with rgw_region_root_pool
    ([pr#12138](http://github.com/ceph/ceph/pull/12138), Orit Wasserman)
-   rgw: add option to log custom HTTP headers (rgw_log_http_headers)
    ([pr#7639](http://github.com/ceph/ceph/pull/7639), Matt Benjamin)
-   rgw: add recovery procedure for upgrade to older version of jewel
    ([issue#17820](http://tracker.ceph.com/issues/17820),
    [pr#11827](http://github.com/ceph/ceph/pull/11827), Orit Wasserman)
-   rgw: add rgw_compression_type=random for teuthology testing
    ([pr#11901](http://github.com/ceph/ceph/pull/11901), Casey Bodley)
-   rgw: add sleep to let the sync agent init
    ([pr#1136](http://github.com/ceph/ceph/pull/1136), Orit Wasserman)
-   rgw: add suport for creating S3 type subuser of admin rest api
    ([issue#16682](http://tracker.ceph.com/issues/16682),
    [pr#10325](http://github.com/ceph/ceph/pull/10325), snakeAngel2015)
-   rgw: add support for the prefix parameter in account listing of
    Swift API ([issue#17931](http://tracker.ceph.com/issues/17931),
    [pr#12047](http://github.com/ceph/ceph/pull/12047), Radoslaw
    Zarzynski)
-   rgw: allow fastcgi idle timeout to be adjusted
    ([pr#230](http://github.com/ceph/ceph/pull/230), Sage Weil)
-   rgw: also approve, passed teuthology (many false positives in
    several classes)
    ([issue#17985](http://tracker.ceph.com/issues/17985),
    [pr#12224](http://github.com/ceph/ceph/pull/12224), Yehuda Sadeh,
    Sage Weil)
-   rgw: Anonymous users shouldn\'t be able to access requester pays
    buckets. ([issue#17175](http://tracker.ceph.com/issues/17175),
    [pr#11719](http://github.com/ceph/ceph/pull/11719), Zhang Shaowen)
-   rgw: aws4: add presigned url bugfix in runtime
    ([issue#16463](http://tracker.ceph.com/issues/16463),
    [pr#10160](http://github.com/ceph/ceph/pull/10160), Javier M.
    Mellid)
-   rgw: bucket resharding
    ([issue#17550](http://tracker.ceph.com/issues/17550),
    [pr#11230](http://github.com/ceph/ceph/pull/11230), Yehuda Sadeh)
-   rgw:bugfix for deleting objects name beginning and ending with
    underscores of one bucket using POST method of AWS\'s js sdk.
    ([issue#17888](http://tracker.ceph.com/issues/17888),
    [pr#11982](http://github.com/ceph/ceph/pull/11982), root)
-   rgw: Class member cookie is not initialized correctly in some
    coroutine\'s constructor.
    ([pr#11673](http://github.com/ceph/ceph/pull/11673), Zhang Shaowen)
-   rgw: clean up RGWShardedOmapCRManager on early return
    ([issue#17571](http://tracker.ceph.com/issues/17571),
    [pr#11505](http://github.com/ceph/ceph/pull/11505), Casey Bodley)
-   rgw: clear data_sync_cr if RGWDataSyncControlCR fails
    ([issue#17569](http://tracker.ceph.com/issues/17569),
    [pr#11506](http://github.com/ceph/ceph/pull/11506), Casey Bodley)
-   rgw: compilation of the ASIO front-end is enabled by default.
    ([pr#12073](http://github.com/ceph/ceph/pull/12073), Radoslaw
    Zarzynski)
-   rgw: compression uses optional::emplace instead of in-place
    factories ([pr#12021](http://github.com/ceph/ceph/pull/12021),
    Radoslaw Zarzynski)
-   rgw: conform to the standard usage of string::find
    ([pr#10086](http://github.com/ceph/ceph/pull/10086), Yan Jun)
-   rgw: data_extra_pool is unique per zone
    ([issue#17025](http://tracker.ceph.com/issues/17025),
    [pr#1119](http://github.com/ceph/ceph/pull/1119), Orit Wasserman)
-   rgw: delete entries_index in RGWFetchAllMetaCR
    ([issue#17812](http://tracker.ceph.com/issues/17812),
    [pr#11816](http://github.com/ceph/ceph/pull/11816), Casey Bodley)
-   rgw: do not abort when accept a CORS request with short origin
    ([pr#12381](http://github.com/ceph/ceph/pull/12381), LiuYang)
-   rgw: do not enable both tcp and uds for fastcgi
    ([issue#5797](http://tracker.ceph.com/issues/5797),
    [pr#479](http://github.com/ceph/ceph/pull/479), Andrew Schoen)
-   rgw: don\'t error out on empty owner when setting acls
    ([issue#6892](http://tracker.ceph.com/issues/6892),
    [pr#877](http://github.com/ceph/ceph/pull/877), Loic Dachary, Nathan
    Cutler)
-   rgw: Don\'t loop forever when reading data from 0 sized segment.
    ([issue#17692](http://tracker.ceph.com/issues/17692),
    [pr#11567](http://github.com/ceph/ceph/pull/11567), Marcus Watts)
-   rgw: dont set CURLOPT_UPLOAD for GET requests
    ([issue#17822](http://tracker.ceph.com/issues/17822),
    [pr#12105](http://github.com/ceph/ceph/pull/12105), Casey Bodley)
-   rgw: don\'t store empty chains in gc
    ([issue#17897](http://tracker.ceph.com/issues/17897),
    [pr#11969](http://github.com/ceph/ceph/pull/11969), Yehuda Sadeh)
-   rgw: do quota tests on ubuntu
    ([issue#6382](http://tracker.ceph.com/issues/6382),
    [pr#635](http://github.com/ceph/ceph/pull/635), Sage Weil)
-   rgw: dump objects in RGWBucket::check_object_index()
    ([issue#14589](http://tracker.ceph.com/issues/14589),
    [pr#11324](http://github.com/ceph/ceph/pull/11324), Yehuda Sadeh)
-   rgw: dump remaining coroutines when cr deadlock is detected
    ([pr#11580](http://github.com/ceph/ceph/pull/11580), Casey Bodley)
-   rgw: extract host name from host:port string
    ([issue#17788](http://tracker.ceph.com/issues/17788),
    [pr#11751](http://github.com/ceph/ceph/pull/11751), Yehuda Sadeh)
-   rgw: Fixed problem with PUT with x-amz-copy-source when source
    object is compressed.
    ([pr#12253](http://github.com/ceph/ceph/pull/12253), Adam Kupczyk)
-   rgw: fixes for virtual hosting of buckets
    ([issue#17440](http://tracker.ceph.com/issues/17440),
    [issue#15975](http://tracker.ceph.com/issues/15975),
    [issue#17136](http://tracker.ceph.com/issues/17136),
    [pr#11280](http://github.com/ceph/ceph/pull/11280), Casey Bodley,
    Robin H. Johnson)
-   rgw: fix etag in multipart complete
    ([issue#17794](http://tracker.ceph.com/issues/17794),
    [issue#6830](http://tracker.ceph.com/issues/6830),
    [issue#16129](http://tracker.ceph.com/issues/16129),
    [issue#17872](http://tracker.ceph.com/issues/17872),
    [pr#1269](http://github.com/ceph/ceph/pull/1269), Casey Bodley, Orit
    Wasserman)
-   rgw: fix for bucket delete racing with mdlog sync
    ([issue#17698](http://tracker.ceph.com/issues/17698),
    [pr#11648](http://github.com/ceph/ceph/pull/11648), Casey Bodley)
-   rgw: fix for passing temporary in InitBucketSyncStatus
    ([issue#17661](http://tracker.ceph.com/issues/17661),
    [pr#11594](http://github.com/ceph/ceph/pull/11594), Casey Bodley)
-   rgw: fix for unsafe change of rgw_zonegroup
    ([issue#17962](http://tracker.ceph.com/issues/17962),
    [pr#12075](http://github.com/ceph/ceph/pull/12075), Casey Bodley)
-   rgw: fix indentation for cache_pools
    ([issue#8295](http://tracker.ceph.com/issues/8295),
    [pr#251](http://github.com/ceph/ceph/pull/251), Sage Weil)
-   rgw: fix missing master zone for a single zone zonegroup
    ([issue#17364](http://tracker.ceph.com/issues/17364),
    [pr#11965](http://github.com/ceph/ceph/pull/11965), Orit Wasserman)
-   rgw: fix osd crashes when execute \"radosgw-admin bi list
    \--max-entries=1\" command
    ([issue#17745](http://tracker.ceph.com/issues/17745),
    [pr#11697](http://github.com/ceph/ceph/pull/11697), weiqiaomiao)
-   rgw: fix put_acls for objects starting and ending with underscore
    ([issue#17625](http://tracker.ceph.com/issues/17625),
    [pr#11566](http://github.com/ceph/ceph/pull/11566), Orit Wasserman)
-   rgw: fix RGWSimpleRadosLockCR set_description()
    ([pr#11961](http://github.com/ceph/ceph/pull/11961), Tianshan Qu)
-   rgw: fix the field \'total_time\' of log entry in log show opt
    ([issue#17598](http://tracker.ceph.com/issues/17598),
    [pr#11425](http://github.com/ceph/ceph/pull/11425), weiqiaomiao)
-   rgw: fix uncompressed object size deduction in
    RGWRados::copy_obj_data.
    ([issue#17803](http://tracker.ceph.com/issues/17803),
    [pr#11794](http://github.com/ceph/ceph/pull/11794), Radoslaw
    Zarzynski)
-   rgw: frontend subsystem rework
    ([pr#10767](http://github.com/ceph/ceph/pull/10767), Radoslaw
    Zarzynski, Casey Bodley, Matt Benjamin)
-   rgw: ftw ([issue#17888](http://tracker.ceph.com/issues/17888),
    [pr#12262](http://github.com/ceph/ceph/pull/12262), Casey Bodley)
-   rgw: get_system_obj does not use result of get_system_obj_state
    ([issue#17580](http://tracker.ceph.com/issues/17580),
    [pr#11444](http://github.com/ceph/ceph/pull/11444), Casey Bodley)
-   rgw: get_zonegroup() uses \"default\" zonegroup if empty
    ([issue#17372](http://tracker.ceph.com/issues/17372),
    [pr#11207](http://github.com/ceph/ceph/pull/11207), Yehuda Sadeh)
-   rgw: handle empty POST condition
    ([issue#17635](http://tracker.ceph.com/issues/17635),
    [pr#11581](http://github.com/ceph/ceph/pull/11581), Yehuda Sadeh)
-   rgw: handle Swift auth errors in a way compatible with new Tempests.
    ([issue#16590](http://tracker.ceph.com/issues/16590),
    [pr#10021](http://github.com/ceph/ceph/pull/10021), Radoslaw
    Zarzynski)
-   rgw: json encode/decode index_type, allow modification
    ([issue#17755](http://tracker.ceph.com/issues/17755),
    [pr#11707](http://github.com/ceph/ceph/pull/11707), Yehuda Sadeh)
-   rgw: loses realm/period/zonegroup/zone data: period overwritten if
    somewhere in the cluster is still running Hammer
    ([issue#17371](http://tracker.ceph.com/issues/17371),
    [pr#11426](http://github.com/ceph/ceph/pull/11426), Orit Wasserman)
-   rgw: make RGWLocalAuthApplier::is_admin_of() aware about system
    users. ([issue#18106](http://tracker.ceph.com/issues/18106),
    [pr#12283](http://github.com/ceph/ceph/pull/12283), Radoslaw
    Zarzynski)
-   rgw: metadata sync info should be shown at master zone of slave
    zoneg... ([issue#18091](http://tracker.ceph.com/issues/18091),
    [pr#12187](http://github.com/ceph/ceph/pull/12187), Jing Wenjun)
-   rgw: minor cleanup
    ([pr#10057](http://github.com/ceph/ceph/pull/10057), Yan Jun)
-   rgw: move compression config into zone placement
    ([pr#12113](http://github.com/ceph/ceph/pull/12113), Casey Bodley)
-   rgw: move xfs to a seperate directory
    ([pr#969](http://github.com/ceph/ceph/pull/969), Orit Wasserman)
-   rgw: multipart upload copy
    ([issue#12790](http://tracker.ceph.com/issues/12790),
    [pr#11269](http://github.com/ceph/ceph/pull/11269), Yehuda Sadeh,
    Javier M. Mellid)
-   rgw: need to close_section in lc list op
    ([pr#12232](http://github.com/ceph/ceph/pull/12232), weiqiaomiao)
-   rgw: policy acl format should be xml
    ([pr#946](http://github.com/ceph/ceph/pull/946), Orit Wasserman)
-   rgw: radosgw-admin: more on placement configuration
    ([issue#18078](http://tracker.ceph.com/issues/18078),
    [pr#12242](http://github.com/ceph/ceph/pull/12242), Casey Bodley)
-   rgw: region conversion respects pre-existing rgw_region_root_pool
    ([issue#17963](http://tracker.ceph.com/issues/17963),
    [pr#12076](http://github.com/ceph/ceph/pull/12076), Casey Bodley)
-   rgw: remove a redundant judgement when listng objects.
    ([pr#10849](http://github.com/ceph/ceph/pull/10849), zhangshaowen)
-   rgw: remove circular reference in RGWAsyncRadosRequest
    ([issue#17793](http://tracker.ceph.com/issues/17793),
    [issue#17792](http://tracker.ceph.com/issues/17792),
    [pr#11815](http://github.com/ceph/ceph/pull/11815), Casey Bodley)
-   rgw: remove suggestion to upgrade libcurl
    ([pr#11630](http://github.com/ceph/ceph/pull/11630), Casey Bodley)
-   rgw: remove unused variable \"ostr\" in rgw_b64.h and fix the
    comment ([pr#11329](http://github.com/ceph/ceph/pull/11329), Weibing
    Zhang)
-   rgw: Replacing \'+\' with \"%20\" in canonical uri for s3 v4 auth.
    ([issue#17076](http://tracker.ceph.com/issues/17076),
    [pr#10919](http://github.com/ceph/ceph/pull/10919), Pritha
    Srivastava)
-   rgw: revert unintentional change to civetweb
    ([pr#12004](http://github.com/ceph/ceph/pull/12004), Bassam Tabbara)
-   rgw: rgw-admin: new commands to control placement
    ([issue#18078](http://tracker.ceph.com/issues/18078),
    [pr#12230](http://github.com/ceph/ceph/pull/12230), Yehuda Sadeh)
-   rgw: RGWBucketSyncStatusManager uses existing async_rados
    ([issue#18083](http://tracker.ceph.com/issues/18083),
    [pr#12229](http://github.com/ceph/ceph/pull/12229), Casey Bodley)
-   rgw: rgw_file: apply missed base64 try-catch
    ([issue#17663](http://tracker.ceph.com/issues/17663),
    [pr#11671](http://github.com/ceph/ceph/pull/11671), Matt Benjamin)
-   rgw: RGWHTTPArgs::get_str() - return argument string that was set.
    ([pr#10672](http://github.com/ceph/ceph/pull/10672), Marcus Watts)
-   rgw: rgw multisite: fix the increamtal bucket sync init
    ([issue#17624](http://tracker.ceph.com/issues/17624),
    [pr#11553](http://github.com/ceph/ceph/pull/11553), Zengran Zhang)
-   rgw: rgw multisite: use a rados lock to coordinate data log trimming
    ([pr#10546](http://github.com/ceph/ceph/pull/10546), Casey Bodley)
-   rgw: RGW Python bindings - use explicit array
    ([pr#11831](http://github.com/ceph/ceph/pull/11831), Daniel
    Gryniewicz)
-   rgw: rgw_rados.cc fix shard_num format for snprintf
    ([pr#11493](http://github.com/ceph/ceph/pull/11493), Weibing Zhang)
-   rgw: rgw/rgw_file.cc: Add compat.h to allow CLOCK_MONOTONE
    ([pr#12309](http://github.com/ceph/ceph/pull/12309), Willem Jan
    Withagen)
-   rgw: RGWSimpleRadosReadCR tolerates empty reads
    ([issue#17568](http://tracker.ceph.com/issues/17568),
    [pr#11504](http://github.com/ceph/ceph/pull/11504), Casey Bodley)
-   rgw: \[RGW\] Wip rgw compression
    ([pr#11494](http://github.com/ceph/ceph/pull/11494), Alyona
    Kiseleva, Adam Kupczyk, Casey Bodley)
-   rgw: set duration for lifecycle lease
    ([issue#17965](http://tracker.ceph.com/issues/17965),
    [pr#12231](http://github.com/ceph/ceph/pull/12231), Yehuda Sadeh)
-   rgw: should assign \'olh_bl\" to
    state.attrset\[RGW_ATTR_OLH_ID_TAG\] instead of \'bl\'
    ([pr#10239](http://github.com/ceph/ceph/pull/10239), weiqiaomiao)
-   rgw: skip empty http args in method parse() to avoid extra effort
    ([pr#11989](http://github.com/ceph/ceph/pull/11989), Guo Zhandong)
-   rgw: split osd\'s in 2 nodes
    ([issue#15612](http://tracker.ceph.com/issues/15612),
    [pr#1019](http://github.com/ceph/ceph/pull/1019), Vasu Kulkarni)
-   rgw: support for x-robots-tag header
    ([issue#17790](http://tracker.ceph.com/issues/17790),
    [pr#11753](http://github.com/ceph/ceph/pull/11753), Yehuda Sadeh)
-   rgw: sync modules, metadata search
    ([pr#10731](http://github.com/ceph/ceph/pull/10731), Yehuda Sadeh)
-   rgw: Update version of civetweb to 1.8
    ([pr#11343](http://github.com/ceph/ceph/pull/11343), Marcus Watts)
-   rgw: use civetweb if no frontend was configured
    ([pr#958](http://github.com/ceph/ceph/pull/958), Orit Wasserman)
-   rgw: use explicit flag to cancel RGWCoroutinesManager::run()
    ([issue#17465](http://tracker.ceph.com/issues/17465),
    [pr#12452](http://github.com/ceph/ceph/pull/12452), Casey Bodley)
-   rgw: valgrind fixes for kraken
    ([issue#18414](http://tracker.ceph.com/issues/18414),
    [issue#18407](http://tracker.ceph.com/issues/18407),
    [issue#18412](http://tracker.ceph.com/issues/18412),
    [issue#18300](http://tracker.ceph.com/issues/18300),
    [pr#12949](http://github.com/ceph/ceph/pull/12949), Casey Bodley)
-   rgw: verified that failed check is in osd-scrub-repair.sh
    ([issue#17850](http://tracker.ceph.com/issues/17850),
    [pr#11881](http://github.com/ceph/ceph/pull/11881), Matt Benjamin)
-   rgw: we don\'t support btrfs any more
    ([pr#1132](http://github.com/ceph/ceph/pull/1132), Orit Wasserman)
-   rgw: Wip rgwfile pybind
    ([pr#11624](http://github.com/ceph/ceph/pull/11624), Haomai Wang)
-   tests,bluestore: os/bluestore: add UT for an estimation of Onode
    in-memory size ([pr#12532](http://github.com/ceph/ceph/pull/12532),
    Igor Fedotov)
-   tests,bluestore: os/test/store_test: fix legacy bluestore cache
    settings application
    ([pr#11915](http://github.com/ceph/ceph/pull/11915), Igor Fedotov)
-   tests: ceph-disk: force debug monc = 0
    ([issue#17607](http://tracker.ceph.com/issues/17607),
    [pr#11534](http://github.com/ceph/ceph/pull/11534), Loic Dachary)
-   tests: ceph_objectstore_tool.py: Don\'t use btrfs on FreeBSD
    ([pr#10507](http://github.com/ceph/ceph/pull/10507), Willem Jan
    Withagen)
-   tests: ceph_test_objectstore: fix Rename test
    ([pr#12261](http://github.com/ceph/ceph/pull/12261), Sage Weil)
-   tests: check hostname \--fqdn sanity before running make check
    ([issue#18134](http://tracker.ceph.com/issues/18134),
    [pr#12297](http://github.com/ceph/ceph/pull/12297), Nathan Cutler)
-   tests,cleanup,rbd: test/librbd: in test_notify set object-map and
    fast-diff features by default
    ([pr#11821](http://github.com/ceph/ceph/pull/11821), Mykola Golub)
-   tests,cleanup: test_bloom_filter.cc: Fix a mismatch for the
    random_seed parameter
    ([pr#11774](http://github.com/ceph/ceph/pull/11774), Willem Jan
    Withagen)
-   tests,cleanup: test/osd/osd-fast-mark-down.sh: remove unnecessary
    teardown() calls
    ([pr#12101](http://github.com/ceph/ceph/pull/12101), Kefu Chai)
-   tests,cleanup: test/osd-scrub-repair.sh: use repair() instead of
    \"ceph pg repair\"
    ([pr#12036](http://github.com/ceph/ceph/pull/12036), Kefu Chai)
-   tests,cleanup: test/rados: remove unused bufferlist variable
    ([pr#10221](http://github.com/ceph/ceph/pull/10221), Yan Jun)
-   tests,common: test: add perf-reset test in test/perf_counters.cc
    ([pr#8948](http://github.com/ceph/ceph/pull/8948), wangsongbo)
-   tests: disable failing tests
    ([issue#17561](http://tracker.ceph.com/issues/17561),
    [issue#17757](http://tracker.ceph.com/issues/17757),
    [pr#11714](http://github.com/ceph/ceph/pull/11714), Loic Dachary)
-   tests: disable the echo when running get_timeout_delays()
    ([pr#12180](http://github.com/ceph/ceph/pull/12180), Kefu Chai)
-   tests: do not use memstore.test_temp_dir in two tests
    ([issue#17743](http://tracker.ceph.com/issues/17743),
    [pr#12281](http://github.com/ceph/ceph/pull/12281), Loic Dachary)
-   tests: erasure-code: add k=2, m=2 for isa & jerasure
    ([issue#18188](http://tracker.ceph.com/issues/18188),
    [pr#12383](http://github.com/ceph/ceph/pull/12383), Loic Dachary)
-   tests: facilitate background process debug in ceph-helpers.sh
    ([issue#17830](http://tracker.ceph.com/issues/17830),
    [pr#12183](http://github.com/ceph/ceph/pull/12183), Loic Dachary)
-   tests: fix ceph-helpers.sh wait_for_clean delays
    ([issue#17830](http://tracker.ceph.com/issues/17830),
    [pr#12095](http://github.com/ceph/ceph/pull/12095), Loic Dachary)
-   tests: fix osd-scrub-repair.sh
    ([pr#12072](http://github.com/ceph/ceph/pull/12072), David Zafman)
-   tests: Fix racey test by setting noout flag (tracker 17757)
    ([issue#17757](http://tracker.ceph.com/issues/17757),
    [pr#11715](http://github.com/ceph/ceph/pull/11715), David Zafman)
-   tests: merge ceph-qa-suite
-   tests: Minor clean-ups
    ([pr#12048](http://github.com/ceph/ceph/pull/12048), David Zafman)
-   tests: minor make check cleanup
    ([pr#12146](http://github.com/ceph/ceph/pull/12146), David Zafman)
-   tests: no python3 tests for ceph-disk
    ([issue#17923](http://tracker.ceph.com/issues/17923),
    [pr#12025](http://github.com/ceph/ceph/pull/12025), Loic Dachary)
-   tests: osd-crush.sh must retry crush dump
    ([issue#17919](http://tracker.ceph.com/issues/17919),
    [pr#12016](http://github.com/ceph/ceph/pull/12016), Loic Dachary)
-   tests: osd-scrub-repair.sh abort if add_something fails
    ([pr#12172](http://github.com/ceph/ceph/pull/12172), Loic Dachary)
-   tests: os/memstore: fix a mem leak in
    MemStore::Collection::create_object()
    ([pr#12201](http://github.com/ceph/ceph/pull/12201), Kefu Chai)
-   tests: os/memstore, os/filestore: fix store_test\'s to satisfy
    rm_coll behavi...
    ([pr#11558](http://github.com/ceph/ceph/pull/11558), Igor Fedotov)
-   tests: paxos fixes
    ([issue#11913](http://tracker.ceph.com/issues/11913),
    [pr#457](http://github.com/ceph/ceph/pull/457), John Spray)
-   tests: pin flake8 to avoid behavior changes
    ([issue#17898](http://tracker.ceph.com/issues/17898),
    [pr#11971](http://github.com/ceph/ceph/pull/11971), Loic Dachary)
-   tests: qa: fixed script to schedule rados and other suites with
    \--subset option
    ([pr#12587](http://github.com/ceph/ceph/pull/12587), Yuri Weinstein)
-   tests: qa/tasks/admin_socket: subst in repo name
    ([pr#12508](http://github.com/ceph/ceph/pull/12508), Sage Weil)
-   tests: qa/tasks/ceph_deploy: use dev option instead of dev-commit
    ([pr#12514](http://github.com/ceph/ceph/pull/12514), Vasu Kulkarni)
-   tests: qa/tasks/osd_backfill.py: wait for osd.\[12\] to start
    ([issue#18303](http://tracker.ceph.com/issues/18303),
    [pr#12577](http://github.com/ceph/ceph/pull/12577), Sage Weil)
-   tests: qa/workunits/cephtool/test.sh: FreeBSD has no distro.
    ([pr#11702](http://github.com/ceph/ceph/pull/11702), Willem Jan
    Withagen)
-   tests: qa/workunits: include extension for nose tests
    ([pr#12572](http://github.com/ceph/ceph/pull/12572), Sage Weil)
-   tests: qa/workunits/rados/test_envlibrados_for_rocksdb: force
    librados-dev install
    ([pr#11941](http://github.com/ceph/ceph/pull/11941), Sage Weil)
-   tests,rbd: qa/workunits/rbd: fix
    ([issue#18271](http://tracker.ceph.com/issues/18271),
    [pr#12511](http://github.com/ceph/ceph/pull/12511), Sage Weil)
-   tests,rbd: qa/workunits/rbd: removed qemu-iotest case 077
    ([issue#10773](http://tracker.ceph.com/issues/10773),
    [pr#12366](http://github.com/ceph/ceph/pull/12366), Jason Dillaman)
-   tests,rbd: qa/workunits/rbd: simplify running nbd test under build
    env ([pr#11781](http://github.com/ceph/ceph/pull/11781), Mykola
    Golub)
-   tests,rbd: qa/workunits/rbd: use image id when probing for image
    presence ([issue#18048](http://tracker.ceph.com/issues/18048),
    [pr#12195](http://github.com/ceph/ceph/pull/12195), Mykola Golub)
-   tests,rbd: qa/workunits/rbd: use more recent qemu-iotests that
    support Xenial ([issue#18149](http://tracker.ceph.com/issues/18149),
    [pr#12371](http://github.com/ceph/ceph/pull/12371), Jason Dillaman)
-   tests,rbd: rbd-mirror: fix gmock warnings in bootstrap request unit
    tests ([issue#18156](http://tracker.ceph.com/issues/18156),
    [pr#12344](http://github.com/ceph/ceph/pull/12344), Mykola Golub)
-   tests,rbd: rbd-mirror: improve resiliency of stress test case
    ([issue#17416](http://tracker.ceph.com/issues/17416),
    [pr#11326](http://github.com/ceph/ceph/pull/11326), Jason Dillaman)
-   tests,rbd: test: new librbd discard after write test case
    ([pr#11645](http://github.com/ceph/ceph/pull/11645), Jason Dillaman)
-   tests,rbd: test: skip TestLibRBD.DiscardAfterWrite if skip partial
    discard enabled
    ([issue#17750](http://tracker.ceph.com/issues/17750),
    [pr#11703](http://github.com/ceph/ceph/pull/11703), Jason Dillaman)
-   tests,rbd: test: TestJournalReplay test cases need to wait for event
    commit ([issue#17566](http://tracker.ceph.com/issues/17566),
    [pr#11480](http://github.com/ceph/ceph/pull/11480), Jason Dillaman)
-   tests: remove TestPGLog EXPECT_DEATH tests
    ([issue#18030](http://tracker.ceph.com/issues/18030),
    [pr#12361](http://github.com/ceph/ceph/pull/12361), Loic Dachary)
-   tests: save 9 characters for asok paths
    ([issue#16014](http://tracker.ceph.com/issues/16014),
    [pr#12066](http://github.com/ceph/ceph/pull/12066), Loic Dachary)
-   tests: sync ceph-erasure-code-corpus for using \'arch\' not \'uname
    -p\' ([pr#12024](http://github.com/ceph/ceph/pull/12024), Kefu Chai)
-   tests: test/ceph_crypto: do not read ceph.conf in global_init()
    ([issue#18128](http://tracker.ceph.com/issues/18128),
    [pr#12318](http://github.com/ceph/ceph/pull/12318), Kefu Chai)
-   tests: test: ceph-objectstore-tool: should import platform before
    using it ([pr#12038](http://github.com/ceph/ceph/pull/12038), Kefu
    Chai)
-   tests: test/ceph_test_msgr: do not use <Message::middle> for holding
    transient... ([issue#17728](http://tracker.ceph.com/issues/17728),
    [pr#11680](http://github.com/ceph/ceph/pull/11680), Kefu Chai)
-   tests: test: disable osd-scrub-repair and test-erasure-eio
    ([issue#17830](http://tracker.ceph.com/issues/17830),
    [pr#12058](http://github.com/ceph/ceph/pull/12058), Loic Dachary,
    Dan Mick)
-   tests: test: disable osd-scrub-repair and test-erasure-eio
    ([pr#11979](http://github.com/ceph/ceph/pull/11979), Dan Mick)
-   tests: test: Don\'t write to a poolid that this test might not have
    created ([pr#12378](http://github.com/ceph/ceph/pull/12378), David
    Zafman)
-   tests: test: enable unittest_dns_resolve
    ([pr#12209](http://github.com/ceph/ceph/pull/12209), Kefu Chai)
-   tests: test/encoding/readable.sh: fix shell script warning
    ([pr#11527](http://github.com/ceph/ceph/pull/11527), Willem Jan
    Withagen)
-   tests: TestErasureCodePluginJerasure must stop the log thread
    ([issue#17561](http://tracker.ceph.com/issues/17561),
    [pr#11721](http://github.com/ceph/ceph/pull/11721), Loic Dachary)
-   tests: test: fix test-erasure-eio and osd-scrub-repair races (17830)
    ([pr#11926](http://github.com/ceph/ceph/pull/11926), David Zafman)
-   tests: test/osd-fast-mark-down.sh: wrong assumption on first subtest
    ([pr#12123](http://github.com/ceph/ceph/pull/12123), Piotr Dałek)
-   tests: test/osd/osd-fast-mark-down.sh: introduce large timeout
    ([issue#17918](http://tracker.ceph.com/issues/17918),
    [pr#12019](http://github.com/ceph/ceph/pull/12019), Piotr Dałek)
-   tests: test/osd-scrub-repair.sh: Use test case specific object names
    to help... ([pr#11449](http://github.com/ceph/ceph/pull/11449),
    David Zafman)
-   tests: test/store_test: fix errors on the whole test suite run
    caused by the...
    ([pr#11427](http://github.com/ceph/ceph/pull/11427), Igor Fedotov)
-   tests: test_subman.sh: Don\'t use \--tmpdir
    ([pr#11384](http://github.com/ceph/ceph/pull/11384), Willem Jan
    Withagen)
-   tests: test: test-erasure-eio.sh fix recovery testing and enable it
    ([pr#12170](http://github.com/ceph/ceph/pull/12170), David Zafman)
-   tests: The default changed to disallow pool delete as of #11665; the
    tests assume it\'s allowed.
    ([pr#11897](http://github.com/ceph/ceph/pull/11897), Sage Weil)
-   tests: Turn off tests again due to Jenkins failures
    ([pr#12217](http://github.com/ceph/ceph/pull/12217), David Zafman)
-   tests: unittest_throttle avoid ASSERT_DEATH
    ([issue#18036](http://tracker.ceph.com/issues/18036),
    [pr#12393](http://github.com/ceph/ceph/pull/12393), Loic Dachary)
-   tests: update rbd/singleton/all/formatted-output.yaml to support
    ceph-ci ([issue#18440](http://tracker.ceph.com/issues/18440),
    [pr#12823](http://github.com/ceph/ceph/pull/12823), Nathan Cutler)
-   tests: use shorter directories for tests
    ([issue#16014](http://tracker.ceph.com/issues/16014),
    [pr#12046](http://github.com/ceph/ceph/pull/12046), Loic Dachary)
-   tests: vstart.sh: fix bashism in the script
    ([pr#11889](http://github.com/ceph/ceph/pull/11889), Mykola Golub)
-   tests: workunits/ceph-helpers.sh: FreeBSD returns a different
    errorstring. ([pr#12005](http://github.com/ceph/ceph/pull/12005),
    Willem Jan Withagen)
-   tools: Adding ceph-lazy tool
    ([pr#11055](http://github.com/ceph/ceph/pull/11055), gcharot)
-   tools: ceph-create-keys should not try forever to do things
    ([issue#17753](http://tracker.ceph.com/issues/17753),
    [issue#12649](http://tracker.ceph.com/issues/12649),
    [issue#16255](http://tracker.ceph.com/issues/16255),
    [pr#11749](http://github.com/ceph/ceph/pull/11749), Alfredo Deza)
-   tools: ceph_detect_init: add support for Alpine
    ([pr#8316](http://github.com/ceph/ceph/pull/8316), John Coyle)
-   tools: ceph-disk: fix flake8 errors
    ([issue#17898](http://tracker.ceph.com/issues/17898),
    [pr#11973](http://github.com/ceph/ceph/pull/11973), Ken Dreyer)
-   tools: ceph-disk: prevent unnecessary tracebacks from
    subprocess.check_call
    ([issue#16125](http://tracker.ceph.com/issues/16125),
    [pr#12414](http://github.com/ceph/ceph/pull/12414), Alfredo Deza)
-   tools: ceph-post-file: single command to upload a file to cephdrop
    ([pr#505](http://github.com/ceph/ceph/pull/505), Dan Mick, Travis
    Rhoden)
-   tools: cleanup phase of cephfs-data-scan
    ([pr#12337](http://github.com/ceph/ceph/pull/12337), Vishal
    Kanaujia)
-   tools: osdmaptool: additional tests
    ([pr#1196](http://github.com/ceph/ceph/pull/1196), Sage Weil)
-   tools: osdmaptool: fix divide by zero error
    ([pr#12561](http://github.com/ceph/ceph/pull/12561), Yunchuan Wen)
-   tools: rados: fix segfaults when run without \--pool
    ([issue#17684](http://tracker.ceph.com/issues/17684),
    [pr#11633](http://github.com/ceph/ceph/pull/11633), David
    Disseldorp)
-   tools: rados: optionally support reading omap key from file
    ([issue#18123](http://tracker.ceph.com/issues/18123),
    [pr#12286](http://github.com/ceph/ceph/pull/12286), Jason Dillaman)
-   tools: script/run-coverity: update
    ([pr#12162](http://github.com/ceph/ceph/pull/12162), Sage Weil)
-   tools: script/sepia_bt.sh: a script to prepare for debugging on
    <teuthology@sepia>
    ([pr#12012](http://github.com/ceph/ceph/pull/12012), Kefu Chai)
-   tools: src/vstart.sh: Only execute btrfs if it is available
    ([pr#11683](http://github.com/ceph/ceph/pull/11683), Willem Jan
    Withagen)
-   tools: tools/ceph-monstore-update-crush.sh: FreeBSD getopt is not
    compatible... ([pr#11525](http://github.com/ceph/ceph/pull/11525),
    Willem Jan Withagen)

## v11.0.2 Kraken

This development checkpoint release includes a lot of changes and
improvements to Kraken. This is the first release introducing ceph-mgr,
a new daemon which provides additional monitoring & interfaces to
external monitoring/management systems. There are also many improvements
to bluestore, RGW introduces sync modules, copy part for multipart
uploads and metadata search via elastic search as a tech preview.

### Notable Changes

-   bluestore: os/bluestore: misc fixes
    ([pr#10953](http://github.com/ceph/ceph/pull/10953), Sage Weil)
-   bluestore: os/bluestore/BlueFS: do not op_file_update deleted files
    ([pr#10686](http://github.com/ceph/ceph/pull/10686), Sage Weil)
-   bluestore: bluestore/BitAllocator: Fix deadlock with musl libc
    ([pr#10634](http://github.com/ceph/ceph/pull/10634), John Coyle)
-   bluestore: bluestore/BlueFS: revert direct IO for WRITER_WAL
    ([pr#11059](http://github.com/ceph/ceph/pull/11059), Mark Nelson)
-   bluestore: ceph-disk: support creating block.db and block.wal with
    customized size for bluestore
    ([pr#10135](http://github.com/ceph/ceph/pull/10135), Zhi Zhang)
-   bluestore: compressor/zlib: switch to raw deflate
    ([pr#11122](http://github.com/ceph/ceph/pull/11122), Piotr Dałek)
-   bluestore: do not use freelist to track bluefs_extents
    ([pr#10698](http://github.com/ceph/ceph/pull/10698), Sage Weil)
-   bluestore: initialize csum_order properly
    ([pr#10728](http://github.com/ceph/ceph/pull/10728), xie xingguo)
-   bluestore: kv/rocksdb: dump transactions on error
    ([pr#11042](http://github.com/ceph/ceph/pull/11042), Somnath Roy)
-   bluestore: kv: In memory keyvalue db implementation
    ([pr#9933](http://github.com/ceph/ceph/pull/9933), Ramesh Chander)
-   bluestore: os/bluestore/BitAllocator: batch is_allocated bit checks
    ([pr#10704](http://github.com/ceph/ceph/pull/10704), Ramesh Chander)
-   bluestore: os/bluestore/BlueFS: For logs of rocksdb & bluefs only
    use directio. ([pr#11012](http://github.com/ceph/ceph/pull/11012),
    Jianpeng Ma)
-   bluestore: os/bluestore/BlueFS: async compaction
    ([pr#10717](http://github.com/ceph/ceph/pull/10717), Varada Kari,
    Sage Weil)
-   bluestore: os/bluestore/BlueFS: do not hold internal lock while
    waiting for IO ([pr#9898](http://github.com/ceph/ceph/pull/9898),
    Varada Kari, Sage Weil)
-   bluestore: os/bluestore/BlueFS: do not start racing async compaction
    ([pr#11010](http://github.com/ceph/ceph/pull/11010), Sage Weil)
-   bluestore: os/bluestore/BlueFS: don\'t inc
    l_bluefs_files_written_wal if overwrite.
    ([pr#10143](http://github.com/ceph/ceph/pull/10143), Jianpeng Ma)
-   bluestore: os/bluestore/BlueFS: factor unflushed log into runway
    calculation ([pr#10966](http://github.com/ceph/ceph/pull/10966),
    Sage Weil)
-   bluestore: os/bluestore/BlueFS: fix async compaction logging bug
    ([pr#10964](http://github.com/ceph/ceph/pull/10964), Sage Weil)
-   bluestore: os/bluestore/BlueFS: log dirty files at sync time
    ([pr#11108](http://github.com/ceph/ceph/pull/11108), Sage Weil)
-   bluestore: os/bluestore/BlueFS: only extend extent on same bdev
    ([pr#11023](http://github.com/ceph/ceph/pull/11023), Sage Weil)
-   bluestore: os/bluestore/BlueFS: prevent concurrent async compaction
    ([pr#11095](http://github.com/ceph/ceph/pull/11095), Sage Weil)
-   bluestore: os/bluestore/BlueFS: release completed aios
    ([pr#11268](http://github.com/ceph/ceph/pull/11268), Sage Weil)
-   bluestore: os/bluestore/BlueFS: use StupidAllocator; fix async
    compaction bug ([pr#11087](http://github.com/ceph/ceph/pull/11087),
    Sage Weil)
-   bluestore: os/bluestore/bluefs: add file refs check
    ([pr#10863](http://github.com/ceph/ceph/pull/10863), xie xingguo)
-   bluestore: os/bluestore/bluefs: use map to track dirty files
    ([pr#10923](http://github.com/ceph/ceph/pull/10923), xie xingguo)
-   bluestore: os/bluestore/bluefs_types: fix extent operator\<\<
    ([pr#10685](http://github.com/ceph/ceph/pull/10685), Sage Weil)
-   bluestore: os/bluestore/bluestore_types: uint64_t for ref_map
    ([pr#11267](http://github.com/ceph/ceph/pull/11267), Sage Weil)
-   bluestore: os/bluestore: Hint based allocation in bitmap Allocator
    ([pr#10978](http://github.com/ceph/ceph/pull/10978), Ramesh Chander)
-   bluestore: os/bluestore: Remove bit alloc Woverloaded-virtual
    warnings ([pr#10082](http://github.com/ceph/ceph/pull/10082), Ramesh
    Chander)
-   bluestore: os/bluestore: a few cleanups
    ([pr#11192](http://github.com/ceph/ceph/pull/11192), xie xingguo)
-   bluestore: os/bluestore: a few fixes about the global csum setting
    ([pr#11195](http://github.com/ceph/ceph/pull/11195), xie xingguo)
-   bluestore: os/bluestore: add assert to compress_extent_map
    ([pr#11240](http://github.com/ceph/ceph/pull/11240), Sage Weil)
-   bluestore: os/bluestore: add cache-related stats
    ([pr#10961](http://github.com/ceph/ceph/pull/10961), xie xingguo)
-   bluestore: os/bluestore: add checks and kill unreachable code
    ([pr#11077](http://github.com/ceph/ceph/pull/11077), xie xingguo)
-   bluestore: os/bluestore: add error injection
    ([pr#11151](http://github.com/ceph/ceph/pull/11151), Sage Weil)
-   bluestore: os/bluestore: add max blob size; fix compressed min blob
    size logic ([pr#11239](http://github.com/ceph/ceph/pull/11239), Sage
    Weil)
-   bluestore: os/bluestore: add multiple finishers to bluestore
    ([pr#10780](http://github.com/ceph/ceph/pull/10780), Ilsoo Byun)
-   bluestore: os/bluestore: add perf counters for compression
    effectiveness and space utilization measurements
    ([pr#10449](http://github.com/ceph/ceph/pull/10449), Igor Fedotov)
-   bluestore: os/bluestore: apply \"small encoding\" for
    onode_t::extents map
    ([pr#10018](http://github.com/ceph/ceph/pull/10018), Igor Fedotov)
-   bluestore: os/bluestore: avoid blob_t reencode when unchanged
    ([pr#10768](http://github.com/ceph/ceph/pull/10768), Sage Weil)
-   bluestore: os/bluestore: binary search specified shard
    ([pr#11245](http://github.com/ceph/ceph/pull/11245), xie xingguo)
-   bluestore: os/bluestore: change algorithm of compression header from
    string to int ([pr#10137](http://github.com/ceph/ceph/pull/10137),
    xie xingguo)
-   bluestore: os/bluestore: compaction fixes
    ([pr#11279](http://github.com/ceph/ceph/pull/11279), Sage Weil)
-   bluestore: os/bluestore: drop redundant call of get_blob
    ([pr#11275](http://github.com/ceph/ceph/pull/11275), xie xingguo)
-   bluestore: os/bluestore: drop unreferenced spanning blobs
    ([pr#11212](http://github.com/ceph/ceph/pull/11212), Sage Weil)
-   bluestore: os/bluestore: fix a few leaks
    ([pr#11068](http://github.com/ceph/ceph/pull/11068), Sage Weil)
-   bluestore: os/bluestore: fix a few memory utilization leaks and
    wasters ([pr#11011](http://github.com/ceph/ceph/pull/11011), Sage
    Weil)
-   bluestore: os/bluestore: fix crash in decode_some()
    ([pr#11312](http://github.com/ceph/ceph/pull/11312), Sage Weil)
-   bluestore: os/bluestore: fix decoding hash of bnode
    ([pr#10773](http://github.com/ceph/ceph/pull/10773), xie xingguo)
-   bluestore: os/bluestore: fix fsck() won\'t catch stray shard
    sometimes ([pr#11219](http://github.com/ceph/ceph/pull/11219), xie
    xingguo)
-   bluestore: os/bluestore: fix gc when blob extends past eof
    ([pr#11282](http://github.com/ceph/ceph/pull/11282), Sage Weil)
-   bluestore: os/bluestore: fix improper local var variable in
    collection_list meth...
    ([pr#10680](http://github.com/ceph/ceph/pull/10680), Igor Fedotov)
-   bluestore: os/bluestore: fix incorrect pool decoding of bnode
    ([pr#10117](http://github.com/ceph/ceph/pull/10117), xie xingguo)
-   bluestore: os/bluestore: fix leak of result-checking of
    \_fsck_check_extents
    ([pr#11040](http://github.com/ceph/ceph/pull/11040), xie xingguo)
-   bluestore: os/bluestore: fix leaks in our use of rocksdb
    ([pr#11250](http://github.com/ceph/ceph/pull/11250), Sage Weil)
-   bluestore: os/bluestore: fix memory leak during bit_alloc testing
    ([pr#9935](http://github.com/ceph/ceph/pull/9935), xie xingguo)
-   bluestore: os/bluestore: fix offset bug in \_do_write_small.
    ([pr#11030](http://github.com/ceph/ceph/pull/11030), amoxic)
-   bluestore: os/bluestore: fix onode cache addition race
    ([pr#11300](http://github.com/ceph/ceph/pull/11300), Sage Weil)
-   bluestore: os/bluestore: fix potential access violation
    ([pr#10362](http://github.com/ceph/ceph/pull/10362), xie xingguo)
-   bluestore: os/bluestore: fix potential access violation during
    rename ([pr#11033](http://github.com/ceph/ceph/pull/11033), xie
    xingguo)
-   bluestore: os/bluestore: fix shard\_<info::dump>()
    ([pr#11061](http://github.com/ceph/ceph/pull/11061), xie xingguo)
-   bluestore: os/bluestore: fix spanning blob leak from \~ExtentMap
    ([pr#11223](http://github.com/ceph/ceph/pull/11223), Somnath Roy)
-   bluestore: os/bluestore: fix statfs tests
    ([pr#10910](http://github.com/ceph/ceph/pull/10910), Sage Weil)
-   bluestore: os/bluestore: fix when block device is not a multiple of
    the block size ([pr#10844](http://github.com/ceph/ceph/pull/10844),
    Sage Weil)
-   bluestore: os/bluestore: fix write_big counter and some more
    cleanups ([pr#11344](http://github.com/ceph/ceph/pull/11344), xie
    xingguo)
-   bluestore: os/bluestore: fix/improve csum error message
    ([pr#10938](http://github.com/ceph/ceph/pull/10938), Sage Weil)
-   bluestore: os/bluestore: garbage collect partially overlapped blobs
    ([pr#11232](http://github.com/ceph/ceph/pull/11232), Roushan Ali)
-   bluestore: os/bluestore: get rid off \"isa-l\" type in
    ZLibCompressor ctor
    ([pr#10931](http://github.com/ceph/ceph/pull/10931), xie xingguo)
-   bluestore: os/bluestore: gifting bluefs more carefully
    ([pr#10950](http://github.com/ceph/ceph/pull/10950), xie xingguo)
-   bluestore: os/bluestore: honour allow-eio flag; use global
    compressor if possible
    ([pr#10970](http://github.com/ceph/ceph/pull/10970), xie xingguo)
-   bluestore: os/bluestore: improve required compression threshold
    ([pr#10080](http://github.com/ceph/ceph/pull/10080), xie xingguo)
-   bluestore: os/bluestore: include bluefs space in statfs result
    ([pr#10795](http://github.com/ceph/ceph/pull/10795), Sage Weil)
-   bluestore: os/bluestore: introduce power 2 macros for block
    alignment and rounding
    ([pr#10128](http://github.com/ceph/ceph/pull/10128), xie xingguo)
-   bluestore: os/bluestore: make assert conditional with macro for
    allocator ([pr#11014](http://github.com/ceph/ceph/pull/11014),
    Ramesh Chander)
-   bluestore: os/bluestore: make cache settings process-wide
    ([pr#11295](http://github.com/ceph/ceph/pull/11295), Sage Weil)
-   bluestore: os/bluestore: make clone_range copy-on-write
    ([pr#11106](http://github.com/ceph/ceph/pull/11106), Sage Weil)
-   bluestore: os/bluestore: make onode keys more efficient (and sort
    correctly) ([pr#11009](http://github.com/ceph/ceph/pull/11009), xie
    xingguo, Sage Weil)
-   bluestore: os/bluestore: make trim() of 2Q cache more fine-grained
    ([pr#9946](http://github.com/ceph/ceph/pull/9946), xie xingguo)
-   bluestore: os/bluestore: make zone/span size of bitmap-allocator
    configurable ([pr#10040](http://github.com/ceph/ceph/pull/10040),
    xie xingguo)
-   bluestore: os/bluestore: misc cleanup and test fixes
    ([pr#11346](http://github.com/ceph/ceph/pull/11346), Igor Fedotov)
-   bluestore: os/bluestore: misc cleanups
    ([pr#10201](http://github.com/ceph/ceph/pull/10201), xie xingguo)
-   bluestore: os/bluestore: misc cleanups
    ([pr#11197](http://github.com/ceph/ceph/pull/11197), Haomai Wang)
-   bluestore: os/bluestore: misc fixes
    ([pr#9999](http://github.com/ceph/ceph/pull/9999), xie xingguo)
-   bluestore: os/bluestore: misc fixes
    ([pr#10771](http://github.com/ceph/ceph/pull/10771), xie xingguo)
-   bluestore: os/bluestore: misc. fixes
    ([pr#11129](http://github.com/ceph/ceph/pull/11129), xie xingguo)
-   bluestore: os/bluestore: more cleanups
    ([pr#11235](http://github.com/ceph/ceph/pull/11235), xie xingguo)
-   bluestore: os/bluestore: more cleanups and fixes
    ([pr#11210](http://github.com/ceph/ceph/pull/11210), xie xingguo)
-   bluestore: os/bluestore: narrow condition of sanity check when
    get_object_key()
    ([pr#11149](http://github.com/ceph/ceph/pull/11149), xie xingguo)
-   bluestore: os/bluestore: narrow lock scope for cache trim()
    ([pr#10410](http://github.com/ceph/ceph/pull/10410), xie xingguo)
-   bluestore: os/bluestore: optimize intrusive sets for size.
    ([pr#11319](http://github.com/ceph/ceph/pull/11319), Mark Nelson)
-   bluestore: os/bluestore: pack a few more in-memory types
    ([pr#11328](http://github.com/ceph/ceph/pull/11328), Sage Weil)
-   bluestore: os/bluestore: precondition rocksdb/bluefs during mkfs
    ([pr#10814](http://github.com/ceph/ceph/pull/10814), Sage Weil)
-   bluestore: os/bluestore: prevent extent merging across shard
    boundaries ([pr#11216](http://github.com/ceph/ceph/pull/11216), Sage
    Weil)
-   bluestore: os/bluestore: print bluefs_extents in hex
    ([pr#10689](http://github.com/ceph/ceph/pull/10689), Sage Weil)
-   bluestore: os/bluestore: proper handling for csum enable/disable
    settings ([pr#10431](http://github.com/ceph/ceph/pull/10431), Igor
    Fedotov)
-   bluestore: os/bluestore: refactor dirty blob tracking along with
    some related fixes
    ([pr#10215](http://github.com/ceph/ceph/pull/10215), Igor Fedotov)
-   bluestore: os/bluestore: remove cmake warning from extent alloc
    functions ([issue#16766](http://tracker.ceph.com/issues/16766),
    [pr#10492](http://github.com/ceph/ceph/pull/10492), Ramesh Chander)
-   bluestore: os/bluestore: remove deferred_csum machinery
    ([pr#11243](http://github.com/ceph/ceph/pull/11243), Sage Weil)
-   bluestore: os/bluestore: remove some copy-pastes
    ([pr#11017](http://github.com/ceph/ceph/pull/11017), Igor Fedotov)
-   bluestore: os/bluestore: replace store with logger in Cache
    ([pr#10969](http://github.com/ceph/ceph/pull/10969), xie xingguo)
-   bluestore: os/bluestore: shard extent map
    ([pr#10963](http://github.com/ceph/ceph/pull/10963), Sage Weil)
-   bluestore: os/bluestore: simplify LRUCache::trim()
    ([pr#10109](http://github.com/ceph/ceph/pull/10109), xie xingguo)
-   bluestore: os/bluestore: simplify calculation of collection key
    range ([pr#11166](http://github.com/ceph/ceph/pull/11166), xie
    xingguo)
-   bluestore: os/bluestore: sloppy reshard boundaries to avoid spanning
    blobs ([pr#11263](http://github.com/ceph/ceph/pull/11263), Sage
    Weil)
-   bluestore: os/bluestore: still more cleanups
    ([pr#11274](http://github.com/ceph/ceph/pull/11274), xie xingguo)
-   bluestore: os/bluestore: switch spanning_blob_map to std::map
    ([pr#11336](http://github.com/ceph/ceph/pull/11336), Sage Weil)
-   bluestore: os/bluestore: trim cache on reads
    ([pr#10095](http://github.com/ceph/ceph/pull/10095), Sage Weil)
-   bluestore: os/bluestore: try to split blobs instead of spanning them
    ([pr#11264](http://github.com/ceph/ceph/pull/11264), Sage Weil)
-   bluestore: os/bluestore: upgrade compression settings to atomics
    ([pr#11244](http://github.com/ceph/ceph/pull/11244), xie xingguo)
-   bluestore: os/bluestore: use small encoding for bluefs extent and
    fnode ([pr#10375](http://github.com/ceph/ceph/pull/10375), xie
    xingguo)
-   bluestore: os/bluestore: yet another statfs test fix
    ([pr#10926](http://github.com/ceph/ceph/pull/10926), Igor Fedotov)
-   bluestore: os/bluestore:Fix size calculation in bitallocator
    ([pr#10377](http://github.com/ceph/ceph/pull/10377), Ramesh Chander)
-   bluestore: os/bluestore: fix error handling of posix_fallocate()
    ([pr#10277](http://github.com/ceph/ceph/pull/10277), xie xingguo)
-   bluestore: os/bluestore: use BE for gifting and reclaiming from
    bluefs ([pr#10294](http://github.com/ceph/ceph/pull/10294), xie
    xingguo)
-   bluestore: os/bluestore: get rid off blob\'s ref_map for non-shared
    objects ([pr#9988](http://github.com/ceph/ceph/pull/9988), Igor
    Fedotov)
-   bluestore: kv/MemDB: fix wrong output target and add sanity checks
    ([pr#10358](http://github.com/ceph/ceph/pull/10358), xie xingguo)
-   bluestore: os/bluestore: add a boundary check of cache read
    ([pr#10349](http://github.com/ceph/ceph/pull/10349), xie xingguo)
-   bluestore: os/bluestore: fix bitmap allocating failure if
    max_alloc_size is 0
    ([pr#10379](http://github.com/ceph/ceph/pull/10379), xie xingguo)
-   bluestore: os/bluestore: misc fixes
    ([pr#10327](http://github.com/ceph/ceph/pull/10327), xie xingguo)
-   bluestore: kv/MemDB: misc fixes and cleanups
    ([pr#10295](http://github.com/ceph/ceph/pull/10295), xie xingguo)
-   bluestore: rocksdb: pull up to master (4.12 + a few patches)
    ([pr#11069](http://github.com/ceph/ceph/pull/11069), Sage Weil)
-   bluestore: test/store_test: extend Bluestore compression test to
    verify compress...
    ([pr#11080](http://github.com/ceph/ceph/pull/11080), Igor Fedotov)
-   bluestore: test/store_test: fix statfs results check to consider SSD
    min_alloc_size ([pr#11096](http://github.com/ceph/ceph/pull/11096),
    Igor Fedotov)
-   bluestore: unittest_bluestore_types: a few more types for sizeof
    ([pr#11323](http://github.com/ceph/ceph/pull/11323), Sage Weil)
-   bluestore: ceph_test_objectstore: test clone_range and fix a few
    bugs ([pr#11103](http://github.com/ceph/ceph/pull/11103), Sage Weil)
-   bluestore: kv: fix some bugs in memdb
    ([pr#10550](http://github.com/ceph/ceph/pull/10550), Haodong Tang)
-   bluestore: os/bluestore/BlueFS: disable buffered io
    ([pr#10766](http://github.com/ceph/ceph/pull/10766), Sage Weil)
-   build/ops,bluestore: test/objectstore/CMakeLists.txt: fix libaio
    conditional ([pr#11008](http://github.com/ceph/ceph/pull/11008),
    Sage Weil)
-   build/ops,cephfs: client: added def for ACCESSPERMS when undefined
    ([pr#9835](http://github.com/ceph/ceph/pull/9835), John Coyle)
-   build/ops,cephfs: deb: merge ceph-fs-common into ceph-common
    ([issue#16808](http://tracker.ceph.com/issues/16808),
    [pr#10433](http://github.com/ceph/ceph/pull/10433), Nathan Cutler)
-   build/ops,cephfs: man/Makefile-client.am: drop legacy cephfs tool
    ([pr#10444](http://github.com/ceph/ceph/pull/10444), Nathan Cutler)
-   build/ops,cephfs: test: break out librados-using cephfs test
    ([issue#16556](http://tracker.ceph.com/issues/16556),
    [pr#10452](http://github.com/ceph/ceph/pull/10452), John Spray)
-   build/ops,common: common/dns_resolve: use ns_name_uncompress instead
    of ns_name_ntop ([pr#9755](http://github.com/ceph/ceph/pull/9755),
    John Coyle)
-   build/ops,common: msg/async/net_handler.cc: make it more compatible
    with BSDs ([pr#10029](http://github.com/ceph/ceph/pull/10029),
    Willem Jan Withagen)
-   build/ops,pybind: Include Python 3 bindings into the cmake build and
    make packages for them
    ([pr#10208](http://github.com/ceph/ceph/pull/10208), Oleh Prypin)
-   build/ops,rbd: systemd: add install section to rbdmap.service file
    ([pr#10942](http://github.com/ceph/ceph/pull/10942), Jelle vd Kooij)
-   build/ops,rbd: test: fix rbd-mirror workunit test cases for cmake
    ([pr#10076](http://github.com/ceph/ceph/pull/10076), Jason Dillaman)
-   build/ops,rgw: rgw-ldap: add ldap lib to rgw lib deps based on build
    config ([pr#9852](http://github.com/ceph/ceph/pull/9852), John
    Coyle)
-   build/ops: .gitignore: Add .pyc files globally
    ([pr#11076](http://github.com/ceph/ceph/pull/11076), Brad Hubbard)
-   build/ops: Allow compressor build without YASM
    ([pr#10937](http://github.com/ceph/ceph/pull/10937), Daniel
    Gryniewicz)
-   build/ops: CMake - stop pip checking for updates
    ([pr#10161](http://github.com/ceph/ceph/pull/10161), Daniel
    Gryniewicz)
-   build/ops: CMakeList.txt: link ceph_objectstore_tool against fuse
    only if WITH_FUSE
    ([pr#10149](http://github.com/ceph/ceph/pull/10149), Willem Jan
    Withagen)
-   build/ops: Cmake: fix using CMAKE_DL_LIBS instead of dl
    ([pr#10317](http://github.com/ceph/ceph/pull/10317), Willem Jan
    Withagen)
-   build/ops: CmakeLists.txt: use LIB_RESOLV instead of resolv.
    ([pr#10972](http://github.com/ceph/ceph/pull/10972), Willem Jan
    Withagen)
-   build/ops: Enable builds without ceph-test subpackage
    ([issue#16776](http://tracker.ceph.com/issues/16776),
    [pr#10872](http://github.com/ceph/ceph/pull/10872), Ricardo Dias)
-   build/ops: Fix libatomic_ops-devel in SUSE and specfile cleanup
    ([issue#16645](http://tracker.ceph.com/issues/16645),
    [pr#10363](http://github.com/ceph/ceph/pull/10363), Nathan Cutler)
-   build/ops: FreeBSD: Define CLOCK_REALTIME_COARSE in compat.h
    ([pr#10506](http://github.com/ceph/ceph/pull/10506), Willem Jan
    Withagen)
-   build/ops: Gentoo support for ceph-disk / ceph-detect-init; pip
    speedup ([pr#8317](http://github.com/ceph/ceph/pull/8317), Robin H.
    Johnson)
-   build/ops: LTTng-UST disabled for openSUSE
    ([issue#16937](http://tracker.ceph.com/issues/16937),
    [pr#10592](http://github.com/ceph/ceph/pull/10592), Michel Normand)
-   build/ops: Port ceph-brag to Python 3 (+ small fixes)
    ([pr#10064](http://github.com/ceph/ceph/pull/10064), Oleh Prypin)
-   build/ops: Removes remaining reference to WITH_MDS
    ([pr#10286](http://github.com/ceph/ceph/pull/10286), J. Eric
    Ivancich)
-   build/ops: Stop hiding errors from run-tox.sh
    ([issue#17267](http://tracker.ceph.com/issues/17267),
    [pr#11071](http://github.com/ceph/ceph/pull/11071), Dan Mick)
-   build/ops: Wip kill warnings
    ([pr#10881](http://github.com/ceph/ceph/pull/10881), Kefu Chai)
-   build/ops: autogen: Fix rocksdb error when make dist
    ([pr#10988](http://github.com/ceph/ceph/pull/10988), tianqing)
-   build/ops: autotools: remove a few other remaining traces
    ([pr#11019](http://github.com/ceph/ceph/pull/11019), Sage Weil)
-   build/ops: build scripts: Enable dnf for Fedora \>= 22
    ([pr#11105](http://github.com/ceph/ceph/pull/11105), Brad Hubbard)
-   build/ops: build: drop dryrun of autogen.sh from run-cmake-check.sh
    script ([pr#11013](http://github.com/ceph/ceph/pull/11013), xie
    xingguo)
-   build/ops: ceph-disk tests: Let missing python interpreters be
    non-fatal ([pr#11072](http://github.com/ceph/ceph/pull/11072), Dan
    Mick)
-   build/ops: ceph-disk: Compatibility fixes for Python 3
    ([pr#9936](http://github.com/ceph/ceph/pull/9936), Anirudha Bose)
-   build/ops: ceph-disk: do not activate device that is not ready
    ([issue#15990](http://tracker.ceph.com/issues/15990),
    [pr#9943](http://github.com/ceph/ceph/pull/9943), Boris Ranto)
-   build/ops: ceph-osd-prestart.sh: check existence of OSD data
    directory ([issue#17091](http://tracker.ceph.com/issues/17091),
    [pr#10809](http://github.com/ceph/ceph/pull/10809), Nathan Cutler)
-   build/ops: ceph-osd-prestart.sh: drop Upstart-specific code
    ([issue#15984](http://tracker.ceph.com/issues/15984),
    [pr#9667](http://github.com/ceph/ceph/pull/9667), Nathan Cutler)
-   build/ops: ceph-post-file replace DSA with RSA ssh key
    ([issue#14267](http://tracker.ceph.com/issues/14267),
    [pr#10800](http://github.com/ceph/ceph/pull/10800), David Galloway)
-   build/ops: ceph.spec.in: don\'t try to package \_\_pycache\_\_ for
    SUSE ([issue#17106](http://tracker.ceph.com/issues/17106),
    [pr#10805](http://github.com/ceph/ceph/pull/10805), Tim Serong)
-   build/ops: ceph.spec.in: fix rpm package building error
    ([pr#10115](http://github.com/ceph/ceph/pull/10115), runsisi)
-   build/ops: changes for Clang and yasm
    ([pr#10417](http://github.com/ceph/ceph/pull/10417), Willem Jan
    Withagen)
-   build/ops: cmake changes
    ([pr#10351](http://github.com/ceph/ceph/pull/10351), Kefu Chai)
-   build/ops: cmake changes
    ([pr#10059](http://github.com/ceph/ceph/pull/10059), Kefu Chai)
-   build/ops: cmake changes
    ([pr#10279](http://github.com/ceph/ceph/pull/10279), Kefu Chai)
-   build/ops: cmake changes
    ([issue#16804](http://tracker.ceph.com/issues/16804),
    [pr#10391](http://github.com/ceph/ceph/pull/10391), Kefu Chai)
-   build/ops: cmake changes
    ([pr#10361](http://github.com/ceph/ceph/pull/10361), Kefu Chai)
-   build/ops: cmake changes
    ([pr#10112](http://github.com/ceph/ceph/pull/10112), Kefu Chai)
-   build/ops: cmake changes
    ([pr#10489](http://github.com/ceph/ceph/pull/10489), Kefu Chai)
-   build/ops: cmake changes
    ([pr#10283](http://github.com/ceph/ceph/pull/10283), Kefu Chai)
-   build/ops: cmake changes
    ([issue#16504](http://tracker.ceph.com/issues/16504),
    [pr#9995](http://github.com/ceph/ceph/pull/9995), Kefu Chai, Sage
    Weil, Dan Mick)
-   build/ops: cmake changes
    ([pr#9975](http://github.com/ceph/ceph/pull/9975), Kefu Chai)
-   build/ops: cmake changes related to LTTng-UST
    ([pr#10917](http://github.com/ceph/ceph/pull/10917), Kefu Chai)
-   build/ops: common/compressor: add libcommon as a dependency for zlib
    and snappy p... ([pr#11083](http://github.com/ceph/ceph/pull/11083),
    Igor Fedotov)
-   build/ops: compat: add abstractions for non portable pthread name
    funcs ([pr#9763](http://github.com/ceph/ceph/pull/9763), John Coyle)
-   build/ops: configure.ac: Use uname instead of arch.
    ([pr#9766](http://github.com/ceph/ceph/pull/9766), John Coyle)
-   build/ops: configure.ac: add \_LIBS variables for boost_system and
    boost_iostreams ([pr#9848](http://github.com/ceph/ceph/pull/9848),
    John Coyle)
-   build/ops: configure.ac: fix res_query detection
    ([pr#9820](http://github.com/ceph/ceph/pull/9820), John Coyle)
-   build/ops: debian and cmake cleanups
    ([pr#10788](http://github.com/ceph/ceph/pull/10788), Kefu Chai)
-   build/ops: debian: bump compat to 9
    ([issue#16744](http://tracker.ceph.com/issues/16744),
    [pr#10366](http://github.com/ceph/ceph/pull/10366), Kefu Chai)
-   build/ops: debian: python related changes
    ([pr#10322](http://github.com/ceph/ceph/pull/10322), Kefu Chai)
-   build/ops: debian: replace SysV rbdmap with systemd service
    ([pr#10435](http://github.com/ceph/ceph/pull/10435), Ken Dreyer)
-   build/ops: debian: set libexec dir to correct value as autotools did
    ([pr#10096](http://github.com/ceph/ceph/pull/10096), Daniel
    Gryniewicz)
-   build/ops: do_cmake.sh: set up initial plugin dir
    ([pr#10067](http://github.com/ceph/ceph/pull/10067), Sage Weil)
-   build/ops: fix /etc/os-release parsing in install-deps.sh
    ([pr#10981](http://github.com/ceph/ceph/pull/10981), Nathan Cutler)
-   build/ops: fix the rpm build for centos
    ([pr#10289](http://github.com/ceph/ceph/pull/10289), Oleh Prypin,
    Josh Durgin)
-   build/ops: force Python 3 packages to build in SUSE
    ([issue#17106](http://tracker.ceph.com/issues/17106),
    [pr#10894](http://github.com/ceph/ceph/pull/10894), Dominique
    Leuenberger, Nathan Cutler)
-   build/ops: install-deps.sh based on /etc/os-release
    ([issue#16522](http://tracker.ceph.com/issues/16522),
    [pr#10017](http://github.com/ceph/ceph/pull/10017), Jan Fajerski)
-   build/ops: install-deps: exit non-zero when we cannot match distro
    ([pr#10941](http://github.com/ceph/ceph/pull/10941), Gregory Meno)
-   build/ops: isa-l: add isa-l library as a submodule
    ([pr#10066](http://github.com/ceph/ceph/pull/10066), Alyona
    Kiseleva)
-   build/ops: jerasure: include generic objects in neon jerasure lib
    (like sse3/4) ([pr#10879](http://github.com/ceph/ceph/pull/10879),
    Dan Mick)
-   build/ops: logrotate: Run as root/ceph
    ([pr#10587](http://github.com/ceph/ceph/pull/10587), Boris Ranto)
-   build/ops: lttng: build the tracepoint provider lib from .c files in
    repo ([pr#11196](http://github.com/ceph/ceph/pull/11196), Kefu Chai)
-   build/ops: make-dist: generate ceph.spec
    ([issue#16501](http://tracker.ceph.com/issues/16501),
    [pr#9986](http://github.com/ceph/ceph/pull/9986), Sage Weil)
-   build/ops: make-dist: set rpm_release correctly for release builds
    ([pr#11334](http://github.com/ceph/ceph/pull/11334), Dan Mick)
-   build/ops: make-srpm.sh: A simple script to make the srpm for ceph.
    ([pr#11064](http://github.com/ceph/ceph/pull/11064), Ira Cooper)
-   build/ops: makefile: change [librgw_file]()\* as check_PROGRAMS
    ([issue#16646](http://tracker.ceph.com/issues/16646),
    [pr#10229](http://github.com/ceph/ceph/pull/10229), Brad Hubbard)
-   build/ops: remove autotools
    ([pr#11007](http://github.com/ceph/ceph/pull/11007), Sage Weil)
-   build/ops: rpm: Do not start targets on update
    ([pr#9968](http://github.com/ceph/ceph/pull/9968), Nathan Cutler,
    Boris Ranto)
-   build/ops: rpm: ExclusiveArch for suse_version
    ([issue#16936](http://tracker.ceph.com/issues/16936),
    [pr#10594](http://github.com/ceph/ceph/pull/10594), Michel Normand)
-   build/ops: rpm: Fix creation of mount.ceph symbolic link for SUSE
    distros ([pr#10353](http://github.com/ceph/ceph/pull/10353), Ricardo
    Dias)
-   build/ops: rpm: add udev BuildRequires to provide /usr/lib/udev
    directory ([issue#16949](http://tracker.ceph.com/issues/16949),
    [pr#10608](http://github.com/ceph/ceph/pull/10608), Nathan Cutler)
-   build/ops: rpm: build rpm with cmake
    ([pr#10016](http://github.com/ceph/ceph/pull/10016), Kefu Chai)
-   build/ops: rpm: drop obsolete libs-compat and python-ceph-compat
    metapackages ([issue#16353](http://tracker.ceph.com/issues/16353),
    [pr#9757](http://github.com/ceph/ceph/pull/9757), Nathan Cutler)
-   build/ops: rpm: fix permissions for /etc/ceph/rbdmap
    ([issue#17395](http://tracker.ceph.com/issues/17395),
    [pr#11217](http://github.com/ceph/ceph/pull/11217), Ken Dreyer)
-   build/ops: rpm: fix shared library devel package names and
    dependencies ([issue#16345](http://tracker.ceph.com/issues/16345),
    [issue#16346](http://tracker.ceph.com/issues/16346),
    [pr#9744](http://github.com/ceph/ceph/pull/9744), Nathan Cutler, Ken
    Dreyer)
-   build/ops: rpm: move mount.ceph from ceph-base to ceph-common and
    add symlink in /sbin for SUSE
    ([issue#16598](http://tracker.ceph.com/issues/16598),
    [pr#10147](http://github.com/ceph/ceph/pull/10147), Nathan Cutler)
-   build/ops: run-cmake-check.sh: Remove redundant calls
    ([pr#11116](http://github.com/ceph/ceph/pull/11116), Brad Hubbard)
-   build/ops: script: improve ceph-release-notes regex
    ([pr#10729](http://github.com/ceph/ceph/pull/10729), Nathan Cutler)
-   build/ops: src/CMakeLists.txt: remove double flag
    -Wno-invalid-offsetof
    ([pr#10443](http://github.com/ceph/ceph/pull/10443), Willem Jan
    Withagen)
-   build/ops: src/CMakeLists.txt: remove unneeded libraries from
    ceph-dencoder target
    ([pr#10478](http://github.com/ceph/ceph/pull/10478), Willem Jan
    Withagen)
-   build/ops: src/global/pidfile.cc: Assign elements in structures
    individually ([pr#10516](http://github.com/ceph/ceph/pull/10516),
    Willem Jan Withagen)
-   build/ops: src/kv/CMakeLists.txt: force rocksdb/include to first
    include directory
    ([pr#11194](http://github.com/ceph/ceph/pull/11194), Willem Jan
    Withagen)
-   build/ops: test/common/test_util.cc: FreeBSD does not have distro
    information ([pr#10547](http://github.com/ceph/ceph/pull/10547),
    Willem Jan Withagen)
-   build/ops: test: make check using cmake
    ([pr#10116](http://github.com/ceph/ceph/pull/10116), Kefu Chai, Sage
    Weil)
-   build/ops: verfied f23
    ([pr#10222](http://github.com/ceph/ceph/pull/10222), Kefu Chai)
-   build/ops: yasm-wrapper: dont echo the yasm command line
    ([pr#10819](http://github.com/ceph/ceph/pull/10819), Casey Bodley)
-   build/ops: .gitignore: exclude coredumps, logfiles and temporary
    testresults ([pr#8150](http://github.com/ceph/ceph/pull/8150),
    Willem Jan Withagen)
-   build/ops: this fixes the broken build
    ([pr#9992](http://github.com/ceph/ceph/pull/9992), Haomai Wang)
-   build/ops: mrgw: search for cmake build dir.
    ([pr#10180](http://github.com/ceph/ceph/pull/10180), Abhishek
    Lekshmanan)
-   build/ops: mrun, mstart.sh, mstop.sh: search for cmake build
    directory ([pr#10097](http://github.com/ceph/ceph/pull/10097),
    Yehuda Sadeh)
-   build/ops: arm64
    fixes([pr#10438](http://github.com/ceph/ceph/pull/10438), Dan Mick)
-   build/ops: Wip kill warnings
    ([pr#10934](http://github.com/ceph/ceph/pull/10934), Kefu Chai)
-   build/ops: systemd: add osd id to service description
    ([pr#10091](http://github.com/ceph/ceph/pull/10091), Ruben Kerkhof)
-   build/ops: fix wrong indent caused compile warning
    ([pr#10014](http://github.com/ceph/ceph/pull/10014), Wanlong Gao)
-   build/ops: ceph-detect-init: fix the py3 test
    ([pr#10266](http://github.com/ceph/ceph/pull/10266), Kefu Chai)
-   build/ops: ceph.spec: fix ceph-mgr version requirement
    ([pr#11285](http://github.com/ceph/ceph/pull/11285), Sage Weil)
-   build/ops: make-dist/ceph.spec.in: Fix srpm build breakage.
    ([pr#10404](http://github.com/ceph/ceph/pull/10404), Ira Cooper)
-   build/ops: master: remove SYSTEMD_RUN from initscript
    ([issue#16440](http://tracker.ceph.com/issues/16440),
    [issue#7627](http://tracker.ceph.com/issues/7627),
    [pr#9871](http://github.com/ceph/ceph/pull/9871), Vladislav
    Odintsov)
-   build/ops: rocksdb: revert the change introduced by dc41731
    ([pr#10595](http://github.com/ceph/ceph/pull/10595), Kefu Chai)
-   build/ops: do_freebsd\*.sh: rename do_freebsd-cmake.sh to
    do_freebsd.sh ([pr#11088](http://github.com/ceph/ceph/pull/11088),
    Kefu Chai)
-   build/ops: gcc 6.1.1 complains about missing include: \<random\>.
    4.8.3 does not c...
    ([pr#10747](http://github.com/ceph/ceph/pull/10747), Daniel
    Oliveira)
-   build/ops: selinux: Allow ceph to manage tmp files
    ([issue#17436](http://tracker.ceph.com/issues/17436),
    [pr#11259](http://github.com/ceph/ceph/pull/11259), Boris Ranto)
-   build/ops: selinux: allow read /proc/\<pid\>/cmdline
    ([issue#16675](http://tracker.ceph.com/issues/16675),
    [pr#10339](http://github.com/ceph/ceph/pull/10339), Kefu Chai)
-   cephfs,common: osdc/Journaler: move C_DelayFlush class to .cc
    ([pr#10744](http://github.com/ceph/ceph/pull/10744), Michal
    Jarzabek)
-   cephfs,core,rbd: ObjectCacher: fix bh_read_finish offset logic
    ([issue#16002](http://tracker.ceph.com/issues/16002),
    [pr#9606](http://github.com/ceph/ceph/pull/9606), Greg Farnum)
-   cephfs,core,rbd: osdc/ObjectCacher: move C_ReadFinish, C_RetryRead
    ([pr#10781](http://github.com/ceph/ceph/pull/10781), Michal
    Jarzabek)
-   cephfs: Add ceph_ll_setlk and ceph_ll_getlk
    ([pr#9566](http://github.com/ceph/ceph/pull/9566), Frank S. Filz)
-   cephfs: CephFS: misc. cleanups and remove legacy cephfs tool
    ([issue#16195](http://tracker.ceph.com/issues/16195),
    [issue#16035](http://tracker.ceph.com/issues/16035),
    [issue#15923](http://tracker.ceph.com/issues/15923),
    [pr#10243](http://github.com/ceph/ceph/pull/10243), John Spray)
-   cephfs: Clean up handling of \"/..\" in ceph client
    ([pr#10691](http://github.com/ceph/ceph/pull/10691), Jeff Layton)
-   cephfs: Client: fixup param type and return value
    ([pr#10463](http://github.com/ceph/ceph/pull/10463), gongchuang)
-   cephfs: Client: pass \"UserPerm\" struct everywhere for security
    checks ([issue#16367](http://tracker.ceph.com/issues/16367),
    [issue#17368](http://tracker.ceph.com/issues/17368),
    [pr#11218](http://github.com/ceph/ceph/pull/11218), Greg Farnum)
-   cephfs: First pile of statx patches
    ([pr#10922](http://github.com/ceph/ceph/pull/10922), Sage Weil, Jeff
    Layton)
-   cephfs: Fix attribute handling at lookup time
    ([issue#16668](http://tracker.ceph.com/issues/16668),
    [pr#10386](http://github.com/ceph/ceph/pull/10386), Jeff Layton)
-   cephfs: Inotable repair during forward scrub
    ([pr#10281](http://github.com/ceph/ceph/pull/10281), Vishal
    Kanaujia)
-   cephfs: Server: drop locks and auth pins if wait for pending
    truncate ([pr#9716](http://github.com/ceph/ceph/pull/9716), xie
    xingguo)
-   cephfs: Small interface cleanups for struct ceph_statx
    ([pr#11093](http://github.com/ceph/ceph/pull/11093), Jeff Layton)
-   cephfs: build ceph-fuse on OSX
    ([pr#9371](http://github.com/ceph/ceph/pull/9371), Yan, Zheng)
-   cephfs: ceph-fuse: link to libtcmalloc or jemalloc
    ([issue#16655](http://tracker.ceph.com/issues/16655),
    [pr#10258](http://github.com/ceph/ceph/pull/10258), Yan, Zheng)
-   cephfs: ceph_volume_client: store authentication metadata
    ([issue#15406](http://tracker.ceph.com/issues/15406),
    [issue#15615](http://tracker.ceph.com/issues/15615),
    [pr#9864](http://github.com/ceph/ceph/pull/9864), John Spray, Ramana
    Raja)
-   cephfs: client/barrier: move C_Block_Sync class to .cc
    ([pr#11001](http://github.com/ceph/ceph/pull/11001), Michal
    Jarzabek)
-   cephfs: client/filer: cleanup the redundant judgments of
    \_write&&\_fallocate
    ([pr#10062](http://github.com/ceph/ceph/pull/10062), huanwen ren)
-   cephfs: client: add missing client_lock for get_root
    ([pr#10027](http://github.com/ceph/ceph/pull/10027), Patrick
    Donnelly)
-   cephfs: client: discard mds map if it is identical to ours
    ([pr#9774](http://github.com/ceph/ceph/pull/9774), xie xingguo)
-   cephfs: client: fast abort if underlying statsf() call failed; end
    scope of std::hex properly
    ([pr#9803](http://github.com/ceph/ceph/pull/9803), xie xingguo)
-   cephfs: client: fix access violation
    ([pr#9793](http://github.com/ceph/ceph/pull/9793), xie xingguo)
-   cephfs: client: fix readdir vs fragmentation race
    ([issue#17286](http://tracker.ceph.com/issues/17286),
    [pr#11147](http://github.com/ceph/ceph/pull/11147), Yan, Zheng)
-   cephfs: client: fix segment fault in
    Client::\_invalidate_kernel_dcache().
    ([issue#17253](http://tracker.ceph.com/issues/17253),
    [pr#11170](http://github.com/ceph/ceph/pull/11170), Yan, Zheng)
-   cephfs: client: fix shutdown with open inodes
    ([issue#16764](http://tracker.ceph.com/issues/16764),
    [pr#10419](http://github.com/ceph/ceph/pull/10419), John Spray)
-   cephfs: client: include COMPLETE and ORDERED states in cache dump
    ([pr#10485](http://github.com/ceph/ceph/pull/10485), Greg Farnum)
-   cephfs: client: kill compiling warning
    ([pr#9994](http://github.com/ceph/ceph/pull/9994), xie xingguo)
-   cephfs: client: misc fixes
    ([pr#9838](http://github.com/ceph/ceph/pull/9838), xie xingguo)
-   cephfs: client: move Inode specific cleanup to destructor
    ([pr#10168](http://github.com/ceph/ceph/pull/10168), Patrick
    Donnelly)
-   cephfs: client: note order of member init in cons
    ([pr#10169](http://github.com/ceph/ceph/pull/10169), Patrick
    Donnelly)
-   cephfs: client: properly set inode number of created inode in replay
    request ([issue#17172](http://tracker.ceph.com/issues/17172),
    [pr#10957](http://github.com/ceph/ceph/pull/10957), Yan, Zheng)
-   cephfs: client: protect InodeRef with client_lock
    ([issue#17392](http://tracker.ceph.com/issues/17392),
    [pr#11225](http://github.com/ceph/ceph/pull/11225), Yan, Zheng)
-   cephfs: doc/mds: fixup mds doc
    ([pr#10573](http://github.com/ceph/ceph/pull/10573), huanwen ren)
-   cephfs: fuse_ll: fix incorrect error settings of fuse_ll_mkdir()
    ([pr#9809](http://github.com/ceph/ceph/pull/9809), xie xingguo)
-   cephfs: include/ceph_fs.h: guard [#define
    CEPH_SETATTR\_\*]{.title-ref} with #ifndef
    ([pr#10265](http://github.com/ceph/ceph/pull/10265), Kefu Chai)
-   cephfs: libcephfs: Fix the incorrect integer conversion in
    libcephfs_jni.cc
    ([pr#10640](http://github.com/ceph/ceph/pull/10640), wenjunhuang)
-   cephfs: libcephfs: add unmount function in cephfs.pyx
    ([pr#10774](http://github.com/ceph/ceph/pull/10774), huanwen ren)
-   cephfs: libcephfs: fix portability-related error settings
    ([pr#9794](http://github.com/ceph/ceph/pull/9794), xie xingguo)
-   cephfs: libcephfs: kill compiling warning
    ([pr#10622](http://github.com/ceph/ceph/pull/10622), xie xingguo)
-   cephfs: mds/CDir: remove the part of judgment for
    \_next_dentry_on_set
    ([pr#10476](http://github.com/ceph/ceph/pull/10476), zhang.zezhu)
-   cephfs: mds/CInode: fix potential fin hanging
    ([pr#9773](http://github.com/ceph/ceph/pull/9773), xie xingguo)
-   cephfs: mds/MDBalancer: cleanup
    ([pr#10512](http://github.com/ceph/ceph/pull/10512), huanwen ren)
-   cephfs: mds/MDCache: kill a comipler warning
    ([pr#11254](http://github.com/ceph/ceph/pull/11254), xie xingguo)
-   cephfs: mds/MDSMap default metadata pool to -1 (was: output None
    instead of 0 when no fs present.)
    ([issue#16588](http://tracker.ceph.com/issues/16588),
    [pr#10202](http://github.com/ceph/ceph/pull/10202), Xiaoxi Chen)
-   cephfs: mds/MDSTable: add const to member functions
    ([pr#10846](http://github.com/ceph/ceph/pull/10846), Michal
    Jarzabek)
-   cephfs: mds/SessionMap.h: change statement to assertion
    ([pr#11289](http://github.com/ceph/ceph/pull/11289), Michal
    Jarzabek)
-   cephfs: mds/SnapRealm.h: add const to member functions
    ([pr#10878](http://github.com/ceph/ceph/pull/10878), Michal
    Jarzabek)
-   cephfs: mds/server: clean up handle_client_open()
    ([pr#11120](http://github.com/ceph/ceph/pull/11120), huanwen ren)
-   cephfs: mon/MDSMonitor: move C_Updated class to .cc file
    ([pr#10668](http://github.com/ceph/ceph/pull/10668), Michal
    Jarzabek)
-   cephfs: osdc/mds: fixup pos parameter in the journaler
    ([pr#10200](http://github.com/ceph/ceph/pull/10200), huanwen ren)
-   cephfs: reduce unnecessary mds log flush
    ([pr#10393](http://github.com/ceph/ceph/pull/10393), Yan, Zheng)
-   cephfs: tools/cephfs: Remove cephfs-data-scan tmap_upgrade
    ([issue#16144](http://tracker.ceph.com/issues/16144),
    [pr#10100](http://github.com/ceph/ceph/pull/10100), Douglas Fuller)
-   cephfs: ceph_fuse: use sizeof get the buf length
    ([pr#11176](http://github.com/ceph/ceph/pull/11176), LeoZhang)
-   cli: retry when the mon is not configured
    ([issue#16477](http://tracker.ceph.com/issues/16477),
    [pr#11089](http://github.com/ceph/ceph/pull/11089), Loic Dachary)
-   cmake: Add -pie to CMAKE_EXE_LINKER_FLAGS
    ([pr#10755](http://github.com/ceph/ceph/pull/10755), Tim Serong)
-   cmake: Fix FCGI include directory
    ([pr#9983](http://github.com/ceph/ceph/pull/9983), Tim Serong)
-   cmake: Fix mismatched librgw VERSION / SOVERSION
    ([pr#10754](http://github.com/ceph/ceph/pull/10754), Tim Serong)
-   cmake: FreeBSD specific excludes in CMakeLists.txt
    ([pr#10973](http://github.com/ceph/ceph/pull/10973), Willem Jan
    Withagen)
-   cmake: FreeBSD specific excludes in CMakeLists.txt files
    ([pr#10517](http://github.com/ceph/ceph/pull/10517), Willem Jan
    Withagen)
-   cmake: Really add FCGI_INCLUDE_DIR to include_directories for rgw
    ([pr#10139](http://github.com/ceph/ceph/pull/10139), Tim Serong)
-   cmake: Removed README.cmake.md, edited README.md
    ([pr#10028](http://github.com/ceph/ceph/pull/10028), Ali Maredia)
-   cmake: Support tcmalloc_minimal allocator
    ([pr#11111](http://github.com/ceph/ceph/pull/11111), Bassam Tabbara)
-   cmake: add dependency from ceph_smalliobenchrbd to cls libraries
    ([pr#10870](http://github.com/ceph/ceph/pull/10870), J. Eric
    Ivancich)
-   cmake: add_subdirectory(include)
    ([pr#10360](http://github.com/ceph/ceph/pull/10360), Kefu Chai)
-   cmake: ceph_test_rbd_mirror does not require librados_test_stub
    ([pr#10164](http://github.com/ceph/ceph/pull/10164), Jason Dillaman)
-   cmake: cleanup Findgperftools.cmake
    ([pr#10670](http://github.com/ceph/ceph/pull/10670), Kefu Chai)
-   cmake: correct ceph_test_librbd/ceph_test_rbd_mirror linkage
    ([issue#16882](http://tracker.ceph.com/issues/16882),
    [pr#10598](http://github.com/ceph/ceph/pull/10598), Jason Dillaman)
-   cmake: disable -fvar-tracking-assignments for ceph_dencoder.cc
    ([pr#10275](http://github.com/ceph/ceph/pull/10275), Kefu Chai)
-   cmake: disable unittest_async_compressor
    ([pr#10394](http://github.com/ceph/ceph/pull/10394), Kefu Chai)
-   cmake: do not link against unused objects or libraries
    ([pr#10837](http://github.com/ceph/ceph/pull/10837), Kefu Chai)
-   cmake: enable ccache for rocksdb too
    ([pr#11100](http://github.com/ceph/ceph/pull/11100), Bassam Tabbara)
-   cmake: exclude non-public symbols in shared libraries
    ([issue#16556](http://tracker.ceph.com/issues/16556),
    [pr#10472](http://github.com/ceph/ceph/pull/10472), Kefu Chai)
-   cmake: fix incorrect dependencies to librados
    ([pr#10145](http://github.com/ceph/ceph/pull/10145), Jason Dillaman)
-   cmake: fix the FTBFS introduced by dc8b3ba
    ([pr#10282](http://github.com/ceph/ceph/pull/10282), Kefu Chai)
-   cmake: fix the build of unittest_async_compressor
    ([pr#10400](http://github.com/ceph/ceph/pull/10400), Kefu Chai)
-   cmake: fix the tracing header dependencies
    ([pr#10906](http://github.com/ceph/ceph/pull/10906), Kefu Chai)
-   cmake: fix unittest_rbd_mirror failures under non-optimized builds
    ([pr#9990](http://github.com/ceph/ceph/pull/9990), Jason Dillaman)
-   cmake: fix wrong path introduced by bb163e9
    ([pr#10643](http://github.com/ceph/ceph/pull/10643), Kefu Chai)
-   cmake: fixes ([pr#10092](http://github.com/ceph/ceph/pull/10092),
    Daniel Gryniewicz)
-   cmake: fixes for pypi changes
    ([pr#10204](http://github.com/ceph/ceph/pull/10204), Kefu Chai)
-   cmake: include(SIMDExt) in src/CMakeLists.txt
    ([pr#11003](http://github.com/ceph/ceph/pull/11003), Kefu Chai)
-   cmake: install ceph_test_cls_rgw
    ([pr#10025](http://github.com/ceph/ceph/pull/10025), Kefu Chai)
-   cmake: install [ceph_test_rados_striper_api]()\*
    ([pr#10541](http://github.com/ceph/ceph/pull/10541), Kefu Chai)
-   cmake: install platlib into a subdir of build-base dir
    ([pr#10666](http://github.com/ceph/ceph/pull/10666), Kefu Chai)
-   cmake: make py3 a nice-to-have
    ([issue#17103](http://tracker.ceph.com/issues/17103),
    [pr#11015](http://github.com/ceph/ceph/pull/11015), Kefu Chai)
-   cmake: pass -DINTEL\* to gf-complete cflags
    ([pr#10956](http://github.com/ceph/ceph/pull/10956), tone.zhang,
    Kefu Chai)
-   cmake: pass cmake\'s compiler and flags to compile RocksDB into
    build ([pr#10418](http://github.com/ceph/ceph/pull/10418), Willem
    Jan Withagen)
-   cmake: recompile erasure src for different variants
    ([pr#10772](http://github.com/ceph/ceph/pull/10772), Kefu Chai)
-   cmake: remove WITH_MDS option
    ([pr#10186](http://github.com/ceph/ceph/pull/10186), Ali Maredia)
-   cmake: remove more autotools hacks
    ([pr#11229](http://github.com/ceph/ceph/pull/11229), Sage Weil)
-   cmake: remove unnecessary linked libs from libcephfs
    ([issue#16556](http://tracker.ceph.com/issues/16556),
    [pr#10081](http://github.com/ceph/ceph/pull/10081), Kefu Chai)
-   cmake: rework NSS and SSL
    ([pr#9831](http://github.com/ceph/ceph/pull/9831), Matt Benjamin)
-   cmake: set ARM_CRC_FLAGS from the CRC test rather than
    ARM_NEON_FLAGS ([issue#17250](http://tracker.ceph.com/issues/17250),
    [pr#11028](http://github.com/ceph/ceph/pull/11028), Dan Mick)
-   cmake: specify distutils build path explicitly
    ([pr#10568](http://github.com/ceph/ceph/pull/10568), Kefu Chai)
-   cmake: supress more warnings
    ([pr#10469](http://github.com/ceph/ceph/pull/10469), Willem Jan
    Withagen)
-   cmake: use PERF_LOCAL_FLAGS only if defined
    ([issue#17104](http://tracker.ceph.com/issues/17104),
    [pr#10828](http://github.com/ceph/ceph/pull/10828), Michel Normand)
-   cmake: use stock Find\* modules.
    ([pr#10178](http://github.com/ceph/ceph/pull/10178), Kefu Chai)
-   cmake: work to get inital FreeBSD stuff
    ([pr#10352](http://github.com/ceph/ceph/pull/10352), Willem Jan
    Withagen)
-   cmake: find GIT_VER variables if there is no .git dir
    ([pr#11499](http://github.com/ceph/ceph/pull/11499), Ali Maredia)
-   common,bluestore: Isa-l extention for zlib compression plugin
    ([pr#10158](http://github.com/ceph/ceph/pull/10158), Alyona
    Kiseleva, Dan Mick)
-   common,bluestore: compressor/zlib: zlib wrapper fix
    ([pr#11079](http://github.com/ceph/ceph/pull/11079), Igor Fedotov)
-   common: auth/cephx: misc fixes
    ([pr#9679](http://github.com/ceph/ceph/pull/9679), xie xingguo)
-   common: common/PluginRegistry: improve error output for shared
    library load fa...
    ([pr#11081](http://github.com/ceph/ceph/pull/11081), Igor Fedotov)
-   common: common/Throttle.h: remove unneeded class
    ([pr#10902](http://github.com/ceph/ceph/pull/10902), Michal
    Jarzabek)
-   common: common/Timer.h: delete copy constr and assign op
    ([pr#11046](http://github.com/ceph/ceph/pull/11046), Michal
    Jarzabek)
-   common: common/WorkQueue: add std move
    ([pr#9729](http://github.com/ceph/ceph/pull/9729), Michal Jarzabek)
-   common: compressor: zlib compressor plugin cleanup
    ([pr#9782](http://github.com/ceph/ceph/pull/9782), Alyona Kiseleva)
-   common: erasure-code: Runtime detection of SIMD for jerasure and
    shec ([pr#11086](http://github.com/ceph/ceph/pull/11086), Bassam
    Tabbara)
-   common: global: log which process/command sent a signal
    ([pr#8964](http://github.com/ceph/ceph/pull/8964), song baisen)
-   common: include/assert: clean up ceph assertion macros
    ([pr#9969](http://github.com/ceph/ceph/pull/9969), Sage Weil)
-   common: instantiate strict_si_cast\<long\> not
    strict_si_cast\<int64_t\>
    ([issue#16398](http://tracker.ceph.com/issues/16398),
    [pr#9934](http://github.com/ceph/ceph/pull/9934), Kefu Chai)
-   common: lockdep: verbose even if no logging is set
    ([pr#10576](http://github.com/ceph/ceph/pull/10576), Willem Jan
    Withagen)
-   common: messages/MOSDMap: mark as enlighten OSDMap encoder
    ([pr#10843](http://github.com/ceph/ceph/pull/10843), Sage Weil)
-   common: mon/Monitor.cc:replce lock/unlock with Mutex:Lockr
    ([pr#9792](http://github.com/ceph/ceph/pull/9792), Michal Jarzabek)
-   common: msg/AsyncMessenger.cc: remove code duplication
    ([pr#10030](http://github.com/ceph/ceph/pull/10030), Michal
    Jarzabek)
-   common: msg/async: less verbose debug messages at debug_ms=1
    ([pr#11205](http://github.com/ceph/ceph/pull/11205), Sage Weil)
-   common: msg/async: remove static member variable
    ([issue#16686](http://tracker.ceph.com/issues/16686),
    [pr#10440](http://github.com/ceph/ceph/pull/10440), Kefu Chai)
-   common: only call crypto::init once per CephContext
    ([issue#17205](http://tracker.ceph.com/issues/17205),
    [pr#10965](http://github.com/ceph/ceph/pull/10965), Casey Bodley)
-   common: osdc/ObjectCacher: change iterator to const_iterator and add
    const to member functions
    ([pr#9644](http://github.com/ceph/ceph/pull/9644), Michal Jarzabek)
-   common: preforker: prevent call to \'write\' on an fd that was
    already closed ([pr#10949](http://github.com/ceph/ceph/pull/10949),
    Avner BenHanoch)
-   common: remove basename() dependency
    ([pr#9845](http://github.com/ceph/ceph/pull/9845), John Coyle)
-   common: src/common/buffer.cc fix judgment for lseek
    ([pr#10130](http://github.com/ceph/ceph/pull/10130), zhang.zezhu)
-   common: unknown hash type of judgment modification
    ([pr#9510](http://github.com/ceph/ceph/pull/9510), huanwen ren)
-   common: Timer.cc: replace long types with auto
    ([pr#11067](http://github.com/ceph/ceph/pull/11067), Michal
    Jarzabek)
-   common: TrackedOp: move ShardedTrackingData to .cc
    ([pr#10639](http://github.com/ceph/ceph/pull/10639), Michal
    Jarzabek)
-   common: config_opts: fix comment(radio -\> ratio)
    ([pr#10783](http://github.com/ceph/ceph/pull/10783), xie xingguo)
-   common: src/common/dns_resolve.cc: reorder the includes
    ([pr#10505](http://github.com/ceph/ceph/pull/10505), Willem Jan
    Withagen)
-   common: global/signal_handler: use sig_str instead of sys_siglist
    ([pr#10633](http://github.com/ceph/ceph/pull/10633), John Coyle)
-   core,cephfs: Revert \"osd/ReplicatedPG: for sync-read it don\'t cacl
    l_osd_op_r_prep...
    ([issue#16908](http://tracker.ceph.com/issues/16908),
    [pr#10875](http://github.com/ceph/ceph/pull/10875), Samuel Just)
-   core,cephfs: mon/mds: add err info when load_metadata is abnormal
    ([pr#10176](http://github.com/ceph/ceph/pull/10176), huanwen ren)
-   core,common: osd/OSD.cc: remove unneeded returns
    ([pr#11043](http://github.com/ceph/ceph/pull/11043), Michal
    Jarzabek)
-   core,pybind: python-rados: extends ReadOp/WriteOp API
    ([pr#9944](http://github.com/ceph/ceph/pull/9944), Mehdi Abaakouk)
-   core,pybind: python-rados: implement new aio_stat.
    ([pr#11006](http://github.com/ceph/ceph/pull/11006), Iain Buclaw)
-   core,pybind: qa/workunits/rados/test_python.sh: Allow specifying
    Python executable
    ([pr#10782](http://github.com/ceph/ceph/pull/10782), Oleh Prypin)
-   core: os/filestore/LFNIndex: remove unused variable \'subdir_path\'
    ([pr#8959](http://github.com/ceph/ceph/pull/8959), huangjun)
-   core: Create ceph-mgr
    ([pr#10328](http://github.com/ceph/ceph/pull/10328), John Spray, Tim
    Serong)
-   core: FileJournal: Remove obsolete \_check_disk_write_cache function
    ([pr#11073](http://github.com/ceph/ceph/pull/11073), Brad Hubbard)
-   core: Lua object class support
    ([pr#7338](http://github.com/ceph/ceph/pull/7338), Noah Watkins)
-   core: OSD crash with Hammer to Jewel Upgrade: void
    FileStore::init_temp_collections()
    ([issue#16672](http://tracker.ceph.com/issues/16672),
    [pr#10565](http://github.com/ceph/ceph/pull/10565), David Zafman)
-   core: OSD.cc: remove unneeded return
    ([pr#9701](http://github.com/ceph/ceph/pull/9701), Michal Jarzabek)
-   core: OSD: avoid FileStore finisher deadlock in osd_lock when
    shutdown OSD ([pr#11052](http://github.com/ceph/ceph/pull/11052),
    Haomai Wang)
-   core: ObjectCacher: fix last_write check in bh_write_adjacencies()
    ([issue#16610](http://tracker.ceph.com/issues/16610),
    [pr#10304](http://github.com/ceph/ceph/pull/10304), Yan, Zheng)
-   core: ReplicatedPG: call op_applied for submit_log_entries based
    repops ([pr#9489](http://github.com/ceph/ceph/pull/9489), Samuel
    Just)
-   core: Wip 16998
    ([issue#16998](http://tracker.ceph.com/issues/16998),
    [pr#10688](http://github.com/ceph/ceph/pull/10688), Samuel Just)
-   core: ceph-create-keys: add missing argument comma
    ([pr#11123](http://github.com/ceph/ceph/pull/11123), Patrick
    Donnelly)
-   core: ceph-create-keys: fix existing-but-different case
    ([issue#16255](http://tracker.ceph.com/issues/16255),
    [pr#10415](http://github.com/ceph/ceph/pull/10415), John Spray)
-   core: ceph-disk: partprobe should block udev induced BLKRRPART
    ([issue#15176](http://tracker.ceph.com/issues/15176),
    [pr#9330](http://github.com/ceph/ceph/pull/9330), Marius Vollmer,
    Loic Dachary)
-   core: ceph-disk: timeout ceph-disk to avoid blocking forever
    ([issue#16580](http://tracker.ceph.com/issues/16580),
    [pr#10262](http://github.com/ceph/ceph/pull/10262), Loic Dachary)
-   core: ceph-objectstore-tool: add a way to split filestore
    directories offline
    ([issue#17220](http://tracker.ceph.com/issues/17220),
    [pr#10776](http://github.com/ceph/ceph/pull/10776), Josh Durgin)
-   core: ceph.in: python 3 compatibility of the ceph CLI
    ([pr#9702](http://github.com/ceph/ceph/pull/9702), Oleh Prypin)
-   core: ceph_mon: use readdir() as readdir_r() is deprecated
    ([pr#11047](http://github.com/ceph/ceph/pull/11047), Kefu Chai)
-   core: cephx: Fix multiple segfaults due to attempts to encrypt or
    decrypt ([issue#16266](http://tracker.ceph.com/issues/16266),
    [pr#9703](http://github.com/ceph/ceph/pull/9703), Brad Hubbard)
-   core: <https://github.com/ceph/ceph/pull/11052>
    ([pr#10371](http://github.com/ceph/ceph/pull/10371), Yan Jun)
-   core: include write error codes in the pg log
    ([issue#14468](http://tracker.ceph.com/issues/14468),
    [pr#10170](http://github.com/ceph/ceph/pull/10170), Josh Durgin)
-   core: kv/MemDB: fix assert triggerred by m_total_bytes underflow
    ([pr#10471](http://github.com/ceph/ceph/pull/10471), xie xingguo)
-   core: kv/RocksDB: add perfcounter for submit_transaction_sync
    operation ([pr#9770](http://github.com/ceph/ceph/pull/9770), Haodong
    Tang)
-   core: logmon: check is_leader() before doing any work on
    get_trim_to() ([pr#10342](http://github.com/ceph/ceph/pull/10342),
    song baisen)
-   core: memstore: clone zero-fills holes from source range
    ([pr#11157](http://github.com/ceph/ceph/pull/11157), Casey Bodley)
-   core: message: optimization for message priority strategy
    ([pr#8687](http://github.com/ceph/ceph/pull/8687), yaoning)
-   core: messages/MForward: fix encoding features
    ([issue#17365](http://tracker.ceph.com/issues/17365),
    [pr#11180](http://github.com/ceph/ceph/pull/11180), Sage Weil)
-   core: mgr/MgrClient: fix ms_handle_reset
    ([pr#11298](http://github.com/ceph/ceph/pull/11298), Sage Weil)
-   core: mgr/MgrMap: initialize all fields
    ([issue#17492](http://tracker.ceph.com/issues/17492),
    [pr#11308](http://github.com/ceph/ceph/pull/11308), Sage Weil)
-   core: mon/ConfigKeyService: pass strings by const ref
    ([pr#10618](http://github.com/ceph/ceph/pull/10618), Michal
    Jarzabek)
-   core: mon/LogMonitor: move C_Log struct to cc file
    ([pr#10721](http://github.com/ceph/ceph/pull/10721), Michal
    Jarzabek)
-   core: mon/MonClient.h: pass strings by const reference
    ([pr#10605](http://github.com/ceph/ceph/pull/10605), Michal
    Jarzabek)
-   core: mon/MonDBStore: fix assert which never fires
    ([pr#10706](http://github.com/ceph/ceph/pull/10706), xie xingguo)
-   core: mon/MonitorDBStore: do not use snapshot iterator; close on
    close ([pr#10102](http://github.com/ceph/ceph/pull/10102), Sage
    Weil)
-   core: mon/OSDMonitor.cc: remove use of boost assign
    ([pr#11060](http://github.com/ceph/ceph/pull/11060), Michal
    Jarzabek)
-   core: mon/PGMonitor: batch filter pg states; add sanity check
    ([pr#9394](http://github.com/ceph/ceph/pull/9394), xie xingguo)
-   core: mon/PGMonitor: calc the %USED of pool using used/(used+avail)
    ([issue#16933](http://tracker.ceph.com/issues/16933),
    [pr#10584](http://github.com/ceph/ceph/pull/10584), Kefu Chai)
-   core: mon/PGMonitor: move C_Stats struct to cc file
    ([pr#10719](http://github.com/ceph/ceph/pull/10719), Michal
    Jarzabek)
-   core: mon/PaxosService: make the return value type inconsistent
    ([pr#10231](http://github.com/ceph/ceph/pull/10231), zhang.zezhu)
-   core: mon/osdmonitor: fix incorrect output of \"osd df\" due to osd
    out ([issue#16706](http://tracker.ceph.com/issues/16706),
    [pr#10308](http://github.com/ceph/ceph/pull/10308), xie xingguo)
-   core: msg/AsyncMessenger: change return type to void
    ([pr#10230](http://github.com/ceph/ceph/pull/10230), Michal
    Jarzabek)
-   core: msg/Messenger: add const and override to function
    ([pr#10183](http://github.com/ceph/ceph/pull/10183), Michal
    Jarzabek)
-   core: msg/async/AsyncConnection: replace Mutex with std::mutex for
    peformance ([issue#16714](http://tracker.ceph.com/issues/16714),
    [issue#16715](http://tracker.ceph.com/issues/16715),
    [pr#10340](http://github.com/ceph/ceph/pull/10340), Haomai Wang)
-   core: msg/async/Event: ensure not refer to member variable which may
    destroyed ([issue#16714](http://tracker.ceph.com/issues/16714),
    [pr#10369](http://github.com/ceph/ceph/pull/10369), Haomai Wang)
-   core: msg/async/kqueue: avoid remove nonexist kqueue event
    ([pr#9869](http://github.com/ceph/ceph/pull/9869), Haomai Wang)
-   core: msg/async: Support close idle connection feature
    ([issue#16366](http://tracker.ceph.com/issues/16366),
    [pr#9783](http://github.com/ceph/ceph/pull/9783), Haomai Wang)
-   core: msg/async: allow other async backend implementations
    ([pr#10264](http://github.com/ceph/ceph/pull/10264), Haomai Wang)
-   core: msg/async: avoid set out of range ms_async_op_threads option
    ([pr#11200](http://github.com/ceph/ceph/pull/11200), Haomai Wang)
-   core: msg/async: connect authorizer fix + recv_buf size
    ([pr#9784](http://github.com/ceph/ceph/pull/9784), Ilya Dryomov)
-   core: msg/async: harden error logic handle
    ([pr#9781](http://github.com/ceph/ceph/pull/9781), Haomai Wang)
-   core: msg/async: remove fd output in log prefix
    ([pr#11199](http://github.com/ceph/ceph/pull/11199), Haomai Wang)
-   core: msg/async: remove file event lock
    ([issue#16554](http://tracker.ceph.com/issues/16554),
    [issue#16552](http://tracker.ceph.com/issues/16552),
    [pr#10090](http://github.com/ceph/ceph/pull/10090), Haomai Wang)
-   core: msg/simple/Pipe: eliminating casts for the comparing of len
    and recv_max_prefetch
    ([pr#10273](http://github.com/ceph/ceph/pull/10273), zhang.zezhu)
-   core: msg/simple: fix wrong condition checking of writing TAG_CLOSE
    on closing ([pr#10343](http://github.com/ceph/ceph/pull/10343), xie
    xingguo)
-   core: msg/simple: wait dispatch_queue until all pipes closed
    ([issue#16472](http://tracker.ceph.com/issues/16472),
    [pr#9930](http://github.com/ceph/ceph/pull/9930), Haomai Wang)
-   core: msg: make async backend default
    ([pr#10746](http://github.com/ceph/ceph/pull/10746), Haomai Wang)
-   core: msg: mark daemons down on RST + ECONNREFUSED
    ([pr#8558](http://github.com/ceph/ceph/pull/8558), Piotr Dałek)
-   core: os/FuseStore: fix several FuseStore issues
    ([pr#10723](http://github.com/ceph/ceph/pull/10723), Sage Weil)
-   core: os/MemStore: move BufferlistObject to .cc file
    ([pr#10833](http://github.com/ceph/ceph/pull/10833), Michal
    Jarzabek)
-   core: os/ObjectStore: fix return code of collection_empty() method
    ([pr#11050](http://github.com/ceph/ceph/pull/11050), xie xingguo)
-   core: os/RocksDBStore: use effective Get API instead of iterator api
    ([pr#9411](http://github.com/ceph/ceph/pull/9411), Jianjian Huo,
    Haomai Wang, Mark Nelson)
-   core: os/filestore/FDCache: fix bug when filestore_fd_cache_shards =
    0 ([pr#11048](http://github.com/ceph/ceph/pull/11048), jimifm)
-   core: os/filestore/FileJournal: error out if FileJournal is not a
    file ([issue#17307](http://tracker.ceph.com/issues/17307),
    [pr#11146](http://github.com/ceph/ceph/pull/11146), Kefu Chai)
-   core: os/filestore: add sanity checks and cleanups for mount()
    process ([pr#9734](http://github.com/ceph/ceph/pull/9734), xie
    xingguo)
-   core: os/filestore: disable use of splice by default
    ([pr#11113](http://github.com/ceph/ceph/pull/11113), Haomai Wang)
-   core: osd/OSD.cc: remove repeated searching of map
    ([pr#10986](http://github.com/ceph/ceph/pull/10986), Michal
    Jarzabek)
-   core: osd/OSD.cc: remove unneeded searching of maps
    ([pr#11039](http://github.com/ceph/ceph/pull/11039), Michal
    Jarzabek)
-   core: osd/OSD.h: add const to member functions
    ([pr#11114](http://github.com/ceph/ceph/pull/11114), Michal
    Jarzabek)
-   core: osd/OSD.h: move some members under private
    ([pr#11121](http://github.com/ceph/ceph/pull/11121), Michal
    Jarzabek)
-   core: osd/OSD.h: remove unneeded line
    ([pr#8980](http://github.com/ceph/ceph/pull/8980), Michal Jarzabek)
-   core: osd/OSDMonitor: misc. cleanups
    ([pr#10739](http://github.com/ceph/ceph/pull/10739), xie xingguo)
-   core: osd/OSDMonitor: misc. fixes
    ([pr#10491](http://github.com/ceph/ceph/pull/10491), xie xingguo)
-   core: osd/ReplicatedBackend: add sanity check during build_push_op()
    ([pr#9491](http://github.com/ceph/ceph/pull/9491), Yan Jun)
-   core: osd/ReplicatedPG: for sync-read it don\'t cacl
    l_osd_op_r_prepare_lat.
    ([pr#10365](http://github.com/ceph/ceph/pull/10365), Jianpeng Ma)
-   core: osd/ReplicatedPG: remove class redeclaration
    ([pr#11041](http://github.com/ceph/ceph/pull/11041), Michal
    Jarzabek)
-   core: osd/ReplicatedPG: remove unused param \"op\" from
    generate_subop()
    ([pr#10811](http://github.com/ceph/ceph/pull/10811), jimifm)
-   core: osd/Watch: add consts to member functions
    ([pr#10251](http://github.com/ceph/ceph/pull/10251), Michal
    Jarzabek)
-   core: osd/osd_type: check if pool is gone during
    check_new_interval()
    ([pr#10859](http://github.com/ceph/ceph/pull/10859), xie xingguo)
-   core: osd/osdmonitor: pool of objects and bytes beyond quota should
    all be warn ([pr#9085](http://github.com/ceph/ceph/pull/9085),
    huanwen ren)
-   core: osdc/objecter: misc fixes
    ([pr#10826](http://github.com/ceph/ceph/pull/10826), xie xingguo)
-   core: pass string by const ref and add override to virtual function
    ([pr#9082](http://github.com/ceph/ceph/pull/9082), Michal Jarzabek)
-   core: qa/workunits/objectstore/test_fuse.sh: make test_fuse.sh work
    with filestore ([pr#11057](http://github.com/ceph/ceph/pull/11057),
    Sage Weil)
-   core: rados: add option to include clones when doing flush or evict
    ([pr#9698](http://github.com/ceph/ceph/pull/9698), Mingxin Liu)
-   core: subman: use replace instead of format
    ([issue#16961](http://tracker.ceph.com/issues/16961),
    [pr#10620](http://github.com/ceph/ceph/pull/10620), Loic Dachary)
-   core: test/common/Throttle.cc: fix race in shutdown
    ([pr#10094](http://github.com/ceph/ceph/pull/10094), Samuel Just)
-   core: test: add the necessary judgment
    ([pr#9694](http://github.com/ceph/ceph/pull/9694), huanwen ren)
-   core: tox.ini: remove extraneous coverage \--omit option
    ([pr#10943](http://github.com/ceph/ceph/pull/10943), Josh Durgin)
-   core: udev: always populate /dev/disk/by-parttypeuuid
    ([issue#16351](http://tracker.ceph.com/issues/16351),
    [pr#9885](http://github.com/ceph/ceph/pull/9885), Loic Dachary)
-   core: os/FuseStore: remove unneeded header file
    ([pr#10799](http://github.com/ceph/ceph/pull/10799), Michal
    Jarzabek)
-   core: os/MemStore: move OmapIteratorImpl to cc file
    ([pr#10803](http://github.com/ceph/ceph/pull/10803), Michal
    Jarzabek)
-   core: os/Memstore.h: add override to virtual functions
    ([pr#10801](http://github.com/ceph/ceph/pull/10801), Michal
    Jarzabek)
-   core: os/Memstore: move PageSetObject class to .cc file
    ([pr#10817](http://github.com/ceph/ceph/pull/10817), Michal
    Jarzabek)
-   core: os/bluestore: remove unused head file.
    ([pr#11186](http://github.com/ceph/ceph/pull/11186), Jianpeng Ma)
-   core: safe_io: Improve portability by replacing loff_t type usage
    with off_t. ([pr#9767](http://github.com/ceph/ceph/pull/9767), John
    Coyle)
-   core: src/kv/MemDB.cc: the type of the parameter of push_back() does
    not match the ops\'s value_type
    ([pr#10455](http://github.com/ceph/ceph/pull/10455), Willem Jan
    Withagen)
-   core: msg/simple: apply prefetch policy more precisely
    ([pr#10344](http://github.com/ceph/ceph/pull/10344), xie xingguo)
-   core: CompatSet.h: remove unneeded inline
    ([pr#10071](http://github.com/ceph/ceph/pull/10071), Michal
    Jarzabek)
-   core: Objclass perm feedback
    ([pr#10313](http://github.com/ceph/ceph/pull/10313), Noah Watkins)
-   core: arch/arm.c: remove unnecessary variable read for simplicity
    ([pr#10821](http://github.com/ceph/ceph/pull/10821), Weibing Zhang)
-   crush: don\'t normalize input of crush_ln iteratively
    ([pr#10935](http://github.com/ceph/ceph/pull/10935), Piotr Dałek)
-   crush: reset bucket-\>h.items\[i\] when removing tree item
    ([issue#16525](http://tracker.ceph.com/issues/16525),
    [pr#10093](http://github.com/ceph/ceph/pull/10093), Kefu Chai)
-   crush: CrushCompiler.cc:884
    ([pr#10952](http://github.com/ceph/ceph/pull/10952), xu biao)
-   crush: CrushCompiler: error out as long as parse fails
    ([issue#17306](http://tracker.ceph.com/issues/17306),
    [pr#11144](http://github.com/ceph/ceph/pull/11144), Kefu Chai)
-   doc: Add documentation about snapshots
    ([pr#10436](http://github.com/ceph/ceph/pull/10436), Greg Farnum)
-   doc: Add two options to radosgw-admin.rst manpage
    ([issue#17281](http://tracker.ceph.com/issues/17281),
    [pr#11134](http://github.com/ceph/ceph/pull/11134), Thomas Serlin)
-   doc: Changed config parameter \"rgw keystone make new tenants\" in
    radosgw multitenancy
    ([issue#17293](http://tracker.ceph.com/issues/17293),
    [pr#11127](http://github.com/ceph/ceph/pull/11127), SirishaGuduru)
-   doc: Modification for \"TEST S3 ACCESS\" section in \"INSTALL CEPH
    OBJECT GATEWAY\" page
    ([pr#9089](http://github.com/ceph/ceph/pull/9089), la-sguduru)
-   doc: Update developer docs for cmake paths
    ([pr#11163](http://github.com/ceph/ceph/pull/11163), John Spray)
-   doc: add \"\--orphan-stale-secs\" to radosgw-admin(8)
    ([issue#17280](http://tracker.ceph.com/issues/17280),
    [pr#11097](http://github.com/ceph/ceph/pull/11097), Ken Dreyer)
-   doc: add \$pid metavar conf doc
    ([pr#11172](http://github.com/ceph/ceph/pull/11172), Patrick
    Donnelly)
-   doc: add Backporting section to Essentials chapter
    ([issue#15497](http://tracker.ceph.com/issues/15497),
    [pr#10457](http://github.com/ceph/ceph/pull/10457), Nathan Cutler)
-   doc: add Prepare tenant section to Testing in the cloud chapter
    ([pr#10413](http://github.com/ceph/ceph/pull/10413), Nathan Cutler)
-   doc: add Upload logs to archive server section\...
    ([pr#10414](http://github.com/ceph/ceph/pull/10414), Nathan Cutler)
-   doc: add client config ref
    ([issue#16743](http://tracker.ceph.com/issues/16743),
    [pr#10434](http://github.com/ceph/ceph/pull/10434), Patrick
    Donnelly)
-   doc: add graphic for cap bit field
    ([pr#10897](http://github.com/ceph/ceph/pull/10897), Patrick
    Donnelly)
-   doc: add missing PR to hammer 0.94.8 release notes
    ([pr#10900](http://github.com/ceph/ceph/pull/10900), Nathan Cutler)
-   doc: add openSUSE instructions to quick-start-preflight
    ([pr#10454](http://github.com/ceph/ceph/pull/10454), Nathan Cutler)
-   doc: add rgw_enable_usage_log option in Rados Gateway admin guide
    ([issue#16604](http://tracker.ceph.com/issues/16604),
    [pr#10159](http://github.com/ceph/ceph/pull/10159), Mike Hackett)
-   doc: add troubleshooting steps for ceph-fuse
    ([pr#10374](http://github.com/ceph/ceph/pull/10374), Ken Dreyer)
-   doc: admin/build-doc: bypass sanity check if building doc
    ([issue#16940](http://tracker.ceph.com/issues/16940),
    [pr#10623](http://github.com/ceph/ceph/pull/10623), Kefu Chai)
-   doc: ceph-authtool man page option is \--print-key not \--print
    ([pr#9731](http://github.com/ceph/ceph/pull/9731), Brad Hubbard)
-   doc: ceph-deploy mon add doesn\'t take multiple nodes
    ([pr#10085](http://github.com/ceph/ceph/pull/10085), Chengwei Yang)
-   doc: clarify rbd size units
    ([pr#11303](http://github.com/ceph/ceph/pull/11303), Ilya Dryomov)
-   doc: cleanup outdated radosgw description
    ([pr#11248](http://github.com/ceph/ceph/pull/11248), Jiaying Ren)
-   doc: describe libvirt client logging
    ([pr#10542](http://github.com/ceph/ceph/pull/10542), Ken Dreyer)
-   doc: do not list all major versions in get-packages.rst
    ([pr#10899](http://github.com/ceph/ceph/pull/10899), Nathan Cutler)
-   doc: doc/cephfs: explain the various health messages
    ([pr#10244](http://github.com/ceph/ceph/pull/10244), John Spray)
-   doc: doc/dev: Fix missing code section due to no lexer for \"none\"
    ([pr#9083](http://github.com/ceph/ceph/pull/9083), Brad Hubbard)
-   doc: doc/radosgw: fix description of response elements \'Part\'
    ([pr#10641](http://github.com/ceph/ceph/pull/10641), weiqiaomiao)
-   doc: doc/radosgw: rename config.rst to config-fcgi.rst
    ([pr#10381](http://github.com/ceph/ceph/pull/10381), Nathan Cutler)
-   doc: extend the CephFS troubleshooting guide
    ([pr#10458](http://github.com/ceph/ceph/pull/10458), Greg Farnum)
-   doc: fix broken link in SHEC erasure code plugin
    ([issue#16996](http://tracker.ceph.com/issues/16996),
    [pr#10675](http://github.com/ceph/ceph/pull/10675), Albert Tu)
-   doc: fix description for rsize and rasize
    ([pr#11101](http://github.com/ceph/ceph/pull/11101), Andreas
    Gerstmayr)
-   doc: fix rados/configuration/osd-config-ref.rst
    ([pr#10619](http://github.com/ceph/ceph/pull/10619), Chengwei Yang)
-   doc: fix singleton example in Developer Guide
    ([pr#10830](http://github.com/ceph/ceph/pull/10830), Nathan Cutler)
-   doc: fix some nits in release notes and releases table
    ([pr#10903](http://github.com/ceph/ceph/pull/10903), Nathan Cutler)
-   doc: fix standby replay config
    ([issue#16664](http://tracker.ceph.com/issues/16664),
    [pr#10268](http://github.com/ceph/ceph/pull/10268), Patrick
    Donnelly)
-   doc: fix wrong osdkeepalive name in mount.ceph manpage
    ([pr#10840](http://github.com/ceph/ceph/pull/10840), Zhi Zhang)
-   doc: fix/add changelog for 10.2.2, 0.94.7, 0.94.8
    ([pr#10895](http://github.com/ceph/ceph/pull/10895), Sage Weil)
-   doc: format 2 now is the default image format
    ([pr#10705](http://github.com/ceph/ceph/pull/10705), Chengwei Yang)
-   doc: lgtm (build verified f23)
    ([pr#9745](http://github.com/ceph/ceph/pull/9745), weiqiaomiao)
-   doc: mailmap updates for upcoming 11.0.0
    ([pr#9301](http://github.com/ceph/ceph/pull/9301), Yann Dupont)
-   doc: manual instructions to set up mds daemon
    ([pr#11115](http://github.com/ceph/ceph/pull/11115), Peter Maloney)
-   doc: missing \"make vstart\" in quick_guide.rst
    ([pr#11226](http://github.com/ceph/ceph/pull/11226), Leo Zhang)
-   doc: more details for pool deletion
    ([pr#10190](http://github.com/ceph/ceph/pull/10190), Ken Dreyer)
-   doc: peering.rst, fix typo
    ([pr#10131](http://github.com/ceph/ceph/pull/10131), Brad Hubbard)
-   doc: perf_counters.rst fix trivial typo
    ([pr#10292](http://github.com/ceph/ceph/pull/10292), Brad Hubbard)
-   doc: rbdmap: specify bash shell interpreter
    ([issue#16608](http://tracker.ceph.com/issues/16608),
    [pr#10733](http://github.com/ceph/ceph/pull/10733), Jason Dillaman)
-   doc: release-notes.rst: draft 0.94.8 release notes
    ([pr#10730](http://github.com/ceph/ceph/pull/10730), Nathan Cutler)
-   doc: remove btrfs contradiction
    ([pr#9758](http://github.com/ceph/ceph/pull/9758), Nathan Cutler)
-   doc: remove i386 from minimal hardware recommendations
    ([pr#10276](http://github.com/ceph/ceph/pull/10276), Kefu Chai)
-   doc: remove old references to inktank premium support
    ([pr#11182](http://github.com/ceph/ceph/pull/11182), Alfredo Deza)
-   doc: remove the description of deleted options
    ([issue#17041](http://tracker.ceph.com/issues/17041),
    [pr#10741](http://github.com/ceph/ceph/pull/10741), MinSheng Lin)
-   doc: rgw, doc: fix formatting around Keystone-related options.
    ([pr#10331](http://github.com/ceph/ceph/pull/10331), Radoslaw
    Zarzynski)
-   doc: rgw/doc: fix indent
    ([pr#10676](http://github.com/ceph/ceph/pull/10676), Yan Jun)
-   doc: rm SysV instructions, add systemd
    ([pr#10184](http://github.com/ceph/ceph/pull/10184), Ken Dreyer)
-   doc: silence sphinx warnings
    ([pr#10621](http://github.com/ceph/ceph/pull/10621), Kefu Chai)
-   doc: small standby doc edits
    ([pr#10479](http://github.com/ceph/ceph/pull/10479), Patrick
    Donnelly)
-   doc: update CephFS \"early adopters\" info
    ([pr#10068](http://github.com/ceph/ceph/pull/10068), John Spray)
-   doc: update canonical tarballs URL
    ([pr#9695](http://github.com/ceph/ceph/pull/9695), Ken Dreyer)
-   doc: update rbd glance configuration notes
    ([pr#10629](http://github.com/ceph/ceph/pull/10629), Jason Dillaman)
-   doc: update s3 static webiste feature support status
    ([pr#10223](http://github.com/ceph/ceph/pull/10223), Jiaying Ren)
-   doc: changelog: add v10.2.3
    ([pr#11238](http://github.com/ceph/ceph/pull/11238), Abhishek
    Lekshmanan)
-   doc: install: Use <https://> for download.ceph.com
    ([pr#10709](http://github.com/ceph/ceph/pull/10709), Colin Walters)
-   doc: release-notes: v0.94.9
    ([pr#10927](http://github.com/ceph/ceph/pull/10927), Sage Weil)
-   doc: release-notes: v10.2.3 jewel
    ([pr#11234](http://github.com/ceph/ceph/pull/11234), Abhishek
    Lekshmanan)
-   doc: Add UK mirror and update copyright
    ([pr#10531](http://github.com/ceph/ceph/pull/10531), Patrick
    McGarry)
-   doc: README.md: replace package build instructions with tarball
    instructions ([pr#10829](http://github.com/ceph/ceph/pull/10829),
    Sage Weil)
-   doc: Removed reference about pool ownership based on BZ#1368528
    ([pr#11063](http://github.com/ceph/ceph/pull/11063), Bara Ancincova)
-   librados: use bufferlist instead of buffer::list in public header
    ([pr#10632](http://github.com/ceph/ceph/pull/10632), Ryne Li)
-   librados: Rados-stripper: Flexible string matching for not found
    attributes ([pr#10577](http://github.com/ceph/ceph/pull/10577),
    Willem Jan Withagen)
-   librados: librados examples: link and include from current source
    tree by default.
    ([issue#15100](http://tracker.ceph.com/issues/15100),
    [pr#8189](http://github.com/ceph/ceph/pull/8189), Jesse Williamson)
-   librbd: API methods to directly acquire and release the exclusive
    lock ([issue#15632](http://tracker.ceph.com/issues/15632),
    [pr#9592](http://github.com/ceph/ceph/pull/9592), Mykola Golub)
-   librbd: add consistency groups operations with images
    ([pr#10034](http://github.com/ceph/ceph/pull/10034), Victor Denisov)
-   librbd: add explicit shrink check while resizing images
    ([pr#9878](http://github.com/ceph/ceph/pull/9878), Vaibhav Bhembre)
-   librbd: asynchronous v2 image creation
    ([issue#15321](http://tracker.ceph.com/issues/15321),
    [pr#9585](http://github.com/ceph/ceph/pull/9585), Venky Shankar)
-   librbd: backward/forward compatibility for update_features
    ([issue#17330](http://tracker.ceph.com/issues/17330),
    [pr#11155](http://github.com/ceph/ceph/pull/11155), Jason Dillaman)
-   librbd: block name prefix might overflow fixed size C-string
    ([issue#17310](http://tracker.ceph.com/issues/17310),
    [pr#11148](http://github.com/ceph/ceph/pull/11148), Jason Dillaman)
-   librbd: cache was not switching to writeback after first flush
    ([issue#16654](http://tracker.ceph.com/issues/16654),
    [pr#10762](http://github.com/ceph/ceph/pull/10762), Jason Dillaman)
-   librbd: corrected use-after-free in ImageWatcher
    ([issue#17289](http://tracker.ceph.com/issues/17289),
    [pr#11112](http://github.com/ceph/ceph/pull/11112), Jason Dillaman)
-   librbd: deadlock when replaying journal during image open
    ([issue#17188](http://tracker.ceph.com/issues/17188),
    [pr#10945](http://github.com/ceph/ceph/pull/10945), Jason Dillaman)
-   librbd: delay acquiring lock if image watch has failed
    ([issue#16923](http://tracker.ceph.com/issues/16923),
    [pr#10574](http://github.com/ceph/ceph/pull/10574), Jason Dillaman)
-   librbd: discard hangs when \'rbd_skip_partial_discard\' is enabled
    ([issue#16386](http://tracker.ceph.com/issues/16386),
    [pr#10060](http://github.com/ceph/ceph/pull/10060), Mykola Golub)
-   librbd: extract group module from librbd/internal
    ([pr#11070](http://github.com/ceph/ceph/pull/11070), Victor Denisov)
-   librbd: failed assertion after shrinking a clone image twice
    ([issue#16561](http://tracker.ceph.com/issues/16561),
    [pr#10072](http://github.com/ceph/ceph/pull/10072), Jason Dillaman)
-   librbd: fix missing return statement if failed to get mirror image
    state ([pr#10136](http://github.com/ceph/ceph/pull/10136), runsisi)
-   librbd: fix possible inconsistent state when disabling mirroring
    fails ([issue#16984](http://tracker.ceph.com/issues/16984),
    [pr#10711](http://github.com/ceph/ceph/pull/10711), Jason Dillaman)
-   librbd: ignore partial refresh error when acquiring exclusive lock
    ([issue#17227](http://tracker.ceph.com/issues/17227),
    [pr#11044](http://github.com/ceph/ceph/pull/11044), Jason Dillaman)
-   librbd: initial hooks for client-side, image-extent cache in IO path
    ([pr#9121](http://github.com/ceph/ceph/pull/9121), Jason Dillaman)
-   librbd: interlock image refresh and exclusive lock operations
    ([issue#16773](http://tracker.ceph.com/issues/16773),
    [issue#17015](http://tracker.ceph.com/issues/17015),
    [pr#10770](http://github.com/ceph/ceph/pull/10770), Jason Dillaman)
-   librbd: memory leak in MirroringWatcher::notify_image_updated
    ([pr#11306](http://github.com/ceph/ceph/pull/11306), Mykola Golub)
-   librbd: optimize away unnecessary object map updates
    ([issue#16707](http://tracker.ceph.com/issues/16707),
    [issue#16689](http://tracker.ceph.com/issues/16689),
    [pr#10332](http://github.com/ceph/ceph/pull/10332), Jason Dillaman)
-   librbd: optionally unregister \"laggy\" journal clients
    ([issue#14738](http://tracker.ceph.com/issues/14738),
    [pr#10378](http://github.com/ceph/ceph/pull/10378), Mykola Golub)
-   librbd: permit disabling journaling if in corrupt state
    ([issue#16740](http://tracker.ceph.com/issues/16740),
    [pr#10712](http://github.com/ceph/ceph/pull/10712), Jason Dillaman)
-   librbd: possible deadlock if cluster connection closed after image
    ([issue#17254](http://tracker.ceph.com/issues/17254),
    [pr#11037](http://github.com/ceph/ceph/pull/11037), Jason Dillaman)
-   librbd: potential deadlock closing image with in-flight readahead
    ([issue#17198](http://tracker.ceph.com/issues/17198),
    [pr#11152](http://github.com/ceph/ceph/pull/11152), Jason Dillaman)
-   librbd: potential double-unwatch of watch handle upon error
    ([issue#17210](http://tracker.ceph.com/issues/17210),
    [pr#10974](http://github.com/ceph/ceph/pull/10974), Jason Dillaman)
-   librbd: potential seg fault when blacklisting an image client
    ([issue#17251](http://tracker.ceph.com/issues/17251),
    [pr#11034](http://github.com/ceph/ceph/pull/11034), Jason Dillaman)
-   librbd: prevent creation of clone from non-primary mirrored image
    ([issue#16449](http://tracker.ceph.com/issues/16449),
    [pr#10123](http://github.com/ceph/ceph/pull/10123), Mykola Golub)
-   librbd: prevent creation of v2 image ids that are too large
    ([issue#16887](http://tracker.ceph.com/issues/16887),
    [pr#10581](http://github.com/ceph/ceph/pull/10581), Jason Dillaman)
-   mds: Add path filtering for dump cache
    ([issue#11171](http://tracker.ceph.com/issues/11171),
    [pr#9925](http://github.com/ceph/ceph/pull/9925), Douglas Fuller)
-   mds: Kill C_SaferCond in evict_sessions()
    ([issue#16288](http://tracker.ceph.com/issues/16288),
    [pr#9971](http://github.com/ceph/ceph/pull/9971), Douglas Fuller)
-   mds: Return \"committing\" rather than \"committed\" member in
    get_committing ([pr#10250](http://github.com/ceph/ceph/pull/10250),
    Greg Farnum)
-   mds: Set mds_snap_max_uid to 4294967294
    ([pr#11016](http://github.com/ceph/ceph/pull/11016), Wido den
    Hollander)
-   mds: add assertion in handle_slave_rename_prep
    ([issue#16807](http://tracker.ceph.com/issues/16807),
    [pr#10429](http://github.com/ceph/ceph/pull/10429), John Spray)
-   mds: add assertions for standby_daemons invariant
    ([issue#16592](http://tracker.ceph.com/issues/16592),
    [pr#10316](http://github.com/ceph/ceph/pull/10316), Patrick
    Donnelly)
-   mds: add health warning for oversized cache
    ([issue#16570](http://tracker.ceph.com/issues/16570),
    [pr#10245](http://github.com/ceph/ceph/pull/10245), John Spray)
-   mds: add maximum fragment size constraint
    ([issue#16164](http://tracker.ceph.com/issues/16164),
    [pr#9789](http://github.com/ceph/ceph/pull/9789), Patrick Donnelly)
-   mds: add perf counters for MDLog replay and SessionMap
    ([pr#10539](http://github.com/ceph/ceph/pull/10539), John Spray)
-   mds: catch duplicates in DamageTable
    ([issue#17173](http://tracker.ceph.com/issues/17173),
    [pr#11137](http://github.com/ceph/ceph/pull/11137), John Spray)
-   mds: fix <Session::check_access>()
    ([issue#16358](http://tracker.ceph.com/issues/16358),
    [pr#9769](http://github.com/ceph/ceph/pull/9769), Yan, Zheng)
-   mds: fix daemon selection when starting ranks
    ([pr#10540](http://github.com/ceph/ceph/pull/10540), John Spray)
-   mds: fix shutting down mds timed-out due to deadlock
    ([issue#16396](http://tracker.ceph.com/issues/16396),
    [pr#9884](http://github.com/ceph/ceph/pull/9884), Zhi Zhang)
-   mds: fix up \_dispatch ref-counting semantics
    ([pr#10533](http://github.com/ceph/ceph/pull/10533), Greg Farnum)
-   mds: fixup dump Formatter\' type error; add path_ino and is_primary
    in the CDentry::dump()
    ([pr#10119](http://github.com/ceph/ceph/pull/10119), huanwen ren)
-   mds: handle blacklisting during journal recovery
    ([issue#17236](http://tracker.ceph.com/issues/17236),
    [pr#11138](http://github.com/ceph/ceph/pull/11138), John Spray)
-   mds: log path with CDir damage messages
    ([issue#16973](http://tracker.ceph.com/issues/16973),
    [pr#10996](http://github.com/ceph/ceph/pull/10996), John Spray)
-   mds: move Finisher to unlocked shutdown
    ([issue#16042](http://tracker.ceph.com/issues/16042),
    [pr#10142](http://github.com/ceph/ceph/pull/10142), Patrick
    Donnelly)
-   mds: populate DamageTable from scrub and log more quietly
    ([issue#16016](http://tracker.ceph.com/issues/16016),
    [pr#11136](http://github.com/ceph/ceph/pull/11136), John Spray)
-   mds: remove fail-safe queueing replay request
    ([issue#17271](http://tracker.ceph.com/issues/17271),
    [pr#11078](http://github.com/ceph/ceph/pull/11078), Yan, Zheng)
-   mds: remove max_mds config option
    ([issue#17105](http://tracker.ceph.com/issues/17105),
    [pr#10914](http://github.com/ceph/ceph/pull/10914), Patrick
    Donnelly)
-   mds: remove unused MDSDaemon::objecter
    ([pr#10566](http://github.com/ceph/ceph/pull/10566), Patrick
    Donnelly)
-   mds: snap failover fixes
    ([pr#9955](http://github.com/ceph/ceph/pull/9955), Yan, Zheng)
-   mds: trim null dentries proactively
    ([issue#16919](http://tracker.ceph.com/issues/16919),
    [pr#10606](http://github.com/ceph/ceph/pull/10606), John Spray)
-   mds: unuse Class and cleanup
    ([pr#10399](http://github.com/ceph/ceph/pull/10399), huanwen ren)
-   mds: use reference to avoid copy
    ([pr#10191](http://github.com/ceph/ceph/pull/10191), Patrick
    Donnelly)
-   mds: MDCache.h: remove unneeded access specifier
    ([pr#10901](http://github.com/ceph/ceph/pull/10901), Michal
    Jarzabek)
-   mds: MDSDaemon: move C_MDS_Tick class to .cc file
    ([pr#11220](http://github.com/ceph/ceph/pull/11220), Michal
    Jarzabek)
-   mgr: implement con reset handling
    ([pr#11299](http://github.com/ceph/ceph/pull/11299), Sage Weil)
-   mgr: squash compiler warnings
    ([pr#11307](http://github.com/ceph/ceph/pull/11307), John Spray)
-   mon: MonClient may hang on pinging an unresponsive monitor
    ([pr#9259](http://github.com/ceph/ceph/pull/9259), xie xingguo)
-   mon: Monitor: validate prefix on handle_command()
    ([issue#16297](http://tracker.ceph.com/issues/16297),
    [pr#9700](http://github.com/ceph/ceph/pull/9700), You Ji)
-   mon: OSDMonitor: Missing nearfull flag set
    ([pr#11082](http://github.com/ceph/ceph/pull/11082), Igor Podoski)
-   mon: change osdmap flags set and unset messages
    ([issue#15983](http://tracker.ceph.com/issues/15983),
    [pr#9252](http://github.com/ceph/ceph/pull/9252), Vikhyat Umrao)
-   mon: clear list in better way
    ([pr#9718](http://github.com/ceph/ceph/pull/9718), song baisen)
-   mon: do not recalculate \'to_remove\' when it\'s known
    ([pr#9717](http://github.com/ceph/ceph/pull/9717), song baisen)
-   mon: misc cleanups
    ([pr#10591](http://github.com/ceph/ceph/pull/10591), xie xingguo)
-   mon: remove the redundant cancel_probe_timeout function
    ([pr#10261](http://github.com/ceph/ceph/pull/10261), song baisen)
-   mon: remove the redundant is_active judge in PaxosService
    ([pr#9749](http://github.com/ceph/ceph/pull/9749), song baisen)
-   mon: tear down standby replays on MDS rank stop
    ([issue#16909](http://tracker.ceph.com/issues/16909),
    [pr#10628](http://github.com/ceph/ceph/pull/10628), John Spray)
-   mon: use clearer code structure
    ([pr#10192](http://github.com/ceph/ceph/pull/10192), Patrick
    Donnelly)
-   mon: validate states transmitted in beacons
    ([issue#16592](http://tracker.ceph.com/issues/16592),
    [pr#10428](http://github.com/ceph/ceph/pull/10428), John Spray)
-   mon: wait 10m (not 5m) before marking down OSDs out
    ([pr#11184](http://github.com/ceph/ceph/pull/11184), Sage Weil)
-   mon: write fsid use the right return value
    ([pr#10197](http://github.com/ceph/ceph/pull/10197), song baisen)
-   mon: Elector:move C_ElectionExpire class to cc file
    ([pr#10416](http://github.com/ceph/ceph/pull/10416), Michal
    Jarzabek)
-   mon: HealthMonitor: add override to virtual functs
    ([pr#10549](http://github.com/ceph/ceph/pull/10549), Michal
    Jarzabek)
-   mon: HealthMonitor: remove unneeded include
    ([pr#10563](http://github.com/ceph/ceph/pull/10563), Michal
    Jarzabek)
-   mon: MonClient.h: delete copy constr and assing op
    ([pr#10599](http://github.com/ceph/ceph/pull/10599), Michal
    Jarzabek)
-   mon: MonClient: move C_CancelMonCommand to cc file
    ([pr#10392](http://github.com/ceph/ceph/pull/10392), Michal
    Jarzabek)
-   mon: MonClient: move C_Tick struct to cc file
    ([pr#10383](http://github.com/ceph/ceph/pull/10383), Michal
    Jarzabek)
-   mon: Monitor.h: add override to virtual functions
    ([pr#10515](http://github.com/ceph/ceph/pull/10515), Michal
    Jarzabek)
-   mon: Monitor: move C_Scrub, C_ScrubTimeout to .cc
    ([pr#10513](http://github.com/ceph/ceph/pull/10513), Michal
    Jarzabek)
-   mon: OSDMonitor.cc: remove unneeded casts
    ([pr#10575](http://github.com/ceph/ceph/pull/10575), Michal
    Jarzabek)
-   mon: Paxos: move classes to .cc file
    ([pr#11215](http://github.com/ceph/ceph/pull/11215), Michal
    Jarzabek)
-   mon: PaxosService: move classes to cc file
    ([pr#10529](http://github.com/ceph/ceph/pull/10529), Michal
    Jarzabek)
-   mon: remove the redundant list swap in paxos commit_proposal
    ([pr#10011](http://github.com/ceph/ceph/pull/10011), song baisen)
-   msgr: set close on exec flag
    ([issue#16390](http://tracker.ceph.com/issues/16390),
    [pr#9772](http://github.com/ceph/ceph/pull/9772), Kefu Chai)
-   msgr: Accepter.h: add override to virtual function
    ([pr#10422](http://github.com/ceph/ceph/pull/10422), Michal
    Jarzabek)
-   msgr: Accepter: move include to cc file
    ([pr#10441](http://github.com/ceph/ceph/pull/10441), Michal
    Jarzabek)
-   msgr: AsyncConnection: add const to mem functions
    ([pr#10302](http://github.com/ceph/ceph/pull/10302), Michal
    Jarzabek)
-   msgr: AsyncMessenger.cc: remove unneeded cast
    ([pr#10141](http://github.com/ceph/ceph/pull/10141), Michal
    Jarzabek)
-   msgr: AsyncMessenger: add const to function
    ([pr#10114](http://github.com/ceph/ceph/pull/10114), Michal
    Jarzabek)
-   msgr: AsyncMessenger: move C_handle_reap class to cc
    ([pr#10113](http://github.com/ceph/ceph/pull/10113), Michal
    Jarzabek)
-   msgr: AsyncMessenger: move C_processor_accept class
    ([pr#9991](http://github.com/ceph/ceph/pull/9991), Michal Jarzabek)
-   msgr: AsyncMessenger: remove unneeded include file
    ([pr#10195](http://github.com/ceph/ceph/pull/10195), Michal
    Jarzabek)
-   msgr: AsyncMessenger: remove unused function
    ([pr#10163](http://github.com/ceph/ceph/pull/10163), Michal
    Jarzabek)
-   msgr: EventKqueue.h: add override to virtual func
    ([pr#10318](http://github.com/ceph/ceph/pull/10318), Michal
    Jarzabek)
-   msgr: EventPoll.h: add override to virtual functions
    ([pr#10314](http://github.com/ceph/ceph/pull/10314), Michal
    Jarzabek)
-   msgr: EventSelect.h: add override to virtual funct
    ([pr#10321](http://github.com/ceph/ceph/pull/10321), Michal
    Jarzabek)
-   msgr: EventSelect: move includes to cc file
    ([pr#10333](http://github.com/ceph/ceph/pull/10333), Michal
    Jarzabek)
-   msgr: FastStrategy.h: add override to virtual funct
    ([pr#10482](http://github.com/ceph/ceph/pull/10482), Michal
    Jarzabek)
-   msgr: Message.h: add const to member function
    ([pr#10354](http://github.com/ceph/ceph/pull/10354), Michal
    Jarzabek)
-   msgr: Message.h: remove code duplication
    ([pr#10356](http://github.com/ceph/ceph/pull/10356), Michal
    Jarzabek)
-   msgr: QueueStrategy: add override to virtual functs
    ([pr#10503](http://github.com/ceph/ceph/pull/10503), Michal
    Jarzabek)
-   msgr: Stack.h: delete copy constr and assign op
    ([pr#11107](http://github.com/ceph/ceph/pull/11107), Michal
    Jarzabek)
-   msgr: async/Event.h: add const to member function
    ([pr#10224](http://github.com/ceph/ceph/pull/10224), Michal
    Jarzabek)
-   msgr: async: remove unused code.
    ([pr#11247](http://github.com/ceph/ceph/pull/11247), Jianpeng Ma)
-   osd: bail out if transaction size overflows
    ([issue#16982](http://tracker.ceph.com/issues/16982),
    [pr#10753](http://github.com/ceph/ceph/pull/10753), Kefu Chai)
-   osd: cleanup options and other redundancies
    ([pr#10450](http://github.com/ceph/ceph/pull/10450), xie xingguo)
-   osd: drop unused variables/methods
    ([pr#10559](http://github.com/ceph/ceph/pull/10559), xie xingguo)
-   osd: fix the mem leak of RepGather
    ([issue#16801](http://tracker.ceph.com/issues/16801),
    [pr#10423](http://github.com/ceph/ceph/pull/10423), Kefu Chai)
-   osd: fixups to explicitly persistenting missing sets
    ([pr#10405](http://github.com/ceph/ceph/pull/10405), Samuel Just)
-   osd: increment stats on recovery pull also
    ([issue#16277](http://tracker.ceph.com/issues/16277),
    [pr#10152](http://github.com/ceph/ceph/pull/10152), Kefu Chai)
-   osd: limit omap data in push op
    ([issue#16128](http://tracker.ceph.com/issues/16128),
    [pr#9894](http://github.com/ceph/ceph/pull/9894), Wanlong Gao)
-   osd: minor performance improvements
    ([pr#10470](http://github.com/ceph/ceph/pull/10470), xie xingguo)
-   osd: minor performance improvements and fixes
    ([pr#10526](http://github.com/ceph/ceph/pull/10526), xie xingguo)
-   osd: misc fixes and cleanups
    ([pr#10610](http://github.com/ceph/ceph/pull/10610), xie xingguo)
-   osd: miscellaneous fixes
    ([pr#10572](http://github.com/ceph/ceph/pull/10572), xie xingguo)
-   osd: more cleanups
    ([pr#10548](http://github.com/ceph/ceph/pull/10548), xie xingguo)
-   osd: object class loading and execution permissions
    ([pr#9972](http://github.com/ceph/ceph/pull/9972), Noah Watkins)
-   osd: pass shared_ptr by const reference
    ([pr#11266](http://github.com/ceph/ceph/pull/11266), Michal
    Jarzabek)
-   osd: persist the missing set explicitly
    ([pr#10334](http://github.com/ceph/ceph/pull/10334), Samuel Just)
-   osd: remove dispatch queue check since we don\'t queue hb message to
    this ([pr#9947](http://github.com/ceph/ceph/pull/9947), Haomai Wang)
-   osd: remove duplicated function
    ([pr#9117](http://github.com/ceph/ceph/pull/9117), Wei Jin)
-   osd: replace ceph:atomic_t with std::atomic in osd module.
    ([pr#9138](http://github.com/ceph/ceph/pull/9138), Xiaowei Chen)
-   osd: should not look up an empty pg
    ([issue#17380](http://tracker.ceph.com/issues/17380),
    [pr#11208](http://github.com/ceph/ceph/pull/11208), Kefu Chai, Loic
    Dachary)
-   osd: small cleanups
    ([pr#9980](http://github.com/ceph/ceph/pull/9980), Wanlong Gao)
-   osd: subscribe for old osdmaps when pause flag is set
    ([issue#17023](http://tracker.ceph.com/issues/17023),
    [pr#10725](http://github.com/ceph/ceph/pull/10725), Kefu Chai)
-   osd:preserve allocation hint attribute during recovery
    ([pr#9452](http://github.com/ceph/ceph/pull/9452), yaoning)
-   osd: osd-fast-mark-down.sh: fix typo in variable assignments
    ([pr#11224](http://github.com/ceph/ceph/pull/11224), Willem Jan
    Withagen)
-   osd: OSD.cc: initialise variable at definition
    ([pr#11099](http://github.com/ceph/ceph/pull/11099), Michal
    Jarzabek)
-   osd: OSD.cc: remove unneeded searching of map
    ([pr#11000](http://github.com/ceph/ceph/pull/11000), Michal
    Jarzabek)
-   osd: OSD.h: make some members private
    ([pr#11085](http://github.com/ceph/ceph/pull/11085), Michal
    Jarzabek)
-   osd: PG.cc: remove unneeded use of count
    ([pr#11228](http://github.com/ceph/ceph/pull/11228), Michal
    Jarzabek)
-   osd: PGBackend.h: move structs to .cc file
    ([pr#10975](http://github.com/ceph/ceph/pull/10975), Michal
    Jarzabek)
-   osd: ReplicatedBackend: move classes to cc file
    ([pr#10967](http://github.com/ceph/ceph/pull/10967), Michal
    Jarzabek)
-   osd: ReplicatedPG.h: add override to virtual funct
    ([pr#11271](http://github.com/ceph/ceph/pull/11271), Michal
    Jarzabek)
-   osd: ReplicatedPG: move classes to .cc file
    ([pr#10971](http://github.com/ceph/ceph/pull/10971), Michal
    Jarzabek)
-   osd: ReplicatedPG:move C_OSD_OnApplied class to cc
    ([pr#11288](http://github.com/ceph/ceph/pull/11288), Michal
    Jarzabek)
-   osd: Watch.h: remove unneeded forward declaration
    ([pr#10269](http://github.com/ceph/ceph/pull/10269), Michal
    Jarzabek)
-   osd: osdc/ObjectCacher.h: add const to member functions
    ([pr#9569](http://github.com/ceph/ceph/pull/9569), Michal Jarzabek)
-   osd: osdc/ObjectCacher.h: add const to member functions
    ([pr#9652](http://github.com/ceph/ceph/pull/9652), Michal Jarzabek)
-   osd: osdc/Objecter: move RequestStateHook class to .cc
    ([pr#10734](http://github.com/ceph/ceph/pull/10734), Michal
    Jarzabek)
-   pybind: Port Python-based tests and remaining Python bindings to
    Python 3 ([pr#10177](http://github.com/ceph/ceph/pull/10177), Oleh
    Prypin)
-   pybind: Rework cephfs/setup.py for PyPI
    ([pr#10315](http://github.com/ceph/ceph/pull/10315), Anirudha Bose)
-   pybind: Rework rbd/setup.py for PyPI
    ([issue#16940](http://tracker.ceph.com/issues/16940),
    [pr#10376](http://github.com/ceph/ceph/pull/10376), Anirudha Bose)
-   pybind: global/signal_handler: dump cmdline instead of arg\[0\]
    ([pr#10345](http://github.com/ceph/ceph/pull/10345), Kefu Chai)
-   pybind: make rados ready for PyPI
    ([pr#9833](http://github.com/ceph/ceph/pull/9833), Anirudha Bose)
-   pybind: pybind/ceph_argparse: handle non ascii unicode args
    ([issue#12287](http://tracker.ceph.com/issues/12287),
    [pr#8943](http://github.com/ceph/ceph/pull/8943), Kefu Chai)
-   pybind: Python 3 compatibility for workunits
    ([pr#10815](http://github.com/ceph/ceph/pull/10815), Anirudha Bose)
-   rbd: Allow user to remove snapshot with \--force to auto flatten
    children ([pr#10087](http://github.com/ceph/ceph/pull/10087),
    Dongsheng Yang)
-   rbd: Reviewed-off-by: Ilya Dryomov \<<idryomov@gmail.com>\>
    ([issue#16171](http://tracker.ceph.com/issues/16171),
    [pr#10481](http://github.com/ceph/ceph/pull/10481), Jason Dillaman)
-   rbd: Reviewed-off-by: Ilya Dryomov \<<idryomov@gmail.com>\>
    ([issue#17030](http://tracker.ceph.com/issues/17030),
    [pr#10735](http://github.com/ceph/ceph/pull/10735), Jason Dillaman)
-   rbd: bench io-size should not be larger than image size
    ([issue#16967](http://tracker.ceph.com/issues/16967),
    [pr#10708](http://github.com/ceph/ceph/pull/10708), Jason Dillaman)
-   rbd: cleanup - Proxied operations shouldn\'t result in error
    messages if replayed
    ([issue#16130](http://tracker.ceph.com/issues/16130),
    [pr#9724](http://github.com/ceph/ceph/pull/9724), Vikhyat Umrao)
-   rbd: cls_rbd: clean up status from rbd-mirror if image removed
    ([pr#11142](http://github.com/ceph/ceph/pull/11142), Huan Zhang)
-   rbd: cls_rbd: set omap values in batch during image creation
    ([pr#9981](http://github.com/ceph/ceph/pull/9981), Dongsheng Yang)
-   rbd: inherit the parent image features when cloning an image
    ([issue#15388](http://tracker.ceph.com/issues/15388),
    [pr#9334](http://github.com/ceph/ceph/pull/9334), Dongsheng Yang)
-   rbd: journal: ensure in-flight ops are complete destroying journaler
    ([issue#17446](http://tracker.ceph.com/issues/17446),
    [pr#11257](http://github.com/ceph/ceph/pull/11257), Mykola Golub,
    Jason Dillaman)
-   rbd: journal: increase concurrency/parallelism of journal recorder
    ([issue#15259](http://tracker.ceph.com/issues/15259),
    [pr#10445](http://github.com/ceph/ceph/pull/10445), Ricardo Dias)
-   rbd: journal: move JournalTrimmer::C_RemoveSet struct
    ([pr#10912](http://github.com/ceph/ceph/pull/10912), Michal
    Jarzabek)
-   rbd: qa/workunits/rbd: before removing image make sure it is not
    bootstrapped ([issue#16555](http://tracker.ceph.com/issues/16555),
    [pr#10155](http://github.com/ceph/ceph/pull/10155), Mykola Golub)
-   rbd: qa/workunits/rbd: check status also in pool dir after asok
    commands ([pr#11291](http://github.com/ceph/ceph/pull/11291), Mykola
    Golub)
-   rbd: qa/workunits/rbd: set image-meta on primary image and wait it
    is replicated ([pr#11294](http://github.com/ceph/ceph/pull/11294),
    Mykola Golub)
-   rbd: qa/workunits/rbd: small fixup and improvements for rbd-mirror
    tests ([pr#10483](http://github.com/ceph/ceph/pull/10483), Mykola
    Golub)
-   rbd: qa/workunits/rbd: wait for image deleted before checking health
    ([pr#10545](http://github.com/ceph/ceph/pull/10545), Mykola Golub)
-   rbd: qa/workunits: support filtering cls_rbd unit test cases
    ([issue#16529](http://tracker.ceph.com/issues/16529),
    [pr#10714](http://github.com/ceph/ceph/pull/10714), Jason Dillaman)
-   rbd: rbd-mirror: \'wait_for_scheduled_deletion\' callback might
    deadlock ([issue#16491](http://tracker.ceph.com/issues/16491),
    [pr#9964](http://github.com/ceph/ceph/pull/9964), Jason Dillaman)
-   rbd: rbd-mirror: Add sparse read for sync image
    ([issue#16780](http://tracker.ceph.com/issues/16780),
    [pr#11005](http://github.com/ceph/ceph/pull/11005), tianqing)
-   rbd: rbd-mirror: add additional test scenarios
    ([pr#10488](http://github.com/ceph/ceph/pull/10488), lande1234)
-   rbd: rbd-mirror: concurrent access of event might result in heap
    corruption ([issue#17283](http://tracker.ceph.com/issues/17283),
    [pr#11104](http://github.com/ceph/ceph/pull/11104), Jason Dillaman)
-   rbd: rbd-mirror: force-promoted image will remain R/O until
    rbd-mirror daemon restarted
    ([issue#16974](http://tracker.ceph.com/issues/16974),
    [pr#11090](http://github.com/ceph/ceph/pull/11090), Jason Dillaman)
-   rbd: rbd-mirror: gracefully fail if object map is unavailable
    ([issue#16558](http://tracker.ceph.com/issues/16558),
    [pr#10065](http://github.com/ceph/ceph/pull/10065), Jason Dillaman)
-   rbd: rbd-mirror: gracefully handle being blacklisted
    ([issue#16349](http://tracker.ceph.com/issues/16349),
    [pr#9970](http://github.com/ceph/ceph/pull/9970), Jason Dillaman)
-   rbd: rbd-mirror: image deleter should use pool id + global image
    uuid for key ([issue#16538](http://tracker.ceph.com/issues/16538),
    [issue#16227](http://tracker.ceph.com/issues/16227),
    [pr#10484](http://github.com/ceph/ceph/pull/10484), Jason Dillaman)
-   rbd: rbd-mirror: improve split-brain detection logic
    ([issue#16855](http://tracker.ceph.com/issues/16855),
    [pr#10703](http://github.com/ceph/ceph/pull/10703), Jason Dillaman)
-   rbd: rbd-mirror: include local pool id in resync throttle unique key
    ([issue#16536](http://tracker.ceph.com/issues/16536),
    [pr#10254](http://github.com/ceph/ceph/pull/10254), Jason Dillaman)
-   rbd: rbd-mirror: non-primary image is recording journal events
    during image sync
    ([pr#10462](http://github.com/ceph/ceph/pull/10462), Jason Dillaman)
-   rbd: rbd-mirror: potential IO stall when using asok flush request
    ([issue#16708](http://tracker.ceph.com/issues/16708),
    [pr#10432](http://github.com/ceph/ceph/pull/10432), Jason Dillaman)
-   rbd: rbd-mirror: potential assertion failure during error-induced
    shutdown ([issue#16956](http://tracker.ceph.com/issues/16956),
    [pr#10613](http://github.com/ceph/ceph/pull/10613), Jason Dillaman)
-   rbd: rbd-mirror: potential race condition during failure shutdown
    ([issue#16980](http://tracker.ceph.com/issues/16980),
    [pr#10667](http://github.com/ceph/ceph/pull/10667), Jason Dillaman)
-   rbd: rbd-mirror: quiesce in-flight event commits before shut down
    ([issue#17355](http://tracker.ceph.com/issues/17355),
    [pr#11185](http://github.com/ceph/ceph/pull/11185), Jason Dillaman)
-   rbd: rbd-mirror: reduce memory footprint during journal replay
    ([issue#16223](http://tracker.ceph.com/issues/16223),
    [pr#10341](http://github.com/ceph/ceph/pull/10341), Jason Dillaman)
-   rbd: rbd-mirror: remove ceph_test_rbd_mirror_image_replay test case
    ([issue#16539](http://tracker.ceph.com/issues/16539),
    [pr#10083](http://github.com/ceph/ceph/pull/10083), Mykola Golub)
-   rbd: rbd-mirror: replaying state should include flush action
    ([issue#16970](http://tracker.ceph.com/issues/16970),
    [pr#10627](http://github.com/ceph/ceph/pull/10627), Jason Dillaman)
-   rbd: rbd-mirror: replicate dynamic feature updates
    ([issue#16213](http://tracker.ceph.com/issues/16213),
    [pr#10980](http://github.com/ceph/ceph/pull/10980), Mykola Golub)
-   rbd: rbd-mirror: replicate image metadata settings
    ([issue#16212](http://tracker.ceph.com/issues/16212),
    [pr#11168](http://github.com/ceph/ceph/pull/11168), Mykola Golub)
-   rbd: rbd-mirror: snap rename does not properly replicate to peers
    ([issue#16622](http://tracker.ceph.com/issues/16622),
    [pr#10249](http://github.com/ceph/ceph/pull/10249), Jason Dillaman)
-   rbd: rbd-nbd does not properly handle resize notifications
    ([issue#15715](http://tracker.ceph.com/issues/15715),
    [pr#9291](http://github.com/ceph/ceph/pull/9291), Mykola Golub)
-   rbd: rbd-nbd: fix kernel deadlock during teuthology testing
    ([issue#16921](http://tracker.ceph.com/issues/16921),
    [pr#10985](http://github.com/ceph/ceph/pull/10985), Jason Dillaman)
-   rbd: recognize lock_on_read option
    ([pr#11313](http://github.com/ceph/ceph/pull/11313), Ilya Dryomov)
-   rbd: return error if we specified a wrong image name for rbd du
    ([issue#16987](http://tracker.ceph.com/issues/16987),
    [pr#11031](http://github.com/ceph/ceph/pull/11031), Dongsheng Yang)
-   rbd: test/librbd/fsx: enable exclusive-lock feature in krbd mode
    ([pr#10984](http://github.com/ceph/ceph/pull/10984), Ilya Dryomov)
-   rbd: test/rbd: fix possible mock journal race conditions
    ([issue#17317](http://tracker.ceph.com/issues/17317),
    [pr#11153](http://github.com/ceph/ceph/pull/11153), Jason Dillaman)
-   rbd: test: cmake related fixups for rbd tests
    ([pr#10124](http://github.com/ceph/ceph/pull/10124), Mykola Golub)
-   rbd: test: run-rbd-tests test cmake fixup
    ([pr#10134](http://github.com/ceph/ceph/pull/10134), Mykola Golub)
-   rbd: test: use wrapper that respects RBD_FEATURES when creating rbd
    image ([issue#16717](http://tracker.ceph.com/issues/16717),
    [pr#10348](http://github.com/ceph/ceph/pull/10348), Mykola Golub)
-   rbd: udev: add krbd readahead placeholder
    ([pr#10841](http://github.com/ceph/ceph/pull/10841), Nick Fisk)
-   rbd: rbd_mirror/ImageSynceThrottler: move struct to .cc
    ([pr#10928](http://github.com/ceph/ceph/pull/10928), Michal
    Jarzabek)
-   rgw: (build verified, provably unused/not aliased)
    ([pr#9993](http://github.com/ceph/ceph/pull/9993), weiqiaomiao)
-   rgw: Add documentation for the Multi-tenancy feature
    ([pr#9570](http://github.com/ceph/ceph/pull/9570), Pete Zaitcev)
-   rgw: Clean up lifecycle thread
    ([pr#10480](http://github.com/ceph/ceph/pull/10480), Daniel
    Gryniewicz)
-   rgw: Do not archive metadata by default
    ([issue#17256](http://tracker.ceph.com/issues/17256),
    [pr#11051](http://github.com/ceph/ceph/pull/11051), Pavan
    Rallabhandi)
-   rgw: Fix Host-\>bucket fallback logic inversion
    ([issue#15975](http://tracker.ceph.com/issues/15975),
    [issue#17136](http://tracker.ceph.com/issues/17136),
    [pr#10873](http://github.com/ceph/ceph/pull/10873), Robin H.
    Johnson)
-   rgw: Fix for using port 443 with pre-signed urls.
    ([issue#16548](http://tracker.ceph.com/issues/16548),
    [pr#10088](http://github.com/ceph/ceph/pull/10088), Pritha
    Srivastava)
-   rgw: Fix incorrect content length and range for zero sized objects
    during range requests
    ([issue#16388](http://tracker.ceph.com/issues/16388),
    [pr#10207](http://github.com/ceph/ceph/pull/10207), Pavan
    Rallabhandi)
-   rgw: Got rid of recursive mutex.
    ([pr#10562](http://github.com/ceph/ceph/pull/10562), Adam Kupczyk)
-   rgw: RGW : setting socket backlog for via ceph.conf
    ([issue#16406](http://tracker.ceph.com/issues/16406),
    [pr#9891](http://github.com/ceph/ceph/pull/9891), Feng Guo)
-   rgw: RGWMetaSyncCR holds refs to stacks instead of crs
    ([issue#16666](http://tracker.ceph.com/issues/16666),
    [pr#10301](http://github.com/ceph/ceph/pull/10301), Casey Bodley)
-   rgw: Reviewed by: Pritha Srivastava \<<prsrivas@redhat.com>\>
    ([issue#16188](http://tracker.ceph.com/issues/16188),
    [pr#9584](http://github.com/ceph/ceph/pull/9584), Albert Tu)
-   rgw: Rgw lifecycle testing
    ([pr#11131](http://github.com/ceph/ceph/pull/11131), Daniel
    Gryniewicz)
-   rgw: Rgw nfs 28 ([pr#10611](http://github.com/ceph/ceph/pull/10611),
    Matt Benjamin)
-   rgw: add configurables for {data,meta} sync error injection
    ([pr#10388](http://github.com/ceph/ceph/pull/10388), Yehuda Sadeh)
-   rgw: add deadlock detection to RGWCoroutinesManager::run()
    ([pr#10032](http://github.com/ceph/ceph/pull/10032), Casey Bodley)
-   rgw: add lc_pool when decode or encode struct RGWZoneParams
    ([pr#10439](http://github.com/ceph/ceph/pull/10439), weiqiaomiao)
-   rgw: add missing master_zone when running with old default region
    config ([issue#16627](http://tracker.ceph.com/issues/16627),
    [pr#10205](http://github.com/ceph/ceph/pull/10205), Orit Wasserman)
-   rgw: add pg_ver to tombstone_cache
    ([pr#9851](http://github.com/ceph/ceph/pull/9851), Casey Bodley)
-   rgw: add reinit/rebind logic (ldap)
    ([pr#10532](http://github.com/ceph/ceph/pull/10532), Matt Benjamin)
-   rgw: add return value checking to avoid possible subsequent
    [parse]{.title-ref} exception
    ([pr#10241](http://github.com/ceph/ceph/pull/10241), Yan Jun)
-   rgw: add suport for Swift-at-root dependent features of Swift API
    ([issue#16673](http://tracker.ceph.com/issues/16673),
    [pr#10280](http://github.com/ceph/ceph/pull/10280), Pritha
    Srivastava, Radoslaw Zarzynski)
-   rgw: add support for Static Website of Swift API
    ([pr#9844](http://github.com/ceph/ceph/pull/9844), Radoslaw
    Zarzynski)
-   rgw: add tenant support to multisite sync
    ([issue#16469](http://tracker.ceph.com/issues/16469),
    [pr#10075](http://github.com/ceph/ceph/pull/10075), Casey Bodley)
-   rgw: back off bucket sync on failures, don\'t store marker
    ([issue#16742](http://tracker.ceph.com/issues/16742),
    [pr#10355](http://github.com/ceph/ceph/pull/10355), Yehuda Sadeh)
-   rgw: better error message when user has no bucket created yet
    ([issue#16444](http://tracker.ceph.com/issues/16444),
    [pr#10162](http://github.com/ceph/ceph/pull/10162), Gaurav Kumar
    Garg)
-   rgw: clean-up in the authentication infrastructure
    ([pr#10212](http://github.com/ceph/ceph/pull/10212), Radoslaw
    Zarzynski)
-   rgw: clear realm watch on failed watch_restart
    ([issue#16817](http://tracker.ceph.com/issues/16817),
    [pr#10446](http://github.com/ceph/ceph/pull/10446), Casey Bodley)
-   rgw: collect skips a specific coroutine stack
    ([issue#16665](http://tracker.ceph.com/issues/16665),
    [pr#10274](http://github.com/ceph/ceph/pull/10274), Yehuda Sadeh)
-   rgw: cosmetic changes only\--build verified, f23
    ([pr#9931](http://github.com/ceph/ceph/pull/9931), Yan Jun)
-   rgw: delete region map after upgrade to zonegroup map
    ([issue#17051](http://tracker.ceph.com/issues/17051),
    [pr#10831](http://github.com/ceph/ceph/pull/10831), Casey Bodley)
-   rgw: do not try to encode or decode time_t and fix compiling
    warnings ([pr#10751](http://github.com/ceph/ceph/pull/10751), Kefu
    Chai)
-   rgw: don\'t fail if lost race when setting acls
    ([issue#16930](http://tracker.ceph.com/issues/16930),
    [pr#11286](http://github.com/ceph/ceph/pull/11286), Yehuda Sadeh)
-   rgw: drop create_bucket in fwd_request log message
    ([pr#10214](http://github.com/ceph/ceph/pull/10214), Abhishek
    Lekshmanan)
-   rgw: eradicate dynamic memory allocation in RGWPostObj.
    ([pr#11054](http://github.com/ceph/ceph/pull/11054), Radoslaw
    Zarzynski)
-   rgw: file setattr ([pr#8618](http://github.com/ceph/ceph/pull/8618),
    Matt Benjamin)
-   rgw: finish error_repo cr in stop_spawned_services()
    ([issue#16530](http://tracker.ceph.com/issues/16530),
    [pr#10031](http://github.com/ceph/ceph/pull/10031), Yehuda Sadeh)
-   rgw: fix RGWAccessControlPolicy_SWIFT::create return value check
    error ([issue#17090](http://tracker.ceph.com/issues/17090),
    [pr#10727](http://github.com/ceph/ceph/pull/10727), weiqiaomiao)
-   rgw: fix compilation
    ([pr#10252](http://github.com/ceph/ceph/pull/10252), Josh Durgin)
-   rgw: fix decoding of creation_time and last_update.
    ([issue#17167](http://tracker.ceph.com/issues/17167),
    [pr#11132](http://github.com/ceph/ceph/pull/11132), Orit Wasserman)
-   rgw: fix error_repo segfault in data sync
    ([issue#16603](http://tracker.ceph.com/issues/16603),
    [pr#10157](http://github.com/ceph/ceph/pull/10157), Casey Bodley)
-   rgw: fix failed to create bucket if a non-master zonegroup has a
    single zone ([pr#10991](http://github.com/ceph/ceph/pull/10991),
    weiqiaomiao)
-   rgw: fix flush_read_list() error msg
    ([pr#10749](http://github.com/ceph/ceph/pull/10749), Jiaying Ren)
-   rgw: fix for issue 16494
    ([issue#16494](http://tracker.ceph.com/issues/16494),
    [pr#10077](http://github.com/ceph/ceph/pull/10077), Yehuda Sadeh)
-   rgw: fix for s3tests failure when ldap auth is not applied
    ([pr#10669](http://github.com/ceph/ceph/pull/10669), Casey Bodley)
-   rgw: fix get object instance returned NoSuchKey error
    ([issue#17111](http://tracker.ceph.com/issues/17111),
    [pr#10820](http://github.com/ceph/ceph/pull/10820), Yang Honggang)
-   rgw: fix is_admin handling in RGWLDAPAuthEngine and introduce
    acct_privilege_t
    ([pr#10687](http://github.com/ceph/ceph/pull/10687), Radoslaw
    Zarzynski)
-   rgw: fix issue 16435
    ([issue#16435](http://tracker.ceph.com/issues/16435),
    [pr#10193](http://github.com/ceph/ceph/pull/10193), Yehuda Sadeh)
-   rgw: fix multi-delete query param parsing.
    ([issue#16618](http://tracker.ceph.com/issues/16618),
    [pr#10187](http://github.com/ceph/ceph/pull/10187), Robin H.
    Johnson)
-   rgw: fix period update \--commit return error
    ([issue#17110](http://tracker.ceph.com/issues/17110),
    [pr#10836](http://github.com/ceph/ceph/pull/10836), weiqiaomiao)
-   rgw: fix radosgw daemon core when reopen logs
    ([issue#17036](http://tracker.ceph.com/issues/17036),
    [pr#10737](http://github.com/ceph/ceph/pull/10737), weiqiaomiao)
-   rgw: fix regression with handling double underscore
    ([issue#16856](http://tracker.ceph.com/issues/16856),
    [pr#10939](http://github.com/ceph/ceph/pull/10939), Orit Wasserman)
-   rgw: fix rgw_bucket_dir_entry decode v
    ([pr#10918](http://github.com/ceph/ceph/pull/10918), Tianshan Qu)
-   rgw: fix the error return variable in log message and cleanups
    ([pr#10138](http://github.com/ceph/ceph/pull/10138), Yan Jun)
-   rgw: fix the missing return value
    ([pr#10122](http://github.com/ceph/ceph/pull/10122), Yan Jun)
-   rgw: fix upgrade from old multisite to new multisite configuration
    ([issue#16751](http://tracker.ceph.com/issues/16751),
    [pr#10368](http://github.com/ceph/ceph/pull/10368), Orit Wasserman)
-   rgw: fix wrong variable definition in cls_version_check func
    ([pr#10233](http://github.com/ceph/ceph/pull/10233), weiqiaomiao)
-   rgw: fix wrong variable definition in rgw_cls_lc_set_entry function
    ([pr#10408](http://github.com/ceph/ceph/pull/10408), weiqiaomiao)
-   rgw: for the create_bucket api, if the input creation_time is zero,
    we should set it to \'now\"
    ([issue#16597](http://tracker.ceph.com/issues/16597),
    [pr#10118](http://github.com/ceph/ceph/pull/10118), weiqiaomiao)
-   rgw: kill a compile warning for rgw_sync
    ([pr#10425](http://github.com/ceph/ceph/pull/10425), Casey Bodley,
    Abhishek Lekshmanan)
-   rgw: lgtm ([pr#9941](http://github.com/ceph/ceph/pull/9941),
    weiqiaomiao)
-   rgw: lgtm (build verified, f23)
    ([pr#9754](http://github.com/ceph/ceph/pull/9754), John Coyle)
-   rgw: lgtm, build verified f23
    ([pr#10035](http://github.com/ceph/ceph/pull/10035), Yan Jun)
-   rgw: lgtm\--build verified, f23
    ([pr#10002](http://github.com/ceph/ceph/pull/10002), Yan Jun)
-   rgw: lgtm\--build verified, f23
    ([pr#9985](http://github.com/ceph/ceph/pull/9985), Yan Jun)
-   rgw: lgtm\--should backport
    ([pr#9979](http://github.com/ceph/ceph/pull/9979), Yan Jun)
-   rgw: log mp upload failures due to parts mismatch
    ([pr#10424](http://github.com/ceph/ceph/pull/10424), Abhishek
    Lekshmanan)
-   rgw: merge setting flags operation together and cleanups
    ([pr#10203](http://github.com/ceph/ceph/pull/10203), Yan Jun)
-   rgw: miscellaneous cleanups
    ([pr#10299](http://github.com/ceph/ceph/pull/10299), Yan Jun)
-   rgw: multiple fixes for Swift\'s object expiration
    ([issue#16705](http://tracker.ceph.com/issues/16705),
    [issue#16684](http://tracker.ceph.com/issues/16684),
    [pr#10330](http://github.com/ceph/ceph/pull/10330), Radoslaw
    Zarzynski)
-   rgw: need to \'open_object_section\' before dump stats in
    \'RGWGetUsage\_...
    ([issue#17499](http://tracker.ceph.com/issues/17499),
    [pr#11325](http://github.com/ceph/ceph/pull/11325), weiqiaomiao)
-   rgw: obsolete \'radosgw-admin period prepare\' command
    ([issue#17387](http://tracker.ceph.com/issues/17387),
    [pr#11278](http://github.com/ceph/ceph/pull/11278), Gaurav Kumar
    Garg)
-   rgw: radosgw-admin: add \"\--orphan-stale-secs\" to \--help
    ([issue#17280](http://tracker.ceph.com/issues/17280),
    [pr#11098](http://github.com/ceph/ceph/pull/11098), Ken Dreyer)
-   rgw: radosgw-admin: zone\[group\] modify can change realm id
    ([issue#16839](http://tracker.ceph.com/issues/16839),
    [pr#10477](http://github.com/ceph/ceph/pull/10477), Casey Bodley)
-   rgw: raise log levels for common radosgw-admin errors
    ([issue#16935](http://tracker.ceph.com/issues/16935),
    [pr#10602](http://github.com/ceph/ceph/pull/10602), Shilpa
    Jagannath)
-   rgw: register the correct handler for cls_user_complete_stats
    ([issue#16624](http://tracker.ceph.com/issues/16624),
    [pr#10151](http://github.com/ceph/ceph/pull/10151), Orit Wasserman)
-   rgw: remove bucket index objects when deleting the bucket
    ([issue#16412](http://tracker.ceph.com/issues/16412),
    [pr#10120](http://github.com/ceph/ceph/pull/10120), Orit Wasserman)
-   rgw: remove possible duplicate setting
    ([pr#10110](http://github.com/ceph/ceph/pull/10110), Yan Jun)
-   rgw: remove the field ret from class RGWPutLC
    ([pr#10726](http://github.com/ceph/ceph/pull/10726), weiqiaomiao)
-   rgw: remove unused bufferlist variable
    ([pr#10194](http://github.com/ceph/ceph/pull/10194), Yan Jun)
-   rgw: remove unused realm from radosgw-admin zone modify
    ([issue#16632](http://tracker.ceph.com/issues/16632),
    [pr#10211](http://github.com/ceph/ceph/pull/10211), Orit Wasserman)
-   rgw: remove unused variables
    ([pr#10589](http://github.com/ceph/ceph/pull/10589), Yan Jun)
-   rgw: return \"NoSuchLifecycleConfiguration\" if lifecycle config
    does not exist ([pr#10442](http://github.com/ceph/ceph/pull/10442),
    weiqiaomiao)
-   rgw: revert a commit that broke s3 signature validation
    ([issue#17279](http://tracker.ceph.com/issues/17279),
    [pr#11102](http://github.com/ceph/ceph/pull/11102), Casey Bodley)
-   rgw: rgw file: remove busy-wait in RGWLibFS::gc()
    ([pr#10638](http://github.com/ceph/ceph/pull/10638), Matt Benjamin)
-   rgw: rgw ldap: protect rgw::from_base64 from non-base64 input
    ([pr#10777](http://github.com/ceph/ceph/pull/10777), Matt Benjamin)
-   rgw: rgw ldap: enforce simple_bind w/LDAPv3
    ([pr#10593](http://github.com/ceph/ceph/pull/10593), Matt Benjamin)
-   rgw: rgw multisite: RGWCoroutinesManager::run returns status of last
    cr ([issue#17047](http://tracker.ceph.com/issues/17047),
    [pr#10778](http://github.com/ceph/ceph/pull/10778), Casey Bodley)
-   rgw: rgw multisite: RGWDataSyncCR fails on errors from
    RGWListBucketIndexesCR
    ([issue#17073](http://tracker.ceph.com/issues/17073),
    [pr#10779](http://github.com/ceph/ceph/pull/10779), Casey Bodley)
-   rgw: rgw multisite: fix for assertion in RGWMetaSyncCR
    ([issue#17044](http://tracker.ceph.com/issues/17044),
    [pr#10743](http://github.com/ceph/ceph/pull/10743), Casey Bodley)
-   rgw: rgw multisite: fixes for period puller
    ([issue#16939](http://tracker.ceph.com/issues/16939),
    [pr#10596](http://github.com/ceph/ceph/pull/10596), Casey Bodley)
-   rgw: rgw multisite: trim data logs as peer zones catch up
    ([pr#10372](http://github.com/ceph/ceph/pull/10372), Casey Bodley)
-   rgw: rgw nfs v3 completions
    ([pr#10745](http://github.com/ceph/ceph/pull/10745), Matt Benjamin)
-   rgw: rgw-admin: allow unsetting user\'s email
    ([issue#13286](http://tracker.ceph.com/issues/13286),
    [pr#11340](http://github.com/ceph/ceph/pull/11340), Yehuda Sadeh,
    Weijun Duan)
-   rgw: rgw/admin: fix some return values and indents
    ([pr#9170](http://github.com/ceph/ceph/pull/9170), Yan Jun)
-   rgw: rgw/rados: remove confused error printout
    ([pr#9351](http://github.com/ceph/ceph/pull/9351), Yan Jun)
-   rgw: rgw/rgw_common.cc: modify the end check in RGWHTTPArgs::sys_get
    ([pr#9136](http://github.com/ceph/ceph/pull/9136), zhao kun)
-   rgw: rgw/rgw_lc.cc: fix sleep time according to the error message
    ([pr#10930](http://github.com/ceph/ceph/pull/10930), Weibing Zhang)
-   rgw: rgw/rgw_main: fix unnecessary variables defined
    ([pr#10475](http://github.com/ceph/ceph/pull/10475), zhang.zezhu)
-   rgw: rgw/swift: remove redundant assignment operation
    ([pr#11292](http://github.com/ceph/ceph/pull/11292), Yan Jun)
-   rgw: rgw_file: pre-assign times
    ([issue#17367](http://tracker.ceph.com/issues/17367),
    [pr#11181](http://github.com/ceph/ceph/pull/11181), Matt Benjamin)
-   rgw: rgw_file: fix rename cases and unify unlink
    ([pr#10271](http://github.com/ceph/ceph/pull/10271), Matt Benjamin)
-   rgw: rgw_file: fix set_attrs operation
    ([pr#11159](http://github.com/ceph/ceph/pull/11159), Matt Benjamin)
-   rgw: rgw_file: refuse partial, out-of-order writes
    ([pr#10284](http://github.com/ceph/ceph/pull/10284), Matt Benjamin)
-   rgw: rgw_file: restore local definition of RGWLibFS gc interval
    ([pr#10756](http://github.com/ceph/ceph/pull/10756), Matt Benjamin)
-   rgw: rgw_file: unlock() must precede out label
    ([pr#10635](http://github.com/ceph/ceph/pull/10635), Matt Benjamin)
-   rgw: right parenthesis is missing in radosgw-admin help message on
    caps ([pr#10947](http://github.com/ceph/ceph/pull/10947), Weibing
    Zhang)
-   rgw: set correct instance on the object
    ([issue#17443](http://tracker.ceph.com/issues/17443),
    [pr#11270](http://github.com/ceph/ceph/pull/11270), Yehuda Sadeh)
-   rgw: store oldest mdlog period in rados
    ([issue#16894](http://tracker.ceph.com/issues/16894),
    [pr#10558](http://github.com/ceph/ceph/pull/10558), Casey Bodley)
-   rgw: test/multi.py add a destructive attr to tests
    ([pr#10401](http://github.com/ceph/ceph/pull/10401), Abhishek
    Lekshmanan)
-   rgw: test/rgw: add \--gateways-per-zone to test_multi.py
    ([pr#10742](http://github.com/ceph/ceph/pull/10742), Casey Bodley)
-   rgw: test_multi.py avoid creating mds
    ([pr#10174](http://github.com/ceph/ceph/pull/10174), Abhishek
    Lekshmanan)
-   rgw: test_rgw_bencode: null terminate strings before checking
    ([issue#16861](http://tracker.ceph.com/issues/16861),
    [pr#10510](http://github.com/ceph/ceph/pull/10510), Yehuda Sadeh)
-   rgw: use endpoints from master zone instead of zonegroup
    ([issue#16834](http://tracker.ceph.com/issues/16834),
    [pr#10456](http://github.com/ceph/ceph/pull/10456), Casey Bodley)
-   rgw: use the standard usage of string.find
    ([pr#10226](http://github.com/ceph/ceph/pull/10226), Yan Jun)
-   rgw: verfied: f23, subset of s3tests
    ([pr#10448](http://github.com/ceph/ceph/pull/10448), Pritha
    Srivastava)
-   rgw: verified ([pr#10000](http://github.com/ceph/ceph/pull/10000),
    weiqiaomiao)
-   rgw: verified non-regression (MS AD)
    ([pr#10597](http://github.com/ceph/ceph/pull/10597), Pritha
    Srivastava)
-   rgw: verified: autobuild
    ([issue#16928](http://tracker.ceph.com/issues/16928),
    [pr#10579](http://github.com/ceph/ceph/pull/10579), Robin H.
    Johnson)
-   rgw: verified: MS AD
    ([pr#10307](http://github.com/ceph/ceph/pull/10307), Pritha
    Srivastava)
-   rgw: verified: f23
    ([pr#10882](http://github.com/ceph/ceph/pull/10882), Michal
    Jarzabek)
-   rgw: verified: f23
    ([pr#10858](http://github.com/ceph/ceph/pull/10858), Weibing Zhang)
-   rgw: verified: f23
    ([pr#10822](http://github.com/ceph/ceph/pull/10822), Yan Jun)
-   rgw: verified: f23
    ([pr#10929](http://github.com/ceph/ceph/pull/10929), Weibing Zhang)
-   rgw: wip: rgw multisite: preserve zone\'s extra pool
    ([issue#16712](http://tracker.ceph.com/issues/16712),
    [pr#10397](http://github.com/ceph/ceph/pull/10397), Abhishek
    Lekshmanan)
-   rgw: work around curl_multi_wait bug with non-blocking reads
    ([issue#15915](http://tracker.ceph.com/issues/15915),
    [issue#16695](http://tracker.ceph.com/issues/16695),
    [pr#10998](http://github.com/ceph/ceph/pull/10998), Casey Bodley)
-   rgw:add a s3 API of make torrent for a object
    ([pr#10396](http://github.com/ceph/ceph/pull/10396), zhouruisong)
-   rgw:add a s3 API of make torrent for a object
    ([pr#9589](http://github.com/ceph/ceph/pull/9589), zhouruisong)
-   rgw:bucket check remove \_[multipart]() prefix
    ([pr#6501](http://github.com/ceph/ceph/pull/6501), Weijun Duan)
-   rgw:clean unuse bufferlist
    ([pr#10232](http://github.com/ceph/ceph/pull/10232), weiqiaomiao)
-   rgw:fix rgw boot failed after upgrade to master latest version
    ([pr#10409](http://github.com/ceph/ceph/pull/10409), weiqiaomiao)
-   rgw:lifecycle feature \[rebased\]
    ([pr#9737](http://github.com/ceph/ceph/pull/9737), Ji Chen, Daniel
    Gryniewicz)
-   rgw: rgw/rgw_rados.h: remove unneeded class C_Tick
    ([pr#10954](http://github.com/ceph/ceph/pull/10954), Michal
    Jarzabek)
-   rgw: ext_mime_map_init add string describing for error number
    ([pr#9807](http://github.com/ceph/ceph/pull/9807), Yan Jun)
-   tests: Add test for global static non-POD segfault
    ([pr#10486](http://github.com/ceph/ceph/pull/10486), Brad Hubbard)
-   tests: populate /dev/disk/by-partuuid for scsi_debug
    ([issue#17100](http://tracker.ceph.com/issues/17100),
    [pr#10824](http://github.com/ceph/ceph/pull/10824), Loic Dachary)
-   tests: use a fixture for memstore clone testing
    ([pr#11190](http://github.com/ceph/ceph/pull/11190), Kefu Chai)
-   tests: run-\*make-check.sh: Make DRY_RUN actually mean a dry run
    ([pr#11074](http://github.com/ceph/ceph/pull/11074), Brad Hubbard)
-   tests: run-cmake-check.sh: Actually run the tests
    ([pr#11075](http://github.com/ceph/ceph/pull/11075), Brad Hubbard)
-   tests: run-cmake-check.sh: Init submodules
    ([pr#11091](http://github.com/ceph/ceph/pull/11091), Brad Hubbard)
-   tests: run-make-check.sh: Make DRY_RUN actually do a dry run
    ([pr#11092](http://github.com/ceph/ceph/pull/11092), Brad Hubbard)
-   tests: run-make-check.sh: pass args to do_cmake.sh
    ([pr#10701](http://github.com/ceph/ceph/pull/10701), John Coyle)
-   tests: unittest_chain_xattr: account for existing xattrs
    ([issue#16025](http://tracker.ceph.com/issues/16025),
    [pr#11109](http://github.com/ceph/ceph/pull/11109), Dan Mick)
-   tests: src/test/cli/\* tests: POSIX Convert grep -P to grep -E
    ([pr#10319](http://github.com/ceph/ceph/pull/10319), Willem Jan
    Withagen)
-   test: ceph_test_msgr: fix circular locking dependency
    ([issue#16955](http://tracker.ceph.com/issues/16955),
    [pr#10612](http://github.com/ceph/ceph/pull/10612), Kefu Chai)
-   test: cli/crushtool: fix the test of compile-decompile-recompile.t
    ([issue#17306](http://tracker.ceph.com/issues/17306),
    [pr#11173](http://github.com/ceph/ceph/pull/11173), Kefu Chai)
-   test: libcephfs: fix gcc sys/fcntl.h warnings
    ([pr#10126](http://github.com/ceph/ceph/pull/10126), John Coyle)
-   test: librados: rados_connect() should succeed
    ([issue#17087](http://tracker.ceph.com/issues/17087),
    [pr#10806](http://github.com/ceph/ceph/pull/10806), Kefu Chai)
-   test: mds: add fs dump in test_ceph_argparse.py
    ([pr#10347](http://github.com/ceph/ceph/pull/10347), huanwen ren)
-   test: simple_dispatcher.cc: remove unused variable
    ([pr#9932](http://github.com/ceph/ceph/pull/9932), Michal Jarzabek)
-   test: store_test: tidy-up SyntheticWorkloadState class
    ([pr#10775](http://github.com/ceph/ceph/pull/10775), xie xingguo)
-   test: More portable use of mmap(MAP_ANON)
    ([pr#10557](http://github.com/ceph/ceph/pull/10557), Willem Jan
    Withagen)
-   test: Removeall merged after print_function commit needs a fix
    ([pr#10535](http://github.com/ceph/ceph/pull/10535), David Zafman)
-   test: ceph-disk.sh do not kill all daemons
    ([issue#16729](http://tracker.ceph.com/issues/16729),
    [pr#10346](http://github.com/ceph/ceph/pull/10346), Kefu Chai)
-   test: cephtool/test.sh: fix expect_false() calls
    ([pr#10133](http://github.com/ceph/ceph/pull/10133), Kefu Chai)
-   test: fix usage info of omapbench
    ([pr#10089](http://github.com/ceph/ceph/pull/10089), Wanlong Gao)
-   test: remove ceph_test_rados_api_tmap_migrate
    ([issue#16144](http://tracker.ceph.com/issues/16144),
    [pr#10256](http://github.com/ceph/ceph/pull/10256), Kefu Chai)
-   test: [test](){compression_plugin,async_compressor}: do not copy
    plugins ([pr#10153](http://github.com/ceph/ceph/pull/10153), Kefu
    Chai)
-   test: test_rados_tool.sh: Make script work under ctest
    ([pr#10166](http://github.com/ceph/ceph/pull/10166), Willem Jan
    Withagen)
-   test: qa/workunits/cephtool/test.sh: fix omission of ceph-command
    ([pr#10979](http://github.com/ceph/ceph/pull/10979), Willem Jan
    Withagen)
-   test: qa/workunits/cephtool/test.sh: s/TMPDIR/TEMP_DIR/
    ([pr#10306](http://github.com/ceph/ceph/pull/10306), Kefu Chai)
-   test: qa/workunits/cephtool/test.sh: use absolute path for TEMP_DIR
    ([pr#10430](http://github.com/ceph/ceph/pull/10430), Kefu Chai)
-   tools: New \"removeall\" used to remove head with snapshots
    ([pr#10098](http://github.com/ceph/ceph/pull/10098), David Zafman)
-   tools: do not closed stdout ; fix overload of \"\<\" operator
    ([pr#9290](http://github.com/ceph/ceph/pull/9290), xie xingguo)
-   tools: fix the core dump when get the crushmap do not exist
    ([pr#10451](http://github.com/ceph/ceph/pull/10451), song baisen)
-   tools: rebuild monstore
    ([issue#17179](http://tracker.ceph.com/issues/17179),
    [pr#10933](http://github.com/ceph/ceph/pull/10933), Kefu Chai)
-   tools: use TextTable for \"rados df\" plain output
    ([pr#9362](http://github.com/ceph/ceph/pull/9362), xie xingguo)
-   tools: fio engine for objectstore
    ([pr#10267](http://github.com/ceph/ceph/pull/10267), Casey Bodley,
    Igor Fedotov, Daniel Gollub)
-   tools: rados/client: fix typo
    ([pr#10493](http://github.com/ceph/ceph/pull/10493), Yan Jun)
-   tools: rados/client: fix waiting on the condition variable more
    efficient. ([pr#9939](http://github.com/ceph/ceph/pull/9939), Yan
    Jun)
-   tools: tools/rebuild_mondb: kill comipling warning and other fixes
    ([pr#11117](http://github.com/ceph/ceph/pull/11117), xie xingguo)
-   tools: authtool: Enhance argument combinations validation
    ([issue#2904](http://tracker.ceph.com/issues/2904),
    [pr#9704](http://github.com/ceph/ceph/pull/9704), Brad Hubbard)
-   tools: ceph-disk: change ownership of initfile to ceph:ceph
    ([issue#16280](http://tracker.ceph.com/issues/16280),
    [pr#9688](http://github.com/ceph/ceph/pull/9688), Shylesh Kumar)
-   test: ceph_test_rados_api_tmap_migrate: remove test for tmap_upgrade
    ([pr#10234](http://github.com/ceph/ceph/pull/10234), Kefu Chai)

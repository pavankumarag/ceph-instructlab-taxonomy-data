# Past vulnerabilities

  ------------ ------------------------------------------------------------------- ---------- ----------------------------------
  Published    CVE                                                                 Severity   Summary

  2023-02-02   [CVE-2023-46159](https://nvd.nist.gov/vuln/detail/cve-2023-46159)   Medium     DoS from RGW

  2023-01-17   [CVE-2022-3650](https://nvd.nist.gov/vuln/detail/cve-2022-3650)     High       ceph-crash run as user, not root

  2022-07-21   [CVE-2022-0670](../CVE-2022-0670)                                   Medium     Native-CephFS Manila
                                                                                              Path-restriction bypass

  2021-05-13   [CVE-2021-3531](../CVE-2021-3531)                                   Medium     Swift API denial of service

  2021-05-13   [CVE-2021-3524](../CVE-2021-3524)                                   Medium     HTTP header injects via CORS in
                                                                                              RGW

  2021-05-13   [CVE-2021-3509](../CVE-2021-3509)                                   High       Dashboard XSS via token cookie

  2021-04-14   [CVE-2021-20288](../CVE-2021-20288)                                 High       Unauthorized global_id reuse in
                                                                                              cephx

  2020-12-18   [CVE-2020-27781](https://nvd.nist.gov/vuln/detail/CVE-2020-27781)   7.1 High   CephFS creds read/modified by
                                                                                              Manila users

  2021-01-08   [CVE-2020-25678](https://nvd.nist.gov/vuln/detail/CVE-2020-25678)   4.9 Medium mgr module passwords in clear text

  2020-12-07   [CVE-2020-25677](https://nvd.nist.gov/vuln/detail/CVE-2020-25677)   5.5 Medium ceph-ansible iscsi-gateway.conf
                                                                                              perm

  2020-11-23   [CVE-2020-25660](https://nvd.nist.gov/vuln/detail/CVE-2020-25660)   8.8 High   Cephx replay vulnerability

  2020-04-22   [CVE-2020-12059](https://nvd.nist.gov/vuln/detail/CVE-2020-12059)   7.5 High   malformed POST could crash RGW

  2020-06-26   [CVE-2020-10753](https://nvd.nist.gov/vuln/detail/CVE-2020-10753)   6.5 Medium HTTP header injects via CORS in
                                                                                              RGW

  2020-06-22   [CVE-2020-10736](https://nvd.nist.gov/vuln/detail/CVE-2020-10736)   8.0 High   authorization bypass in mon and
                                                                                              mgr

  2020-04-23   [CVE-2020-1760](https://nvd.nist.gov/vuln/detail/CVE-2020-1760)     6.1 Medium potential RGW XSS attack

  2020-04-13   [CVE-2020-1759](https://nvd.nist.gov/vuln/detail/CVE-2020-1759)     6.8 Medium Cephx nonce reuse in secure mode

  2020-02-07   [CVE-2020-1700](https://nvd.nist.gov/vuln/detail/CVE-2020-1700)     6.5 Medium RGW disconnects leak sockets, can
                                                                                              DoS

  2020-04-21   [CVE-2020-1699](https://nvd.nist.gov/vuln/detail/CVE-2020-1699)     7.5 High   Dashboard path traversal flaw

  2019-12-23   [CVE-2019-19337](https://nvd.nist.gov/vuln/detail/CVE-2019-19337)   6.5 Medium RGW DoS via malformed headers

  2019-11-08   [CVE-2019-10222](https://nvd.nist.gov/vuln/detail/CVE-2019-10222)   7.5 High   Invalid HTTP headers could crash
                                                                                              RGW

  2019-03-27   [CVE-2019-3821](https://nvd.nist.gov/vuln/detail/CVE-2019-3821)     7.5 High   RGW file descriptors could be
                                                                                              exhausted

  2019-01-28   [CVE-2018-16889](https://nvd.nist.gov/vuln/detail/CVE-2018-16889)   7.5 High   encryption keys logged in
                                                                                              plaintext

  2019-01-15   [CVE-2018-16846](https://nvd.nist.gov/vuln/detail/CVE-2018-16846)   6.5 Medium authenticated RGW users can cause
                                                                                              DoS

  2019-01-15   [CVE-2018-14662](https://nvd.nist.gov/vuln/detail/CVE-2018-14662)   5.7 Medium read-only users could steal
                                                                                              dm-crypt keys

  2018-07-10   [CVE-2018-10861](https://nvd.nist.gov/vuln/detail/CVE-2018-10861)   8.1 High   authenticated user can
                                                                                              create/delete pools

  2018-03-19   [CVE-2018-7262](https://nvd.nist.gov/vuln/detail/CVE-2018-7262)     7.5 High   malformed headers can cause RGW
                                                                                              DoS

  2018-07-10   [CVE-2018-1129](https://nvd.nist.gov/vuln/detail/CVE-2018-1129)     6.5 Medium network MITM can tamper with
                                                                                              messages

  2018-07-10   [CVE-2018-1128](https://nvd.nist.gov/vuln/detail/CVE-2018-1128)     7.5 High   Cephx replay vulnerability

  2018-07-27   [CVE-2017-7519](https://nvd.nist.gov/vuln/detail/CVE-2017-7519)     4.4 Medium libradosstriper unvalidated format
                                                                                              string

  2018-08-01   [CVE-2016-9579](https://nvd.nist.gov/vuln/detail/CVE-2016-9579)     7.6 High   potential RGW XSS attack

  2018-07-31   [CVE-2016-8626](https://nvd.nist.gov/vuln/detail/CVE-2016-8626)     6.5 Medium malformed POST can DoS RGW

  2016-10-03   [CVE-2016-7031](https://nvd.nist.gov/vuln/detail/CVE-2016-7031)     7.5 High   RGW unauthorized bucket listing

  2016-07-12   [CVE-2016-5009](https://nvd.nist.gov/vuln/detail/CVE-2016-5009)     6.5 Medium mon command handler DoS

  2016-12-03   [CVE-2015-5245](https://nvd.nist.gov/vuln/detail/CVE-2015-5245)                RGW header injection
  ------------ ------------------------------------------------------------------- ---------- ----------------------------------

::: {.toctree hidden="" maxdepth="0"}
CVE-2022-0670 \<CVE-2022-0670.rst\> CVE-2021-3531 \<CVE-2021-3531.rst\>
CVE-2021-3524 \<CVE-2021-3524.rst\> CVE-2021-3509 \<CVE-2021-3509.rst\>
CVE-2021-20288 \<CVE-2021-20288.rst\>
:::

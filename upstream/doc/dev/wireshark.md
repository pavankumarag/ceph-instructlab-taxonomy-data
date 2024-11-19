# Wireshark Dissector

Wireshark has support for the Ceph protocol and it will be shipped in
the 1.12.1 release.

## Using

To use the Wireshark dissector you must build it from
[git](https://www.wireshark.org/develop.html), the process is outlined
in great detail in the [Building and
Installing](https://www.wireshark.org/docs/wsug_html_chunked/ChapterBuildInstall.html)
section of the [Wireshark Users
Guide](https://www.wireshark.org/docs/wsug_html_chunked/).

## Developing

The Ceph dissector lives in [Wireshark
git](https://www.wireshark.org/develop.html) at
`epan/dissectors/packet-ceph.c`. At the top of that file there are some
comments explaining how to insert new functionality or to update the
encoding of existing types.

Before you start hacking on Wireshark code you should look at the
`doc/README.developer` and `doc/README.dissector` documents as they
explain the basics of writing dissectors. After reading those two
documents you should be prepared to work on the Ceph dissector. [The
Wireshark developers
guide](https://www.wireshark.org/docs/wsdg_html_chunked/) also contains
a lot of useful information but it is less directed and is more useful
as a reference then an introduction.

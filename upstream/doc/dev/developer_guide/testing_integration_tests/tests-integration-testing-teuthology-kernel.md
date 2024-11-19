# Integration Tests for Kernel Development {#tests-integration-testing-teuthology-kernel}

## CephFS {#kernel-cephfs}

The `fs` suite runs various kernels as described by the [kernel YAML
fragments](https://github.com/ceph/ceph/tree/63f84c50e0851d456fc38b3330945c54162dd544/qa/cephfs/mount/kclient/overrides/distro).
These are symbolically linked by other sub-suites under the `fs` suite.

The matrix of fragments allows for testing the following configurations:

-   The \"stock\" kernel on RHEL 8 (i.e. the kernel that ships with it).
-   The [testing
    branch](https://github.com/ceph/ceph-client/tree/testing) by the
    kernel development team which represents the patches undergoing
    active testing. These patches may or may not be in the next upstream
    kernel release and include a mix of CephFS or kRBD changes. For the
    testing kernel, we test with whatever distributions are specified by
    the sub-suite. For example, the `fs:functional` sub-suite uses a
    random selection of the [supported random
    distros](https://github.com/ceph/ceph/blob/63f84c50e0851d456fc38b3330945c54162dd544/qa/suites/fs/functional/distro).

## Testing custom kernels

If you have a kernel branch on
[ceph-client.git](https://github.com/ceph/ceph-client/tree/testing) and
have built it using shaman, then you can also test that easily by
specifying an override for the kernel. This is done via a YAML fragment
passed to the `teuthology-suite` command:

    $ cat custom-kernel.yaml
    overrides:
      kernel:
        branch: for-linus

This specifies an override for the kernel branch specified in the
suite\'s matrix. You can also specify an override as a tag or SHA1 for
the `kernel` task. When overriding the kernel, you should reduce the
selection of jobs as the matrix will include a number of kernel
configurations you won\'t care to test, as mentioned in the
`kernel-cephfs`{.interpreted-text role="ref"} section; the override YAML
will apply to all configurations of the kernel so it will result in
duplicate tests. The command to run tests will look like:

::: prompt
bash \$

teuthology-suite \... \--suite fs \--filter k-testing custom-kernel.yaml
:::

Where `...` indicates other typical options that are normally specified
when running `teuthology-suite`. The important filter
`--filter k-testing` will limit the selection of jobs to those using the
`testing` branch of the kernel (see the
[k-testing.yaml](https://github.com/ceph/ceph/blob/63f84c50e0851d456fc38b3330945c54162dd544/qa/cephfs/mount/kclient/overrides/distro/testing/k-testing.yaml)
file). So you\'ll only select jobs using the kernel client with the
`testing` branch. Your custom YAML file, `custom-kernel.yaml`, will
further override the `testing` branch to use whatever you specify.

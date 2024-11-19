# MGR Service {#mgr-cephadm-mgr}

The cephadm MGR service hosts multiple modules. These include the
`mgr-dashboard`{.interpreted-text role="ref"} and the cephadm manager
module.

## Specifying Networks {#cephadm-mgr-networks}

The MGR service supports binding only to a specific IP within a network.

example spec file (leveraging a default placement):

``` yaml
service_type: mgr
networks:
- 192.169.142.0/24
```

### Allow co-location of MGR daemons {#cephadm_mgr_co_location}

In deployment scenarios with just a single host, cephadm still needs to
deploy at least two MGR daemons in order to allow an automated upgrade
of the cluster. See `mgr_standby_modules` in the
`mgr-administrator-guide`{.interpreted-text role="ref"} for further
details.

See also: `cephadm_co_location`{.interpreted-text role="ref"}.

### Further Reading

-   `ceph-manager-daemon`{.interpreted-text role="ref"}
-   `cephadm-manually-deploy-mgr`{.interpreted-text role="ref"}

# OAuth2 Proxy {#deploy-cephadm-oauth2-proxy}

## Deploying oauth2-proxy

In Ceph releases starting from Squid, the [oauth2-proxy]{.title-ref}
service introduces an advanced method for managing authentication and
access control for Ceph applications. This service integrates with
external Identity Providers (IDPs) to provide secure, flexible
authentication via the OIDC (OpenID Connect) protocol.
[oauth2-proxy]{.title-ref} acts as an authentication gateway, ensuring
that access to Ceph applications including the Ceph Dashboard and
monitoring stack is tightly controlled.

To deploy the [oauth2-proxy]{.title-ref} service, use the following
command:

::: prompt
bash \#

ceph orch apply oauth2-proxy \[\--placement \...\] \...
:::

Once applied, [cephadm]{.title-ref} will re-configure the necessary
components to use [oauth2-proxy]{.title-ref} for authentication, thereby
securing access to all Ceph applications. The service will handle login
flows, redirect users to the appropriate IDP for authentication, and
manage session tokens to facilitate seamless user access.

## Benefits of the oauth2-proxy service

-   `Enhanced Security`: Provides robust authentication through
    integration with external IDPs using the OIDC protocol.
-   `Seamless SSO`: Enables seamless single sign-on (SSO) across all
    Ceph applications, improving user access control.
-   `Centralized Authentication`: Centralizes authentication management,
    reducing complexity and improving control over access.

## Security enhancements

The [oauth2-proxy]{.title-ref} service ensures that all access to Ceph
applications is authenticated, preventing unauthorized users from
accessing sensitive information. Since it makes use of the
[oauth2-proxy]{.title-ref} open source project, this service integrates
easily with a variety of [external
IDPs](https://oauth2-proxy.github.io/oauth2-proxy/configuration/providers/)
to provide a secure and flexible authentication mechanism.

## High availability

[oauth2-proxy]{.title-ref} is designed to integrate with an external IDP
hence login high availability is not the responsibility of this service.
In squid release high availability for the service itself is not
supported yet.

## Accessing services with oauth2-proxy

After deploying [oauth2-proxy]{.title-ref}, access to Ceph applications
will require authentication through the configured IDP. Users will be
redirected to the IDP for login and then returned to the requested
application. This setup ensures secure access and integrates seamlessly
with the Ceph management stack.

## Service Specification

Before deploying [oauth2-proxy]{.title-ref} service please remember to
deploy the [mgmt-gateway]{.title-ref} service by turning on the
[\--enable_auth]{.title-ref} flag. i.e:

::: prompt
bash \#

ceph orch apply mgmt-gateway \--enable_auth=true
:::

An [oauth2-proxy]{.title-ref} service can be applied using a
specification. An example in YAML follows:

``` yaml
service_type: oauth2-proxy
service_id: auth-proxy
placement:
  hosts:
    - ceph0
spec:
 https_address: "0.0.0.0:4180"
 provider_display_name: "My OIDC Provider"
 client_id: "your-client-id"
 oidc_issuer_url: "http://192.168.100.1:5556/dex"
 client_secret: "your-client-secret"
 cookie_secret: "your-cookie-secret"
 ssl_certificate: |
   -----BEGIN CERTIFICATE-----
   MIIDtTCCAp2gAwIBAgIYMC4xNzc1NDQxNjEzMzc2MjMyXzxvQ7EcMA0GCSqGSIb3
   DQEBCwUAMG0xCzAJBgNVBAYTAlVTMQ0wCwYDVQQIDARVdGFoMRcwFQYDVQQHDA5T
   [...]
   -----END CERTIFICATE-----
ssl_certificate_key: |
   -----BEGIN PRIVATE KEY-----
   MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC5jdYbjtNTAKW4
   /CwQr/7wOiLGzVxChn3mmCIF3DwbL/qvTFTX2d8bDf6LjGwLYloXHscRfxszX/4h
   [...]
   -----END PRIVATE KEY-----
```

Fields specific to the `spec` section of the [oauth2-proxy]{.title-ref}
service are described below. More detailed description of the fields can
be found on [oauth2-proxy](https://oauth2-proxy.github.io/oauth2-proxy/)
project documentation.

::: {.autoclass members=""}
OAuth2ProxySpec
:::

The specification can then be applied by running the below command. Once
becomes available, cephadm will automatically redeploy the
[mgmt-gateway]{.title-ref} service while adapting its configuration to
redirect the authentication to the newly deployed
[oauth2-service]{.title-ref}.

::: prompt
bash \#

ceph orch apply -i oauth2-proxy.yaml
:::

## Limitations

A non-exhaustive list of important limitations for the
[oauth2-proxy]{.title-ref} service follows:

-   High-availability configurations for [oauth2-proxy]{.title-ref}
    itself are not supported.
-   Proper configuration of the IDP and OAuth2 parameters is crucial to
    avoid authentication failures. Misconfigurations can lead to access
    issues.

### Default images

The [oauth2-proxy]{.title-ref} service typically uses the default
container image:

    DEFAULT_OAUTH2_PROXY = 'quay.io/oauth2-proxy/oauth2-proxy:v7.2.0'

Admins can specify the image to be used by changing the
[container_image_oauth2_proxy]{.title-ref} cephadm module option. If
there were already running daemon(s), you must redeploy the daemon(s) to
apply the new image.

For example:

``` bash
ceph config set mgr mgr/cephadm/container_image_oauth2_proxy <new-oauth2-proxy-image>
ceph orch redeploy oauth2-proxy
```

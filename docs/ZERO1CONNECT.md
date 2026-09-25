# Zero1Connect server support — Zero1Local v1.2.9.14

Zero1Local v1.2.9.14 targets Zero1Connect v0.2.8+ and combines routed-LAN/VLAN pairing with first-time direct remote pairing over LTE/5G.

## v1.2.9.14 persistent UPnP control path

Live v1.2.9.13 evidence proved the site's Omada ER707-M2 exposes and answers a valid UPnP InternetGatewayDevice/WANIPConnection service and that Zero1Local previously established automatic UPnP publication. A later fresh SSDP discovery could nevertheless return no locations.

v1.2.9.14 persists the validated IGD description URL, WAN control URL, service type and gateway. Before reuse, the cached control service is validated with GetExternalIPAddress. One validated service is then reused for both the WireGuard UDP mapping and bootstrap TCP mapping. SSDP becomes rediscovery/failover when the cached path is absent or invalid rather than a prerequisite for every renewal.

Failed automatic publication clears stale endpoint, mapping-active, lease/expiry and last-successful-renewal state. The UI reports automatic mapping failure factually and offers manual forwarding as a fallback without claiming the router inherently requires it.

## v1.2.9.13 automatic-mapping diagnostics

UPnP discovery uses dedicated local UDP reply port 43121. Strict firewall rules admit routed-private-LAN traffic to that destination before INVALID/conntrack filtering. Zero1Local records the selected interface, source address, default gateway, reply port, returned SSDP locations, chosen WAN control service, and exact UPnP SOAP faults so router behavior can be diagnosed from evidence.

If a gateway explicitly reports UPnP error 725 (OnlyPermanentLeasesSupported), Zero1Local retries that mapping with a permanent lease. PCP and NAT-PMP remain independent fallbacks. Manual forwarding is used only after the automatic mechanisms actually fail.

The private mobile API remains `/api/connect/v1`. Direct remote pairing adds only one public HTTPS route: `POST /api/connect/bootstrap/v1/pair`. The bootstrap listener is separate from the normal management/Connect listener and does not expose files, shares, sessions, administration, SMB/NFS, or the web UI.

## Routed LAN / VLAN behavior

A phone does not need to share the NAS's directly attached subnet. The private Connect listener accepts routed LAN transport from `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`, and IPv6 ULA `fc00::/7` when the upstream site router/firewall permits the path. These ranges are a transport boundary only; normal pairing, device authentication, session, ACL, and revocation enforcement remain in force.

The broader Connect transport scope is separate from the owner's general trusted-service CIDRs. SMB, NFS, SSH and other services are not automatically opened to every routed private VLAN.

Pairing QR v2 continues to use the NAS numeric LAN IPv4 address. For example, a phone at `172.16.0.13/24` may pair to `http://192.168.0.145/api/connect/v1` through the site's router without Zero1Local substituting a `172.16.0.x` address.

`_zero1local._tcp` mDNS remains advertised locally, but cross-VLAN discovery requires a site mDNS reflector/repeater. QR/manual unicast pairing does not depend on multicast crossing VLANs.

The Zero1Connect administration diagnostics expose effective listeners, interface addresses/prefixes, routed-LAN trust ranges, mDNS advertisement information, and recent accepted Connect source addresses. `/capabilities` and `/pair/complete` also log the actual source address seen by Zero1Local.

## Direct remote and aggregate WireGuard

Pairing QR v2 retains the numeric LAN endpoint and, only when direct remote access is actually ready, includes the public bootstrap endpoint, pinned bootstrap leaf-certificate SHA-256, public WireGuard endpoint, and expiry.

Each NAS derives a stable RFC4193 ULA prefix from `SHA256("zero1local-wireguard-server:" + device_id)`. Zero1Local uses subnet `:1::/64` within that prefix, assigns the NAS `::1`, and assigns managed phones stable persistent `/128` addresses from the same per-NAS subnet. Therefore the phone address and NAS/API address share IPv6, and each NAS returns a unique `/128` AllowedIP suitable for Zero1Connect's aggregate multi-peer tunnel.

A successful remote bootstrap must return a complete usable managed WireGuard profile. If an externally reachable bootstrap or WireGuard endpoint is unavailable, the public bootstrap fails with a structured error instead of creating a stranded remote-only pairing.

## Automatic gateway discovery in 1.2.9

Automatic remote-access setup now discovers the router through the NAS IPv4 default route. Docker bridges, WireGuard interfaces, and other virtual interfaces are excluded from Internet-gateway discovery. Zero1Local sends standard multicast SSDP plus a gateway-directed probe and can use NAT-PMP when UPnP mapping is unavailable. Diagnostics report the selected LAN interface, source address, gateway path, and mapping result.

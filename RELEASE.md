# Zero1Local v1.2.6.7 — LAN Pairing / Nearby Discovery / UPnP Interoperability Correction

**Git tag:** `v1.2.6.7`  
**Status:** Pre-release / real-hardware qualification candidate

Zero1Local v1.2.6.7 is a focused Zero1Connect interoperability correction based on live LAN and router evidence from the qualification appliance. The Omada gateway has UPnP enabled for the Management (Default) 192.168.0.0/24 network, yet Zero1Local reported that no UPnP Internet Gateway Device was advertised. At the same time, QR pairing returned an unreachable-host error in Zero1Connect and Nearby discovery returned no Zero1Local devices.

## Numeric LAN QR pairing

The pairing deep link no longer copies the browser `Host` value as the phone endpoint. Zero1Local now enumerates active IPv4 LAN addresses and prefers the address whose subnet contains the browser client. A browser opened as `nas1` or another local hostname therefore produces a pairing URI containing the actual NAS IPv4 address (for example `192.168.0.145`) rather than assuming Android can resolve the same hostname.

If no usable numeric LAN IPv4 address can be determined, pairing fails explicitly with `lan_address_unavailable` instead of emitting a QR code known to be unusable.

## Nearby Zero1Local discovery

- Adds a packaged `_zero1local._tcp` Avahi service definition so Nearby discovery does not depend on a runtime-generated file appearing successfully.
- Preserves the runtime-generated service metadata with persistent NAS ID/name when available.
- Starts/reloads Avahi when the Connect advertisement is reconciled.
- `mDNS status=Running` now requires both the service definition and an actually active `avahi-daemon`; file existence alone is no longer reported as success.
- Installer rollback/uninstall paths preserve or restore the Connect Avahi service transactionally.
- Production verification/qualification now fails when the advertisement exists but Avahi is not actually active.

## Omada / UPnP interoperability

The previous SSDP implementation used one wildcard UDP socket, three search targets, a single send round and a 2.5-second response window. On a multi-interface NAS this can select the wrong egress path and can miss gateways that advertise a WAN connection service without replying to the narrow IGD search.

v1.2.6.7 now:

- sends SSDP discovery independently from every active non-loopback IPv4 LAN address;
- binds multicast transmission to the corresponding source interface;
- searches IGD v1/v2, WANIPConnection v1/v2, WANPPPConnection, root-device and `ssdp:all` targets;
- performs two discovery rounds;
- uses a five-second response window in parallel across interfaces; and
- reports which LAN interfaces were actually scanned when no usable gateway response is received.

No WireGuard keys, peers, ACLs or routes are weakened by this change. A remotely reachable endpoint is still required before Zero1Local returns a managed profile as Ready.

## WireGuard result carried forward

Real-hardware testing already proved that the RK3568 vendor kernel rejects the native WireGuard link type while the installed ARM64 `wireguard-go` fallback successfully creates a TUN-backed WireGuard interface that `wg` can configure and inspect. v1.2.6.7 preserves that userspace fallback path.

## Hardware validation after installation

1. Scan a fresh Zero1Connect pairing QR and confirm the phone reaches the NAS over its numeric 192.168.0.x address.
2. Confirm the NAS appears under Nearby Zero1Local devices.
3. Confirm Remote Access retry discovers the Omada UPnP gateway and creates the UDP mapping, or returns the new interface-specific SSDP diagnostic.
4. Confirm the returned endpoint is usable from cellular/off-LAN and the WireGuard tunnel handshakes.
5. Continue SMART progress, RAID consistency and Google Drive sign-in hardware checks.

Phone Transfer has already passed with two physical devices. Zero1Connect LAN API/file behavior has also previously passed; this release specifically corrects the pairing/discovery path that prevents a fresh client from reaching that working LAN API.

## Release asset

Public installation asset:

`Zero1Local-v1.2.6.7-production.zip`

SHA-256: `42f82a669b92b82346172d7d6ab5ebcfb463847e5fd1f094b3d62a15bf95a6a6`

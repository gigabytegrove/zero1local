# Zero1Local Changelog

## v1.2.9.14 — Google Device Client & Persistent UPnP Control Path

- Replaces the Google OAuth Web-application credential that live Google device authorization rejected with the newly created TVs and Limited Input devices client pair.
- Persists and validates the last successful UPnP IGD/WANIPConnection control path instead of requiring fresh SSDP discovery for every port mapping and renewal.
- Uses one validated UPnP WAN service for both WireGuard UDP and bootstrap TCP publication during a direct-remote transaction.
- Clears stale public endpoints, mapping flags, lease/expiry state and last-successful-renewal data when a new automatic publication transaction fails.
- Exposes cached UPnP path/validation evidence in diagnostics and no longer claims a router inherently requires manual forwarding merely because an automatic attempt failed.
- Remains a pre-release until the exact package passes live Google authorization/token exchange, Omada mapping/renewal, LTE/5G WireGuard/bootstrap, reboot and update/rollback acceptance.

## v1.2.9 — Health, Tasks, Apps & Interface

- Drive health in Storage now uses the same SMART assessment as the chassis drive lights, so warning LEDs are accompanied by a clear reason in the UI.
- SMART short and long tests better handle USB/SATA bridge types, already-running tests, and `smartctl` status semantics while preserving useful failure details.
- Finished and failed Task Center items can be dismissed individually or cleared together. Active tasks remain protected, and dismissed update history stays dismissed.
- Zero1Connect automatic router discovery now uses the actual IPv4 default-route LAN path instead of Docker, WireGuard, or other virtual interfaces.
- NAT-PMP can be used as an automatic fallback when UPnP cannot create the required remote-access mappings.
- The App Catalog now includes more curated applications, distinct local app icons, and persistent custom Docker image entries. Docker Compose remains available.
- Navigation and subnavigation are more consistent across the interface. Remote Access is consolidated under Zero1Connect, and Office Editing lives with Files & Sharing.
- System & Power now includes visual summaries for memory, storage, service health, temperature, and load.
- A new Help Center provides in-product guidance for setup, storage, Zero1Connect, apps, and troubleshooting.
- Global spacing, card alignment, button grouping, and responsive stacking have been tightened across the interface.

## v1.2.8 — Routed LAN / VLAN support

- Zero1Connect LAN access can traverse routed private VLANs when the site router/firewall permits it.
- Connect-only firewall trust covers RFC1918 IPv4 and IPv6 ULA ranges without broadly opening SMB, NFS, SSH, or other services.
- Diagnostics show the Connect listener, interface addresses, effective trusted ranges, mDNS advertisements, and observed request source addresses.

## v1.2.7.0 — Direct remote bootstrap and multi-NAS WireGuard

- Added a dedicated HTTPS pairing bootstrap for first-time remote pairing without exposing the normal Connect API publicly.
- Added persistent bootstrap TLS identity and certificate pinning through pairing QR data.
- Added independent public mappings for WireGuard UDP and bootstrap HTTPS TCP.
- Added deterministic per-NAS IPv6 ULA addressing so several Zero1Local systems can coexist in one managed Zero1Connect tunnel without route conflicts.
- Added replay-safe remote pairing and stable managed peer persistence.

## v1.2.6 series

- Expanded Zero1Connect integration, managed WireGuard support, and LAN pairing behavior.
- Added userspace WireGuard fallback for supported systems without a native WireGuard link type.
- Improved the independent Software Update monitor with live activity, local-time timestamps, canonical branding, and stronger recovery/rollback checks.
- Improved SMART and RAID maintenance behavior and added stronger package/binary identity validation.

## Earlier releases

Earlier 1.2.x releases established the current local-first management UI, storage workflows, File Manager, backups, applications, hardware controls, recovery tooling, and software-update path used by current builds.

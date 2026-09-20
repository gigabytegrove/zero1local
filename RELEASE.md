# Zero1Local v1.2.9 — Health, Tasks, Apps & Interface

**Git tag:** `v1.2.9`

Zero1Local 1.2.9 makes appliance health easier to understand, improves routine task management, expands the Docker application experience, and gives the web interface a more consistent structure.

## Drive health you can act on

The Storage interface and physical drive-light policy now share one SMART health assessment. A yellow or red drive light is accompanied by an owner-facing explanation in the UI, including conditions such as reallocated sectors, pending or uncorrectable sectors, command timeouts, and interface CRC errors.

SMART short and long tests also use the detected drive/bridge type. If a test is already running, Zero1Local attaches to that test instead of treating it as a start failure. When a drive genuinely rejects a test request, the actual diagnostic is shown.

## Cleaner Task Center history

Finished and failed jobs can now be dismissed individually. **Clear finished** removes all completed history at once, while active jobs remain protected. Dismissals are persisted so completed update tasks do not reappear simply because update state is reloaded.

## Better automatic remote-access discovery

Zero1Connect remote setup now performs Internet-gateway discovery through the NAS interface that owns the IPv4 default route. Docker bridges, WireGuard interfaces, and other virtual interfaces are not treated as gateway candidates.

UPnP discovery sends both multicast and gateway-directed SSDP probes. If UPnP cannot establish a mapping, Zero1Local can fall back to NAT-PMP for the WireGuard UDP mapping and direct-bootstrap TCP mapping. Diagnostics identify the selected LAN interface, source address, and gateway path instead of listing unrelated virtual interfaces.

## Expanded App Catalog

The curated catalog now includes additional applications alongside the existing productivity, media, synchronization, security, monitoring, development, and home-automation options. Each curated application has its own local vector mark in the interface.

Owners can also save custom Docker image references from Docker Hub, GHCR, or another registry and pull those images directly from the catalog. Custom entries do not guess container settings or expose ports automatically. Docker Compose remains available for advanced and multi-container deployments.

## More deliberate navigation and layout

Version 1.2.9 reduces duplicated navigation and keeps feature-specific controls with the feature they belong to:

- Remote Access is managed under Zero1Connect rather than duplicated under Connectivity.
- Office editing stays with Files & Sharing and remains available contextually from File Manager.
- System pages use consistent spacing, card sizing, button grouping, and responsive stacking.
- System & Power now includes visual memory, storage, service-health, temperature, and load summaries.

## Help Center

A new Help section provides owner-facing guides for getting started, storage and drive health, Zero1Connect, applications, and troubleshooting. Contextual Help remains available from the top bar throughout the interface.

## Compatibility

This release keeps the existing Zero1Connect 0.2.6+ private API and direct-remote/multi-NAS design. Routed private LAN/VLAN support from 1.2.8 remains in place. Docker Compose, File Manager Office integration, Recovery, Phone Transfer, storage protection, and existing application-management workflows are retained.

## Release asset

Use `Zero1Local-v1.2.9-production.zip` for installation or update. The package includes the approved Windows installer, exact ARM64 runtime payload, deployment helper, README, and checksum manifest.

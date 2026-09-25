# Zero1Local

Zero1Local is a local-first management system for the IronCow Zero1 NAS. It replaces the original appliance management layer while preserving owner data and focuses on storage, file sharing, backups, applications, hardware health, recovery, and Zero1Connect integration.

## Zero1Local 1.2.9.14 pre-release

v1.2.9.14 addresses two failures proven during live v1.2.9.13 testing.

- **Google device authorization.** The previously embedded client was proven in Google Cloud to be a Web application client. The production application now uses the newly created TVs and Limited Input devices client pair while keeping credentials embedded and owner-facing setup credential-free.
- **Persistent UPnP WAN path.** Zero1Local now persists and validates the known-good IGD/WANIPConnection control path and reuses it for both WireGuard UDP and bootstrap TCP mapping instead of requiring a fresh SSDP response for every renewal.
- **Truthful failure state.** Failed automatic publication clears stale active/lease/renewal state, while manual forwarding is presented as a fallback rather than an unsupported conclusion about the router.
- **Evidence remains visible.** Cached UPnP description/control/service/gateway information and validation timing are available in direct-remote diagnostics.

The public installation asset for this pre-release is `Zero1Local-v1.2.9.14-production.zip`. Implementation source and private build material remain off GitHub.

## Zero1Local 1.2.9.13 pre-release

v1.2.9.13 is an evidence-driven corrective build. It does not claim an external provider or network success until the exact release artifact proves that behavior on the designated test NAS.

### What changed

- **UPnP discovery firewall correction.** SSDP discovery now uses a dedicated local UDP reply port and admits private-LAN replies to that destination before INVALID/conntrack filtering.
- **Exact UPnP fault handling.** Standard router SOAP fault codes are preserved, including permanent-lease-only handling when the gateway explicitly reports it.
- **Network evidence in the journal.** The selected interface, source address, gateway, reply port, returned SSDP locations, WAN service selection, and mapping faults are retained for diagnosis.
- **Google provider evidence.** The embedded Google application credential and ownerless sign-in flow remain. Provider HTTP status/code/detail are retained when Google rejects device authorization.
- **Production installer repaired.** The Windows installer now names and SHA-256-pins the runtime payload from the same release.

The public installation artifact is `Zero1Local-v1.2.9.13-production.zip`. Implementation source and private build material remain off GitHub.

## Zero1Local 1.2.9

Version 1.2.9 focuses on clearer health information, a more organized interface, and easier day-to-day administration.

### What’s new

- **Drive health that explains itself.** The Storage interface and chassis drive lights now use the same SMART assessment. When a drive needs attention, Zero1Local shows the reason instead of reporting the drive as healthy while a warning LED is lit.
- **More reliable SMART self-tests.** Short and long tests use the detected drive/bridge type, attach to an already-running test, and preserve the real `smartctl` diagnostic when a drive rejects a request.
- **Dismissible Task Center history.** Completed and failed jobs can be dismissed individually or cleared together. Dismissed update tasks stay dismissed instead of reappearing after the management service refreshes its state.
- **Improved Zero1Connect router discovery.** Automatic remote-access setup now targets the actual default-route LAN interface and gateway instead of Docker or WireGuard virtual interfaces. NAT-PMP is available as a fallback when UPnP mapping is unavailable.
- **A larger App Catalog.** Additional managed applications are included, every curated app has its own local vector mark, and owners can save and pull custom Docker image references. Docker Compose remains available for advanced and multi-container deployments.
- **A more consistent interface.** Navigation and subnavigation have been normalized, duplicate Remote Access navigation has been removed, Office editing is kept with Files & Sharing, and System pages use more consistent spacing, controls, and visual summaries.
- **New Help Center.** Owner-facing guidance is available directly in the web interface for setup, storage, Zero1Connect, applications, and troubleshooting.
- **More visual System status.** Memory, storage, service health, temperature, and load are presented visually instead of relying on text-only status blocks.

## Installation and updates

The supported public installation asset is the five-file production package published with each release. Existing Zero1Local systems can use the same package for an in-place update.

See [Installation](docs/INSTALLATION.md), [Update Path](docs/UPDATE-PATH.md), and [Software Updates](docs/SOFTWARE-UPDATES.md) for owner-facing instructions.

## Local-first design

Zero1Local does not require a Zero1Local cloud account. Management stays on the NAS. Remote Zero1Connect access uses direct private networking rather than an operator-hosted relay.

## Documentation

- [Documentation index](docs/README.md)
- [File Manager](docs/FILE-MANAGER.md)
- [Task Center](docs/TASK-CENTER.md)
- [Zero1Connect](docs/ZERO1CONNECT.md)
- [LED status](docs/LED-STATUS.md)
- [Phone Transfer](docs/PHONE-TRANSFER.md)
- [UI and UX](docs/UI-UX.md)
- [Support](SUPPORT.md)
- [Security](SECURITY.md)

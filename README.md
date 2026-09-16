<p align="center">
  <img src="web/assets/zero1-local-logo-light.png" alt="Zero1Local — Local-First NAS Software" width="520">
</p>

# Zero1Local

**Local-first NAS software for supported Zero1 NAS hardware.**

Zero1Local replaces the original appliance management experience with an owner-controlled NAS interface while preserving the supported Debian 11 / ARM64 platform and established storage layout. Core NAS management is designed to remain usable locally without requiring a vendor cloud account.

> **v1.2.6 is a pre-release.** It is intended for qualification on the project test appliance before wider deployment.

## What v1.2.6 focuses on

- A reorganized owner-facing UI with fewer stacked cards, fewer redundant cross-links, and feature checks moved behind **Advanced** surfaces.
- **Phone Transfer** as a dedicated Sync & Backup workflow for automatic rules and manual phone-to-NAS transfers.
- **Zero1Connect** as its own first-class application with paired-device access assignments and automatic managed WireGuard provisioning.
- Storage maintenance fixes, including RAID consistency-check control and integrated drive replacement.
- Expanded Storage Analytics with file-type counts, file-type storage visualization, capacity trend, share usage, largest files, and duplicate candidates.
- Consistent terminology including **Docker Compose** and **VLANs**.
- System organization that keeps Office, Access & API, security, administrators, automation, advanced stats, logs, and recovery in clear ownership boundaries.
- Theme-correct Zero1Local branding using the supplied transparent light/dark logo assets.

## Main product areas

| Area | Purpose |
| --- | --- |
| Home | Appliance status, current actions, tasks, and notifications |
| Files & Sharing | File Manager, shared folders, users, groups, and secure links |
| Storage | Drives, RAID, USB storage, and analytics |
| Sync & Backup | Synchronization, Phone Transfer, restore, backups, and snapshots |
| Zero1Connect | Pairing, device access control, and managed remote connectivity |
| Apps | App catalog, containers, and Docker Compose |
| Connectivity | Network, VLANs, advanced networking, remote access, and desktop integration |
| System | Updates, power, Access & API, Office, security, administrators, automation, hardware, advanced stats, logs, and recovery |

## Zero1Connect

Zero1Connect is developed as a separate Android client. Zero1Local provides the server-side `/api/connect/v1` integration, pairing, per-device access scopes, authentication, and managed WireGuard provisioning. A successful pairing is intended to configure the phone's private remote-access path automatically when the appliance can establish a usable endpoint.

Each paired phone has an independent identity. Mobile access can be restricted to specific shared folders or folder roots and is always further constrained by the bound Zero1Local user's underlying permissions.

## Phone Transfer

Phone Transfer lives under **Sync & Backup**. It supports automatic device-specific transfer rules and manual transfer from connected phones. The product UI uses one consistent name; historical internal API names may remain for compatibility.

## Recovery and notifications

Recovery verification is optional. When disabled, it does not lower protection scoring or create verification reminders. A manual verification attempt with no usable source returns:

```text
No recovery source was available to verify.
```

Owner-facing advisory notifications can be dismissed, snoozed, or ignored so repeated recommendations do not continue to occupy Action Center after the owner has made a decision.

## Installation and updates

Official production packages contain a compiled ARM64 runtime and the established Windows bootstrap installer. In-place updates use Zero1Local's staged validation and rollback path.

The accepted Windows installer from v1.2.4.27 remains authoritative and byte-for-byte unchanged unless the project owner explicitly changes it.

For the current release package, see [`RELEASE.md`](RELEASE.md).

## Documentation

- [`CHANGELOG.md`](CHANGELOG.md) — release changes
- [`CONTRIBUTING.md`](CONTRIBUTING.md) — contribution expectations
- [`SECURITY.md`](SECURITY.md) — security reporting and security boundaries
- [`SUPPORT.md`](SUPPORT.md) — support and troubleshooting information
- [`LICENSE.md`](LICENSE.md) — Zero1Local Free Attribution License v1.0
- [`docs/`](docs/) — product and implementation documentation

## Project attribution

Zero1Local originally created by **Brad Trammell**, a **Gigabyte Grove** project.

See [`LICENSE.md`](LICENSE.md) for the complete license terms and required attribution.

# Zero1Local

Zero1Local is a local-first management system for the IronCow Zero1 NAS. It replaces the original appliance management layer while preserving owner data and focuses on storage, file sharing, backups, applications, hardware health, recovery, and Zero1Connect integration.

## Current release

**v1.2.9.15 is the current stable release.**

This corrective build fixes the Google TVs and Limited Input devices OAuth client ID used by Zero1Local's device authorization flow. The matching client secret and device-flow implementation are otherwise unchanged, and the persistent Omada UPnP control path introduced in v1.2.9.14 remains in place.

The public installation artifact is:

`Zero1Local-v1.2.9.15-production.zip`

Implementation source, private build material, and embedded application credentials are not published in this public repository.

For complete release history and technical changes, see [CHANGELOG.md](CHANGELOG.md) and the repository's GitHub Releases.

## Highlights

Zero1Local provides owner-facing management for:

- **Storage and drive health** — SMART assessment, RAID / Drive Protection, USB storage, maintenance, and hardware status.
- **Files and sharing** — File Manager, shared folders, users, groups, secure links, previews, and Office editing.
- **Sync and backup** — synchronization, backups, restore workflows, snapshots, replication, and Phone Transfer.
- **Apps and containers** — curated applications, custom Docker images, Docker Compose, and container management.
- **Networking** — LAN configuration, VLANs, desktop integration, and controlled service exposure.
- **Zero1Connect** — device pairing and direct private remote connectivity without an operator-hosted relay.
- **System management** — updates, power, security, automation, logs, recovery, hardware controls, and task history.
- **Help and diagnostics** — in-product guidance, support evidence, and troubleshooting information.

## Installation and updates

Use the production package attached to the matching GitHub Release. Existing Zero1Local systems can use the same release package for an in-place update when that release is approved for the target system.

See:

- [Installation](docs/INSTALLATION.md)
- [Update Path](docs/UPDATE-PATH.md)
- [Software Updates](docs/SOFTWARE-UPDATES.md)
- [Upgrading and Rollback](docs/UPGRADING-AND-ROLLBACK.md)

## Local-first design

Zero1Local does not require a Zero1Local cloud account. Management stays on the NAS. Remote Zero1Connect access uses direct private networking rather than an operator-hosted relay.

## Documentation

Start with the [documentation index](docs/README.md).

Useful guides include:

- [Getting Started](docs/GETTING-STARTED.md)
- [Storage and RAID](docs/STORAGE-AND-RAID.md)
- [File Manager](docs/FILE-MANAGER.md)
- [Task Center](docs/TASK-CENTER.md)
- [Zero1Connect](docs/ZERO1CONNECT.md)
- [LED Status](docs/LED-STATUS.md)
- [Phone Transfer](docs/PHONE-TRANSFER.md)
- [Networking](docs/NETWORKING.md)
- [Recovery](docs/RECOVERY.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)

Project policies:

- [Support](SUPPORT.md)
- [Security](SECURITY.md)
- [Contributing](CONTRIBUTING.md)
- [License](LICENSE.txt)

## Release model

Zero1Local release packages are evidence-driven. A build is not treated as proven merely because it was produced successfully; promotion depends on live acceptance of the exact artifact on supported hardware and workflows.

Stable and pre-release builds are identified by their GitHub Release status. Historical release notes belong in GitHub Releases and [CHANGELOG.md](CHANGELOG.md), keeping the repository root focused on current documentation.

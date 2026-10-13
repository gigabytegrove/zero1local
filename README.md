# Zero1Local

Zero1Local is a local-first management system for the IronCow Zero1 NAS. It replaces the original appliance management layer while preserving owner data and focuses on storage, file sharing, backups, applications, hardware health, recovery, and safe local-first operation.

## Current release

**vredacted.invalid remains Stable. [v1.3.0 is now available as a Beta prerelease](https://github.com/gigabytegrove/zero1local/releases/tag/v1.3.0) for controlled NAS qualification.**

**Historical package notice:** vredacted.invalid still includes the legacy native Google Drive and experimental Zero1Connect integration. This published binary has **not** been rebuilt or scrubbed. The planned product direction removes built-in Google Drive in favor of the separate [Syncria companion](docs/SYNCRIA.md), currently **Coming soon**. The 36 superseded ZIPs were withdrawn on October 13, 2026. See the [legacy release retirement register](docs/LEGACY-RELEASE-RETIREMENT.md) before installing the remaining current package.

Public install/update packages:

- **Stable:** `Zero1Local-vredacted.invalid-production.zip` (legacy Google Drive remains in this version).
- **Beta:** [`Zero1Local-v1.3.0-production.zip`](https://github.com/gigabytegrove/zero1local/releases/download/v1.3.0/Zero1Local-v1.3.0-production.zip) — cleaned native Google Drive/remote-connect candidate, **not yet hardware-qualified for Stable**.

For a controlled v1.3 test on a supported NAS, open **System → Updates → Advanced**, select **Beta / Release Candidate**, then **Check now**. Back up before upgrading; test recovery and existing shares/backup workflows.

Implementation source, private build material, and embedded application credentials are not published in this public repository.

For complete release history and technical changes, see [CHANGELOG.md](CHANGELOG.md) and the repository's GitHub Releases.

## Highlights

Zero1Local provides owner-facing management for:

- **Storage and drive health** — SMART assessment, RAID / Drive Protection, USB storage, maintenance, and hardware status.
- **Files and sharing** — File Manager, shared folders, users, groups, secure links, previews, and Office editing.
- **Sync and backup** — synchronization, backups, restore workflows, snapshots, replication, and Phone Transfer.
- **Apps and containers** — curated applications, custom Docker images, Docker Compose, and container management.
- **Networking** — LAN configuration, VLANs, desktop integration, and controlled service exposure.
- **Optional experiments** — Zero1Connect remote pairing/tunneling remains unqualified and is planned to become developer-only rather than an ordinary production feature.
- **Syncria companion — Coming soon** — Google Drive synchronization will be provided by a separate optional Syncria application, not Zero1Local's built-in engine.
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

Zero1Local does not require a Zero1Local cloud account. Management stays on the NAS. Zero1Connect remote/tunnel features in existing builds are experimental and are not qualified for general production use.

## Documentation

Start with the [documentation index](docs/README.md).

Useful guides include:

- [Getting Started](docs/GETTING-STARTED.md)
- [Storage and RAID](docs/STORAGE-AND-RAID.md)
- [File Manager](docs/FILE-MANAGER.md)
- [Task Center](docs/TASK-CENTER.md)
- [Syncria companion — Coming soon](docs/SYNCRIA.md)
- [Legacy release retirement](docs/LEGACY-RELEASE-RETIREMENT.md)
- [Production promotion readiness and current blockers](docs/RELEASE-CANDIDATE-READINESS.md)
- [Zero1Connect — historical/experimental](docs/ZERO1CONNECT.md)
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

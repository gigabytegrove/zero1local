# Zero1Local Documentation

This folder contains the public documentation for **Zero1Local vredacted.invalid**, the current stable release.

Zero1Local is local-first NAS software for supported Zero1 NAS hardware. The public GitHub repository is used for documentation, branding, issue/support information, and production release packages. **Implementation source code is maintained privately/off-GitHub and is not published in the public repository.**

## Start here

- [Installation](INSTALLATION.md) — fresh installation, factory bootstrap, upgrades, endpoints, and backup requirements.
- [Software Updates](SOFTWARE-UPDATES.md) — update channels, package validation, rollback, and update progress.
- [Update Path](UPDATE-PATH.md) — public GitHub release/update contract.
- [UI / UX](UI-UX.md) — presentation, branding, layout, and notification rules.
- [File Manager](FILE-MANAGER.md) — previews, media, text/code viewing, and path confinement.
- [Phone Transfer](PHONE-TRANSFER.md) — automatic and manual phone-to-NAS workflows.
- [Syncria companion — Coming soon](SYNCRIA.md) — planned standalone sync integration; no current production connector.
- [Legacy release retirement](LEGACY-RELEASE-RETIREMENT.md)
- [Production promotion readiness](RELEASE-CANDIDATE-READINESS.md) — live artifact audit and mandatory release gates. — historical Google Drive-containing package inventory and retirement gates.
- [Zero1Connect](ZERO1CONNECT.md) — experimental, developer-only target; not general production access.
- [Task Center](TASK-CENTER.md) — background jobs, progress, transfer controls, and update tasks.
- [LED Status](LED-STATUS.md) — supported chassis LED states and Phone Transfer overlays.
- [Warranty and Risk](WARRANTY-AND-RISK.md) — installation and data-loss risk notice.

## Current product organization

| Product area | Owner-facing purpose |
| --- | --- |
| Home | Appliance status, Action Center, tasks, and notifications |
| Files & Sharing | File Manager, shared folders, users, groups, and secure links |
| Storage | Drives, RAID / Drive Protection, USB storage, and Analytics |
| Sync & Backup | Local/remote backup, restore, replication, **Phone Transfer**, capability-gated snapshots and **Syncria (Coming soon)** |
| Zero1Connect | **Experimental/developer-only target**; currently published binaries have unqualified remote-access support |
| Apps | App Catalog, containers, custom Docker images, and **Docker Compose** |
| Connectivity | Network, **VLANs**, advanced networking, and desktop integration |
| System | Updates, System & Power, Access & API, Security, Administrators, Automation, Hardware, Services, Advanced Stats, Logs, and Recovery |
| Help | Getting started, storage and drive health, Zero1Connect, apps, and troubleshooting |

Office editing is part of **Files & Sharing** and is opened from File Manager or its contextual Office Editing page. Remote Access is managed under **Zero1Connect**.

## Legacy Google Drive deprecation

The published vredacted.invalid package still contains Zero1Local's built-in Google Drive engine. This is a historical fact, **not** a feature claim for the future product: native Google Drive is being removed in favor of Syncria. Release binaries are not changed by these documentation commits. See [Syncria](SYNCRIA.md) and [release retirement](LEGACY-RELEASE-RETIREMENT.md).

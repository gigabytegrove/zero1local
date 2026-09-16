# Zero1Local Documentation

This folder contains the public documentation for **Zero1Local v1.2.6.3**.

Zero1Local is local-first NAS software for supported Zero1 NAS hardware. The public GitHub repository is used for documentation, branding, issue/support information, and production release packages. **Implementation source code is maintained privately/off-GitHub and is not published in the public repository.**

## Start here

- [Installation](INSTALLATION.md) — fresh installation, factory bootstrap, upgrades, endpoints, and backup requirements.
- [Software Updates](SOFTWARE-UPDATES.md) — update channels, package validation, rollback, and update progress.
- [Update Path](UPDATE-PATH.md) — public GitHub release/update contract.
- [User Experience](USER-EXPERIENCE.md) — owner-facing terminology and information architecture.
- [UI / UX](UI-UX.md) — presentation, branding, layout, and notification rules.
- [File Manager](FILE-MANAGER.md) — previews, media, text/code viewing, and path confinement.
- [Phone Transfer](PHONE-TRANSFER.md) — automatic and manual phone-to-NAS workflows.
- [Zero1Connect](ZERO1CONNECT.md) — pairing, access control, authentication, and managed remote access.
- [Task Center](TASK-CENTER.md) — background jobs, progress, transfer controls, and update tasks.
- [LED Status](LED-STATUS.md) — supported chassis LED states and Phone Transfer overlays.
- [Warranty and Risk](WARRANTY-AND-RISK.md) — installation and data-loss risk notice.
- [Public Release Gate](PUBLIC-RELEASE-GATE.md) — qualification and documentation requirements for public builds.
- [Documentation Provenance](DOCUMENTATION-PROVENANCE.md) — how the public documentation is produced and reviewed.

## Current product organization

| Product area | Owner-facing purpose |
| --- | --- |
| Home | Appliance status, Action Center, tasks, and notifications |
| Files & Sharing | File Manager, shared folders, users, groups, and secure links |
| Storage | Drives, RAID / Drive Protection, USB storage, and Analytics |
| Sync & Backup | Synchronization, **Phone Transfer**, restore, backups, and snapshots |
| Zero1Connect | Pair phones, inherit native shared-folder access, and manage automatic private remote connectivity |
| Apps | App catalog, containers, and **Docker Compose** |
| Connectivity | Network, **VLANs**, advanced networking, remote access, and desktop integration |
| System | Updates, System & Power, Access & API, Office, Security, Administrators, Automation, Hardware, Services, Advanced Stats, Logs, and Recovery |

Developer/qualification information belongs under **Advanced**, **Feature checks**, logs, or support diagnostics rather than normal owner workflows.

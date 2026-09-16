# Zero1Local owner-facing language and organization — v1.2.6.3

Zero1Local presents owner tasks first. Internal protocol names, qualification output, implementation evidence, raw checks, and developer terminology belong under **Advanced**, **Feature checks**, diagnostics, logs, or support bundles unless they are necessary to complete the task safely.

## Primary organization

- **Home** — current appliance status, actions, tasks, and notifications.
- **Files & Sharing** — File Manager, shared folders, users/groups, and sharing workflows.
- **Storage** — drives, Drive Protection / RAID, USB storage, and Analytics.
- **Sync & Backup** — synchronization, **Phone Transfer**, restore, backups, snapshots.
- **Zero1Connect** — pairing, Devices & Access, and Remote Access.
- **Apps** — catalog, containers, and **Docker Compose**.
- **Connectivity** — Network, **VLANs**, advanced networking, remote access, desktop integration.
- **System** — Updates, System & Power, **Access & API**, Office, Security, Administrators, Automation, Hardware, Services, **Advanced Stats**, Logs, and Recovery.

## Ownership rules

- SSH, API credentials, and browser sessions belong under **System → Access & API**, not Security.
- Security is reserved for authentication/security policy, firewall exposure, certificates, and related protection controls.
- Office belongs under **System**.
- Restart history and feature/qualification checks belong under **Advanced Stats** or another Advanced disclosure.
- Zero1Connect is a first-class product section, not a buried System subsection.
- Phone Transfer is a first-class Sync & Backup workflow, not “Phone Offload.”

## Navigation rules

The primary sidebar and section tabs should be the normal way to move between areas. Avoid adding “go to X” links everywhere merely because two features are related.

Cross-links are appropriate when they complete a specific workflow or resolve an actionable dependency, not as a substitute for information architecture.

## Presentation rules

A card represents a distinct concept, not every row of information. Repeated entities should normally use grouped rows, tables, or a shared section rather than card-on-card stacks.

Advisory explanations should be concise. Repeated advisory notices must support dismissal/snooze/ignore where appropriate so the owner can make a decision and stop being nagged.

Short information popovers may explain concepts such as Drive Protection, VLANs, Windows Sharing (SMB), Linux Sharing (NFS), Docker Compose, network ranges, restore points, two-step verification, firewall protection, certificates, and Recovery.

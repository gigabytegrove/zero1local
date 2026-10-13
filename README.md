# Zero1Local

**Local-first NAS management for supported LenovoEMC and Iomega storage appliances.**

Zero1Local provides a modern management interface for supported NAS hardware while keeping storage and everyday network services under your control.

### Features

- Storage health, RAID monitoring, disk information and shares
- Local users and file access management, including SMB and NFS
- File Manager, local backup and restore
- Native **NAS-to-NAS replication**
- Appliance monitoring, notifications and maintenance
- On-device software updates and recovery tools

### Cloud synchronization

**NAS-to-cloud and cloud-to-NAS synchronization are not built into Zero1Local.** For those workflows, use **Syncria**, a separately deployed Docker-container application. Syncria is optional; it is not required for native NAS-to-NAS replication.

### Download and update

Versioned installers are distributed through [GitHub Releases](https://github.com/gigabytegrove/zero1local/releases). Each release includes its version, installation package and release notes. Installed Zero1Local systems can check for releases using **System → Updates**, subject to their selected update channel.

**Release note:** v1.3.1 is not published yet. The existing v1.3.0 prerelease is not the current development baseline. Do not manually relabel or substitute release packages; wait for a verified installer matching its published version.

### Hardware and network safety

Zero1Local manages your existing NAS; it is **not** a guarantee of a new operating-system kernel or of security fixes for the underlying vendor firmware. Keep older appliances on a trusted, appropriately segmented network and maintain independent backups of important files. Do not expose management ports or SMB/NFS directly to the public Internet.

### Project

Zero1Local is a Grand Bay Collective / Gigabyte Grove project.

**Release packages are published here; this public repository does not contain the application source tree.**

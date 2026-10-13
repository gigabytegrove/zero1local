# Zero1Local

**Local-first NAS management for YXS / IronCow Zero1 NAS devices.**

Zero1Local is developed and released by **Gigabyte Grove**. It brings a modern management experience to supported YXS / IronCow Zero1 NAS hardware while retaining control of storage, files, and network services on your own network.

### Features

- Storage health, RAID monitoring, disk information, and shared folders
- Local users, access permissions, SMB, and NFS
- File Manager, local backup, and restore
- Native **NAS-to-NAS replication** between supported devices
- Appliance monitoring, notifications, and maintenance
- Built-in Help, software updates, and recovery tools

### Cloud synchronization

**NAS-to-cloud and cloud-to-NAS synchronization are not part of Zero1Local.** For those workflows, we recommend **Syncria**, an independently deployed Docker-container application.

Syncria is optional and is not required for native NAS-to-NAS replication. Zero1Local does not automatically install or manage Syncria.

### Download and installation

Official Zero1Local installers and release notes are provided through **[GitHub Releases](https://github.com/gigabytegrove/zero1local/releases)**.

If Zero1Local is already installed, check **System → Updates** for a published update compatible with your selected update channel.

**Release status:** v1.3.1 is under development and has not yet been published. The available v1.3.0 prerelease experienced an installation failure; do not install it as a replacement for a working system. Only install a release whose exact package has been verified for your device.

### Hardware and network safety

Zero1Local is management software for supported YXS / IronCow Zero1 NAS devices; it does not replace the underlying firmware or guarantee a newer kernel.

Keep older NAS devices on a trusted, appropriately segmented network, maintain independent backups of important data, and do not expose NAS management, SMB, or NFS ports directly to the Internet.

---

**Developed and released by [Gigabyte Grove](https://github.com/gigabytegrove).**

This public repository distributes official Zero1Local releases. Development source code and internal engineering materials are maintained separately.

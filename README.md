<p align="center">
  <img src="docs/assets/zero1-local-logo.png" alt="Zero1Local" width="520">
</p>

# Zero1Local

**Take Back Control.** Zero1Local converts the supported IronCow Zero1 NAS into a local-first NAS platform while preserving the appliance's validated Debian 11 / RK3568 hardware foundation.

Current stable release: **v1.2.4**

Zero1Local is a Gigabyte Grove project originally created by Brad Trammell.

## What Zero1Local does

Zero1Local replaces the cloud-dependent appliance-management experience with a locally managed NAS interface and services. The v1.2 feature baseline includes storage and RAID management, SMB/NFS sharing, users and groups, File Manager, Docker/apps, backup/synchronization, networking, notifications, recovery, phone transfer and system administration.

The release is cumulative: you do not install a chain of older Zero1Local versions first.

The public GitHub repository is a production distribution/support repository. Compiled runtime artifacts are published; the private application source and developer build/test tree are not. See [Distribution model](docs/DISTRIBUTION.md).

## Before you install

**Back up or move all important data off the NAS before installing Zero1Local.** Zero1Local may rewrite or reinitialize disk/storage structures for the supported layout and performance model. Existing data can be lost. A copy that exists only on the NAS is not an independent backup.

## Quick install

For a Zero1Local appliance or an already-rooted supported IronCow Zero1:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP>
```

For a supported factory-stock IronCow Zero1 requiring the root bootstrap, scan the QR code on the product sticker on the **bottom of the NAS** to obtain the serial number, then run:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP> -Serial '<NAS_SERIAL>'
```

Read [Installation](docs/INSTALLATION.md) before deploying to a factory-stock appliance.

## Core areas

| Area | v1.2 capability |
| --- | --- |
| Storage | Main Storage identity protection, RAID adoption/management, guarded `/disk0`, disk health and analytics |
| Files | SMB, userspace NFSv3, FTP/Time Machine where supported, File Manager, Recycle Bin, secure links |
| Users | Users, groups, Samba access, account policy and delegated administrators |
| Apps | Existing Docker engine adoption, container management, Compose and App Catalog |
| Protection | Backup, restore, synchronization, replication, cloud/off-site workflows |
| Phone | Manual Android MTP transfer, automatic offload, nicknames, progress/ETA/controls |
| Network | Hostname, DNS, VLANs, advanced network configuration and optional WireGuard |
| Recovery | Independent recovery service, Recovery Key, emergency SSH and rollback-safe installation |

## Software Updates in v1.2.4

v1.2.4 completes the Linux-native online update path. Update downloads are staged under `/var/cache/zero1-local/updates`, verified on the NAS, and handed to a detached Linux updater that uses the same rollback-safe transactional installer as manual deployment. The updater persists status through the expected management-service restart and removes its managed package/extraction workspace on success or failure.

Task Center now presents software updates as software updates: download, package opening, verification, appliance checks, installation, restart, and final verification/cleanup. It no longer reuses phone-transfer/file-copy fields for update work. See [Software Updates](docs/SOFTWARE-UPDATES.md) and [GitHub Update Path](docs/UPDATE-PATH.md).

## Documentation

The repository documentation is organized for owners, installers and support:

- [Documentation home](docs/README.md)
- [Getting started](docs/GETTING-STARTED.md)
- [Installation](docs/INSTALLATION.md)
- [Hardware support](docs/HARDWARE-SUPPORT.md)
- [Architecture and services](docs/ARCHITECTURE.md)
- [Storage and RAID](docs/STORAGE-AND-RAID.md)
- [Files, users and shares](docs/FILES-USERS-AND-SHARES.md)
- [SMB and NFS](docs/SMB-AND-NFS.md)
- [File Manager](docs/FILE-MANAGER.md)
- [Phone Transfer](docs/PHONE-TRANSFER.md)
- [Task Center](docs/TASK-CENTER.md)
- [Docker and Apps](docs/DOCKER-AND-APPS.md)
- [Backup, sync and replication](docs/BACKUP-SYNC-AND-REPLICATION.md)
- [Networking](docs/NETWORKING.md)
- [Remote access](docs/REMOTE-ACCESS.md)
- [Office integration](docs/OFFICE.md)
- [Notifications](docs/NOTIFICATIONS.md)
- [Security model](docs/SECURITY-MODEL.md)
- [Recovery](docs/RECOVERY.md)
- [LED status](docs/LED-STATUS.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)
- [Evidence collection](docs/SUPPORT-EVIDENCE.md)
- [Known limitations](docs/KNOWN-LIMITATIONS.md)
- [FAQ](docs/FAQ.md)
- [Distribution model](docs/DISTRIBUTION.md)
- [Documentation provenance](docs/DOCUMENTATION-PROVENANCE.md)

## Important design principles

- **Local first.** Core NAS operation does not require a Zero1Local cloud account.
- **Evidence first.** Zero1Local should fail closed when storage, identity or recovery state cannot be proven.
- **Owner data first.** Existing data is not assumed disposable.
- **Rollback safe.** Installation snapshots state and rolls back when final verification fails.
- **No kernel replacement.** v1.2 preserves the validated vendor kernel/bootloader/DTB.
- **Recovery independent of the main UI.** The Recovery Environment listens separately on TCP/8089.

## Support

Before opening an issue, read [SUPPORT.md](SUPPORT.md) and [Troubleshooting](docs/TROUBLESHOOTING.md). Never publish passwords, recovery keys, OAuth credentials, GitHub tokens or private SSH keys in an issue.

## Documentation Provenance

Zero1Local public documentation was generated with assistance from **OpenAI ChatGPT** after project planning and implementation documentation was supplied to it. **AI was not used in the design or implementation of the Zero1Local software.** Documentation is reviewed against the actual production distribution artifacts before publication.

See [Documentation provenance](docs/DOCUMENTATION-PROVENANCE.md).

## Warranty Disclaimer and Assumption of Risk

Zero1Local modifies software on the target NAS and is used at the device owner's risk. Potential consequences include data loss, service interruption, failed boot, filesystem or hardware damage, and a partially or completely unusable ("bricked") device.

Zero1Local is provided **AS IS** and **AS AVAILABLE**, without warranty of any kind. To the maximum extent permitted by applicable law, **Brad Trammell, Gigabyte Grove, the Zero1Local developers, contributors, copyright holders and distributors are not responsible or liable for hardware damage, data loss, service interruption, loss of use, financial loss, or other damages or losses arising from installation, modification, distribution or use of Zero1Local.**

The device owner is responsible for complete independent backups, moving irreplaceable data off the NAS before installation, confirming target compatibility and deciding whether to install or use the software. See [Warranty and assumption of risk](docs/WARRANTY-AND-RISK.md) and [LICENSE.md](LICENSE.md).

## License

See [LICENSE.md](LICENSE.md). Attribution to Brad Trammell and Gigabyte Grove must be retained as specified by the license.

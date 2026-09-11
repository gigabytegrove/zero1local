# Zero1Local v1.2

Zero1Local v1.2 is the current stable production release of the local-first replacement platform for the **IronCow Zero1 NAS**.

This is a **cumulative release**. A supported factory-stock IronCow Zero1 can be taken directly from the factory environment through the established root bootstrap and into the complete Zero1Local v1.2 environment. Earlier Zero1Local releases are not required.

## What's included

- Complete local-first NAS management interface with light and dark appearance modes
- Main Storage and RAID management with fail-closed `/disk0` protection
- SMB file sharing, users, groups and share permissions
- Userspace NFSv3, FTP and Time Machine workflows where supported
- File Manager with uploads, downloads, search, favorites, Recycle Bin, ZIP operations, image lightbox/zoom and video playback
- Docker management, Compose stacks and managed application catalog
- Office integration and zero-touch Office setup flow
- Backup, restore, synchronization, replication and cloud/off-site workflows
- Network, DNS, VLAN and optional WireGuard remote-access management
- Notifications and Task Center
- Independent Recovery Environment on TCP/8089
- Transactional installation, automatic rollback and recovery safeguards

## Phone Transfer

Zero1Local v1.2 includes device-specific Android phone workflows centered on direct MTP access:

- Manual selective transfers with **no arbitrary file-count limit**
- Automatic phone offload rules tied to stable device identity
- Persistent phone nicknames without replacing hardware identity
- Copy and Move workflows
- Private partial-file writes, byte-count verification and SHA-256 destination read-back
- Source deletion only after a verified Move
- No elapsed-time/idle timeout on the manual MTP device session
- Manual sessions take priority over automatic offload
- Automatic jobs wait for the phone to enter the correct transfer mode instead of failing immediately
- Task Center progress, ordered remaining files, average effective transfer speed and dynamic ETA
- Pause, Resume, Stop-after-current-file and Cancel-now controls

### Phone status LED behavior

| State | Power/status LED |
| --- | --- |
| Saved phone connected but not ready for file transfer | Slow-flashing yellow |
| Transferable mode detected / device acquired | Green |
| Transfer active | Fast-flashing green |
| Verified transfer completed | Solid green for five seconds |
| Transfer or verification failure | Flashing red |

A browser/login session expiring does not terminate an already-running server-side transfer task.

## Installation

Download `Zero1Local-v1.2-production.zip`, extract it on Windows, open PowerShell in the extracted directory and run:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP>
```

For a supported factory-stock IronCow Zero1 that still requires the initial root bootstrap:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP> -Serial '<NAS_SERIAL>'
```

The installer performs package-integrity validation, root-access establishment when required, deployment staging, appliance/preflight checks, rollback preparation, installation and final verification.

> **Qualification note:** the factory-stock bootstrap path is included in v1.2, but public hardware-qualified status should be based on an actual replay against a current factory-reset target. Package/source validation alone is not a substitute for that hardware evidence.

## Distribution layout

The production ZIP contains exactly:

```text
Install-Zero1Local.ps1
README.txt
SHA256SUMS.txt
Zero1Local-v1.2.tar.gz
deploy-on-nas.sh
```

## Supported platform

Primary release target:

- **IronCow Zero1 NAS**
- Rockchip RK3568 EVB8 LP4 V10 Board NAS
- ARM64
- Vendor Debian 11 environment
- Kernel `5.10.198`
- Main Storage mounted at `/disk0`
- XFS on the validated production configuration

Zero1Local intentionally preserves the vendor kernel, bootloader and DTB. Other ARM64 systems are compatibility targets only and must be separately qualified.

## SHA-256

| Artifact | SHA-256 |
| --- | --- |
| `Zero1Local-v1.2-production.zip` | `6ecaf7a50897ca59a52c611fbe2774026e622e4e6533cd982940e7793c4770b9` |
| `Zero1Local-v1.2.tar.gz` | `de74c9560e008fb2d7c5c93cdbf514d866e68a5a19556dd5190d85e626aed987` |
| `zero1d-linux-arm64` | `3643fa74fce3fdbc00f90f5ab28700b2677c8f02cf010d30ab7f9918130985dd` |
| `zero1-recovery-linux-arm64` | `9c16b2d43673074a38de8ba5179b1c89f9231374012492e0b7b2c80bbebf5d17` |

## Documentation

Start with the [documentation index](docs/README.md). Important pages include:

- [Installation](docs/INSTALLATION.md)
- [Upgrading and rollback](docs/UPGRADING-AND-ROLLBACK.md)
- [Phone Transfer](docs/PHONE-TRANSFER.md)
- [Task Center](docs/TASK-CENTER.md)
- [File Manager](docs/FILE-MANAGER.md)
- [Storage and RAID](docs/STORAGE-AND-RAID.md)
- [SMB and NFS](docs/SMB-AND-NFS.md)
- [Recovery](docs/RECOVERY.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)
- [Known limitations](docs/KNOWN-LIMITATIONS.md)

## Verification

The v1.2 production distribution was validated for:

- exact five-file outer distribution layout
- outer SHA-256 integrity
- installer/deployment payload-hash agreement
- 142/142 internal payload files
- exact release-tree verification
- Go tests and `go vet`
- Go race-detector suite
- JavaScript syntax
- Python MTP helper self-test
- shell syntax and manifest validation
- ARM64 binary identity
- deterministic binary rebuild

Zero1Local v1.2 is the locked production baseline. Future work should be additive and preserve established behavior unless a change is explicitly intended.

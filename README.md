# Zero1Local

**Local-first NAS management software for YXS / IronCow Zero1 appliances.**

Zero1Local modernizes supported YXS / IronCow Zero1 network-attached storage devices with a browser-based management interface for files, storage, network sharing, backup and replication, applications, appliance health, updates, and recovery. Core NAS functionality stays on your network and does not require a manufacturer cloud account.

**Developed and released by [Gigabyte Grove](https://github.com/gigabytegrove).** Originally created by Brad Trammell.

[Releases and downloads](https://github.com/gigabytegrove/zero1local/releases) · [Report an issue](https://github.com/gigabytegrove/zero1local/issues) · [Syncria](https://github.com/gigabytegrove/syncria)

> [!IMPORTANT]
> **Release status — October 13, 2026:** Zero1Local **v1.3.1 is undergoing release qualification and is not yet published**. Use only a release package confirmed compatible with your appliance. Check [GitHub Releases](https://github.com/gigabytegrove/zero1local/releases) for current downloads, checksums and release notes.

> [!CAUTION]
> **BACK UP YOUR DATA OUTSIDE THE NAS FIRST.** Installation, recovery, upgrades, storage migration, power interruptions, or hardware faults can cause service interruption or permanent data loss. Verify that you can restore from your independent backup. A second folder or drive inside the same appliance is not an independent disaster-recovery backup.

## Features

| Category | What Zero1Local manages |
| --- | --- |
| **Storage** | Disks and SMART health, Main Storage state, supported RAID management, USB storage, hardware conditions, guarded storage operations |
| **Files & sharing** | Browser File Manager, shared folders, users, groups, access permissions, SMB, optional NFS |
| **Protection** | Local/USB backup and restore, **native NAS-to-NAS replication**, appropriate filesystem-native snapshots where available |
| **Applications** | Docker containers, images, networks, volumes, Compose stacks, supported application catalog |
| **Connectivity** | LAN settings, hostnames, DNS, VLANs, guarded network changes |
| **Monitoring** | Appliance health, notices, Action Center, Task Center, diagnostics and service state |
| **System** | In-UI software updater, maintenance, activity history, separate recovery and eligible rollback |
| **Phone Transfer** | Android USB/MTP file transfers on compatible hardware, optional managed offload workflows |
| **Guidance** | Built-in Help for the functions available on your appliance |

Availability varies by hardware, kernel capabilities, filesystem, installed services, and release. Zero1Local does not invent unsupported storage features.

## Hardware support

The primary platform is the **YXS / IronCow Zero1 NAS**. The established native hardware profile uses a **Rockchip RK3568 EVB8 LP4 V10 ARM64** board, a vendor **Debian 11** environment and **Linux 5.10.198** kernel, with separate internal system storage and owner data normally mounted at `/disk0`.

| Component | Practical boundary |
| --- | --- |
| CPU | Native IronCow Rockchip RK3568 ARM64/AArch64 |
| Operating system | Existing vendor OS; this application is **not** a firmware or kernel replacement |
| Main Storage | Can adopt compatible existing single-disk, complete RAID0, or RAID1 configurations after positive identity checks |
| Array creation | Only implemented/proven creation paths are offered; do not assume arbitrary RAID creation |
| Drive replacement | Guarded, supported RAID1 scenarios only |
| Snapshots | Actual Btrfs subvolumes or ZFS datasets when supported; **not emulated** for XFS/ext4 |
| NFS | Optional userspace **NFSv3**, not kernel NFSv4 on the validated vendor profile |
| Other ARM64 NAS devices | Compatibility only until separately qualified; model-specific controls cannot be assumed |

Zero1Local uses the appliance's existing vendor operating system, kernel and boot environment. The underlying platform requires careful security management, including a private, appropriately segmented network.

### Storage safety

Zero1Local checks the physical identity of mounted Main Storage before allowing dependent services to treat it as writable owner storage. If the expected array disappears, the application is designed to protect against silently writing data into the underlying root/eMMC mount directory. A degraded RAID1 still needs repair, while RAID0 provides no redundancy.

Never create test files in an unverified `/disk0` mount, run unplanned filesystem repair, or force array creation to work around a failed installation preflight.

## Files, sharing and applications

**Files and access:** Create and manage eligible shared folders; administer local users, groups, and permissions; work through the web File Manager; and share data using SMB or optional supported NFS services. Confirm that share paths actually reside on the expected mounted storage before changing permissions.

**Containers:** Zero1Local can adopt and manage an existing Docker engine, including supported Compose workloads, images, networks and volumes. The existing Docker data root is important owner state: an unexpected data-root change must not be mistaken for empty or missing containers. Container features are optional, not requirements for NAS operation.

**Network controls:** Manage supported DNS, hostname, VLAN, and LAN settings, with safeguards for changes that could disconnect administrators. Avoid exposing any of these management services to the public Internet.

**Monitoring:** The appliance overview summarizes health. **Action Center** highlights active items requiring attention; **Notifications** provides the notice history and management actions; **Task Center** tracks running, finished and failed operations. An unread badge should correspond to genuinely visible active notices.

**Phone transfers:** USB/MTP is the primary established Android transfer path. Phone hardware and protocol availability vary. Unlock the device and select its file-transfer USB mode before expecting browsing/offload.

## Backups, replication and Syncria

Zero1Local provides native NAS protection and appliance replication. For cloud synchronization with a Zero1Local NAS or another NAS, use **[Syncria](https://github.com/gigabytegrove/syncria)**.

| Need | Recommended path |
| --- | --- |
| **Between supported Zero1Local NAS devices** | Zero1Local's built-in NAS-to-NAS replication |
| **Local or USB backup / restore** | Zero1Local's supported backup and restore workflows |
| **Cloud ↔ Zero1Local NAS or another NAS** | **[Syncria](https://github.com/gigabytegrove/syncria)** — independent Docker-based cloud and NAS synchronization |
| **Disaster recovery** | Independently verified backups, stored separately from both source and replica |

### Native NAS-to-NAS replication

Zero1Local provides appliance-to-appliance replication on trusted network paths without requiring a cloud account, Syncria, Docker, or a third-party management platform. Depending on the supported configuration, native replication uses secure SSH/rsync transport with a dedicated peer identity and tracked jobs. Replication is **not a substitute for backup**: file deletion, corruption and ransomware-encrypted content can be replicated.

### Cloud and NAS synchronization with Syncria

**[Syncria](https://github.com/gigabytegrove/syncria)** is the recommended companion for syncing your cloud files with a **Zero1Local NAS or another compatible NAS**. It can run as a standalone Docker container on a suitable NAS or a separate Docker host with authorized access to your storage.

Syncria supports **cloud → NAS**, **NAS → cloud** and **bidirectional synchronization**. Configure your cloud accounts, permitted storage locations, sync direction, relationships and schedules using Syncria's own interface. A separate Docker host can reach NAS storage through suitable network shares or mounted folders, according to Syncria's supported setup methods.

Syncria manages its own configuration and updates, and works independently with Zero1Local or other NAS devices. **Zero1Local's native NAS-to-NAS replication works without Syncria.**

**Get Syncria:** https://github.com/gigabytegrove/syncria

## Installation

### Before you start

1. Have an **independent, readable backup** of your files off the target NAS.
2. Confirm this is a compatible YXS/IronCow Zero1, with a known IP address on a trusted LAN.
3. Check current disk/RAID health, free space, power reliability, and your recovery options.
4. Confirm the intended [GitHub Release](https://github.com/gigabytegrove/zero1local/releases) is approved for your device and review its notes and checksums.
5. Use only an intact, matched release package. Do not mix installer files between versions.

### Download the official production package

When a qualified release is available, download its exact named asset from [Releases](https://github.com/gigabytegrove/zero1local/releases):

```text
Zero1Local-vX.Y.Z-production.zip
```

The expected production ZIP includes these five top-level files:

```text
Install-Zero1Local.ps1
README.txt
SHA256SUMS.txt
Zero1Local-vX.Y.Z.tar.gz
deploy-on-nas.sh
```

Unzip into an empty folder. Review `SHA256SUMS.txt` and verify that the included files match their published hashes. The installer pins the corresponding runtime tarball checksum; an asset or digest mismatch is a **stop condition**.

From PowerShell inside the extracted folder, this read-only check validates the manifest entries:

```powershell
$ErrorActionPreference = 'Stop'
foreach ($entry in Get-Content -LiteralPath '.\SHA256SUMS.txt') {
    if ([string]::IsNullOrWhiteSpace($entry)) { continue }
    if ($entry -notmatch '^([0-9a-fA-F]{64})\s+(.+)$') {
        throw "Invalid checksum manifest entry: $entry"
    }
    $expected = $Matches[1]
    $filename = $Matches[2].Trim()
    if (-not (Test-Path -LiteralPath $filename -PathType Leaf)) {
        throw "Missing release file: $filename"
    }
    $actual = (Get-FileHash -LiteralPath $filename -Algorithm SHA256).Hash
    if ($actual -ine $expected) { throw "Checksum mismatch: $filename" }
    Write-Host "Verified: $filename"
}
```

A matching checksum catches corruption or inconsistent files. It does not, by itself, authenticate a malicious source; download from the official repository.

### Windows installer: already rooted or existing installation

Run the cumulative Windows installer in the extracted release folder:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP>
```

Replace `<NAS-IP>` with the appliance IP. Existing authorized root SSH access must work for this path.

### Windows installer: factory-stock IronCow Zero1

For an unrooted/factory-stock compatible IronCow Zero1, the supported installer path accepts the device serial number:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP> -Serial '<NAS-SERIAL>'
```

The serial is encoded in the QR code on the sticker under the device; use its exact value. On factory devices a direct root SSH probe may initially fail as expected; the installer can continue through its supported bootstrap sequence.

The installer verifies payload integrity, compatibility, storage readiness, recovery/rollback safety, then stages, activates and checks the services. Temporary bootstrap components are removed after the supported permanent access path is verified. **Do not power off the NAS during installation, activation or rollback.**

> [!WARNING]
> First-time installation modifies appliance management. Do not bypass preflight checks, manually repartition drives, flash firmware, or improvise factory bootstrap. If any safety check fails, investigate the cause instead of forcing deployment.

### First login and checklist

After a successful installation, on the **private LAN**:

| Address | Purpose |
| --- | --- |
| `http://<NAS-IP>/` | Main management UI |
| `http://<NAS-IP>:8088/` | Compatibility management listener |
| `http://<NAS-IP>:8089/` | Separate Recovery Environment |
| `http://<NAS-IP>:8090/` | Session-independent update progress monitor |

Confirm Main Storage, RAID, shares and permissions, network connectivity, and backup destinations. Run the built-in diagnostics. Go to **System → Recovery** and save the **Recovery Key off the NAS**. It is separate from the ordinary administrator password. HTTP should only be used on a trusted, controlled network; arrange supported HTTPS or protected VPN access for less-trusted paths.

## Updating from inside Zero1Local

For a running appliance, **System → Updates is the primary, preferred upgrade path**. The appliance checks GitHub Releases, downloads the matching ZIP, verifies it, stages the upgrade, reports progress and handles supported rollback. Updates are managed directly within Zero1Local, independently of third-party container platforms.

The Updates screen distinguishes **Installed**, **Latest found**, **Last checked**, and whether an update is eligible. Select **Check now** to force a fresh check rather than relying on cached discovery.

| Channel | Eligible releases |
| --- | --- |
| **Stable** | Published non-prerelease versions |
| **Beta / Release Candidate** | Published stable releases and eligible prereleases |
| **Alpha** | All published release classes |
| **Draft** | Never included |

Advanced settings control the channel. A prerelease does not appear on Stable; a source-code version bump does not create an updater-visible release. A new version must be **published with an exact matching `Zero1Local-vX.Y.Z-production.zip` asset**.

A typical update consists of download, checksums, staged validation, storage/compatibility checks, rollback preparation, activation, service restart, health verification, and cleanup. The status-only independent Update Monitor on port **8090** follows the transaction while the main service restarts.

Rollback depends on an intact compatible previous release and recovery checkpoint. **Not every downgrade is permitted**, especially after non-reversible storage changes. Keep an independent data backup even when rollback is offered.

## Independent recovery

If the main UI fails, first try `http://<NAS-IP>:8089/` and authenticate with your separate Recovery Key. Depending on current state, the Recovery Environment can inspect health, restart management, restore verified configuration, reset ordinary admin access, and roll back to an eligible earlier installation.

An emergency key-only SSH path is also provided for protected private-LAN recovery; it is **not** a general-purpose Internet SSH endpoint.

From an already authorized root session, gather evidence without changing storage:

```bash
systemctl --no-pager --full status zero1-local.service zero1-recovery.service zero1-storage.service
journalctl -u zero1-local.service -n 200 --no-pager
curl -fsS http://127.0.0.1:8088/healthz
curl -fsS http://127.0.0.1:8089/healthz
findmnt -T /disk0
cat /proc/mdstat
lsblk -f
```

For update failures, these are useful evidence sources:

```bash
cat /var/lib/zero1-local/update-apply.json 2>/dev/null
ls -lah /var/lib/zero1-local/update-apply-*.log 2>/dev/null
ls -lah /var/cache/zero1-local/updates 2>/dev/null
```

Do not delete active update staging, rollback evidence or existing data roots just because an update or application failed.

## Network and security guidance

Zero1Local is designed for a **trusted local network or segmented VLAN**. No public cloud service is needed for ordinary NAS access. Internet access may be needed for optional external services or GitHub update discovery/downloads.

| Port | Default or optional service |
| --- | --- |
| TCP **80** | HTTP management |
| TCP **8088** | Compatibility management |
| TCP **8089** | Independent Recovery |
| TCP **8090** | Update Monitor |
| TCP **139/445** | SMB sharing, when enabled |
| TCP **2049/20048** | Userspace NFSv3 services, when enabled |
| TCP **22** | Normal SSH, when enabled |
| TCP **22222** | Restricted key-only emergency SSH |
| Other | Configured HTTPS, container ports or other optional services |

**Do not forward NAS management, recovery, SMB, NFS, or SSH services to the open Internet.** Use a firewall and trusted private VPN where remote administration is necessary. The retained vendor OS/kernel may no longer receive all upstream security fixes. VLAN isolation, least privilege, working backups and carefully controlled access are particularly important.

Never include passwords, Recovery Keys, cloud service credentials, VPN private keys, SSH keys, full connection files or owner data in a public support report.

## Troubleshooting

| Symptom | Check first |
| --- | --- |
| **Update missing** | Is the exact production ZIP actually published? Correct channel? Fresh Check now? Can GitHub be reached? |
| **Main UI unavailable** | Check service status and 8088 health. Try independent Recovery on 8089 |
| **Disk or share disappeared** | Verify physical Main Storage identity, mount and RAID state; **do not write to an unverified path** |
| **SMB access denied** | Check user permissions, actual mounted share path and Samba health |
| **NFS unavailable** | Check userspace NFSv3 service/tooling; do not assume NFSv4 |
| **Docker containers appear missing** | Confirm Docker's real existing data root before modifying anything |
| **Phone transfer waiting** | Unlock Android device and choose **File transfer / Android Auto** USB mode |
| **Replication fails** | Check trusted peer access, storage space, permissions and Task Center job output |
| **Installation rolled back** | Preserve the specific installer log/transaction state; do not repeatedly bypass safety preflight |

## Platform compatibility and release channels

- **Device focus:** YXS / IronCow Zero1 NAS hardware using the supported ARM64 profile.
- **Operating environment:** Existing vendor OS, kernel and boot environment on a private, controlled network.
- **Storage:** RAID, snapshots and filesystem operations follow the actual hardware and filesystem capabilities.
- **NAS replication:** Native replication between supported Zero1Local appliances.
- **Cloud/NAS sync:** **[Syncria](https://github.com/gigabytegrove/syncria)** connects cloud storage with Zero1Local or another NAS.
- **Updates:** Stable, Beta/Release Candidate and Alpha are selected under **System → Updates → Advanced**. Review release qualification and compatibility notes before installing.

## Support and feedback

Use the repository's [Issues](https://github.com/gigabytegrove/zero1local/issues) page for user-facing bug reports and documentation issues. Include the **Zero1Local version, appliance model, relevant storage/network topology, reproduction steps, what actually happened and redacted error output**. For updater issues include the release channel and exact package filename. If an operation affected storage, do not proceed with destructive troubleshooting before preserving evidence and backups.

The public repository is the **release/distribution repository**, not the editable development-source repository. It holds compiled distribution packages and their notes, metadata, and owner-facing documentation. Development implementation and internal engineering materials are maintained separately.

## License, warranty and attribution

Zero1Local uses the **Zero1Local Free Attribution License v1.0** in the official distribution. Redistribution and modification are permitted under its terms, including retaining reasonable original-author attribution. Modified versions must not imply endorsement by the original author or Gigabyte Grove.

**Zero1Local originally created by Brad Trammell, a Gigabyte Grove project.**

The software is provided **“AS IS”** with no warranty. You assume responsibility for backups, compatibility, installation risk and decisions affecting your device. The full license is supplied with official release material.

---

**Zero1Local is developed and released by [Gigabyte Grove](https://github.com/gigabytegrove).**

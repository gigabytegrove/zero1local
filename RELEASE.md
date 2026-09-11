# Zero1Local v1.2.2

Zero1Local v1.2.2 is a focused **GitHub update-path validation and installer-documentation release** over the locked v1.2 feature baseline.

The purpose of this release is to prove the complete public update path introduced in v1.2.1: **discover v1.2.2 from GitHub Releases, select the correct production asset, download it, verify it, hand it to the transactional installer, and come back online reporting v1.2.2.**

No existing NAS feature is intentionally removed, disabled, capped, renamed, or redesigned in v1.2.2.

## Important: Back Up Your Data First

**Before installing Zero1Local, back up or move all important data off the NAS entirely.**

Zero1Local changes the software stack that manages the appliance and may rewrite or reinitialize disk/storage structures to use the supported Zero1Local layout and performance model. Existing data can be lost during storage conversion, reinitialization, migration, recovery, unexpected power loss, hardware failure, or installation failure.

A second copy that exists only on the same NAS is **not** an independent backup. Keep irreplaceable data on another storage device or service before installation.

## What's Changed

### GitHub updater transition

v1.2.1 can discover the public GitHub Releases feed, but its dashboard installer expects the selected `*-production.zip` to contain the Zero1Local release tree directly.

The canonical manual Zero1Local distribution intentionally uses a five-file wrapper instead. To validate the v1.2.1 → v1.2.2 transition without breaking the locked manual distribution contract, this GitHub release contains **two different ZIP assets**:

- **`Zero1Local-v1.2.2-production.zip`** — dashboard-updater transition asset. This is the exact asset v1.2.1 should discover and install from the Zero1Local Updates page.
- **`Zero1Local-v1.2.2-distribution.zip`** — complete cumulative manual/factory installer with the canonical five-file root.

v1.2.2 also adds dashboard-updater support for the canonical five-file distribution format. Once the v1.2.1 → v1.2.2 path has been proven on real hardware, future releases can use that format directly for normal production updates.

### Better factory-stock root-access guidance

If the NAS is already rooted or already running Zero1Local, use the normal installer path.

If direct root SSH is unavailable on a factory-stock IronCow Zero1, v1.2.2 now stops with clear guidance instead of leaving a raw SSH error such as:

```text
banner exchange: Connection to UNKNOWN port -1: Connection refused
```

A factory-stock/unrooted unit requires the `-Serial` flag.

**The NAS serial number is encoded in the QR code on the product sticker on the bottom of the NAS.** Scan the QR code and use the serial value exactly as encoded.

### Documentation and risk disclosure

v1.2.2 expands the shipped/public documentation to make the following requirements explicit:

- back up or move important data off the NAS before installation;
- factory-stock installations require the NAS serial when root SSH has not yet been established;
- the serial is encoded in the QR code on the sticker on the bottom of the NAS;
- manual/factory installation remains a cumulative five-file distribution;
- v1.2.2 uses separate GitHub updater and manual distribution assets for this transition release;
- Zero1Local is installed and used at the device owner's risk.

## Manual Installation / Upgrade

For a current Zero1Local appliance or an already-rooted supported IronCow Zero1, download:

```text
Zero1Local-v1.2.2-distribution.zip
```

Then use the complete PowerShell deployment flow documented in that ZIP's `README.txt`.

The final invocation is:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP>
```

## Factory-Stock / Unrooted Installation

First scan the QR code on the product sticker on the bottom of the NAS to obtain its serial number.

Then use the complete PowerShell deployment flow in `Zero1Local-v1.2.2-distribution.zip` and invoke:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP> -Serial '<NAS_SERIAL>'
```

The cumulative installer performs the established factory root bootstrap, validates direct root SSH, removes the temporary bootstrap containers, performs package/preflight/rollback-safety validation, installs Zero1Local, and verifies the management/recovery endpoints.

## Testing the v1.2.1 → v1.2.2 Online Update

On a NAS currently running v1.2.1:

1. Publish this GitHub release as **v1.2.2** and mark it as a normal stable/latest release, not a draft or prerelease.
2. Upload `Zero1Local-v1.2.2-production.zip` as an asset.
3. Open **Zero1Local → Updates** on the v1.2.1 NAS.
4. Run/check for updates.
5. Confirm v1.2.2 is detected as newer than v1.2.1.
6. Confirm the selected asset is exactly `Zero1Local-v1.2.2-production.zip`.
7. Start installation from the dashboard.
8. Confirm the update downloads and verifies successfully.
9. Confirm the transactional installer activates the release and the UI reconnects.
10. Confirm the running version reports **v1.2.2**.
11. Confirm management (`:80`), compatibility (`:8088`) and Recovery (`:8089`) endpoints remain healthy.

The result of that real-appliance test determines whether the public GitHub update path is hardware-qualified. Package/source validation alone does not substitute for that replay.

## Locked v1.2 Feature Baseline Preserved

v1.2.2 preserves the existing Zero1Local v1.2 feature set, including:

- local-first NAS management;
- Main Storage and RAID management;
- SMB and userspace NFS;
- FTP and Time Machine workflows where supported;
- users, groups, shares and permissions;
- File Manager, image lightbox/zoom and video playback;
- Docker, Compose and managed applications;
- Office integration;
- backup, restore, synchronization and replication;
- cloud/off-site workflows;
- networking, DNS and VLAN controls;
- notifications and Task Center;
- independent Recovery Environment and rollback protections;
- Manual Phone Transfer and Automatic Phone Offload;
- persistent phone nicknames;
- no arbitrary manual phone-transfer file-count limit;
- no elapsed-time/idle timeout on the manual MTP device session;
- verified Copy/Move semantics;
- Pause, Resume, Stop and Cancel controls;
- ordered remaining-file queue;
- average transfer speed and dynamic ETA;
- manual-session priority over automatic offload;
- yellow waiting / green ready-transfer phone LED behavior.

## Release Assets

### Dashboard updater asset

```text
Zero1Local-v1.2.2-production.zip
SHA-256: b04979b09ee6cc1febb62c81c2e85f989cafc05effd4ebe24201d80cf61cf36e
```

### Complete manual/factory distribution

```text
Zero1Local-v1.2.2-distribution.zip
SHA-256: 20a266916bf03c847e7410b14b20c145c8306f8d041a3fa75ed563ed5d0a07b9
```

### Cumulative payload inside the distribution

```text
Zero1Local-v1.2.2.tar.gz
SHA-256: 8a18c811709ef8d941c5f471a8a621d2680c18e543440a650c796e4638682025
```

### ARM64 management daemon

```text
zero1d-linux-arm64
SHA-256: 7eff7d374639aba9aeb48253e792205913f23b6fd94689b0f5ea21cc7274a68a
```

### ARM64 Recovery daemon

```text
zero1-recovery-linux-arm64
SHA-256: 1f947c38c546bb31c621f47aac25029448008f7b96b45980b27399400596c765
```

## Verification

The exported v1.2.2 packages were validated for:

- exact canonical five-file manual distribution layout;
- outer SHA-256 verification;
- PowerShell installer payload pin = NAS deploy-script payload pin = actual payload SHA-256;
- 147/147 internal release-tree checksums;
- exact release-tree verification;
- v1.2.2 runtime/manifest identity;
- v1.2.1 → v1.2.2 version comparison and updater transition tests;
- canonical five-file update-package handling in v1.2.2;
- archive traversal rejection;
- Go test suite;
- Go vet;
- Go race detector;
- JavaScript syntax;
- Python direct-MTP helper self-test;
- shell syntax;
- manifest JSON validation;
- ARM64 binary identity; and
- deterministic byte-for-byte ARM64 rebuild of both shipped binaries.

## Warranty Disclaimer and Assumption of Risk

Zero1Local modifies or replaces software components on the target NAS. Although the project includes integrity checks, transactional installation, rollback safeguards, recovery tooling and hardware-specific validation, no software modification can eliminate all risk.

**By installing, using, modifying, or distributing Zero1Local, the device owner and user voluntarily accept all risks associated with modifying the device.** These risks include, but are not limited to, data loss or corruption, service interruption, loss of network or storage access, failed installation or upgrade, failed rollback or recovery, filesystem or operating-system damage, boot failure, hardware malfunction or incompatibility, and a device becoming partially or completely unusable or "bricked."

Zero1Local is provided **AS IS** and **AS AVAILABLE**, without warranty of any kind, express or implied. **To the maximum extent permitted by applicable law, Brad Trammell, Gigabyte Grove, the Zero1Local developers, contributors, copyright holders and distributors are not responsible or liable for hardware damage, data loss, service interruption, loss of use, financial loss, or any other direct, indirect, incidental, special, exemplary, consequential or other damages or losses arising from or related to installation, modification, distribution or use of Zero1Local.**

The device owner is responsible for maintaining complete independent backups, moving irreplaceable data off the NAS before installation, confirming target compatibility, reviewing release documentation, and deciding whether installation or use is appropriate.

See the shipped `LICENSE.txt` and `docs/WARRANTY-AND-RISK.md` for the complete release terms.

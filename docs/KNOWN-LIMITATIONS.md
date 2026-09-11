# Known Limitations and Qualification Boundaries

Zero1Local documents unsupported/unqualified paths explicitly rather than implying universal compatibility.

## Hardware

- Primary native target is the IronCow Zero1 / RK3568 EVB8 LP4 V10 appliance.
- Other ARM64 NAS hardware is Compatibility Mode unless separately qualified.
- v1.2 does not replace the vendor kernel, bootloader or DTB.


## Factory-stock bootstrap

- The v1.2 cumulative installer includes the supported factory-stock root-bootstrap path.
- Treat that path as hardware-qualified only after the exact public v1.2 wrapper is replayed successfully against a current factory-reset IronCow Zero1.

## Operating-system base

- The validated appliance uses Debian 11.
- Debian 11 reached Debian LTS end-of-life on 2026-08-31.
- Archive/source repair for dependency installation does not restore upstream security support.

## NFS

- Kernel NFS is unavailable on the validated vendor kernel path.
- Zero1Local uses userspace NFSv3 (UNFS3), not kernel NFSv4.

## Snapshots

- Native snapshots require actual Btrfs subvolumes or ZFS datasets.
- XFS/ext4 are not given fake snapshot semantics.
- The validated IronCow Main Storage is XFS.

## RAID

- Existing single-disk, RAID1 and complete RAID0 Main Storage can be adopted.
- Fresh destructive array creation is RAID1-only in the proven v1.2 creation path.
- Guided drive replacement is RAID1-only where the backend positively identifies a supported replacement case.

## Phone Transfer

- Android USB/MTP is the primary v1.2 phone path.
- Apple support exists in the inherited path but must not be represented as hardware-qualified without real Apple-device evidence.
- Wi-Fi and Bluetooth manual phone transfer are not v1.2 transports.
- Transfer speed/ETA are measurements/estimates of effective completed work, not guarantees of USB bus throughput.

## Media

- Browser-native video playback depends on browser codec/container support.
- VLC fallback depends on VLC/cvlc being installed and able to handle the media.

## Remote access

- WireGuard capability depends on the required local tools being present.
- Zero1Local does not require or provide a cloud relay account for remote access.

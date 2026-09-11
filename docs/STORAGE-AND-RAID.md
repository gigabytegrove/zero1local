# Storage and RAID

## Main Storage

Zero1Local treats the owner-data filesystem mounted at `/disk0` as **Main Storage**. It validates the physical identity behind that mount rather than assuming a particular Linux device name.

Supported adopted Main Storage modes in v1.2 include:

- single-disk
- RAID1
- RAID0, when the complete array is present

A degraded RAID1 may remain mounted for recovery. Release installation/qualification expects steady-state healthy storage. An incomplete RAID0 is not treated as usable Main Storage.

## Fresh destructive storage creation

Fresh destructive array creation is intentionally narrower than adoption: the implemented/proven fresh creation backend is RAID1. Zero1Local does not pretend to offer destructive creation modes it has not proven.

## Array-loss protection

If the validated Main Storage disappears, Zero1Local must not allow `/disk0` to become an ordinary directory on root/eMMC. The storage service establishes a fail-closed read-only guard instead.

This protects against the historical failure mode where applications continue writing to the mountpoint after the real array disappears and fill the appliance's internal eMMC.

## Drive replacement

Guided member replacement is exposed only when the backend positively identifies a supported RAID1 replacement case. Rebuild progress is tracked in Task Center. RAID0 and arbitrary/unknown array layouts are not represented as safely replaceable through the guided workflow.

## Snapshots

Native snapshots are capability-gated:

- Btrfs: only real Btrfs subvolumes
- ZFS: only real datasets
- XFS/ext4: no fake snapshot emulation

The validated IronCow Main Storage is XFS, so use backups/replication rather than expecting native snapshots on that filesystem.

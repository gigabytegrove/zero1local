# Architecture and Services

Zero1Local is a local-first appliance manager built around a primary Go management daemon, an independent Go recovery daemon and narrowly scoped helper/service units.

## Important paths

| Path | Purpose |
| --- | --- |
| `/opt/zero1-local/current` | active Zero1Local release |
| `/opt/zero1-local/releases/<version>` | installed release tree |
| `/var/lib/zero1-local` | persistent Zero1Local state |
| `/var/backups/zero1-local` | transaction/recovery backups |
| `/etc/zero1` | managed configuration including emergency SSH and NFS |
| `/disk0` | validated Main Storage mountpoint |
| `/usr/local/libexec/zero1-local` | stable recovery/safety helpers |

## Principal services

| Service | Purpose |
| --- | --- |
| `zero1-local.service` | primary management UI/API on TCP/80 plus compatibility TCP/8088 |
| `zero1-recovery.service` | independent Recovery Environment on TCP/8089 |
| `zero1-storage.service` | establish Main Storage identity or fail-closed `/disk0` guard |
| `zero1-docker.service` | Zero1Local-owned Docker lifecycle after storage is safe |
| `zero1-unfs3.service` | userspace NFSv3 server when enabled |
| `zero1-phone-usb-host.service` | set validated phone USB controller to host role |
| `zero1-dns.service` | reassert selected DNS policy |
| `zero1-firewall.service` | strict normal firewall after recovery invariants are established |
| `zero1-emergency-ssh.service` | independent public-key-only emergency SSH on TCP/22222 |
| `zero1-emergency-access.service` | verifies independent recovery access before strict firewall activation |
| `zero1-hardware-recovery.service` | physical recovery-key listener |

## Boot ordering

Storage and recovery boundaries are intentionally established before the primary management service and strict firewall. Docker/NFS require safe Main Storage; Recovery remains independent of the main management daemon.

## Main Storage fail-closed behavior

`/disk0` is a mountpoint contract, not a synonym for `/dev/md127`. Zero1Local persists and validates the physical source, UUID, filesystem and storage mode. If Main Storage cannot be positively established, Zero1Local places a read-only guard at `/disk0` so owner writes cannot silently fall through to root/eMMC.

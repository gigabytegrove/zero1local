# Mobile access and network services — Zero1Local v1.3.5

Zero1Local is designed primarily for use on a **trusted local network**. The v1.3.5 package is available as a [Beta / Release Candidate](https://github.com/gigabytegrove/zero1local/releases/tag/v1.3.5), not a promoted Stable release.

## Android/mobile access on your LAN

The authenticated mobile interface continues to support device pairing, permitted shared folders, file browsing, downloads and uploads on the NAS's local network.

1. Connect the mobile device to the permitted LAN/Wi-Fi network that can reach your NAS.
2. Open the mobile app and use its local pairing process.
3. Sign in and browse only shares the selected NAS account is allowed to access.
4. If access fails, first verify the NAS's LAN address, VLAN/firewall policy and account/share permissions.

**You do not need Zero1Local to create a WireGuard VPN or forward a port to the public Internet to use the LAN mobile app.** Historic public bootstrap, cellular pairing, automatic router mappings and managed WireGuard remote access have been retired. Some mobile API routes retain their older name for compatibility; that does not mean the remote VPN still operates.

A separately administered private VPN can provide network connectivity where appropriate, but Zero1Local does not automatically provide or maintain that VPN.

## Why the port inventory has unfamiliar entries

The Connectivity screen shows TCP/UDP listening sockets. **Binding to a port does not necessarily mean it can be reached from the Internet.**

| Listener/address | What it indicates |
| --- | --- |
| `127.0.0.1` or `::1` | **Local only**: the service accepts connections from this NAS, not directly from another LAN device |
| `0.0.0.0` or `*` | **All interfaces**: it may accept connections on several network interfaces; firewall rules determine what is actually reachable |
| Specific LAN address | Service is bound to that address |
| Multicast address such as `239.x.x.x` | Often local network discovery traffic |

Common identifiers:

| Port | Typical use |
| --- | --- |
| UDP 323 | Chrony clock-control listener, commonly loopback-only |
| UDP 500 and 4500 | IPsec key negotiation/NAT traversal, often `charon` from strongSwan; **not WireGuard** |
| UDP 1701 | L2TP VPN transport |
| TCP/UDP 111, TCP 2049, TCP 20048 | RPC / Linux NFS file-sharing components |
| TCP 139/445 | SMB Windows/macOS file sharing |
| UDP 5353 | mDNS local discovery |
| TCP 3306 | Common MySQL/MariaDB database port |
| TCP 6379 | Common Redis port |

If Linux does not report an owning process, a port name is **only a likely service hint**. Confirm process ownership before stopping anything. Removing `charon`, Chrony or other operating-system services solely because they appear in the list can interrupt unrelated applications or recovery functions.

## User accounts, storage and quotas

**Users & Groups** contains separate **Users**, **Groups** and **Account Policies** pages. Only the selected subsection should be highlighted in v1.3.5.

Zero1Local shields reserved appliance-maintenance accounts from normal owner account editing. This does **not** mean those Linux identities, existing files or filesystem ownership were deleted.

Per-user quota configuration requires both compatible Main Storage filesystem/mount support and the `setquota` utility. If quotas are unavailable, read the capability message. Installing a quota tool alone does not enable user quotas on every filesystem; never force-remount or reformat a data volume to clear the warning.

## Network safety

Keep management, SMB/NFS, recovery and SSH access on a trusted LAN or appropriately segmented VLAN. Don't forward these services to the open Internet. Verify independent backups and a recovery path before making a disruptive network change.

For native NAS-to-NAS replication, use Zero1Local's built-in Replication. For cloud↔NAS sync, [Syncria](https://github.com/gigabytegrove/syncria) is an independent optional companion; it is not required for LAN mobile access.

[Back to Zero1Local](../README.md) · [Official v1.3.5 release](https://github.com/gigabytegrove/zero1local/releases/tag/v1.3.5)

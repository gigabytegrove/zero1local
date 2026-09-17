# Zero1Local v1.2.6.5 — WireGuard Fallback Packaging Correction

**Git tag:** `v1.2.6.5`  
**Status:** Pre-release / real-hardware qualification candidate

Zero1Local v1.2.6.5 is a focused correction based on live v1.2.6.4 testing on the Zero1 RK3568 appliance. The appliance's vendor kernel does not expose the native WireGuard link type and returns `Error: Unknown device type`. v1.2.6.4 correctly attempted to use the userspace fallback, but the fallback binary was not present on the appliance.

## WireGuard correction

v1.2.6.5 moves fallback provisioning into the release installation transaction instead of trying to mutate system packages from the hardened `zero1d` management daemon.

During installation, after both primary SSH and the independent emergency recovery path are verified, Zero1Local now:

- ensures `wireguard-tools` and `iproute2` are present;
- installs a pinned Linux/arm64 `wireguard-go` userspace fallback when it is absent;
- downloads and verifies the corresponding SHA-256 sidecar before installation;
- installs the fallback as `/usr/local/sbin/wireguard-go` before the hardened management service starts;
- fails the update transaction rather than activating a release that advertises a fallback it cannot execute.

The running `zero1d` service no longer attempts `apt` or system-binary installation from an API request. It only validates the already-installed backend.

Manual Remote Access VPN enablement and Zero1Connect managed remote provisioning now use the same readiness contract. If neither native nor userspace WireGuard can create a usable interface, the API returns HTTP 503 with `wireguard_backend_unavailable`.

## Preserved v1.2.6.x qualification work

This patch preserves the accepted v1.2.6.4 behavior for SMART self-test attachment/progress, RAID consistency progress and read-only-sysfs handling, Google Drive public-client OAuth flow, Phone Transfer, LAN Zero1Connect ACL behavior, analytics, recovery, and the independent Software Update Monitor.

## Hardware validation after installation

The immediate test sequence on the qualification NAS is:

1. Observe the v1.2.6.4 → v1.2.6.5 update with the corrected independent Update Monitor.
2. Confirm `wireguard-go` exists at `/usr/local/sbin/wireguard-go`.
3. Enable Remote Access VPN manually and confirm `wg-zero1` is created through the userspace backend when the kernel rejects the native link type.
4. Enable automatic Zero1Connect remote access and confirm peer provisioning plus an actual handshake.
5. Test Zero1Connect from a genuinely off-LAN connection.
6. Reboot and confirm the managed WireGuard configuration and Connect access recover.
7. Continue the remaining SMART-progress, RAID-consistency, and Google Drive sign-in hardware checks.

Phone Transfer has already been exercised successfully with two physical devices, and LAN Zero1Connect access has already been confirmed during this qualification campaign.

## Release asset

Public installation asset:

`Zero1Local-v1.2.6.5-production.zip`

SHA-256: `4f4c818f2f77c8c82ab8ef27fc582636e1acc55fc3bcd0ac4524c10ffc3bc28d`

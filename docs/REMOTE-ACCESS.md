# Remote Access

Zero1Local is LAN-first. Optional remote access is based on WireGuard when the required local tooling is present.

## Model

- appliance server keypair generated locally
- independent per-device keypairs
- revocable device addresses
- persisted/reconciled confirmed state after reboot
- QR output only when `qrencode` is available
- no Zero1Local cloud account required

Generated client policy is oriented toward reaching the NAS/LAN, not automatically turning the NAS into a full-tunnel Internet VPN.

## Security guidance

Prefer WireGuard or another private VPN path over public Internet exposure of ports 80, 8088, 8089, 139, 445 or NFS.

Never paste WireGuard private keys or complete client configurations into a public GitHub issue.

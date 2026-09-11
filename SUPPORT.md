# Zero1Local Support

This page explains how to get useful support for Zero1Local v1.2.2 without guessing at appliance state.

## Before opening an issue

1. Confirm the issue is reproducible on the current v1.2.2 release.
2. Check [Troubleshooting](docs/TROUBLESHOOTING.md) and [Known limitations](docs/KNOWN-LIMITATIONS.md).
3. Record what you expected, what actually happened and the exact sequence that triggered it.
4. Collect the smallest evidence set that proves the failure. See [Support evidence](docs/SUPPORT-EVIDENCE.md).
5. If an installation failed, include the exact `/var/log/zero1-local/install-*.log` referenced by the Windows installer.

## Never post these publicly

Do **not** paste any of the following into a public issue:

- `/var/lib/zero1-local/recovery.key`
- `/var/lib/zero1-local/github-token`
- OAuth tokens or cloud connector credentials
- SMTP passwords, notification tokens or webhook secrets
- WireGuard private keys or complete client configuration files
- SSH private keys
- Samba or administrator passwords

Redact public IP addresses and personal filenames if they are not needed to reproduce the problem.

## Good bug reports include

- Zero1Local version
- NAS model and architecture
- whether this was factory-stock, adopted or already running Zero1Local
- exact browser/OS for UI issues
- the screen/feature being used
- exact error text
- whether Recovery on TCP/8089 is reachable
- service status and relevant logs
- storage identity (`findmnt -T /disk0`) when the issue involves files/shares/storage
- `/proc/mdstat` when the issue involves RAID
- whether the issue affects both management endpoints (`:80` and `:8088`)

Use the repository's **Bug report** or **Support request** issue template so the evidence is consistent.

## Installation prerequisites

Before installation, back up or move important data off the NAS. For a factory-stock/unrooted IronCow Zero1, obtain the serial by scanning the QR code on the sticker on the bottom of the NAS and run the installer with `-Serial <NAS_SERIAL>`.

If stage 2 reports that direct root SSH is unavailable or shows a connection-refused SSH/banner error, use the factory-stock serial path rather than repeatedly retrying the IP-only command.

## Installation failures

Zero1Local's installer is transactional. If final verification fails, it attempts to restore the previous healthy release. The Windows console prints a NAS-side detailed log path such as:

```text
/var/log/zero1-local/install-YYYYMMDDTHHMMSSZ.log
```

Retrieve that exact log over root SSH. Do not substitute a different timestamp from another NAS.

## Recovery first

If the main UI is unavailable, check the independent Recovery Environment:

```text
http://<NAS-IP>:8089/
```

It uses the separate Recovery Key shown under **System → Recovery**. See [Recovery](docs/RECOVERY.md).

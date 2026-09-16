# Zero1Local Support

## Before requesting help

Record the installed Zero1Local version and the exact behavior you see. When possible, include the relevant page, action, timestamp, and exact error message.

For update failures, preserve the update transaction ID and its update-apply log. Zero1Local's staged updater and rollback path are designed to leave evidence about the exact stage that failed.

For general diagnostics, **System → Advanced Stats** can provide performance/history information and a sanitized support bundle. Feature checks are intentionally kept there rather than spread across the normal product UI.

## Useful information to include

- Zero1Local version;
- whether this is the supported Zero1 NAS / RK3568 platform;
- whether the issue occurs after a fresh page load as well as normal navigation;
- exact error text;
- whether the operation changes storage, files, network, or remote access;
- the smallest reproducible sequence of actions.

Do **not** post passwords, API tokens, pairing tokens, recovery keys, SSH private keys, WireGuard private keys, or private user files.

## Common locations

- **Updates:** System → Updates
- **Access / SSH / API:** System → Access & API
- **Security:** System → Security
- **Restart history / feature checks:** System → Advanced Stats
- **Recovery service:** System → Recovery
- **Phone Transfer:** Sync & Backup → Phone Transfer
- **Zero1Connect:** Zero1Connect → Overview / Devices & Access / Remote Access
- **RAID maintenance / drive replacement:** Storage → RAID

## Pre-release builds

Pre-release builds should be validated on a test appliance before deployment to additional NAS units. A successful compile/package validation is not a substitute for real-hardware qualification.

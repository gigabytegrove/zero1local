# Zero1Local Support

## Before requesting help

Record the installed Zero1Local version and exact behavior. When possible, include the relevant page, action, timestamp, and exact error message.

For update failures, preserve the update transaction ID and update-apply log. Zero1Local's staged updater and rollback path are designed to leave evidence about the exact stage that failed.

For general diagnostics, **System → Advanced Stats** provides performance/history information and support diagnostics. Feature checks are intentionally kept there or under workflow-specific Advanced disclosures rather than spread across normal owner pages.

## Useful information to include

- Zero1Local version;
- whether this is the supported Zero1 NAS / RK3568 platform;
- exact page/workflow and error text;
- whether the issue occurs after a fresh page load as well as normal navigation;
- whether the operation changes storage, files, network, recovery, or remote access;
- smallest reproducible action sequence.

Do **not** post passwords, API tokens, pairing tokens, recovery keys, SSH private keys, WireGuard private keys, or private user files.

## Common locations

- **Updates:** System → Updates
- **Access / SSH / API:** System → Access & API
- **Security:** System → Security
- **Restart history / feature checks:** System → Advanced Stats
- **Recovery:** System → Recovery
- **Phone Transfer:** Sync & Backup → Phone Transfer
- **Zero1Connect:** Zero1Connect → Overview / Devices & Access / Remote Access
- **RAID maintenance / drive replacement:** Storage → RAID
- **Analytics:** Storage → Analytics
- **Office:** System → Office

## Public repository

The GitHub repository publishes documentation, support/security information, branding, and production release packages. Implementation source code is maintained privately/off-GitHub, so public support requests should focus on reproducible product behavior rather than requesting source-tree paths or build instructions.

## Pre-release builds

Pre-release builds should be validated on a test appliance before deployment to additional NAS units. A successful compile/package validation is not a substitute for real-hardware qualification.

# Zero1Local v1.2.6 — Product UX, Phone Transfer & Zero1Connect Update

**Git tag:** `v1.2.6`  
**GitHub status:** **Pre-release**

## Release notes

Zero1Local v1.2.6 is a substantial pre-release update focused on product organization, recovery behavior, Phone Transfer, storage maintenance, Analytics, and Zero1Connect integration.

### Product organization and UI/UX

- Reorganized the UI around clear owner workflows instead of broad catch-all categories.
- Reduced redundant cross-linking and unnecessary stacked/nested card presentation.
- Moved implementation/feature-check material behind Advanced disclosure controls.
- Moved Office to System.
- Added System → Access & API for browser sessions, SSH administration, and API credentials.
- Kept Security focused on actual security policy and exposure.
- Moved restart history into Advanced Stats.
- Renamed Multi-App Setups / Compose Stacks to Docker Compose.
- Restored Network Segments terminology to VLANs and removed Local resolver path from the normal Network display.

### Recovery and repeated notices

- Recovery verification is optional and defaults to off.
- Disabled recovery verification no longer affects protection scores or creates verification reminders.
- No-source verification returns: `No recovery source was available to verify.`
- Recurring advisory notices can be dismissed, snoozed, or ignored so they stay out of Action Center until restored or their suppression expires.

### Storage

- Fixed RAID Check consistency writes to `/sys/block/.../md/sync_action` so the existing sysfs control is opened for writing without create/truncate semantics.
- Integrated drive replacement into the RAID workflow and retired the separate Replace Drive page from primary navigation.
- Expanded Analytics with file-type counts/storage visualization, capacity trend, share usage, largest files, and duplicate candidates.

### Phone Transfer

- Standardized the owner-facing name to Phone Transfer.
- Phone Transfer is now a dedicated Sync & Backup section.
- Reworked the page into an approximately 80/20 desktop workspace: phones/rules on the left, guidance/manual-transfer information on the right.
- Moved Phone Transfer feature checks behind Advanced disclosure.

### Zero1Connect

- Zero1Connect is now a first-class top-level product section.
- Added dedicated Devices & Access and Remote Access views.
- Added per-device mobile access assignments and permission presets.
- Normal pairing attempts to provision managed WireGuard automatically.
- Zero1Local can install missing `wireguard-tools` and `iproute2` for managed Zero1Connect remote access.
- Manual WireGuard setup is not intended to be part of the normal scan-QR-and-connect workflow.

### Routing and branding

- Retains three-way direct-refresh route parity validation between the frontend, packaged route manifest, and actual Go route handler.
- Uses the supplied transparent theme-correct Zero1Local logos and the supplied Zero1Connect integration logo.

## Qualification status

This remains a **pre-release**. The qualification target is the Zero1Local test appliance. Do not treat v1.2.6 as production-qualified until the current server release and Zero1Connect Android client have completed real-device testing.

The accepted v1.2.4.27 Windows installer remains byte-for-byte unchanged.

## GitHub publication boundary

The public repository contains documentation/branding and production release material. **Implementation source code is maintained privately/off-GitHub.**

### GitHub Release asset

Upload this installation asset to the v1.2.6 GitHub Release:

```text
Zero1Local-v1.2.6-production.zip
```

SHA-256:

```text
adcaa2d4a493dd25de6973a3b01536b572202063be2b8978ca2c51a0c05f8c3f
```

Do **not** upload `Zero1Local-v1.2.6-source.tar.gz` or private source/build workspaces to GitHub. Documentation files and branding are committed to the repository as normal files rather than attached as source release artifacts.

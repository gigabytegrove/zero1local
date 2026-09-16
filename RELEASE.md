# Zero1Local v1.2.6.2 — WireGuard Backend Qualification Gate

**Git tag:** `v1.2.6.2`  
**GitHub status:** **Pre-release**

## Release notes

Zero1Local v1.2.6.2 is the corrective release candidate built on v1.2.6.1 after real-device evidence proved that installed WireGuard userspace tools did not necessarily mean the NAS kernel could create a WireGuard interface.

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

### WireGuard backend qualification correction

- Replaces binary-presence detection with a live temporary backend probe that creates a WireGuard interface, configures a private key, brings the interface up, verifies it through `wg show`, and removes it.
- `features.wireguard` and `managed_remote_access` are true only when that backend probe succeeds.
- The real `.145` failure signature `Error: Unknown device type` is covered by regression tests and must result in the feature being unavailable rather than falsely advertised.
- Managed WireGuard provisioning returns `wireguard_backend_unavailable`; the dedicated device provisioning path returns HTTP 503 for this condition.
- LAN pairing remains usable even if remote setup cannot be completed.
- Manual Remote Access enable and managed retry also return structured HTTP 503 when the backend is unavailable.
- `applyWireGuard` now fails on address-assignment errors, reports activation failures with context, and cleans up newly-created partial interfaces.
- The production qualifier independently probes the backend and verifies that Connect advertises the same truth. Strict qualification also requires a usable backend before managed off-LAN access can be promoted.

### Zero1Connect corrections

- Treats authenticated `root` as the master appliance administrator throughout Zero1Connect.
- Removes the parallel Zero1Connect file-permission authority. Mobile file access now derives directly from the native Zero1Local shared-folder valid/read and write ACLs used by Files & Sharing.
- A phone paired to `root` receives master native shared-folder access; other phones can never exceed their bound Zero1Local user's current rights.
- Legacy prerelease scope IDs remain compatibility aliases only; their old stored permission flags are ignored.
- Pairing now asks on the NAS whether the owner wants automatic remote access or LAN-only pairing. The pairing intent is stored with the single-use token, while current Android clients may also explicitly confirm/change the choice.
- When remote access is enabled, Zero1Local installs/reconciles WireGuard, keys, peer, tunnel address, split routes and firewall state automatically.
- Removes the dead-end owner-facing `Not configured` state. Remote state is Automatic setup, Ready, Needs attention, or Off by choice.
- Fixes missing Zero1Connect status/layout styles that caused labels and values to run together.

### Routing and branding

- Retains three-way direct-refresh route parity validation between the frontend, packaged route manifest, and actual Go route handler.
- Uses the supplied transparent theme-correct Zero1Local logos and the supplied Zero1Connect integration logo.

## Qualification status

This remains a **pre-release**. The qualification target is the Zero1Local test appliance. Do not treat v1.2.6.2 as production-qualified until the current server release and Zero1Connect Android client have completed real-device testing.

The accepted v1.2.4.27 Windows installer remains byte-for-byte unchanged.

## GitHub publication boundary

The public repository contains documentation/branding and production release material. **Implementation source code is maintained privately/off-GitHub.**

### GitHub Release asset

Upload this installation asset to the v1.2.6.2 GitHub Release:

```text
Zero1Local-v1.2.6.2-production.zip
```

SHA-256:

```text
f15f10c863e8764263e2e8fd57d5f2fecc726a18ba4508af957aeff0d975dcbf
```

Do **not** upload `Zero1Local-v1.2.6.2-source.tar.gz` or private source/build workspaces to GitHub. Documentation files and branding are committed to the repository as normal files rather than attached as source release artifacts.

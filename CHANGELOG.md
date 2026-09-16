# Zero1Local Changelog

## v1.2.6 — Pre-Release

v1.2.6 is a product-organization, UX, recovery, storage-maintenance, Phone Transfer, Analytics, and Zero1Connect integration release. It is intended for real-hardware qualification before promotion.

### UI / UX and information architecture

- Reorganized the primary product areas around owner tasks: Home, Files & Sharing, Storage, Sync & Backup, Zero1Connect, Apps, Connectivity, and System.
- Reduced unnecessary nested and stacked card presentation; related information is grouped into shared sections and repeated entities are presented as rows/lists.
- Reduced redundant cross-linking between pages so the application navigation and section tabs are the primary way to move between major workflows.
- Moved developer/qualification-oriented checks behind **Advanced** or **Feature checks** disclosure controls rather than placing them front and center.
- Moved restart history to **System → Advanced Stats**.
- Added **System → Access & API** as the central location for browser sessions, SSH administration, and API credentials instead of treating those items as general Security settings.
- Kept **Security** focused on sign-in protection, certificates, firewall policy, and exposure.
- Moved **Office** from Files & Sharing to **System**.
- Renamed Docker **Multi-App Setups / Compose Stacks** to **Docker Compose**.
- Renamed Network **Network Segments** to **VLANs**.
- Removed the unnecessary **Local resolver path** field from the owner-facing Network display.
- Preserved compatibility aliases for older deep links where appropriate without keeping obsolete workflows in primary navigation.

### Branding

- Uses the supplied Zero1Local light and dark artwork as theme-specific branding.
- Uses transparent, tightly cropped assets so the logo does not carry a black/white background block into the opposite theme.
- Renders one theme-selected Zero1Local logo per branding surface.
- Uses the supplied Zero1Connect artwork only inside the Zero1Connect integration experience.

### Recovery verification

- Recovery verification is optional and defaults to disabled.
- Disabled verification does not lower protection scores or create verification-driven reminders.
- Verification controls and history live under an Advanced optional section in Restore Center.
- A verification attempt with no usable source now returns the exact error/summary:
  `No recovery source was available to verify.`
- Added regression coverage for the exact no-source behavior.

### Notifications and repeated advisories

- Existing persistent notification states are exposed consistently for dismiss, snooze, ignore, and restore behavior.
- Dismissed/ignored/snoozed notices stay out of Action Center while suppressed.
- Advisory notices such as no-backup and no-UPS recommendations can be suppressed when the owner does not want repeated reminders.

### Storage and RAID

- Fixed RAID **Check consistency** so the kernel `sync_action` sysfs control node is opened as an existing writable control file rather than using create/truncate semantics that can fail with `read-only file system`.
- Added regression coverage for the sysfs-control write behavior.
- Retired the separate **Replace Drive** page from primary navigation.
- Integrated replacement-drive selection and rebuild initiation into the RAID workflow.
- RAID maintenance/implementation details are kept under Advanced disclosure instead of being presented as separate owner workflows.

### Phone Transfer

- Standardized the product name to **Phone Transfer** across the owner-facing UI and current documentation.
- Promoted Phone Transfer to its own section inside **Sync & Backup**.
- Reworked the page into an approximately 80/20 desktop layout:
  - left: connected phones and automatic transfer rules;
  - right: automatic-transfer guidance, manual-transfer guidance, connection help, and advanced feature checks.
- Moved Phone Transfer qualification/check data behind **Feature checks**.
- Retained compatible internal `/api/mobile-offload` endpoints while removing the old owner-facing Phone Offload terminology.

### Storage Analytics

- Added/expanded file-type storage visualization.
- Shows the number of discovered file types and scanned-file count.
- Added capacity-trend visualization.
- Added share-usage bars, largest-file reporting, and duplicate-candidate reporting.
- Keeps scan implementation details under Advanced.

### Zero1Connect

- Promoted **Zero1Connect** to its own top-level product section.
- Added dedicated Overview, Devices & Access, and Remote Access views.
- Added per-device mobile access assignments that can target a whole shared folder or a folder root.
- Added permission presets and server-side scope/permission enforcement support for paired devices.
- Pairing retains the Android P-256 authentication key and per-device WireGuard public key model.
- Successful pairing attempts managed WireGuard provisioning automatically.
- Zero1Local can install missing `wireguard-tools` and `iproute2` when managed Zero1Connect remote access requires them.
- Existing paired devices are reconciled against managed remote-access state after service start/restart.
- Manual WireGuard configuration is not intended to be a prerequisite for a normal Zero1Connect phone pairing flow.
- LAN pairing may remain usable when an external endpoint cannot be established; the remote-access failure is reported rather than faked as successful.

### Routing and session behavior

- Preserves the v1.2.5.5 direct-refresh fix that synchronized frontend SPA routes, packaged route manifest, and the Go server route allowlist.
- Release tests exercise the actual Go UI route handler for the packaged route set, preventing authenticated direct-refresh pages from silently regressing to raw `404 page not found` responses.

### Release engineering

- Version advanced to 1.2.6 for the new feature/organization push.
- The accepted v1.2.4.27 `Install-Zero1Local.ps1` remains byte-for-byte unchanged.
- The public production archive retains the established five-file root layout.
- Complete source and GitHub documentation/branding bundles are produced alongside the production package.

### Qualification status

- v1.2.6 remains a **pre-release** until it passes real-hardware qualification on the designated test appliance.
- Zero1Connect integration remains subject to end-to-end qualification with the current Android client, including LAN pairing, assigned mobile access, managed WireGuard provisioning, off-LAN access, transfer operations, revocation, and persistence across reboot/update.

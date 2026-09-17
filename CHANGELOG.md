# Zero1Local Changelog

## v1.2.6.7 — Zero1Connect LAN discovery / Omada UPnP correction

Real-hardware qualification confirmed the Omada gateway has UPnP enabled for the NAS Management network while Zero1Local still reported no UPnP IGD, and a fresh Zero1Connect client could neither reach the NAS from the pairing QR nor find it under Nearby devices.

- Pairing QR/deep links now prefer the numeric NAS IPv4 address on the browser client's subnet instead of copying the browser hostname.
- Pairing fails with `lan_address_unavailable` rather than emitting an endpoint Zero1Local cannot identify as a LAN IPv4 address.
- Adds a packaged `_zero1local._tcp` Avahi service and requires active `avahi-daemon` before mDNS is reported as Running.
- Reconciles Avahi at runtime and adds installer/rollback handling for the Connect advertisement.
- Expands SSDP discovery across every active IPv4 LAN interface with interface-bound multicast, two request rounds, five-second parallel discovery, IGD v1/v2, WANIPConnection v1/v2, WANPPPConnection, root-device and `ssdp:all` targets.
- Replaces the misleading no-IGD message with interface-specific SSDP diagnostics when the router still cannot be discovered.
- Preserves the proven userspace WireGuard fallback and the v1.2.6.6 stale-binary anti-regression gates.

## v1.2.6.6 — stale-binary packaging correction

v1.2.6.5 is rejected and must not be deployed. Real-hardware installation on three appliances proved that its source/runtime metadata was labeled 1.2.6.5 while both shipped ARM64 service binaries were still the v1.2.6.4 executables. The installer correctly detected the health-version mismatch and rolled back.

v1.2.6.6 rebuilds both service binaries from the current source and adds permanent binary-identity gates. Exact release-tree verification now requires the VERSION string to be embedded in both packaged binaries, and the NAS installer executes both staged candidates with `--version` before quiescing the active management service. A stale or mismatched binary therefore fails before release handoff.

Real-hardware evidence also confirms the release-installed ARM64 `wireguard-go` userspace fallback can create a TUN interface on the RK3568 vendor kernel when the native `ip link ... type wireguard` path returns `Unknown device type`.


## v1.2.6.6 — Pre-Release

v1.2.6.6 is a focused WireGuard fallback packaging correction based on live v1.2.6.4 hardware evidence. The target RK3568 vendor kernel rejects native WireGuard interface creation with `Error: Unknown device type`, and the v1.2.6.4 runtime correctly attempted the userspace path but could not find `wireguard-go`.

- Moves userspace WireGuard fallback installation out of the hardened `zero1d` API process and into the recovery-safe release installation transaction.
- Installs the fixed Linux arm64 `wireguard-go` fallback before `zero1d` starts, after primary and emergency SSH recovery paths are proven.
- Downloads both the pinned fallback archive and its SHA-256 sidecar and refuses installation when verification fails.
- Removes runtime package-manager mutation from `zero1d`; the service now reports a clear installation/backend error rather than attempting `apt` under `ProtectSystem=true`.
- Makes manual Remote Access VPN enablement use the same backend-readiness gate and structured `503 wireguard_backend_unavailable` response as managed Zero1Connect provisioning.
- Preserves all v1.2.6.4 SMART, RAID consistency, Google Drive, Phone Transfer, LAN Zero1Connect, and Update Monitor behavior.

## v1.2.6.4 — Pre-Release

v1.2.6.4 is a targeted hardware-qualification correction based on live v1.2.6.3 testing. It preserves the accepted update-monitor behavior, Phone Transfer behavior, LAN Zero1Connect behavior, and existing 1.2.6.x architecture.

### Drive diagnostics

- Detects an already-running SMART self-test before attempting to start another test.
- Treats smartctl's existing-test condition as attachable state instead of a generic start failure.
- Adds a dedicated live SMART-test status API with percent complete / percent remaining reporting.
- Adds automatic progress polling on the Drives page and disables duplicate test starts while a drive test is active.
- Never forces or aborts an existing drive self-test just to satisfy a UI action.

### RAID consistency

- Adds a live RAID consistency status API using md `sync_action`, `sync_completed`, and `mismatch_cnt`.
- Adds visible progress and automatic polling to the RAID page.
- Handles the vendor image's read-only `/sys` mount by temporarily remounting sysfs read-write only for the validated md `sync_action` write, then immediately restoring read-only state.
- Reuses the same safe start path for scheduled RAID maintenance.

### Zero1Connect remote access

- Preserves native in-kernel WireGuard as the preferred backend.
- Adds automatic `wireguard-go` userspace fallback when the vendor kernel returns `Error: Unknown device type`.
- Managed provisioning can install `wireguard-go` automatically when the kernel backend is unavailable.
- Capability probing validates the userspace fallback with the same create/configure/activate/verify/cleanup contract before advertising remote access.

### Google Drive authorization

- Corrects Google Drive OAuth to match the product's installed/public-client device-flow design.
- Removes the incorrect requirement for a per-NAS Google OAuth client-secret file.
- Uses the built-in Zero1Local Google client ID for device authorization; an explicitly configured client secret remains optional rather than mandatory.

## v1.2.6.3 — Pre-Release

v1.2.6.3 is a focused Update Monitor owner-experience correction based on live v1.2.6.2 in-place update testing. It preserves the v1.2.6.2 WireGuard qualification gate and all existing 1.2.6.x behavior.

### Update Monitor branding and time

- Replaces the temporary `Z1` tile/text treatment with the canonical Zero1Local light/dark logo assets.
- Removes owner-facing implementation copy about read-only/admin-session behavior.
- Converts persisted UTC/RFC3339 update timestamps to the browser owner's local time zone with local time-zone labeling.
- Passes the current light/dark theme from the main Zero1Local UI into the independent monitor during update handoff.

### Visible activity and power-loss protection

- Adds a continuously visible working badge/spinner during active update transactions.
- Adds an animated determinate progress track so a stable percentage still has visible motion.
- Adds an active-step spinner/pulse in the seven-stage update timeline.
- Adds a live status-refresh heartbeat and continuously updating elapsed update time.
- Explicitly warns not to power off or unplug the NAS while updating, and explains that install/restart can remain at one percentage for several minutes.
- Adds a distinct reconnecting state that continues to warn against power interruption while the monitor retries.

### Regression protection

- Extends web capability validation to require canonical monitor branding, browser-local time formatting, activity/heartbeat fingerprints, and theme-aware monitor handoff.
- Rejects the old temporary tile, old administrator-session subtitle, and raw UTC timestamp rendering.
- Keeps the independent monitor status-only: GET/HEAD status and canonical logo assets only; mutation methods remain rejected.

## v1.2.6.2 — Pre-Release

v1.2.6.2 closes the WireGuard backend truth gap found during v1.2.6.1 qualification. Installed `wg` and `ip` commands are no longer treated as proof that the NAS can actually create and operate a WireGuard interface.

### WireGuard backend readiness

- Adds a live temporary backend probe: generate a temporary key, create a WireGuard interface, apply the key, activate the interface, verify it with `wg show`, and remove it.
- Caches normal capability probe results briefly while forcing a fresh probe for provisioning/retry operations.
- Gates Zero1Connect `features.wireguard` and `managed_remote_access` on the live backend result.
- Preserves the real `Error: Unknown device type` failure evidence in diagnostics and regression coverage.
- Returns structured `wireguard_backend_unavailable` failures and HTTP 503 on the dedicated provisioning path when the kernel/backend cannot create or configure the interface.
- Keeps LAN pairing usable when automatic remote access cannot be established.

### Runtime hardening

- `applyWireGuard` now checks address assignment instead of silently ignoring it.
- Newly-created WireGuard interfaces are removed when configuration or activation fails, preventing partial runtime state.
- Browser API error handling now displays structured backend error messages correctly.

### Production qualification

- Adds an independent real-hardware WireGuard backend probe to `scripts/qualify-production.sh`.
- Qualification compares the independent probe result with `/api/connect/v1/capabilities` and fails on any truth mismatch.
- Strict production qualification also fails when no usable WireGuard backend exists, because managed off-LAN Zero1Connect cannot be end-to-end qualified on that runtime.

## v1.2.6.1 — Pre-Release

v1.2.6.1 is a corrective pre-release based on live v1.2.6 appliance testing. It keeps the v1.2.6 product reorganization while correcting Zero1Connect authorization, pairing/remote-access behavior, and presentation.

### Zero1Connect administration and native ACL

- Treats authenticated `root` as the master appliance administrator for Zero1Connect management.
- A phone paired to `root` receives full native shared-folder read/write authority.
- Removes the parallel Zero1Connect file-permission authority introduced during the prerelease integration work.
- Mobile file access is now derived from the same native Files & Sharing shared-folder ACL used elsewhere in Zero1Local: valid/read users determine read/download rights and write users determine mutation rights.
- Legacy prerelease mobile scope IDs are accepted only as aliases to the underlying shared folder; their old stored permission flags cannot expand current native rights.
- Devices & Access is now an effective-access view with a direct path to manage the authoritative shared-folder permissions.

### Automatic remote access

- Pairing asks whether the owner wants **Set up remote access** or **Pair LAN only**.
- The NAS records that choice in the single-use pairing intent. A current Android client may explicitly confirm/change it in `/pair/complete`; older compatible clients inherit the NAS-side choice.
- Automatic remote access remains the compatibility default when no explicit choice is supplied.
- Zero1Local continues to install/reconcile required WireGuard tooling, server identity, peer, address, split routes, firewall state and endpoint discovery automatically.
- Replaces the ambiguous/dead-end `Not configured` presentation with Automatic setup, Ready, Needs attention, or Off by choice.
- If router/NAT conditions prevent automatic endpoint establishment, the UI explains the remaining network action without asking the owner to manually build a WireGuard tunnel.

### UI correction

- Adds the missing Zero1Connect metric/status layout styles so labels, values and supporting text no longer run together.
- Makes root/master and native shared-folder permission source explicit in the owner-facing interface.

### Security and regression coverage

- Preserves per-request authorization against the current native share ACL rather than trusting cached/stored mobile permission flags.
- Preserves path confinement and adds/retains coverage for slash, backslash and encoded traversal attempts.
- Keeps the v1.2.6 public-repository policy: production releases and documentation/branding are public; source archives remain local/private and off GitHub.

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

### Documentation and public repository

- Refreshed the complete public `docs/` set for the v1.2.6 information architecture and terminology.
- Added `docs/README.md` as the documentation index.
- Corrected Zero1Connect documentation to reflect its new top-level product section.
- Removed obsolete v1.2.2/v1.2.4 transition-era update documentation from the current owner guides while preserving the current updater/rollback architecture.
- Removed broken documentation links and consolidated duplicated File Manager image documentation.
- Corrected documentation provenance to accurately disclose AI-assisted work in documentation and portions of design/implementation/review.
- Documented the public-repository boundary: GitHub carries documentation, branding, support/security material, and production releases; implementation source remains privately maintained/off-GitHub.

### Release engineering

- Version advanced to 1.2.6 for the new feature/organization push.
- The accepted v1.2.4.27 `Install-Zero1Local.ps1` remains byte-for-byte unchanged.
- The public production archive retains the established five-file root layout.
- Complete source and GitHub documentation/branding bundles are produced alongside the production package.

### Qualification status

- v1.2.6 remains a **pre-release** until it passes real-hardware qualification on the designated test appliance.
- Zero1Connect integration remains subject to end-to-end qualification with the current Android client, including LAN pairing, assigned mobile access, managed WireGuard provisioning, off-LAN access, transfer operations, revocation, and persistence across reboot/update.

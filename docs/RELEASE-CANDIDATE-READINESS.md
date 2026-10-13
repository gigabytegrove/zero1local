# Zero1Local v1.3.0 — beta release and Stable promotion gate

**Current status after failed hardware attempt (2026-10-13):** The user attempted the v1.3.0 dashboard upgrade. It reached the install/restart steps but the updater reported a failed installer at final verification and rollback was available. The exact failure must be taken from `/var/lib/zero1-local/update-apply-*.log`; the screenshot alone does not identify the failing health gate. The v1.3.0 GitHub prerelease and all 37 historical releases/tags have now been **deleted by explicit owner request**. There are currently **zero** published GitHub Releases. Do not republish v1.3.0 until the logged installer cause is fixed and the exact corrected artifact is qualified.


Updated October 13, 2026.

## Verified distribution status

- **Stable:** [v1.2.9.15](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.15). This older binary still contains the retired native Google Drive implementation.
- **Beta / Release Candidate:** [v1.3.0](https://github.com/gigabytegrove/zero1local/releases/tag/v1.3.0) — **published and downloadable** as a GitHub prerelease. It has **NOT** been promoted to Stable or qualified on physical NAS hardware.
- **Official update asset:** [Zero1Local-v1.3.0-production.zip](https://github.com/gigabytegrove/zero1local/releases/download/v1.3.0/Zero1Local-v1.3.0-production.zip).
- **Release ZIP SHA-256:** `986a1a5ec2a906fe23d94e796fa50203339f4851701ebc79d1f082fc708604c2` (8,194,795 bytes).
- **Source repository:** private [gigabytegrove/zero1local-source](https://github.com/gigabytegrove/zero1local-source), branch `main`, exact import commit `6d2d39db4476a32a7348f6a821f0891ab583d8fe`.
- **Source completeness:** all 196 archive source files were independently compared byte-for-byte with corresponding Git blob SHAs on private `main`; the repository also retains four management files.

The recovered **v1.2.9.12 source archive** was sanitized and used as the baseline for v1.3.0. The intervening original v1.2.9.13–v1.2.9.15 source tree was not recovered; changes specific to those versions must not be implied to have been merged. The original archive contained a historical OAuth client secret; the v1.3 source import underwent credential-signature checks. Provider-side rotation of any historical exposed credential should still be evaluated.

## Product scope

| Area | v1.3.0 disposition |
| --- | --- |
| Storage health/RAID, users and groups, SMB/NFS and shares, File Manager, USB, local backup/restore/replication, applications/containers, updates/rollback, recovery and hardware controls | Retained in source and package; hardware regression testing outstanding |
| Native Google Drive OAuth, jobs, sync workers, UI and API | Removed from v1.3 candidate, including known runtime markers |
| Syncria | **Coming soon** informational reference only; no dependency or working integration in this release |
| Zero1Connect and experimental remote bootstrap, enrollment, UPnP/mappings and managed tunnels | Removed/disabled from normal production UI and APIs in candidate; physical firewall/router state must be inspected |
| Kernel, bootloader and Debian 13 migration | Not part of this management-plane release; continue segmentation |
| Zero1Local-ix2 ARMv5 | Separate hardware product/release track |

## Engineering and distribution checks completed

- [x] Go unit/race tests and `go vet ./...` passed on prepared candidate.
- [x] ARM64 Go management daemon and recovery service compiled; JavaScript/shell syntax and service contracts checked.
- [x] SPA route manifest/UI validation checked 62 routes.
- [x] Static packaged runtime audit scanned 81 files and returned `STATIC_PASS_NEEDS_SOURCE_AND_HARDWARE_TESTS`, with zero detectable native Google Drive markers.
- [x] Full sanitized source imported to private `main` with 196/196 byte-identical file verification.
- [x] Exact candidate ZIP transferred without committing the production binary into public Git history.
- [x] [Publication workflow](https://github.com/gigabytegrove/zero1local/actions/runs/38407090364) reconstructed the ZIP, validated its exact size and SHA-256, created the GitHub v1.3.0 **prerelease**, and independently downloaded the published asset and verified the same SHA-256.
- [x] All older release pages, assets and associated tags, and failed v1.3.0 prerelease, withdrawn per owner request; **no installer is currently published**.

**These checks permit Beta publication, not a Stable promotion.** Static scanning cannot prove absence of dynamically assembled routes, credentials, functionality, or real-world regressions.

## Required physical NAS qualification before Stable promotion

- [ ] Independently back up and restore-test owner data and NAS configuration before upgrade testing.
- [ ] Capture installed version, model, storage health, mount guards, RAID, SMART, shares, ACLs, and service health before installing.
- [ ] Test the **exact published v1.3.0 ZIP** using **System → Updates → Advanced → Beta / Release Candidate → Check now** on a designated nonproduction Zero1 NAS.
- [ ] Confirm upgrade preserves storage mounts, shares/users/groups/ACLs, data, local backups/restore, replication, applications/Docker data, network segmentation and access to the management UI.
- [ ] Confirm recovered appliance status and logs after reboot/cold boot, update status monitor and Recovery Key/emergency access.
- [ ] Test rollback and failed-update recovery on a **disposable test target** with a verified off-device backup.
- [ ] Confirm old native Google Drive jobs cannot initiate sync/delete operations; old OAuth configuration does not trigger transfers; existing local backup and restore remain functional.
- [ ] Probe disabled Google OAuth/Zero1Connect APIs directly, not only through the UI. Confirm no new public listeners or Zero1Local-managed UPnP, router mapping, WireGuard or tunnel services; check external router state separately.
- [ ] Confirm client routes refresh directly, login/authz and narrow-screen UI work in both themes.
- [ ] Confirm normal NAS functions on its segmented VLAN and with no general Internet access (except what the owner explicitly permits for updates).
- [ ] Record hardware test and rollback evidence against the **published** ZIP, not a local near-equivalent build.

Only after this gate is complete: explicitly promote the tested version to Stable and consider retiring the `v1.2.9.15` asset. Do not silently retag, mutate an existing ZIP/checksum or delete the last Stable installer in advance.

## Historical baseline risk

A separate [v1.2.9.15 audit](https://github.com/gigabytegrove/zero1local/actions/runs/38388257044) downloaded the existing Stable ZIP and found legacy native Google Drive references in the ARM64 Go daemon, web JavaScript and CSS, helper script and manifest. That is why the Stable binary cannot be described as sanitized. The older 36 superseded asset withdrawals are documented in [the retirement register](LEGACY-RELEASE-RETIREMENT.md).

## Ongoing release control

The public repository owns production ZIPs, checksum verification, GitHub Release notes and the update feed; the private source repository owns editable Go source, web code and tests. Neither the private source archive nor credential-bearing source may be published as a public asset. The in-app updater must continue to accept the exact versioned five-file package layout and honor Stable versus Beta release eligibility.

Related tracker: [Google Drive retirement issue #2](https://github.com/gigabytegrove/zero1local/issues/2), [Zero1Connect production restrictions issue #3](https://github.com/gigabytegrove/zero1local/issues/3).

# Zero1Local production promotion gate — October 13, 2026

**Release status: BLOCKED.** The latest downloadable release is `vredacted.invalid`; it still contains the retired native Google Drive implementation and experimental Zero1Connect/tunnel controls. Its original private Go source/build workspace has not been located in the available connected repositories or conversation files, so **there is no defensible way to publish a verified clean production binary in this audit session**. Do not promote a documentation-only commit as a new Zero1Local version.

## Product scope for the next mainline release

| Area | Release disposition |
| --- | --- |
| Storage, drive health, RAID, users, groups, shares, SMB/NFS, File Manager, recovery, update/rollback, local backup and replication, Task Center, hardware controls, notifications | Retain and verify on actual supported hardware |
| Native Google Drive OAuth, credentials, jobs, sync workers, settings, web routes | **Remove completely** from implementation; not merely hide |
| Syncria | **Coming soon** informational companion only; no nonfunctional installation/connection controls or required dependency |
| Zero1Connect, auto router mapping, bootstrap HTTP(S), managed WireGuard/tunnels | Experimental/developer-only, **off by default**; disable public listener/mapping creation and public API registration until proven; never rely on UI hiding alone |
| Kernel, bootloader and Debian 13 migration | Out of current management-plane promotion scope; security limitation documented explicitly; keep appliance segmented |
| Zero1Local-ix2 | Separate ARMv5 hardware release track; same quality bar, only supported lightweight features |

## Source and build prerequisites

A release owner must identify a **complete private source tree** corresponding to the published 1.2.9.x Go daemon and recovery service, including its tests and build scripts; it must remain **outside** the public documentation/distribution repository.

- [ ] Source identified and its provenance recorded privately.
- [ ] Perform a minimal feature-removal change, rather than a rewrite, preserving unrelated implementation.
- [ ] `go test ./...`, `go vet ./...`, target-platform builds, JavaScript/shell syntax checks, and security regression tests pass.
- [ ] Confirm no native Google Drive handlers, background jobs, application OAuth credential constants, account/mapping UI, API routes, or packaged runtime assets remain.
- [ ] On upgrades, preserve NAS data and backups. Disable old Google Drive jobs safely; do not propagate remote deletions. Old refresh tokens/config may require explicit user-approved cleanup, not silent deletion.
- [ ] Zero1Connect experimental mode is disabled by default and cannot publish ports or run enrollment/tunnel APIs in production. Developer access must require server-side authorization, optional allowlisted IP/CIDR and owner-controlled opt-in. Verify direct requests fail when disabled, regardless of browser UI.
- [ ] Confirm the new core UI works directly, including refreshing each route, sessions and permissions, in both themes and on narrow viewports.

## Binary package gate

The public repository includes [a fail-closed static package verifier](../.github/scripts/verify-production-package.py), [synthetic regression tests](../.github/scripts/test-verify-production-package.py) and [a GitHub Actions production ZIP audit](../.github/workflows/production-package-audit.yml).

For a freshly built **candidate** with a versioned `Zero1Local-v<version>-production.zip`:

```bash
python3 .github/scripts/test-verify-production-package.py
python3 .github/scripts/verify-production-package.py \
  Zero1Local-v<VERSION>-production.zip --version <VERSION> \
  --json-out zero1local-static-gate.json
```

This checks outer archive identity, file checksums, unsafe archive members, ARM64 runtime identity and known native Google Drive markers in executable/runtime files. **A static pass is insufficient for release approval**. The source test and real-hardware checklists remain mandatory because compiled behavior can be dynamically constructed or bypass simple string scans.

## Appliance qualification gates (before stable publication)

- [ ] Capture current version and health from each test unit. Back up all owner data independently before any installer/storage test.
- [ ] Verify healthy cold boot, Main Storage identity and mount guard, RAID and SMART status, SMB user/share ACLs, system services, Recovery Key, emergency access and safe power.
- [ ] Test upgrades to the exact candidate from the installed version without destroying existing storage, Docker data root, shares, users and backups.
- [ ] Test update rollback/failure recovery using a **separate disposable target**, not the three stable deployed appliances.
- [ ] Verify backup **and restore**, realistic share permissions, Task Center, local networking and VLAN access.
- [ ] Confirm normal production operations function with **no Internet access** on the segmented VLAN.
- [ ] Verify Zero1Connect and legacy Google OAuth/tunnel handlers have no public or authenticated production functionality; no listening remote bootstrap and no implicit UPnP port mappings.
- [ ] Run and archive reproducible source-level and exact-artifact tests, including a QA record of UI navigation and access controls.
- [ ] Publish a new versioned release asset/checksum with full notes and no misleading statements; keep source private.
- [ ] Run the GitHub production package audit on that **exact new release** and confirm the artifact is installable through System → Updates.
- [ ] Only then retire the remaining legacy `vredacted.invalid` production ZIP and verify the updater cannot select assetless historical releases.

## Current Github distribution state

On October 13, 2026, the 36 superseded production ZIP assets were withdrawn after preserving checksums and warning on all 37 historical release pages. Only `vredacted.invalid` remains downloadable. The public GitHub documentation repository contains no canonical private Go application source; documentation and tooling changes do not alter the currently installed NAS binaries.

Tracked work: [Zero1Local #2](https://github.com/gigabytegrove/zero1local/issues/2), [Syncria companion specification](SYNCRIA.md), [legacy release retirement](LEGACY-RELEASE-RETIREMENT.md).

**No stable promotion until the original application source, verified binary removal, and appliance qualification are complete.**

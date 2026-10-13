# Zero1Local production promotion gate — October 13, 2026

**Release status: BLOCKED.** The latest downloadable release is `vredacted.invalid`; it still contains the retired native Google Drive implementation and experimental Zero1Connect/tunnel controls. The owner supplied a complete-looking **vredacted.invalid editable source archive**, which passed baseline Go tests. The original redacted.invalid source is not verified, and the vredacted.invalid archive contains an embedded Google OAuth client secret; sanitation and credential rotation assessment are required before it can be committed or used to build a clean successor. **A verified production binary has not yet been built.** Do not promote a documentation-only commit as a new Zero1Local version.

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

A release owner must verify the recovered **vredacted.invalid source archive** is complete, compare any relevant changes through vredacted.invalid, and import sanitized source to the **private** `gigabytegrove/zero1local-source` GitHub repository. Source must remain outside this public documentation/distribution repository.

- [x] Recovered vredacted.invalid editable source archive, with passing baseline Go package tests (not proof of build/release qualification).
- [ ] Remove embedded OAuth secrets and other sensitive material before import, and evaluate provider-side credential rotation.
- [ ] Commit sanitized source to private `gigabytegrove/zero1local-source` and establish its canonical build provenance.
- [ ] Perform a minimal feature-removal change, rather than a rewrite, preserving unrelated implementation.
- [ ] `go test ./...`, `go vet ./...`, target-platform builds, JavaScript/shell syntax checks, and security regression tests pass.
- [ ] Confirm no native Google Drive handlers, background jobs, application OAuth credential constants, account/mapping UI, API routes, or packaged runtime assets remain.
- [ ] On upgrades, preserve NAS data and backups. Disable old Google Drive jobs safely; do not propagate remote deletions. Old refresh tokens/config may require explicit user-approved cleanup, not silent deletion.
- [ ] Zero1Connect experimental mode is disabled by default and cannot publish ports or run enrollment/tunnel APIs in production. Developer access must require server-side authorization, optional allowlisted IP/CIDR and owner-controlled opt-in. Verify direct requests fail when disabled, regardless of browser UI.
- [ ] Confirm the new core UI works directly, including refreshing each route, sessions and permissions, in both themes and on narrow viewports.

## Verified vredacted.invalid packaged-artifact evidence (2026-10-13)

A GitHub-hosted audit downloaded the actual stable ZIP, matched its public asset SHA-256 digest, and inspected 104 runtime files in the internal production archive. The result was **FAIL**: executable/runtime Google Drive markers were detected in:

- `Zero1Local-vredacted.invalid/bin/zero1d-linux-arm64` (compiled ARM64 Go daemon)
- `Zero1Local-vredacted.invalid/helpers/validate-web-capabilities.sh`
- `Zero1Local-vredacted.invalid/manifest.json`
- `Zero1Local-vredacted.invalid/web/app.css`
- `Zero1Local-vredacted.invalid/web/app.js`

This confirms the package is **not** a Google-free release. It does not by itself establish that every runtime route is reachable or reveal implementation source. [Review the audited GitHub workflow log](https://github.com/gigabytegrove/zero1local/actions/runs/38388257044).

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

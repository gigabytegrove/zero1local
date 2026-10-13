# Syncria companion integration — coming soon

**Development status: planned. Not available in the current Zero1Local production binary.**

[Syncria](https://github.com/gigabytegrove/syncria) is a separate Gigabyte Grove project for synchronizing Google Drive with filesystem destinations. Syncria is the intended **only** provider of Google Drive synchronization for future Zero1Local releases. Zero1Local will remove its built-in Google Drive OAuth/account/mapping/sync implementation rather than maintaining two overlapping engines.

The deployed Zero1Local **vredacted.invalid and historical GitHub release packages still contain the legacy Google Drive integration**. Documentation changes do not change these packages. No currently published Zero1Local package should be advertised as a Google-Drive-free replacement without a verified rebuilt artifact.

## Intended product experience

> **Syncria — Coming soon**
>
> A companion synchronization system for Zero1Local, bringing Google Drive and NAS files together. Syncria runs independently and can be hosted as a standalone Docker application or on another supported system. Zero1Local integration is in development.

The planned **Sync & Backup → Syncria** landing area must be honest about its status. Until the integration is implemented, it may link to Syncria's project page but must not show fake connection, installation, or syncing controls.

Once qualified, Zero1Local should act as an **optional connector/dashboard**. Syncria must remain usable entirely without Zero1Local and must own Google account authorization, mapping configuration, transfer execution, conflict detection, and sync history. Zero1Local may expose limited high-level health and job status after explicit pairing. Detailed job editing remains in Syncria.

Syncria should work on a different physical host, using only explicit SMB/NFS or other authorized NAS share access. Zero1Local-ix2 must **not** require Docker; a remote Syncria instance is the suitable option for that hardware.

## Engineering separation

| Zero1Local responsibilities | Syncria responsibilities |
| --- | --- |
| NAS shares/ACLs, safe filesystem roots, ordinary local/remote backup and restore | Google OAuth, Google account management, cloud transfer and syncing |
| Optional connector discovery, authentication and status display | Syncria's own UI, releases, in-app updater and rollback |
| Minimum permitted NAS share access | Sync schedules, mappings, conflicts, transfer history |

**Syncria is not a control plane for Zero1Local**: it receives no root permissions, no Docker socket, no NAS administrative authority, and no privileged access to unrelated shares. Conversely Zero1Local should not incorporate Syncria's OAuth or sync engine. Neither application requires a specific Docker orchestration platform.

## Connector contract — proposed, not yet implemented

The existing browser-oriented Syncria API is **not** an approved third-party integration contract. A versioned machine-to-machine API must be deliberately implemented and tested.

Acceptance criteria:

1. Instance identity, API version and compatibility check.
2. Explicit administrator consent, authenticated pairing and revocable, least-privilege integration credentials.
3. Read-only health, permitted mappings and job status/error summaries.
4. Authenticated TLS for non-loopback or untrusted paths; no disabled certificate verification or anonymous Internet listener.
5. Explicit approved NAS share roots; server-side filesystem/ACL enforcement; no arbitrary host path input.
6. Unavailable/incompatible/offline Syncria cannot interrupt Zero1Local local backups, storage, users, or UI.
7. No automatic installation, third-party Docker integration, separate update service, or automatic privileged mounting.
8. No silent file deletion or new bidirectional mapping upon integration setup.

## Removal of legacy built-in Google Drive

The future production build must:

- Remove Google Drive settings/navigation, browser routes, API routes, OAuth callbacks, embedded OAuth credentials, transfer workers, schedulers and legacy dependency code; leave unrelated backup, file transfer, S3/SMB/NFS/SFTP and replication functionality intact.
- Discover existing accounts/mappings/jobs before upgrade; safely stop legacy tasks; never propagate an apparent mass deletion due to disabled Google integration.
- Preserve NAS files; require explicit consent for any credentials cleanup or mapping migration. Never automatically transplant old Google refresh tokens into Syncria.
- Revoke or clean up legacy credentials with explicit owner approval, then verify local secrets are securely removed where feasible (backups and prior release archives may retain historical copies).
- Test fresh install, in-place upgrade from every relevant historical release family, rollback, offline use and recovery.
- Verify route tables, UI bundles, binaries, configuration/default data and published ZIPs do not contain executable Google Drive integration; maintain a narrowly scoped denylist with documented false-positive handling.
- Publish a **new** release tag, provenance, checksums and full reproducible acceptance evidence, not a silent same-version replacement.

## Legacy release retirement

Until the Google-free production artifact is available and verified, previously issued production ZIPs cannot honestly be described as Google-free. Treat them as **legacy**, and stop recommending them for new installation. See [Legacy release retirement](LEGACY-RELEASE-RETIREMENT.md).

After a verified replacement is published, retire historical release **assets** that contain the old integration. Preserve version/tags/release-page history with a conspicuous historical notice; deleting public assets does not erase previously downloaded copies or repository history. Do not delete currently usable installation assets prematurely without an alternative supported production release.

This document is a roadmap/specification, not a claim of shipped functionality.

# GitHub Update Path — v1.2.9.15

Zero1Local uses GitHub Releases from `gigabytegrove/zero1local` as the public production-update source.

## Superseded update downloads

Thirty-six older production ZIP assets were retired on 2026-10-13 and are no longer installable from GitHub Releases. The remaining **Stable** installer is v1.2.9.15; it retains the legacy native Google Drive implementation and has not been rebuilt. The verified **v1.3.0 Beta prerelease** is also now downloadable, but is not yet hardware-qualified for promotion to Stable. The future replacement is to remove that engine and offer [Syncria — Coming soon](SYNCRIA.md). See [legacy release retirement](LEGACY-RELEASE-RETIREMENT.md).

## Public repository boundary

GitHub contains documentation, branding, support/security information, and production release packages. **Implementation source code and local source archives are maintained on the **private** `gigabytegrove/zero1local-source` GitHub repository.**

The update client does not require or consume a source archive.

## Production asset contract

An installable GitHub release must include the exact asset:

```text
Zero1Local-v<version>-production.zip
```

The production ZIP uses the established five-file root layout:

```text
Install-Zero1Local.ps1
README.txt
SHA256SUMS.txt
Zero1Local-v<version>.tar.gz
deploy-on-nas.sh
```

The updater validates the outer package and the runtime payload before staged activation.

## Update selection

Version comparison uses the published release version/tag and the selected release channel. Draft releases are ignored. Prereleases are considered only by channels that permit them.

The user-triggered update check bypasses saved discovery cache state so a newly published release is not hidden by stale metadata.

## Validation before activation

Before the new release is activated, Zero1Local verifies the package tree, runtime checksums, unit/service contracts, storage/update readiness, and UI route/capability contracts. A staged validation failure must stop the update before the new service is activated.

## Direct-refresh route protection

Release validation compares:

1. the frontend SPA route table;
2. the packaged UI route manifest; and
3. the actual Go `uiRoute` handler.

All three must match. This prevents a page that works through client navigation from returning raw HTTP 404 on browser refresh/direct load.

## Rollback

The update runner captures/restores rollback state where supported and verifies the previous management endpoint if activation fails. Rollback evidence is retained in the update transaction log/state.

## Session-independent progress

The status-only Update Monitor on TCP/8090 reads persisted transaction state independently of the primary management daemon. This allows progress to remain visible across management-service restarts without weakening normal authenticated session behavior. The monitor renders timestamps in the browser owner's local time zone and keeps visible activity/heartbeat indicators moving even when a legitimate long-running stage remains at one percentage.

## Manual installation

Manual/factory deployment through the Windows installer remains supported. Normal in-place upgrades from a healthy Zero1Local appliance should use **System → Updates**.

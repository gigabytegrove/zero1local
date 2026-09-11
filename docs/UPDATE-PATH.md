# GitHub Update Path

## v1.2.3 discovery correction

v1.2.3 makes update discovery resilient to a stale GitHub release-list response by combining the GitHub Latest Release endpoint with the normal release-history endpoint. A user-triggered check bypasses saved ETag/cache state. The newest GitHub release seen is recorded independently from the installed version and exposed to the dedicated `/updates` workspace.

Starting with v1.2.3, the exact `Zero1Local-v<version>-production.zip` asset may use the canonical five-file distribution layout because the updater support added during the v1.2.2 transition is retained.


Zero1Local uses GitHub Releases from `gigabytegrove/zero1local` as the stable public update source.

## v1.2.2 transition

v1.2.1 can discover GitHub Releases but its dashboard installer expects the selected `*-production.zip` asset to contain the versioned Zero1Local release tree directly. The canonical manual distribution, however, is intentionally a five-file wrapper containing the payload as `Zero1Local-v<version>.tar.gz`.

For v1.2.2 only, publish both assets:

- `Zero1Local-v1.2.2-production.zip` — dashboard-updater asset. Contains the checksummed `Zero1Local-v1.2.2/` release tree directly so v1.2.1 can install it.
- `Zero1Local-v1.2.2-distribution.zip` — canonical manual/factory-stock distribution. Contains exactly `Install-Zero1Local.ps1`, `README.txt`, `SHA256SUMS.txt`, `Zero1Local-v1.2.2.tar.gz`, and `deploy-on-nas.sh`.

v1.2.2 adds updater support for the canonical five-file distribution. Therefore subsequent releases may return to using the canonical distribution as the exact `Zero1Local-v<version>-production.zip` dashboard/update asset.

## Update selection

Stable update checks query the GitHub Releases API and ignore drafts/prereleases on the Stable channel. A candidate must be newer than the running version and must provide an exact `Zero1Local-v<version>-production.zip` asset.

## Validation before installation

The dashboard updater validates the selected version, approved HTTPS GitHub asset host, archive paths, release manifest, SHA-256 release tree and appliance preflight before handing installation to the detached transactional installer. Canonical five-file distributions also have their outer `SHA256SUMS.txt` verified before the inner payload tarball is extracted.

## Manual installation remains supported

The dashboard updater does not replace the cumulative installer. The five-file distribution remains the canonical path for a manual upgrade or factory-stock installation.

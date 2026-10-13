# Software Updates — v1.2.9

Software Updates lives at **System → Updates** (`/updates`). It is designed to answer four owner questions immediately: **what is installed, what is newest, what changed, and what is happening now?**

## Retired historical versions

On 2026-10-13, all 36 superseded production ZIPs were removed from GitHub Releases. Their tags and notes remain for history but have no installable asset. The remaining stable vredacted.invalid ZIP **still contains legacy built-in Google Drive**. The cleaned **v1.3.0 Beta prerelease is now downloadable** for controlled appliance qualification; Stable promotion still requires NAS upgrade, rollback and data-preservation testing. Google Drive will belong to the optional [Syncria companion — Coming soon](SYNCRIA.md), not a future Zero1Local engine. See [legacy release retirement](LEGACY-RELEASE-RETIREMENT.md).

## Public update source

The official public update source is GitHub Releases for `gigabytegrove/zero1local`.

The updater installs the exact production asset:

```text
Zero1Local-v<version>-production.zip
```

The public GitHub repository does not publish Zero1Local implementation source code. The complete editable source is maintained at the **private** `gigabytegrove/zero1local-source` GitHub repository, not part of update discovery or installation.

## What the page shows

The normal page separates:

- **Installed** — the version currently running;
- **Latest found** — newest eligible release received from the selected channel;
- **Last checked** — last GitHub check time; and
- a plain-language result such as **Update available**, **Up to date**, or **Couldn’t check**.

When an update is available, the page shows release notes, package metadata, readiness information, rollback protection, and an explicit Install action.

## Discovery behavior

A user-triggered **Check now** bypasses saved response-cache state. The running version and latest release found are tracked separately so the UI never substitutes the installed version for a failed/empty discovery result.

A release is installable only when its exact `Zero1Local-v<version>-production.zip` asset is present.

## Release channels

- **Stable:** published stable releases only.
- **Beta / Release Candidate:** stable releases plus eligible prereleases.
- **Alpha:** all published release classes.
- Draft releases are ignored.

Channel selection is an Advanced setting. Checking for an update never installs it by itself.

## Installation flow

After the owner starts an update, Zero1Local:

1. downloads the production package;
2. validates the package layout and checksums;
3. extracts and validates the runtime payload;
4. checks appliance/storage/update readiness;
5. captures rollback state where supported;
6. validates staged UI/service contracts before activation;
7. activates the release;
8. restarts the required services;
9. verifies management/recovery health; and
10. cleans up or rolls back according to the transaction outcome.

A failed staged validation must stop activation. A failed activation must restore the previous working release where rollback is available.

## Session-independent update progress

The primary management daemon may restart during an update. Zero1Local therefore exposes a separate status-only Update Monitor on TCP/8090. The browser can follow persisted transaction state there while the ordinary authenticated management service restarts.

The monitor uses the canonical Zero1Local light/dark branding, converts persisted UTC timestamps to the browser owner's local time zone, and keeps visible activity moving during long-running stages through a working spinner, animated progress track, active-stage indicator, live status-refresh heartbeat, and elapsed update time. A stable percentage during installation or restart does not by itself mean the update is frozen.

While an update is active, the monitor explicitly warns the owner not to power off or unplug the NAS. The monitor does not make installation/rollback decisions and does not expose owner data; it is a progress/status surface only.

## Failure behavior

A failed update should report the failed stage and preserve the transaction evidence needed for troubleshooting. The previous working release remains or is restored when rollback is available.

## Package cleanup

Verified update staging lives outside ordinary owner data. Cleanup must not remove manual deployment staging, owner files, or the persistent rollback/evidence needed by an active transaction.

See [Update Path](UPDATE-PATH.md) for the public release contract.

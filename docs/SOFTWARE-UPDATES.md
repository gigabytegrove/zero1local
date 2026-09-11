# Software Updates

Zero1Local v1.2.3 gives software updates a dedicated owner-facing workspace at `/updates`. It is designed to answer four questions immediately: **what is installed, what is newest, what changed, and what is happening now?**

## What the page shows

The normal page separates:

- **Installed** — the version currently running on this NAS.
- **Latest found** — the newest release Zero1Local actually received from the selected GitHub channel.
- **Last checked** — when the NAS most recently contacted GitHub.
- **Update available / You’re up to date / Couldn’t check** — a plain-language result instead of internal release-feed terminology.

When an update is available, the page shows the GitHub release notes, exact install package, package size when GitHub reports it, pre-install readiness, rollback protection, and an explicit Install button.

## Discovery behavior

The official repository is `gigabytegrove/zero1local`. A Stable check ignores drafts and prereleases.

To prevent a newly published stable release from being hidden by stale release-list metadata, v1.2.3 combines:

1. GitHub's **Latest Release** endpoint for the newest published stable release; and
2. the normal GitHub Releases history endpoint for channel history and beta/alpha selection.

A user-triggered **Check now** bypasses saved ETag/cache state and sends no-cache request headers. Results are merged by tag/version before version selection. The running version and the newest release received from GitHub are retained as separate fields so the UI never substitutes the installed version for the latest version found.

The updater still requires an exact `Zero1Local-v<version>-production.zip` asset before the release can be installed. If a newer release exists without its install package, the page says that the version is published but the package is not attached yet.

## Consumer states

### Checking
`Looking for updates` while GitHub is being contacted.

### Update available
Shows the newer version, release notes, install package, readiness checks and Install action.

### Up to date
Shows the installed version and confirms it is the newest release found for the selected channel.

### Cannot check
The installed version is left untouched. The page provides **Try again**, Diagnostics, and an Advanced technical-details section.

### Downloading and installing
The page stays live and reports the current stage and percentage. During package download it reports downloaded bytes when known. Stages use owner language such as `Downloading update`, `Opening update package`, `Verifying package and checking this NAS`, and `Installing and checking the new version`.

The web interface may briefly disconnect while Zero1Local restarts. The updater page automatically attempts to reconnect.

### Failed update
The page reports that the update did not finish and exposes technical details on demand. The transactional installer keeps or restores the previous working release when rollback is possible.

## Automatic checking

Owners can choose whether Zero1Local checks automatically and how often it checks. Checking for a new version does not install it.

`Ask me first` remains the recommended installation mode. Automatic installation is opt-in and still uses package verification, preflight checks and rollback protection.

## Release channels

- **Stable (recommended):** published stable releases only.
- **Beta / Release Candidate:** stable plus eligible prereleases.
- **Alpha:** all published release classes.
- Draft GitHub releases are always ignored.

Release channel selection is kept under **Advanced release channel** so normal owners do not have to understand prerelease terminology.

## Technical diagnostics

Normal users do not need HTTP/feed details. The collapsed **Technical update details** section records the official repository, last successful GitHub contact, discovery path, HTTP response, request duration and next automatic check. This information is intended for support and troubleshooting.

## Package safety

Dashboard updates use the same release-owned transactional install path as manual upgrades. Canonical five-file production archives have their outer checksum manifest verified before the inner release payload is extracted and the exact payload tree is verified.

See also:

- [UPDATE-PATH.md](UPDATE-PATH.md)
- [UPGRADING-AND-ROLLBACK.md](UPGRADING-AND-ROLLBACK.md)
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

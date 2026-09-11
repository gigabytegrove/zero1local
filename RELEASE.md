# Zero1Local v1.2.3

Zero1Local v1.2.3 is a focused **Software Updates reliability and user-experience release** over the locked v1.2 feature baseline.

This release addresses the condition where a NAS could report **“No update available”** while a newer stable Zero1Local release was already published on GitHub. It also replaces the old update-settings panel with a dedicated, live Software Updates workspace designed for normal device owners rather than developers or appliance administrators.

No unrelated Zero1Local NAS feature is intentionally removed, disabled, capped, renamed, or redesigned in v1.2.3.

## Software Updates Is Now Its Own Workspace

The Updates experience now has a dedicated page with a clear hierarchy:

- **Installed version** — what is running on this NAS right now.
- **Latest version** — the newest release Zero1Local actually received from GitHub.
- **Last checked** — when GitHub was most recently contacted.
- A single plain-language state such as **Update available**, **You’re up to date**, **Looking for updates**, or **We couldn’t check for updates**.

When an update is available, the page shows:

- the new version;
- GitHub release notes;
- the exact install package and package size when available;
- pre-install readiness checks;
- rollback protection information;
- a clear **Install** action;
- live update progress and current stage;
- downloaded bytes while the package is being downloaded;
- recent release history;
- retry and Diagnostics options when a check fails;
- technical GitHub/HTTP details only under a collapsed **Advanced** section.

The page automatically refreshes active update progress and reconnects after the Zero1Local service restarts during installation.

## GitHub Discovery Reworked

The official release source remains:

```text
https://github.com/gigabytegrove/zero1local
```

v1.2.3 no longer relies on a single cached release-list response for Stable updates.

Stable discovery now combines:

1. GitHub's **Latest Release** endpoint; and
2. GitHub's normal **release history** endpoint.

The results are merged before Zero1Local decides whether a newer version exists.

A user-triggered **Check now** explicitly bypasses saved ETag/cache state. The Latest Release request is also made as a fresh request so a newly published stable version cannot be hidden behind stale release-history metadata.

v1.2.3 also fixes an additional edge case where GitHub could return a fresh Latest release while release history returned **HTTP 304 Not Modified**. The fresh Latest result now wins for current stable-version discovery instead of being discarded.

A newer GitHub version is still shown even if its `*-production.zip` package has not been attached yet. In that case Zero1Local explains that the release is published but cannot be installed until its package is available.

## Consumer-First UI Review

The Software Updates workspace was reviewed specifically as a distributed consumer-product surface.

Changes include:

- removed normal-screen backend terminology such as “eligible update,” “production release metadata,” and “feed state”;
- clearly separated installed and latest version information;
- one obvious primary action for the current state;
- owner-language download, verification, installation, restart and failure stages;
- release-channel controls moved under Advanced settings;
- technical HTTP/discovery data kept out of the normal workflow;
- responsive card/grid behavior for desktop, tablet and mobile layouts;
- no horizontal updater-page overflow at the reviewed 1440 px, 820 px and 390 px viewport widths;
- full-width primary update actions on phone layouts;
- larger updater touch targets on phone layouts.

## Update Installation Progress

During an installation, Zero1Local can report stages such as:

- **Downloading update**
- **Opening update package**
- **Verifying package and checking this NAS**
- **Starting safe installation**
- **Installing and checking the new version**
- **Update installed successfully**

The existing transactional installation and rollback behavior is preserved.

## Updating to v1.2.3

Because the currently installed v1.2.1 updater is the component whose discovery behavior is being corrected, install v1.2.3 manually once using the cumulative production package.

Download:

```text
Zero1Local-v1.2.3-production.zip
```

Extract it and run:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP>
```

For a supported factory-stock/unrooted IronCow Zero1:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP> -Serial '<NAS_SERIAL>'
```

The serial number is encoded in the **QR code on the product sticker on the bottom of the NAS**.

After v1.2.3 is installed, the correct end-to-end online-update validation is to publish a newer stable release (for example v1.2.4) and confirm that v1.2.3 discovers, downloads, verifies and installs it from this new Updates workspace.

## Important: Back Up Your Data First

**Back up or move all important data off the NAS before installing Zero1Local.**

Zero1Local modifies the software environment managing the appliance and may rewrite or reinitialize disk/storage structures to use the supported Zero1Local layout and performance model. Existing data may be lost during conversion, reinitialization, migration, recovery, power loss, hardware failure, or an installation failure.

A second copy that exists only on the same NAS is **not** an independent backup.

## Production Distribution

v1.2.3 returns to one canonical production asset:

```text
Zero1Local-v1.2.3-production.zip
```

The production ZIP is also the complete cumulative manual/factory installer and contains exactly:

```text
Install-Zero1Local.ps1
README.txt
SHA256SUMS.txt
Zero1Local-v1.2.3.tar.gz
deploy-on-nas.sh
```

The dashboard updater retains the canonical five-file archive support introduced during the v1.2.2 transition.

## SHA-256

### `Zero1Local-v1.2.3-production.zip`

```text
916149dc4e4ad5424abe40cf923aab6a5388c980b2664d4d6e4fba34fbe71f5e
```

### `Zero1Local-v1.2.3.tar.gz`

```text
bbfff5986febf2c030714acbf8c101f25ba805b21ee97145cfc5f6ea4552538d
```

### `zero1d-linux-arm64`

```text
813e6a9322fd49cbfa9a60c2df074f45d4e5ea5d9d122de5bb2a6ee835313662
```

### `zero1-recovery-linux-arm64`

```text
52e8a6033367146cf0b0608835f767f50a18dc787b959ab304d99f7aa95a3739
```

## Verification

The exported v1.2.3 production package was validated for:

- exact five-file outer distribution layout;
- outer SHA-256 manifest verification;
- PowerShell installer payload pin = NAS deploy-script payload pin = actual payload hash;
- exact **149/149** internal checksummed release files;
- exact release-tree verification;
- v1.2.3 runtime/manifest identity;
- GitHub Latest + release-history discovery tests;
- forced no-cache update checks;
- fresh Latest + HTTP 304 release-history regression coverage;
- published-newer-release-without-package UI/discovery behavior;
- canonical five-file dashboard update-package support;
- Go tests;
- Go vet;
- Go race detector;
- JavaScript syntax;
- Python direct-MTP helper self-test;
- shell syntax;
- manifest JSON validation;
- ARM64 binary identity;
- deterministic rebuild of both shipped ARM64 binaries from the source inside the delivered archive.

## Warranty Disclaimer and Assumption of Risk

Zero1Local modifies or replaces software components on the target NAS. By installing, using, modifying, or distributing Zero1Local, the device owner and user voluntarily accept the risks associated with modifying the device, including data loss, service interruption, failed installation or recovery, filesystem or operating-system damage, boot failure, hardware incompatibility or damage, and a device becoming partially or completely unusable or “bricked.”

Zero1Local is provided **AS IS** and **AS AVAILABLE**, without warranty of any kind. To the maximum extent permitted by applicable law, **Brad Trammell, Gigabyte Grove, the Zero1Local developers, contributors, copyright holders and distributors are not responsible or liable for hardware damage, data loss, service interruption, loss of use, financial loss, or other damages or losses arising from installation, modification, distribution or use of Zero1Local.**

The device owner is responsible for maintaining complete independent backups, confirming hardware compatibility, and deciding whether to install or use the software.

---

**Zero1Local v1.2.3 is a focused updater correction and UI refinement over the locked v1.2 product baseline.**

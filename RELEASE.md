# Zero1Local v1.2.4

Zero1Local v1.2.4 is a focused **online-updater, Task Center, and appliance-log maintenance release** over the locked Zero1Local v1.2 feature baseline.

This release fixes the online-update failure that could stop around 15% with:

```text
open /root/Zero1Local-update-v<version>-<id>.zip: read-only file system
```

It also gives software-update tasks their own Task Center presentation, cleans stale update archives automatically, and addresses the recurring fan/GPIO and systemd permission warnings observed on real IronCow Zero1 appliances.

No unrelated Zero1Local NAS functionality is intentionally removed, disabled, capped, renamed, or redesigned in v1.2.4.

## Important: Back Up Your Data First

**Before installing Zero1Local, back up or move all important data off the NAS entirely.**

Zero1Local changes the software stack that manages the appliance and may rewrite or reinitialize disk/storage structures to use the supported Zero1Local layout and performance model. Existing data can be lost during storage conversion, reinitialization, migration, recovery, unexpected power loss, hardware failure, or installation failure.

A second copy that exists only on the same NAS is not an independent backup.

## Online Updates Are Now Linux-Native

The online updater no longer stages packages under `/root` and no longer depends on PowerShell after an update has been discovered from the Zero1Local UI.

Online update work is now staged in the dedicated Zero1Local-owned cache:

```text
/var/cache/zero1-local/updates
```

After the package is downloaded and verified, Zero1Local hands the release to a detached Linux-native updater running on the NAS. The updater:

1. downloads the selected GitHub production package;
2. opens the canonical five-file distribution;
3. validates the outer checksum manifest;
4. validates the inner Zero1Local release tree;
5. runs appliance preflight checks;
6. hands the release to the existing transactional Linux installer;
7. survives the expected Zero1Local management-service restart;
8. verifies the newly running version and management health endpoint;
9. records final success/failure state; and
10. removes its managed update workspace.

The Windows PowerShell installer remains the supported manual/factory-stock installation path. It is **not** used internally by the online updater.

## Update Tasks Now Look Like Updates

Task Center no longer presents a Zero1Local software update as though it were a phone transfer or file-copy job.

A software update now follows seven owner-facing stages:

1. **Downloading update**
2. **Opening update package**
3. **Verifying package**
4. **Checking this NAS**
5. **Installing update**
6. **Restarting Zero1Local**
7. **Verifying and cleaning up**

The update detail view shows the target version, package information, overall progress, current stage, start time, last activity, and any update-specific error.

Transfer-only fields such as remaining phone files, current-file throughput, transfer ETA, Pause, or Stop-after-current-file are not shown for software-update tasks.

Update task state is persisted independently of the management process so the same update remains visible after the expected Zero1Local restart.

## Automatic Update-Archive Cleanup

Zero1Local now owns the complete lifecycle of online-update artifacts.

- active update workspaces are retained only while required;
- successful transactions are cleaned after final health verification;
- failed transactions clean their temporary package/extraction workspace;
- superseded transaction directories are pruned before a new update starts;
- stale Zero1Local-owned update-cache entries are pruned at service startup; and
- v1.2.4 installation removes legacy `/root/Zero1Local-update-*` archives/directories left by the v1.2.3 updater bug.

Manual deployment staging under `/root/zero1local-deploy-*` is separate and is not included in this cleanup policy.

## Appliance Log Cleanup

### Fan/GPIO warning storm

Real appliance logs showed the same fan/GPIO warning pair repeating approximately every ten seconds while the effective fan state had not changed.

v1.2.4 keeps the existing validated fan curve and hardware commands but no longer rewrites an unchanged fan state every ten seconds. The state is still applied immediately when Zero1Local starts and whenever the effective speed changes because of temperature or owner configuration. A failed hardware write is not cached and is retried.

### Vendor systemd unit permissions

Real appliance logs also showed systemd warnings for these vendor unit files having executable and/or world-writable permission bits:

- `smbd.service`
- `aria2.service`
- `bootanim.service`
- `rockchip.service`
- `rkaiq_3A.service`

v1.2.4 normalizes only the permission bits on those exact regular unit files to `0644`. It does **not** rewrite their unit contents and does not follow symlinks.

Historical Zero1Local `SIGTERM` entries associated with controlled service stop/restart operations were not treated as evidence of an application crash when the service immediately returned healthy.

## Software Updates UI

The dedicated consumer-first Software Updates workspace introduced in v1.2.3 remains intact, including:

- Installed version and Latest version shown separately;
- fresh GitHub Latest + release-history discovery;
- no-cache **Check now** behavior;
- release notes and package readiness;
- live update progress;
- reconnect behavior while Zero1Local restarts;
- rollback visibility;
- recent releases;
- update preferences; and
- technical HTTP/discovery information under Advanced details.

v1.2.4 also fixes direct browser refresh/navigation of `/updates` so the dedicated updater workspace is a complete first-class application route.

## Manual Installation

Download:

```text
Zero1Local-v1.2.4-production.zip
```

### Existing Zero1Local / already-rooted NAS

```powershell
$Downloads = "$env:USERPROFILE\Downloads"
Set-Location -LiteralPath $Downloads

$Zip = Get-Item "$Downloads\Zero1Local-v1.2.4-production.zip" -ErrorAction Stop
$Dest = "$Downloads\Zero1Local-v1.2.4-production"

Remove-Item -LiteralPath $Dest -Recurse -Force -ErrorAction SilentlyContinue

Expand-Archive `
    -LiteralPath $Zip.FullName `
    -DestinationPath $Dest `
    -Force

$Installer = Join-Path $Dest 'Install-Zero1Local.ps1'

if (-not (Test-Path -LiteralPath $Installer -PathType Leaf)) {
    throw "INSTALLER NOT FOUND: $Installer"
}

Set-ExecutionPolicy -Scope Process Bypass -Force
Set-Location -LiteralPath $Dest

.\Install-Zero1Local.ps1 <NAS-IP>
```

### Factory-stock / not yet rooted

The NAS serial number is encoded in the QR code on the product sticker on the **bottom of the NAS**. Scan the QR code and use the serial value with `-Serial`:

```powershell
$Downloads = "$env:USERPROFILE\Downloads"
Set-Location -LiteralPath $Downloads

$Zip = Get-Item "$Downloads\Zero1Local-v1.2.4-production.zip" -ErrorAction Stop
$Dest = "$Downloads\Zero1Local-v1.2.4-production"
$Serial = '<NAS_SERIAL>'

Remove-Item -LiteralPath $Dest -Recurse -Force -ErrorAction SilentlyContinue

Expand-Archive `
    -LiteralPath $Zip.FullName `
    -DestinationPath $Dest `
    -Force

$Installer = Join-Path $Dest 'Install-Zero1Local.ps1'

if (-not (Test-Path -LiteralPath $Installer -PathType Leaf)) {
    throw "INSTALLER NOT FOUND: $Installer"
}

Set-ExecutionPolicy -Scope Process Bypass -Force
Set-Location -LiteralPath $Dest

.\Install-Zero1Local.ps1 <NAS-IP> -Serial $Serial
```

## Distribution Layout

The production ZIP contains exactly:

```text
Install-Zero1Local.ps1
README.txt
SHA256SUMS.txt
Zero1Local-v1.2.4.tar.gz
deploy-on-nas.sh
```

The same canonical production ZIP is used for manual/factory deployment and GitHub online updates.

## SHA-256

| Artifact | SHA-256 |
| --- | --- |
| `Zero1Local-v1.2.4-production.zip` | `80e1372dd6082b30213e6980f760f99fb5c185b897fe93607dc029a22276fe8d` |
| `Zero1Local-v1.2.4.tar.gz` | `48b776ee575272b042218aaba19a29132a00e61052fc97bb4445a591512d9d43` |
| `zero1d-linux-arm64` | `e9e75b94932c658da564cc23d833a034198d93c682df5c2c98405f78f594ea87` |
| `zero1-recovery-linux-arm64` | `bd193364b5f9c8f02d78a6e29d4e2efac7361567ebcad441435ec456ae204679` |

## Verification

The exported v1.2.4 production ZIP was validated for:

- exact five-file outer distribution layout;
- outer SHA-256 verification;
- PowerShell installer payload pin = NAS deploy-script payload pin = actual payload SHA-256;
- exact 85-file public runtime release tree;
- private build validation with Go tests;
- private build validation with `go vet`;
- private build validation with the full `zero1d` race-detector suite;
- JavaScript syntax;
- Python MTP helper self-test;
- shell syntax;
- manifest validation;
- direct-refresh route parity, including `/updates`;
- ARM64 binary identity;
- deterministic rebuild of both shipped ARM64 binaries;
- managed update-cache path safety tests;
- update-cache pruning tests; and
- a Linux updater failure-path integration test proving that a failed update removes its transaction workspace and persists a failed update state.


## Distribution model

The public GitHub production package is a compiled runtime distribution. It includes the binaries and runtime/support files required to install and operate Zero1Local. The private canonical application source and developer build/test tree are not included in the public release.

## Documentation Provenance

Zero1Local public documentation was generated with assistance from **OpenAI ChatGPT** after project planning and implementation documentation was supplied to it. **AI was not used in the design or implementation of the Zero1Local software.** Documentation is reviewed against the actual production distribution artifacts before publication.

## Warranty Disclaimer and Assumption of Risk

Zero1Local modifies or replaces software components on the target NAS. By installing, using, modifying, or distributing Zero1Local, the device owner and user voluntarily accept the risks associated with modifying the device, including data loss, service interruption, failed installation or recovery, filesystem or operating-system damage, boot failure, hardware incompatibility or damage, and a device becoming partially or completely unusable or “bricked.”

Zero1Local is provided **AS IS** and **AS AVAILABLE**, without warranty of any kind. To the maximum extent permitted by applicable law, **Brad Trammell, Gigabyte Grove, the Zero1Local developers, contributors, copyright holders and distributors are not responsible or liable for hardware damage, data loss, service interruption, loss of use, financial loss, or other damages or losses arising from installation, modification, distribution or use of Zero1Local.**

The device owner is responsible for maintaining complete independent backups, moving irreplaceable data off the NAS before installation, confirming hardware compatibility, and deciding whether to install or use the software.

---

**Zero1Local v1.2.4 is a maintenance release over the locked v1.2 product baseline.**

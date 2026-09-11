# Installation

Zero1Local v1.2 uses one cumulative production package. Earlier Zero1Local versions are not prerequisites.

## Requirements

- supported IronCow Zero1 target or separately qualified ARM64 compatibility target
- NAS connected to the same trusted LAN as the Windows workstation
- Windows PowerShell
- the NAS IP address
- for factory-stock bootstrap, the NAS serial required by the factory bootstrap path

## Verify the downloaded ZIP

From PowerShell:

```powershell
Get-FileHash .\Zero1Local-v1.2-production.zip -Algorithm SHA256
```

Expected v1.2 ZIP hash:

```text
6ecaf7a50897ca59a52c611fbe2774026e622e4e6533cd982940e7793c4770b9
```

## Extract the release

```powershell
$Downloads = "$env:USERPROFILE\Downloads"
Set-Location -LiteralPath $Downloads

$Zip = Get-Item "$Downloads\Zero1Local-v1.2-production.zip" -ErrorAction Stop
$Dest = "$Downloads\Zero1Local-v1.2-production"

Remove-Item -LiteralPath $Dest -Recurse -Force -ErrorAction SilentlyContinue
Expand-Archive -LiteralPath $Zip.FullName -DestinationPath $Dest -Force

$Installer = Join-Path $Dest 'Install-Zero1Local.ps1'
if (-not (Test-Path -LiteralPath $Installer -PathType Leaf)) {
    throw "INSTALLER NOT FOUND: $Installer"
}

Set-ExecutionPolicy -Scope Process Bypass -Force
Set-Location -LiteralPath $Dest
```

## Already-rooted/current Zero1Local appliance

```powershell
.\Install-Zero1Local.ps1 <NAS-IP>
```

## Factory-stock supported IronCow Zero1

```powershell
.\Install-Zero1Local.ps1 <NAS-IP> -Serial '<NAS_SERIAL>'
```

The factory path establishes the documented root-access bootstrap, verifies direct root SSH, removes the temporary bootstrap containers and then enters the normal cumulative installation transaction.

Hardware qualification of the factory bootstrap is evidence-based: the exact public wrapper should be replayed against a current factory-reset target before being described as hardware-proven.

## Installer stages

The normal installer reports six owner-facing stages:

1. verifying release package
2. establishing root access
3. creating deployment staging
4. uploading release
5. checking appliance and rollback safety
6. installing and verifying Zero1Local

Detailed verification output is retained in a NAS-side installation log rather than flooding the normal console.

## Successful result

A successful install reports the management, compatibility and recovery endpoints. Verify:

```text
http://<NAS-IP>/
http://<NAS-IP>:8088/
http://<NAS-IP>:8089/
```

## Failed result

If stage 6 fails, the installer attempts automatic rollback to the previous healthy Zero1Local management endpoint. Use the exact detailed log path printed by the installer, typically:

```text
/var/log/zero1-local/install-YYYYMMDDTHHMMSSZ.log
```

See [Troubleshooting](TROUBLESHOOTING.md).

## What the installer does not replace

The normal v1.2 installer does not replace the validated kernel, bootloader or DTB.

# Installation and Factory Bootstrap

## Back up or move important data off the NAS first

**Do not install Zero1Local until all important data has been backed up or moved off the NAS entirely.**

Zero1Local replaces software that manages the appliance and may rewrite or reinitialize storage structures when required by the supported layout. Installation, storage migration, recovery, unexpected power loss, hardware failure, or an installation failure can result in data loss.

A second copy on the same NAS is not an independent backup.

## Public release package

The official GitHub release publishes the production distribution package:

```text
Zero1Local-v<version>-production.zip
```

The public GitHub repository contains documentation and production release material. **Zero1Local implementation source code is maintained privately/off-GitHub and is not distributed as a public GitHub source archive.**

## Already rooted or upgrading Zero1Local

For a manual deployment, run the established cumulative Windows installer from the production package:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP>
```

For normal upgrades from a working Zero1Local installation, the preferred path is **System → Updates** so the appliance can download, verify, stage, activate, and roll back a release transactionally.

## Factory-stock or unrooted IronCow Zero1

If direct root SSH has not been established, the installer requires the NAS serial number:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP> -Serial '<NAS_SERIAL>'
```

### Where to find the serial number

The serial number is encoded in the QR code on the product sticker on the bottom of the NAS. Scan the QR code and use the serial value exactly as encoded.

A factory-stock NAS may reject or close a direct SSH probe before root access has been established. When `-Serial` is supplied, that failed direct-SSH probe is treated as an expected state and the installer continues into the supported factory bootstrap instead of stopping on a raw SSH error.

Temporary bootstrap containers are removed after the permanent root SSH path is established and verified.

## Installation stages

The public installer performs the established guarded sequence:

1. verify the production package and pinned payload checksum;
2. establish root access, using factory bootstrap when required;
3. stage deployment under `/root`;
4. upload the verified payload and deployment helper;
5. validate appliance compatibility, Main Storage health, rollback capacity, service ownership, and recovery safety;
6. activate transactionally;
7. verify management/recovery health; and
8. roll back when final activation validation fails and rollback is available.

## Endpoints after installation

- Management: `http://<NAS-IP>/`
- Compatibility listener: `http://<NAS-IP>:8088/`
- Recovery service: `http://<NAS-IP>:8089/`
- Session-independent Update Monitor: `http://<NAS-IP>:8090/`

Do not expose SMB, NFS, SSH, Recovery, or the management plane directly to the public Internet.

## Warranty and risk

Installation is voluntary and at the device owner's risk. See [Warranty and Risk](WARRANTY-AND-RISK.md) and the repository [LICENSE.md](../LICENSE.md).

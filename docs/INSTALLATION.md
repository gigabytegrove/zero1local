# Installation and Factory Bootstrap

## Back up or move your data off the NAS first

**Do not install Zero1Local until all important data has been backed up or moved off the NAS entirely.**

Zero1Local changes the software stack that manages the NAS and may rewrite or reinitialize disk/storage structures to use the supported Zero1Local layout and performance model. Storage migration, conversion, recovery, unexpected power loss, hardware failure, or an installation failure can result in data loss.

A second copy on the same NAS is not an independent backup. Keep irreplaceable data on another storage device or service before installation.

## Already rooted or upgrading Zero1Local

Run the cumulative installer with the NAS IP:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP>
```

The installer first checks the established Zero1Local ED25519 root key and then the ordinary reachable root SSH path.

## Factory-stock or unrooted IronCow Zero1

If direct root SSH has not been established, the installer requires the NAS serial number:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP> -Serial '<NAS_SERIAL>'
```

### Where to find the serial number

The serial number is **encoded in the QR code on the product sticker on the bottom of the NAS**. Scan the QR code and use the serial value exactly as encoded.

If installation stops while establishing root access with an SSH message such as:

```text
banner exchange: Connection to UNKNOWN port -1: Connection refused
```

then direct root SSH is not available. Rerun the installer with the `-Serial` flag.

The factory bootstrap uses the supported vendor Docker/API path to establish the dedicated Zero1Local root SSH key, validates the real host SSH daemon on TCP/22, removes temporary bootstrap containers, and then continues through the same normal cumulative installer.

## Installer stages

1. Verify the release package and pinned payload SHA-256.
2. Establish root access, using the factory serial bootstrap when required.
3. Create deployment staging under `/root`.
4. Upload the cumulative payload and NAS deployment script.
5. Check appliance compatibility, Main Storage health, rollback space, services and recovery safety.
6. Install transactionally, verify the management/recovery endpoints, and roll back automatically if final verification fails.

## Endpoints after a successful installation

- Management: `http://<NAS-IP>/`
- Compatibility: `http://<NAS-IP>:8088/`
- Recovery: `http://<NAS-IP>:8089/`

## Warranty and risk

Installation is voluntary and at the device owner's risk. See [`WARRANTY-AND-RISK.md`](WARRANTY-AND-RISK.md) and the shipped `LICENSE.txt` for the complete disclaimer and assumption-of-risk terms.

# Ports and Services

## Core TCP listeners

| Port | Purpose |
| ---: | --- |
| 22 | normal SSH when enabled by the appliance |
| 80 | canonical Zero1Local management UI/API |
| 8088 | compatibility management listener |
| 8089 | independent Recovery Environment |
| 22222 | independent emergency public-key-only SSH |
| 139/445 | SMB |
| 2049 | userspace NFSv3 when enabled |
| 20048 | userspace NFS mount service port used by the v1.2 unit |

Optional services such as WireGuard, Docker-published application ports or optional HTTPS have their own configured listeners.

## Important systemd units

```text
zero1-local.service
zero1-recovery.service
zero1-storage.service
zero1-docker.service
zero1-unfs3.service
zero1-phone-usb-host.service
zero1-dns.service
zero1-firewall.service
zero1-emergency-ssh.service
zero1-emergency-access.service
zero1-hardware-recovery.service
```

Useful command:

```bash
systemctl --no-pager --full status zero1-local.service zero1-recovery.service zero1-storage.service
```

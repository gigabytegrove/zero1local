# Troubleshooting

Zero1Local troubleshooting is evidence-first. Capture what the appliance actually reports before changing services, permissions or storage.

## UI will not load

From root SSH:

```bash
systemctl status zero1-local.service --no-pager
journalctl -u zero1-local.service -n 250 --no-pager
curl -v http://127.0.0.1:8088/healthz
curl -v http://127.0.0.1:8089/healthz
```

If Recovery works but the main UI does not, use [Recovery](RECOVERY.md) rather than disabling firewall/recovery safeguards.

## Installation failed and rolled back

Use the exact log path printed by the installer:

```bash
cat /var/log/zero1-local/install-YYYYMMDDTHHMMSSZ.log
```

Do not assume the newest log on one NAS belongs to a failed attempt on another NAS.

## Main Storage/share disappeared

```bash
findmnt -T /disk0
cat /proc/mdstat
lsblk -f
systemctl status zero1-storage.service --no-pager
```

Do not create files manually in an unverified `/disk0` directory to test it. If Main Storage cannot be proven, Zero1Local intentionally guards the path.

## SMB inaccessible

```bash
systemctl status smbd --no-pager
/usr/local/samba/bin/testparm -s
/usr/local/samba/bin/smbstatus
```

Confirm the underlying share path is on proven Main Storage. Avoid blanket `chmod -R 777` fixes.

## NFS unavailable

```bash
systemctl status zero1-unfs3.service --no-pager
cat /var/lib/zero1-local/nfs-install-state.json 2>/dev/null
cat /var/lib/zero1-local/nfs-install.log 2>/dev/null
test -f /etc/zero1/nfs/exports && cat /etc/zero1/nfs/exports
```

## Phone visible but cannot browse

For Android:

1. unlock the phone;
2. open the USB notification;
3. select **Transferring files / Android Auto**;
4. keep the cable connected to the validated NAS phone USB port;
5. watch Task Center/LED state.

If Manual Phone Transfer is already open, automatic offload should wait rather than interfere.

If the native MTP helper fails, capture the complete error/traceback from the UI/log rather than repeatedly reconnecting until it happens to work.

## Automatic phone job waits yellow

Yellow waiting is expected when a saved phone is physically present but not MTP-ready. Change the phone to file-transfer mode. There is no automatic readiness timeout in v1.2.

## Docker containers appear missing

Before changing Docker configuration:

```bash
docker info --format '{{.DockerRootDir}}'
cat /var/lib/zero1-local/docker-data-root 2>/dev/null
systemctl status zero1-docker.service --no-pager
```

A data-root mismatch is a safety failure, not a reason to initialize a fresh empty Docker root.

## Network/DNS issue

```bash
nmcli device status
nmcli connection show
ip -br address
ip route
cat /etc/resolv.conf
systemctl status zero1-dns.service --no-pager
```

## Need more evidence

See [Support evidence](SUPPORT-EVIDENCE.md).


## Online update fails or stops

Start with the update state and update log:

```bash
cat /var/lib/zero1-local/update-apply.json 2>/dev/null
ls -lah /var/lib/zero1-local/update-apply-*.log 2>/dev/null
tail -n 200 /var/lib/zero1-local/update-apply-*.log 2>/dev/null
ls -lah /var/cache/zero1-local/updates 2>/dev/null
```

v1.2.4 must not create new `/root/Zero1Local-update-*` archives. If such an entry predates v1.2.4, the v1.2.4 installer removes it as legacy updater debris.

## Repeating fan/GPIO warnings

v1.2.4 no longer rewrites an unchanged fan state every ten seconds. One hardware message associated with an actual fan-state transition can still be meaningful; a continuing ten-second warning storm after v1.2.4 should be reported with the surrounding kernel log and current fan status rather than hidden or filtered.

```bash
journalctl -k -n 200 --no-pager
curl -fsS http://127.0.0.1/api/hardware/fan 2>/dev/null || true
```

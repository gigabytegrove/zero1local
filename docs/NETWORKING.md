# Networking, DNS and VLANs

## Primary-network model

Zero1Local uses the interface/default route that actually owns primary connectivity rather than assuming a fixed interface name.

## Hostname and DNS

Zero1Local manages hostname/DNS policy through NetworkManager and owns `/etc/resolv.conf` policy for the appliance.

### Automatic DNS

Automatic mode clears profile DNS overrides and prefers DNS servers delivered by DHCP.

### Manual DNS

Manual mode uses the exact owner-selected non-loopback DNS servers and ignores automatically supplied DNS for that profile.

Persistent DNS state is retained under:

```text
/var/lib/zero1-local/network/
```

`zero1-dns.service` reasserts policy after network startup.

## VLANs

VLAN create/update/delete is integrated under Connectivity → Network → VLANs and is guarded by route/DNS safety checks.

## Advanced network changes

Advanced settings such as MTU/static routes use an apply/confirm transaction pattern so a change that breaks connectivity is not silently committed forever.

## Troubleshooting

```bash
nmcli device status
nmcli connection show
ip -br address
ip route
cat /etc/resolv.conf
systemctl status zero1-dns.service --no-pager
```

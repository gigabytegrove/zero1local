# Recovery

Zero1Local v1.2 keeps recovery independent from the primary management UI.

## Recovery Environment

Open from the private LAN:

```text
http://<NAS-IP>:8089/
```

Recovery requires the separate **Recovery Key**, not the normal web administrator password.

Retrieve/store the key from:

**System → Recovery → Recovery Key**

Store it somewhere outside the NAS.

## Recovery capabilities

The Recovery Environment can provide actions such as:

- inspect system/storage/network state
- restart the primary UI
- restore configuration
- reset the normal web administrator password
- roll back an installed release
- safe power actions

## Recovery Mode

From root SSH:

```bash
zero1-recovery-mode status
```

Enter manually only when needed:

```bash
zero1-recovery-mode enter "manual administrator recovery"
```

Clear:

```bash
zero1-recovery-mode clear
```

Clear is evidence-gated: Zero1Local validates the management endpoint, protected listeners, storage/SMB integrity and candidate strict firewall before committing the transition out of Recovery Mode.

## Emergency SSH

An independent key-only SSH service is maintained on TCP/22222 for recovery. It is restricted to RFC1918/private-LAN and IPv6 link-local sources. It is a safety boundary, not the normal daily administration path.

## If the main UI is down

Check in this order:

```bash
systemctl status zero1-recovery.service --no-pager
systemctl status zero1-local.service --no-pager
curl -fsS http://127.0.0.1:8089/healthz
curl -fsS http://127.0.0.1:8088/healthz
zero1-recovery-mode status
```

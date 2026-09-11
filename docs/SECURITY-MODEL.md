# Security Model

Zero1Local v1.2 is designed for a trusted private LAN with optional private VPN access.

## Normal services

The management service listens on TCP/80 with a compatibility listener on TCP/8088. Optional HTTPS can be configured separately. Recovery uses TCP/8089.

## Recovery boundary

The Recovery Environment is a separate process/service and remains available independently of the primary management UI. Emergency SSH is also a separate public-key-only sshd on TCP/22222 restricted to RFC1918/private-LAN and IPv6 link-local source ranges.

Normal strict firewall activation is ordered after the recovery invariant is established. Recovery Mode can suppress the strict normal policy while keeping protected recovery listeners reachable.

## Authentication/session behavior

The normal web administrator session is separate from the Recovery Key. A running backend transfer task is not terminated merely because a browser session expires.

## Storage safety is security

Zero1Local treats accidental writes to root/eMMC after array loss as a data-integrity/security problem. Main Storage must be positively identified; otherwise `/disk0` is guarded fail-closed.

## OS-base limitation

The validated IronCow platform uses Debian 11. Debian 11 reached Debian LTS end-of-life on 2026-08-31. Package-source repair does not restore upstream security maintenance. Keep the appliance behind a trusted firewall and avoid direct public exposure.

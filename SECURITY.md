# Security Policy

## Supported release

Security fixes are targeted at the current stable Zero1Local release. At the time of this documentation set, that release is **v1.2.2**.

## Reporting a vulnerability

Do not disclose a suspected vulnerability in a public issue while it is still exploitable. Prefer a private GitHub Security Advisory for the repository when available. If the repository does not expose private advisory reporting, contact the project maintainer privately through the maintainer's GitHub contact path before publishing technical exploit details.

Include:

- affected Zero1Local version
- affected hardware/platform
- exact preconditions
- impact
- minimal reproduction steps
- whether the issue is reachable only from the private LAN or from an explicitly configured remote-access path

Do not send real credentials, Recovery Keys, private keys, OAuth tokens or production user data unless a private channel has been explicitly established.

## Security model notes

Zero1Local is local-first. v1.2 uses a strict firewall model, a separate Recovery Environment on TCP/8089 and a separate public-key-only emergency SSH service on TCP/22222 restricted to RFC1918/private-LAN and IPv6 link-local source ranges. These recovery paths are intentional safety boundaries, not substitutes for normal administration.

The validated IronCow target retains the vendor Debian 11 base and kernel 5.10.198. Debian 11 reached the end of Debian LTS on 2026-08-31. Zero1Local can repair Bullseye package-source reachability for required dependencies, but doing so does not restore upstream security support for the vendor operating-system base. Owners should treat that platform constraint as part of their risk model and avoid exposing NAS management or file-sharing services directly to the public Internet.

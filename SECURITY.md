# Security Policy

Zero1Local manages a storage appliance and should be treated as security-sensitive infrastructure.

## Supported security posture

Zero1Local is designed primarily for trusted local networks and private VPN access. Plain HTTP is acceptable on a trusted LAN or inside an encrypted WireGuard tunnel. HTTPS should use certificates trusted by the client operating system/browser; the project does not require trust-all TLS behavior or mandatory self-signed certificates.

Do not expose SMB, NFS, SSH, the recovery service, or the raw NAS management plane directly to the public Internet. When intentionally publishing a web application, use an appropriate reverse proxy and restrict trusted source networks where practical.

## Reporting a vulnerability

Please do not publish exploit details, credentials, tokens, private keys, or a working attack path in a public issue.

Use GitHub private vulnerability reporting / a private security advisory when it is available for the repository. If that feature is not available, contact the project maintainer through a private channel associated with the repository before disclosing technical details publicly.

A useful report includes:

- affected Zero1Local version;
- affected route/service/component;
- exact reproduction steps;
- expected vs. actual behavior;
- security impact;
- logs with passwords, tokens, private keys, recovery keys, and personal file paths removed;
- whether the behavior was reproduced on real Zero1 NAS hardware or only in a development environment.

## Security-sensitive areas

Extra care is required for changes involving:

- authentication, sessions, 2FA, administrator delegation, SSH, and API keys;
- Zero1Connect pairing, device authentication, access scopes, and WireGuard;
- filesystem/path confinement, share ACLs, uploads/downloads, and file IDs;
- update signing/validation, staged activation, rollback, and recovery;
- firewall/network exposure;
- Docker/app isolation and host bind mounts;
- backup/restore, RAID, and destructive storage actions.

## Secrets

Never include passwords, bearer tokens, pairing tokens, private keys, recovery keys, API secrets, or full secret-bearing configuration files in public bug reports or support bundles.

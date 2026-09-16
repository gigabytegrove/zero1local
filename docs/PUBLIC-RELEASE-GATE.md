# Zero1Local Public Release Qualification and Documentation Policy

The official public repository is `gigabytegrove/zero1local`.

The public repository intentionally contains **documentation, branding, issue/support material, and production release packages only**. Zero1Local implementation source code is maintained privately/off-GitHub and must not be published as a GitHub source archive unless the project owner explicitly changes that policy.

## Public release documentation requirements

Every public release should document, as applicable:

- project purpose, local-first scope, supported hardware, and pre-release/production status;
- exact installation/update workflow and production package checksum;
- independent-backup requirements before installation;
- factory-stock bootstrap requirements, including serial-number usage;
- Main Storage / RAID safeguards and destructive-operation warnings;
- SMB/NFS users, shares, permissions, and account behavior;
- Phone Transfer behavior and its hardware-qualification boundary;
- Zero1Connect pairing, native shared-folder ACL inheritance, root master behavior, and managed remote-access behavior;
- networking, DNS, VLANs, firewall, and remote-access boundaries;
- Docker/App Catalog, Docker Compose, and Office integration;
- staged updates, rollback, Recovery, and session-independent update progress;
- notification suppression/restore behavior;
- known limitations and intentionally unqualified functions;
- release notes/changelog, warranty/risk terms, security policy, and support policy.

Public documentation follows Zero1Local's evidence-first rule. Do not claim universal Android compatibility, qualified iPhone support, a public remote endpoint, a particular RAID/storage recovery outcome, or another hardware/network-dependent behavior without evidence from the relevant path.

## GitHub publication policy

For v1.2.6.3, the GitHub Release asset intended for installation is:

```text
Zero1Local-v1.2.6.3-production.zip
```

Repository documentation and branding are committed as normal GitHub files. Local/private source archives, build workspaces, source manifests, and internal validation artifacts are **not** GitHub release assets.

## Installer presentation requirement

The public installer retains its safety/verification gates while presenting normal stage-oriented output. Detailed verification remains available in installation logs. A failure should identify the failed stage, concise error, rollback result, and relevant log path.

Before installation begins, documentation and installer presentation must clearly require the owner to back up or move important data off the NAS.

## SPA direct-refresh requirement

Every frontend route must also be accepted by the actual Go UI route handler and the packaged route manifest. Release verification must compare all three sets so client navigation cannot work while direct refresh returns a raw `404 page not found`.

## UI production-readiness requirement

Normal owner workflows must not expose developer-only qualification chatter, raw feature-check output, internal implementation notes, or repetitive explanatory notices by default. Such material belongs under **Advanced**, **Feature checks**, diagnostics, logs, or support bundles.

The UI should prefer grouped sections/rows over stacks of nested cards and should use centralized navigation instead of excessive cross-linking between unrelated areas.

## Phone Transfer evidence boundary

Package/install success alone does not qualify hardware-specific Phone Transfer behavior. Real-device testing is required for connection mode, stable device identity, manual transfer, automatic rules, Copy/Move verification, reconnect behavior, and relevant LED states.

## Zero1Connect evidence boundary

Package/install success alone does not qualify the Android integration. Real-device testing is required for QR pairing, LAN-only and automatic-remote choices, one-time token use, P-256 challenge/session authentication, root master access, native shared-folder ACL inheritance, file operations, resumable transfers, managed WireGuard provisioning, off-LAN connectivity, revocation, multiple phones, and reboot/update persistence.

## Factory-bootstrap evidence boundary

Packaging validation does not by itself create factory-bootstrap hardware qualification. A current factory-stock target must be replayed for that claim.

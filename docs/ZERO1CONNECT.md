# Zero1Connect server support — Zero1Local v1.2.6

**Zero1Connect** is a first-class top-level Zero1Local product area. The Android app remains a separate project; Zero1Local provides the server-side `/api/connect/v1` contract, pairing, access control, file/transfer services, and managed private remote-access path.

The current integration target is Zero1Connect Android `0.1.0-dev18`. Build compatibility alone does not qualify the complete Android/NAS workflow.

## Zero1Local workspace

Use **Zero1Connect** from the primary navigation. The product area contains:

- **Overview** — service/pairing/remote-access state;
- **Devices & Access** — paired phones, bound Zero1Local user, assigned mobile locations, permissions, and revocation; and
- **Remote Access** — managed WireGuard state, endpoint status, and recovery/retry information.

Pairing is initiated from the Zero1Connect area rather than from a buried System subsection.

## Pairing and device ownership

A pairing QR contains a short-lived, single-use token and the NAS endpoint information required by the Android client. It must never contain a NAS password, Android private key, WireGuard private key, or permanent bearer token.

Each paired phone remains bound to a Zero1Local user/account context. A phone does not become an independent super-user identity.

If an administrator pairs a phone for another user, the intended user must be selected explicitly.

## Mobile access assignments

A paired device receives only explicitly assigned mobile access locations. An assignment may be:

- an entire shared folder; or
- a folder root inside a shared folder.

Effective permission is the intersection of:

1. the paired-device mobile assignment;
2. the bound Zero1Local user's ACL;
3. underlying share/filesystem permissions; and
4. operation-specific Zero1Local policy.

The most restrictive result wins. A mobile assignment can reduce access; it cannot expand the user's normal rights.

`GET /api/connect/v1/shares` returns only the mobile access locations assigned to the authenticated paired phone.

## Authentication

Pair completion receives the Android P-256 authentication public key (X.509 SPKI) and the phone's WireGuard public key. Private keys remain on Android.

Challenge/session authentication uses short-lived random challenges and `SHA256withECDSA`. Successful authentication issues a short-lived bearer session. Revoked devices cannot establish new sessions.

## File and transfer confinement

The Connect API supports assigned-location browsing, folder creation, rename, move, copy, delete/recycle behavior, duplicate checks, streaming downloads, and resumable uploads.

Mobile-visible paths are relative to the assigned scope. Zero1Local must reject `..` traversal, alternate slash/encoding traversal, symlink/mount escape, stale IDs, IDs from another scope/device/user, and unauthorized cross-scope move/copy.

Possessing an opaque file ID is not authorization; the object is re-authorized on every request.

## Managed WireGuard: zero-configuration owner path

Normal Zero1Connect pairing is intended to configure private remote access automatically.

When the first paired phone requires managed remote access and WireGuard is not ready, Zero1Local can install the required `wireguard-tools` and `iproute2` packages, create/reconcile the `wg-zero1` server identity/interface, assign a unique per-phone `/32`, update the trusted firewall scope, persist the peer, and attempt to establish a usable external endpoint.

Endpoint selection may use:

1. an explicitly configured valid endpoint;
2. a globally routable address directly assigned to the NAS; or
3. a router-confirmed UPnP UDP mapping when the NAS is behind suitable IPv4 NAT.

If no usable external endpoint can be established, LAN pairing remains valid. Zero1Local must report remote access as not ready with the concrete failure reason; it must not pretend remote setup succeeded.

The Android private WireGuard key never leaves the phone. Managed routes are **split tunnel only** and must not require `0.0.0.0/0` or `::/0`.

## Revocation

Revoking one phone invalidates its future authentication authority, mobile access assignments, and managed WireGuard peer without revoking other phones.

## Qualification boundary

Real-device qualification must prove QR/manual pairing, one-time token behavior, authentication, assigned-location ACL isolation, traversal confinement, file operations, resumable upload/download, managed WireGuard off-LAN access, full-tunnel rejection, multiple phones, revocation, and reboot/update persistence against the exact Android client under test.

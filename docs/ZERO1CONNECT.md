# Zero1Connect server support — Zero1Local v1.2.6.7

**Zero1Connect** is a first-class top-level Zero1Local product area. The Android application is developed independently; Zero1Local owns the NAS-side `/api/connect/v1` contract, device identity, native file authorization, transfer services, and managed private remote-access path.

The current integration target is Zero1Connect Android `0.2.3`. Package/build compatibility does not by itself qualify the complete Android/NAS workflow.

## Zero1Local workspace

Use **Zero1Connect** from the primary navigation. The product area contains:

- **Overview** — Connect API, discovery, administration state, paired phones, and remote-access state;
- **Devices & Access** — paired phones, the bound Zero1Local user, effective native shared-folder access, and revocation; and
- **Remote Access** — managed WireGuard state, endpoint status, and automatic setup/retry guidance.

Pairing is initiated from this product area rather than from a buried System subsection.

## Root is the appliance master administrator

An authenticated Zero1Local `root` administrator is the appliance owner and has master administrative authority over Zero1Connect management.

A phone paired to `root` receives the same full native shared-folder file authority that `root` has on the appliance. It is not restricted by a second Zero1Connect-specific ACL.

Other paired phones remain bound to their selected Zero1Local user and can never exceed that user's native file rights.

## One file-permission authority

Zero1Connect does **not** maintain a separate file/ACL permission system.

The authoritative source for mobile file access is the same native shared-folder access configuration used by **Files & Sharing**:

- shared-folder valid/read users determine read/download access;
- shared-folder write users determine write operations; and
- `root` has master read/write authority.

`GET /api/connect/v1/shares` is therefore an effective view of the bound user's current native shared-folder access. Changes made in **Files & Sharing** automatically change what that paired phone can access.

Legacy prerelease `scope_...` IDs may be accepted temporarily as compatibility aliases to their original shared folder, but their old stored permission flags are ignored and can never expand the current native ACL.

## Pairing and device ownership

A pairing QR contains a short-lived, single-use token and the NAS endpoint information required by the Android client. The NAS host embedded in that URI is a numeric LAN IPv4 address selected from the requesting browser client's subnet whenever one is available; Zero1Local does not assume that an Android phone can resolve the same local hostname the browser used. If Zero1Local cannot determine a usable numeric LAN IPv4 address, pairing fails explicitly instead of emitting a known-bad QR code. The QR must never contain a NAS password, Android private key, WireGuard private key, or permanent bearer token.

Nearby discovery uses `_zero1local._tcp` over mDNS/Avahi. A service file alone is not treated as healthy discovery: owner-facing status is Running only when the advertisement exists and `avahi-daemon` is active.

Each paired phone remains bound to a Zero1Local user/account context. A phone does not become an independent super-user identity.

If an administrator pairs a phone for another user, the intended user must be selected explicitly where that workflow is offered.

## Remote-access choice and zero-configuration setup

Pairing offers an owner-facing choice:

- **Set up remote access** — recommended; or
- **Pair LAN only** — explicitly disables the managed remote tunnel for that phone.

The pairing intent is stored with the single-use pairing request. A current Android client may also explicitly confirm or change the choice in `POST /pair/complete`. Older compatible clients that omit the field inherit the NAS-side pairing choice. If neither side supplies a choice, automatic remote access remains the compatibility default.

WireGuard support is capability-gated by the runtime, not by package presence alone. Zero1Local advertises `features.wireguard=true` and `managed_remote_access=true` only after a temporary nonpersistent interface can be created, configured with a private key, activated, verified, and removed successfully. If that backend test fails, the dedicated provisioning path returns HTTP 503 with `wireguard_backend_unavailable`; LAN pairing remains valid.

When remote access is enabled, the user is **not** expected to configure WireGuard manually. Zero1Local and Zero1Connect own the tunnel lifecycle. Zero1Local can:

1. install required `wireguard-tools` and `iproute2` packages when missing;
2. create/reconcile the managed `wg-zero1` server identity/interface;
3. assign a unique per-phone tunnel address;
4. install/reconcile that phone's peer and trusted firewall scope;
5. preserve the peer across reboot/update; and
6. discover or establish a usable external UDP endpoint where the network permits it.

Endpoint selection can use an explicitly configured valid endpoint, a globally routable address directly assigned to the NAS, or a router-confirmed UPnP UDP mapping when appropriate. UPnP discovery is performed independently on each active LAN IPv4 address with interface-bound SSDP multicast, retries, and IGD/WANIPConnection/WANPPPConnection/root-device/`ssdp:all` search targets so a multi-interface NAS does not silently probe the wrong network path.

There is no ambiguous **Not configured** normal state. Owner-facing remote state is expressed as **Automatic setup**, **Ready**, **Needs attention**, or **Off by choice**.

If the NAS cannot establish an external endpoint automatically, LAN pairing remains valid. Zero1Local reports the concrete network problem and what remains for the network owner (for example, allowing/forwarding the displayed UDP port). The user still does not manually create WireGuard keys, peers, subnets, or routes.

The Android WireGuard private key never leaves the phone. Managed routes are **split tunnel only** and must never require `0.0.0.0/0` or `::/0`.

## Pair completion contract

The current request includes the single-use token, Android device identity, P-256 authentication public key, and Android WireGuard public key. `remote_access` is optional:

```json
{
  "pairing_token": "single-use-token",
  "device": {
    "id": "client-generated-uuid",
    "name": "Samsung SM-...",
    "platform": "android",
    "app_version": "0.2.3"
  },
  "auth_public_key": "BASE64-X509-SPKI-P256-PUBLIC-KEY",
  "auth_algorithm": "EC_P256_SHA256",
  "wireguard_public_key": "BASE64-WIREGUARD-PUBLIC-KEY",
  "remote_access": true
}
```

When automatic remote access is ready, `/pair/complete` returns the managed WireGuard configuration directly. When automatic endpoint setup needs attention, pairing still succeeds for LAN use and the response reports `action_required` with the real failure reason. An explicit LAN-only choice reports `disabled` / off by choice rather than “not configured.”

## Authentication

Pair completion receives the Android P-256 authentication public key (X.509 SPKI) and the phone's WireGuard public key. Private keys remain on Android.

Challenge/session authentication uses short-lived random challenges and `SHA256withECDSA`. Successful authentication issues a short-lived bearer session. Revoked devices cannot establish new sessions.

## File and transfer confinement

The Connect API supports native-share browsing, folder creation, rename, move, copy, delete/recycle behavior, duplicate checks, streaming downloads, and resumable uploads according to the bound user's effective native permissions.

Mobile-visible paths are relative to the selected shared folder. Zero1Local rejects `..` traversal, backslash/alternate-separator traversal, alternate encoding traversal, symlink/mount escape, stale IDs, IDs from another device/user, and unauthorized cross-share operations.

Possessing an opaque file ID is not authorization; the object is re-authorized on every request.

## Revocation

Revoking one phone invalidates its future authentication authority and managed WireGuard peer without changing the native Zero1Local shared-folder ACL or revoking other phones.

## Qualification boundary

Real-device qualification must prove numeric-LAN QR pairing, Nearby `_zero1local._tcp` discovery, manual pairing, both remote-access choices, one-time token behavior, root master behavior, normal-user native ACL inheritance, traversal confinement, file operations, resumable upload/download, managed WireGuard off-LAN access, full-tunnel rejection, multiple phones, revocation, and reboot/update persistence against the exact Android client under test.

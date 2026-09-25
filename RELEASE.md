# Zero1Local v1.2.9.14 — Google Device Authorization & Persistent UPnP Path

**PRE-RELEASE / TEST BUILD**

v1.2.9.14 addresses two failures proven on the designated Zero1Local test NAS.

## Google Drive authorization

The previously embedded OAuth client was proven in Google Cloud to be a Web application client. Google rejected that client at the device-code endpoint.

v1.2.9.14 embeds the newly created Zero1Local TVs and Limited Input devices OAuth client pair. The owner workflow remains credential-free: users select Sign in with Google and Zero1Local owns device authorization and token polling.

Provider acceptance is not claimed until the exact packaged artifact successfully completes live device authorization and token exchange.

## Zero1Connect automatic router mapping

Live v1.2.9.13 evidence proved that the Omada ER707-M2 exposes a valid InternetGatewayDevice/WANIPConnection service, returns SSDP responses to Zero1Local, and previously permitted automatic UPnP publication. Later renewals could fail when fresh SSDP discovery returned no locations.

v1.2.9.14 therefore:

- persists the validated UPnP description URL, control URL, service type and gateway;
- validates the cached control service with GetExternalIPAddress before reuse;
- reuses one validated UPnP service for both WireGuard UDP and bootstrap TCP mapping;
- rediscovers only when the cached service is absent or invalid;
- clears stale automatic endpoint/lease/renewal state when a publication transaction fails;
- exposes cached UPnP path evidence in diagnostics;
- no longer translates a transient automatic-mapping failure into the unsupported claim that the router requires manual forwarding.

PCP and NAT-PMP remain independent fallback mechanisms.

## Packaging

Use `Zero1Local-v1.2.9.14-production.zip`. The Windows installer and NAS deploy script name and SHA-256-pin the exact v1.2.9.14 runtime payload.

## Promotion boundary

This remains a **PRE-RELEASE / TEST BUILD** until the exact artifact passes Google authorization/token exchange, live Omada mapping/renewal, LTE/5G pairing/WireGuard, reboot persistence, update/rollback and remaining hardware acceptance checks.

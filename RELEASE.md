# Zero1Local v1.2.9.13 — Evidence-Driven Router Mapping & Google Diagnostics

## Scope

v1.2.9.13 is a corrective pre-release on the verified v1.2.9.12 lineage. Its release rule is evidence-first: documented protocol behavior or reproduced/live failure may justify a behavior change; an unproven theory may not.

## Automatic router mapping

- SSDP discovery binds local UDP port 43121.
- Strict nftables and netfilter-legacy rules admit routed-private-LAN traffic to UDP/43121 before INVALID-state filtering.
- Discovery records the selected Internet-facing interface, source address, gateway, reply port, returned SSDP locations, and chosen WAN control service.
- UPnP SOAP faults preserve provider code and description.
- `GetSpecificPortMappingEntry` error 714 is treated as the defined absent-entry result. Unsupported read-back remains a separate verification-unavailable state.
- `AddPortMapping` error 725 is treated as the defined permanent-lease-only result and is retried with `NewLeaseDuration=0`.
- PCP and NAT-PMP remain independent automatic fallbacks.
- Manual forwarding remains fallback behavior, not the assumed default.

## Google Drive

- The Zero1Local Google application credential remains embedded in the production application.
- The owner workflow contains no Google client-ID/client-secret fields.
- Device authorization uses Google's device-code endpoint with the client ID and `drive.file` scope.
- Provider rejection preserves HTTP status, provider error code, provider detail, credential source, and client ID in diagnostics.
- Google authorization success is not claimed until the exact release artifact succeeds against Google's live service.

## Packaging

Use `Zero1Local-v1.2.9.13-production.zip`. The Windows installer and NAS deploy script both name and SHA-256-pin the exact v1.2.9.13 runtime payload included beside them.

## Promotion boundary

The release remains **PRE-RELEASE / TEST** until the exact production ZIP passes installation/update/rollback, live automatic router mapping, remote LTE/5G pairing/WireGuard, Google Drive authorization/browse/transfer, SMART/LED, and reboot-persistence acceptance on the designated test hardware.

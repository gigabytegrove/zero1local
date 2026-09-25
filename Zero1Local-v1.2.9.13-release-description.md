# Zero1Local v1.2.9.13

Zero1Local v1.2.9.13 is an evidence-driven corrective pre-release.

## Zero1Connect / automatic router mapping

This release corrects a strict-firewall SSDP reply-path defect and improves standards-based UPnP diagnostics:

- binds UPnP discovery to dedicated local UDP reply port 43121;
- admits routed-private-LAN UDP traffic to destination port 43121 before INVALID/conntrack filtering;
- records the selected interface, source IP, gateway, reply port, returned SSDP locations, and selected WAN control service;
- preserves standardized UPnP SOAP fault codes and descriptions;
- interprets error 714 only as an absent specific port mapping;
- retries with a permanent lease only when the gateway explicitly returns error 725 (OnlyPermanentLeasesSupported);
- keeps PCP and NAT-PMP as independent automatic fallback mechanisms.

Manual forwarding remains a fallback only when automatic mapping actually fails.

## Google Drive

The embedded Zero1Local Google OAuth credential remains in the production application. Owners are not asked to enter Google application credentials.

Google device authorization uses the documented device-code request. If Google rejects device authorization, Zero1Local preserves the provider HTTP status, provider error code, provider detail, credential source, and client ID for diagnosis. This release does not claim Google authorization success until the exact artifact succeeds against Google's live service.

## Packaging

The Windows installer and NAS deploy script are release-coupled to the exact v1.2.9.13 runtime payload. The public installation asset is:

`Zero1Local-v1.2.9.13-production.zip`

Implementation source and private qualification/build material are not published in this repository.

## Release state

**Pre-release / test build.** Promotion requires live acceptance of installation/update/rollback, router mapping, remote LTE/5G pairing/WireGuard, Google Drive authorization and transfer, SMART/LED behavior, and reboot persistence on the designated Zero1Local hardware.

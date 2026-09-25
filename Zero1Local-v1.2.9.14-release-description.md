# Zero1Local v1.2.9.14

Zero1Local v1.2.9.14 is an evidence-driven corrective pre-release addressing two failures proven during live v1.2.9.13 testing.

## Google Drive device authorization

Google Cloud evidence proved the OAuth client embedded in the earlier build was a Web application client. v1.2.9.14 replaces it with the newly created Zero1Local TVs and Limited Input devices client pair. Credentials remain embedded in the private production application and are not exposed through the owner UI or public repository.

Live provider acceptance remains pending until the exact v1.2.9.14 artifact completes device authorization and token exchange.

## Zero1Connect automatic router mapping

Live v1.2.9.13 evidence proved the Omada ER707-M2 has a valid InternetGatewayDevice/WANIPConnection service, returns SSDP responses, and previously allowed Zero1Local automatic UPnP publication.

v1.2.9.14 persists and validates that WAN control path, reuses one validated service for both required port mappings, rediscovers only when necessary, clears stale automatic-publication state on failure, and stops presenting a transient automatic mapping failure as proof that manual forwarding is inherently required.

## Packaging

Public installation asset:

`Zero1Local-v1.2.9.14-production.zip`

Implementation source, private build material and embedded application credentials are not published in the public GitHub repository.

## Release state

**Pre-release / test build.** Promotion requires exact-artifact live acceptance of Google authorization/token exchange, Omada mapping/renewal, LTE/5G Zero1Connect bootstrap/WireGuard, reboot persistence, update/rollback and remaining hardware checks.

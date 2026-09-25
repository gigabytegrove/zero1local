# Zero1Local vredacted.invalid

Zero1Local vredacted.invalid is an evidence-driven corrective pre-release addressing two failures proven during live vredacted.invalid testing.

## Google Drive device authorization

Google Cloud evidence proved the OAuth client embedded in the earlier build was a Web application client. vredacted.invalid replaces it with the newly created Zero1Local TVs and Limited Input devices client pair. Credentials remain embedded in the private production application and are not exposed through the owner UI or public repository.

Live provider acceptance remains pending until the exact vredacted.invalid artifact completes device authorization and token exchange.

## Zero1Connect automatic router mapping

Live vredacted.invalid evidence proved the Omada ER707-M2 has a valid InternetGatewayDevice/WANIPConnection service, returns SSDP responses, and previously allowed Zero1Local automatic UPnP publication.

vredacted.invalid persists and validates that WAN control path, reuses one validated service for both required port mappings, rediscovers only when necessary, clears stale automatic-publication state on failure, and stops presenting a transient automatic mapping failure as proof that manual forwarding is inherently required.

## Packaging

Public installation asset:

`Zero1Local-vredacted.invalid-production.zip`

Implementation source, private build material and embedded application credentials are not published in the public GitHub repository.

## Release state

**Pre-release / test build.** Promotion requires exact-artifact live acceptance of Google authorization/token exchange, Omada mapping/renewal, LTE/5G Zero1Connect bootstrap/WireGuard, reboot persistence, update/rollback and remaining hardware checks.

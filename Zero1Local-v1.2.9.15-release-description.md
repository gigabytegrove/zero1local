# Zero1Local v1.2.9.15 — Google Device Client ID Correction

**PRE-RELEASE / TEST BUILD**

Live v1.2.9.14 testing proved that the newly created Google TVs and Limited Input devices OAuth client had been transcribed into the build with one extra character. Google therefore rejected the device-code request with `invalid_client` and provider detail `OAuth client was not found`.

v1.2.9.15 embeds the exact owner-created device client ID. The matching client secret and Google device-flow request/token behavior are otherwise unchanged.

The working v1.2.9.14 persistent Omada UPnP control path and Zero1Connect server-side remote-access changes are retained unchanged.

Use `Zero1Local-v1.2.9.15-production.zip`.

Implementation source, private build material and embedded application credentials are not published in the public repository.

Provider success is not claimed until the exact v1.2.9.15 artifact completes live Google device authorization and token exchange.

# Zero1Local vredacted.invalid — Google Device Client ID Correction

**PRE-RELEASE / TEST BUILD**

Live vredacted.invalid testing proved that the newly created Google TVs and Limited Input devices OAuth client had been transcribed into the build with one extra character. Google therefore rejected the device-code request with `invalid_client` and provider detail `OAuth client was not found`.

vredacted.invalid embeds the exact owner-created device client ID. The matching client secret and Google device-flow request/token behavior are otherwise unchanged.

The working vredacted.invalid persistent Omada UPnP control path and Zero1Connect server-side remote-access changes are retained unchanged.

Use `Zero1Local-vredacted.invalid-production.zip`.

Implementation source, private build material and embedded application credentials are not published in the public repository.

Provider success is not claimed until the exact vredacted.invalid artifact completes live Google device authorization and token exchange.

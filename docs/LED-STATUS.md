# Zero1Local chassis LED status reference — v1.2.6.5

## Proven hardware capability

The IronCow Zero1 chassis LED controller exposes separate red and green channels for the power/status LED and the two disk LEDs. Hardware evidence supports:

- green;
- red;
- yellow (red + green together);
- off;
- solid;
- fast flash; and
- slow flash where the underlying Twinkle command supports it.

There is no evidence that these indicators are RGB LEDs. Blue or arbitrary RGB colors must not be documented or exposed as available.

## Phone Transfer overlay policy

Phone Transfer status is a temporary overlay on the **power/status LED**. Disk 1 and Disk 2 retain their storage-health role.

| Phone Transfer state | Power/status LED |
| --- | --- |
| Active automatic/manual transfer | Fast flashing green |
| Transfer completed | Solid green for 5 seconds, then normal state |
| Phone needs user action / wrong USB mode | Slow flashing yellow |
| Transfer or verification failed | Fast flashing red |

Storage and thermal critical states outrank Phone Transfer overlays. When a phone overlay ends, Zero1Local restores the normal chassis status policy.

## Automatic readiness

A saved automatic Phone Transfer rule may wait without failing while the phone is physically connected but Android MTP / Apple file access is not ready. In that state, the power/status LED may slow-flash yellow until the phone becomes transferable.

An active Manual Phone Transfer session owns the phone while it is browsing/transferring. An automatic rule must wait rather than stealing the session or overwriting its active transfer indication.

## Error semantics

A red Phone Transfer indication must correspond to a visible task/UI failure. For Move operations, a verification failure leaves the source file on the phone. A disconnect during transfer is a transfer failure and must never be represented as success.

## Qualification boundary

The basic red/green/yellow/off channel behavior is based on exercised chassis controls. Specific Phone Transfer event sequences remain subject to real-hardware acceptance testing for the exact phone/USB path in use.

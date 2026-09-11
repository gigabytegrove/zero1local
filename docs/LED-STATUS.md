# LED Status

Zero1Local uses the IronCow chassis LED backend only when that hardware path is positively identified.

## Phone-transfer overlay

The **power/status LED** is used for phone state. Disk LEDs remain storage-oriented.

| Phone state | LED |
| --- | --- |
| Saved phone physically connected but wrong/not-ready USB mode | Slow-flashing yellow |
| Transferable mode detected/device acquired | Green |
| Transfer active | Fast-flashing green |
| Verified completion | Solid green for five seconds |
| Transfer/verification failure | Flashing red |

A pending automatic job must not overwrite the LED state of a phone currently owned by Manual Phone Transfer.

## Priority

Critical storage, thermal or system conditions retain priority over cosmetic/phone overlays. The LED controller should never hide a more important hardware warning just to display a phone event.

## Qualification note

Software state and physical LED observation are separate evidence. A software task entering `waiting` is not by itself proof that the chassis visibly displayed the correct color/pattern on every hardware revision.

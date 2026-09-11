# Phone Transfer

Zero1Local v1.2 provides two phone workflows:

1. **Automatic Phone Offload** — a saved rule bound to one physical phone.
2. **Manual Phone Transfer** — browse a connected phone and select individual files to Copy or Move.

Primary hardware qualification is centered on Android MTP on the IronCow Zero1. Apple support exists in the inherited phone path but should not be represented as hardware-qualified until exercised on real Apple hardware.

## Android connection mode

Android may connect as **Charging phone only**. Zero1Local cannot read MTP media in that mode. Unlock the phone, open its USB notification and select:

**Transferring files / Android Auto**

## Stable identity and nicknames

Automatic routing uses stable physical identity, not transient USB bus/device numbers. For Android, identity is derived from USB VID, PID and hardware USB serial; devices without a stable serial can be used interactively but cannot receive an automatic-on-connect rule.

Nicknames are display metadata only. A nickname such as `Brad's Phone` is associated with the stable device identity while the detected manufacturer/model remains visible underneath it.

## Manual Phone Transfer

Manual Android USB transfer uses direct libmtp and does not mount the phone through FUSE.

The manual MTP browser/device session has **no elapsed-time or idle timeout**. It remains owned until the user closes/cancels it, the phone disconnects, a real protocol/device failure occurs or the transfer takes ownership and completes.

There is **no arbitrary Zero1Local manual-selection file-count ceiling**. Very large selections remain subject to real device memory, browser, NAS and protocol constraints, but Zero1Local does not reject them merely because the count exceeds 500 or another invented threshold.

### Copy integrity

For each file:

1. stream the phone object into a private `.zero1-part-*` destination;
2. verify expected byte count;
3. calculate transfer SHA-256;
4. calculate NAS read-back SHA-256;
5. atomically promote the destination only after verification succeeds.

### Move integrity

Move performs the full Copy verification first. The source object is deleted from the phone **only after** the verified NAS destination exists. A failed/unverified Move must leave the source on the phone.

## Manual vs automatic ownership

Manual Transfer has priority. Automatic Phone Offload must never steal, close, expire or reopen the phone underneath a live manual session.

When an automatic rule is pending for a phone owned by Manual Transfer, the automatic task waits and leaves the manual task/LED state alone.

## Automatic readiness state machine

A physical connection is not the same as transfer readiness.

Normal Android sequence:

1. Zero1Local recognizes that the saved phone is physically connected.
2. If the phone is still in charging-only/wrong mode, Task Center remains in a non-failing waiting state.
3. The power/status LED slow-flashes **yellow**.
4. Zero1Local keeps waiting with **no readiness timeout**.
5. When MTP/file-transfer mode becomes available, Zero1Local acquires the device and changes the phone overlay to **green**.
6. Transfer starts; active transfer uses fast-flashing green.
7. Verified completion uses solid green for five seconds.

If the phone disconnects before it becomes ready, the pending automatic attempt ends cleanly. A later reconnect starts a new connect transition.

## Progress and control

Task Center shows:

- current file
- files completed / total files
- bytes transferred / total bytes when known
- percentage complete / remaining
- average effective transfer speed
- dynamic ETA
- ordered remaining-file queue
- Pause / Resume
- Stop after current file
- Cancel now

See [Task Center](TASK-CENTER.md).

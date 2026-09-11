# Task Center

Task Center is the owner-facing view for long-running work.

## Mobile transfer metrics

A running Manual Phone Transfer can show:

- current file
- completed / total files
- transferred / total bytes
- overall percentage complete
- percentage remaining
- current-file progress
- ordered remaining-file queue
- average effective transfer speed
- estimated time remaining

The queue preserves the original selection order. The UI may paginate the displayed queue for browser performance; this is **not** a transfer-count limit.

## Average speed

Average speed is an end-to-end effective throughput measurement: transferred bytes divided by active transfer time.

- deliberate Pause time is excluded;
- transfer/storage/verification overhead is included;
- this makes the number closer to the time the owner actually experiences than a raw USB-link speed claim.

## ETA

ETA is byte-based, not file-count based. It uses known remaining bytes and a smoothed combination of recent throughput and whole-transfer average. Early in a transfer it may display **Calculating…** until enough real progress exists.

The estimate should settle as more bytes are transferred. It is still an estimate: a queue that moves from small photos into very large videos, storage contention or a slower phone can change the effective rate.

## Controls

### Pause

Pause takes effect at the next safe verified file boundary. Zero1Local does not intentionally freeze a file halfway through destination verification.

### Resume

Resume continues the same server-side task/session and remaining queue.

### Stop after current file

The current file is allowed to finish safely; the task stops before the next selected file.

### Cancel now

Cancel aborts the active file, removes its private `.zero1-part-*` destination and leaves already-verified completed files intact. For Move, an unverified source file is not deleted from the phone.

## Browser sessions

Once a transfer is a server-side running task, browser/login session expiration or closing the page does not terminate it. Returning to Task Center after authentication shows the current backend task state.

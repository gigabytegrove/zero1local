# Zero1Local Task Center — v1.2.6.2

Task Center is the owner-facing place for background work that can outlive the current page or browser session.

## Task summaries

Normal task rows should answer:

- what is running;
- current state;
- progress when measurable;
- current item/stage when useful;
- whether owner action is required; and
- final outcome.

Developer diagnostics and feature checks belong under Advanced details rather than the primary task row.

## Transfer speed and ETA

Phone Transfer and other byte-oriented jobs may show transfer speed and approximate ETA when enough progress exists to make the estimate meaningful. ETA remains approximate because phone storage, USB behavior, file sizes, verification, and destination storage can change throughput during a run.

Paused tasks show **Paused** rather than an elapsed-time ETA.

## Automatic Phone Transfer waiting state

A saved Phone Transfer rule may create a running/waiting task before file transfer begins. Examples:

- **Phone connected · waiting for Transferring files / Android Auto mode**;
- **Phone ready · waiting for Manual Phone Transfer to finish**; and
- **Phone ready · starting automatic transfer**.

Wrong USB mode is not an immediate transfer failure. Disconnecting before transfer begins ends the pending attempt cleanly; reconnecting later may retrigger the saved rule.

## Phone Transfer controls

When supported safely by the active backend job, Phone Transfer may expose:

- **Pause** — pause at the next verified file boundary;
- **Resume** — continue the same transfer job;
- **Stop after current file** — finish/verify the current file, then stop; and
- **Cancel now** — cancel the active file as safely as possible and clean its partial destination.

For Move operations, source deletion occurs only after destination verification. A cancellation before verified deletion must leave the source intact.

## Task outcomes

Task states may include `running`, `pause_pending`, `paused`, `stop_pending`, `canceling`, `completed`, `stopped`, `cancelled`, or `failed`. Stopped/cancelled tasks are not failures. A failed task retains its actual progress instead of being rendered as 100% complete.

## Software Update tasks

Software Update tasks use update-specific stages rather than file-transfer terminology:

1. Downloading update
2. Opening update package
3. Verifying package
4. Checking this NAS
5. Installing update
6. Restarting Zero1Local
7. Verifying and cleaning up

Update progress persists across the expected management-service restart and is available through the session-independent Update Monitor.

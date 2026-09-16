# Zero1Local Phone Transfer — v1.2.6.3

Phone Transfer is a first-class workflow under **Sync & Backup → Phone Transfer**. The owner-facing product uses the name **Phone Transfer** consistently; older internal `/api/mobile-offload` identifiers may remain only for compatibility.

## Workspace layout

On desktop, Phone Transfer uses an approximately **80/20 split**:

- **Primary pane:** connected phones and saved automatic transfer rules.
- **Information pane:** Automatic Transfer guidance, Manual Transfer entry points, connection help, and an **Advanced / Feature checks** disclosure.

Feature checks and qualification details are not front-and-center owner content.

## Two workflows

### Automatic Phone Transfer

An automatic rule is bound to one physical phone identity and a NAS destination. When the saved phone is detected, Zero1Local waits for a transferable phone mode, then starts the rule when it can safely acquire the device.

Wrong Android USB mode is a waiting state, not an immediate failed transfer. The task should explain that the phone is connected and waiting for **Transferring files / Android Auto** mode.

### Manual Phone Transfer

Manual Transfer lets an authenticated owner browse a currently connected supported phone and select files for **Copy** or **Move** to a NAS folder.

The manual browser/session owns the connected phone while active. Automatic rules targeting that same phone wait until the manual session releases it.

## Android USB behavior

On the supported Zero1 NAS hardware, Phone Transfer uses the external USB path in host mode for Android MTP. The exact phone must present a transferable MTP interface before file browsing/transfer can begin.

Phone charging alone does not prove that MTP is ready.

## Device identity

Saved rules bind to a stable physical-device identity rather than a temporary USB bus address. Reconnection or reboot must not silently redirect a rule to a different phone.

Owners may assign a friendly name to a known phone without changing its underlying identity.

## Destination and shared-folder safety

Phone Transfer destinations are selected through normal Zero1Local storage/shared-folder authorization. A transfer may create a destination folder only inside the permitted destination root.

The transfer path must not bypass normal storage/share confinement simply because the source is a phone.

## Copy and Move integrity

For **Copy**, a destination file is not considered complete until the transfer finishes successfully.

For **Move**, the phone source is deleted only after the NAS copy has been verified. If transfer or verification fails, the phone source remains.

Temporary partial files use a Zero1Local-owned partial-file path/name and are removed or recovered according to the task outcome.

## Task Center integration

Phone Transfer work is server-side and continues independently of the browser session once started. Task Center reports progress, current file, speed/ETA when meaningful, waiting conditions, completion, cancellation, or failure.

Safe controls may include:

- Pause at a verified file boundary;
- Resume;
- Stop after current file; and
- Cancel now.

Controls are shown only when the backend supports them safely for the active job.

## LED behavior

Phone Transfer can temporarily use the power/status LED for waiting, active, completed, or failed states. See [LED Status](LED-STATUS.md). Storage/thermal critical status always has priority.

## Apple support and qualification

Apple/AFC support may exist in the inherited transfer path, but it must not be described as hardware-qualified until exercised successfully on real supported hardware.

Wi-Fi and Bluetooth phone transfer are not documented as supported Phone Transfer transports in v1.2.6.3.

## Qualification boundary

A build/package pass does not prove a phone workflow. Hardware-specific qualification requires real-device evidence for connection mode, browse/transfer, Copy/Move integrity, reconnect behavior, automatic rules, and reboot persistence on the applicable phone/device path.

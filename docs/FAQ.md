# FAQ

## Is v1.2 cumulative?

Yes. The production package installs the complete current Zero1Local release. You do not install earlier Zero1Local releases first.

## Can it start from a factory-stock IronCow Zero1?

Yes, on the supported factory path. Use the IP plus serial form of `Install-Zero1Local.ps1`; the wrapper performs the established root bootstrap before the normal cumulative install.

## Does Zero1Local replace the kernel?

No. v1.2 intentionally preserves the validated vendor kernel, bootloader and DTB.

## Why userspace NFSv3?

The validated vendor kernel lacks the kernel capability required by Zero1Local's intended kernel NFS path. v1.2 therefore uses pinned UNFS3 userspace NFSv3.

## What happens if the RAID/Main Storage disappears?

Zero1Local tries to prove the real Main Storage identity before allowing writes. If it cannot, it guards `/disk0` fail-closed so applications cannot silently fill root/eMMC.

## Is there a 500-file phone transfer limit?

No. v1.2 does not impose an arbitrary Zero1Local manual phone-selection count limit.

## Will an automatic phone job interrupt my manual transfer?

No. Manual Phone Transfer owns the phone. Automatic offload waits for that ownership to be released.

## Why is the power LED blinking yellow after I connect my phone?

For a saved automatic-offload phone, yellow means the device is physically present but not yet transferable—commonly because Android is still in charging-only mode. Select **Transferring files / Android Auto** on the phone.

## Does a web session timeout stop a running transfer?

No. Once running, the transfer is a server-side Task Center job.

## How is transfer ETA calculated?

From known remaining bytes and effective throughput. Deliberate pause time is excluded from the average; verification/storage overhead is included.

## Where is the Recovery Key?

In the main UI under **System → Recovery**. Store it somewhere outside the NAS.

## What is port 8089?

The independent Recovery Environment.

## Is generic ARM64 fully supported?

No. It is a compatibility target. IronCow-specific hardware behavior must not be assumed on another board.

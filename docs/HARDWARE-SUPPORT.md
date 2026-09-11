# Hardware Support

## Primary validated target

Zero1Local v1.2 is designed and release-tested first for:

- IronCow Zero1 NAS
- Rockchip RK3568 EVB8 LP4 V10 Board NAS
- ARM64
- vendor Debian 11 environment
- kernel 5.10.198
- root device `/dev/mmcblk0p6`
- Main Storage mounted at `/disk0`
- XFS on the validated production storage configuration
- Rockchip `twinkle` chassis LED backend

This is the **Native** hardware profile.

## Compatibility Mode

Other ARM64 NAS devices can only use capabilities that Zero1Local positively detects. Generic ARM64 compatibility does not imply support for IronCow-specific LEDs, storage assumptions, USB-controller behavior or recovery hardware.

Do not report an untested ARM64 board as fully supported merely because `zero1d` starts.

## Kernel policy

v1.2 intentionally preserves the target's kernel, bootloader and DTB. Kernel replacement is outside the normal product installation path.

The vendor 5.10.198 kernel does not provide the kernel capability Zero1Local requires for normal kernel NFS service, so v1.2 uses the separately installed userspace UNFS3 NFSv3 path.

## Phone USB hardware

The validated IronCow development path uses the external USB-A connector served by `fcc00000.dwc3`, placed into USB host role by `zero1-phone-usb-host.service`. Android MTP hardware behavior remains device-specific; Samsung hardware was used for primary Android development evidence.

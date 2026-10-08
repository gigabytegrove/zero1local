# Temporary Control4 EA-1 V2 Debian 13 build harness

This branch is an isolated build workspace for the Control4 C4-EA1-V2.
It does not alter the zero1local product or its main branch.

The produced kernel is a native Debian 13 amd64 kernel based on Debian's
linux-source-6.12 package, with the CE5310 hardware fixes forward-ported from
the proven openHC hardware research. The resulting kernel boots the Debian
root filesystem directly from /dev/mmcblk0p1 and is size-gated against
CEFDK's 7,417,856-byte protected-mode copy window.

No Buildroot rootfs and no kexec chain are part of the finished runtime.

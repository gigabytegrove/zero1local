#!/usr/bin/env bash
set -Eeuo pipefail
shopt -s nullglob

ART=/artifacts
WORK=/work
SRC="$WORK/linux"
OHC="$WORK/openhc"
LOG="$ART/build.log"
mkdir -p "$ART" "$WORK"
exec > >(tee -a "$LOG") 2>&1

echo "=== Control4 EA-1 V2 native Debian 13 kernel build ==="
date -u
uname -a
cat /etc/debian_version

apt-get update
apt-get install -y --no-install-recommends \
  linux-source-6.12 linux-config-6.12 \
  build-essential debhelper bc bison flex libssl-dev libelf-dev dwarves \
  rsync cpio xz-utils zstd kmod fakeroot git patch file \
  dpkg-dev ca-certificates python3

rm -rf "$SRC" "$OHC"

SRC_TAR=/usr/src/linux-source-6.12.tar.xz
test -s "$SRC_TAR"
tar -xJf "$SRC_TAR" -C "$WORK"
EXTRACTED="$(find "$WORK" -mindepth 1 -maxdepth 1 -type d -name 'linux-source-6.12*' | head -n1)"
test -n "$EXTRACTED"
test "$EXTRACTED" != "$SRC"
mv "$EXTRACTED" "$SRC"

git clone --filter=blob:none --no-checkout https://github.com/The1TrueJoe/openHC.git "$OHC"
git -C "$OHC" checkout 4d650dd7d397400d8d258efd52de8e0bc5a8052f

echo "Debian source: $(make -s -C "$SRC" kernelversion)"
echo "openHC hardware reference: $(git -C "$OHC" rev-parse HEAD)"

PATCHES=(
  0001-i2c-pxa-pci-enumerate-without-DT.patch
  0002-x86-ce5300-serial-clock-and-irq.patch
  0003-e1000-ce5300-fake-phy.patch
  0006-8250-ce5300-force-xscale.patch
  0009-spi-pxa2xx-ce5x00-ssp.patch
  0010-8250-ce5300-poll-tx.patch
  0011-8250-pci-ea-no-ce4100-uart.patch
  0012-8250-ce5300-gen3-fifo-dma.patch
  0013-i2c-pxa-build-on-x86_64.patch
  0014-ehci-ce5300-tdi-hostpc.patch
)

mkdir -p "$ART/patches"
for p in "${PATCHES[@]}"; do
  srcp="$OHC/board/ea/common/patches/linux/$p"
  echo ">>> applying $p"

  # Debian 6.12.111 differs from 7.1 only in the allocation line immediately
  # after this check (kzalloc(sizeof(*sds)) vs kzalloc_obj(*sds)). The first
  # three CE5310 I2C hunks apply verbatim; forward-port the fourth hunk
  # explicitly instead of dropping the no-DT requirement.
  if [ "$p" = "0001-i2c-pxa-pci-enumerate-without-DT.patch" ]; then
    set +e
    patch -d "$SRC" -p1 --forward --batch < "$srcp"
    rc=$?
    set -e
    if [ "$rc" -ne 0 ]; then
      rej="$SRC/drivers/i2c/busses/i2c-pxa-pci.c.rej"
      test -s "$rej"
      grep -Fq 'Missing device tree node.' "$rej"
      python3 - "$SRC/drivers/i2c/busses/i2c-pxa-pci.c" <<'PY'
import pathlib, sys
p = pathlib.Path(sys.argv[1])
s = p.read_text()
old = '''\tif (!dev->dev.of_node) {
\t\tdev_err(&dev->dev, "Missing device tree node.\\n");
\t\treturn -EINVAL;
\t}
'''
if old not in s:
    raise SystemExit("Debian 6.12 I2C DT guard not found")
p.write_text(s.replace(old, "", 1))
PY
      rm -f "$rej" "$SRC/drivers/i2c/busses/i2c-pxa-pci.c.orig"
    fi
    grep -Fq '#define CE4100_PCI_I2C_DEVS' "$SRC/drivers/i2c/busses/i2c-pxa-pci.c"
    ! grep -Fq 'Missing device tree node.' "$SRC/drivers/i2c/busses/i2c-pxa-pci.c"
    continue
  fi

  # Linux 6.12 has the pre-7.1 serial8250_handle_irq body, but the CE5300
  # requirement is identical: a timer-polled XScale port must not return early
  # solely because THRE is absent from IIR. Apply the semantic two-line change
  # directly when the 7.1-context patch does not match.
  if [ "$p" = "0010-8250-ce5300-poll-tx.patch" ]; then
    if ! patch -d "$SRC" -p1 --forward --batch < "$srcp"; then
      rm -f "$SRC/drivers/tty/serial/8250/8250_port.c.rej" "$SRC/drivers/tty/serial/8250/8250_port.c.orig"
      python3 - "$SRC/drivers/tty/serial/8250/8250_port.c" <<'PY'
import pathlib, sys
p = pathlib.Path(sys.argv[1])
s = p.read_text()
old = """\tif (iir & UART_IIR_NO_INT)
\t\treturn 0;
"""
new = """\t/*
\t * Intel CE5300 GEN3/XScale UARTs are timer-polled (irq == 0).  Their
\t * THRE condition is not reflected in IIR, so UART_IIR_NO_INT must not
\t * suppress the LSR-driven TX service on those ports.
\t */
\tif ((iir & UART_IIR_NO_INT) &&
\t    !(port->irq == 0 && port->type == PORT_XSCALE))
\t\treturn 0;
"""
if old not in s:
    raise SystemExit("Linux 6.12 serial8250 IIR early-return pattern not found")
p.write_text(s.replace(old, new, 1))
PY
    fi
    grep -Fq 'port->irq == 0 && port->type == PORT_XSCALE' "$SRC/drivers/tty/serial/8250/8250_port.c"
    continue
  fi

  if ! patch -d "$SRC" -p1 --forward --batch < "$srcp"; then
    echo "FAILED PATCH: $p"
    cp -a "$srcp" "$ART/patches/"
    find "$SRC" \( -name '*.rej' -o -name '*.orig' \) | while read -r f; do
      rel="${f#$SRC/}"
      mkdir -p "$ART/rejects/$(dirname "$rel")"
      cp -a "$f" "$ART/rejects/$rel"
    done
    exit 42
  fi
done

# Mirror only clean-room EA/common hardware drivers. The finished Debian kernel
# has no Buildroot or openHC runtime dependency. Audio/SGX are intentionally not
# registered in this first boot-critical build; storage/network/USB/serial/GPIO/
# I2C/PWM/SPI are the hardware required to make the controller a dependable
# Debian machine.
for mirror in "$OHC/board/common/kernel" "$OHC/board/ea/common/kernel"; do
  [ -d "$mirror/drivers" ] || continue
  (
    cd "$mirror/drivers"
    find . -type f \( -name '*.c' -o -name '*.h' -o -name 'Makefile' -o -name 'Kbuild' -o -name 'Kconfig' \) -print0
  ) | while IFS= read -r -d '' f; do
    rel="${f#./}"
    install -D -m0644 "$mirror/drivers/$rel" "$SRC/drivers/$rel"
  done

  while IFS='|' read -r mk line; do
    case "$mk" in
      ''|'#'*) continue ;;
      sound/*|drivers/gpu/*|drivers/video/*) continue ;;
    esac
    # Keep the clean-room CE5310 board drivers BUILT IN exactly as they were
    # written. Several intentionally use builtin_*_driver(), and turning their
    # obj-y registrations into modules creates a kernel that compiles but does
    # not actually bind the hardware. The EA-1 V2 has no BCM53125 managed
    # switch, so do not register the EA3-only switch board glue.
    case "$line" in
      *spi-ea-b53-board.o*) continue ;;
    esac
    obj="${line##*+= }"
    if ! grep -Fq "$obj" "$SRC/$mk"; then
      printf '\n# Control4 EA-1 V2 CE5310 hardware driver.\n%s\n' "$line" >> "$SRC/$mk"
    fi
  done < "$mirror/objs.mk"
done

# Debian's shipped amd64 configuration is the starting point.
CFG="$(find /usr/src/linux-config-6.12 -type f -name 'config.amd64_none_amd64*' | head -n1)"
test -n "$CFG"
case "$CFG" in
  *.xz) xz -dc "$CFG" > "$SRC/.config" ;;
  *) cp "$CFG" "$SRC/.config" ;;
esac

# Carry over the CE5310 size/platform decisions already proven on this silicon,
# then put the actual EA-1 V2 values on top. We intentionally do NOT use the
# openHC Wi-Fi fragment: this physical EA-1 V2 has Realtek 10ec:818b, not AR9485.
MERGE="$SRC/scripts/kconfig/merge_config.sh"
chmod +x "$MERGE"
CUSTOM="$WORK/ea1v2-debian.fragment"
cat > "$CUSTOM" <<'EOF'
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y

# Boot Debian directly from eMMC p1. Ignore CEFDK's stale 32-bit/media cmdline;
# these exact RAM ranges are the full-map values already proven on this unit.
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttyS0,115200 earlyprintk=serial,ttyS0,115200 pci=realloc,nocrs,routeirq memmap=exactmap memmap=68K@0 memmap=60K#0x11000 memmap=512K@0x20000 memmap=255M@1M memmap=1536M@0x10000000 root=/dev/mmcblk0p1 rootwait rw net.ifnames=0 biosdevname=0"
CONFIG_CMDLINE_OVERRIDE=y

# Boot-critical devices must be built in. No initramfs or kexec is required.
CONFIG_E1000=y
CONFIG_MMC=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_EXT4_FS=y
CONFIG_JBD2=y
CONFIG_FS_MBCACHE=y

# Debian/systemd fundamentals.
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_PROC_FS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_NET=y
CONFIG_CGROUPS=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_SECCOMP=y

# Actual EA-1 V2 Wi-Fi: Realtek RTL8192EE, PCI 10ec:818b.
CONFIG_WLAN=y
CONFIG_CFG80211=m
CONFIG_MAC80211=m
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_RTL_CARDS=m
CONFIG_RTL8192EE=m
CONFIG_RTLWIFI=m
CONFIG_RTLWIFI_PCI=m
CONFIG_RTLBTCOEXIST=m

# USB and Zigbee CP2104. CE5300 EHCI quirk is patched in above.
CONFIG_USB_SUPPORT=y
CONFIG_USB=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_PCI=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_CP210X=m

# CE5300 board hardware after root is mounted.
CONFIG_GPIOLIB=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_SYSFS=y
CONFIG_I2C=y
CONFIG_I2C_PXA=y
CONFIG_I2C_CHARDEV=m
CONFIG_HWMON=y
CONFIG_SENSORS_LM75=y
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_SPI=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_PXA2XX=m
CONFIG_MTD=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_SPI_NOR=y
CONFIG_SPI_MEM=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_NETDEV=m

# CEFDK is legacy BIOS-style boot; this board does not boot Linux through EFI.
# Keep security sane in userspace, but don't bake Debian's distro signing paths
# into this locally built kernel.
# CONFIG_EFI is not set
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_REVOCATION_KEYS=""
# CONFIG_MODULE_SIG is not set

# Keep the direct-boot bzImage beneath CEFDK's immutable 7,417,856-byte window.
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
# CONFIG_KALLSYMS is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_FTRACE is not set
# CONFIG_KPROBES is not set
# CONFIG_PROFILING is not set
# CONFIG_BPF_SYSCALL is not set
# CONFIG_HYPERVISOR_GUEST is not set
# CONFIG_PARAVIRT is not set
# CONFIG_VIRTUALIZATION is not set
# CONFIG_XEN is not set
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
# CONFIG_DRM is not set
# CONFIG_SOUND is not set
# CONFIG_MEDIA_SUPPORT is not set
# CONFIG_SCSI is not set
# CONFIG_ATA is not set
# CONFIG_NVME_CORE is not set
# CONFIG_MD is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set
# CONFIG_NET_SCHED is not set
# CONFIG_WERROR is not set
EOF

cd "$SRC"
"$MERGE" -m .config \
  "$OHC/board/ea/common/linux/common.fragment" \
  "$OHC/board/ea/common/features/emmc/linux.fragment" \
  "$CUSTOM"

make olddefconfig

# Refuse silent regressions on the things that make this a native boot rather
# than the old multi-stage handoff.
required=(
  'CONFIG_X86_64=y'
  'CONFIG_E1000=y'
  'CONFIG_MMC_SDHCI_PCI=y'
  'CONFIG_EXT4_FS=y'
  'CONFIG_CMDLINE_OVERRIDE=y'
)
for k in "${required[@]}"; do
  grep -Fxq "$k" .config || { echo "required config missing: $k"; exit 43; }
done
grep -Fq 'CONFIG_RTL8192EE=m' .config || { echo 'RTL8192EE did not survive Kconfig'; exit 43; }
grep -Fq 'CONFIG_I2C_PXA=y' .config || { echo 'I2C_PXA x86_64 enablement did not survive Kconfig'; exit 43; }
grep -Fq 'CONFIG_MTD_SPI_NOR=y' .config || { echo 'SPI-NOR support did not survive Kconfig'; exit 43; }

cp .config "$ART/config-control4-ea1v2-debian13-amd64"

# Compile the direct-boot image first so an oversized kernel fails before we
# spend time packaging modules.
make -j"$(nproc)" bzImage

BZ=arch/x86/boot/bzImage
test -s "$BZ"
BYTES="$(stat -c %s "$BZ")"
LIMIT=7417856
echo "bzImage bytes=$BYTES limit=$LIMIT"
printf '%s\n' "$BYTES" > "$ART/bzImage.size"
if [ "$BYTES" -ge "$LIMIT" ]; then
  cp "$BZ" "$ART/bzImage.OVERSIZE"
  echo "ERROR: kernel exceeds CEFDK direct-boot copy window"
  exit 44
fi

KREL="$(make -s kernelrelease)"
PKGVER="$(make -s kernelversion)-1+c4ea1v2.1"
echo "kernel release: $KREL"
echo "package version: $PKGVER"

# Build Debian .deb packages from the same source/config that produced the
# checked bzImage. This is the installed kernel; no Buildroot filesystem exists.
make -j"$(nproc)" bindeb-pkg KDEB_PKGVERSION="$PKGVER"

cp "$BZ" "$ART/vmlinuz-$KREL"
for f in "$WORK"/linux-*.deb; do
  [ -f "$f" ] && cp "$f" "$ART/"
done

# The Debian rootfs already on the controller needs these modules loaded after
# the root filesystem is up. Package the list next to the kernel packages.
cat > "$ART/control4-ea1v2.modules" <<'EOF'
gpio-intelce
gpio-ea-board
gpio-ohc-iomcu
pwm-ce5300
spi-ea-ce5xx
spi-pxa2xx-pci
i2c-pxa
lm75
ehci-pci
cp210x
rtl8192ee
EOF

cat > "$ART/README-FIRST.txt" <<EOF
Control4 EA-1 V2 native Debian 13 amd64 kernel
Kernel: $KREL
Base: Debian stable linux-source-6.12
Direct CEFDK limit: $LIMIT bytes
Built bzImage: $BYTES bytes

This kernel boots /dev/mmcblk0p1 directly with the proven full CE5310 RAM map.
It does NOT require the old signed-i686 -> kexec -> i386 -> kexec -> x86_64 chain.

Boot-critical support built in:
  Intel CE5310 x86_64
  Intel CE5300 e1000 MAC with no-PHY/fake-PHY fix
  PCI SDHCI eMMC
  ext4
  CE5300 serial quirks

Modules included:
  Realtek RTL8192EE (10ec:818b)
  CE5300 EHCI + CP210x USB/Zigbee
  CE5300 GPIO / EA board GPIO
  CE5300 I2C + LM75
  CE5300 PWM
  CE5300 SPI / boot SPI NOR
EOF

(
  cd "$ART"
  sha256sum * 2>/dev/null | grep -v 'SHA256SUMS' > SHA256SUMS
)

file "$BZ"
ls -lh "$ART"
echo "=== build complete ==="

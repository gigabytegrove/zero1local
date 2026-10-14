# Understanding the NAS status lights — Zero1Local v1.3.5

Zero1Local's supported Zero1 front panel uses a **power/status light** and separate lights for **Drive 1** and **Drive 2**. The verified hardware supports green, red and yellow (combined red+green) signals, with steady/flashing states. These are not arbitrary RGB lights.

The shipped application includes **animated visual examples**, so you do not need to interpret a blinking pattern from text alone. Open **Hardware → Customize lights** or **Help → Status light meanings**. The illustrations show default assignments, not necessarily the live state or a customized mapping, and viewing them does not control your actual LEDs.

## Power/status light

| Indication | Default interpretation |
| --- | --- |
| Green, steady | NAS operating normally |
| Green, fast flash | NAS starting up |
| Yellow, steady | Optional Internet-outage indicator; LAN service can still work |
| Yellow, fast flash | A NAS service needs attention |
| Red, fast flash | A potential system issue needs review |
| Red, steady | A critical system condition is reported |

If your NAS is intentionally blocked from the Internet by a segmented VLAN, the **optional Internet-outage light setting** can be disabled. An Internet warning by itself does not establish that local file sharing has stopped.

## Drive 1 and Drive 2 lights

These are independent of the power indicator. Check which physical bay is showing the warning.

| Indication | Default interpretation |
| --- | --- |
| Green, steady | Drive healthy and idle |
| Green, fast flash | Drive activity |
| Yellow, steady | **Drive health needs checking**; review the SMART detail |
| Yellow, fast flash | Drive or its mirror may be degraded or rebuilding |
| Red, fast flash | Critical drive-health concern; check backups and SMART |
| Red, steady | Expected disk failed or missing |

A yellow indicator does **not** automatically mean the drive must be pulled. Open **Storage → Drives** and read the actual reported health reason. Before considering a replacement, inspect RAID status, identify the correct slot and confirm independent backups.

## Temporary Phone Transfer signals

During an approved transfer the **power** light may temporarily override normal status. A green fast flash indicates copying; a brief steady green indicates completed transfer. Slow yellow flashing can mean a phone needs attention (for example, unlock it or select file access). Fast red flashing indicates a failed transfer or verification. Disk warning lights remain separate.

## What to do if a light concerns you

1. Identify **Power**, **Drive 1** or **Drive 2**.
2. Note the color and whether it is **steady**, **fast flashing** or **slow flashing**.
3. Check the matching information in **Notifications**, **System** or **Storage → Drives**.
4. Avoid disconnecting a drive or power-cycling during RAID recovery, active writes or updates without understanding the reported problem.

This is a guide to **v1.3.5 default behavior**. Device-specific custom patterns and hardware/USB capabilities vary. v1.3.5 is published as a **Beta / Release Candidate**, not Stable.

[Back to Zero1Local](../README.md) · [Mobile and network guide](LAN-MOBILE-AND-NETWORK.md)

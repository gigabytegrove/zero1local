# Getting Started

## 1. Know the target

Zero1Local v1.2 is release-tested first on the IronCow Zero1 NAS / Rockchip RK3568 EVB8 LP4 V10 Board NAS. Other ARM64 platforms are compatibility targets only.

## 2. Keep the NAS on a trusted LAN

The normal management UI is served at:

```text
http://<NAS-IP>/
```

A compatibility management listener is also retained on:

```text
http://<NAS-IP>:8088/
```

The independent Recovery Environment is:

```text
http://<NAS-IP>:8089/
```

Do not expose SMB, NFS, the management UI or recovery ports directly to the public Internet.

## 3. Install

Use the cumulative Windows installer. See [Installation](INSTALLATION.md).

## 4. Complete initial setup

After installation, work through the owner-facing UI in this order when applicable:

1. **Storage** — confirm Main Storage and RAID health.
2. **Files & Sharing** — review users, groups and shared folders.
3. **Connectivity** — confirm hostname, address and DNS policy.
4. **System → Recovery** — copy the Recovery Key and store it away from the NAS.
5. **Diagnostics** — run the system/readiness checks.
6. Configure optional services such as NFS, Docker apps, backup, remote access or Phone Transfer.

## 5. Preserve the Recovery Key

The Recovery Key is intentionally separate from the normal administrator password. Store a copy somewhere that remains accessible if the NAS management UI fails.

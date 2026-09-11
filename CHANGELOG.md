# Changelog

## v1.2.3

- Reworked stable GitHub discovery to combine GitHub Latest Release with release history and no-cache manual checks.
- Fixed the edge case where a fresh Latest release could be ignored when release history returned HTTP 304.
- Added a dedicated Software Updates workspace with separate Installed / Latest version status.
- Added release notes, package readiness, live download/install stages, recent releases, retry/error states, rollback visibility and advanced diagnostics.
- Completed desktop/tablet/mobile consumer-language and responsive-layout review for the updater.
- Preserved the locked v1.2 NAS feature baseline and canonical cumulative installer.

## v1.2

Zero1Local v1.2 is the current cumulative stable baseline.

Major areas included in the release:

- cumulative factory-stock-to-current installation path
- rollback-safe installation and independent recovery
- storage/RAID and `/disk0` fail-closed protection
- SMB, userspace NFSv3, users, groups and shares
- File Manager media improvements, image lightbox and video playback path
- Docker, Apps, backup, synchronization and networking workflows
- Manual and automatic Phone Transfer
- persistent phone nicknames and no-timeout manual MTP ownership
- unlimited manual phone selection count at the Zero1Local layer
- Task Center queue detail and transfer controls
- average effective phone-transfer speed and byte-based ETA
- automatic-phone wrong-mode waiting with yellow-to-green LED state
- manual/automatic phone-session isolation

See [RELEASE.md](RELEASE.md) for the public release notes.

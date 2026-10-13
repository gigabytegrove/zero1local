# Backup, Sync and Replication

Zero1Local groups protection work under **Sync & Backup**.

## Backup jobs

Persistent backup jobs can protect selected shared folders to local/USB destinations or supported remote targets. Depending on locally available tools, remote target types can include:

- SMB
- NFS
- rsync over SSH
- SFTP
- S3-compatible storage

Jobs can provide manual/daily/weekly scheduling, verification, include/exclude rules, bandwidth controls, retention where the destination can safely support pruning and Task Center failure history.

A copy on the same physical storage set is not represented as off-device disaster protection.

## Zero1Local replication

Zero1Local-to-Zero1Local replication uses a dedicated generated Ed25519 identity and resumable rsync transport. Peers can be connection-tested and jobs can be manual/daily/weekly with optional bandwidth limits.

## Cloud/off-site workflows

Zero1Local retains existing independent backup/replication functionality such as SMB, NFS, rsync/SSH, SFTP and supported S3-compatible targets. **Native Google Drive synchronization is deprecated and targeted for complete removal from future Zero1Local builds.** The vredacted.invalid and older published binaries have not yet been scrubbed.

**Syncria — Coming soon** is the planned separate Google Drive companion. Syncria will be a standalone Docker/native app; a future optional connector may provide health and summary status in Zero1Local. See [Syncria](SYNCRIA.md) and [legacy release retirement](LEGACY-RELEASE-RETIREMENT.md).

Never publish OAuth tokens or remote credentials in support issues.

## Restore

Restore operations are centralized in the protection/restore workflow. Configuration restore validates its archive, creates a recovery checkpoint and rolls configuration state back if the restored state cannot load or Samba cannot reconcile.

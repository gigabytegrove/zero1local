# SMB and NFS

## SMB

Samba is inventory-first: the live Samba configuration is authoritative. Zero1Local manages shares and account access against the actual active Samba environment rather than maintaining a disconnected shadow inventory.

The validated appliance uses Samba 4.x and a TDB passdb. Zero1Local verifies the effective Samba private directory/passdb during installation.

### Windows access

Use the NAS hostname or IP from Windows Explorer:

```text
\\<NAS-IP>\<share>
```

If Windows reports access denied after a Phone Transfer-created folder appears, first confirm the new folder's parent share is accessible and then use the File Manager/Phone Transfer destination again so v1.2 can reconcile known mobile destinations. Do not recursively `chmod 777` the whole array as a troubleshooting shortcut.

## NFS

The vendor kernel does not provide the required kernel NFS path, so Zero1Local offers userspace NFSv3 using pinned UNFS3 0.11.0.

NFS is optional at runtime. Enabling it installs/builds the required userspace service and manages exports under:

```text
/etc/zero1/nfs/exports
```

Service:

```text
zero1-unfs3.service
```

UNFS3 listens on NFS TCP/UDP 2049 and the configured mount service port used by the unit (`20048`).

## Share integrity

SMB/NFS configuration is checked against physical backing storage. Zero1Local should refuse operations that would make network definitions point outside the proven Main Storage contract.

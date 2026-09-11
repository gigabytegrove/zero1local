# Files, Users and Shares

## Share-first model

The owner-facing File Manager starts from live shared folders. It does not expose raw `/disk0` or internal factory/application directories as the normal browsing root.

Managed shares normally map to top-level Main Storage directories:

```text
/disk0/<share>
```

## Users and groups

Zero1Local provides a unified owner-facing users/groups model. Existing non-factory Linux identities can be adopted without UID/GID renumbering. Factory/system identities remain preserved but are hidden from normal owner workflows.

Account management can include, where supported:

- password management
- Samba enablement
- group membership
- display-name metadata
- account lock/unlock
- local SSH shell policy
- account expiration
- forced password change
- capability-gated user quotas

Account-policy mutations checkpoint Linux account databases and roll back on failure.

## Shared-folder permissions

Managed SMB shares require at least one SMB-enabled allowed user. New shares use a dedicated Unix group plus Samba access policy so filesystem access and SMB access stay aligned.

Phone Transfer destination folders inherit compatible parent ownership/group/access rather than creating private folders that SMB/NFS clients cannot traverse.

## Delete vs stop sharing

Zero1Local distinguishes data deletion from share-definition removal:

- **Delete shared folder** recycles the enumerated top-level contents before removing the SMB definition.
- **Stop sharing, keep files** removes network sharing while retaining the underlying data.

If recycling cannot complete safely, the share definition is not silently removed.

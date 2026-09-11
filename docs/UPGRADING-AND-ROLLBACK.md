# Upgrading and Rollback

## Upgrade method

Zero1Local upgrades use the same cumulative Windows production installer as fresh/current deployments. Download the new production ZIP, verify it, extract it to a new folder and run the normal installer against the NAS IP.

Do not manually replace `/opt/zero1-local/current` or copy individual helpers/binaries between releases as a routine upgrade method.

## Transaction model

Before mutating the active installation, the release validates:

- exact payload tree/checksums
- storage identity/health
- appliance compatibility
- transaction-space capacity
- recovery/service contracts

It then captures rollback state and quiesces relevant state writers before switching the release.

## Automatic rollback

If the new release fails final validation before healthy activation, the installer attempts to restore the previous healthy Zero1Local management endpoint. The Windows console reports the rollback result and the exact detailed NAS log.

## Recovery rollback

The independent Recovery Environment on TCP/8089 can roll back an installed release when an eligible previous release exists.

## Downgrade limits

Once native storage-layout migration has been committed, Zero1Local refuses to downgrade to a release that does not understand that native layout. Full Zero1Local-to-factory reversal is intentionally blocked where reverse migration is not independently qualified.

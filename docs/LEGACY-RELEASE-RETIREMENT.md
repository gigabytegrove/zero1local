# Historical Zero1Local production archives — retirement register

**Recorded 2026-10-13. Current published archives are not yet scrubbed.** This is the authoritative tracking register for withdrawing legacy Google Drive implementation from public distribution.

Zero1Local's final product architecture removes its native Google Drive integration entirely. [Syncria](SYNCRIA.md) will be marketed as a separate, optional companion, **Coming soon**. This document does not say any current ZIP has been remediated.

## Scope and caveats

- The public repository intentionally does not contain the private application source. Historical production ZIPs include compiled binaries and runtime files. **Changing the README, GitHub Release description, or ZIP filename cannot remove embedded functionality**.
- The stable `v1.2.9.15` explicitly shipped a Google OAuth credential correction and must be treated as containing the legacy feature.
- The archived release notes for 7 release(s) explicitly refer to Google functionality. Silence in other release notes is **not evidence of absence**.
- `v1.2.9.15` is currently the last published mainline stable artifact. Withdrawal of **all** release ZIPs before a tested replacement would leave users without a supported downloadable installer and break the public update path.
- Deletion of GitHub Release assets is a distribution control, **not** sanitization of previously downloaded copies, forked assets, public CDN caches, commit history or devices with an existing installation.
- Never overwrite an existing tag, silently mutate the binary bytes under an existing checksum, or describe a historical binary as Google-free.

## Required execution sequence

1. Rebuild from the canonical **private** Zero1Local source without built-in Google Drive features, routes, scheduler, OAuth flow or credentials; implement the user-facing Syncria **Coming soon** message.
2. Test source/binary/runtime/package with a feature-removal checklist, including historical upgrade paths and live NAS health, restore/rollback, shares and storage. Do not remove unrelated backup or cloud-independent features.
3. Publish a **new** versioned clean release and SHA-256 checksum. Explicitly qualify the GitHub updater to choose the new release.
4. Mark affected old release notes **Historical / retired — native Google Drive present — do not install** and remove their downloadable `*-production.zip` assets via authorized release administration. Preserve tags/notes for provenance.
5. Re-query all GitHub Releases and verify every legacy production asset is absent. Test that the updater cannot select retired assetless releases or downgrade into one.
6. Clean current repository documentation to reflect the actual version, while preserving honest historical changelog entries and Git provenance. Do not rewrite Git history to falsely claim the features were never shipped.

## Public release inventory (verified against GitHub API on 2026-10-13)

**37 release pages, each with a production ZIP currently published.** None of these ZIPs was unpacked or binary-audited during this documentation pass, and no existing asset was deleted.

| Release | Public package | Evidence classification |
| --- | --- | --- |
| [`v1.2.9.15`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.15) | `Zero1Local-v1.2.9.15-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.9.14`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.14) | `Zero1Local-v1.2.9.14-production.zip` | Legacy Google Drive referenced in release notes |
| [`v1.2.9.13`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.13) | `Zero1Local-v1.2.9.13-production.zip` | Legacy Google Drive referenced in release notes |
| [`v1.2.9.8`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.8) | `Zero1Local-v1.2.9.8-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.9.7`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.7) | `Zero1Local-v1.2.9.7-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.9.6`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.6) | `Zero1Local-v1.2.9.6-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.9.5`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.5) | `Zero1Local-v1.2.9.5-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.9.4`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.4) | `Zero1Local-v1.2.9.4-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.9.3`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.3) | `Zero1Local-v1.2.9.3-production.zip` | Legacy Google Drive referenced in release notes |
| [`v1.2.9.2`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.2) | `Zero1Local-v1.2.9.2-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.9.12`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.12) | `Zero1Local-v1.2.9.12-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.9.11`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.11) | `Zero1Local-v1.2.9.11-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.9.10`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.10) | `Zero1Local-v1.2.9.10-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.9.1`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9.1) | `Zero1Local-v1.2.9.1-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.9`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.9) | `Zero1Local-v1.2.9-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.8`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.8) | `Zero1Local-v1.2.8-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.7.0`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.7.0) | `Zero1Local-v1.2.7.0-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.6.7`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.6.7) | `Zero1Local-v1.2.6.7-production.zip` | Legacy Google Drive referenced in release notes |
| [`v1.2.6.6`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.6.6) | `Zero1Local-v1.2.6.6-production.zip` | Legacy Google Drive referenced in release notes |
| [`v1.2.6.5`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.6.5) | `Zero1Local-v1.2.6.5-production.zip` | Legacy Google Drive referenced in release notes |
| [`v1.2.6.1`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.6.1) | `Zero1Local-v1.2.6.1-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.6.4`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.6.4) | `Zero1Local-v1.2.6.4-production.zip` | Legacy Google Drive referenced in release notes |
| [`v1.2.6.3`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.6.3) | `Zero1Local-v1.2.6.3-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.6.2`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.6.2) | `Zero1Local-v1.2.6.2-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.6`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.6) | `Zero1Local-v1.2.6-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.5.4`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.5.4) | `Zero1Local-v1.2.5.4-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.5.3`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.5.3) | `Zero1Local-v1.2.5.3-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.5.2`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.5.2) | `Zero1Local-v1.2.5.2-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.5.1`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.5.1) | `Zero1Local-v1.2.5.1-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.5`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.5) | `Zero1Local-v1.2.5-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.4.27`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.4.27) | `Zero1Local-v1.2.4.27-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.4.26`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.4.26) | `Zero1Local-v1.2.4.26-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.4.25`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.4.25) | `Zero1Local-v1.2.4.25-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.4.24`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.4.24) | `Zero1Local-v1.2.4.24-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.4.23`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.4.23) | `Zero1Local-v1.2.4.23-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.4.22`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.4.22) | `Zero1Local-v1.2.4.22-production.zip` | Implementation not inspected — do not certify clean |
| [`v1.2.4.19`](https://github.com/gigabytegrove/zero1local/releases/tag/v1.2.4.19) | `Zero1Local-v1.2.4.19-production.zip` | Implementation not inspected — do not certify clean |

## Release gates for the Google-free replacement

- Zero active Google Drive backend routes, authorization endpoints, embedded credentials, scheduled tasks or linked runtime packages in the new build, verified independently.
- No functional native Google Drive UI or API controls; show **Syncria — Coming soon** only while the real connector is unavailable.
- Syncria remains optional, standalone and not coupled to Docker socket, a host management platform, or a separate updater service.
- Legacy Google accounts are not auto-migrated and retained state does not cause data loss. Cleanup of old OAuth tokens requires an explicit supported flow, not undocumented deletion.
- Install, upgrade, rollback and recovery remain tested on the designated NAS hardware.
- Every newly released ZIP has a unique version, public checksum and release notes documenting removal.


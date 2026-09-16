# Contributing to Zero1Local

Thanks for helping improve Zero1Local.

Zero1Local runs directly on NAS hardware and manages storage, files, users, networking, services, updates, and recovery. Changes must therefore prioritize preservation of owner data, deterministic rollback, and evidence from the actual target platform.

## Contribution principles

1. **Do not guess about hardware behavior.** When behavior depends on the Zero1 NAS, Debian vendor image, RK3568 platform, kernel configuration, storage layout, LEDs, USB, or services, provide direct evidence or clearly mark the behavior unqualified.
2. **Do not weaken safety gates.** Avoid bypasses around storage validation, path confinement, authentication, firewall policy, update validation, rollback, or recovery controls.
3. **Preserve existing features unless the change intentionally replaces them.** A UI cleanup must not silently remove backend capability.
4. **Keep local-first behavior.** Core NAS operation must not depend on a mandatory cloud account or vendor relay.
5. **Keep user-facing and developer-facing information separate.** Routine users should see task-oriented product language; implementation evidence and feature checks belong under Advanced/diagnostic surfaces.
6. **Maintain upgrade compatibility.** Existing persistent state and supported deep routes should be migrated or retained deliberately.

## Development checks

Before proposing a release change, run the relevant checks from `BUILD.txt`, including:

```bash
go test ./...
go test -race ./...
go vet ./...
node --check web/app.js
bash helpers/validate-web-capabilities.sh web/app.js packaging/ui-routes.txt
```

Shell changes should pass `bash -n`. Release artifacts must pass their exact SHA-256 manifests and route-validation gates.

## UI contributions

- Use the existing product information architecture rather than adding a new top-level item for every capability.
- Prefer grouped sections, rows, tables, and compact summary bands over nested cards.
- Keep feature checks and raw implementation data under Advanced disclosure.
- Preserve Light/Dark behavior and the supplied branding assets without recoloring or adding baked backgrounds.
- Keep terminology consistent with current product names such as **Phone Transfer**, **Docker Compose**, **VLANs**, and **Advanced Stats**.

## Storage and destructive operations

Changes that can format, replace, delete, move, restore, or overwrite owner data need explicit server-side validation and deliberate acknowledgement. UI confirmation alone is not a safety boundary.

## Zero1Connect changes

The Android client is developed independently. Backend work must follow the current integration contract, keep per-device identity and access separation, enforce scope/ACL checks server-side, and preserve split-tunnel managed WireGuard behavior.

## Licensing and attribution

By contributing, you agree that your contribution may be distributed as part of Zero1Local under the repository's Zero1Local Free Attribution License v1.0. Do not remove the original-author attribution or license notice.

# Contributing to Zero1Local

Zero1Local accepts useful fixes and improvements, but changes must preserve the product's local-first and evidence-first safety model.

## Development rules

- Do not remove existing behavior as an incidental part of another fix.
- Do not weaken storage, rollback, firewall, recovery or verification gates to make a test pass.
- Do not treat `/disk0` as safe merely because the directory exists. The physical Main Storage identity must be proven.
- Do not replace the validated kernel, bootloader or DTB as part of an ordinary Zero1Local change.
- Keep the full first-party source tree buildable; do not ship a binary-only implementation as the canonical source.
- Keep device-specific behavior evidence-gated. Do not describe untested hardware paths as qualified.
- Preserve manual Phone Transfer ownership and verification semantics.
- Keep public documentation synchronized with actual behavior.

## Validation

From the release source root:

```bash
go test ./...
go vet ./...
node --check web/app.js
bash -n scripts/install.sh
```

The release build uses Go 1.23.2 and produces Linux ARM64 binaries with:

```bash
CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -trimpath -ldflags="-s -w" -o bin/zero1d-linux-arm64 ./cmd/zero1d
CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -trimpath -ldflags="-s -w" -o bin/zero1-recovery-linux-arm64 ./cmd/zero1-recovery
```

See [Source and build](docs/SOURCE-AND-BUILD.md) and [Release verification](docs/RELEASE-VERIFICATION.md).

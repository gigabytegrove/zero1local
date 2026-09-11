# Source and Build

The production payload includes the full buildable first-party source tree.

## Main components

```text
cmd/zero1d/          primary Go management daemon
cmd/zero1-recovery/ independent Go recovery daemon
web/                 SPA UI
helpers/             appliance helpers
packaging/systemd/   service definitions
scripts/             install, verify, qualification and platform scripts
manifest.json        release contract/metadata
```

## Toolchain

Release toolchain: **Go 1.23.2**

## Validate

```bash
go test ./...
go vet ./...
node --check web/app.js
bash -n scripts/install.sh
```

## Build ARM64 binaries

```bash
CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -trimpath -ldflags="-s -w" -o bin/zero1d-linux-arm64 ./cmd/zero1d
CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -trimpath -ldflags="-s -w" -o bin/zero1-recovery-linux-arm64 ./cmd/zero1-recovery
```

Deterministic release verification rebuilds the binaries from the exact packaged source and compares them byte-for-byte with the shipped binaries.

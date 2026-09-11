# Release Verification — v1.2.4

## Production asset

```text
Zero1Local-v1.2.4-production.zip
SHA-256 7907eddfad6517b29de0aff50f1eeb294bb5a7dd437f0c2dd68f0583d1d91b5a
```

Payload:

```text
Zero1Local-v1.2.4.tar.gz
SHA-256 4db314fbee0fd8fdf7850ab3e684c668ba466edeb46324d8e6a979461398d809
```

Binaries:

```text
zero1d-linux-arm64
SHA-256 e9e75b94932c658da564cc23d833a034198d93c682df5c2c98405f78f594ea87

zero1-recovery-linux-arm64
SHA-256 bd193364b5f9c8f02d78a6e29d4e2efac7361567ebcad441435ec456ae204679
```

## Outer distribution contract

The ZIP root contains exactly five files:

```text
Install-Zero1Local.ps1
README.txt
SHA256SUMS.txt
Zero1Local-v1.2.4.tar.gz
deploy-on-nas.sh
```

The payload hash pinned by the Windows installer and the NAS deploy script equals the actual tarball hash.

## Internal release contract

v1.2.4 contains 154 internally checksummed payload files plus the `SHA256SUMS` self-manifest exception defined by the exact release-tree verifier. Missing, extra or hash-mismatched canonical files fail verification.

## Build and updater verification

The v1.2.4 release validation includes:

- Go tests and `go vet`;
- the full `zero1d` race-detector suite;
- JavaScript syntax validation;
- Python MTP helper self-test;
- shell syntax and manifest validation;
- direct-refresh route parity including `/updates`;
- ARM64 identity checks;
- deterministic rebuild of both shipped ARM64 binaries;
- update-cache path and pruning tests;
- canonical five-file update-package tests;
- archive traversal rejection tests; and
- a Linux updater failure-path integration test proving failed transaction workspace cleanup and persisted failure state.

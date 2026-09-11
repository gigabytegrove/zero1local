# Release Verification

## Production asset

```text
Zero1Local-v1.2-production.zip
SHA-256 6ecaf7a50897ca59a52c611fbe2774026e622e4e6533cd982940e7793c4770b9
```

Payload:

```text
Zero1Local-v1.2.tar.gz
SHA-256 de74c9560e008fb2d7c5c93cdbf514d866e68a5a19556dd5190d85e626aed987
```

Binaries:

```text
zero1d-linux-arm64
SHA-256 3643fa74fce3fdbc00f90f5ab28700b2677c8f02cf010d30ab7f9918130985dd

zero1-recovery-linux-arm64
SHA-256 9c16b2d43673074a38de8ba5179b1c89f9231374012492e0b7b2c80bbebf5d17
```

## Outer distribution contract

The ZIP root contains exactly five files:

```text
Install-Zero1Local.ps1
README.txt
SHA256SUMS.txt
Zero1Local-v1.2.tar.gz
deploy-on-nas.sh
```

The payload hash pinned by the Windows installer and the NAS deploy script must equal the actual tarball hash.

## Internal release contract

v1.2 was packaged with 142 internally checksummed payload files plus the self-manifest exception defined by the release verifier. The release-tree verifier rejects missing, extra or hash-mismatched canonical files.

## Build verification

The v1.2 release validation includes Go tests, Go vet, race-detector coverage, JavaScript syntax, Python MTP helper self-test, shell syntax, manifest validation, ARM64 identity and deterministic rebuild.

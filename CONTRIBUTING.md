# Contributing to Zero1Local

Thanks for helping improve Zero1Local.

## Public repository boundary

The public `gigabytegrove/zero1local` repository is a **documentation and production-release repository**. Zero1Local implementation source code is maintained privately/off-GitHub and is not published in the public repository.

Because the public repository does not contain the implementation source tree, public pull requests should focus on:

- documentation corrections and clarity;
- broken links;
- screenshots/branding/documentation assets when requested;
- reproducible bug reports;
- feature requests and product feedback; and
- security reports through the private process described in [`SECURITY.md`](SECURITY.md).

Do not submit guessed source patches against files that are not published.

## Useful bug reports

For software behavior, include:

- Zero1Local version;
- affected page/workflow;
- exact error text;
- smallest reproducible action sequence;
- whether the behavior survives a fresh browser load/reboot where relevant;
- whether the operation affects storage, files, network, recovery, or remote access; and
- logs/screenshots with passwords, tokens, private keys, recovery keys, and private file paths removed.

Hardware-dependent claims should identify the exact Zero1 NAS/phone/network path tested.

## Documentation contributions

Public documentation follows these principles:

1. **Evidence first.** Do not document hardware/network behavior as qualified without evidence.
2. **Owner language first.** Normal docs should use current product names such as **Phone Transfer**, **Docker Compose**, **VLANs**, **Access & API**, and **Advanced Stats**.
3. **Keep developer detail separate.** Qualification/check internals belong in advanced or release-policy documentation rather than basic owner workflows.
4. **Preserve the local-first model.** Do not describe a mandatory cloud account or vendor relay as required for core NAS operation.
5. **Do not publish source.** Public documentation must not instruct users to download, clone, or build private Zero1Local implementation source.

## UI/product feedback

When proposing UI changes, prefer centralized product organization over adding more cross-links and avoid turning every row or notice into a separate card.

The current primary areas are Home, Files & Sharing, Storage, Sync & Backup, Zero1Connect, Apps, Connectivity, and System.

## Licensing and attribution

Documentation contributions may be distributed with Zero1Local under the repository's Zero1Local Free Attribution License v1.0. Do not remove original-author attribution or license notices.

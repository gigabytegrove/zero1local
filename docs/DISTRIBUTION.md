# Distribution model

The public Zero1Local GitHub repository is a **production distribution and support repository**.

Public release assets contain the compiled Zero1Local ARM64 binaries and the runtime files required to install, operate, update, recover and support the product. This includes runtime helpers and scripts, web assets, service definitions, configuration, manifests/checksums, license terms and owner documentation.

The private canonical application source and developer build/test tree are **not distributed in the public repository or production release assets**.

Some runtime components are necessarily readable because the appliance executes or serves them directly, including PowerShell, shell, Python and browser JavaScript files. Their presence does not mean the private application source/build tree is being published.

For installation instructions, see [Installation](INSTALLATION.md). For release-package verification, see [Release Verification](RELEASE-VERIFICATION.md).

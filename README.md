# Zero1Local

**Take Back Control.**

Zero1Local is a local-first NAS management platform for compatible Zero1 / IronCow network-attached storage appliances.

It replaces the dependency on the original cloud-managed experience with a modern, locally hosted management interface while preserving the underlying vendor operating system and hardware support wherever practical.

Zero1Local is designed around a simple principle:

**If you own the hardware and the storage, you should be able to manage it locally.**

---

## Overview

Zero1Local transforms supported Zero1 NAS hardware into a locally managed storage appliance with a modern browser-based administration interface.

The project is designed to provide the core functionality expected from modern NAS platforms such as Synology DSM or QNAP QTS while remaining lightweight enough to operate on the original Zero1 hardware.

Zero1Local does **not** replace the entire operating system.

Instead, it installs a management and service layer on top of the existing Debian-based vendor environment, preserving useful hardware support and reducing unnecessary risk to the appliance.

---

## Features

Zero1Local is being developed as a complete local NAS management platform.

Current and planned functionality includes:

### Storage

* Physical disk inventory
* Disk health and status
* Storage utilization
* Mounted volume discovery
* Existing filesystem detection
* RAID visibility and management
* Storage pool management
* Safe handling of existing data
* Adopted storage support
* Storage usage visualization
* Disk and filesystem diagnostics

Zero1Local is designed to discover existing storage before attempting to manage it.

Existing disks, shares, and data should not be reformatted or replaced simply because Zero1Local is installed.

---

## File Sharing

### SMB / Samba

Zero1Local provides local SMB file sharing for Windows, macOS, Linux, and other compatible clients.

Functionality includes:

* SMB share creation
* Existing share discovery
* Share editing
* Share deletion
* User-based permissions
* Group-based permissions
* Guest access controls
* Read-only shares
* Read/write shares
* Adopted existing Samba shares
* Share path validation
* Samba configuration management

Existing SMB configuration is discovered wherever possible rather than blindly replaced.

---

### NFS

Zero1Local supports userspace NFS where the vendor kernel does not provide the kernel functionality required for traditional Linux NFS exports.

The supported direction for affected Zero1 appliances is userspace NFSv3.

This avoids replacing the vendor kernel simply to enable NFS functionality.

---

### FTP

FTP service management may be provided for environments that still require traditional FTP-compatible file access.

Secure alternatives should be preferred where practical.

---

### Apple Time Machine

Zero1Local is designed to support compatible SMB-based Time Machine shares for macOS systems.

---

## Users and Groups

Zero1Local provides centralized management of NAS users and groups.

Functionality includes:

* Create users
* Modify users
* Delete users
* Create groups
* Modify groups
* Delete groups
* Group membership management
* SMB account integration
* Password management
* Share permission assignment

Where configured, the Zero1Local administrative account can also be synchronized with the underlying operating-system account.

---

## Docker and Containers

Zero1Local includes container management capabilities intended to make Docker workloads practical on supported appliances.

Functionality includes:

* Docker service status
* Container listing
* Start containers
* Stop containers
* Restart containers
* Remove containers
* Image management
* Container port visibility
* Port mapping
* Environment variable management
* Volume mapping
* Container logs
* Image selection
* Container creation

Container management is intended to remain secondary to the appliance's primary NAS role.

---

## Networking

Zero1Local provides local network configuration and visibility.

Functionality includes:

* Network interface discovery
* IPv4 information
* IPv6 information
* Gateway information
* DNS configuration
* Interface status
* Link information
* MAC address visibility
* DHCP configuration
* Static addressing
* VLAN configuration
* Network diagnostics

Network changes are designed to minimize the risk of accidentally locking administrators out of the appliance.

---

## System Management

Zero1Local provides appliance-level system management including:

* CPU information
* Memory utilization
* System uptime
* Hostname
* Operating-system information
* Hardware information
* Service status
* System logs
* Network status
* Storage health
* Restart
* Shutdown
* Service control
* Diagnostic information

---

## Web Interface

Zero1Local includes an appliance-style browser management interface.

The primary management address is:

```text
http://<NAS-IP>/
```

Port `80` is the canonical Zero1Local management endpoint.

Legacy or compatibility listeners may exist depending on the installed version, but normal administration should use the primary address.

---

## HTTPS

Zero1Local supports optional HTTPS management.

HTTPS can be configured through the Zero1Local TLS settings.

TLS support is designed to:

* Require TLS 1.2 or newer
* Reject invalid certificate configuration
* Preserve certificates across upgrades
* Support locally generated certificates
* Regenerate managed self-signed certificates when necessary
* Avoid silently falling back to an insecure or unrelated certificate

HTTPS configuration must fail clearly when the configured certificate cannot be used safely.

---

## Local-First Design

Zero1Local is intentionally local-first.

The appliance should not require an external vendor service merely to perform ordinary NAS administration.

Core administration is designed to remain available directly over the local network.

Zero1Local aims to eliminate unnecessary dependencies on:

* Vendor cloud authentication
* Remote cloud dashboards
* Mandatory external management APIs
* Internet connectivity for ordinary NAS administration

Internet access may still be required for software updates, container image downloads, package installation, or other explicitly internet-dependent functions.

---

## Vendor Cloud Isolation

Zero1Local can isolate or disable the original cloud-dependent management components while preserving the underlying operating system.

This allows Zero1Local to become the primary management interface without unnecessarily replacing the vendor platform.

Isolation is designed to be:

* Controlled
* Reversible
* Upgrade-safe
* Ownership-aware
* Recoverable

Zero1Local-owned service overrides and systemd drop-ins are tracked so that uninstall and rollback operations do not indiscriminately remove unrelated system configuration.

---

## Installation

### Windows — Recommended Installation

Download both:

```text
Install-Zero1Local.ps1
Zero1Local-v<VERSION>-production.zip
```

Place both files in the same Windows directory.

Open PowerShell in that directory and run:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP>
```

Example:

```powershell
.\Install-Zero1Local.ps1 192.168.1.50
```

The installer handles the deployment process automatically, including:

* NAS connectivity checks
* SSH connection
* Bootstrap preparation
* Package upload
* Installation
* Upgrade handling
* Management service activation
* Port 80 management takeover
* Vendor management isolation
* Verification
* Recovery safeguards

The installer will request credentials when required.

---

## Manual Windows Deployment

The release can also be transferred manually.

Example:

```powershell
scp Zero1Local-v<VERSION>-production.zip root@<NAS-IP>:/root/
```

Connect to the NAS:

```powershell
ssh root@<NAS-IP>
```

Then perform the NAS-side installation.

---

## NAS-Side Installation

After placing the production ZIP in `/root`:

```bash
cd /root
```

Extract the release:

```bash
unzip -o Zero1Local-v<VERSION>-production.zip
```

Enter the extracted directory:

```bash
cd Zero1Local-v<VERSION>
```

Make the installer executable:

```bash
chmod +x install
```

Run the installer:

```bash
./install
```

For an existing Zero1Local installation, use the upgrade behavior provided by the release installer.

---

## Verification

After installation, open:

```text
http://<NAS-IP>/
```

Confirm that the Zero1Local management interface loads.

Basic system verification should include:

```bash
systemctl status zero1local
```

Where applicable, verify the local web listener:

```bash
ss -ltnp
```

And confirm that the management interface is responding on the expected address.

---

## Upgrading

Zero1Local releases are designed to support in-place upgrades.

The recommended Windows upgrade workflow remains:

```powershell
.\Install-Zero1Local.ps1 <NAS-IP>
```

with the matching production ZIP located beside the installer.

Example:

```text
Install-Zero1Local.ps1
Zero1Local-v0.1.20-production.zip
```

The installer detects the existing installation and performs the appropriate upgrade workflow.

Upgrades are expected to preserve:

* User data
* Storage
* Existing shares
* Users
* Groups
* Supported configuration
* Zero1Local state
* Managed TLS configuration
* Recovery information

---

## Uninstall and Recovery

Zero1Local is designed to be reversible.

The uninstall process should remove components owned by Zero1Local while avoiding removal of unrelated operating-system configuration.

Where Zero1Local has isolated vendor management services, uninstall should restore the appropriate original service state where possible.

Zero1Local does not intentionally delete user storage during uninstall.

Always maintain independent backups of important data before performing operating-system, storage, RAID, filesystem, or appliance-management changes.

---

## Safety

Storage software must be conservative.

Zero1Local follows an inventory-first approach.

The software should determine what already exists before attempting to create, modify, replace, or remove storage configuration.

Operations involving disks, RAID arrays, filesystems, shares, containers, networking, or system services should be treated as potentially disruptive.

Zero1Local is designed around:

* Explicit operations
* State discovery
* Validation
* Transactional changes where possible
* Rollback
* Recovery
* Preservation of existing configuration
* Failure visibility

Critical failures should be visible rather than silently ignored.

---

## Supported Platform

Zero1Local is currently developed primarily for Zero1 / IronCow NAS appliances using the original vendor Debian 11-based operating system.

Support for other hardware is not guaranteed.

Running Zero1Local on unrelated hardware should be considered experimental unless that platform is specifically listed as supported.

---

## Architecture

Zero1Local intentionally avoids replacing the vendor kernel unless there is an exceptional technical requirement.

This is particularly important on embedded NAS hardware where the vendor kernel may contain hardware-specific drivers, storage support, fan controls, LEDs, monitoring interfaces, or other appliance-specific components.

Where a feature can be implemented safely in userspace, that approach is preferred over replacing the kernel.

---

## Design Goals

Zero1Local should feel like dedicated NAS appliance software rather than a collection of Linux administration pages.

The management interface is designed around:

* Clear navigation
* Consistent controls
* Appliance-style workflows
* Responsive layouts
* Storage-first information design
* Human-readable status information
* Useful dashboards
* Immediate action feedback
* Light and dark interface support
* Minimal dependence on direct shell administration

The goal is to make the appliance usable by both technical administrators and users who simply want a locally managed NAS.

---

## Project Philosophy

Zero1Local is not intended to turn the appliance into a generic Linux server with a web panel attached.

It is intended to remain a NAS.

Every major feature should therefore be evaluated against the appliance's primary responsibilities:

1. Protect stored data.
2. Keep file services available.
3. Keep management access available.
4. Avoid unnecessary operating-system changes.
5. Make recovery possible.
6. Keep local ownership and control with the hardware owner.

---

## Development Status

Zero1Local is currently under active development.

The project is still in the pre-1.0 development cycle.

Current releases may introduce changes to:

* Internal architecture
* Management APIs
* Interface behavior
* Configuration formats
* Installation behavior
* Supported services

Upgrade compatibility and preservation of existing installations remain priorities throughout development.

---

## Versioning

Zero1Local uses semantic-style version numbering:

```text
vMAJOR.MINOR.PATCH
```

Example:

```text
v0.1.19
v0.1.20
v0.2.0
v1.0.0
```

Pre-1.0 releases represent active development.

---

## Release Files

Production releases normally include:

```text
Zero1Local-v<VERSION>-production.zip
Install-Zero1Local.ps1
```

The production ZIP contains the complete Zero1Local release.

The PowerShell installer provides the recommended deployment path from Windows.

---

## Bug Reports

When reporting an issue, include as much of the following information as possible:

* Zero1Local version
* NAS model
* Vendor firmware or OS version
* Browser
* Relevant service
* Exact error message
* Steps to reproduce
* Whether the problem started after an upgrade
* Relevant logs
* Expected behavior
* Actual behavior

Do not include:

* Passwords
* Private SSH keys
* Recovery keys
* API credentials
* Authentication tokens
* Other sensitive information

---

## Feature Requests

Feature requests are welcome where they support Zero1Local's primary purpose as a safe, locally managed NAS platform.

Features that unnecessarily require external cloud services, significantly reduce appliance reliability, or compromise data safety may not align with the goals of the project.

---

## Security

Security issues should not be disclosed publicly before they can be reviewed.

If a vulnerability could expose:

* Authentication credentials
* NAS data
* Administrative access
* Network configuration
* Remote code execution
* Privilege escalation

use the repository's private security reporting mechanism when available.

---

## Contributions

Contributions should preserve the core design principles of Zero1Local.

Changes should avoid:

* Unnecessary destructive operations
* Blind configuration replacement
* Dependencies on vendor cloud services
* Unnecessary kernel replacement
* Breaking existing shares
* Breaking existing users
* Removing existing functionality without a replacement
* Making installation irreversible
* Hiding operational failures

Contributions should include appropriate validation for the functionality being changed.

---

## Credits

**Zero1Local** is a **Gigabyte Grove** project.

**Original Author:** Brad Trammell

Development assistance, debugging, testing support, and implementation assistance have been provided with the use of OpenAI tools.

---

## Disclaimer

Zero1Local is an independent project.

It is not an official Zero1 or IronCow product unless explicitly stated otherwise by the respective rights holders.

Zero1, IronCow, and any other third-party product names or trademarks remain the property of their respective owners.

Installing third-party software on a NAS appliance may affect warranty coverage, vendor support, or future vendor updates.

Use Zero1Local at your own risk.

Always maintain independent backups of important data.

---

# Take Back Control.

Your NAS.

Your storage.

Your network.

**Your hardware.**

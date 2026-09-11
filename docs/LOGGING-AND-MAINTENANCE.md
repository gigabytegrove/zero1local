# Logging and Maintenance

## Fan-control logging

The validated fan policy remains temperature driven. v1.2.4 writes the hardware state at daemon start and when the effective requested speed changes. It does not continuously rewrite an unchanged state every ten seconds. Failed hardware writes are retried.

## Vendor systemd unit permissions

The IronCow vendor image has been observed with executable and/or world-writable permission bits on several `/lib/systemd/system/*.service` files. v1.2.4 normalizes only the exact observed regular files to `0644` and does not modify unit contents or follow symlinks.

## Controlled service restarts

A historical journal entry showing `status=15/TERM` around a deliberate Zero1Local stop/restart is not by itself proof of a crash. Capture the surrounding journal and confirm whether the service immediately returned healthy before reporting it as an application failure.

## Update cache

Online-update temporary files live under `/var/cache/zero1-local/updates`. Zero1Local owns and prunes this directory. Manual deployment staging under `/root/zero1local-deploy-*` is separate.

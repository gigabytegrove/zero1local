# Docker and Apps

Zero1Local adopts and manages the existing Docker engine rather than silently creating a new empty Docker data root.

## Data-root protection

The live engine's actual `DockerRootDir` is authoritative when available. During installation/upgrade Zero1Local records and verifies that data root. If Docker starts against a different root, activation fails rather than making existing containers appear to have vanished.

`zero1-docker.service` is ordered after `zero1-storage.service`, so the Main Storage identity/guard is established before Docker activation.

## Owner workflows

The UI includes:

- container inventory and lifecycle
- images/networks/volumes where supported
- guarded port remapping
- Compose stacks
- image pulls and Task Center integration
- managed App Catalog

## Bind mounts

Main Storage bind mounts are checked against storage safety. Clean Takeover also protects owner data referenced by Docker bind mounts rather than deleting a path merely because it resembles factory application data.

## Troubleshooting

Useful evidence:

```bash
systemctl status zero1-docker.service --no-pager
docker info --format '{{.DockerRootDir}}'
docker ps -a
cat /var/lib/zero1-local/docker-data-root 2>/dev/null
```

Do not manually change Docker's data root while diagnosing a missing-container problem.

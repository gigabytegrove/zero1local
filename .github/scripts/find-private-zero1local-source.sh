#!/usr/bin/env bash
# Read-only local source locator for the machine that was used to build Zero1Local.
# No source, credentials, files, or directories are uploaded or changed.
set -Eeuo pipefail
shopt -s nullglob

printf 'Zero1Local private source locator (read-only)\n'
printf 'Host: %s\n' "$(hostname 2>/dev/null || printf unknown)"
printf 'Date: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
printf '\n'

if (( $# > 0 )); then
  search_roots=("$@")
else
  search_roots=(/root /home /srv /opt /mnt/data)
fi

found=0
for root in "${search_roots[@]}"; do
  [[ -d "$root" && -r "$root" ]] || continue
  printf 'Scanning %s (same filesystem, maximum depth 8)\n' "$root"
  while IFS= read -r -d '' item; do
    case "$(basename -- "$item")" in
      go.mod)
        if grep -Eiq 'zero1.?local|ironcow' "$item" 2>/dev/null ||
           [[ "${item,,}" == *zero1* ]]; then
          printf 'CANDIDATE Go source: %s\n' "$(dirname -- "$item")"
          ((found+=1))
        fi
        ;;
      *[Zz]ero1*[Ss]ource*.tar.gz|*[Zz]ero1*[Ss]ource*.zip|*[Zz]ero1*[Ss]ource*.tgz|*[Zz]ero1*[Bb]uild*.tar.gz|*[Zz]ero1*[Bb]uild*.zip)
        printf 'CANDIDATE source archive: %s\n' "$item"
        sha256sum -- "$item" 2>/dev/null || true
        ((found+=1))
        ;;
      *) ;;
    esac
  done < <(
    find "$root" -xdev -maxdepth 8 \
      \( -type d \( -name .git -o -name node_modules -o -name .cache -o -name .npm -o -name .cargo -o -name vendor \) -prune \) -o \
      \( -type f \( -name go.mod -o -iname '*zero1*source*.tar.gz' -o -iname '*zero1*source*.tgz' -o -iname '*zero1*source*.zip' -o -iname '*zero1*build*.tar.gz' -o -iname '*zero1*build*.zip' \) -print0 \) 2>/dev/null || true
  )
done
printf '\nFound %d source candidates.\n' "$found"
if ((found == 0)); then
  printf 'No private source was found in these filesystem roots.\n'
  printf 'Search the original build workstation and its historical Downloads/source archives.\n'
fi

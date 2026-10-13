#!/usr/bin/env python3
"""Fail-closed static inspection of a Zero1Local production distribution.

This is NOT functional/source-level/hardware qualification. It detects some
known forbidden legacy feature strings in runtime code, and enforces package
identity/integrity. A pass cannot establish absence of dynamically-built APIs.
"""
from __future__ import annotations

import argparse
import hashlib
import io
import json
import re
import stat
import sys
import tarfile
import zipfile
from pathlib import PurePosixPath

MAX_PACKAGE = 256 * 1024 * 1024
MAX_MEMBER = 128 * 1024 * 1024
MAX_TOTAL_UNPACKED = 512 * 1024 * 1024
ELF_AARCH64 = 183
SCAN_SUFFIXES = {'.html', '.htm', '.js', '.mjs', '.css', '.json', '.py', '.sh', '.service', '.go', '.yaml', '.yml', '.toml'}
LEGACY_MARKERS = [
    re.compile(rb'https?://(?:www\.)?googleapis\.com/(?:auth/drive|drive/)', re.I),
    re.compile(rb'googleapis\.com/auth/drive', re.I),
    re.compile(rb'google\s+drive', re.I),
    re.compile(rb'google\s+oauth', re.I),
    re.compile(rb'/api/(?:cloud/)?google(?:/|\b)', re.I),
    re.compile(rb'/oauth/google(?:/|\b)', re.I),
    re.compile(rb'googleusercontent\.com/oauth2', re.I),
]


def safe_name(name: str) -> bool:
    if not name or '\\' in name or '\x00' in name or name.startswith('/'):
        return False
    path = PurePosixPath(name)
    return '..' not in path.parts and str(path) not in {'.', '/'}


def parse_sha256s(contents: bytes) -> dict[str, str]:
    out = {}
    for line in contents.decode('utf-8').splitlines():
        if not line.strip():
            continue
        match = re.fullmatch(r'([0-9a-fA-F]{64})\s+\*?([^\s].*)', line.strip())
        if not match or not safe_name(match[2]) or '/' in match[2]:
            raise ValueError('invalid SHA256SUMS entry')
        if match[2] in out:
            raise ValueError('duplicate SHA256SUMS entry')
        out[match[2]] = match[1].lower()
    if not out:
        raise ValueError('empty SHA256SUMS')
    return out


def check_package(zip_path: str, version: str) -> dict:
    errors = []
    warnings = []
    findings = []
    inspected = 0
    required = {
        'Install-Zero1Local.ps1', 'README.txt', 'SHA256SUMS.txt',
        f'Zero1Local-v{version}.tar.gz', 'deploy-on-nas.sh'
    }
    try:
        from pathlib import Path
        p = Path(zip_path)
        if not p.is_file() or p.stat().st_size > MAX_PACKAGE:
            raise ValueError('package missing or larger than safety limit')
        with zipfile.ZipFile(p) as z:
            infos = z.infolist()
            names = [i.filename for i in infos]
            if len(names) != len(set(names)):
                errors.append('duplicate ZIP member names')
            if any(not safe_name(n) for n in names):
                errors.append('unsafe ZIP member path')
            if set(names) != required:
                errors.append('ZIP does not have the exact five-file production layout')
            if any(i.is_dir() or (i.external_attr >> 16) & 0o170000 == stat.S_IFLNK for i in infos):
                errors.append('ZIP contains directory or symlink entries')
            if sum(i.file_size for i in infos) > MAX_TOTAL_UNPACKED or any(i.file_size > MAX_PACKAGE for i in infos):
                errors.append('ZIP expanded size exceeds safety limit')
            if errors:
                return {'result': 'FAIL', 'errors': errors, 'warnings': warnings, 'findings': findings}
            expected = parse_sha256s(z.read('SHA256SUMS.txt'))
            if set(expected) != required - {'SHA256SUMS.txt'}:
                errors.append('SHA256SUMS must cover all four other top-level files')
            for name, digest in expected.items():
                actual = hashlib.sha256(z.read(name)).hexdigest()
                if actual != digest:
                    errors.append(f'SHA256 mismatch: {name}')
            if errors:
                return {'result': 'FAIL', 'errors': errors, 'warnings': warnings, 'findings': findings}
            archive = z.read(f'Zero1Local-v{version}.tar.gz')
        with tarfile.open(fileobj=io.BytesIO(archive), mode='r:gz') as tar:
            members = tar.getmembers()
            if len(members) > 10000:
                errors.append('too many runtime tar members')
            if sum(m.size for m in members) > MAX_TOTAL_UNPACKED or any(m.size > MAX_MEMBER for m in members):
                errors.append('runtime tar expanded size exceeds safety limit')
            names = [m.name for m in members]
            if len(names) != len(set(names)):
                errors.append('duplicate runtime tar member names')
            for m in members:
                if not safe_name(m.name):
                    errors.append('unsafe runtime tar path')
                if not (m.isfile() or m.isdir()):
                    errors.append(f'unsupported runtime tar entry type: {m.name}')
            if errors:
                return {'result': 'FAIL', 'errors': errors, 'warnings': warnings, 'findings': findings}
            binary_count = 0
            for m in members:
                if not m.isfile():
                    continue
                data = tar.extractfile(m).read()
                inspected += 1
                lower = m.name.lower()
                filename = PurePosixPath(m.name).name.lower()
                if re.search(r'(?:^|[-_/])google[-_]?drive(?:[-_/]|$)', lower):
                    findings.append({'path': m.name, 'reason': 'legacy Google Drive runtime file name'})
                is_binary = filename.startswith(('zero1d', 'zero1-recovery')) and 'arm64' in filename
                if is_binary:
                    binary_count += 1
                    if not data.startswith(b'\x7fELF') or len(data) < 20 or int.from_bytes(data[18:20], 'little') != ELF_AARCH64:
                        errors.append(f'invalid ARM64 ELF: {m.name}')
                inspect = is_binary or PurePosixPath(m.name).suffix.lower() in SCAN_SUFFIXES
                if inspect and '/docs/' not in '/' + lower and 'license' not in filename:
                    for marker in LEGACY_MARKERS:
                        if marker.search(data):
                            findings.append({'path': m.name, 'reason': 'legacy Google Drive marker', 'marker': marker.pattern.decode('ascii')})
                            break
            if binary_count == 0:
                errors.append('no ARM64 zero1d or zero1-recovery runtime binary found')
    except (OSError, ValueError, KeyError, zipfile.BadZipFile, tarfile.TarError, UnicodeError) as e:
        errors.append(f'could not verify archive: {type(e).__name__}: {e}')
    if findings:
        errors.append('legacy Google Drive references detected in runtime; release cannot be promoted')
    warnings.append('Static scan is not proof of code removal, behavior, authorization safety, or hardware qualification.')
    return {
        'result': 'FAIL' if errors else 'STATIC_PASS_NEEDS_SOURCE_AND_HARDWARE_TESTS',
        'version': version, 'inspected_runtime_files': inspected,
        'errors': errors, 'warnings': warnings, 'findings': findings
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument('zip_path')
    parser.add_argument('--version', required=True, help='version number without v prefix')
    parser.add_argument('--json-out', help='optional report path')
    args = parser.parse_args()
    report = check_package(args.zip_path, args.version)
    data = json.dumps(report, indent=2, sort_keys=True) + '\n'
    print(data)
    if args.json_out:
        from pathlib import Path
        Path(args.json_out).write_text(data, encoding='utf-8')
    return 0 if report['result'] == 'STATIC_PASS_NEEDS_SOURCE_AND_HARDWARE_TESTS' else 1


if __name__ == '__main__':
    sys.exit(main())

#!/usr/bin/env python3
"""Synthetic fixture tests for fail-closed public package inspection."""
import hashlib
import importlib.util
import io
from pathlib import Path
import tarfile
import tempfile
import unittest
import zipfile

verifier = Path(__file__).with_name('verify-production-package.py')
spec = importlib.util.spec_from_file_location('gate', verifier)
gate = importlib.util.module_from_spec(spec)
spec.loader.exec_module(gate)
ARM64_ELF = b'\x7fELF\x02\x01\x01' + b'\x00'*11 + (183).to_bytes(2, 'little') + b'\x00'*64


def make_zip(target, *, marker=False, tamper=False, traversal=False, no_binary=False):
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode='w:gz') as t:
        members = {'runtime/zero1d-linux-arm64': ARM64_ELF + (b'Google Drive' if marker else b'local first')}
        if no_binary:
            members = {'runtime/file.sh': b'echo safe\n'}
        if traversal:
            members['../oops'] = b'unsafe'
        for name, data in members.items():
            i = tarfile.TarInfo(name)
            i.size = len(data)
            t.addfile(i, io.BytesIO(data))
    files = {
        'Install-Zero1Local.ps1': b'Write-Host okay',
        'README.txt': b'Safe',
        'deploy-on-nas.sh': b'#!/bin/sh\n',
        'Zero1Local-v9.0.0.tar.gz': buf.getvalue()
    }
    checksum = ''.join(f'{hashlib.sha256(data).hexdigest()}  {name}\n' for name,data in files.items()).encode()
    files['SHA256SUMS.txt'] = checksum
    if tamper:
        files['deploy-on-nas.sh'] += b'# corrupted'
    with zipfile.ZipFile(target, 'w') as z:
        for name,data in files.items():
            z.writestr(name,data)


class VerifyTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.package = Path(self.temp.name)/'package.zip'
    def tearDown(self):
        self.temp.cleanup()
    def test_good_static(self):
        make_zip(self.package)
        result = gate.check_package(str(self.package),'9.0.0')
        self.assertEqual(result['result'],'STATIC_PASS_NEEDS_SOURCE_AND_HARDWARE_TESTS',result)
    def test_reject_legacy_google_drive(self):
        make_zip(self.package,marker=True)
        result = gate.check_package(str(self.package),'9.0.0')
        self.assertEqual(result['result'],'FAIL')
        self.assertTrue(result['findings'])
    def test_reject_checksum_mismatch(self):
        make_zip(self.package,tamper=True)
        self.assertEqual(gate.check_package(str(self.package),'9.0.0')['result'],'FAIL')
    def test_reject_path_traversal(self):
        make_zip(self.package,traversal=True)
        result=gate.check_package(str(self.package),'9.0.0')
        self.assertEqual(result['result'],'FAIL')
        self.assertTrue(any('unsafe' in x for x in result['errors']))
    def test_reject_missing_arm64_runtime(self):
        make_zip(self.package,no_binary=True)
        self.assertEqual(gate.check_package(str(self.package),'9.0.0')['result'],'FAIL')
    def test_reject_duplicate_zip_file(self):
        make_zip(self.package)
        with zipfile.ZipFile(self.package, 'a') as z:
            z.writestr('README.txt','duplicate')
        self.assertEqual(gate.check_package(str(self.package),'9.0.0')['result'],'FAIL')
    def test_reject_incorrect_version(self):
        make_zip(self.package)
        self.assertEqual(gate.check_package(str(self.package),'9.0.1')['result'],'FAIL')
    def test_invalid_paths(self):
        for name in ('../evil','/absolute','a\\b','', 'a/../b'):
            self.assertFalse(gate.safe_name(name),name)


if __name__ == '__main__':
    unittest.main(verbosity=2)

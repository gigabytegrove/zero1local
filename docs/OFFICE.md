# Office Integration

Zero1Local's File Manager can open supported documents through its Office integration.

The UI provides the Office workflow from the selected file. If the required Office service is not installed/configured, Zero1Local presents the setup/install path rather than treating that as a permanent file error.

Office/WOPI behavior is same-origin aware and uses the active appliance address rather than assuming one development NAS IP.

If Office fails while ordinary File Manager downloads work, collect:

- file type and approximate size
- browser error
- `zero1-local.service` log lines from the attempted open
- Office/container status from the Apps/Docker UI
- the NAS hostname/IP used in the browser

Do not expose the Office service directly to the public Internet merely to work around local routing/certificate issues.

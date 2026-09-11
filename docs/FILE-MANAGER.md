# File Manager

## Scope

File Manager is share-first. The normal root is built from live SMB shares; raw `/disk0` and internal application/factory trees are not presented as ordinary owner folders.

## Supported operations

Within a selected share, v1.2 supports:

- browse
- upload/download
- New folder
- copy/move/rename
- Recycle Bin and restore
- permanent Recycle Bin deletion / empty bin
- bounded recursive name search
- folder properties
- previews
- ZIP creation
- path-traversal-safe ZIP extraction
- favorites and recent files
- Office integration

Share roots themselves remain protected from ordinary File Manager mutation.

## Images

Supported image previews open in a lightbox. Controls include:

- zoom in/out
- reset
- Ctrl/Cmd + mouse-wheel zoom
- zoom range from 25% through 800%
- Open Original

The media path is no longer constrained by the older 8 MB inline-preview ceiling.

## Video

Video uses HTTP range streaming so browser-native formats can seek normally. Where a format is not browser-compatible and VLC/cvlc is installed on the appliance, Zero1Local can use the VLC-compatible fallback path. Availability depends on the appliance's installed media tooling and the actual codec/container.

## Recycle Bin

Deletes use the visible Zero1Local Recycle Bin rather than treating removal as an immediate permanent unlink. Share-deletion workflows also use the Recycle Bin before network-sharing metadata is removed.

## Troubleshooting media

If a video does not play:

1. confirm the file downloads normally;
2. test a browser-native format;
3. check whether VLC/cvlc is installed on the NAS;
4. inspect `zero1-local.service` logs for the media request;
5. do not assume every codec can be transcoded by a browser alone.

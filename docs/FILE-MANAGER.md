# Zero1Local File Manager — v1.2.9

Zero1Local File Manager remains confined to authorized shared-folder roots. Browser-visible file IDs and relative paths are not permission boundaries by themselves; every operation is re-authorized server-side against the active user/session and share scope.

## Images

Images are streamed from the selected shared folder and open in the built-in viewer. Supported controls include:

- Fit and 100% views;
- zoom from 10%–1000%;
- mouse-wheel zoom;
- drag-to-pan;
- rotation;
- full screen;
- natural dimensions;
- keyboard previous/next navigation; and
- a thumbnail filmstrip for images in the current folder.

Streamed image previews are not limited by the text-preview memory ceiling.

## Video

Browser-native formats such as common MP4/WebM files stream inline with browser controls and HTTP range/seeking support.

For formats that are not normally browser-native, Zero1Local can use the installed VLC compatibility path to provide a browser-playable stream. The required VLC components are part of the supported appliance deployment path; owners are not expected to install them manually.

## PDFs, text, and code

PDFs stream inline. Common text and source-code files open in a syntax-aware viewer with line numbers, wrapping, copying, and a local edit mode.

The in-memory preview ceiling remains for text-oriented preview types such as text/JSON/XML. It does not apply to streamed images, video, or PDF content.

Browser edits are downloaded as an edited copy unless a specific File Manager workflow explicitly performs a server-side write. The viewer does not silently overwrite NAS files.

## Safety boundary

The File Manager must never expose absolute host filesystem paths. Path traversal, alternate separators/encoding, symlink escape, stale opaque IDs, and cross-scope object reuse must be rejected by the server-side confinement/authorization path.

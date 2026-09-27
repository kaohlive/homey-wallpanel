# The web flasher

`index.html` is the page; the manifests next to it say which image belongs to which board.

It is published by CI, not by hand. On a release the workflow in the firmware repository
rebuilds the `gh-pages` branch from scratch: this page, a manifest with the version filled
in, and the factory image beside it. Keeping the image on the same origin as the page is
deliberate — the browser fetches it while flashing, and a redirect to a download host is one
more thing that can fail in the middle of writing to a board.

That branch is force-pushed as a single commit each time, so published binaries never pile
up in the history.

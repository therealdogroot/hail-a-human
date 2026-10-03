#!/bin/sh
# Renders the share image and favicon set from the HTML sources in this folder.
# Requires macOS (sips) and Google Chrome. Fonts load from Google Fonts, so you need a network connection.
set -e
cd "$(dirname "$0")/.."
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
TMP="$(mktemp -d)"
shot() { # src out width height
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --virtual-time-budget=8000 --window-size="$3,$4" --screenshot="$2" "file://$PWD/$1" >/dev/null 2>&1
}
shot design/og-image.html og-image.png 1200 630

# Headless Chrome has a minimum viewport, so render icons at 512 and downscale.
shot design/favicon.html "$TMP/full.png" 512 512
shot "design/favicon.html?small=1" "$TMP/flat.png" 512 512
cp "$TMP/full.png" icon-512.png
sips -z 192 192 "$TMP/full.png" --out icon-192.png >/dev/null
sips -z 180 180 "$TMP/full.png" --out apple-touch-icon.png >/dev/null
sips -z 32 32 "$TMP/flat.png" --out favicon-32x32.png >/dev/null
sips -z 16 16 "$TMP/flat.png" --out favicon-16x16.png >/dev/null
python3 design/make_ico.py favicon-16x16.png favicon-32x32.png favicon.ico
rm -rf "$TMP"
echo "done"

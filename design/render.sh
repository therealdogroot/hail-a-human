#!/bin/sh
# Renders the share image and favicon PNGs from the HTML sources in this folder.
# Requires Google Chrome. Fonts load from Google Fonts, so you need a network connection.
set -e
cd "$(dirname "$0")/.."
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
shot() { # src out width height
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --virtual-time-budget=8000 --window-size="$3,$4" --screenshot="$2" "file://$PWD/$1" >/dev/null 2>&1
}
shot design/og-image.html og-image.png 1200 630
for s in 512 192 180 32 16; do
  shot "design/favicon.html?s=$s" "/tmp/hah-icon-$s.png" "$s" "$s"
done
cp /tmp/hah-icon-512.png icon-512.png
cp /tmp/hah-icon-192.png icon-192.png
cp /tmp/hah-icon-180.png apple-touch-icon.png
cp /tmp/hah-icon-32.png favicon-32x32.png
cp /tmp/hah-icon-16.png favicon-16x16.png
python3 design/make_ico.py /tmp/hah-icon-16.png /tmp/hah-icon-32.png favicon.ico
echo "done"

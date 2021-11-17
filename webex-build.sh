#!/usr/bin/env sh

set -eux

# install -Dm0755 apply_extra.sh "${FLATPAK_DEST}/bin/apply_extra"
install -Dm0755 webex.sh "${FLATPAK_DEST}/bin/webex"
install -Dm0644 "${FLATPAK_ID}.metainfo.xml" "${FLATPAK_DEST}/share/metainfo/${FLATPAK_ID}.metainfo.xml"

bsdtar -Oxf Webex.deb 'data.tar.*' |
  bsdtar -xf - \
    --strip-components=3

# There is probably a better way to do this...
cp -r bin/* "${FLATPAK_DEST}/bin"
cp -r lib/* "${FLATPAK_DEST}/lib"
cp -r qml "${FLATPAK_DEST}/"

install -Dm0644 bin/webex.desktop "${FLATPAK_DEST}/share/applications/${FLATPAK_ID}.desktop"
sed -i s:Exec=/opt/Webex/bin/CiscoCollabHost:Exec=webex: "${FLATPAK_DEST}/share/applications/${FLATPAK_ID}.desktop"
# Cisco erroniously supplies the Webex version here instead of the Freedesktop .desktop spec version
sed -i 's/.*Version.*/Version=1.0/' "${FLATPAK_DEST}/share/applications/${FLATPAK_ID}.desktop"
desktop-file-edit --set-key="Comment" --set-value="webex startup script" "${FLATPAK_DEST}/share/applications/${FLATPAK_ID}.desktop"
desktop-file-edit --set-key="Icon" --set-value="${FLATPAK_ID}" "${FLATPAK_DEST}/share/applications/${FLATPAK_ID}.desktop"

for size in 64 128 264 512; do
    convert bin/sparklogosmall.png -resize ${size} "${FLATPAK_ID}.png"
    install -Dm0644 "${FLATPAK_ID}.png" "${FLATPAK_DEST}/share/icons/hicolor/${size}x${size}/apps/${FLATPAK_ID}.png"
done

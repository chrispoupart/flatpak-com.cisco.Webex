#!/usr/bin/env sh

set -e

bsdtar -Oxf Webex.deb 'data.tar.*' |
  bsdtar -xf - \
    --strip-components=3 \

rm -rf Webex.deb

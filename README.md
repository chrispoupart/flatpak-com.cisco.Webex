# Cisco Webex Flatpak

## Description

[Webex](https://www.webex.com/) is Cisco's unified communication platform. In
2021 they released some packages for a limited range of Linux distributions.
Unfortunately, they do not support RHEL versions released in the past year, nor
do they support distros other than Ubuntu LTS.

Currently, requests by the community for a Flatpak or snap have gone unheeded.

This project attempts to repackage the Linux package as a Flatpak so that it can
be used on any modern Linux distro.

## Building
| 🚨   |
| :--- |
| This package doesn't currently work! |

In order to build this package, you will need the following:

1. Follow the [Building your first
   flatpak](https://docs.flatpak.org/en/latest/first-build.html) guide to make
   sure that you have the required setup on your computer.
1. Clone this repository. Because we are using submodules, you will also want to
   add and init those submodules. The easiest way to do that is to pass the
   `--recuse-submodules` on your `git clone` command.
1. Make sure that you have the base flatpak installed. You can see which ones
   are required in the top of the `com.cisco.Webex.json` file.
1. Run and install your build: `flatpak-builder build com.cisco.Webex.json
   --install --force-clean --user`

## Known Issues

* [Zypak
  wrapper](https://github.com/chrispoupart/flatpak-com.cisco.Webex/issues/1) not
  work with the Webex forking method. Hopefully, this will be resolved in Zypak
  soon.
* Cisco does not version their webex packages. This means that periodically, the
  build will fail due to checksum mismatches, at which point we need to update
  the checksums, as well as extract the Webex build number from the Debian
  package and populate that in our scripts.
* Cisco has botched the `.desktop` spec by placing the release number of Webex
  in the `version` key, instead of the intended spec version. (fixed in
  `webex-build.sh`).

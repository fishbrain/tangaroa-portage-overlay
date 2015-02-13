## Tangaroa Portage Overlay

Tangaroa is the grandfather of Ikatere, Fish god and father of all sea creatures.

## Purpose

This repository holds custom ebuild files (Gentoo package definitions) used by Fishbrain on some of their backend servers.

## HowTo

FishBrain servers pull this overlay automatically, but if you want to take anything from here, you can configure your repos.conf with the following, or adapt it to your needs:

```
[tangaroa]
auto-sync = true
sync-type = git
sync-uri = git://github.com/Fishbrain/tangaroa-portage-overlay.git
location = /usr/local/portage/tangaroa
```

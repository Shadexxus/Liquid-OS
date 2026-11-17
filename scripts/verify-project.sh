#!/usr/bin/env bash
set -Eeuo pipefail
project="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
"$project/scripts/check-source.sh"
PYTHONPYCACHEPREFIX="$(mktemp -d)" python3 -m py_compile "$project/config-overlay/includes.chroot/usr/local/bin/liquid-control-center"
for app in "$project"/config-overlay/includes.chroot/usr/share/applications/*.desktop "$project"/config-overlay/includes.chroot/etc/skel/.config/autostart/*.desktop; do
  grep -q '^\[Desktop Entry\]' "$app"
done
printf 'Python ve Desktop Entry kontrolleri: BAŞARILI\n'

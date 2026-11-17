#!/usr/bin/env bash
set -Eeuo pipefail
PROJECT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
for script in "$PROJECT"/scripts/*.sh; do bash -n "$script"; done
for f in \
 "$PROJECT/config-overlay/package-lists/00-base.list.chroot" \
 "$PROJECT/config-overlay/package-lists/10-desktop.list.chroot" \
 "$PROJECT/config-overlay/package-lists/20-audio-apps.list.chroot" \
 "$PROJECT/config-overlay/includes.chroot/usr/share/backgrounds/liquid/liquid-dark.png" \
 "$PROJECT/config-overlay/includes.chroot/usr/share/backgrounds/liquid/liquid-white.png" \
 "$PROJECT/config-overlay/includes.chroot/etc/lightdm/lightdm.conf.d/50-liquid-live.conf"; do
 test -s "$f" || { echo "Eksik dosya: $f" >&2; exit 1; }
done
printf 'Bash sözdizimi + temel dosya varlığı testi: BAŞARILI\n'
printf 'UYARI: Bu test ISO üretmez veya sistem önyüklemesini doğrulamaz.\n'

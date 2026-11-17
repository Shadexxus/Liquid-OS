#!/usr/bin/env bash
set -Eeuo pipefail
ISO="${1:-dist/Liquid-Universal-OS-Alpha-0.1-amd64.iso}"
if [[ ! -s "$ISO" ]]; then echo "HATA: ISO bulunamadı: $ISO" >&2; exit 1; fi
for cmd in xorriso sha256sum; do command -v "$cmd" >/dev/null || { echo "$cmd yüklü değil" >&2; exit 1; }; done
printf '=== SHA-256 ===\n'
sha256sum "$ISO"
printf '\n=== El Torito boot bilgileri (BIOS) ===\n'
xorriso -indev "$ISO" -report_el_torito plain
printf '\n=== Live dosya ağacı ===\n'
xorriso -indev "$ISO" -ls /live
printf '\nISO dosya yapısı incelendi; bu çıktı masaüstünün açıldığını kanıtlamaz.\n'

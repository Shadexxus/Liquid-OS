#!/usr/bin/env bash
# Liquid Universal OS Alpha 0.1 — Debian 13 (trixie) live-build recipe
set -Eeuo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="${LIQUID_WORKDIR:-$PROJECT_DIR/work}"
OUT_DIR="${LIQUID_OUTDIR:-$PROJECT_DIR/dist}"

if [[ $(id -u) -ne 0 ]]; then
    echo 'HATA: Debian 13 sisteminde sudo ile çalıştırın: sudo ./scripts/build-iso.sh' >&2
    exit 1
fi
if [[ $(uname -m) != x86_64 ]]; then
    echo 'HATA: x86_64 (amd64) Linux derleme ana makinesi gerekli.' >&2
    exit 1
fi
for cmd in lb debootstrap mksquashfs xorriso sha256sum; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "HATA: $cmd kurulu değil. Önce: sudo apt-get update && sudo apt-get install -y live-build debootstrap squashfs-tools xorriso isolinux syslinux-utils" >&2
        exit 1
    fi
done
if [[ -e "$WORK_DIR/config" ]] || [[ -e "$WORK_DIR/.build" ]]; then
    echo "HATA: $WORK_DIR derleme klasörü zaten hazırlanmış. Yeni bir klasör kullanın ya da elle temizleyin." >&2
    echo 'Örnek: sudo LIQUID_WORKDIR=/tmp/liquid-build-2 ./scripts/build-iso.sh' >&2
    exit 1
fi
mkdir -p "$WORK_DIR" "$OUT_DIR"
cd "$WORK_DIR"
echo "live-build version: $(lb --version 2>&1 || true)"

# BIOS/Legacy compatible ISO hybrid; no disk installer in Alpha 0.1.
lb config \
  --distribution trixie \
  --architecture amd64 \
  --binary-image iso-hybrid \
  --bootloaders syslinux \
  --debian-installer none \
  --archive-areas 'main contrib non-free-firmware' \
  --iso-volume 'LIQUID_ALPHA_01' \
  --iso-application 'Liquid Universal OS Alpha 0.1 Live' \
  --iso-publisher 'Liquid Universal OS Project' \
  --bootappend-live 'boot=live components username=liquid hostname=liquid locales=tr_TR.UTF-8 keyboard-layouts=tr'

cp -a "$PROJECT_DIR/config-overlay/." "$WORK_DIR/config/"

# Log captured for troubleshooting (build can download several GB).
echo '==> Derleme başladı; Debian paketlerine internet erişimi gerekir.'
set +e
lb build 2>&1 | tee "$OUT_DIR/build.log"
status=${PIPESTATUS[0]}
set -e
if (( status != 0 )); then
    echo "HATA: live-build çıkış kodu $status; ayrıntılar: $OUT_DIR/build.log" >&2
    exit "$status"
fi

ISO=$(find "$WORK_DIR" -maxdepth 1 -type f \( -name '*.hybrid.iso' -o -name '*.iso' \) | head -1)
if [[ -z "$ISO" ]]; then
    echo 'HATA: live-build başarılı döndü ancak ISO çıktı dosyası bulunamadı.' >&2
    exit 2
fi
cp "$ISO" "$OUT_DIR/Liquid-Universal-OS-Alpha-0.1-amd64.iso"
(cd "$OUT_DIR" && sha256sum Liquid-Universal-OS-Alpha-0.1-amd64.iso > SHA256SUMS)
echo "BAŞARILI: $OUT_DIR/Liquid-Universal-OS-Alpha-0.1-amd64.iso"
echo 'Sonraki adım: ./scripts/check-iso.sh dist/Liquid-Universal-OS-Alpha-0.1-amd64.iso'

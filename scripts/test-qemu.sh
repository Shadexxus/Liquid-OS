#!/usr/bin/env bash
set -Eeuo pipefail
ISO="${1:-dist/Liquid-Universal-OS-Alpha-0.1-amd64.iso}"
if [[ ! -f "$ISO" ]]; then echo "ISO bulunamadı: $ISO" >&2; exit 1; fi
if ! command -v qemu-system-x86_64 >/dev/null; then echo 'QEMU kurulu değil: sudo apt install qemu-system-x86' >&2; exit 1; fi
# Live-only; NO virtual hard disk attached. Manual visual verification required.
exec qemu-system-x86_64 \
  -name 'Liquid Universal OS Alpha 0.1 — Live Test' \
  -m 4096 -smp 2 -boot d \
  -cdrom "$ISO" \
  -vga std -nic user,model=e1000 \
  -no-reboot

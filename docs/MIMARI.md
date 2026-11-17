# Liquid OS — Alpha 0.1 mimarisi

## Çekirdek
Debian 13 Trixie `linux-image-amd64`, live-boot/live-config ve systemd.

## Masaüstü
X11 / XFCE / LightDM. Uyarlanabilir Qt/QML Liquid Shell daha sonraki bir aşama; **bu paket o özellikleri içermez.**

## Yazılım
APT, Flatpak, Firefox ESR, Thunar, XFCE Terminal, NetworkManager, PipeWire/WirePlumber.

## Başlatma
BIOS/Legacy Syslinux ve El Torito / ISO hybrid. Alpha 0.1 derleme betiği UEFI için ayrı GRUB önyükleme profili üretmez.

## Görünüm
Kullanıcı tarafından verilen özgün LIQUID L işaretini kullanan iki masaüstü duvar kâğıdı ve XFCE GTK tema seçicisi.

## Güvenlik
Debian'ın imzalı depoları, Linux kullanıcı ayrımı ve standart servisleri kullanılır. Güvenli önyükleme, doğrulanmış salt-okunur rootfs, roll-back ve özel Liquid Shield henüz uygulanmamıştır.

## Sınırlar
Bu çıktı resmi Debian yerine geçmez; ilk prototiptir. Özellikle GUI, video, ağ, ses, sürücüler ve lisans uyumu gerçek donanım/sanal makine testine tabidir.

# Liquid OS — Kod ile geliştirme

Bu depo Debian 13 tabanlı gerçek Linux Live ISO oluşturma **kaynak kodudur**. Çalışan ISO olduğu iddia edilmez.

## Başlangıç

1. GitHub'da yeni bir depo oluştur ve bu projenin **içeriğini** köke yükle.
2. Actions > Build Liquid Live ISO (Debian 13) > Run workflow.
3. İş başarılıysa Actions çalışmasının Artifacts bölümünden `.iso` içeren paketi indir. Büyük artefaktlar hesap/plan limitlerine takılabilir.
4. Sanal makinede ISO'yu optik diske bağla, BIOS/Legacy ile aç.

GitHub Actions iş akışı Debian 13 konteynerini kullanır. Gerçek paket indirme ve derleme GitHub runner ağında gerçekleşir; bu dosyalar burada yerel olarak boot testinden geçmemiştir.

## Yerel Debian 13 derleme

```bash
sudo apt-get update
sudo apt-get install -y live-build debootstrap squashfs-tools xorriso isolinux syslinux-utils ca-certificates
sudo bash scripts/build-iso.sh
bash scripts/check-iso.sh dist/Liquid-Universal-OS-Alpha-0.1-amd64.iso
```

## Uygulama kodu

`config-overlay/includes.chroot/usr/local/bin/liquid-control-center`: Python/Tkinter ile yazılmış çalışan görsel ayarlar uygulaması. Temalar `liquid-apply-theme` ile XFCE üzerinden değiştirilir.

## Doğrulama

```bash
bash scripts/verify-project.sh
```

Bu kontrol kaynak, Python ve masaüstü kısayollarının sözdizimini kontrol eder; ISO açılışını doğrulamaz.

## Güvenlik

ISO betiği sabit diske herhangi bir yazma yapmaz; canlı oturum hedeflenir. İlk denemede sanal makineye sanal sabit disk bağlamadan başlatmak daha güvenlidir.

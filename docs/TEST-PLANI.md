# Liquid OS Alpha 0.1 — Manuel test planı

ISO'nun gerçek bir Linux ortamında üretildiği ve BIOS önyüklemesinin QEMU veya VirtualBox'ta başladığı varsayılır.

| Test | Beklenen sonuç | Durum |
| --- | --- | --- |
| ISO BIOS boot | Syslinux Live menüsü açılır | Test edilmedi |
| Live Linux | Sistem sabit diske dokunmadan açılır | Test edilmedi |
| Giriş | `liquid` kullanıcısı XFCE oturumuna girer | Test edilmedi |
| Masaüstü | Koyu LIQUID duvar kâğıdı görünür | Test edilmedi |
| Tema | Menüden beyaz/koyu mod seçilir | Test edilmedi |
| Dosya yöneticisi | Thunar açılır, klasör listelenir | Test edilmedi |
| İnternet | NAT ağ ile web sayfası açılır | Test edilmedi |
| Ses | PipeWire ses aygıtı görür | Test edilmedi |
| Bellek | `free -h` RAM kullanımını raporlar | Test edilmedi |
| Sistem | `cat /etc/debian_version` Debian sürümünü gösterir | Test edilmedi |

Hata olursa `dist/build.log`, ISO'nun SHA256 değeri, VirtualBox hatası ve ilgili ekran görüntülerini saklayın.

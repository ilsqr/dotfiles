#!/usr/bin/env bash

# Nerd Font İkonları tanımlanıyor
shutdown="  Kapat"
reboot="  Yeniden Başlat"
lock="  Ekranı Kilitle"
logout="󰈆  Oturumu Kapat"

# Seçenekleri Rofi'ye gönder (Görsel ayarlar dahil)
selected=$(echo -e "$shutdown\n$reboot\n$lock\n$logout" | rofi \
    -dmenu \
    -p "⚡ Sistem" \
    -i \
    -theme-str 'window {width: 25%;} listview {lines: 4;}')

# Onay fonksiyonu (Yanlışlıkla basmayı engellemek için)
confirm_exit() {
    echo -e "  Evet\n  Hayır" | rofi -dmenu -p "Emin misiniz?" -i -theme-str 'window {width: 20%;} listview {lines: 2;}'
}

# Seçime göre aksiyon al
case "$selected" in
    $shutdown)
        ans=$(confirm_exit)
        if [[ "$ans" == "  Evet" ]]; then
            systemctl poweroff
        fi
        ;;
    $reboot)
        ans=$(confirm_exit)
        if [[ "$ans" == "  Evet" ]]; then
            systemctl reboot
        fi
        ;;
    $lock)
        # Eğer i3lock veya Betterlockscreen kullanıyorsan burayı güncelleyebilirsin
        if command -v betterlockscreen &> /dev/null; then
            betterlockscreen -l
        elif command -v i3lock &> /dev/null; then
            i3lock
        fi
        ;;
    $logout)
        ans=$(confirm_exit)
        if [[ "$ans" == "  Evet" ]]; then
            bspc quit
        fi
        ;;
esac

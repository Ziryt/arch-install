sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c Ukraine -a 12 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload

git clone https://aur.archlinux.org/yay.git
cd /yay
makepkg -si --noconfirm

sudo pacman -S --noconfirm xorg
sudo pacman -S --noconfirm gdm gnome gnome-tweaks obs-studio vlc dina-font tamsyn-font bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu 
sudo pacman -S --noconfirm tf-droid gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto tex-gyre-fonts 
sudo pacman -S --noconfirm ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code 
sudo pacman -S --noconfirm ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans 
sudo pacman -S --noconfirm gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji

yay -S --noconfirm --removemake telegram-desktop-bin discord google-chrome gnome-console qbittorrent menulibre

sudo systemctl enable gdm
/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
sudo reboot

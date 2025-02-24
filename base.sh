ln -sf /usr/share/zoneinfo/Europe/Kiev /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=en_US.UTF-8" >> /etc/vconsole.conf
echo "lmz" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 lmz.localdomain lmz" >> /etc/hosts

read -p 'Username: ' uservar
read -sp 'Password: ' passvar

echo root:$passvar | chpasswd

pacman -S grub grub-btrfs efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-zen-headers 
pacman -S avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh 
pacman -S rsync acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld 
pacman -S flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font
pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

useradd -m $uservar
echo $uservar:$passvar | chpasswd
usermod -aG libvirt $uservar

echo "$uservar ALL=(ALL) ALL" >> /etc/sudoers.d/$uservar

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

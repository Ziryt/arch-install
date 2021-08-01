# arch-install

lsblk # show devices
#partition disk
gdisk /dev/nvme0n1
#d - delete part, n - new part, p - print 
#create +300M ef00 and linux fs
#w - write changes

mkfs.vfat /dev/nvme0n1p1
mkfs.btrfs -f /dev/nvme0n1p2

#create subvolumes
mount /dev/nvme0n1p2 /mnt
cd /mnt
btrfs subvolume create @
btrfs subvolume create @home
btrfs subvolume create @var
cd
umount /mnt

#mount subvolumes
mount -o noatime,compress=zstd,space_cache,discard=async,subvol=@ /dev/nvme0n1p2 /mnt
mkdir /mnt/{boot,home,var}
mount -o noatime,compress=zstd,space_cache,discard=async,subvol=@home /dev/nvme0n1p2 /mnt/home
mount -o noatime,compress=zstd,space_cache,discard=async,subvol=@var /dev/nvme0n1p2 /mnt/var
mount /dev/nvme0n1p1 /mnt/boot

lsblk

pacstrap /mnt base linux linux-firmware git nano amd-ucode btrfs-progs

#after pacstrap

genfstab -U /mnt >> /mnt/etc/fstab

#chroot to /mnt
arch-chroot /mnt
#look fs table
cat /etc/fstab
git clone https://github.com/lzhecz/arch-install
cd arch-install/
#edit base installer
nano base.sh
chmod +x base.sh
cd /
./arch-install/base.sh

#mkinit
#add videocard to modules (amdgpu, nvidia, i915)
nano /etc/mkinitcpio.conf
mkinitcpio -p linux
exit
umount -a
exit
reboot

## install de
cp -r /arch-install .
cd arch-install/
#edit de installer
nano gnome.sh
chmod +x gnome.sh
cd
./arch-install/gnome.sh

#after install timeshift
pikaur -S timeshift timeshift-autosnap

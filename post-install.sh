echo "Manhhao's Custom Arch Dualboot Setup Installation Part 2"

# Set date time
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

# Set locale to en_US.UTF-8 UTF-8
sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# hostname
echo "manhhao-pc" >> /etc/hostname
echo "127.0.1.1 manhhao-pc.localdomain  manhhao-pc" >> /etc/hosts

# initramfs
mkinitcpio -P

# root password
passwd

# bootloader
grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id=GRUB

mkdir /mnt2
mount /dev/sda2 /mnt2

grub-mkconfig -o /boot/grub/grub.cfg

# user creation
useradd -m -G wheel,power,iput,storage,uucp,network -s /usr/bin/zsh manhhao
sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers
echo "Set password for new user manhhao"
passwd manhhao

# final setup
systemctl enable lxdm.service
systemctl enable dhcpcd.service

echo "Configuration done. You can now exit chroot."

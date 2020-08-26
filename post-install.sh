# Set date time
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

# Set locale to en_US.UTF-8 UTF-8
sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# hostname
echo "kynux-pc" >> /etc/hostname
echo "127.0.1.1 kynux-pc.localdomain  kynux-pc" >> /etc/hosts

# initramfs
mkinitcpio -P

# root password
passwd

# user creation
useradd -m -G wheel,audio,video -s /usr/bin/zsh kynux
sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+ALL\)/\1/' /etc/sudoers
echo "set password for new user kynux"
passwd kynux

variable=$(blkid -s PARTUUID -o value /dev/sda5)
echo "The PARTUUID is: $variable"

# final setup
systemctl enable lightdm.service
systemctl enable dhcpcd.service

echo "Almost done, follow the last few steps on the README and you are good to go!"

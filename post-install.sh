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

# user creation
useradd -m -G wheel,audio,video -s /usr/bin/zsh manhhao
sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+ALL\)/\1/' /etc/sudoers
echo "set password for new user manhhao"
passwd manhhao

variable=$(blkid -s PARTUUID -o value /dev/sda5)
echo "The PARTUUID is: $variable"

echo "efibootmgr --disk /dev/sda --part 4 --create --label "Arch Openbox" --loader /vmlinuz-linux --unicode 'root=PARTUUID="$variable" rw initrd=\initramfs-linux.img' --verbose"

# final setup
systemctl enable lightdm.service
systemctl enable dhcpcd.service

echo "Done!"

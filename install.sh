echo "Manhhao's Custom Arch Dualboot Setup Installation"

# format partitions
mkfs.fat -F32 /dev/sda4
mkfs.ext4 /dev/sda5
mkswap /dev/sda6
swapon /dev/sda6

# Initate pacman keyring
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys

# mount partitions
mount /dev/sda5 /mnt
mkdir /mnt/boot
mount /dev/sda4 /mnt/boot/

# pacstrap necessary files
echo "Installing Arch Linux and Openbox" 
pacstrap /mnt base base-devel linux linux-firmware nano dhcpcd efibootmgr xorg-server xorg-apps xorg-xinit nvidia lightdm lightdm-webkit2-greeter openbox ttf-dejavu ttf-liberation

# gen fstab
genfstab -U /mnt >> /mnt/etc/fstab

# copy part 2 into chroot
cp -rfv post-install.sh /mnt/root
chmod a+x /mnt/root/post-install.sh

# chroot into new system
echo "please run the second script file via ./root/post-install.sh, press any key to chroot"
read tmpvar
arch-chroot /mnt

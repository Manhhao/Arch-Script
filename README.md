# Arch-Script

This is an (almost) fully automated install script for an Arch-Linux installation. It installs the Openbox environment and proprietary nvidia drivers by default, although this can be edited.
The repository is still being updated, things might become easier in the future (though I consider this easy enough).

## Installation
While in the live environment of the .iso, install git 
```bash
pacman -Su git
```
and then simply clone the repository with
```bash
git clone https://github.com/Manhhao/Arch-Openbox.git && cd Arch-Openbox
```
Also consider editing your mirrorlist before running the script, the installation will take a very loooooooooooong time otherwise.

## Preparation
1. The script does not install a bootloader, instead, it creates its own EFI device, so please make
   sure your mainboard supports proper UEFI booting.
2. This script assumes that partitioning has already been done, if not, please do so via
    ```bash
    gdisk
    ```
    and create:
    - a 512MB EFI-Partition
    - a swap partition (size variable according to your ram)
    - an ext4 main system partition
    
    and adjust the following to the correct partition number and drive name
    ``` bash
    nano install.sh
    ```
    
    ```bash
    ...
    
    mkfs.fat -F32 /dev/sda4 <- EFI partition
    mkfs.ext4 /dev/sda5 <- main system partition
    mkswap /dev/sda6 <- swap partition
    swapon /dev/sda6 <- swap partition
    
    ...
    ```
   
    ``` bash
    nano post-install.sh
    ```
    
    ``` bash
    
    ...
    
    variable=$(blkid -s PARTUUID -o value /dev/sda5) <- main system partition
    echo "The PARTUUID is: $variable"

    echo "efibootmgr --disk /dev/sda <- drive name --part 4 <- EFI partition [...]

    ...
    ```
3. While in ``` nano post-install.sh ``` replace ``` manhhao ``` with your desired username, hostname, ...
4. Before you can execute the script, make sure you give permission to execute:
    ``` bash
    chmod a+x install.sh
    ```
5. You might not like Openbox, you can edit the following command
    ``` bash
    pacstrap /mnt base base-devel [...] openbox
    ```
    Simply remove ``` openbox ``` and add one of the [supported Desktop Environments](https://wiki.archlinux.org/index.php/Desktop_environment#Officially_supported)
## Usage
Now that you have edited the script to your liking, it is time to simply run the script:

```bash
./install.sh
```

After running the post-install script, please make sure to edit the lightdm greeter via this [guide](https://wiki.archlinux.org/index.php/LightDM#Installation) to ```lightdm-webkit2-greeter```, you will not be able to boot into your desktop otherwise!

If you have reached this point without any issues, your installation should be done and ready for usage!

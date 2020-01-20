#!/bin/bash

loadkeys ru us

mkfs.ext4 /dev/sda2
mkswap /dev/sda1
swapon /dev/sda1
mount /dev/sda2 /mnt
pacstrap /mnt base base-devel
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
echo 'Вписываем KEYMAP=ru FONT=cyr-sun16'
echo 'KEYMAP=ru' >> /etc/vconsole.conf
echo 'FONT=cyr-sun16' >> /etc/vconsole.conf
keymap="us"
ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime

hwclock --systohc --utc

read -p "Введите имя компьютера: " hostname
read -p "Введите имя пользователя: " username
pacman -S grub
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
exit
umount -R /mnt
reboot
passwd

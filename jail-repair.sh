echo "iniciando proceso de recuperación"
cryptsetup luksOpen /dev/nvme0n1p2 test02
cryptsetup luksOpen /dev/nvme0n1p3 test03
mount -t ext4 /dev/mapper/test02 /mnt
mount -t ext4 /dev/mapper/test03 /mnt/home
mount -t proc proc /mnt/proc
mount -t sysfs sysfs /mnt/sys
mount -o bind /dev /mnt/dev
mount --bind /run /mnt/run
mount -t vfat /dev/nvme0n1p1 /mnt/boot/efi
mount --bind /sys/firmware/efi/efivars /mnt/sys/firmware/efi/efivars
chroot /mnt /bin/bash
umount /mnt/boot/efi
umount /mnt/run
umount /mnt/sys/firmware/efi/efivars
umount /mnt/{proc,sys,dev}
umount /mnt
echo "Todo desmontado"

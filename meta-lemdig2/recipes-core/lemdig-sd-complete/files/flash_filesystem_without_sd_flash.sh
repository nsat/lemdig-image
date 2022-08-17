#!/usr/bin/env bash
set -e

if [ ! -e /dev/mtd7 ] ; then
    echo "Unable to find mtd7, stopping!"
    exit 1
fi
echo "Mounting boot partition to /real_boot/"
mount /dev/mmcblk0p1 /real_boot/

# Write copies of the bootloader and kernel to the QSPI Flash
echo "Writing bootloader and kernel to SPI Flash..."
echo "Part 1/5"
flashcp -v /real_boot/BOOT.bin /dev/mtd2
echo "Part 2/5"
flashcp -v /real_boot/BOOT.bin /dev/mtd3
echo "Part 3/5"
flashcp -v /real_boot/BOOT.bin /dev/mtd4
echo "Part 4/5"
flashcp -v /real_boot/fitImage /dev/mtd5
echo "Part 5/5"
flashcp -v /real_boot/fitImage /dev/mtd6

echo "Erasing U-Boot Environment..."
flash_erase /dev/mtd7 0 0

# Flash rootfs to both nands and prepare datafs
for i in 0 1; do
    echo "Preparing ubifs in NAND${i}..."
    ubiformat -y /dev/mtd${i}
    ubiattach --dev-path=/dev/mtd${i}
done

echo "Creating ubifs partitons..."
# Create first rootfs partition
ubimkvol /dev/ubi0 -N rootfs -s 1024MiB

# Create first data partition with the rest of the space on first NAND
ubimkvol /dev/ubi0 -N prog -m

# Create backup rootfs partition
ubimkvol /dev/ubi1 -N rootfs_backup -s 1024MiB

# Create backup data partition with the rest of the space on second NAND
ubimkvol /dev/ubi1 -N data -m

for i in 0 1; do
    # Write rootfs image to rootfs partitions
    echo "Writing rootfs to NAND${i}..."
    ubiupdatevol /dev/ubi${i}_0 /root.ubifs
done

ubinfo

# allow customer's current workflow (mmcblk0p3 as data partition)
if [ ! -e /dev/mmcblk0p3 ] ; then
    echo "Adding data partition to SD card..."
    echo -e "n\np\n3\n\n\nw\n" | fdisk /dev/mmcblk0 && mkfs.ext4 -F /dev/mmcblk0p3
else
    echo "Partition 3 exists on SD card, leaving it alone"
fi

echo "Detaching ubifs..."
for i in 0 1; do
    ubidetach --dev-path=/dev/mtd${i}
done

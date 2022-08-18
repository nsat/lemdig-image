DESCRIPTION = "Spire LEMDIG 2.0 image"

# Generate a UBIFS rootfs suitable for the target hardware and a tar image suitable for netbooting
IMAGE_FSTYPES = "ubifs tar.gz"

# Tentative ubifs settings for LEMDIG1.5 "MARSUPIAL" (MT29F64G08AECABH1 SLC NAND)
#
# / # mtdinfo  -u /dev/mtd0
# mtd0
# Name:                           boot
# Type:                           nand
# Eraseblock size:                1048576 bytes, 1024.0 KiB
# Amount of eraseblocks:          64 (67108864 bytes, 64.0 MiB)
# Minimum input/output unit size: 8192 bytes
# Sub-page size:                  8192 bytes
# OOB size:                       448 bytes
# Character device major/minor:   90:0
# Bad blocks are allowed:         true
# Device is writable:             true
# Default UBI VID header offset:  8192
# Default UBI data offset:        16384
# Default UBI LEB size:           1032192 bytes, 1008.0 KiB
# Maximum UBI volumes count:      128

# 0.98 GB rootfs volume
MKUBIFS_ARGS = "-m 8192 -e 1032192 -c 1024"

require recipes-core/images/lemdig-image.inc

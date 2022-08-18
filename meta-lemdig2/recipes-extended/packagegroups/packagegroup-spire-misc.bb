SUMMARY = "Miscellaneous packages required by Spire's Lemdig-2.0"
DESCRIPTION = "Various packages that are required by more than one Lemdig-2.0 \
profile and for which there's currently no dedicated BitBake recipe. This is a \
work-in-progress design and it is expected to be refined as more packages are \
added."
PR = "r6"

inherit packagegroup

PACKAGES = "\
    packagegroup-spire-misc \
    packagegroup-spire-connectivity \
    "

RDEPENDS_packagegroup-spire-misc = "\
    packagegroup-spire-connectivity \
    "

# Note:
# - iproute2 (ip command in it) is required to configure CAN interface on Zynq/ZynqMP platform.
RDEPENDS_packagegroup-spire-connectivity = "\
    iproute2 \
    ethtool \
    "

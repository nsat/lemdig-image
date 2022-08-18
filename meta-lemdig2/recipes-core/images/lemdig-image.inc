IMAGE_FEATURES += " \
                   allow-empty-password \
                   empty-root-password \
                   read-only-rootfs \
                   ssh-server-openssh \
                   package-management \
                  "

# Packages/groups provided by Yocto
IMAGE_INSTALL = " \
    packagegroup-core-boot \
    \
    mtd-utils \
    mtd-utils-ubifs \
    \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    "

# Spire packages
IMAGE_INSTALL += " \
    packagegroup-spire-misc \
    packagegroup-spire-utils \
    \
    lemdig-profile \
    "

# Keep non-RO rootfs stuff in rootfs, as some payloads want to remount the rootfs as RW for OOUs
# Only remove "run-postinsts" which includes post-install scripts run on the board.
ROOTFS_RO_UNNEEDED = "run-postinsts"

inherit core-image

# Configure SSH daemon (no password/authentication if --bare-image, else ssh keys required)
ROOTFS_POSTPROCESS_COMMAND += 'ssh_payload_config ;'

# Don't bake the timestamp into the rootfs (as we symlink the path to the local etc dir in the basefiles recipe)
ROOTFS_POSTPROCESS_COMMAND_remove = "rootfs_update_timestamp ;"

ssh_payload_config () {
    if [ -e ${IMAGE_ROOTFS}${sysconfdir}/ssh/sshd_config ]; then

        # Accept root logins
        sed -i 's/^[#[:space:]]*PermitRootLogin.*/PermitRootLogin yes/' ${IMAGE_ROOTFS}${sysconfdir}/ssh/sshd_config

        # Remvove X11 to open graphic application
        sed -i 's/^[#[:space:]]*X11Forwarding.*/X11Forwarding no/' ${IMAGE_ROOTFS}${sysconfdir}/ssh/sshd_config

        if [ "${SPIRE_BARE_IMAGE}" = "1" ]; then
            # Remove needs to authenticate (authentication with password but password is "")
            sed -i 's/^[#[:space:]]*PermitEmptyPasswords.*/PermitEmptyPasswords yes/' ${IMAGE_ROOTFS}${sysconfdir}/ssh/sshd_config
            sed -i 's/^[#[:space:]]*PasswordAuthentication.*/PasswordAuthentication yes/' ${IMAGE_ROOTFS}${sysconfdir}/ssh/sshd_config
        else
            # Authenticate with ssh keys
            sed -i 's/^[#[:space:]]*PermitEmptyPasswords.*/PermitEmptyPasswords no/' ${IMAGE_ROOTFS}${sysconfdir}/ssh/sshd_config
            sed -i 's/^[#[:space:]]*PasswordAuthentication.*/PasswordAuthentication no/' ${IMAGE_ROOTFS}${sysconfdir}/ssh/sshd_config
        fi
    fi
}

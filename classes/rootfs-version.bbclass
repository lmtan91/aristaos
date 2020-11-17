update_root_version() {
        chmod a+w ${IMAGE_ROOTFS}/root-filesystem-version.txt || true
        echo ${DATE}-${TIME} > ${IMAGE_ROOTFS}/root-filesystem-version.txt
        chmod a-w ${IMAGE_ROOTFS}/root-filesystem-version.txt
}

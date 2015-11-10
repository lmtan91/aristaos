FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += " \
	file://config.custom \
"

do_configure_prepend() {
	cp ${WORKDIR}/config.custom ${WORKDIR}/defconfig
}

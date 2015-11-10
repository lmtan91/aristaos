FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

do_install_append () {
	install -d ${D}/usr/bin
	ln -snf ../java/bin/java ${D}/usr/bin/java
	ln -snf ../java/bin/keytool ${D}/usr/bin/keytool

}

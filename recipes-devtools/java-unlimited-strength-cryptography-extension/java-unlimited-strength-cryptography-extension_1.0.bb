DESCRIPTION = "Java Cryptography Extension (JCE) Unlimited"
SECTION = "java"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Proprietary;md5=0557f9d92cf58f2ccdd50f62f8ac0b28"
PR = "r0"

RDEPENDS_${PN} = "oracle-jse-ejre-arm-vfp-hflt-client-headless"

SRC_URI = "file://UnlimitedJCEPolicyJDK7.zip" 

FILES_${PN} = " \
	/usr/ejre1.7.0_60/lib/security/local_policy.jar \
	/usr/ejre1.7.0_60/lib/security/US_export_policy.jar \
"


do_install () {
	install -d ${D}/usr/ejre1.7.0_60/lib/security/
        install -m 0644 ${WORKDIR}/UnlimitedJCEPolicy/local_policy.jar ${D}/usr/ejre1.7.0_60/lib/security/local_policy.jar
        install -m 0644 ${WORKDIR}/UnlimitedJCEPolicy/US_export_policy.jar ${D}/usr/ejre1.7.0_60/lib/security/US_export_policy.jar
}


FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://UnlimitedJCEPolicyJDK7.zip"

#FILES_${PN} += " 
#        /usr/share/ejre1.7.0_60/lib/security/local_policy.jar 
#        /usr/share/ejre1.7.0_60/lib/security/US_export_policy.jar"

JAVA_PATH := "/usr/share/ejre1.7.0_60/"

do_install_append () {
        install -d ${D}/usr/bin
        ln -snf ${JAVA_PATH}/bin/java ${D}/usr/bin/java
        ln -snf ${JAVA_PATH}/bin/keytool ${D}/usr/bin/keytool
        install -d ${D}/usr/share/ejre1.7.0_60/lib/security/
        install -m 0644 ${WORKDIR}/UnlimitedJCEPolicy/local_policy.jar ${D}/usr/share/ejre1.7.0_60/lib/security/local_policy.jar
        install -m 0644 ${WORKDIR}/UnlimitedJCEPolicy/US_export_policy.jar ${D}/usr/share/ejre1.7.0_60/lib/security/US_export_policy.jar
}


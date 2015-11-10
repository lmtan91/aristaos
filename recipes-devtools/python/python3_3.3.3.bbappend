# Remove the distutils-prefix patch.
SRC_URI := "${@bb.data.getVar('SRC_URI',d,1).replace('file://12-distutils-prefix-is-inside-staging-area.patch ', '')}"
SRC_URI += "file://sitecustomize.py"

FILES_${PN} += "${STAGING_INCDIR}/python3.3m/*"

# need to export these variables for python-config to work
export BUILD_SYS
export HOST_SYS
export STAGING_INCDIR
export STAGING_LIBDIR

#do_install_append () {
#	test
#}

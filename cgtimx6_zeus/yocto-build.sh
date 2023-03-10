#!/bin/bash
# This script will run into container

# source the common variables

. cgtimx6_zeus/env.sh

#

mkdir -p ${YOCTO_DIR}
cd ${YOCTO_DIR}

# Init

repo init \
    -u ${REMOTE} \
    -b ${BRANCH} \
    -m ${MANIFEST}

repo sync -j`nproc`

# source the yocto env

EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source imx-setup-release.sh -b build_${DISTRO}

# add meta-aristaos layer
if [ -d ../sources/meta-aristaos ]; then
    echo meta-aristaos directory found
    echo "BBLAYERS += \"\${BSPDIR}/sources/meta-aristaos\"" >> ./conf/bblayers.conf
fi
# add meta-java layer
if [ -d ../sources/meta-java ]; then
    echo meta-java directory found
    echo "BBLAYERS += \"\${BSPDIR}/sources/meta-java\"" >> ./conf/bblayers.conf
fi
echo "BBLAYERS += \"\${BSPDIR}/sources/meta-openembedded/meta-webserver\"" >> ./conf/bblayers.conf

echo "# Possible provider: cacao-initial-native and jamvm-initial-native" >> ./conf/local.conf
echo "PREFERRED_PROVIDER_virtual/java-initial-native = \"cacao-initial-native\"" >> ./conf/local.conf
echo "# Possible provider: cacao-native and jamvm-native" >> ./conf/local.conf
echo "PREFERRED_PROVIDER_virtual/java-native = \"jamvm-native\"" >> ./conf/local.conf
echo "# Optional since there is only one provider for now" >> ./conf/local.conf
echo "PREFERRED_PROVIDER_virtual/javac-native = \"ecj-bootstrap-native\"" >> ./conf/local.conf
echo "PREFERRED_PROVIDER_java2-runtime = \"openjdk-8-jre\"" >> ./conf/local.conf

echo "CORE_IMAGE_EXTRA_INSTALL += \"openssh\"" >> ./conf/local.conf
echo "PACKAGE_EXCLUDE += \" packagegroup-core-ssh-dropbear\"" >> ./conf/local.conf
echo "CORE_IMAGE_EXTRA_INSTALL += \"packagegroup-core-ssh-openssh\"" >> ./conf/local.conf

# Build

if [ "$1" = "-dev" ]; then
	export IMAGES="${IMAGES}-dev"
fi
bitbake ${IMAGES}


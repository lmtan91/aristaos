#!/bin/bash
# This script will run into container

################################################################################
#################################### Function ##################################
################################################################################
apply_patch() {
	for file in ${DOCKER_WORKDIR}/${ARISTA_IMX_RELEASE}/patches/*
	do
		echo "Checking $file..."
		patch -p0 -N --dry-run --silent < $file 2>/dev/null
		if [ $? -eq 0 ];
		then
    		echo "Applying patches $file ..."
    		patch -p0 -N < $file
		fi
	done
}

# source the common variables

. cgtimx6_zeus_imx-5.4.70-2.3.9/env.sh

#

mkdir -p ${YOCTO_DIR}
cd ${YOCTO_DIR}

# Init

repo init \
    -u ${REMOTE} \
    -b ${BRANCH} \
    -m ${MANIFEST}

repo sync -j`nproc`

apply_patch ;

# source the yocto env

EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source imx-setup-release.sh -b build_${DISTRO}

sed -i '/meta-nxp-demo-experience/d' ./conf/bblayers.conf

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
echo "BBLAYERS += \"\${BSPDIR}/sources/meta-swupdate\"" >> ./conf/bblayers.conf

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
echo "IMAGE_FSTYPES = \" ext4 ext4.gz wic.bmap wic.gz\"" >> ./conf/local.conf

echo "PREFERRED_PROVIDER_u-boot-fw-utils = \"libubootenv\"" >> ./conf/local.conf

echo "IMAGE_INSTALL_append = \" dosfstools\"" >> ./conf/local.conf
# disable volatile log in tmpfs to enable persistent journal log
echo "VOLATILE_LOG_DIR = \"no\"" >> ./conf/local.conf

# Build

if [ "$1" = "-dev" ]; then
	export IMAGES="${IMAGES}-dev"
#else
#	sed -i '/debug-tweaks/d' ./conf/local.conf
fi

echo "INHERIT += \"extrausers\"" >> ./conf/local.conf
echo "EXTRA_USERS_PARAMS = \"usermod -P arista root;\"" >> ./conf/local.conf
echo "IMAGE_BOOT_FILES += \"uImage imx6dl-qmx6.dtb imx6q-qmx6.dtb\"" >> ./conf/local.conf
echo "WKS_FILES = \"aristaos-image.wks.in\"" >> ./conf/local.conf

bitbake ${IMAGES}
bitbake update-image 

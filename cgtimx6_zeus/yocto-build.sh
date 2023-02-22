#!/bin/bash
# This script will run into container

# source the common variables

. cgtimx6_zeus/env.sh

#

mkdir -p ${YOCTO_DIR}
cd ${YOCTO_DIR}

rm -rfv /opt/yocto/.repo

# Init

repo init \
    -u ${REMOTE} \
    -b ${BRANCH} \
    -m ${MANIFEST}

repo sync -j`nproc`
ls -l /
ls -l /opt
ls -l /opt/yocto/cgtimx6_zeus
pwd
ls -l /opt/yocto
ls -l /home/tanlm2

# source the yocto env

EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source imx-setup-release.sh -b build_${DISTRO}

# Build

bitbake ${IMAGES}


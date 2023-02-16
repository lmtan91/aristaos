#!/bin/bash
# This script will run into container

# source the common variables


if [ -f /.dockerenv ]; then
    echo "I'm inside matrix ;(";
else
    echo -e "This script must be run inside a container\n";
    exit 1
fi


. ./env.sh

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

echo -e "\n\e[92mrepo:\e[0m Initializing repo"
echo -e "\e[92mCurrent directory:\e[0m ${PWD}\n"



repo init \
    -u ${DOCKER_WORKDIR}/manifest/  \
    -m manifest.xml

repo sync -j`nproc`

# Source the build environment.
EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source imx-setup-release.sh -b build_${DISTRO}

# Build
bitbake ${IMAGES}


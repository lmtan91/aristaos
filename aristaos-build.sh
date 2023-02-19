#!/bin/bash
# This script only runs from a container
if ! [ -f /.dockerenv ]; then
    echo -e "This script must be run inside a container\n";
    exit 1
fi

# Mmm. Colorful.
echo -e "\n\e[92msourcing env variables from:\e[0m ${DOCKER_WORKDIR}/${MANIFEST_REPO}/env.sh"
echo -e "\n\e[92mrepo:\e[0m Initializing repo"
echo -e "\e[92mCurrent directory:\e[0m ${PWD}\n"

# source the common variables
. ${DOCKER_WORKDIR}/${MANIFEST_REPO}/env.sh

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

# The manifest repo comes from a docker volume. See docker-run.sh
repo init \
    -u ${DOCKER_WORKDIR}/${MANIFEST_REPO} \
    -m ${MANIFEST_FILENAME}

repo sync -j`nproc`

# Source the build environment.
EULA=1 MACHINE="${MACHINE}" DISTRO="${DISTRO}" source imx-setup-release.sh -b build_${DISTRO}

# Build
bitbake ${IMAGES}


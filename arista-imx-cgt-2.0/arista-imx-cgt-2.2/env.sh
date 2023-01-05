#!/bin/bash
# Here are some default settings.
# Make sure DOCKER_WORKDIR is created and owned by current user.

# Docker

DOCKER_IMAGE_TAG="arista-os"
DOCKER_WORKDIR="/opt/yocto"

# Yocto

IMX_RELEASE="imx-cgt-arista-2.2"

YOCTO_DIR="${DOCKER_WORKDIR}/${IMX_RELEASE}-build"

MACHINE="imx8mpevk"
DISTRO="fsl-imx-xwayland"
IMAGES="imx-image-core"

REMOTE="../imx-cgt-arista-manifest"
BRANCH="manifest-2.2"
MANIFEST=${IMX_RELEASE}".xml"

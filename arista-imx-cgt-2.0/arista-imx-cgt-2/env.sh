#!/bin/bash
# Here are some default settings.
# Make sure DOCKER_WORKDIR is created and owned by current user.

# Docker

DOCKER_IMAGE_TAG="arista-os"
DOCKER_WORKDIR="/opt/yocto"

# Yocto

IMX_RELEASE="arista-imx-cgt-2.0"

YOCTO_DIR="${DOCKER_WORKDIR}/${IMX_RELEASE}-build"

MACHINE="imx8mpevk"
DISTRO="fsl-imx-xwayland"
IMAGES="imx-image-core"

REMOTE="../arista-imx-cgt-manifest"
BRANCH="manifest-2.0"
MANIFEST=${IMX_RELEASE}".xml"

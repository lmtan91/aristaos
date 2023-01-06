#!/bin/bash

# Set some defaults, to be overridden by env.sh in the version
# subdirectories.

# Make sure DOCKER_WORKDIR is created and owned by current user.

# The Docker image from Docker Hub
DOCKER_IMAGE_TAG="yocto-imx"
# Where Docker is going to put files
# TODO: Make a symbolic link to the output image folder.
DOCKER_WORKDIR="/opt/yocto"

IMX_RELEASE="arista-imx-cgt-2.2"

YOCTO_DIR="${DOCKER_WORKDIR}/${IMX_RELEASE}-build"
MANIFEST_GIT_REPO="/home/nick/arista-imx-cgt-manifest"

MACHINE="cgtqmx6"
DISTRO="fsl-imx-xwayland"
# Image options
# fsl-image-machine-test: A console-only image that includes gstreamer packages
#                         Freescale's multimedia packages (VPU and GPU) when available,
#                         and test and benchmark applications.
# core-image-minimal: A small image that only allows a device to boot
IMAGES="core-image-minimal"

REMOTE="../arista-imx-cgt-manifest"
BRANCH="manifest-2.2"
MANIFEST=${IMX_RELEASE}".xml"



#!/bin/bash

# Submodules that must exist
MANIFEST_REPO="manifest"

# Docker setup
# ------------
# Choose an OS version Dockerfile compatible with the Yocto Project version.
DOCKERFILE_NAME="aristaos-dockerfile-Ubuntu-18.04"

# Tag the Docker image. Must be lowercase.
DOCKER_IMAGE_TAG="ubuntu-18.04"

# Names the release and determines the imx-manifest branch to use.
ARISTA_IMX_RELEASE="2.0"

# Where Docker is going to put files
DOCKER_WORKDIR="/opt/yocto"

# Build files will go in ./aristaos/$[YOCTO_BUILD_DIR]/[version tag]
YOCTO_BUILD_DIR="./builds"

# Bitbkae parameters
MACHINE="cgtqmx6"
DISTRO="fsl-imx-xwayland"
# Image options
#   fsl-image-machine-test: A console-only image that includes gstreamer packages
#     Freescale's multimedia packages (VPU and GPU) when available, and test and
#     benchmark applications.
#   core-image-minimal: A small image that only allows a device to boot
IMAGES="core-image-minimal"
#IMAGES="imx-image-core"

# Repo parameters
# TODO: Fix this next path so it is relative
MANIFEST_REPO="https://github.com/practichem/aristaos-manifest.git"
MANIFEST_BRANCH=${ARISTA_IMX_RELEASE}
MANIFEST_FILENAME="manifest.xml"
#!/bin/bash


# Docker setup
# ------------
# Tag the Dock er image.
# Must be lowercase.
DOCKER_IMAGE_TAG="yocto-imx-ubuntu-18.04"

# Specify the Dockerfile required to generate the image
DOCKER_FILE="Dockerfile-Ubuntu-18.04"

# Where Docker is going to put files
DOCKER_WORKDIR="/opt/yocto"

# Names the release and determines the imx-manifest branch to use.
ARISTA_IMX_RELEASE="cgtimx6_zeus"

YOCTO_DIR="${DOCKER_WORKDIR}/${ARISTA_IMX_RELEASE}-build"

# Bitbkae parameters
MACHINE="cgtqmx6"
DISTRO="fsl-imx-xwayland"
# Image options
# fsl-image-machine-test: A console-only image that includes gstreamer packages
#                         Freescale's multimedia packages (VPU and GPU) when available,
#                         and test and benchmark applications.
# core-image-minimal: A small image that only allows a device to boot
IMAGES="aristaos-image"

REMOTE="https://github.com/practichem/aristaos-manifest.git"
BRANCH="develop"
MANIFEST="manifest_zeus.xml"

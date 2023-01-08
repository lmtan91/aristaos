#!/bin/bash

# Called by docker-build.sh and docker-run.sh

# Be sure DOCKER_WORKDIR exists and is owned by $USER.
DOCKER_WORKDIR="/opt/yocto"

# TODO: Make a symbolic link to the output image folder.

# Docker setup
# ------------
# Tag the Docker image.
# Must be lowercase.
DOCKER_IMAGE_TAG="yocto-imx-ubuntu-18.04"
# Choose the Dockerfile for this process
DOCKER_FILE="Dockerfile-Ubuntu-18.04"

# Where Docker is going to put files
# TODO: Make a symbolic link to the output image folder.
DOCKER_WORKDIR="/opt/yocto"

# Names the release and determines the imx-manifest branch to use.
ARISTA_IMX_RELEASE="2.0"

YOCTO_DIR="${DOCKER_WORKDIR}/${IMX_RELEASE}-build"

# Bitbkae parameters
MACHINE="cgtqmx6"
DISTRO="fsl-imx-xwayland"
# Image options
# fsl-image-machine-test: A console-only image that includes gstreamer packages
#                         Freescale's multimedia packages (VPU and GPU) when available,
#                         and test and benchmark applications.
# core-image-minimal: A small image that only allows a device to boot
IMAGES="core-image-minimal"

# Repo parameters
# TODO: Fix this next path so it is relative
MANIFEST_REPO="/home/nick/arista-imx-cgt-manifest"
MANIFEST_BRANCH=${ARISTA_IMX_RELEASE}
MANIFEST_FILENAME="manifest.xml"
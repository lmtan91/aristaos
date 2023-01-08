#!/bin/bash
#
# This script creates a Docker image ready to build Yocto.
#   --build-arg options pass data about the current user.
#   DOCKER_IMAGE_TAG identifies the generated image.
#
# Define DOCKER_WORKDIR and DOCKER_IMAGE_TAG in env.sh.

# source the common variable store
. ./env.sh

echo ${DOCKER_FILE}

# main
docker image build --tag "${DOCKER_IMAGE_TAG}" \
                --build-arg "DOCKER_WORKDIR=${DOCKER_WORKDIR}" \
                --build-arg "USER=$(whoami)" \
                --build-arg "host_uid=$(id -u)" \
                --build-arg "host_gid=$(id -g)" \
                -f ${DOCKER_FILE} \
                .

#!/bin/bash
#
# This script creates a Docker image ready to build Yocto.
#   --build-arg options pass data about the current user.
#   DOCKER_IMAGE_TAG identifies the generated image.
#
# Define DOCKER_WORKDIR and DOCKER_IMAGE_TAG in env.sh.

# source the common variables
. ./env.sh

usage() {
    echo -e "\e[3m\nUsage: $0 [path_to_Dockerfile]\e[0m\n"
}

# main

if [ $# -ne 1 ]
    then
        usage
    else
        docker build --tag "${DOCKER_IMAGE_TAG}" \
                     --build-arg "DOCKER_WORKDIR=${DOCKER_WORKDIR}" \
                     --build-arg "USER=$(whoami)" \
                     --build-arg "host_uid=$(id -u)" \
                     --build-arg "host_gid=$(id -g)" \
                     -f $1 \
                     .
fi

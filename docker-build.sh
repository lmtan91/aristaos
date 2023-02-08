#!/bin/bash
#
# This script creates the yocto-ready docker image.
# The --build-arg options are used to pass data about the current user.
# Also, a tag is used for easy identification of the generated image.
#

# source the common variables
. ../aristaos-manifest/env.sh

echo $DOCKER_IMAGE_TAG

docker build --tag aristaos-builder:${DOCKER_IMAGE_TAG} \
                --build-arg DOCKER_WORKDIR=${DOCKER_WORKDIR} \
                --build-arg USER=$(whoami) \
                --build-arg host_uid=$(id -u) \
                --build-arg host_gid=$(id -g) \
                -f ${DOCKERFILE_NAME} \
                .
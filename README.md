# Yocto project to build Arista OS
#
Loosely based off the NXP imx-docker scripts.
# Basic operation
1. docker-build.sh builds a Docker image using one of the Yocto-friendly dockerfiles.
2. docker-run.sh runs a Docker image and presents terminal access. Note: it removes the container when it exits.
3. aristaos-build.sh is run from inside the container. It installs Google Repo to pull down subprojects, then BitBake builds an image.

# Other files
* env.sh contains environment variables that configure the process. This is the primary place to configure the aristaos build process.
* aristaos-manifest (project) is a separate git repo containing the env.sh file and the Google Repo manifest file.

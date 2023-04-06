# Yocto project to build Arista OS

Loosely based off the NXP imx-docker scripts.

Prerequisites
=============

Install Docker
--------------

There are various methods of installing [docker], i.e. by docker script:
  ```{.sh}
  $ curl -fsSL https://get.docker.com -o get-docker.sh
  $ sudo sh get-docker.sh
  ```

Run docker without sudo
-----------------------

To work better with docker, without `sudo`, add your user to `docker group`.
  ```{.sh}
  $ sudo usermod -aG docker <your_user>
  ```

Log out and log back in so that your group membership is re-evaluated.

Build aristaos with docker
======================
```{.sh}
.
├── aristaos.code-workspace
├── cgtimx6_zeus
│   ├── env.sh
│   └── yocto-build.sh
├── docker-build.sh
├── Dockerfile-Ubuntu-18.04
├── docker-run.sh
├── docs
│   └── congatec-yocto-zeus-setup.txt
├── env.sh -> cgtimx6_zeus/env.sh
└── README.md

```

Clone AristaOS source code
-------------

```{.sh}
git clone git@github.com:practichem/aristaos.git -b develop_zeus
```

Set variables
-------------

Use `env.sh` to set variables for your build setup. Make sure you have 
created a working directory, owned by current user, on a larger partition.

Assuming the working directory is $HOME/yocto

```{.sh}
mkdir -p $HOME/yocto
chown -R $USER:$USER $HOME/yocto
```

Create a yocto-ready docker image
---------------------------------

Run `docker-build.sh` with one argument, related to Dockerfile, corresponding 
to the operating system, for example the Dockerfile for Ubuntu version 20.04:

```{.sh}
  $ ./docker-build.sh Dockerfile-Ubuntu-18.04
```

Build the yocto imx-image in a docker container
-----------------------------------------------

```{.sh}
  $ ./docker-run.sh cgtimx6_zeus_imx-5.4.70-2.3.9/yocto-build.sh
```

or just go to the docker container prompt (and run the build script from there):

```{.sh}
  $ ./docker-run.sh
```

When running, volumes are used to save the build artifacts on host.
  - `{DOCKER_WORKDIR}` as the main workspace
  - `{DOCKER_WORKDIR}/${IMX_RELEASE}` to make available the yocto build scripts 
    into container
  - `{HOME}` to mount the current home user, to make available the user 
    settings inside the container (ssh keys, git config, etc)

[docker]: https://docs.docker.com/engine/install/ubuntu/ "DockerInstall/Ubuntu"


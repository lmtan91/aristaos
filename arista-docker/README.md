
This setup helps build Arista OS in a Docker isolated environment.
2.0 uses Ubuntu 18.04 and Yocto Project Zeus, as a supported dependency set.
This recipe requires a manifest stored in a git repo with a branch name.


Prerequisites
=============

Install Docker

Build i.MX with docker
======================
```{.sh}
.
├── Dockerfile-Ubuntu-18.04
├── README.md
├── docker-build.sh
├── docker-run.sh
├── env.sh -> imx-5.10.35-2.0.0/env.sh
└── imx-5.10.35-2.0.0
    ├── env.sh
    └── yocto-build.sh
```

Set variables
-------------

Use `env.sh` to set variables for your build setup. Make sure you have 
created a working directory, owned by current user, on a larger partition.

Create a yocto-ready docker image
---------------------------------

Run `docker-build.sh` with one argument, related to Dockerfile, corresponding 
to the operating system, for example the Dockerfile for Ubuntu version 20.04:

```{.sh}
  $ ./docker-build.sh Dockerfile-Ubuntu-20.04
```

Build the yocto imx-image in a docker container
-----------------------------------------------

```{.sh}
  $ ./docker-run.sh ${IMX_RELEASE}/yocto-build.sh

  i.e IMX_RELEASE=imx-5.10.35-2.0.0
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

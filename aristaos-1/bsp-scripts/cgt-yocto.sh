#!/bin/bash

# Script to fetch the yocto repositories
# (c) Congatec AG


VERSION="1.8"
BRANCH="fido"


if [ $# -eq 0 ]
   then
	mkdir -p sources
	cd sources

	git clone https://git.congatec.com/yocto/meta-fsl-arm-extra.git
	git clone https://git.congatec.com/yocto/meta-fsl-arm.git
	git clone https://git.congatec.com/yocto/base.git
	git clone https://git.congatec.com/yocto/meta-fsl-demos.git
	git clone https://git.congatec.com/yocto/meta-openembedded.git
	git clone https://git.congatec.com/yocto/poky.git

	cd meta-fsl-arm-extra && git checkout $BRANCH  &&  cd ..
	cd meta-fsl-arm &&  git checkout $VERSION &&  cd ..
	cd base && git checkout $VERSION &&  cd ..
	cd meta-fsl-demos &&  git checkout $VERSION &&  cd ..
	cd meta-openembedded &&  git checkout $VERSION &&  cd ..
	cd poky &&  git checkout $VERSION &&  cd ..
fi

if [ "$1" == 'update' ]
   then
	 cd sources
	 echo -n "meta-fsl-arm-extra: " ; cd meta-fsl-arm-extra && git pull && cd ..
	 echo -n "meta-fsl-arm: " ; cd meta-fsl-arm &&  git fetch --tags && git fetch &&  git checkout $VERSION && cd ..
	 echo -n "base: " ; cd base && git fetch --tags && git fetch &&  git checkout $VERSION && cd ..
	 echo -n "meta-fsl-demos: " ; cd meta-fsl-demos && git fetch --tags && git fetch &&  git checkout $VERSION && cd ..
	 echo -n "meta-openembedded: " ; cd meta-openembedded && git fetch --tags && git fetch &&  git checkout $VERSION &&  cd ..
	 echo -n "poky: " ; cd poky && git fetch --tags && git fetch &&  git checkout $VERSION &&  cd ..
	 cd ..
fi

echo "----------
   DONE
----------"

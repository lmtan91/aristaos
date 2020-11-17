# Note
The `cgt-yocto.sh` and `setup-environment` files come from this Congatec repo:
* https://git.congatec.com/yocto/bsp-scripts

<br/>  
 
 # Original README from Congatec

## 1. Setting up and building Yocto
------------------------------------

Installation in Ubuntu 14.04 64 bit [Clean install]

Some packages are needed:

	$ sudo apt-get update
	$ sudo apt-get install gawk wget git-core diffstat unzip texinfo  build-essential chrpath libsdl1.2-dev xterm curl

To get the yocto recipes:

   $ mkdir ~/yocto
   $ cd ~/yocto
   $ git clone https://git.congatec.com/yocto/bsp-scripts.git .
   $ git checkout fido	
   $ chmod +x cgt-yocto.sh
   $ ./cgt-yocto.sh
 
To config the build environment:

   $ MACHINE='cgtqmx6' source setup-environment build
	  [ ! ] EULA accept needed for next step.

Different images can be built now:

- fsl-image-machine-test: "A console-only image that includes gstreamer packages, Freescale's multimedia packages (VPU and GPU) when available, and test and benchmark applications."

- fsl-image-multimedia-full: "A console-only image that includes gstreamer packages and Freescale's multimedia packages (VPU and GPU) when available for the specific machine extended with additional gstreamer plugins."

- core-image-sato: "Image with Sato, a mobile environment and visual style for mobile devices. The image supports X11 with a Sato theme, Pimlico applications, and contains terminal, editor, and file manager."


To build the fsl-image-machine-test image use:

   $ bitbake fsl-image-machine-test

The process will take hours.

When it finishes the image will be located ~/yocto/build/tmp/deploy/images/cgtqmx6/

1.1 Updating the sources
------------------------
In order to check and update the sources from the selected Yocto version:

	$ cd ~/yocto
	$ ./cgt-yocto.sh update

Afterwards if anything is updated the image must be bitbaked again.


## 2. Transfer the root file system
--------------

2.1. micro SD
--------------
In order to transfer the image to a uSD card, follow the next steps changing sdX for your detected device:

	$ cd ~/yocto/build/tmp/deploy/images/cgtqmx6/
	$ sudo dd if=/dev/zero of=/dev/sdX count=1000 bs=512
	$ sudo sfdisk --force -uM /dev/sdX <<EOF
		10,,83
		EOF
	$ sudo mkfs.ext3 -j /dev/sdX1
	$ sudo mount /dev/sdX1 /mnt
	$ sudo tar -xjvf fsl-image-machine-test-cgtqmx6-xxxxxxxxxxxxxx.tar.bz2 -C /mnt
	$ sync
	$ sudo umount /dev/sdX1

2.2. eMMC
----------
An uSD is needed as a bridge, then the first step is follow the steps of "Transfer the root file system to a micro SD card", and transfer the image tar.bz2 file to the micro SD with the following command:

	$ cd ~/yocto/build/tmp/deploy/images/cgtqmx6/
	$ sudo mount /dev/sdX1 /mnt
	$ sudo cp fsl-image-machine-test-cgtqmx6-xxxxxxxxxxxxxx.tar.bz2 /mnt
	$ sync
	$ sudo umount /dev/sdX1
	
Boot the system and:
	
	$ sudo dd if=/dev/zero of=/dev/mmcblk1 count=1000 bs=512
	$ echo -e "o\nn\np\n1\n\n\nw\n" | fdisk /dev/mmcblk1
	$ sudo mkfs.ext3 -j /dev/mmcblk2p1
	$ sudo mount /dev/mmcblk2p1 /mnt
	$ sudo tar -xjvf fsl-image-machine-test-cgtqmx6-xxxxxxxxxxxxxx.tar.bz2 -C /mnt
	$ sync
	
Shutdown the system and remove the microSD card.

Stop the autoboot pressing any key:

	$ setenv mmcdev 1
	$ setenv mmcroot '/dev/mmcblk1p1 rootwait rw'
	$ save
	$ reset
	
2.3 external SD
---------------
In order to transfer the image to a SD card, follow the next steps changing sdX for your detected device:

	$ cd ~/yocto/build/tmp/deploy/images/cgtqmx6/
	$ sudo dd if=/dev/zero of=/dev/sdX count=1000 bs=512
	$ sudo sfdisk --force -uM /dev/sdX <<EOF
		10,,83
		EOF
	$ sudo mkfs.ext3 -j /dev/sdX1
	$ sudo mount /dev/sdX1 /mnt
	$ sudo tar -xjvf fsl-image-machine-test-cgtqmx6-xxxxxxxxxxxxxx.tar.bz2 -C /mnt
	$ sync
	$ sudo umount /dev/sdX1
	
	
Boot the system and stop the autoboot pressing any key:

	$ setenv mmcdev 2
	$ setenv mmcroot '/dev/mmcblk2p1 rootwait rw'
	$ save
	$ reset

## 3. U-boot 
---------

From this release onwards, for every part number supported the U-boot binary is built, and can be found in the deploy folder "~/yocto/build/tmp/deploy/images/cgtqmx6/" with the following name: u-boot-pn0161XY-2013.04-r0.imx

The QMX6 board must be flashed with the appropriate file: "~/yocto/build/tmp/deploy/images/cgtqmx6/u-boot-pn0161XY-2013.04-r0.imx" using the Manufacturing tool.

(c) 2015, Alex de Cabo, congatec AG



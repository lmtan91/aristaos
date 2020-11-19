#FROM crops/poky:ubuntu-20.04
#FROM crops/yocto:ubuntu-20.04-base
#FROM crops/yocto:ubuntu-16.04-base
#FROM crops/yocto:ubuntu-14.04-base
FROM crops/yocto:ubuntu-14.04-base-pchem
#FROM 839831791238.dkr.ecr.us-east-1.amazonaws.com/practichem/aristaos-1:crops-yocto-ubuntu-14.04-base-pchem

USER root
RUN apt-get update && \
    apt-get install -y \
#    libsdl1.2-dev \
#    libxtst-dev \
	vim

#RUN rm -rf /var/lib/apt/lists/*

USER yoctouser

#COPY --chown=yoctouser:yoctouser ./bsp-scripts/ bsp-scripts

#RUN chmod -R +x bsp-scripts/sources/poky/scripts
#RUN chmod -R +x bsp-scripts/sources/poky/bitbake/bin

#COPY RUN mkdir -p bsp-scripts/downloads
#COPY --chown=yoctouser:yoctouser ./files/* bsp-scripts/downloads/

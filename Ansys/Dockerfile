# Ansys Docker file
# https://www.cfd-online.com/Forums/ansys/231493-ansys-installation-docker-container.html
# https://stackoverflow.com/questions/25845538/how-to-use-sudo-inside-a-docker-container

# ansys 22R2 works only with ubuntu 20.04, later versions not supported

#FROM ubuntu:20.04

#FROM nvidia/opengl:1.2-glvnd-runtime-ubuntu20.04


FROM nvidia/cuda:12.0.0-runtime-ubuntu20.04


MAINTAINER Bhaskar Sen "bhaskar.sen1@outlook.com"

ARG DEBIAN_FRONTEND=noninteractive

COPY ./keyboard /etc/default/keyboard


RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update \
    && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    rsync \
    strace \
    sudo \
    pciutils \
    mc \
    vim \
    locate \
	less \
	unzip \
	zip \
	curl \
	ninja-build \
	pkg-config \
	python3-dev \
	python3-pip \
	python3-wheel \
	python3-setuptools \
	python3-venv \
	build-essential


#install add-apt-repository    
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get -y install software-properties-common

# add libpng12 which is non standard for ubuntu 20.04
RUN add-apt-repository ppa:linuxuprising/libpng12 && \
    apt-get update && \
    apt-get -y install libpng12-0

# https://www.cfd-online.com/Forums/ansys/231493-ansys-installation-docker-container.html
RUN apt-get install -y fontconfig xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic

# install libxp package
#https://askubuntu.com/questions/1318350/i-cannot-find-the-library-libxp-so-6-for-ubuntu-20-04
Run cd /tmp &&\
    wget -c http://security.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1.6_amd64.deb &&\
    wget -c http://ftp.debian.org/debian/pool/main/libx/libxp/libxp6_1.0.2-2_amd64.deb && \
    apt-get install -y ./multiarch-support_2.27-3ubuntu1.6_amd64.deb ./libxp6_1.0.2-2_amd64.deb

RUN apt-get install -y dirmngr gnupg apt-transport-https ca-certificates software-properties-common
RUN apt-get install -y openmpi-bin openmpi-common 
#openmp-extras
RUN apt-get install -y mpich
RUN apt-get install -y mono-complete

#glxgears to test
RUN apt-get install -y mesa-utils

#https://ansyshelp.ansys.com/account/secured?returnurl=/Views/Secured/corp/v222/en/installation/unix_platformdetails.html
RUN apt-get install -y libc6-i386 libqwt-qt5-6 


# https://ansyshelp.ansys.com/account/secured?returnurl=/Views/Secured/corp/v222/en/installation/unix_platform_libraries.html

# add all common dependencies
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get -y install libasound2  \
			libatk-bridge2.0-0 \
			libatk1.0-0  \
			libatspi2.0-0  \
			libavahi-client3  \
			libavahi-common3  \
			libblkid1  \
			libbsd0  \
			libc6  \
			libcairo-gobject2  \
			libcairo2  \
			libcom-err2  \
			libcups2  \
			libdatrie1  \
			libdbus-1-3  \
			libdrm2  \
			libepoxy0  \
			libexpat1  \
			libffi7  \
			libfontconfig1  \
			libfreetype6  \
			libfribidi0  \
			libgbm1  \
			libgcc-s1  \
			libgcrypt20  \
			libgdk-pixbuf2.0-0  \
			libglib2.0-0  \
			libgmp10  \
			libgnutls30  \
			libgpg-error0  \
			libgraphite2-3  \
			libgssapi-krb5-2  \
			libgtk-3-0  \
			libharfbuzz0b  \
			libhogweed5  \
			libice6  \
			libidn2-0  \
			libk5crypto3  \
			libkeyutils1  \
			libkrb5-3  \
			libkrb5support0  \
			liblz4-1  \
			liblzma5  \
			libmount1  \
			libnettle7  \
			libnspr4  \
			libnss3  \
			libp11-kit0  \
			libpango-1.0-0  \
			libpangocairo-1.0-0  \
			libpangoft2-1.0-0  \
			libpcre2-8-0  \
			libpcre3  \
			libpixman-1-0  \
			libpng16-16  \
			libselinux1  \
			libsm6  \
			libsqlite3-0  \
			libsystemd0  \
			libtasn1-6  \
			libthai0  \
			libunistring2  \
			libuuid1  \
			libwayland-client0  \
			libwayland-cursor0  \
			libwayland-egl1  \
			libwayland-server0  \
			libx11-6  \
			libx11-xcb1  \
			libxau6  \
			libxcb-dri3-0  \
			libxcb-render0  \
			libxcb-shm0  \
			libxcb1  \
			libxcomposite1  \
			libxcursor1  \
			libxdamage1  \
			libxdmcp6  \
			libxext6  \
			libxfixes3  \
			libxft2  \
			libxi6  \
			libxinerama1  \
			libxkbcommon0  \
			libxrandr2  \
			libxrender1  \
			libxss1  \
			libxtst6  \
			lsb-core

# maxwell specific dependencies
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get -y install libgif7 libxmu6 libxt6 libxxf86vm1 libgl1-mesa-dri libglx-mesa0 libglu1-mesa xsltproc

# dependencies for optislang
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get install -y libapparmor1 \ 
			libasn1-8-heimdal \ 
			libasyncns0 \ 
			libbrotli1 \ 
			libbz2-1.0 \ 
			libcrypt1 \ 
			libcurl4-gnutls-dev \ 
			libegl1 \ 
			libenchant-2-2 \ 
			libflac8 \ 
			libgfortran5 \ 
			libgl1 \ 
			libglu1-mesa \ 
			libglvnd0 \ 
			libglx0 \ 
			libgomp1 \ 
			libgssapi3-heimdal \ 
			libgstreamer-gl1.0-0 \ 
			libgstreamer-plugins-base1.0-0 \ 
			libgstreamer1.0-0 \ 
			libgtk2.0-0 \ 
			libgudev-1.0-0 \ 
			libharfbuzz-icu0 \ 
			libhcrypto4-heimdal \ 
			libheimbase1-heimdal \ 
			libheimntlm0-heimdal \ 
			libhx509-5-heimdal \ 
			libhyphen0 \ 
			libibverbs1 \ 
			libicu66 \ 
			libjavascriptcoregtk-4.0-18 \ 
			libjbig0 \ 
			libjpeg-turbo8 \ 
			libkrb5-26-heimdal \ 
			libldap-2.4-2 \ 
			libltdl7 \ 
			libnotify4 \ 
			libogg0 \ 
			libopenjp2-7 \ 
			liborc-0.4-0 \ 
			libpcre3-dev \ 
			libperl-dev \ 
			libpsl5 \ 
			libpulse-mainloop-glib0 \ 
			libpulse0 \ 
			libquadmath0 \ 
			libroken18-heimdal \ 
			libsasl2-2 \ 
			libseccomp2 \ 
			libsecret-1-0 \ 
			libsndfile1 \ 
			libsoup2.4-1 \ 
			libtiff5 \ 
			libudev1 \ 
			libvorbis0a \ 
			libvorbisenc2 \ 
			libwebkit2gtk-4.0-37 \ 
			libwebp6 \ 
			libwebpdemux2 \ 
			libwind0-heimdal \ 
			libwoff1 \ 
			libwrap0 \ 
			libxcb-icccm4 \ 
			libxcb-image0 \ 
			libxcb-keysyms1 \ 
			libxcb-randr0 \ 
			libxcb-render-util0 \ 
			libxcb-shape0 \ 
			libxcb-sync1 \ 
			libxcb-util1 \ 
			libxcb-xfixes0 \ 
			libxcb-xinerama0 \ 
			libxcb-xkb1 \ 
			libxkbcommon-x11-0 \ 
			libxm4 \ 
			libxml2 \ 
			libxmu6 \ 
			libxshmfence1 \ 
			libxslt1.1 \ 
			libxt6 \ 
			libxxf86vm1 \ 
			uuid-dev

# dependencies for ansys mechanical
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get install -y coinor-libipopt1v5 \ 
			libbrotli1 \ 
			libbz2-1.0 \ 
			libcrypt1 \ 
			libcurl4-gnutls-dev \ 
			libdrm-amdgpu1 \ 
			libegl1 \ 
			libelf1 \ 
			libenchant-2-2 \ 
			libgfortran5 \ 
			libgl1 \ 
			libglu1-mesa \ 
			libglvnd0 \ 
			libglx0 \ 
			libgomp1 \ 
			libgstreamer-gl1.0-0 \ 
			libgstreamer-plugins-base1.0-0 \ 
			libgstreamer1.0-0 \ 
			libgtk2.0-0 \ 
			libgudev-1.0-0 \ 
			libharfbuzz-icu0 \ 
			libhyphen0 \ 
			libibverbs1 \ 
			libicu66 \ 
			libjavascriptcoregtk-4.0-18 \ 
			libjbig0 \ 
			libjpeg-turbo8 \ 
			libltdl7 \ 
			libmumps-dev \ 
			libnotify4 \ 
			libnuma1 \ 
			libopenjp2-7 \ 
			liborc-0.4-0 \ 
			libpcre3-dev \ 
			libperl-dev \ 
			libpng-dev \ 
			libpsl5 \ 
			libqhull-dev \ 
			libquadmath0 \ 
			libseccomp2 \ 
			libsecret-1-0 \ 
			libsoup2.4-1 \ 
			libspooles-dev \ 
			libtbb2 \ 
			libtiff-dev \ 
			libtiff5 \ 
			libtinfo5 \ 
			libudev1 \ 
			libwebkit2gtk-4.0-37 \ 
			libwebp6 \ 
			libwebpdemux2 \ 
			libwoff1 \ 
			libxm4 \ 
			libxml2 \ 
			libxmu6 \ 
			libxshmfence1 \ 
			libxslt1.1 \ 
			libxt6 \ 
			libxxf86vm1 \ 
			uuid-dev

#icepack dependencies
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get install -y libasn1-8-heimdal \ 
			libbrotli1 \ 
			libbz2-1.0 \ 
			libcrypt1 \ 
			libcurl4-gnutls-dev \ 
			libegl1 \ 
			libenchant-2-2 \ 
			libfontenc1 \ 
			libgfortran5 \ 
			libgl1 \ 
			libglu1-mesa \ 
			libglvnd0 \ 
			libglx0 \ 
			libgomp1 \ 
			libgssapi3-heimdal \ 
			libgstreamer-gl1.0-0 \ 
			libgstreamer-plugins-base1.0-0 \ 
			libgstreamer1.0-0 \ 
			libgudev-1.0-0 \ 
			libharfbuzz-icu0 \ 
			libhcrypto4-heimdal \ 
			libheimbase1-heimdal \ 
			libheimntlm0-heimdal \ 
			libhx509-5-heimdal \ 
			libhyphen0 \ 
			libibverbs1 \ 
			libicu66 \ 
			libjavascriptcoregtk-4.0-18 \ 
			libjbig0 \ 
			libjpeg-turbo8 \ 
			libkrb5-26-heimdal \ 
			libldap-2.4-2 \ 
			libltdl7 \ 
			libnotify4 \ 
			libopenjp2-7 \ 
			liborc-0.4-0 \ 
			libpam0g \ 
			libpci3 \ 
			libpcre3-dev \ 
			libperl-dev \ 
			libpsl5 \ 
			libquadmath0 \ 
			libroken18-heimdal \ 
			libsasl2-2 \ 
			libseccomp2 \ 
			libsecret-1-0 \ 
			libsoup2.4-1 \ 
			libtiff5 \ 
			libudev1 \ 
			libwebkit2gtk-4.0-37 \ 
			libwebp6 \ 
			libwebpdemux2 \ 
			libwind0-heimdal \ 
			libwoff1 \ 
			libxcb-xfixes0 \ 
			libxcb-xkb1 \ 
			libxkbcommon-x11-0 \ 
			libxm4 \ 
			libxml2 \ 
			libxmu6 \ 
			libxshmfence1 \ 
			libxslt1.1 \ 
			libxt6 \ 
			libxxf86vm1 \ 
			ocl-icd-opencl-dev \ 
			uuid-dev

# fluent dependencies
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get install -y libasn1-8-heimdal \ 
			libbrotli1 \ 
			libbz2-1.0 \ 
			libcrypt1 \ 
			libcurl4-gnutls-dev \ 
			libegl1 \ 
			libembree3-3 \ 
			libenchant-2-2 \ 
			libfontenc1 \ 
			libgfortran5 \ 
			libgl1 \ 
			libglu1-mesa \ 
			libglvnd0 \ 
			libglx0 \ 
			libgomp1 \ 
			libgssapi3-heimdal \ 
			libgstreamer-gl1.0-0 \ 
			libgstreamer-plugins-base1.0-0 \ 
			libgstreamer1.0-0 \ 
			libgudev-1.0-0 \ 
			libharfbuzz-icu0 \ 
			libhcrypto4-heimdal \ 
			libheimbase1-heimdal \ 
			libheimntlm0-heimdal \ 
			libhx509-5-heimdal \ 
			libhyphen0 \ 
			libibverbs1 \ 
			libicu66 \ 
			libjavascriptcoregtk-4.0-18 \ 
			libjbig0 \ 
			libjpeg-turbo8 \ 
			libkrb5-26-heimdal \ 
			libldap-2.4-2 \ 
			libltdl7 \ 
			libnotify4 \ 
			libopenjp2-7 \ 
			liborc-0.4-0 \ 
			libpam0g \ 
			libpci3 \ 
			libpcre3-dev \ 
			libperl-dev \ 
			libpsl5 \ 
			libquadmath0 \ 
			libroken18-heimdal \ 
			libsasl2-2 \ 
			libseccomp2 \ 
			libsecret-1-0 \ 
			libsoup2.4-1 \ 
			libtbb2 \ 
			libtiff5 \ 
			libudev1 \ 
			libwebkit2gtk-4.0-37 \ 
			libwebp6 \ 
			libwebpdemux2 \ 
			libwind0-heimdal \ 
			libwoff1 \ 
			libxcb-xfixes0 \ 
			libxcb-xkb1 \ 
			libxkbcommon-x11-0 \ 
			libxm4 \ 
			libxml2 \ 
			libxmu6 \ 
			libxshmfence1 \ 
			libxslt1.1 \ 
			libxt6 \ 
			libxxf86vm1 \ 
			ocl-icd-opencl-dev \ 
			uuid-dev

#https://forum.ansys.com/forums/topic/execute-workbech-on-ubuntu/
RUN apt-get install -y lsb alien


RUN apt-get -y install -y x11-apps
#xpdf

#RUN apt-get install -y python3-venv
#RUN apt-get install -y python3-pip
#RUN pip3 install wheel
RUN apt-get install -y --reinstall libxcb-xinerama0
RUN apt-get install -y libqt5x11extras5


# install AMDGPU drivers - system specific. Works in AMD 5800H laptop processor
RUN wget https://repo.radeon.com/amdgpu-install/22.20.5/ubuntu/focal/amdgpu-install_22.20.50205-1_all.deb &&\
    dpkg -i amdgpu-install_22.20.50205-1_all.deb &&\
    amdgpu-install --usecase=graphics,opencl -y --accept-eula


#WORKDIR /root
#CMD /bin/bash

RUN apt-get install -y libqt5quickcontrols2-5 libqt5multimedia5 libqt5webengine5 libqt5quick5 libqt5qml5
RUN apt-get install -y libicu-dev libqt5webengine5 libqt5sensors5 libqt5webkit5 libqt5printsupport5 
#RUN apt-get install -y libjpeg62:i386
RUN apt-get install -y libicu-dev qt5-default

# https://www.baeldung.com/ops/dockerfile-path-environment-variable
ENV PATH="/opt/AnsysEM/v222/Linux64:${PATH}" 
ENV PATH="/opt/AnsysEM/shared_files/licensing/linx64:${PATH}"

ENV ANSYSEM_ROOT222="/opt/AnsysEM/v222/Linux64"

ENV ANSYS222_DIR=/opt/ansys_inc/v222/ansys

#env needed for optislang
#https://ansyshelp.ansys.com/account/secured?returnurl=/Views/Secured/corp/v222/en/opti_inst_lic/opti_inst_lic_install_opti_linux.html

ENV AWP_ROOT222=/opt/ansys_inc/v222
# needed by optislang
RUN locale-gen en_US.UTF-8
RUN apt-get install -y graphviz


ENV PATH=/opt/dynardo/ANSYS_optiSLang_2022R2/:$PATH
ENV PATH=/opt/ansys_inc/v222/fluent/bin:$PATH
ENV PATH=/opt/ansys_inc/v222/CFX/bin:$PATH
ENV PATH=/opt/ansys_inc/v222/icemcfd/linux64_amd/bin:$PATH
ENV PATH=/opt/ansys_inc/v222/Framework/bin/Linux64/:$PATH

RUN echo $PATH 


#### ADD DEFAULT USER ####
ARG USER=glacier
ENV USER ${USER}
RUN adduser --disabled-password --gecos '' ${USER} \
	&& adduser ${USER} sudo \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENV USER_HOME /home/${USER}
RUN chown -R ${USER}:${USER} ${USER_HOME}
RUN chown -R root:${USER} /opt
RUN chmod -R g+rwx /opt 

RUN chown -R root:${USER} /tmp
RUN chmod -R g+rwx /tmp 

#### CREATE WORKING DIRECTORY FOR USER ####
#ARG WORKDIR=/project
#ENV WORKDIR ${WORKDIR}
#RUN mkdir ${WORKDIR}
#RUN chown -R ${USER}:${USER} ${WORKDIR}
#WORKDIR ${WORKDIR}


# add the ansys installer files
# assumes that the files are there in the same folder as the dockerfile
ADD ELECTRONICS_2022R2_LINX64.tgz  /tmp/
ADD FLUIDSTRUCTURES_2022R2_LINX64.tgz /tmp/
ADD OPTISLANG_2022R2_LINX64.tgz /tmp/

WORKDIR ${USER_HOME}
USER ${USER}


#RUN cd /tmp && tar zxvf /tmp/ELECTRONICS_2022R2_LINX64.tgz

#-------------------------------
# post install steps
# create a host folder which will mirror guest home folder (07_Ansys_workspace : /home/glacier)

# run the ./run_container.sh without the --rm option since we will have to run the gui installers
# cd /tmp/Electronics_222_linx64/
# ./install
# do install at /opt/AnsysEM (default option)
# server 10.1.0.4
# for libraries select local installation
#after ansysEM installation
# cd ..
# ./INSTALL
#install directory /opt/ansys_inc
# select options, i dont select ls dyna, and aqua 
# 



















# xhost +"local:docker@"
# docker run        -it   -e DISPLAY=$DISPLAY   --device=/dev/dri         -v /tmp/.X11-unix:/tmp/.X11-unix:rw            -v $(pwd)/project:/project            --rm elmer:latest




# 

# in the host run
#   xhost +"local:docker@"
# to enable x11 sharing

# python3 -m venv spyder-env
# source spyder-env/bin/activate
# pip3 install wheel
# pip3 install pyaedt
# pip3 install spyder
# python3 /root/Maxwell2D_NissanLeaf.py

# ENV QTWEBENGINE_DISABLE_SANDBOX=1 spyder
# change python environment to point to the venv python interpreter

# https://github.com/giampaolo/psutil/pull/2103

#WORKDIR /root
#CMD /bin/bash

####### INSTRUCTIONS ##########################
# create docker by going into the folder and running
# https://phoenixnap.com/kb/how-to-commit-changes-to-docker-image

# docker build -t ubuntu-blank . 

# login to the docker by following command
# docker run -it ubuntu-blank

# you should get a similar prompt
# bot@1552b799b417:~$ sudo apt-get install vim

# after vim installation exit
# bot@1552b799b417:~$ exit
# exit

# find container image hash by running 
# docker ps -a
# matrix@ThinkbookLaptop16p:~/Work/02_DockerImages/Blank_ubuntu$ docker ps -a

# CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                            PORTS     NAMES
# 56584b41d175   ubuntu-blank   "/bin/sh -c /bin/bash"   2 minutes ago    Exited (127) About a minute ago             sad_williamson
# 1552b799b417   ubuntu-blank   "/bin/sh -c /bin/bash"   5 minutes ago    Exited (0) 2 minutes ago                    ecstatic_kapitsa
# 9ead1aa21db9   2b87ed38b0fc   "/bin/bash"              14 minutes ago   Exited (127) 8 minutes ago                  great_greider

# then commit the changes to a new image
# matrix@ThinkbookLaptop16p:~/Work/02_DockerImages/Blank_ubuntu$ docker commit 1552b799b417 ubuntu-test
# sha256:c9d0a17c80e0d1845a61ba7b4cdbe397de500bf34e0be7665d29da774dc9d3fe

# run the updated container
# matrix@ThinkbookLaptop16p:~/Work/02_DockerImages/Blank_ubuntu$ docker run -it ubuntu-test
# bot@cfc0c32d975b:~$ vim

# after all commits delete rest of the images
# https://docs.docker.com/engine/reference/commandline/rm/
# docker rm $(docker ps --filter status=exited -q)

# running the container
# docker build -t ubuntu-blank .
# docker run          -it   -e DISPLAY=$DISPLAY            -v /tmp/.X11-unix:/tmp/.X11-unix:rw            -v $(pwd)/:/root            --rm ubuntu-blank:latest
#docker run          -it   -e DISPLAY=$DISPLAY   --device=/dev/dri      -v /tmp/.X11-unix:/tmp/.X11-unix:rw            -v $(pwd)/:/root           ubuntu-ansys:latest 

#.......
# docker build . -t temp:latest
# docker run        -it   -e DISPLAY=$DISPLAY   --device=/dev/dri         -v /tmp/.X11-unix:/tmp/.X11-unix:rw            -v $(pwd)/project:/project            --rm temp:latest




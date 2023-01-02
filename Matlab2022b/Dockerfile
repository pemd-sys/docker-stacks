# modified from https://github.com/mathworks-ref-arch/container-images.git
# glibc mod not needed on ubuntu 22.04
# --no-install-recommends removed from apt-get options

# Copyright 2022 The MathWorks, Inc.
FROM ubuntu:22.04

MAINTAINER Bhaskar Sen "bhaskar.sen1@outlook.com"

ENV DEBIAN_FRONTEND="noninteractive" TZ="Etc/UTC"

COPY base-dependencies.txt /tmp/base-dependencies.txt

RUN apt-get update && apt-get install -y `cat /tmp/base-dependencies.txt` \
    && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# copy keyboard settings
RUN [ -d /usr/share/X11/xkb ] || mkdir -p /usr/share/X11/xkb

# Install patched glibc - See https://github.com/mathworks/build-glibc-bz-19329-patch
# Note: base-dependencies.txt includes libcrypt-dev and linux-libc-dev to enable installation of patched -dev packages
#WORKDIR /packages
#RUN export DEBIAN_FRONTEND=noninteractive &&\
#    wget -q https://github.com/mathworks/build-glibc-bz-19329-patch/releases/download/ubuntu-focal/all-packages.tar.gz &&\
#    tar -x -f all-packages.tar.gz \
#        --exclude glibc-*.deb \
#        --exclude libc6-dbg*.deb &&\
#    apt-get install --yes --no-install-recommends ./*.deb &&\
#    rm -fr /packages
#WORKDIR /

# Uncomment the following RUN apt-get statement if you will be using Simulink 
# code generation capabilities, or if you will be compiling your own mex files
# with gcc, g++, or gfortran.
#
RUN apt-get update -y && apt-get install -y gcc g++ gfortran build-essential && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Uncomment the following RUN apt-get statement to enable running a program
# that makes use of MATLAB's Engine API for C and Fortran
# https://www.mathworks.com/help/matlab/matlab_external/introducing-matlab-engine.html
#
RUN apt-get update -y && apt-get install -y csh && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Uncomment ALL of the following RUN apt-get statement to enable the playing of media files
# (mp3, mp4, etc.) from within MATLAB.
#
RUN apt-get update -y && apt-get install --no-install-recommends -y libgstreamer1.0-0 \
 gstreamer1.0-tools \
 gstreamer1.0-libav \
 gstreamer1.0-plugins-base \
 gstreamer1.0-plugins-good \
 gstreamer1.0-plugins-bad \
 gstreamer1.0-plugins-ugly \
 && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Uncomment the following line if you require the fuse filesystem
RUN apt-get update -y && apt-get install -y libfuse2 && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Uncomment the following line if you require firefox
#RUN apt-get update -y && apt-get install --no-install-recommends -y firefox && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Uncomment to resolve any license manager issues
#RUN ln -s /lib64/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3

# Extra dependencies
RUN apt-get update -y && apt-get install -y libcanberra-gtk-module libffi-dev

# install AMDGPU drivers - system specific. Works in AMD 5800H laptop processor
RUN cd /tmp && \
	wget https://repo.radeon.com/amdgpu-install/22.20.5/ubuntu/jammy/amdgpu-install_22.20.50205-1_all.deb &&\
    dpkg -i amdgpu-install_22.20.50205-1_all.deb &&\
    amdgpu-install --usecase=graphics,opencl --opencl=legacy,rocr --vulkan=amdvlk,pro --no-32  -y --accept-eula


RUN apt-get update -y && apt-get -y install -y x11-apps mesa-utils glmark2 && rm -rf /var/lib/apt/lists/*

# install networking tools
RUN apt-get update -y && apt-get install -y iproute2 traceroute ufw iputils-ping  iputils-tracepath && rm -rf /var/lib/apt/lists/*
	
RUN apt-get update -y && apt-get install -y vim \
	mc \
	pkg-config \
	python3-dev \
	python3-pip \
	python3-wheel \
	python3-setuptools \
	python3-venv \
	&& rm -rf /var/lib/apt/lists/*

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

WORKDIR ${USER_HOME}
USER ${USER}


# post installation 
# install matlab
# re-install libcanberra-gtk-module for some un-known reason matlab complains and it stops complaining after re-install


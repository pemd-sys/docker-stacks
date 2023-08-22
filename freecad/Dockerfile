# Freecad Docker file

# Tested on ThinkBook 16p G2 ACH Laptop
# Ryzen 7 5800H APU with Nvidia RTX 3060
# Thats why uses the nvidia container
# Also has the required ryzen - radeon drivers installed. Can use both

 
# Set the base image to the latest LTS version of Ubuntu
#FROM ubuntu:latest

# TO-DO


FROM nvidia/cuda:12.0.0-runtime-ubuntu22.04


ARG GMSH_VERSION=4_11_1

# Set the working directory to /home
WORKDIR /home

# Create an apt configuration file to fix erroneous "hash sum mismatch" errors
RUN printf "Acquire::http::Pipeline-Depth 0;\nAcquire::http::No-Cache true;\nAcquire::BrokenProxy true;" \
	>> /etc/apt/apt.conf.d/99fixbadproxy

ENV DEBIAN_FRONTEND="noninteractive"

 
# Add the necessary packages to compile 
RUN apt-get update -o Acquire::CompressionTypes::Order::=gz && apt-get upgrade -y && apt-get install -y \
	build-essential \
	cmake \
	git \
	mpich \
	sudo \
	less \
	unzip \
	zip \
	curl \
	wget \
	ca-certificates \
	ninja-build \
	pkg-config && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*
    
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    apt-get -y install \
    python3 \
     python3-launchpadlib \
     initramfs-tools \
	python3-dev \
	python3-pip \
	python3-wheel \
	python3-setuptools \
	python3-venv \
	python3-poetry \
	python3-tomli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*   	

## install freecad dependencies - compile freecad in userspace - does not work with gmsh compile -- mpi_info error

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    apt-get -y install \
    cmake libboost-date-time-dev libboost-dev libboost-filesystem-dev libboost-graph-dev libboost-iostreams-dev libboost-program-options-dev \
    libboost-python-dev libboost-regex-dev libboost-serialization-dev libboost-thread-dev libcoin-dev libeigen3-dev libgts-bin libgts-dev \
    libkdtree++-dev libmedc-dev libocct-data-exchange-dev libocct-ocaf-dev libocct-visualization-dev libopencv-dev libproj-dev libpyside2-dev \
    libqt5opengl5-dev libqt5svg5-dev qtwebengine5-dev libqt5x11extras5-dev libqt5xmlpatterns5-dev libshiboken2-dev libspnav-dev libvtk7-dev \
    libx11-dev libxerces-c-dev libzipios++-dev occt-draw pyside2-tools python3-dev python3-matplotlib python3-packaging python3-pivy python3-ply \
    python3-pyside2.qtcore python3-pyside2.qtgui python3-pyside2.qtsvg python3-pyside2.qtwidgets python3-pyside2.qtnetwork python3-pyside2.qtwebengine \
    python3-pyside2.qtwebenginecore python3-pyside2.qtwebenginewidgets python3-pyside2.qtwebchannel python3-markdown python3-git \
    qtbase5-dev qttools5-dev swig \
    # - E: Unable to locate package python3-pyside2uic -- https://codeberg.org/FreeCAD/FreeCAD-documentation/src/branch/main/wiki/Compile_on_Linux.md 
    pyqt5-dev pyqt5-dev-tools && \
    pip install --upgrade gmsh && \
    cd /usr/bin/ && \
    ln -s pyrcc5 pyside2-rcc && \
    ln -s pyuic5 pyside2-uic && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 


# install AMDGPU drivers - system specific. Works in AMD 5800H laptop processor
RUN cd /tmp && \
	wget https://repo.radeon.com/amdgpu-install/22.20.5/ubuntu/jammy/amdgpu-install_22.20.50205-1_all.deb &&\
    dpkg -i amdgpu-install_22.20.50205-1_all.deb &&\
    amdgpu-install --usecase=graphics,opencl -y --accept-eula  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*  


#### ADD DEFAULT USER ####
# https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user

ARG USERNAME=glacier
ARG USER_HOME=/home/${USERNAME}
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME && \
    adduser $USERNAME sudo 

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.

RUN chown -R ${USERNAME}:${USERNAME} ${USER_HOME}

# give user acess to salome. enable if salome is needed
# RUN chown -R ${USER}:${USER} ${SALOME_HOME}

#### CREATE WORKING DIRECTORY FOR USER ####
#ARG WORKDIR=${USER_HOME}/Elmer
#ENV WORKDIR ${WORKDIR}
#RUN mkdir -p ${WORKDIR}
#RUN chown -R ${USER}:${USER} ${WORKDIR}

WORKDIR ${USER_HOME}
USER $USERNAME

# --------------------------------------------
## Post build Steps
# run ./runContainer.sh



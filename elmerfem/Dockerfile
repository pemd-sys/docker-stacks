# ElmerFEM Docker file
# Compiles elmerFEM from the latest git version
# gmsh, paraview also installed
# Note GMSH uses libocct for compile whereas ElmerFEM uses liboce

# !! ASSUMES SALOME INSTALLER (SALOME-9.9.0-native-UB22.04-SRC-22b4348cf247e9a72539dca3b6f2d65f.tar.gz)
# PRESENT IN THE SAME DIRECTORY AS THE DOCKERFILE
# Replace with different filename if needed 

# Tested on ThinkBook 16p G2 ACH Laptop
# Ryzen 7 5800H APU with Nvidia RTX 3060
# Thats why uses the nvidia container
# Also has the required ryzen - radeon drivers installed. Can use both

 
# Set the base image to the latest LTS version of Ubuntu
#FROM ubuntu:latest

FROM nvidia/cuda:12.0.0-runtime-ubuntu22.04


ARG GMSH_VERSION=4_11_0

# Set the working directory to /home
WORKDIR /home

# Create an apt configuration file to fix erroneous "hash sum mismatch" errors
RUN printf "Acquire::http::Pipeline-Depth 0;\nAcquire::http::No-Cache true;\nAcquire::BrokenProxy true;" \
	>> /etc/apt/apt.conf.d/99fixbadproxy

ENV DEBIAN_FRONTEND="noninteractive"

# Add the necessary packages to compile Elmer/Ice
RUN apt-get update -o Acquire::CompressionTypes::Order::=gz && apt-get upgrade -y && apt-get install -y \
	build-essential \
	cmake \
	git \
	libblas-dev \
	liblapack-dev \
	libmumps-dev \
	libparmetis-dev \
	libhypre-dev \
	mpich \
	sudo \
	less \
	unzip \
	zip \
	curl \
	wget \
	ca-certificates \
	ninja-build \
	pkg-config \
	python3-dev \
	python3-pip \
	python3-wheel \
	python3-setuptools \
	python3-venv


# install AMDGPU drivers - system specific. Works in AMD 5800H laptop processor
RUN cd /tmp && \
	wget https://repo.radeon.com/amdgpu-install/22.20.5/ubuntu/jammy/amdgpu-install_22.20.50205-1_all.deb &&\
    dpkg -i amdgpu-install_22.20.50205-1_all.deb &&\
    amdgpu-install --usecase=graphics,opencl -y --accept-eula


RUN apt-get install -y liboce-modeling-dev \
	liboce-foundation-dev \
	qtscript5-dev \
	libqt5script5 \
	libqt5widgets5 \
	libqt5core5a \
	libqt5gui5 \
	libqt5help5 \
	libqt5opengl5 \
	libqt5opengl5-dev \
	libqt5svg5-dev \
	libvtk7.1p \
	libvtk7-dev \
	libvtk7.1p-qt \
	libvtk7-qt-dev \
	libqwt-qt5-dev

RUN \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    apt-get -y install \
        build-essential cmake freeglut3-dev gdb git iputils-ping libgl1-mesa-dev \
        libglu1-mesa-dev libjpeg-dev libmysqlclient-dev libnss3-dev libopus-dev \
        libpng-dev libsqlite3-dev libssl-dev libx11-xcb-dev libxcb-xinerama0-dev \
        libxcb-xkb-dev libxcb1-dev libxcursor-dev libxi-dev libxml2-dev libxrender-dev \
        libxslt-dev lzip mesa-common-dev \
        '^libxcb.*-dev' libxkbcommon-dev libxkbcommon-x11-dev wget libwayland-dev && \
    apt-get -y install libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev \
        libxtst-dev libxss-dev libdbus-1-dev libevent-dev libfontconfig1-dev \
        libcap-dev libpulse-dev libudev-dev libpci-dev libnss3-dev libasound2-dev \
        libegl1-mesa-dev && \
    apt-get -y install libasound2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
        libgstreamer-plugins-good1.0-dev libgstreamer-plugins-bad1.0-dev 
        
RUN apt-get -y install libgif7 libxmu6 libxt6 libxxf86vm1 libgl1-mesa-dri libglx-mesa0 libglu1-mesa xsltproc

RUN apt-get -y install -y x11-apps

# gmsh needs opencascade
#RUN apt-get -y install \
#    libocct-foundation-dev \
#    libocct-data-exchange-dev \
#    libocct-visualization-dev \
#    libocct-modeling-algorithms-dev \
#    libocct-draw-dev \
#    libocct-ocaf-dev \
#    libocct-modeling-data-dev

# needed by Elmer - incompatible with libocct !!    
RUN apt-get -y install \
    liboce-foundation-dev \
    liboce-modeling-dev \
    liboce-ocaf-dev \
    liboce-ocaf-lite-dev \
    liboce-visualization-dev
    
# Install GMSH
# Cannot compile Gmsh with Elmer. Gmsh works with libocct whereas Elmer needs liboce. What a Mess !!

#RUN git clone -b gmsh_${GMSH_VERSION} --single-branch --depth 1 https://gitlab.onelab.info/gmsh/gmsh.git gmsh && \
#   cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DENABLE_BUILD_DYNAMIC=1  -DENABLE_OPENMP=1 -B build-dir -S gmsh && \
#   cmake --build build-dir && \
#   cmake --install build-dir && \
#   rm -R /home/gmsh

# GMSH installs python library in /usr/local/lib, see: https://gitlab.onelab.info/gmsh/gmsh/-/issues/1414
#ENV PYTHONPATH=/usr/local/lib:$PYTHONPATH

# Clone the ElmerIce source code and compile Elmer/Ice
RUN git clone https://github.com/ElmerCSC/elmerfem.git elmer \
        && mkdir elmer/builddir \
	&& cd elmer/builddir \
	&& cmake /home/elmer \
		-DCMAKE_INSTALL_PREFIX=/usr/local/Elmer-devel \
		-DCMAKE_C_COMPILER=/usr/bin/gcc \
		-DCMAKE_Fortran_COMPILER=/usr/bin/gfortran \
		-DWITH_MPI:BOOL=TRUE -DWITH_Mumps:BOOL=TRUE \
		-DWITH_Hypre:BOOL=TRUE -DHypre_INCLUDE_DIR=/usr/include/hypre \
		-DHypre_INCLUDE_DIR=/usr/include/hypre \
		-DWITH_Trilinos:BOOL=FALSE \
		-DWITH_ELMERGUI:BOOL=TRUE -DWITH_OCC:BOOL=TRUE \
		-DWITH_VTK:BOOL=FALSE \
		-DWITH_ElmerIce:BOOL=FALSE \
                -DWITH_LUA:BOOL=TRUE -DWITH_MATC:BOOL=TRUE \
                -DWITH_QT5:BOOL=TRUE -DQWT_LIBRARY=/usr/lib/libqwt-qt5.so.6 \
	&& make \
	&& make install \
	&& rm -R /home/elmer

# Set the path
ENV PATH=$PATH:/usr/local/Elmer-devel/bin
ENV PATH=$PATH:/usr/local/Elmer-devel/share/elmersolver/lib

RUN apt-get install -y gmsh vim mc sudo paraview

# Install Salome
# get dependencies by running 
# glacier@ElmerDocker:/tmp/SALOME-9.9.0-native-UB22.04-SRC$ python3 sat/sat config  SALOME-9.9.0-native --check_system

# Run-time dependencies
RUN apt-get install -y python3-distro
RUN apt-get install -y python3-babel python3-pytest-cython python3-jinja2 python3-pyqt5 python3-pygments \
					python3-sphinx python3-alabaster python3-certifi libcminpack1 python3-docutils fftw2 \
					graphviz python3-imagesize clang python3-markupsafe python3-nose python3-numpydoc \
					python3-pandas python3-psutil python3-requests libfftw3-double3 libncurses5 libffi7 \
					libopenblas0-serial python3-sip python3-stemmer python3-sphinx-rtd-theme \
					python3-sphinxcontrib.websupport sphinx-intl python3-statsmodels python3-urllib3

#Install compile time dependencies
RUN apt-get install -y pyqt5-dev pyqt5-dev-tools libboost-all-dev libcminpack-dev libcppunit-dev \
						doxygen fftw-dev libgraphviz-dev llvm-dev flex bison libxpm-dev libreadline-dev \
						libfftw3-dev libopenblas-dev libqt5x11extras5-dev qtxmlpatterns5-dev-tools libtiff5-dev \
						dvipng python3-sip-dev python3-statsmodels swig 

# copy salome installer
# ASSUMES SALOME INSTALLER (SALOME-9.9.0-native-UB22.04-SRC-22b4348cf247e9a72539dca3b6f2d65f.tar.gz)
# PRESENT IN THE SAME DIRECTORY AS THE DOCKERFILE
# Replace with different filename if needed 

ADD  SALOME-9.9.0-native-UB22.04-SRC-22b4348cf247e9a72539dca3b6f2d65f.tar.gz /opt/

ENV SALOME_HOME=/opt/SALOME-9.9.0-native-UB22.04-SRC/
ENV PATH=$PATH:$SALOME_HOME

# Check dependencies satisfied
RUN python3 ${SALOME_HOME}/sat/sat  config  SALOME-9.9.0-native --check_system

# may need tar xzfv SALOME-9.9.0-native-UB22.04-SRC-22b4348cf247e9a72539dca3b6f2d65f.tar.gz -C /opt/

# after installation run salome using: salome
#RUN cd /tmp && \
#	wget https://files.salome-platform.org/Salome/Salome9.9.0/SALOME-9.9.0-native-UB22.04-SRC-22b4348cf247e9a72539dca3b6f2d65f.tar.gz && \

# Install Wine for FEMM
RUN dpkg --add-architecture i386 && \
	mkdir -pm755 /etc/apt/keyrings && \
	wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key && \
	wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources &&\
	apt-get update && \
	apt-get install -y --install-recommends winehq-stable



#### ADD DEFAULT USER ####
ARG USER=glacier
ENV USER ${USER}
ENV USER_HOME /home/${USER}


RUN adduser --disabled-password --gecos '' ${USER} \
	&& adduser ${USER} sudo \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN chown -R ${USER}:${USER} ${USER_HOME}

# give user acess to salome
RUN chown -R ${USER}:${USER} ${SALOME_HOME}

#### CREATE WORKING DIRECTORY FOR USER ####
#ARG WORKDIR=${USER_HOME}/Elmer
#ENV WORKDIR ${WORKDIR}
#RUN mkdir -p ${WORKDIR}
#RUN chown -R ${USER}:${USER} ${WORKDIR}

WORKDIR ${USER_HOME}
USER ${USER}

# --------------------------------------------
## Post build Steps
# run ./runContainer.sh

# create venv for python for default user glacier
# cd ${USER_HOME} && python3 -m venv spyder-env 
# source /spyder-env/bin/activate
# pip install spyder numpy scipy pandas matplotlib sympy cython gmsh pyyaml pyelmer
# wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && chmod +x winetricks
# wget -O femm_installer.exe 'https://www.femm.info/wiki/Files/files.xml?action=download&file=femm42bin_x64_21Apr2019.exe' 
# wine femm_installer.exe
# wine ~/.wine/drive_c/femm42/bin/femm.exe 
# git clone https://github.com/ElmerCSC/elmer-elmag.git
# cd elmer-elmag/InductionMachine2D/IM_one_pole_multislice/
# ./run.sh
# paraview

# -------------------------------------------


# activate venv for python
#RUN cd ${USER_HOME} && python3 -m venv spyder-env 
#ENV VIRTUAL_ENV=${USER_HOME}/spyder-env
#RUN $VIRTUAL_ENV/bin/pip install spyder numpy scipy pandas matplotlib sympy cython \
#	gmsh pyyaml pyelmer
	

#install winetricks
#RUN wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks &&\
#	chmod +x winetricks

# Wine c drive path 
#ENV PATH=$PATH:$USER_HOME/.wine/drive_c



# Add user
#ENV USER=glacier
#RUN adduser --disabled-password --gecos '' ${USER} \
#	&& adduser ${USER} sudo \
#	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
#USER ${USER}
#ENV HOME=/home/${USER}
#WORKDIR ${HOME}

# xhost +"local:docker@"
# docker run        -it   -e DISPLAY=$DISPLAY   --device=/dev/dri         -v /tmp/.X11-unix:/tmp/.X11-unix:rw            -v $(pwd)/project:/project            --rm elmer:latest

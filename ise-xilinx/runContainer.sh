#!/bin/bash

USER=glacier
ISEHOMEDIR=/home/glacier
ISEHOSTHOMEDIR=/home/matrix/Work/11_ise_workspace

docker run -it --rm --user glacier --hostname=IseDocker \
	   -v /tmp/.X11-unix:/tmp/.X11-unix \
           -e DISPLAY=$DISPLAY \
           -h $HOSTNAME \
           -v $HOME/.Xauthority:/home/$USER/.Xauthority \
	   -v $ISEHOSTHOMEDIR:$ISEHOMEDIR \
           ise-xilinx
           


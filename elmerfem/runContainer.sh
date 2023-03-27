#!/bin/bash

# assumes user name in docker is glacier, used in the paths


xhost +"local:docker@"
CONTAINER_NAME=ElmerContainer
    
#ELMERWORKDIR=/home/glacier/Elmer
#ELMERHOSTWORKDIR=/home/matrix/Work/06_Elmer/Elmer

#ELMERCACHEDIR=/home/glacier/.cache
#ELMERHOSTCACHEDIR=/home/matrix/Work/06_Elmer/.cache

#ELMERCONFIGDIR=/home/glacier/.config
#ELMERHOSTCONFIGDIR=/home/matrix/Work/06_Elmer/.config

#docker run \
#	--runtime=nvidia -it --rm --user glacier --hostname=ElmerDocker \
#	--ulimit memlock=-1:-1 --ulimit stack=1073741824:1073741824 \
#	--shm-size=2g \
#	--device=/dev/dri:/dev/dri --env="DISPLAY=$DISPLAY" \
#	--env="XAUTHORITY=$XAUTHORITY" --env="XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" \
#   -e __NV_PRIME_RENDER_OFFLOAD=1 -e __GLX_VENDOR_LIBRARY_NAME=nvidia \
#    -e NVIDIA_DRIVER_CAPABILITIES=all -e NVIDIA_VISIBLE_DEVICES=all \
#	--volume="/tmp/.X11-unix/:/tmp/.X11-unix/:rw" -v $XAUTHORITY:$XAUTHORITY \
#	-v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
#	-v $ELMERHOSTDIR:$ELMERDIR -v $ELMERHOSTCACHEDIR:$ELMERCACHEDIR \
#	-v $ELMERHOSTCONFIGDIR:$ELMERCONFIGDIR \
#	-v $ELMERHOSTWORKDIR:$ELMERWORKDIR \
#	--workdir $ELMERWORKDIR --name $CONTAINER_NAME elmer-nvidia:latest


ELMERHOMEDIR=/home/glacier
ELMERHOSTHOMEDIR=/home/matrix/Work/06_Elmer_workspace

docker run \
	--runtime=nvidia -it --rm --user glacier --hostname=ElmerDocker \
	--ulimit memlock=-1:-1 --ulimit stack=1073741824:1073741824 \
	--ipc="host" --cap-drop=ALL --security-opt=no-new-privileges \
	--shm-size=2g \
	--device=/dev/dri:/dev/dri --env="DISPLAY=$DISPLAY" \
	--env="XAUTHORITY=$XAUTHORITY" --env="XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" \
    -e __NV_PRIME_RENDER_OFFLOAD=1 -e __GLX_VENDOR_LIBRARY_NAME=nvidia \
    -e NVIDIA_DRIVER_CAPABILITIES=all -e NVIDIA_VISIBLE_DEVICES=all \
	--volume="/tmp/.X11-unix/:/tmp/.X11-unix/:rw" -v $XAUTHORITY:$XAUTHORITY \
	-v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
	-v $ELMERHOSTHOMEDIR:$ELMERHOMEDIR \
	--name $CONTAINER_NAME elmer-nvidia:latest

# https://towardsdatascience.com/how-to-run-jupyter-notebook-on-docker-7c9748ed209f#b42d
#https://stackoverflow.com/questions/38830610/access-jupyter-notebook-running-on-docker-container

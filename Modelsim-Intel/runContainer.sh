#!/bin/bash

# assumes user name in docker is glacier, used in the paths


xhost +"local:docker@"
CONTAINER_NAME=ModelsimContainer

# create fake network
docker network rm no-internet
docker network create --internal --subnet 99.1.1.0/8 no-internet

    
ELMERHOMEDIR=/home/glacier
ELMERHOSTHOMEDIR=/home/matrix/Work/10_Modelsim_workspace

docker run \
	 -it --rm --user glacier --hostname=ModelsimDocker \
	--ulimit memlock=-1:-1 --ulimit stack=1073741824:1073741824 \
	--ipc="host" --cap-drop=ALL --security-opt=no-new-privileges \
	--shm-size=2g \
	--device=/dev/dri:/dev/dri --env="DISPLAY=$DISPLAY" \
	--env="XAUTHORITY=$XAUTHORITY" --env="XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" \
	--volume="/tmp/.X11-unix/:/tmp/.X11-unix/:rw" -v $XAUTHORITY:$XAUTHORITY \
	-v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
	-v $ELMERHOSTHOMEDIR:$ELMERHOMEDIR \
	--name $CONTAINER_NAME modelsim-intel:latest



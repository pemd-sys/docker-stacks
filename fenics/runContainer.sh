#!/bin/bash

# assumes user name in docker is glacier, used in the paths


xhost +"local:docker@"
CONTAINER_NAME=FenicsContainer
    
FENICSHOMEDIR=/home/glacier
FENICSHOSTHOMEDIR=/home/matrix/Work/12_fenics_workspace

docker run \
	-it --rm --user glacier --hostname=FenicsDocker \
	-p 8888:8888 \
	--ulimit memlock=-1:-1 --ulimit stack=1073741824:1073741824 \
	--ipc="host" --cap-drop=ALL --security-opt=no-new-privileges \
	--shm-size=2g \
	--device=/dev/dri:/dev/dri --env="DISPLAY=$DISPLAY" \
	--device=/dev/kfd \
	--group-add video \
	--env="XAUTHORITY=$XAUTHORITY" --env="XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" \
	--volume="/tmp/.X11-unix/:/tmp/.X11-unix/:rw" -v $XAUTHORITY:$XAUTHORITY \
	-v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
	-v $FENICSHOSTHOMEDIR:$FENICSHOMEDIR \
	--name $CONTAINER_NAME fenics:latest



#!/bin/bash

# assumes user name in docker is glacier, used in the paths


xhost +"local:docker@"
CONTAINER_NAME=FreecadContainer
    

FREECADHOMEDIR=/home/glacier
FREECADHOSTHOMEDIR=/home/matrix/Work/16_freecad_workspace

docker run \
	--runtime=nvidia -it --rm --user glacier --hostname=FreecadDocker \
	--ulimit memlock=-1:-1 --ulimit stack=1073741824:1073741824 \
	--ipc="host" --cap-drop=ALL --security-opt=no-new-privileges \
	--shm-size=2g \
	--device=/dev/dri:/dev/dri --env="DISPLAY=$DISPLAY" \
	--env="XAUTHORITY=$XAUTHORITY" --env="XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" \
    -e __NV_PRIME_RENDER_OFFLOAD=1 -e __GLX_VENDOR_LIBRARY_NAME=nvidia \
    -e NVIDIA_DRIVER_CAPABILITIES=all -e NVIDIA_VISIBLE_DEVICES=all \
	--volume="/tmp/.X11-unix/:/tmp/.X11-unix/:rw" -v $XAUTHORITY:$XAUTHORITY \
	-v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
	-v $FREECADHOSTHOMEDIR:$FREECADHOMEDIR \
	--name $CONTAINER_NAME freecad-nvidia:exptt

# post install
# git clone https://github.com/FreeCAD/FreeCAD.git freecad-source
# mkdir freecad-build
# cd freecad-build
# cmake ../freecad-source
# make -j$(nproc --ignore=2)

# binaries after successful compile is in freecad-build/bin

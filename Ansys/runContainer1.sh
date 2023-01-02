#!/bin/bash

# assumes user name in docker is glacier, used in the paths

ARGS=$@

export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia

xhost +"local:docker@"

CONTAINER_NAME=AnsysContainer

docker container inspect -f '{{.State.Status}}' $CONTAINER_NAME > /dev/null 2>&1

if [ "$?" = "0" ]; then
    docker exec -it $CONTAINER_NAME bash -c ". ~/.bashrc ; $ARGS"
else
    
#    ANSYSWORKDIR=/home/glacier/Ansys
#    ANSYSHOSTWORKDIR=/home/matrix/Work/03_Ansys/Ansys
    
#    ANSYSDIR=/home/glacier/.ansys
#    ANSYSHOSTDIR=/home/matrix/Work/03_Ansys/.ansys

#    ANSYSCACHEDIR=/home/glacier/.cache
#    ANSYSHOSTCACHEDIR=/home/matrix/Work/03_Ansys/.cache

#    ANSYSCONFIGDIR=/home/glacier/.config
#    ANSYSHOSTCONFIGDIR=/home/matrix/Work/03_Ansys/.config

#    ANSYSMWDIR=/home/glacier/.mw
#    ANSYSHOSTMWDIR=/home/matrix/Work/03_Ansys/.mw

#    ANSYSNVDIR=/home/glacier/.nv
#    ANSYSHOSTNVDIR=/home/matrix/Work/03_Ansys/.nv

#    ANSYSEMDIR=/home/glacier/Ansoft
#    ANSYSHOSTEMDIR=/home/matrix/Work/03_Ansys/Ansoft

#    INSTALLSHIELDDIR=/home/glacier/Installshield
#    INSTALLSHIELDHOSTDIR=/home/matrix/Work/03_Ansys/Installshield

#    FLUENTCONFIGDIR=/home/glacier/.fluentconf
#    FLUENTHOSTCONFIGDIR=/home/matrix/Work/03_Ansys/.fluentconf

    ANSYSHOMEDIR=/home/glacier
    ANSYSHOSTHOMEDIR=/home/matrix/Work/07_Ansys_workspace


    docker run \
        --runtime=nvidia -it --user glacier --rm --hostname=AnsysDocker \
        --ulimit memlock=-1:-1 --ulimit stack=1073741824:1073741824 \
        --shm-size=2g \
        --device=/dev/dri:/dev/dri --env="DISPLAY=$DISPLAY" \
        --env="XAUTHORITY=$XAUTHORITY" --env="XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" \
        -e __NV_PRIME_RENDER_OFFLOAD=1 -e __GLX_VENDOR_LIBRARY_NAME=nvidia \
        -e NVIDIA_DRIVER_CAPABILITIES=all -e NVIDIA_VISIBLE_DEVICES=all \
        -e QT_ACCESSIBILITY=1 \
        --volume="/tmp/.X11-unix/:/tmp/.X11-unix/:rw" -v $XAUTHORITY:$XAUTHORITY \
        -v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
		-v $ANSYSHOSTHOMEDIR:$ANSYSHOMEDIR \
		--name $CONTAINER_NAME ansys-nvidia:base


fi

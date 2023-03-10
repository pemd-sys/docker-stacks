#!/bin/bash

# assumes user name in docker is glacier, used in the paths
# docker network create --internal --subnet 99.1.1.0/24 no-internet

ARGS=$@

xhost +"local:docker@"


# create fake network
docker network rm no-internet
docker network create --internal --subnet 99.1.1.0/8 no-internet

CONTAINER_NAME=MatlabContainer

docker container inspect -f '{{.State.Status}}' $CONTAINER_NAME > /dev/null 2>&1

if [ "$?" = "0" ]; then
    docker exec -it $CONTAINER_NAME bash -c ". ~/.bashrc ; $ARGS"
else
    
    MATLABHOMEDIR=/home/glacier
    MATLABHOSTHOMEDIR=/home/matrix/Work/08_Matlab_workspace

    tar -zcvf $MATLABHOSTHOMEDIR/Sims-archive.tar.gz $MATLABHOSTHOMEDIR/Sims
    docker run \
        -it --user glacier --rm --hostname=MatlabDocker \
		--network no-internet \
        --ulimit memlock=-1:-1 --ulimit stack=1073741824:1073741824 \
        --shm-size=2g \
        --device=/dev/dri:/dev/dri --env="DISPLAY=$DISPLAY" \
		--device=/dev/kfd \
		--group-add video \
        --env="XAUTHORITY=$XAUTHORITY" --env="XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" \
        -e QT_ACCESSIBILITY=1 \
        --volume="/tmp/.X11-unix/:/tmp/.X11-unix/:rw" -v $XAUTHORITY:$XAUTHORITY \
        -v $XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR \
		-v $MATLABHOSTHOMEDIR:$MATLABHOMEDIR \
		--name $CONTAINER_NAME matlab-amd:base 
#		-v /media/matrix/MATHWORKS_R2022B:/tmp/Matlab_R2022b_installer \
#		-v /media/matrix/Matlab913_Update2Lin:/tmp/Matlab_R2022b_installer_update \


fi


## some notes
# crete fake network
# docker network create --internal --subnet 99.1.1.0/24 no-internet

# clean images and container only
# docker image prune
# docker container prune

# if matlab says cannot load canbrra-gtk-module
# https://uk.mathworks.com/matlabcentral/answers/472134-gtk-message-10-32-31-466-failed-to-load-module-canberra-gtk-module
# add to .bashrc file the follwoing
# export GTK_PATH=/usr/lib/x86_64-linux-gnu/gtk-2.0
# export LIBOVERLAY_SCROLLBAR=0
# export GIO_EXTRA_MODULES=/usr/lib/x86_64-linux-gnu/gio/modules

# https://uk.mathworks.com/matlabcentral/answers/241850-matlab-failing-to-find-hardware-opengl
# if you get matlab is using software opengl 
# run the following inside the container

# sudo dpkg --add-architecture i386
# sudo apt-get update
# sudo apt-get install lib64stdc++6:i386

# cd <your_matlab_location>/sys/os/glnxa64/
# if libstdc++.so.6 exists then do following line or else skip to the next line
# sudo mv libstdc++.so.6 libstdc++.so.6.bak
# sudo ln -s /usr/lib64/libstdc++.so.6  libstdc++.so.6
    
# Run Matlab and the software opengl error should not appear
# run in matlab command window
# >> opengl info
# it should show the AMD renoir opengl driver.

## create symbolic link (ln -s)
# create a matalb shortcuts directory
# /opt/MATLAB/R2022b/bin/matlab
# /opt/MATLAB/R2022b/bin/deploytool
# /opt/MATLAB/R2022b/bin/mbuild
# /opt/MATLAB/R2022b/bin/mcc
# /opt/MATLAB/R2022b/bin/mex


# R2022b below update 4 - linux
# Simulink has problem saving to the shared host directory 
# https://uk.mathworks.com/matlabcentral/answers/1798895-invalid-cross-device-link-18-when-saving-a-file-on-arch-linux?s_tid=prof_contriblnk
# so as a workaround copy the runMatlab.sh into the matlab host share directory ($MATLABHOSTHOMEDIR)
# and run the script instead (uses rsync to copy from and copy back to the host directory before and after launching and closing matlab)
# Do all work and saving in the tmp/Sims directory. Simulink has no problem saving in the tmp folder.



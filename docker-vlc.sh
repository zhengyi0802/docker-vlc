#!/bin/bash

echo "checkout image if loaded in docker"
 result=`docker images|grep vlc-bionic`
if [ -z "$result" ]; then
   echo "load image from harddisk"
   sudo docker load --input /work/docker/images/vlc-bionic.tar
fi

echo "grant priviledge to docker"
setfacl -m user:1000:r ${HOME}/.Xauthority

echo "run docker"
docker run -it --rm \
    -v $HOME:/home/puser \
    -v /dev/snd:/dev/snd --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /run/user/1000:/run/user/1000 \
    -v $HOME/.config/pulse/native:$HOME/.config/pulse/native:ro \
    -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native:\
    -e XAUTHORITY=$XAUTHORITY \
    -e DISPLAY=unix$DISPLAY \
    -e uid=1000 \
    -e gid=1000 \
    --name vlc \
    chevylin0802/vlc-bionic \
    /usr/bin/vlc


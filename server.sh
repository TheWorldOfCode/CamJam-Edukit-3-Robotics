#!/bin/bash

sudo pigpiod
bash ./adhoc/adhoc.sh -i wlan0 -p 192.168.99.3/24
socat tcp-listen:8080,reuseaddr,fork exec:'bash tcp/tcp_commands.sh -s && echo done' &

rm ./aske
touch ./aske

bash /home/pi/CamJam-Edukit-3-Robotics/ultra_sound/getDist.sh &


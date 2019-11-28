#!/bin/bash

bash ./adhoc/adhoc.sh -i wlan0 -p 192.168.99.3/24
socat tcp-listen:8080,reuseaddr,fork exec:'bash tcp/tcp_commands.sh' &

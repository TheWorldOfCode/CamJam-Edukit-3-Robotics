#!/bin/bash

SSID=pibot
frequency=2412
connect=1

while getopts "cds:i:p:f:hm" option; do

	case "${option}" in
		c)
			connect=1
			;;
		d) 
			disconnect=1
			;;
		s) 
			SSID=$OPTARG
			;;
		l)
			interface=$OPTARG
			;;
		f)
			frequency=$OPTARG
			;;
		p)
			ip=$OPTARG
		h)
			help=1
			;;
		m)
			manager=1
			;;
		*)
			;;
	esac
done

if [ "$#" -eq 0 ]; then
	echo "No argument, do it right or don't do it at all" > /dev/stderr
	error 1
fi

if [ "x$help" != "x" ]; then
	echo "This is the help screen of motor control              "
	echo "                                                      "
	echo "Options:                                              "
	echo "         -c          Connect to network [defualt]     "
	echo "         -d          Disconnect network               "
	echo "         -s          Network SSID [defualt: pibot]    "
	echo "         -l          Network Interface                "
	echo "         -f          Wifi frequency [defualt: 2412]   "
	echo "         -p          Ip address                       "
	echo "         -m          Have network-manager installed   "
	echo "                     Stop network-manager when connecting and starting when disconnecting  "
	echo "         -h          This help screen                 "
	echo ""
	echo ""
	echo "Error codes: "
	echo "          1 No arguments  "
	echo "          2 No Ip address " 
	echo "          3 No interface  "

else

	if [ "x$connect" != "x" ]; then
		if [ "x$manager" != "x" ]; then

			sudo systemctl network-manager stop
		fi

		if [ "x$ip" == "x" ]; then
			echo "Not ip address" > /dev/stderr
			error 2
		fi

		if [ "x$interface" == "x" ]; then
			ehco "No interface address" > /dev/stderr
			error 3
		fi
		sudo iw ${interface} set type ibss
		sudo ip link set ${interface} up
		sudo iw ${interface}ibss join ${SSID} ${frequency}
		sudo ip addr add ${ip} dev ${interface}
	fi

	if [ "x$disconnect" != "x" ]; then
		if [ "x$manager" != "x" ]; then

			sudo systemctl network-manager start
		fi

	fi

fi

exit 0

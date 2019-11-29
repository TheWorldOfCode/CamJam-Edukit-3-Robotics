#! /bin/bash

while getopts "hs" option; do

	case "${option}" in
		h)
			help=1
			;;
		s) 
			s=1
			;;
		*)
			;;
	esac
done

if [ "x$help" != "x" ]
then
        echo "This is the awesome help screen, showing the supported arguments       "
	echo "**********************************************************************"
	echo "getdist :returns the last distance value from the distance sensor     "
	echo "getmotors :returns the current control values from the distance sensor"
	echo "start :starts the wall following behavior                             "
	echo "stop :stop the robot                                                  " 
fi

if [ -t 1 ]; then
     read c
elif [ "x$s" != "x" ]; then
     read c
else
     c=$1
	if [ "$#" = 0 ]
	then
		#Script exits if no arguments passed
		echo "No arguments passed, please behave yourself and/or try the -h option for help." > /dev/stderr
		exit 1
	fi
fi

#Initialize command with the first argument

if [ $c = getdist ]
then
	echo "# get distance"
	tail -n1 aske
fi

if [ $c = getmotors ]
then
	echo "# get motor values"
	echo "$(bash /home/pi/CamJam-Edukit-3-Robotics/motor_control/motor_control.sh  -g l) $(bash /home/pi/CamJam-Edukit-3-Robotics/motor_control/motor_control.sh  -g r)"
fi

if [ $c = start ]
then
	 echo "# start wall following behavior"
	$(python3 /home/pi/CamJam-Edukit-3-Robotics/ultra_sound/interface_ultrasound.py) 
fi

if [ $c = stop ]
then
	echo "# stop robot"
	$(bash /home/pi/CamJam-Edukit-3-Robotics/motor_control/motor_control.sh  -s 0)
        killall python3
fi

exit 0

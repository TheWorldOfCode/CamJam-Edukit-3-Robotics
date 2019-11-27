#! /bin/bash

while getopts "h" option; do

	case "${option}" in
		h)
			help=1
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

if [ "$#" = 0 ]
then
	#Script exits if no arguments passed
	echo "No arguments passed, please behave yourself and/or try the -h option for help." > /dev/stderr
	exit 1
fi

#Initialize command with the first argument

if [ $1 = getdist ]
then
	result=$(python3 ../ultra_sound/getDist.py)
fi

if [ $1 = getmotors ]
then
	result="$(bash ../motor_control/motor_control.sh  -g l) $(bash ../motor_control/motor_control.sh  -g r)"
fi

if [ $1 = start ]
then
echo "# start wall following behavior"
fi

if [ $1 = stop ]
then
echo "# stop robot"
fi
echo $result
exit 0

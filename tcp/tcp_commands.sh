#! /bin/bash

while getops "h" option; do

	case"{option}" in
		h)
			help=1
			;;
		*)
			;;
	esac
done

if ["x$help" != "x"]
then
        echo "This is the awesome helpscreen, showing the supported arguments       "
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
command=$1

if [command = getdist]
#return the last distance value from the distance sensor
fi

if [command = getmotors]
#return the current control values used on the motors
fi

if [command = start]
# start wall following behavior
fi

if [command = stop]
# stop robot
fi

exit 0

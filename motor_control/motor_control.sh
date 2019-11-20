#! /bin/bash

# Options:
# 	s set the same value on both motor
#	l set the speed for the left wheel
#       r set the speed for the right wheel
#       q set the speed to zero
#       g get the speed on wheel specific by the option
#       h help

rightForward_GPIO=10
rightBackward_GPIO=9
leftForward_GPIO=8
leftBackward_GPIO=7
pwmfrequency=100


while getopts "s:l:r:qg:h" option; do
	
	case "${option}" in 
		s)
			same=$OPTARG
			;;
		l)
			left=$OPTARG
			;;
		r)
			right=$OPTARG
			;;
		q)
			stop=1
			;;
		g)
			get=$OPTARG
			;;
		h)
			help=1
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
	echo "         -s [speed]  Set the same speed on both motors"
	echo "         -l [speed]  Set the speed on the left motor  "
	echo "         -r [speed]  Set the speed on the right motor "
	echo "         -q          Stop both motors                 "
	echo "         -g [l/r]    Get the speed from motor         "
	echo "         -h          This help screen                 "
elif [ "x$same" != "x" ]; then 

	if [ $same < 0 ]; then	
		pigs hp $leftBackward_GPIO $pwmfrequency $(($same * -1)) 
		pigs hp $rightBackward_GPIO $pwmfrequency $(($same * -1)) 
		pigs hp $rightForward_GPIO $pwmfrequency 0
		pigs hp $leftForward_GPIO $pwmfrequency 0
	elif [ $same > 0 ]; then
		pigs hp $leftBackward_GPIO $pwmfrequency 0
		pigs hp $rightBackward_GPIO $pwmfrequency 0
		pigs hp $leftForward_GPIO $pwmfrequency $same
		pigs hp $rightForward_GPIO $pwmfrequency $same
	else
		pigs hp $leftBackward_GPIO $pwmfrequency 0
		pigs hp $leftForward_GPIO $pwmfrequency 0
		pigs hp $rightBackward_GPIO $pwmfrequency 0
		pigs hp $rightForward_GPIO $pwmfrequency 0
	fi

else 
	if [ "x$left" != "x" ]; then
		if [ $left < 0 ]; then	
			pigs hp $leftBackward_GPIO $pwmfrequency $(($left * -1)) 
			pigs hp $leftForward_GPIO $pwmfrequency 0
		elif [ $left > 0 ]; then
			pigs hp $leftBackward_GPIO $pwmfrequency 0
			pigs hp $leftForward_GPIO $pwmfrequency $left
		else
			pigs hp $leftBackward_GPIO $pwmfrequency 0
			pigs hp $leftForward_GPIO $pwmfrequency 0
		fi
	fi

	if [ "x$right" != "x" ]; then
		if [ $right < 0 ]; then	
			pigs hp $rightBackward_GPIO $pwmfrequency $(($right * -1)) 
			pigs hp $rightForward_GPIO $pwmfrequency 0
		elif [ $left > 0 ]; then
			pigs hp $rightBackward_GPIO $pwmfrequency 0
			pigs hp $rightForward_GPIO $pwmfrequency $right
		else
			pigs hp $leftBackward_GPIO $pwmfrequency 0
			pigs hp $leftForward_GPIO $pwmfrequency 0
			pigs hp $rightBackward_GPIO $pwmfrequency 0
			pigs hp $rightForward_GPIO $pwmfrequency 0
		fi
	fi


	if [ "x$get" != "x" ]; then

		if [ "$get" = "r" ]; then
			b=$((pigs prg $rightBackward_GPIO))
			f=$((pigs prg $rightForward_GPIO))

			if [ $f -eq 0 ]; then
				echo $b
			else
				echo $f
			fi

		elif [ $get = "l" ]; then
			b=$((pigs prg $lefttBackward_GPIO))
			f=$((pigs prg $rightforward_GPIO))

			if [ $f -eq 0 ]; then
				echo $b
			else
				echo $f
			fi

		fi

	fi


	if [ "x$stop" != "x" ]; then
		pigs hp $leftBackward_GPIO $pwmfrequency 0
		pigs hp $leftForward_GPIO $pwmfrequency 0
		pigs hp $rightBackward_GPIO $pwmfrequency 0
		pigs hp $rightForward_GPIO $pwmfrequency 0
	fi
fi

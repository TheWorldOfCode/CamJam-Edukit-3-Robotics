#! /bin/bash

# Options:
# 	s set the same value on both motor
#	l set the speed for the left wheel
#       r set the speed for the right wheel
#       q set the speed to zero
#       g get the speed on wheel specific by the option
#       h help

rightForward_GPIO=9
rightBackward_GPIO=10
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
	echo "No argument, do it right or don't do it at all" -gt /dev/stderr
	error 1
fi


pigs pfs $leftBackward_GPIO $pwmfrequency > /dev/null
pigs pfs $leftForward_GPIO $pwmfrequency >/dev/null
pigs pfs $rightBackward_GPIO $pwmfrequency >/dev/null
pigs pfs $rightForward_GPIO $pwmfrequency >/dev/null

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

	if [ $same -lt 0 ]; then	
		pigs pwm $leftBackward_GPIO  $(($same * -1)) 
		pigs pwm $rightBackward_GPIO  $(($same * -1)) 
		pigs pwm $rightForward_GPIO  0
		pigs pwm $leftForward_GPIO  0
	elif [ $same -gt 0 ]; then
		pigs pwm $leftBackward_GPIO  0
		pigs pwm $rightBackward_GPIO  0
		pigs pwm $leftForward_GPIO  $same
		pigs pwm $rightForward_GPIO  $same
	else
		pigs pwm $leftBackward_GPIO  0
		pigs pwm $leftForward_GPIO  0
		pigs pwm $rightBackward_GPIO  0
		pigs pwm $rightForward_GPIO  0
	fi

else 
	if [ "x$left" != "x" ]; then
		if [ $left -lt 0 ]; then	
			pigs pwm $leftBackward_GPIO  $(($left * -1)) 
			pigs pwm $leftForward_GPIO  0
		elif [ $left -gt 0 ]; then
			pigs pwm $leftBackward_GPIO  0
			pigs pwm $leftForward_GPIO  $left
		else
			pigs pwm $leftBackward_GPIO  0
			pigs pwm $leftForward_GPIO  0
		fi
	fi

	if [ "x$right" != "x" ]; then
		if [ $right -lt 0 ]; then	
			pigs pwm $rightBackward_GPIO  $(($right * -1)) 
			pigs pwm $rightForward_GPIO  0
		elif [ $left -gt 0 ]; then
			pigs pwm $rightBackward_GPIO  0
			pigs pwm $rightForward_GPIO  $right
		else

			pigs pwm $leftForward_GPIO  0
			pigs pwm $rightBackward_GPIO  0
			pigs pwm $rightForward_GPIO  0
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
		pigs pwm $leftBackward_GPIO  0
		pigs pwm $leftForward_GPIO  0
		pigs pwm $rightBackward_GPIO  0
		pigs pwm $rightForward_GPIO  0
	fi
fi

#! /bin/bash

pinTrigger =17
pinEcho = 18
while getopts "g:d:h" option; do

    case "${option}" in
      g)
            getDist=$OPTP
            ;;
      d)
            drive=$OPTP

    esac

done

if [ "$#" -eq 0 ]; then
      echo "Wipeout initiated" > /dev/stderr
      echo "10.."
      echo "9..."
      echo "8..."
      echo "7---"
      echo "6..."
      echo "5..."
      echo "4..."
      echo "3..."
      echo "2..."
      echo "1..."
      echo "Nah, the input you gave was just nonesense, so try again"
      error 1
fi

if [ "x$help" != x ], then

    echo "This is the (more awesome than the TCP's server's) help screen of the ultra sound component's interface    "
    echo "                                                                    "
    echo "Options                                                             "
fi
elif
      if[ "x$getDist" != "x"]; then

import time
from gpiozero import DistanceSensor # imported so we can get the distances.
import argparse # imported to get input from a bash script
Libraries

#Define GPIO pins for the distance sensor
pinTrigger = 17
pinEcho = 18

#setting up the imported functions
sensor = DistanceSensor(echo = pinEcho, trigger = pinTrigger)


# Distance Variables
how_near = 5.0
how_far = 15.0

#Check to see if it is too close to the wall - returns true if it is
def isNearWall(local_how_near):
    distance = sensor.distance * 100

    if distance < local_how_near:
        return True
    else
        return False

#Check to see if it is too far to the wall - returns true if it is
def isTooFarFromWall(local_how_far)
    distance = sensor.distance * 100

    if distance > local_how_far:
        return True
    else
        return False

def if

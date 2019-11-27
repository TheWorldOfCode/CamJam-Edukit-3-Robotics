import time
from gpiozero import DistanceSensor # imported so we can get the distances.
import os
import sys
Libraries

#Define GPIO pins for the distance sensor
pinTrigger = 17
pinEcho = 18

#setting up the imported functions
sensor = DistanceSensor(echo = pinEcho, trigger = pinTrigger)

bash_variable_list = getopt.getopt(sys.argv)

# Distance Variables
how_near = bash_variable_list[0]
how_far = bash_variable_list[1]
good_distance = bash_variable_list[2]


#Check to see if it is too close to the wall - returns true if it is
def isNearWall(local_how_near):
    distance = sensor.distance * 100

    if distance < local_how_near:
        return True
    else:
        return False

#Check to see if it is too far to the wall - returns true if it is
def isTooFarFromWall(local_how_far):
    distance = sensor.distance * 100

    if distance > local_how_far:
        return True
    else:
        return False
def isItGood(local_good_dist):
    distance = sensor.distance * 100

    if distance == local_good_dist:
        return True
    else:
        return False

while True:
    if isNearWall(how_near):
        system("./motor_control motor_control.sh -l 20")
        time.sleep(0.1)
        system("./motor_control motor_control.sh -s 20")
        while isItGood(good_distance) is not True:
            pass
        system("./motor_control motor_control.sh -h 20")
        time.sleep(0.1)
        system("./motor_control motor_control.sh -s 20")
    if isTooFarFromWall(local_how_far):
        system("./motor_control motor_control.sh -h 20")
        time.sleep(0.1)
        system("./motor_control motor_control.sh -s 20")
        while isItGood(good_distance) is not True:
            pass
        system("./motor_control motor_control.sh -l 20")
        time.sleep(0.1)
        system("./motor_control motor_control.sh -s 20")

import time
from gpiozero import DistanceSensor # imported so we can get the distances.
from os import system
import sys

#Define GPIO pins for the distance sensor
pinTrigger = 17
pinEcho = 18

#setting up the imported functions
sensor = DistanceSensor(echo = pinEcho, trigger = pinTrigger)

#bash_variable_list = getopt.getopt(sys.argv)

# Distance Variables
how_near = 10 #bash_variable_list[0]
how_far = 20 #bash_variable_list[1]
good_distance = 15 # bash_variable_list[2]


#Check to see if it is too close to the wall - returns true if it is
def isNearWall(local_how_near):
    distance = sensor.distance * 100
#    print(distance)
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
#    print(distance)
    if distance > local_good_dist - 3 and distance < local_good_dist + 3:
        return True
    else:
        return False

while True:
    if isNearWall(how_near):
 #       print("The Wall is to Near")
        system("bash ../motor_control/motor_control.sh -l 80 -r 0")
        time.sleep(1)
        system("bash ../motor_control/motor_control.sh -s 80")
        while isItGood(good_distance) is not True:
            pass
  #      print("Correcting") 
        system("bash ../motor_control/motor_control.sh -r 80 -l 0")
        time.sleep(1)
        system("bash ../motor_control/motor_control.sh -s 80")
    if isTooFarFromWall(how_far):
   #     print("The Wall is to far")
        system("bash ../motor_control/motor_control.sh -r 80 -l 0")
        time.sleep(1)
        system("bash ../motor_control/motor_control.sh -s 80")
        while isItGood(good_distance) is not True:
            pass
        system("bash ../motor_control/motor_control.sh -l 80 -r 0")
        time.sleep(1)
        system("bash ../motor_control/motor_control.sh -s 80")
    system("bash ../motor_control/motor_control.sh -s 80")

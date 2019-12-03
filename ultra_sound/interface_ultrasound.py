import time
from gpiozero import DistanceSensor # imported so we can get the distances.
from os import system, popen
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
    distance = float(popen("tail -n1 /home/pi/CamJam-Edukit-3-Robotics/aske").read())
#    print(distance)
    if distance < local_how_near:
        return True
    else:
        return False

#Check to see if it is too far to the wall - returns true if it is
def isTooFarFromWall(local_how_far):
    distance = float(popen("tail -n1 /home/pi/CamJam-Edukit-3-Robotics/aske").read())

    if distance > local_how_far:
        return True
    else:
        return False

def isItGood(local_good_dist):
    distance = float(popen("tail -n1 /home/pi/CamJam-Edukit-3-Robotics/aske").read())
    print(distance)
    if distance > local_good_dist - 3 and distance < local_good_dist + 3:
        return True
    else:
        return False

def turnRight(s):
    print("Turning Right")
    system("bash /home/pi/CamJam-Edukit-3-Robotics/motor_control/motor_control.sh -l 80 -r 50")
    time.sleep(s)
    system("bash /home/pi/CamJam-Edukit-3-Robotics/motor_control/motor_control.sh -s 60")

def turnLeft(s):
    print("Turning Left")
    system("bash /home/pi/CamJam-Edukit-3-Robotics/motor_control/motor_control.sh -r 80 -l 50")
    time.sleep(s)
    system("bash /home/pi/CamJam-Edukit-3-Robotics/motor_control/motor_control.sh -s 60")

while True:
    system("bash /home/pi/CamJam-Edukit-3-Robotics/motor_control/motor_control.sh -s 60")

    if isNearWall(how_near):
        print("The Wall is to Near")
        turnRight(1)
        while isTooFarFromWall(good_distance) is not True:
            pass
        print("Correcting")
        turnLeft(1)
    if isTooFarFromWall(how_far):
       print("The Wall is to far")
       turnLeft(1)
       while isNearWall(good_distance) is not True:
           pass

       print("Correcting")
       turnRight(1)


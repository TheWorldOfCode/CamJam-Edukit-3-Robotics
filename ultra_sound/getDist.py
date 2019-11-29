from gpiozero import DistanceSensor # imported so we can get the distances.
import argparse # imported to get input from a bash script

#Define GPIO pins for the distance sensor
pinTrigger = 17
pinEcho = 18

#setting up the imported functions
sensor = DistanceSensor(echo = pinEcho, trigger = pinTrigger)

distance = sensor.distance *100

print(distance)

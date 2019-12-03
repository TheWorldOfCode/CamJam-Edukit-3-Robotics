import RPi.GPIO as GPIO 
import time

def setup():
    pinTrigger = 17
    pinEcho = 18

    GPIO.setmode(GPIO.BCM)
    GPIO.setwarnings(False)
    # Trigger
    GPIO.setup(pinTrigger, GPIO.OUT)
    # Echo
    GPIO.setup(pinEcho, GPIO.IN)
    return

def measurement():  
    pinTrigger = 17
    pinEcho = 18

    # Set trigger to False
    GPIO.output(pinTrigger, False)
    
    # Sleep the sensor for some time
    time.sleep(0.001)
    
    # Send pulse
    GPIO.output(pinTrigger, True)
    time.sleep(0.0001)
    GPIO.output(pinTrigger, False)
    
    #
    StartTime = time.time()
    
    # Start Time is reset until Echo pin is taken high
    while GPIO.input(pinEcho) == 0:
        StartTime = time.time()
        
    StopTime = StartTime
    
    # Stop when Echo pin is no longer high 
    while GPIO.input(pinEcho) == 1:
        StopTime = time.time()
        # Sensor cannot be too close to the object
        if StopTime - StartTime >= 0.05:
#            print("Target is to close")
            StopTime = StartTime
            break
    
    # Calculate Pulse Length
    ElapsedTime = StopTime - StartTime
    
    #Distance travelled in that time is multiplied by speed of sound
    Distance = ElapsedTime * 34326 / 2
    
#    print("Distance: %.1f cm" % Distance)
    
    return Distance



setup()
print(measurement())

# CamJam-Edukit-3-Robotics
A wall follow robot


## Requirements
1. The Pi should join an ad-hoc network called pibot
2. The Pi’s ip address should be  192.168.99.<group number> 
3. A TCP server should run on port 8080 and accept some specific
4. For example, the TCP server should accept commands like this:
echo getdist | socat tcp:192.168.99.<group number>
5. Be able to follow a wall, even if started at a slight angle.


### Requirement 3
The robot should accept following commands:  
``` bash
getdist 
```
getdist returns the last distance value from the distance sensor.

``` bash
getmotors
```
getmotors returns the current control values used on the motors

``` bash
start
```
start will start wall following behavior

``` bash
stop
```
stop will stop the robot

#### TCP server


# CamJam-Edukit-3-Robotics
A wall follow robot


## Requirements
1. The Pi should join an ad-hoc network called pibot
2. The Pi’s ip address should be  192.168.99.group_number 
3. A TCP server should run on port 8080 and accept some specific commands
4. Be able to follow a wall, even if started at a slight angle.


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
The following command starts a TCP server at the PI, using the script tcp_commands.sh
``` bash
socat tcp-listen:8080,reuseaddr,fork exec:'tcp_commands.sh'
```
#### Executing the commands
At the controlling PC the commands can be executed at the PI by this command type, e.g. for the getdist:
``` bash
echo getdist | socat tcp:192.168.99.group_number
```

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
´´´bash
1. getdist ´´´- return the last distance value from the distance sensor
2. getmotors - return the current control values used on the motors
3. start - start wall following behavior
4. stop - stop robot

#### Mapping editor
As it appears from the "Project Description.pdf" the tools make it easier 
``` bash
sudo apt install openctm-tools pstoedit potrace
```

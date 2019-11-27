# CamJam-Edukit-3-Robotics
A wall follow robot


## Requirements
1. The Pi should join an ad-hoc network called pibot
2. The Pi’s ip address should be  192.168.99.<group number> 
3. A TCP server should run on port 8080 and accept the following commands:
getdist - return the last distance value from the distance sensor
getmotors - return the current control values used on the motors
start - start wall following behavior
stop - stop robot
4. For example, the TCP server should accept commands like this:
echo getdist | socat tcp:192.168.99.<group number>
5. Be able to follow a wall, even if started at a slight angle.


## Installing Requirements

### Installing Gazebo
There are many ways to install Gazebo on. It has a docker file, which allow you to install it no matter which operation system you are usering. In the folder installer contains a installer script for Gazebo 10 with only work on linux. 
#### Mapping editor
As it appears from the "Project Description.pdf" the tools make it easier 
``` bash
sudo apt install openctm-tools pstoedit potrace
```

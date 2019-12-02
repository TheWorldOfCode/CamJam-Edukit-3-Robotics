# CamJam-Edukit-3-Robotics
A wall follow robot


## Requirements
1. The Pi should join an ad-hoc network called pibot
2. The Pi’s ip address should be  192.168.99.3
3. A TCP server should run on port 8080 and accept some specific commands
4. Be able to follow a wall, even if started at a slight angle.

### Requirement 1 & 2
I the folder adhoc are a script that setup adhoc network. The script have servel option and som are required. The required options `-i` this is used to set the interface. `-p` defined the ip address, it is important to set the netmask a eksempel is 
``` bash
192.168.99.3/24
```
If the computer is running network manager remember to turn it off or use the option `-m`. You can also change the wifi frquency with the option `-f`, the defualt frequency is 2421 this is channel 1 on 2.4 G wifi. The option `-s` is used to set the SSID that are connecting too, by default is pibot. 

Inorder to disconnect run the script with the option `-d` and remember if you are running a network manager to add the option `-m` inorder to restart it. 

The following example is used to join the pibot network from the raspberry 
``` bash
adhoc.sh -i wlan0 -p 192.168.99.3/24
```
If you don't know you interface name the use the command ifconfig. 


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

``` bas
stop
```
stop will stop the robot

#### Tcp server
The following command starts a TCP server at the PI, using the script tcp_commands.sh
``` bash
bash server.sh
```
#### Executing the commands
At the controlling PC the commands can be executed at the PI by this command type, e.g. for the getdist:
``` bash
echo getdist | socat tcp:192.168.99.3
```

### Motor control
In the folder motor_control is the script motor_control.sh which control the motor. This script have servel options
``` bash 
motor_control.sh -s 100
```

Set the dytecycle too 100. The option have sign dependency, so a negative number will get the robot to move in the oppisite direction. The options `-l` and `-r` set the dytecycle on respecity the left and right motor. 
A important option is `-q` which stops both motors. The option `-g` takes a argument `l` or `r` which returns the value from the left and right motor 

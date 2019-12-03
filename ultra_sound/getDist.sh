



while [ 1 -eq 1 ]; do

	#python3 /home/pi/CamJam-Edukit-3-Robotics/ultra_sound/getDist.py 2>/dev/null >> aske
        python3 /home/pi/CamJam-Edukit-3-Robotics/ultra_sound/ultrasound.py 2>/dev/null >> /home/pi/CamJam-Edukit-3-Robotics/aske
done

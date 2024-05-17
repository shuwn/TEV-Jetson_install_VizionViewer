#!/bin/bash

echo '***********************************' > /dev/ttyTCU0
echo 'Install Demo Script START!!!' > /dev/ttyTCU0
echo '***********************************' > /dev/ttyTCU0

TEK_ORIN=$(cat /proc/device-tree/nvidia,dtsfilename | rev | cut -d '/' -f 1 | rev | grep "tek-orin")
TN316_ORIN=$(cat /proc/device-tree/nvidia,dtsfilename | rev | cut -d '/' -f 1 | rev | grep "vl316")

if [ -z ${TEK_ORIN} ] && [ -z ${TN316_ORIN} ];then
	echo '===================================' > /dev/ttyTCU0
	echo 'This board have no 8 camera demo script.' > /dev/ttyTCU0
	echo '===================================' > /dev/ttyTCU0
	return 0
fi

DEMO_SCRIPT='/home/ubuntu/Desktop/TechNexion_8_Cam_Demo.desktop'
cp -rv /usr/share/applications/TechNexion_8_Cam_Demo.desktop ${DEMO_SCRIPT}

chmod a+x ${DEMO_SCRIPT}
export DISPLAY=$(w| tr -s ' '| cut -d ' ' -f 3|grep :)
export XAUTHORITY=/home/ubuntu/.Xauthority
echo ubuntu | sudo -S -u ubuntu dbus-launch gio set ${DEMO_SCRIPT} metadata::trusted true
sleep 5
echo ubuntu | sudo -S systemctl restart gdm

echo '***********************************' > /dev/ttyTCU0
echo 'Install Demo Script FINISH!!!' > /dev/ttyTCU0
echo '***********************************' > /dev/ttyTCU0

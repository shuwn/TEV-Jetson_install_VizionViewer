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

DEMO_SCRIPT='/home/ubuntu/Desktop/TNDemo.desktop'
if [[ ! -z ${TEK_ORIN} ]];then
	SCRIPT_NAME=$(find /home/ubuntu/ -name "TechNexion_8_Cam_Demo_TEK.sh")
elif [[ ! -z ${TN316_ORIN} ]];then
	SCRIPT_NAME=$(find /home/ubuntu/ -name "TechNexion_8_Cam_Demo_EVK.sh")
fi
cp -rv /usr/share/applications/vizionviewer.desktop ${DEMO_SCRIPT}
sed -i "$(grep -n "Name=" ${DEMO_SCRIPT} | cut -d ':' -f 1)s|Name=.*|Name=TechNexion 8 Camera demo|" ${DEMO_SCRIPT}
sed -i "$(grep -n "Exec=" ${DEMO_SCRIPT} | cut -d ':' -f 1)s|Exec=.*|Exec=${SCRIPT_NAME}|" ${DEMO_SCRIPT}
sed -i "$(grep -n "Path=" ${DEMO_SCRIPT} | cut -d ':' -f 1)s|Path=.*|Path=/home/ubuntu/|" ${DEMO_SCRIPT}
sed -i "$(grep -n "Terminal=" ${DEMO_SCRIPT} | cut -d ':' -f 1)s|Terminal=.*|Terminal=true|" ${DEMO_SCRIPT}
chmod a+x ${DEMO_SCRIPT}
DISPLAY=$(w| tr -s ' '| cut -d ' ' -f 3|grep :) \
	dbus-launch gio set ${DEMO_SCRIPT} metadata::trusted true

echo '***********************************' > /dev/ttyTCU0
echo 'Install Demo Script FINISH!!!' > /dev/ttyTCU0
echo '***********************************' > /dev/ttyTCU0

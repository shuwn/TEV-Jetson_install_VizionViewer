#!/bin/sh

echo '' > /dev/ttyTCU0
echo '***********************************' > /dev/ttyTCU0
echo 'Install VizionViewer START' > /dev/ttyTCU0
echo '***********************************' > /dev/ttyTCU0

cd /usr/share/vizionviewer/
TAR_FILE=$(find -name "*vizionviewer*.tar.xz")
CURSOR_FILE=$(find -name "*libxcb-cursor0*")
XINPUT_FINE=$(find -name "*libxcb-xinput0*")
LIBV4L2RDS_FILE=$(find -name "*libv4l2rds0*")
V4L_UTILS_FILE=$(find -name "*v4l-utils*")

sudo apt install -y ${CURSOR_FILE} ${XINPUT_FINE} ${V4L_UTILS_FILE} ${LIBV4L2RDS_FILE}
tar -xf ${TAR_FILE}
sudo apt install -y ./vizionsdk.deb
sudo apt install -y ./vizionviewer.deb

rm ./vizionsdk.deb ./vizionviewer.deb

USER_PATH=$(find /run/user -name bus)
sudo -u ubuntu DISPLAY=$(w| tr -s ' '| cut -d ' ' -f 3|grep :) \
	DBUS_SESSION_BUS_ADDRESS=unix:path=${USER_PATH} \
	gsettings set org.gnome.shell favorite-apps \
	"[ 'vizionviewer.desktop', $(gsettings get org.gnome.shell favorite-apps | sed s/.//)"

# Create demo 8 camera script link
DEMO_SCRIPT='/home/ubuntu/Desktop/TNDemo.desktop'
cp -rv /usr/share/applications/vizionviewer.desktop ${DEMO_SCRIPT}
sed -i "$(grep -n "Name=" TNDemo.desktop | cut -d ':' -f 1)s|Name=.*|Name=TechNexion 8 Camera demo|" ${DEMO_SCRIPT}
sed -i "$(grep -n "Exec=" TNDemo.desktop | cut -d ':' -f 1)s|Exec=.*|Exec=/home/ubuntu/TechNexion_8_Cam_Demo_TEK.sh|" ${DEMO_SCRIPT}
sed -i "$(grep -n "Path=" TNDemo.desktop | cut -d ':' -f 1)s|Path=.*|Path=/home/ubuntu/|" ${DEMO_SCRIPT}
sudo -u ubuntu -g ubuntu DISPLAY=$(w| tr -s ' '| cut -d ' ' -f 3|grep :) \
	dbus-launch gio set ${DEMO_SCRIPT} metadata::trusted true
sudo chmod a+x ${DEMO_SCRIPT}
sudo cp -rv ${DEMO_SCRIPT} /usr/share/applications/
sudo service gdm restart

echo '***********************************' > /dev/ttyTCU0
echo 'Install VizionViewer FINISH!!!' > /dev/ttyTCU0
echo '***********************************' > /dev/ttyTCU0

#!/bin/sh

echo '***********************************'
echo 'Install VizionViewer START'
echo '***********************************'

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

echo '***********************************'
echo 'Install VizionViewer FINISH!!!'
echo '***********************************'

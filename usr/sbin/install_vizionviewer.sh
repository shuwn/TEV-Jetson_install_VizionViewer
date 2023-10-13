#!/bin/sh

echo '***********************************'
echo 'Install VizionViewer START'
echo '***********************************'

cd /usr/share/vizionviewer/
TAR_FILE=$(find -name "*vizionviewer*.tar.xz")
tar -xf ${TAR_FILE}
sudo apt install ./vizionsdk.deb
sudo apt install ./vizionviewer.deb
rm ./vizionsdk.deb
rm ./vizionviewer.deb

echo '***********************************'
echo 'Install VizionViewer FINISH!!!'
echo '***********************************'

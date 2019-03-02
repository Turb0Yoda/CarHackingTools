#!/bin/bash
#Modified carhacking.tools script
set -e

# Setup Tools Directory
sudo mkdir -p /tools
sudo chmod -R 0777 /tools
cd /tools || exit

# Add user to dialout so USB-to-Serial Works-ish.
sudo usermod -a -G dialout "$USER"

# Update System
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

#  Java Fixes
echo oracle-java10-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:webupd8team/java
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y

#fix for node errors
#commented out since it started to cause issues rather than fixing previous issues
#echo 'export PATH=$PATH:/usr/local/bin' >> $HOME/.bashrc

#Base Package Install (Packages Listed Invidually For Easy Customazation/Trobule Shooting.)
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y  \
aircrack-ng \
ant \
arduino \
arduino-core \
autoconf \
automake \
bison \
blueman \
bluetooth \
bluez \
bluez-tools \
btscanner \
build-essential \
can-utils \
cpp \
cryptsetup \
curl \
ess \
flex \
gcc \
git \
gnuradio \
gqrx-sdr \
htop \
jq \
libavcodec-dev \
libavformat-dev \
libbluetooth-dev \
libconfig-dev \
libgps-dev \
libgtk-3-dev \
libportmidi-dev \
libsdl2-dev \
libsdl2-image-dev \
libsdl2-mixer-dev \
libsdl2-ttf-dev \
libsqlite3-dev \
libswscale-dev \
libtool \
maven \
moserial \
net-tools \
netbeans \
npm \
oracle-java8-installer \
oracle-java8-set-default \
python \
python-dev \
python-dev \
python-pip \
python-serial \
python-wxtools \
python3-pip \
ruby \
ruby-dev \
software-properties-common \
sqlite \
tree \
tree \
tshark \
unrar \
unzip \
wget \
wireshark \
zlib1g-dev


#fix for npm build errors
#commented out since it started to cause issues rather than fixing previous issues
#sudo ln -s /usr/bin/nodejs /usr/bin/node

#Python Pip
sudo python -m pip uninstall pip  # this might need sudo
sudo apt install --reinstall python-pip

# Starting Car Hacking Tool Installation

printf "Instaling Tools"
printf "\\n"

# Bluelog
# Read The Docs: https://github.com/MS3FGX/Bluelog
cd /tools || exit
git clone https://github.com/MS3FGX/Bluelog.git
cd Bluelog || exit
sudo make install
cd .. || exit

# Can-Utils:
# Read The Docs: https://github.com/linux-can/can-utils
# More Reading: # More Reading: https://discuss.cantact.io/t/using-can-utils/24
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y  can-utils

# Canbus-utils
# Read The Docs Here: https://github.com/digitalbond/canbus-utils
# More Reading:  http://www.digitalbond.com/blog/2015/03/05/tool-release-digital-bond-canbus-utils/
cd /tools || exit
git clone https://github.com/digitalbond/canbus-utils
cd canbus-utils || exit
npm install
cd .. || exit

# Cantact-App
# Read The Docs Here: https://github.com/linklayer/cantact-app/
#git clone https://github.com/linklayer/cantact-app
#cd cantact-app
#ant build
#cd cantact-app || exit
cd /tools || exit
wget https://github.com/linklayer/cantact-app/releases/download/v0.3.0-alpha/cantact-v0.3.0-alpha.zip
sudo unzip cantact-v0.3.0-alpha.zip
sudo rm cantact-v0.3.0-alpha.zip
cd .. || exit

# Caringcaribou
# Read The Docs Here: https://github.com/CaringCaribou/caringcaribou
pip install --user python-can
cd /tools || exit
git clone https://github.com/CaringCaribou/caringcaribou
cd .. || exit

# c0f
# Read the Docs Here: https://github.com/zombieCraig/c0f
sudo gem install c0f

# ICSim
# Read The Docs Here: https://github.com/zombieCraig/ICSim
# Quick Start:  ./setup_vcan.sh &&  ./icsim vcan0 && ./controls vcan0
cd /tools || exit
git clone https://github.com/zombieCraig/ICSim.git
cd .. || exit

# KatyOBD
# Read The Docs Here:
cd /tools || exit
git clone https://github.com/YangChuan80/KatyOBD
#Fix Typo in KatyOBD
cd KatyOBD || exit
###pip install obd
sed -i 's/tkinter/Tkinter/g' KatyOBD.py
cd .. || exit

# Kayak
# Read The Docs Here: http://kayak.2codeornot2code.org/
# To Install ./Kayak-1.0-SNAPSHOT-linux.sh --silent
cd /tools || exit
git clone git://github.com/dschanoeh/Kayak
cd Kayak
mvn install
cd .. || exit

# OBD-Monitor
cd /tools || exit
git clone https://github.com/dchad/OBD-Monitor
cd OBD-Monitor || exit
cd src|| exit
make gui
make server
make simulator
make ftests
make stests
make utests
cd .. || exit
cd .. || exit


# Python-ODB
# Read The Docs Here: https://python-obd.readthedocs.io/en/latest/
sudo pip install --user pySerial
cd /tools || exit
git clone https://github.com/brendan-w/python-OBD
cd python-OBD || exit
sudo python setup.py install
cd .. || exit


# PyOBD:
# Fix This!
# Backup: git clone https://github.com/Pbartek/pyobd-pi.git
cd /tools || exit
wget http://www.obdtester.com/download/pyobd_0.9.3.tar.gz
sudo tar -xzvf pyobd_0.9.3.tar.gz
sudo rm -rf pyobd_0.9.3.tar.gz
cd .. || exit
# SavvyCAN
# Read The Docs Here: https://github.com/collin80/SavvyCAN

# Start With QT:
mkdir -p QT
cd QT || exit
wget http://download.qt.io/official_releases/qt/5.9/5.9.0/qt-opensource-linux-x64-5.9.0.run
chmod +x qt-opensource-linux-x64-5.9.0.run

echo "Installing Qt, this will take a while."
echo " - Ignore warnings about QtAccount credentials and/or XDG_RUNTIME_DIR."
echo " - Do not click on any Qt setup dialogs, it is controlled by a script."
./qt-opensource-linux-x64-5.9.0.run
cd .. || exit

# SavvyCan Install
cd /tools || exit
git clone https://github.com/collin80/SavvyCAN.git
cd SavvyCAN || exit
sudo /opt/Qt5.9.0/5.9/gcc_64/bin/qmake
sudo make
sudo make install
sudo ./install
cd .. || exit


# Scantool
# Read The Docs Here: https://samhobbs.co.uk/2015/04/scantool-obdii-car-diagnostic-software-linux
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y  scantool

# Socketcand
# Read The Docs Here: https://github.com/dschanoeh/socketcand
cd /tools || exit
git clone http://github.com/dschanoeh/socketcand.git
cd socketcand || exit
autoconf
./configure --without-config
 make clean
make
sudo make install
cd .. || exit

# UDSim
# Read The Docs Here: https://github.com/zombieCraig/UDSim
cd /tools || exit
git clone https://github.com/zombieCraig/UDSim
cd UDSim/src || exit
make
cd .. || exit
cd .. || exit

# Make Desktop Icons

printf "Configuring Desktop Icons"
printf "\\n"

mkdir -p -p icons
cd icons || exit

cat << EOF > BlueLog.desktop
[Desktop Entry]
Name=BlueLog
Type=Application
Path=/tools/Bluelog
Exec=/tools/Bluelog/bluelog
Icon=/tools/Bluelog/www/images/bluelog_logo.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

cat << EOF > Cantact.desktop
[Desktop Entry]
Name=Cantact
Type=Application
Path=/tools/cantact-app/cantact/bin
Exec=sudo -H /tools/cantact-app/cantact/bin/cantact
Icon=/tools/images/Icons/cantact.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

cat << EOF > ICSim.desktop
[Desktop Entry]
Name=ICSim
Type=Application
Path=/tools/ICSim/
Exec=/tools/ICSim/icsim vcan0
Icon=/tools/images/Icons/icsim.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

cat << EOF > ICSimControls.desktop
[Desktop Entry]
Name=ICSim Controls
Type=Application
Path=/tools/ICSim/
Exec=/tools/ICSim/controls vcan0
Icon=/tools/images/Icons/icsim.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

cat << EOF > KayakInstall.desktop
[Desktop Entry]
Name=Kayak Install
Type=Application
Path=/tools/Kayak
Exec=/tools/Kayak/application/target/kayak/bin/kayak
Icon=/tools/images/Icons/kayak.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

cat << EOF > KatyOBD.desktop
[Desktop Entry]
Name=KatyOBD
Type=Application
Path=/tools/KatyOBD
Exec=sudo -H python KatyOBD.py
Icon=/tools/images/Icons/KatyOBD.png
Terminal=true
Categories=Utility
StartupNotify=false
EOF

sudo rm ~/Desktop/SavvyCAN.desktop
sleep 15
sudo chmod 755 ./*.desktop
cp ./*.desktop ~/Desktop
cd .. || exit

cd ~/Desktop || exit
sudo chmod 755 ./*.desktop
cd .. || exit

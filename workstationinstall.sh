#!/bin/bash
# Ubuntu Car Hacking Workstation Setup
# TODO:
# Make Sure Icons Work.
# General Clean Up.
set -e

# Set Install Dir Beacon
installdir=$(pwd)

# Setup Tools Directory
sudo mkdir -p /tools
sudo chmod -R 0777 /tools
cd /tools || exit

# Set Background Images
mkdir -p images
cd images || exit
cp -r ~/carhackingtools/Icons /tools/images
gsettings set org.mate.background picture-filename "/tools/images/background.gif"
cd .. || exit

# Configure Desktop
gsettings set org.mate.background show-desktop-icons true
gsettings set org.mate.background primary-color '#000000'
gsettings set org.mate.desktop.datetime clock-show-date true
gsettings set org.mate.screensaver lock-enabled false
gsettings set org.mate.screensaver logout-enabled false

#Disable Power Managment
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

#Running The Tool Install script
cd "$installdir"
./toolinstall.sh

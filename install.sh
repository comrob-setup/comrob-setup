###!/bin/bash

#get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

APPCONFIG_PATH=$MY_PATH/appconfig
MISC_PATH=$MY_PATH/misc

cd $MY_PATH
#git pull
git submodule init 
git submodule update --init --recursive

#update and upgrade current packages
sudo apt-get -y update
sudo apt-get -y upgrade

#install essentials
echo "installing essentials"
sudo apt-get -y install build-essential make cmake ccache pkg-config automake autoconf libc++-dev clang-6.0 clang-format-6.0 python2.7-dev python3-dev

#install libs
echo "installing libs"
sudo apt-get -y install libncurses5-dev libsdl2-dev

#install tools
echo "installing tools"
sudo apt-get -y install htop tree ncdu git subversion unzip dialog

#install cifs-utils for mounting dataset repository
echo "installing cifs-utils"
sudo apt-get -y install cifs-utils

#video processing 
echo "installing video processing"
sudo apt-get -y install vlc mplayer ffmpeg

#install vim
echo "installing vim"
bash $APPCONFIG_PATH/vim/install.sh

#install tmux
echo "installing tmux"
bash $APPCONFIG_PATH/tmux/install.sh

#install opencv
echo "installing opencv"
bash $APPCONFIG_PATH/opencv/install.sh

#install ros
echo "installing ros"
bash $APPCONFIG_PATH/ros/install.sh

#install python libs
echo "installing python libs"
bash $APPCONFIG_PATH/python/install.sh

#add aliases
sudo ln -s /usr/bin/xdg-open /usr/bin/open

#add tmux startup if it is not already in .bashrc 
num=`cat ~/.bashrc | grep "RUN_TMUX" | wc -l`
if [ "$num" -lt "1" ]; then
    cat $APPCONFIG_PATH/tmux/bashconfig >> ~/.bashrc
fi

#add user to dialout group
sudo adduser `whoami` dialout

#copy udev-rules
bash $MISC_PATH/udev/install.sh 
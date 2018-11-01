#!/bin/bash

APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

WS_PATH=`( cd ~ && cd catkin_ws && pwd )`

mkdir '~/software'
SOFTWARE_PATH=`( cd ~ && cd software && pwd )`

URL="https://github.com/intel-ros/realsense"

# 1. Install RealSense SDK 2.0 as debian package:
echo 'deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main' | sudo tee /etc/apt/sources.list.d/realsense-public.list
sudo apt-key adv --keyserver keys.gnupg.net --recv-key 6F3EFCDE
sudo apt-get update
sudo apt-get -y install librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg
 
# 2. Install necessary packages for ROS.
sudo apt-get -y install ros-melodic-tf
sudo apt-get -y install ros-melodic-diagnostic-updater
 
# 3. Now, install RealSense wrapper from source:  ( https://github.com/intel-ros/realsense )
# (I installed branch development.)
# use catkin to install it
cd "$SOFTWARE_PATH"
git clone "$URL"
cd "$WS_PATH/src"
ln -s "$SOFTWARE_PATH/realsense/realsense2_camera"
cd "$WS_PATH"
catkin_make clean
catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release
catkin_make install

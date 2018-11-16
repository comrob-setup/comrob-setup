sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-prerelease `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-prerelease.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install build-essential cmake git libbluetooth-dev libcwiid-dev libgoogle-glog-dev libignition-common-dev libignition-math4-dev libspnav-dev libusb-dev lsb-release mercurial pkg-config python gazebo9 libgazebo9-dev ros-melodic-desktop-full ros-melodic-joystick-drivers ros-melodic-pointcloud-to-laserscan ros-melodic-robot-localization ros-melodic-spacenav-node ros-melodic-tf2-sensor-msgs ros-melodic-twist-mux ros-melodic-velodyne-simulator python3-numpy python3-empy

sudo apt-get -y upgrade

cd ~
mkdir -p "subt_ws/src"
mkdir "software"
SUBT_WS_PATH=`( cd ~ && cd subt_ws && pwd )`
SOFTWARE_PATH=`( cd ~ && cd software && pwd )`
WS_PATH=`( cd ~ && cd catkin_ws && pwd )`

cd "$SUBT_WS_PATH"
catkin_make

cd "$SOFTWARE_PATH"
sudo rm -rf subt
hg clone https://bitbucket.org/osrf/subt

cd "$SUBT_WS_PATH"
wget https://s3.amazonaws.com/osrf-distributions/subt_robot_examples/releases/subt_robot_examples_latest.tgz
tar xvf subt_robot_examples_latest.tgz

cd "$SUBT_WS_PATH/src"
ln -s "$SOFTWARE_PATH/subt"
ln -s "$WS_PATH/src"

cd "$SUBT_WS_PATH"
catkin_make install
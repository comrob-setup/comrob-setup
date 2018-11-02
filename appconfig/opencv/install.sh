#!/bin/bash

ALL="no"
OPENCV="no"

POSITIONAL=()
while [[ $# -gt 0 ]]
	do
	key="$1"

	case $key in
	    --all)
	    ALL="yes"
	    POSITIONAL+=("$1")
	    shift # past argument
	    ;;
	    --opencv)
	    OPENCV="$2"
	    POSITIONAL+=("$1")
	    POSITIONAL+=("$2")
	    shift # past argument
	    shift # past value
	    ;;
	    *)    # unknown option
	    POSITIONAL+=("$1")
	    shift # past argument
	    ;;
	esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [ "$ALL" == "yes" ] || [ "$OPENCV" != "no" ]; then

        echo "******************************************************************************************************************"
        echo "Installing OPENCV $@"
        echo "******************************************************************************************************************"

	#install prerequisities
	sudo apt-get -y install libavcodec-dev libavformat-dev libavutil-dev libswscale-dev 

	#download sources
	cd /tmp
	#opencv contrib package
	git clone https://github.com/opencv/opencv_contrib.git --depth 1

	#opencv core
	git clone https://github.com/opencv/opencv.git --depth 1

	#build opencv with extra packages
	cd /tmp/opencv
	mkdir build
	cd build
	cmake -DOPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib/modules ..
	make -j 4
	sudo make install

        echo "******************************************************************************************************************"
        echo "DONE Installing OPENCV $@"
        echo "******************************************************************************************************************"

fi

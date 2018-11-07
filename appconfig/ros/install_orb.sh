#!/bin/bash

ALL="no"
ORB="no"
USER=""
PSWD=""

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
	    --orb)
	    ORB="$2"
	    POSITIONAL+=("$1")
	    POSITIONAL+=("$2")
	    shift # past argument
	    shift # past value
	    ;;
	    --user)
	    USER="$2"
	    POSITIONAL+=("$1")
	    POSITIONAL+=("$2")
	    shift # past argument
	    shift # past value
	    ;;
	    --pswd)
	    PSWD="$2"
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


if [ "$ALL" == "yes" ] || [ "$ORB" != "no" ]; then

        echo "******************************************************************************************************************"
        echo "Installing ORB SLAM $@"
        echo "******************************************************************************************************************"

	APP_PATH=`dirname "$0"`
	APP_PATH=`( cd "$APP_PATH" && pwd )`

        mkdir "~/software"
        SOFTWARE_PATH=`( cd ~ && cd software && pwd )`

        echo "acquiring ORB SLAM install script"
        #TODO download from svn
        echo "acquired"
 
        bash "${APP_PATH}/orb_slam_auto_install.sh" "${SOFTWARE_PATH}"

	WS_PATH=`( cd ~ && cd catkin_ws && pwd )`
	cd "$WS_PATH/src"
        ln -s "$SOFTWARE_PATH/ORB_SLAM2"
   
        cd "${WS_PATH}"
        catkin_make clean
        catkin_make
        rospack list


        echo "******************************************************************************************************************"
        echo "DONE ORB SLAM $@"
        echo "******************************************************************************************************************"

fi

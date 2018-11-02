#!/bin/bash

ALL="no"
PYTHON="no"

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
	    --python)
	    PYTHON="$2"
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

if [ "$ALL" == "yes" ] || [ "$PYTHON" != "no" ]; then

        echo "******************************************************************************************************************"
        echo "Installing PYTHON $@"
        echo "******************************************************************************************************************"

	# get the path to this script
	APP_PATH=`dirname "$0"`
	APP_PATH=`( cd "$APP_PATH" && pwd )`

	#install python2 packages
	sudo apt-get -y install python-pip
	pip install numpy scipy matplotlib scikit.learn scikit.image pathlib

	#install python3 packages
	sudo apt-get -y install python3-pip
	pip3 install numpy scipy matplotlib scikit.learn scikit.image pathlib

        echo "******************************************************************************************************************"
        echo "DONE Installing PYTHON $@"
        echo "******************************************************************************************************************"

fi

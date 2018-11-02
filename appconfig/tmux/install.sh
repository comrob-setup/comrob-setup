#!/bin/bash

ALL="no"
TMUX="no"

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
	    --tmux)
	    TMUX="$2"
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

if [ "$ALL" == "yes" ] || [ "$TMUX" != "no" ]; then

        echo "******************************************************************************************************************"
        echo "Installing TMUX $@"
        echo "******************************************************************************************************************"

	# get the path to this script
	APP_PATH=`dirname "$0"`
	APP_PATH=`( cd "$APP_PATH" && pwd )`

	sudo apt-get -y install tmux

	# symlink tmux settings
	rm ~/.tmux.conf
	cp $APP_PATH/dottmux.conf ~/.tmux.conf

        echo "******************************************************************************************************************"
        echo "DONE Installing TMUX $@"
        echo "******************************************************************************************************************"

fi

#!/bin/bash

USER="none"
PSWD=""

POSITIONAL=()
while [[ $# -gt 0 ]]
	do
	key="$1"

	case $key in
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

if [ "$USER" != "none" ]; then

        echo "******************************************************************************************************************"
        echo "Installing PRIVATE SETUP $@"
        echo "******************************************************************************************************************"

  	MY_PATH=`dirname "$0"`
	MY_PATH=`( cd "$MY_PATH" && pwd )`

	URL="https://robotics.fel.cvut.cz/svn/${USER}/config/install_private.sh"

        if [ "$PSWD" == "" ]; then
		svn export "$URL" "${MY_PATH}/install_private.sh" --force
        else
		svn export --username "$USER" --password "$PSWD" --non-interactive --trust-server-cert --force "$URL" "${MY_PATH}/install_private.sh"
        fi

        bash "${MY_PATH}/install_private.sh" "$@"

        echo "******************************************************************************************************************"
        echo "DONE Installing PRIVATE SETUP $@"
        echo "******************************************************************************************************************"
fi

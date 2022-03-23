#!/bin/bash

while getopts 'c:p:' flag; do
	case "${flag}" in
		c) cwdiswppslinter=${OPTARG} ;;
		p) plugindirname=${OPTARG} ;;
	esac
done

# Get the absolute path to the plugin we want to check.
if [ "$cwdiswppslinter" = "1" ]; then
	plugindir="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath "$0")" )" )" )" )/$plugindirname"
	wpcontentdir="./../../../../"
	scriptsdir="$(dirname "$(realpath "$0")" )/"
else
	cwdiswppslinter=0
	plugindir="$(dirname "$(dirname "$(realpath "$0")" )" )"
	wpcontentdir="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath $0)" )" )" )" )"
	scriptsdir="$plugindir/wpps-scripts/"
fi

cd "$wpcontentdir"
sh "${scriptsdir}install-script-dependencies.sh" -c $cwdiswppslinter

npm run test:js $plugindir

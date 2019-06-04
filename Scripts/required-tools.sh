#!/bin/bash

echo "Checking 'ruby'"
if !(ruby -v) > /dev/null 2>&1; then
	# TODO: Automate ruby installation, later
	echo "'ruby' is not installed, installing..."
	exit 255
fi

echo "Checking 'xcpretty'"
if !(gem list -i "$xcpretty$") > /dev/null 2>&1; then
	echo "'xcpretty' is not installed, installing..."
	gem install xcpretty
else
	echo "'xcpretty' version $(xcpretty -v) detected"
fi

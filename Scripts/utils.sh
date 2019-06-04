#!/bin/bash

function createDirectory {
	eval [ ! -d "$1" ] && eval mkdir "$1"
}

function clearDataInDirectory {
	eval find "$1" -mindepth 1 -delete
}

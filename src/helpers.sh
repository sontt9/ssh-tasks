#!/bin/bash

_is_array() {
	local variable_name=$1
	[[ "$(declare -p $variable_name)" =~ "declare -a" ]]
}

_is_not_array() {
	! _is_array $1
}

_is_empty() {
	[ "$1" = "" ]
}

_is_file() {
	local string=$1
	[[ -e $string ]]
}

_set_colours() {
	# text colours
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 3`
	blue=`tput setaf 4`
	reset=`tput sgr0`
}

_indent() {
	printf "\t"
}
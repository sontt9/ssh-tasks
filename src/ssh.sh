#!/bin/bash

function _ssh() {
	# require first argument
	[[ -z "$1" ]] && echo 'missing argument, server array or server name required' && exit 1

	ssh $1 $2
}
#!/bin/bash

_task() {
	echo $2
	_ssh $1 "$2"
}
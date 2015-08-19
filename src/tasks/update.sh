#!/bin/bash

function _task() {
	_ssh $1 "sudo yum update -y"
}
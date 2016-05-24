_is_array() {
	local variable_name=$1
	[[ "$(declare -p $variable_name)" =~ "declare -a" ]]
}

_is_not_array() {
	! _is_array $1
}

_in_array() {
	local e
	for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
	return 1
}

_not_in_array() {
	[ _in_array $@ = 0 ]
}

_is_empty() {
	[ "$1" = "" ]
}

_is_not_empty() {
	[ "$1" != "" ]
}

_is_file() {
	[[ -e $1 ]]
}

_is_not_file() {
	! _is_file $1
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

_is_hostname() {
	[[ "$1" =~ ^([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])(\.([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]{0,61}[a-zA-Z0-9]))*$ ]]
}

_run() {
	$TASKS_SRC/bin/run "$@"
}
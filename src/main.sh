function main()
{
	export TASKS_SRC=${TASKS_SRC:-"$autopath"}
	export TASKS_PATH=${TASKS_PATH:-"$PWD"}

	# load source
	source "$TASKS_SRC/src/helpers.sh"
	source "$TASKS_SRC/src/ssh.sh"
	source "$TASKS_SRC/src/load.sh"

	# set colour variables
	_set_colours

	# get task name as $1 and remove from $@
	local task=${1:-"help"}; shift

	# allow usage of 'on' anywhere in params
	local on=false && [ "$1" = "on" ] && shift && on=true

	local manifest
	local servers

	# manifest is included in params
	$on && manifest=${1:-""} && shift

	# load manifest file into an array
	$on && _is_file $manifest && read -a servers <<< $(cat $manifest)

	# no manifest was found, so try that param as a hostname instead
	$on && _is_empty $servers && _is_hostname $manifest && servers=$manifest

	# no manifest provided, use default manifest instead
	[ $on = false ] && _is_empty $servers && _is_file ${TASKS_MANIFEST:-"$TASKS_PATH/manifest"} && read -a servers <<< $(cat ${TASKS_MANIFEST:-"$TASKS_PATH/manifest"})

	# no servers found
	_is_empty $servers && echo "${red}ERROR${reset} Could not find manifest or host. See README.md for help." && exit 1

	# set runner as an array from servers
	_is_array servers && local runner=("${servers[@]}")
	_is_not_array servers && local runner[0]=$servers

	# load task file
	_load $task "$@"

	# run task
	local background=${TASKS_BACKGROUND:-false}
	for run in "${runner[@]}"; do
		echo "${yellow}--->${green} $run ${blue}$task${reset}"

		# run in foreground
		[ $background = false ] && _task $run "$@"

		# run in background
		[ $background = true ] && _task $run "$@" &
		[ $background = true ] && echo '    running in background'

		sleep 1
	done
}
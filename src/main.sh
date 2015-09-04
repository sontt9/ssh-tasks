function main()
{
	# load app
	export TASKS_PATH=${TASKS_PATH:-"$PWD"}
	source "$TASKS_PATH/src/helpers.sh"
	source "$TASKS_PATH/src/ssh.sh"
	source "$TASKS_PATH/src/load_task.sh"

	# colours
	_set_colours

	# get task name and remove from $@
	local task=${1:-"help"}; shift


	# find servers to task upon
	local manifest
	local servers

	# allow usage of on command preffix
	local on=false
	[ "$1" = "on" ] && shift && on=true

	# manifest is included in params
	$on && manifest=${1:-""} && shift

	# load manifest file into an array
	$on && _is_file $manifest && read -a servers <<< $(cat $manifest)

	# no manifest was found, so try it as a hostname instead (only valid after on preffix)
	$on && _is_empty $servers && _is_hostname $manifest && servers=$manifest

	# no manifest provided, use default manifest instead
	[ $on = false ] &&  _is_empty $servers && _is_file ${TASKS_MANIFEST:-"$TASKS_PATH/manifest"} && read -a servers <<< $(cat ${TASKS_MANIFEST:-"$TASKS_PATH/manifest"})

	# no servers found
	_is_empty $servers && echo "${red}ERROR${reset} You're missing a manifest file. See the readme for help." && exit 1

	# set runner as an array from servers
	_is_array servers && runner=("${servers[@]}")
	_is_not_array servers && runner[0]=$servers

	# load task
	_load_task $task "$@"

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
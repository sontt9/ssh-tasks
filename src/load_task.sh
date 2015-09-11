function _load_task() {
	local task=$1; shift

	local userdefined="$TASKS_SRC/src/tasks/$task.sh"
	_is_file $userdefined && source $userdefined && return 1

	local predefined="$TASKS_SRC/tasks/$task.sh"
	_is_file $predefined && source $predefined && return 1

	echo "${red}No such task exists: $task${reset}" && exit 1
}
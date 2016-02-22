_task() {
	local host=$1; shift
	_ssh $host "$@"
}
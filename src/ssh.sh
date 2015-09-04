function _ssh() {
	local ssh_path=${SSH_BINARY:-$(which ssh)}
	$ssh_path $@
}
# SSH tasks

A simple bash task runner, ideal for quick and easy server management over SSH.

## Install

```
git clone https://github.com/Paperback/ssh-tasks.git && ./ssh-tasks/bin/install
```

## Usage

`run $taskname on $hostname $params`

`run ssh on example.com sudo yum update -y` 

`run ssh on example.com echo "hello from $hostname"` 

`run ssh on example.com`

### Manifests

A file containing hosts delimited by a line break, used to run a task on multiple hosts at once.

```
example.com
example.org
```

By default, ssh-tasks will search for a file called manifest.

`run ssh sudo reboot` 

`run ssh on manifest.txt sudo reboot` 

`run ssh on ~/servers/custom hostname`

ssh-tasks will search for the manifest file in your current directory by default.


### Tasks

Tasks are stored under the tasks directory. Each task is just a bash file ending in .sh with a _task function.

```
# tasks/upgrade.sh
_task() {
  echo $1 # hostname
  _ssh $1 "sudo apt-get update && sudo apt-get upgrade"
  echo "Done!"
}
```

`run upgrade on example.com` 

`run upgrade on manifest.txt` 

`run upgrade` will use the default manifest file

#### Tasks from within tasks


```
_task() {
	local host=$1
	echo "Running another_task on $host"
	_run another_task on $host 
}
```

This will echo Hello from 

#### Local tasks

You can also create scripts that run once, locally. Just make sure to exit before the end of the file.

```
# tasks/install_all_gems.sh

for repo in $1/*; do
	if [[ -f "$repo/Gemfile" ]]; then
  	cd $repo && bundle install
    echo $repo
	fi
done

exit 0 # this is required to stop the task runner running multiple times

```

`run install_all_gems ~/Repositories/` will find all subdirectories containing Gemfiles and run bundle install.


## Runtime options

| env        |            |
| ------------- |-------------| 
| TASKS_BACKGROUND | will put tasks into the background with the builtin jobs command if provided |
| TASKS_PATH | installation directory |
| TASKS_MANIFEST | default manifest file |
| SSH_BINARY | location invoked for ssh command  |

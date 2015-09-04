# SSH tasks

An extremely simple task runner for quick and easy server management over SSH.

`./run ssh on example.com sudo yum update -y`
`./run ssh on example.com echo "hello from hostname"`
`./run ssh on example.com`

## Manifests

Simply a file containing hosts delimited by a line break.

```
example.com
example.org
```

By default, ssh-tasks will search for a file called manifest.

`./run ssh sudo reboot`
`./run ssh on manifest sudo reboot`
`./run ssh on ~/servers/custom_manifest hostname`

## Tasks

Tasks are stored under the tasks directory. Each task is just a bash file ending in .sh with a _task function.

```
# tasks/upgrade.sh
function _task() {
  echo $1 # hostname
  _ssh $1 "sudo apt-get update && sudo apt-get upgrade"
  echo "Done!"
}
```

`./run upgrade on example.com`
`./run upgrade on manifest`
`./run upgrade` will use the default manifest file

### Local tasks

You can also create scripts that run once locally.

```
# tasks/bundle-install-all.sh

for repo in $1/*; do
	if [[ -f "$repo/Gemfile" ]]; then
  	cd $repo && bundle install
    echo $repo
	fi
done

exit # this is required to stop the task runner!

done
```

`./run bundle-install-all ~/Repositories/` will find all subdirectories containing Gemfiles and run bundle install.

## Options

| env        |            |
| ------------- |-------------| 
| TASKS_BACKGROUND | will put tasks into the background the builtin jobs if set |
| TASKS_PATH | installation directory |
| TASKS_MANIFEST | default manifest file |
| SSH_BINARY | location invoked for ssh command  |

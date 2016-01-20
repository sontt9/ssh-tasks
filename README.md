# SSH tasks

A simple bash task runner. Ideal for quick and easy server management over SSH.

`./run ssh on example.com sudo yum update -y`

`./run ssh on example.com echo "hello world!"`

`./run ssh on example.com`

## Tasks

Tasks are stored under the tasks directory. Each task is just a bash file ending in .sh

### Local

You can create local tasks like below:

```
# tasks/bundle-install-all.sh

for repo in $1/*; do
	if [[ -f "$repo/Gemfile" ]]; then
  	cd $repo && bundle install
    echo $repo
	fi
done

exit # stop runner

done
```

`run bundle-install-all ~/Repositories/` will find all subdirectories inside the first parameter containing Gemfiles and run bundle install on them.


### over SSH

You can also create tasks that are ran on hosts through SSH:

```
# tasks/update.sh
function _task() {
  echo $1 # hostname
  _ssh $1 "sudo yum update -y"
  echo "Done!"
}
```

You can run this on a domain, or on a file containing many domains delimited by line breaks:

`./run upgrade on example.com`

`./run upgrade on manifest`

`./run upgrade` will always use the default manifest file

## Options

You can set these before running a task.

| env        |            |
| ------------- |-------------|
| TASKS_BACKGROUND | will put tasks into the background as a job if set |
| TASKS_PATH | installation directory |
| TASKS_MANIFEST | default manifest file |
| SSH_BINARY | location invoked for ssh command  |

## Manifests

Simply a file containing hosts delimited by a line break.

```
example.com
example.org
```

You can then use this file to run tasks.

`./run ssh on manifest sudo reboot`

`./run ssh on ~/servers hostname`

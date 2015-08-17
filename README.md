# SSH tasks
A very simple task runner for quick and easy server management over SSH

`./run update jimbob.com`

## Manifests
Manifests allow you run tasks against multiple hosts easily. It's simple a file with a SSH host delimited by a newline.

For example, create your manifest file `"jimbob.com\nbarrysmith.com" > manifest` and then when you `./run update`, it will run against all hosts inside the manifest file.

**Specify your own manifest** 

ssh-tasks will always search for the manifest file, but you can provide your own manifests easily. 

`./run manifest example` will show you the hosts in the manifest called example.


## SSH
`./run ssh echo "Hello from server!"`

# SSH tasks
A very simple task runner for quick and easy server management over SSH

`./run update jimbob.com`

## Manifests
Manifests allow you run tasks against multiple hosts easily.

An example manifest:

```
jimbob.com
barrysmith.com
```

Now `./run update` will update jimbob.com and barrysmith.com.

**Specify a different manifest** 

ssh-tasks will always search for the manifest file, but you can provide your own manifests easily. 

`./run manifest example` will show you the hosts in the manifest called example.


## SSH
`./run ssh echo "Hello from server!"`

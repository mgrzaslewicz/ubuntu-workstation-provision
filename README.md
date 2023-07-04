# dev-machine-provision
Set of ansible playbooks to provision a development machine in a few minutes.

# Usage
## Run from the sources directory
```bash
./provision.sh
```

## Run from the sources directory excluding provisioning graphical tools
```bash
SKIP_TAGS="graphical" ./provision.sh
```

### Run when 'provision.sh' is on the path
```bash
export SKIP_TAGS="graphical" && provision
```

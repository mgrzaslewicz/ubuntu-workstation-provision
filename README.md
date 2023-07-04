# dev-machine-provision
Set of ansible playbooks to provision a development machine in a few minutes.

Adjust it to your needs and run it with
```bash
./provision.sh
```

If you want to exclude provisioning graphical tools, run it with
```bash
SKIP_TAGS="graphical" ./provision.sh
```

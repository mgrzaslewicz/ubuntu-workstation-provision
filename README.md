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
## Example with vagrant
```
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "/full/path/to/dev-machine-provision/playbooks/provision.yml"
    #ansible.skip_tags = "graphical"
  end
  config.vm.network :forwarded_port, guest: 443, host: 443
  config.vm.provider "virtualbox" do |v|
    #v.gui = true
  end
end
```

#!/usr/bin/env bash
set -x
ansible-playbook -K \
--connection=local \
--inventory 127.0.0.1, \
--limit 127.0.0.1 playbooks/provision.yml

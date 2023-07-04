#!/usr/bin/env bash
set -x

SKIP_TAGS=${SKIP_TAGS:-"non-existing-tag"}

ansible-playbook -K \
--connection=local \
--inventory 127.0.0.1, \
--skip-tags "${SKIP_TAGS}" \
--limit 127.0.0.1 playbooks/provision.yml

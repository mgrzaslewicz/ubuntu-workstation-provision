#!/usr/bin/env bash
set -x

SKIP_TAGS=${SKIP_TAGS:-"non-existing-tag"}
TAGS=${TAGS:-"all"}

ansible-playbook -K \
--connection=local \
--inventory 127.0.0.1, \
--skip-tags "${SKIP_TAGS}" \
--tags "${TAGS}" \
--limit 127.0.0.1 playbooks/provision.yml

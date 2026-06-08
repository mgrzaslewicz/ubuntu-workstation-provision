#!/usr/bin/env bash
set -x
set -o pipefail

SKIP_TAGS_OPTION=""
if [[ -n $SKIP_TAGS ]]; then
  # Do not use var wrapped in quotes "${SKIP_TAGS}", it will cause error because of wrapping it with ''
  SKIP_TAGS_OPTION="--skip-tags ${SKIP_TAGS}"
fi

TAGS_OPTION=""
if [[ -n $TAGS ]]; then
  # Do not use var wrapped in quotes "${TAGS}", it will cause error because of wrapping it with ''
  TAGS_OPTION="--tags ${TAGS}"
fi

if ! command -v ansible-playbook &> /dev/null
then
  echo "Ansible is not installed, installing it now..."
  sudo apt-get update && sudo apt-get install -y ansible
fi

export ANSIBLE_BECOME_EXE=sudo.ws
export LOG_PATH="/tmp/provision_$(date +%Y%m%d_%H%M%S).log"

# Apply colors post grep. Uncolored output goes to the log file, colors applied afterwards in console output
# ok       -> light green
# changed  -> yellow
# failed   -> red
# fatal    -> purple/magenta
# skipping -> gray

ansible-playbook -K \
"$@" \
--connection=local \
--inventory 127.0.0.1, \
${SKIP_TAGS_OPTION} \
${TAGS_OPTION} \
--limit 127.0.0.1 playbooks/provision.yml \
-vvv 2>&1 \
  | tee "${LOG_PATH}" \
  | grep -E '^(PLAY|TASK|ok:|changed:|failed:|fatal:|skipping:)' \
  | sed -E \
      -e $'s/^(ok:.*)$/\033[92m\\1\033[0m/' \
      -e $'s/^(changed:.*)$/\033[93m\\1\033[0m/' \
      -e $'s/^(failed:.*)$/\033[91m\\1\033[0m/' \
      -e $'s/^(fatal:.*)$/\033[95m\\1\033[0m/' \
      -e $'s/^(skipping:.*)$/\033[90m\\1\033[0m/'

ANSIBLE_STATUS="${PIPESTATUS[0]}"

printf '\033[33mLog: %s\033[0m\n' "${LOG_PATH}"

if [[ $ANSIBLE_STATUS -ne 0 ]]; then
  vi +$ "${LOG_PATH}"
fi

exit "${ANSIBLE_STATUS}"

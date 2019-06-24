#!/bin/bash
inventory=${INVENTORY:-inventory}
ansible-playbook -i ${inventory} tasks/main.yml $@

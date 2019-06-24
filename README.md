[![Ansible Galaxy](https://img.shields.io/badge/Ansible%20Galaxy-Kubernetes-blue.svg)](https://galaxy.ansible.com/wluisaraujo/iac_ansible_kubernetes) [![Build Status](https://travis-ci.org/wluisaraujo/iac-ansible-kubernetes.svg?branch=master)](https://travis-ci.org/wluisaraujo/iac-ansible-kubernetes)

---
# IaC: with [Ansible](https://www.ansible) role to install and configure [Kubernetes](https://kubernetes.io/pt/)
------------

Description
------------

 *

Requirements
------------

 *

Role Variables
--------------

[defaults/main.yml](defaults/main.yml)

Dependencies
------------

* None

Example Playbook
----------------
```yaml
---
- hosts: localhost
  vars:
    - name: value
  roles:
    - iac-ansible-kubernetes
...    
```

----------------
[![Licence](https://img.shields.io/badge/License-GPL%20v3-red.svg)](https://www.gnu.org/licenses/gpl-3.0.pt-br.html)

Reference
----------------
[LinuxTips: Descomplicando o Kubernetes](https://www.linuxtips.io/blog/descomplicando-o-kubernetes-02)
[LinuxTips: Instalando e configurando um cluster Kubernetes](https://www.youtube.com/playlist?list=PLf-O3X2-mxDmXQU-mJVgeaSL7Rtejvv0S)
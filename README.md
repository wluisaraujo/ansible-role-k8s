[![Ansible Galaxy](https://img.shields.io/badge/Ansible%20Galaxy-Kubernetes-blue.svg)](https://galaxy.ansible.com/wluisaraujo/k8s) [![Build Status](https://travis-ci.org/wluisaraujo/ansible-role-k8s.svg?branch=master)](https://travis-ci.org/wluisaraujo/ansible-role-k8s)
---
# IaC: with [Ansible](https://www.ansible) role to install and configure [Kubernetes](https://kubernetes.io/pt/)
------------

Description
------------

 * Install cluster K8S

Requirements
------------

 * Kubernetes v1.15
 * Docker CE v18.09

Installation
------------

```console
vagrant@localhost:~$ ansible-galaxy install wluisaraujo.k8s
```

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
    - k8s
...
```

Reference
----------------
[LinuxTips: Descomplicando o Kubernetes](https://www.linuxtips.io/blog/descomplicando-o-kubernetes-02)

[LinuxTips: Instalando e configurando um cluster Kubernetes](https://www.youtube.com/playlist?list=PLf-O3X2-mxDmXQU-mJVgeaSL7Rtejvv0S)

[Kubernetes/docs](https://kubernetes.io/docs/home)

----------------
[![Licence](https://img.shields.io/badge/License-GPL%20v3-red.svg)](https://www.gnu.org/licenses/gpl-3.0.pt-br.html)
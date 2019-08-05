#!/usr/bin/env py.test
import pytest, testinfra
from glob import glob

# Packer validate
@pytest.mark.parametrize('filename', glob("packer/*.json"))
def test_packer_files(host, filename):
    assert host.run("packer validate -var-file=packer/variables.json.example " + filename ).rc == 0

# ansible-lint
@pytest.mark.parametrize('filename', glob("ansible/playbooks/*"))
def test_ansible_files(host, filename):
    assert host.run("ansible-lint -c ansible/ansible.cfg ansible " + filename ).rc == 0

# terraform validate & tflint
@pytest.mark.parametrize('env_name', ['stage', 'prod'])
def test_terraform_files(host, env_name):
    assert host.run('cd terraform/' + env_name + ' && terraform init --backend=false' ).rc == 0
    assert host.run('cd terraform/' + env_name + ' && terraform validate -var-file=terraform.tfvars.example -check-variables=false' ).stderr == ''
    assert host.run('cd terraform/' + env_name + ' && tflint --var-file=terraform.tfvars.example' ).stdout == 'Awesome! Your code is following the best practices :)\n'


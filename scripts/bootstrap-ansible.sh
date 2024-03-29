#!/bin/bash

set -euxo pipefail

cd "$(cd "$(dirname "$0")"; pwd -P)/../"

# Prepare APT dependencies
if [ -x "$(command -v apt-get)" ]; then
    export DEBIAN_FRONTEND="noninteractive"
    apt-get update
    apt-get dist-upgrade -y
    apt-get install -y ansible bzip2 ca-certificates curl flake8 gcc gnupg gzip iproute2 procps python3 python3-ansible-lint python3-apt python3-docker python3-flake8 python3-jmespath python3-lxml python3-netaddr python3-pip python3-pipx python3-setuptools python3-vagrant python3-venv python3-virtualenv python3-wheel python3-yamllint sudo tar unzip xz-utils zip
fi

# Prepare YUM dependencies
if [ -x "$(command -v yum)" ]; then
    yum makecache
    yum update -y
    yum install -y ansible bzip2 ca-certificates curl gcc gnupg2 gzip iproute procps-ng python3 python3-ansible-lint python3-dnf-plugin-versionlock python3-docker python3-flake8 python3-jmespath python3-libselinux python3-lxml python3-netaddr python3-pip python3-pipx python3-setuptools python3-vagrant python3-virtualenv python3-wheel python3-yamllint sudo tar unzip xz yum-utils zip
fi

# Prepare Zypper dependencies
if [ -x "$(command -v zypper)" ]; then
    zypper -n --gpg-auto-import-keys refresh
    zypper -n update -y
    zypper -n install -y bzip2 ca-certificates curl gcc gpg2 gzip iproute2 procps python3 python3-jmespath python3-lxml python3-pip python3-setuptools python3-virtualenv python3-wheel sudo tar unzip xz zip python3-pipx ansible python3-ansible-lint python3-docker python3-flake8 python3-netaddr python3-vagrant python3-yamllint
fi

# Install Ansible Collection dependencies
ansible-galaxy collection install --force --requirements-file ansible-galaxy-requirements.yml

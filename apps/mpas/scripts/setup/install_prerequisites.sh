#!/bin/bash

set -e

# Remove AWS temporary credentials
rm -vf $HOME/.aws/credentials

# Uninstall AWS CLI v1
echo "[INFO] Uninstalling AWS CLI version 1"

sudo rm -rf /usr/local/aws
sudo rm -rf /usr/local/bin/aws

# Install AWS CLI v2
echo "[INFO] Installing AWS CLI version 2"

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install Packer

PACKER_VERSION="1.6.4"
PACKER_VERSION_SHA256SUM="a20ec68e9eb6e1d6016481003f705babbecc28e234f8434f3a35f675cb200ea8"

echo "[INFO] Installing Packer"
curl -O https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
echo "${PACKER_VERSION_SHA256SUM}  packer_${PACKER_VERSION}_linux_amd64.zip" > checksum && sha256sum -c checksum
unzip packer_${PACKER_VERSION}_linux_amd64.zip
sudo unlink /usr/sbin/packer
sudo ln -s $PWD/packer /usr/sbin/packer


# Install Session Manager Plugin
echo "[INFO] Install Session Manager Plugin"
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm"
sudo yum install -y session-manager-plugin.rpm


# Install jq
echo "[INFO] Install qj"
sudo yum install -y jq
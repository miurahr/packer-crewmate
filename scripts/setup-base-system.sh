#! /bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y install \
  openssh-server \
  build-essential \
  curl \
  unzip \
  git-core \
  gcc \
  g++ \
  make

mkdir -p /root/.ssh /var/run/sshd
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
echo 'root:root' | chpasswd

useradd -m -s /bin/bash crewmate 
echo 'crewmate:crewmate' | chpasswd
echo 'crewmate ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/crewmate


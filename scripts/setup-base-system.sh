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

apt-get -y install \
  ruby ruby-dev irb libmysqlclient15-dev sqlite3 libsqlite3-dev \
  libcurl4-openssl-dev libopenssl-ruby libpcre3-dev libxml2-dev libxslt-dev \
  libreadline5-dev imagemagick libpq-dev \
  libmysql-ruby libmysqlclient-dev

mkdir -p /root/.ssh /var/run/sshd
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
echo 'root:root' | chpasswd

useradd -m -s /bin/bash crewmate 
echo 'crewmate:crewmate' | chpasswd
echo 'crewmate ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/crewmate


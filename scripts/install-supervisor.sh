#! /bin/bash
set -e

apt-get -y install supervisor
 
# add supervisor config file
mkdir -p /var/log/supervisor /etc/supervisor/conf.d

install /tmp/supervisor/sshd.conf /etc/supervisor/conf.d/
install /tmp/supervisor/crewmate.conf /etc/supervisor/conf.d/
install -d /usr/local/bin/
install -m 755 /tmp/supervisor/runner.sh /usr/local/bin/runner

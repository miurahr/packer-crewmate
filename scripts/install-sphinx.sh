#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get install -y unixodbc libodbc1 odbcinst1debian2 odbcinst
cd /tmp
wget http://sphinxsearch.com/files/sphinxsearch_2.2.8-release-0ubuntu12~trusty_amd64.deb
dpkg -i sphinxsearch_2.2.8-release-0ubuntu12~trusty_amd64.deb
rm /tmp/sphinxsearch_*deb
apt-get clean

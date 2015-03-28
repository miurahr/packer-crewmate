#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get -y install \
  acl libmysqlclient15-dev sqlite3 libsqlite3-dev \
  libcurl4-openssl-dev libpcre3-dev libxml2-dev libxslt-dev \
  imagemagick libpq-dev libmysqlclient-dev libreadline-gplv2-dev

source /etc/profile.d/rbenv.sh

gem update --system
gem install bundler pg rails thin --no-rdoc --no-ri

# install crewmate
git clone https://github.com/crewmate/crewmate.git /srv/crewmate
cd /srv/crewmate
if [ -e /srv/crewmate/.ruby-version ]; then
  rm -f /srv/crewmate/.ruby-version
fi
gem install debugger
bundle install

install /tmp/crewmate/crewmate.yml config/
install /tmp/crewmate/database.yml config/

# setup directories
install -d /srv/crewmate/db

# add permissions
setfacl -m user:crewmate:rwx /srv/crewmate/log
setfacl -m user:crewmate:rwx /srv/crewmate/db

# create development database
bundle exec rake db:create db:schema:load RAILS_ENV=development

# setup startup scripts
install -d /srv/crewmate/bin
install -m 755 /tmp/supervisor/crewmate.sh /srv/crewmate/bin/


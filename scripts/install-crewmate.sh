#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

apt-get -y install \
  imagemagick libpq5 sqlite3 libmysqlclient18 \
  libcurl3 libcurl3-nss libpcre3 libxml2 libxslt1.1 \
  libreadline5 \
  libmysqlclient-dev libsqlite3-dev libpq-dev \
  libcurl4-openssl-dev libpcre3-dev libxml2-dev libxslt-dev \
  libreadline-gplv2-dev

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
install -d -o crewmate -g crewmate /srv/crewmate/db
chmod 777 /srv/crewmate/log

# setup startup scripts
install -d /srv/crewmate/bin
install -m 755 /tmp/supervisor/crewmate.sh /srv/crewmate/bin/

# cleanup dev files
apt-get -y remove \
  libmysqlclient-dev libsqlite3-dev libpq-dev \
  libcurl4-openssl-dev libpcre3-dev libxml2-dev libxslt-dev \
  libreadline-gplv2-dev
apt-get -y autoremove
apt-get clean

# create development database
sudo -u crewmate -i -E /bin/bash -c \
  "source /etc/profile.d/rbenv.sh; bundle exec rake db:create db:schema:load RAILS_ENV=development"

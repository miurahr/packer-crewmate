#!/bin/bash
set -e

git clone https://github.com/sstephenson/rbenv.git /opt/rbenv

# Add rbenv to the path:
echo '# rbenv setup' > /etc/profile.d/rbenv.sh
echo 'export RBENV_ROOT=/opt/rbenv' >> /etc/profile.d/rbenv.sh
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

chmod +x /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh

# Install ruby-build:
pushd /tmp
  git clone git://github.com/sstephenson/ruby-build.git
  cd ruby-build
  ./install.sh
popd

# install ruby
rbenv install 1.9.3-p551
rbenv global 1.9.3-p551

gem update --system
gem install bundler pg rails thin --no-rdoc --no-ri

# install crewmate
git clone https://github.com/crewmate/crewmate.git /srv/crewmate
cd /srv/crewmate
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


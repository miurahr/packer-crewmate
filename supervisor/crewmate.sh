#!/bin/sh
if [ "$RAILS_ENV" == "" ]; then
  RAILS_ENV=development
fi

source /etc/profile.d/ruby.sh
rails server -e ${RAILS_ENV}

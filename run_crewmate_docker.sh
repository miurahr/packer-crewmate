#!/bin/sh

DOCKERHUB_REPO=miurahr/crewmate
RUNNER=/usr/local/bin/runner
RUNDIR=/run/docker
CREWMATE_PID=$RUNDIR/crewmate.pid

# user should be in 'docker' group
# to run docker without sudo

if [ ! -d $RUNDIR ]; then
  sudo mkdir $RUNDIR
  sudo chgrp docker $RUNDIR
fi

docker run -d -p 22 -p 3000 -e "RAILS_ENV=development" \
  -e "CREWMATE_DB_SERVER=dbserver" -e "CREWMATE_DB_USER=postgres" \
  -e "CREWMATE_DB_PASS=pass"
  $DOCKERHUB_REPO $RUNNER

DPID=`sudo docker ps -q -l`
echo $DPID > $CREWMATE_PID

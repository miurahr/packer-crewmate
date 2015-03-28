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

docker run -d -p 22 -p 8080 -e \
  -e "CREWMATE_DB_SERVER=dbserver" \
  $DOCKERHUB_REPO $RUNNER

DPID=`sudo docker ps -q -l`
echo $DPID > $CREWMATE_PID

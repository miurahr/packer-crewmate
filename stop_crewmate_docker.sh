#!/bin/bash

RUNDIR=/run/docker
CREWMATE_PID=$RUNDIR/crewmate.pid

docker stop `cat $CREWMATE_PID`

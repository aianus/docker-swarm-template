#!/bin/bash

docker-compose stop
docker-compose rm -f

seq 1 $CLUSTER_SIZE | \
awk '{ print "scrape-swarm-worker-" $1 }' | \
xargs -n 1 -P $EC2_PARALLELISM \
  docker-machine rm -y

docker-machine rm -y scrape-swarm-master

#!/bin/bash

docker-machine create \
        -d "$DOCKER_MACHINE_DRIVER" \
        --swarm \
        --swarm-master \
        --swarm-discovery token://$SWARM_TOKEN \
        scrape-swarm-master

seq 1 $CLUSTER_SIZE | \
awk '{ print "scrape-swarm-worker-" $1 }' | \
xargs -n 1 -P $LAUNCH_PARALLELISM \
  docker-machine create \
        -d "$DOCKER_MACHINE_DRIVER" \
        --swarm \
        --swarm-discovery token://$SWARM_TOKEN

eval $(docker-machine env --swarm scrape-swarm-master)

docker-compose pull
docker-compose build
docker-compose up -d
docker-compose scale worker=$CLUSTER_SIZE

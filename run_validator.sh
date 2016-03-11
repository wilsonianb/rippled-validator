#!/bin/bash

docker rm rippled-data
docker rm rippled-config
docker stop rippled-validator
docker rm rippled-validator
docker stop watchtower
docker rm watchtower

# Create config and data volume containers
docker create -v /etc/opt/ripple --name rippled-config centos:latest
docker create -v /var/lib/rippled --name rippled-data centos:latest

# Build and run local rippled-validator image
docker run \
  --name rippled-validator -d\
  --net=host \
  --volumes-from rippled-config --volumes-from rippled-data \
  bwilsonripple/rippled-validator:nightly

# Run watchtower to auto-update validator
docker run \
  --name watchtower -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  centurylink/watchtower --cleanup rippled-validator

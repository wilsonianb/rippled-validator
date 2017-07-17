#!/bin/bash

docker stop rippled-validator
docker rm rippled-validator


# Run tests with rippled-validator image
docker run \
  --name rippled-validator \
  bwilsonripple/rippled-validator /opt/ripple/bin/rippled --unittest


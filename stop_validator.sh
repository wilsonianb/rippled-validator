#!/bin/bash

docker rm rippled-data
docker rm rippled-config
docker stop rippled-validator
docker rm rippled-validator
docker stop watchtower
docker rm watchtower

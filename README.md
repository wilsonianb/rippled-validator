# Ripple Validator

Docker image for running an auto-updating rippled validator.

[Watchtower](https://github.com/CenturyLinkLabs/watchtower) detects changes to the `local/rippled-validator` docker image and will automatically update and restart the validator.

## Dependencies

- [docker](https://docs.docker.com/engine/installation/)

## Build && Run

```
./run_validator.sh
```

## Submit commands to rippled

```
docker exec rippled-validator /opt/ripple/bin/rippled <command>
```

## Run rippled tests

```
docker run local/rippled-validator /opt/ripple/bin/rippled --unittest
docker run --workdir /opt/ripple/rippled local/rippled-validator npm test
```

## Update rippled

Modifying the Dockerfile and rebuilding the image will prompt watchtower to update and and restart the validator container.

How to rebuild image:

```
docker build -t local/rippled-validator .
```

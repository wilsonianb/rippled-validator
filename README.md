# Ripple Validator

Docker image for running an auto-updating rippled validator.

[Watchtower](https://github.com/CenturyLinkLabs/watchtower) detects changes to the `local/rippled-validator` docker image and will automatically update and restart the validator.

## Dependencies

- [docker](https://docs.docker.com/engine/installation/)

## Run

```
./run_validator.sh
```

## Submit commands to rippled

```
docker exec rippled-validator /opt/ripple/bin/rippled <command>
```

## Update rippled

Change `ripple-stable` to `ripple-nightly` in the Dockerfile.

Then run:

```
docker build -t local/rippled-validator .
```

The validator will updated to the latest nightly build.

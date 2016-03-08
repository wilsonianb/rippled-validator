# Ripple Validator Docker

Docker image for running a rippled validator

## Dependencies

- docker

## Build

```
docker build -t rippled-validator .
```

## Create config and data volume containers

```
docker create -v /etc/opt/ripple --name rippled-config centos:latest
docker create -v /var/lib/rippled --name rippled-data centos:latest
```

## Run

```
docker run --name rippled-validator -d -p 127.0.0.1:51235:51235 -p 127.0.0.1:6006:6006 --volumes-from rippled-config --volumes-from rippled-data rippled-validator
```

## Run watchtower to auto-update rippled-validator container

```
docker run -d \
  --name watchtower \
  -v /var/run/docker.sock:/var/run/docker.sock \
  centurylink/watchtower rippled-validator --cleanup
```

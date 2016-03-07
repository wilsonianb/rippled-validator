# Ripple Validator Docker

Docker image for running a rippled validator

## Dependencies

- docker

## Build

```
docker build -t ripple-validator .
```

## Run

```
docker run -p 127.0.0.1:51235:51235 -p 127.0.0.1:6006:6006 ripple-validator
```
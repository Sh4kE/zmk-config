#!/usr/bin/env bash

docker rm zmk
docker run -it --name zmk zmk
docker cp zmk:/app/firmware/ ./
docker stop zmk
docker rm zmk

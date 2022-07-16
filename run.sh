#!/usr/bin/env bash

./setup.sh
mkdir -p firmware/old/
mv firmware/*.uf2 firmware/old/

docker rm zmk
docker run -it --name zmk zmk
docker cp zmk:/app/firmware/ ./
docker stop zmk
docker rm zmk

rsync -aHv --delete firmware ~/Nextcloud/zmk/firmware/

#!/usr/bin/env bash

set -e

PWD=$(pwd)

for s in sofle cradio scylla; do
    rm -rf build/*
    # West Build (left)
    west build -s zmk/app -b nice_nano_v2 -- -DZMK_CONFIG="${PWD}/config" -DSHIELD="${s}_left"
    # ${s} Left Kconfig file
    cat build/zephyr/.config | grep -v "^#" | grep -v "^$"
    cp build/zephyr/zmk.uf2 "firmware/${s}_left-nice_nano_v2-zmk.uf2"

    rm -rf build/*
    # West Build (right)
    west build -s zmk/app -b nice_nano_v2 -- -DZMK_CONFIG="${PWD}/config" -DSHIELD="${s}_right"
    # ${s} right Kconfig file
    cat build/zephyr/.config | grep -v "^#" | grep -v "^$"
    cp build/zephyr/zmk.uf2 "firmware/${s}_right-nice_nano_v2-zmk.uf2"
done

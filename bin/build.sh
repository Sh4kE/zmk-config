#!/usr/bin/env bash

set -e

PWD=$(pwd)

# West Build (left)
west build -s zmk/app -b nice_nano_v2 -- -DZMK_CONFIG=${PWD}/config -DSHIELD=sofle_left
# sofle Left Kconfig file
cat build/zephyr/.config | grep -v "^#" | grep -v "^$"
cp build/zephyr/zmk.uf2 "firmware/sofle_left-nice_nano_v2-zmk.uf2"

# West Build (right)
west build -s zmk/app -b nice_nano_v2 -- -DZMK_CONFIG=${PWD}/config -DSHIELD=sofle_right
# sofle right Kconfig file
cat build/zephyr/.config | grep -v "^#" | grep -v "^$"
cp build/zephyr/zmk.uf2 "firmware/sofle_right-nice_nano_v2-zmk.uf2"


# West Build (left)
west build -s zmk/app -b nice_nano_v2 -- -DZMK_CONFIG=${PWD}/config -DSHIELD=cradio_left
# cradio Left Kconfig file
cat build/zephyr/.config | grep -v "^#" | grep -v "^$"
cp build/zephyr/zmk.uf2 "firmware/cradio_left-nice_nano_v2-zmk.uf2"

# West Build (right)
west build -s zmk/app -b nice_nano_v2 -- -DZMK_CONFIG=${PWD}/config -DSHIELD=cradio_right
# cradio right Kconfig file
cat build/zephyr/.config | grep -v "^#" | grep -v "^$"
cp build/zephyr/zmk.uf2 "firmware/cradio_right-nice_nano_v2-zmk.uf2"

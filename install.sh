#!/usr/bin/bash

set -euo pipefail

echo 'Please select keyboard to flash'
read -p "(1) sofle (2) cradio (3) scylla :" -n 1 -r
if [[ $REPLY = 1 ]]; then
    keyboard="sofle"
    echo ""
elif [[ $REPLY = 2 ]]; then
    keyboard="cradio"
    echo ""
elif [[ $REPLY = 3 ]]; then
    keyboard="scylla"
    echo ""
else
    echo -e "\nunknown selection"
    exit 1
fi

dir="firmware/"
files=$(ls "${dir}")
for f in ${files}
do
    if [[ $f =~ ^${keyboard} ]]; then
        echo ""
        read -p "is the Keyboard >> $f << ready for flashing? press (y) to continue" -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            dev=$(lsblk |grep -E "32[,.]1M" |awk '{print $1}')
            mount "/dev/${dev}" /mnt
            cp "${dir}$f" /mnt/
            sleep 15
            umount "/dev/${dev}"
        fi
    fi
done

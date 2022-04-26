#!/usr/bin/bash

set -xeuo pipefail
sudo_home=$(getent passwd "$SUDO_USER" | awk -F":" '{print $6}')

echo "to download the latest build: gh run download -n firmware -D ${sudo_home}/Nextcloud/zmk"

echo 'Please select keyboard to flash'
read -p "(1) sofle (2) cradio :" -n 1 -r
if [[ $REPLY = 1 ]]; then
    keyboard="sofle"
    echo ""
elif [[ $REPLY = 2 ]]; then
    keyboard="cradio"
    echo ""
else
    echo -e "\nunknown selection"
    exit 1
fi

files=$(ls "${sudo_home}/Nextcloud/zmk/")
for f in ${files}
do
    if [[ $f =~ ^${keyboard} ]]; then
        echo ""
        read -p "is the Keyboard >> $f << ready for flashing?" -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            dev=$(lsblk |grep 32,1M |awk '{print $1}')
            mount "/dev/${dev}" /mnt
            cp "$f" /mnt/
            sleep 1
            umount "/dev/${dev}"
        fi
    fi
done

#!/bin/bash

set -e
set -u

if [ ! -d vigimage ]
then
 exit 1
fi

echo "Updating image"

cp /usr/bin/qemu-arm-static vigimage/usr/bin

touch vigimage/boot/ssh
wget https://www.vigibot.com/vigimage/wpa_supplicant.conf -P vigimage/etc/wpa_supplicant -N

wget https://www.vigibot.com/vigiclient/install.sh -P vigimage/tmp -N

cat << EOF | chroot vigimage
apt update
apt upgrade -y
chmod +x /tmp/install.sh
/tmp/install.sh
rm /tmp/install.sh
EOF

#!/usr/bin/bash

if [[ $EUID > 0 ]]
then
    echo "Please run as root"
    exit
fi

# Make 1GB of swap
dd if=/dev/zero bs=1M count=1024 of=/mnt/1GiB.swap
chmod 600 /mnt/1GiB.swap
mkswap /mnt/1GiB.swap
swapon /mnt/1GiB.swap
cat /proc/swaps
echo '/mnt/1GiB.swap swap swap defaults 0 0' | sudo tee -a /etc/fstab

# Go to a temporary directory
mkdir /tmp/kasm-install
cd /tmp/kasm-install

# Install kasm
wget https://kasm-static-content.s3.amazonaws.com/kasm_release_1.15.0.06fdc8.tar.gz
tar -xf kasm_release*.tar.gz
bash kasm_release/install.sh

# Remove temp directory
cd ~/
rm -rf /tmp/kasm-install

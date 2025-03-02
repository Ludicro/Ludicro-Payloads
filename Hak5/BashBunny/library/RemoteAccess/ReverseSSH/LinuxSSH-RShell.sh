#!/bin/bash
S="$0"
H=$1
P=$2


# Check if SSH client is installed
if ! command -v ssh &> /dev/null; then
    apt-get update && apt-get install -y openssh-client
fi

# Start SSH reverse tunnel in background
ssh -f -N -R ${P}:localhost:22 ${H}

# Remove script
rm -f "$S"
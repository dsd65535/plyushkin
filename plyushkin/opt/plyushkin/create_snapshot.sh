#!/bin/bash

set -xe

if [[ -z "${FS_NAME}" ]]; then
    echo "FS_NAME not defined"
    exit 1
fi

sudo zfs snapshot -r ${FS_NAME}@$(date +%s)

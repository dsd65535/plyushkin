#!/bin/bash

set -xe

if [[ -z "${PL_SETUP}" ]]; then
    echo "PL_SETUP not defined"
    exit 1
fi

TARGET=${PL_SETUP%:*}
FS_NAME=${PL_SETUP#*:}

if [[ -z "${TARGET}" ]]; then
    echo "TARGET not defined"
    exit 1
fi

if [[ -z "${FS_NAME}" ]]; then
    echo "FS_NAME not defined"
    exit 1
fi

sudo zfs snapshot -r ${FS_NAME}@$(date +%s)

#!/bin/bash

set -xe

if [[ -z "${FS_NAME}" ]]; then
    echo "FS_NAME not defined"
    exit 1
fi

if [[ -z "${TARGET}" ]]; then
    echo "TARGET not defined"
    exit 1
fi

logfile="/var/opt/plyushkin/${TARGET}_$(echo ${FS_NAME} | tr / _)"
echo ${logfile}

new_snapshot=$(zfs list -t snapshot -o name -s creation ${FS_NAME} | tail -n1)

if [ -f ${logfile} ]; then
    old_snapshot=$(tail -n1 ${logfile})
    sudo zfs send -RI ${old_snapshot} ${new_snapshot} | ssh ${TARGET} sudo zfs recv ${FS_NAME}
else
    sudo zfs send -R ${new_snapshot} | ssh ${TARGET} sudo zfs recv -o readonly=on ${FS_NAME}
fi

mkdir -p $(dirname ${logfile})
echo ${new_snapshot} >> ${logfile}

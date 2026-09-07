#!/bin/bash

# Get the absolute path to the AZ3166 directory
# TODO to validate ${1} as target dir
SAMPLEX_TARGET_DIR=${1:-/Volumes/AZ3166}

if [ ! -d "${SAMPLEX_TARGET_DIR}" ]; then
    echo "[ERROR] Destination ${SAMPLEX_TARGET_DIR} does not exist!"
    exit 1
else
    echo "[INFO] Target is ${SAMPLEX_TARGET_DIR}"
fi

# Get the absolute path to the build directory
SAMPLEX_BUILD_DIR="$PWD/build"
# TODO this might be improved for error handling
SAMPLEX_BINARY=$(ls ${SAMPLEX_BUILD_DIR}/app/*.bin)

if [ -f "${SAMPLEX_BINARY}" ]; then
    echo "[INFO] Copying ${SAMPLEX_BINARY} to ${SAMPLEX_TARGET_DIR}..."
    cp "${SAMPLEX_BINARY}" "${SAMPLEX_TARGET_DIR}"
    echo "[ OK ] Deployment successful!"
else
    echo "[ERROR] No binary found in ${SAMPLEX_BUILD_DIR}/app/*.bin"
    exit 1
fi

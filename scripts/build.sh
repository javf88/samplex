#!/bin/bash

SAMPLEX_BUILD_DIR="$PWD/build"
# TODO To manage from cmake
SAMPLEX_CONFIG=${1:-starter}
if command -v ninja > /dev/null ; then
    SAMPLEX_CMAKE_GENERATOR="-G Ninja"
else
    SAMPLEX_CMAKE_GENERATOR=
fi

# TODO To manage from cmake
if command -v nproc > /dev/null ; then
    SAMPLEX_NUM_JOBS=$(nproc)
else
    SAMPLEX_NUM_JOBS=$(sysctl -n hw.ncpu)
fi

echo "=========================================="
echo "IoT DevKit - Build Script"
echo "=========================================="
echo "Build Dir: ${SAMPLEX_BUILD_DIR}"
echo "Generator: ${SAMPLEX_CMAKE_GENERATOR}"
echo "Config: ${SAMPLEX_CONFIG}"
echo "Parallel Jobs: ${SAMPLEX_NUM_JOBS}"
echo ""

# Parse arguments for clean
if [ -d "${SAMPLEX_BUILD_DIR}" ]; then
    echo "[INFO] Cleaning build directory..."
    rm -rf "${SAMPLEX_BUILD_DIR}"
    echo "[ OK ] Build directory cleaned"
    echo ""
fi

# Create build directory if it doesn't exist
if [ ! -d "${SAMPLEX_BUILD_DIR}" ]; then
    echo "[INFO] Creating build directory..."
    mkdir "${SAMPLEX_BUILD_DIR}"
    echo "[INFO] Configuring CMake..."
    cmake ${SAMPLEX_CMAKE_GENERATOR} \
        "-DCMAKE_BUILD_TYPE=Release" \
        "-DAPP_CONFIG=${SAMPLEX_CONFIG}" \
        "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" \
        -B build
    echo "[ OK ] CMake configured"
    echo ""

    # Build with parallel jobs
    echo "[INFO] Building with ${SAMPLEX_NUM_JOBS} parallel jobs..."
    START_TIME=$(date +%s)

    cmake --build build --parallel ${SAMPLEX_NUM_JOBS} --config Release

    END_TIME=$(date +%s)
    BUILD_TIME=$((END_TIME - START_TIME))
fi

echo "=========================================="
echo "[ OK ] Build completed successfully!"
echo "Build time: ${BUILD_TIME}s"
echo "=========================================="

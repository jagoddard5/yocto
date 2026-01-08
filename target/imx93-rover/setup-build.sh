#!/bin/bash

# Environmental variables
export BUILD_DIR=${PWD}/build
export REPO_SYNC_FILE=${BUILD_DIR}/.repo-synced
export ENV_SETUP_FILE=${BUILD_DIR}/.env_setup
export BUILD_CONFIG=build-rover
export CONFIG_DIR=${BUILD_DIR}/${BUILD_CONFIG}
export YOCTO_DIR=${BUILD_DIR}/${BUILD_CONFIG}/conf
export YOCTO_DROPIN_DIR=${PWD}/yocto-dropin

# Create build directory if it doesn't exist
mkdir -p ${BUILD_DIR} 
pushd ${BUILD_DIR}

# Initialize and sync 
if [ ! -f ${REPO_SYNC_FILE} ]; then
repo init -u https://github.com/varigit/variscite-bsp-platform -b scarthgap -m imx-6.6.52-2.2.0.xml
repo sync -j$(nproc)    
touch ${REPO_SYNC_FILE}
fi

# Setup the build environment
if [ ! -f ${ENV_SETUP_FILE} ]; then
mkdir -p ${BUILD_CONFIG}
MACHINE=imx93-var-som DISTRO=fsl-imx-wayland . var-setup-release.sh ${BUILD_CONFIG}
touch ${ENV_SETUP_FILE}
fi

# Copy the yocto drop-in configuration files
cp -r ${YOCTO_DROPIN_DIR}/* ${YOCTO_DIR}/

# Build the image inside Docker container
./sources/var-host-docker-containers/run.sh  -u 22.04 -w "$(pwd)" -p \
   --command "source setup-environment build-rover && bitbake fsl-image-gui"

popd
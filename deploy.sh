#!/bin/bash

set -e

source './.env';


if [ -z "$AURORA_SDK_PATH" ]; then
    echo 'No `AURORA_SDK_PATH` variable is set.';
    exit 1;
fi

if [ -z "$BUILD_TARGET" ]; then
    echo 'No `BUILD_TARGET` variable is set.';
    exit 1;
fi

if [ -z "$DEPLOY_DEVICE" ]; then
    echo 'No `DEPLOY_DEVICE` variable is set.';
    exit 1;
fi


SFDK_PATH="$AURORA_SDK_PATH/bin/sfdk";
CURRENT_DIR="$(pwd)";

cargo build --release

cp ./target/release/simple_slint_aurora ./com.lmaxyz.SlintAuroraExample

$SFDK_PATH config target="$BUILD_TARGET"
$SFDK_PATH config device="$DEPLOY_DEVICE"

$SFDK_PATH build
$SFDK_PATH engine exec -tt sb2 -t $BUILD_TARGET rpmsign-external sign -k $CURRENT_DIR/../.auroraos-regular-keys/regular_key.pem -c $CURRENT_DIR/../.auroraos-regular-keys/regular_cert.pem $CURRENT_DIR/RPMS/com.lmaxyz.SlintAuroraExample-0.1-1.x86_64.rpm

set +e

$SFDK_PATH deploy --manual
ssh -p 2223 -i $AURORA_SDK_PATH/vmshare/ssh/private_keys/sdk root@127.0.0.1 "pkcon -y remove com.lmaxyz.SlintAuroraExample; pkcon install-local -y /home/defaultuser/RPMS/com.lmaxyz.SlintAuroraExample-0.1-1.x86_64.rpm"

rm ./com.lmaxyz.SlintAuroraExample

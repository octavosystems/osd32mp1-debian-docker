#! /bin/bash
set -e

[ $# -eq 0 ] && set -- all

export USER=$(whoami)
export BUILD_ROOT=/home/docker/octavo-build
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-

mkdir -p $BUILD_ROOT
cd $BUILD_ROOT

exec bash


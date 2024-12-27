#!/bin/bash

# Build waypoint image in the x86 env:
# ARCH=x86 bash build.sh
#
# Build waypoint image in the arm env:
# ARCH=arm bash build.sh

REPO=${1:-"kmesh-net"}

# Build Envoy
BUILD_WITH_CONTAINER=1 make build_envoy

docker create --name temp -v cache:/home/.cache busybox

if [ "$ARCH" = "arm" ]; then
	docker cp temp:/home/.cache/bazel/_bazel_root/1e0bb3bee2d09d2e4ad3523530d3b40c/execroot/io_istio_proxy/bazel-out/aarch64-opt/bin/envoy .
else
	docker cp temp:/home/.cache/bazel/_bazel_root/1e0bb3bee2d09d2e4ad3523530d3b40c/execroot/io_istio_proxy/bazel-out/k8-opt/bin/envoy .
fi

docker rm temp

if [ "$ARCH" = "arm" ]; then
	docker build . --no-cache -t ghcr.io/$REPO/waypoint-arm:latest
elif [ "$ARCH" = "x86" ]; then
	docker build . --no-cache -t ghcr.io/$REPO/waypoint-x86:latest
else
	docker build . --no-cache -t ghcr.io/$REPO/waypoint:latest
fi

rm envoy

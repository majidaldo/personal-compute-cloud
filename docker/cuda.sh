#!/bin/sh
set -e

tag=${1:-master}

cd nvidia
git checkout $tag
cd ..

docker build -t cuda nvidia/
docker run --privileged --rm cuda


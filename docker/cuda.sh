#!/bin/sh
docker build -t cuda nvidia
docker run --privileged --rm cuda


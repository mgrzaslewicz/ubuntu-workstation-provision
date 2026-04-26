#!/bin/bash
docker run --rm -v "$(pwd):/uwp" -w /uwp ubuntu:26.04 ./provision.sh

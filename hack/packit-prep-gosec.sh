#!/bin/bash

set -e

[[ ! -d tmp ]] && mkdir tmp
cp gosec.spec tmp/

echo "Downloading gosec source tarball"
version="$(sed -n "s/^%global gosec_version //p" gosec.spec)"
curl -SL -o "tmp/gosec-${version}.tar.gz" "https://github.com/securego/gosec/archive/refs/tags/v${version}.tar.gz"

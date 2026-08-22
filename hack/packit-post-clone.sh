#!/bin/bash

set -e

[[ ! -d tmp ]] && mkdir tmp
cp golang.spec tmp/

echo "Downloading golang source tarball"
version="$(sed -n "s/^%global go_version //p" golang.spec)"
curl -SL -o "tmp/go${version}.src.tar.gz" "https://go.dev/dl/go${version}.src.tar.gz"

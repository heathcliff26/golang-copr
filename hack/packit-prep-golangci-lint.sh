#!/bin/bash

set -e

[[ ! -d tmp ]] && mkdir tmp
cp golangci-lint.spec tmp/

echo "Downloading golangci-lint source tarball"
version="$(sed -n "s/^%global gocilint_version //p" golangci-lint.spec)"
curl -SL -o "tmp/golangci-lint-${version}.tar.gz" "https://github.com/golangci/golangci-lint/archive/refs/tags/v${version}.tar.gz"

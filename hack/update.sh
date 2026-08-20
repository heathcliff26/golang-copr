#!/bin/bash

set -euo pipefail

version=$(curl --fail --silent --show-error https://go.dev/dl/?mode=json \
    | sed -n 's/.*"version": "go\([0-9][0-9.]*\)".*/\1/p' \
    | head -n1)

if [[ -z ${version} ]]; then
    echo "Could not determine the latest stable Go version" >&2
    exit 1
fi

sed -i -E "s/^%global go_version .*/%global go_version ${version}/" golang.spec
echo "Updated golang.spec to Go ${version}"

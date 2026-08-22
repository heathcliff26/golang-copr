#!/bin/bash

set -euo pipefail

spec_file=golang.spec

version=$(curl --fail --silent --show-error https://go.dev/dl/?mode=json \
    | sed -n 's/.*"version": "go\([0-9][0-9.]*\)".*/\1/p' \
    | head -n1)

if [[ -z ${version} ]]; then
    echo "Could not determine the latest stable version" >&2
    exit 1
fi

version_old="$(sed -n "s/^%global go_version //p" "${spec_file}")"
if [[ "${version_old}" == "${version}" ]]; then
    echo "Already up-to-date"
    exit 0
fi

sed -i -E "s/^%global go_version .*/%global go_version ${version}/" "${spec_file}"
sed -i -E "s/^%global go_release .*/%global go_release 1/" "${spec_file}"
echo "Updated ${spec_file} to ${version}"

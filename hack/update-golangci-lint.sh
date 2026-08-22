#!/bin/bash

set -euo pipefail

spec_file=golangci-lint.spec

version="$(curl --silent "https://api.github.com/repos/golangci/golangci-lint/tags?per_page=20" | jq -r ".[0].name")"
version="${version#v}"

if [[ -z ${version} ]]; then
    echo "Could not determine the latest stable version" >&2
    exit 1
fi

version_old="$(sed -n "s/^%global gocilint_version //p" "${spec_file}")"
if [[ "${version_old}" == "${version}" ]]; then
    echo "Already up-to-date"
    exit 0
fi

sed -i -E "s/^%global gocilint_version .*/%global gocilint_version ${version}/" "${spec_file}"
sed -i -E "s/^%global gocilint_release .*/%global gocilint_release 1/" "${spec_file}"
echo "Updated ${spec_file} to ${version}"

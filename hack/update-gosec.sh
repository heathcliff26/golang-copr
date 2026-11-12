#!/bin/bash

set -euo pipefail

spec_file=gosec.spec

version="$(curl -fsSL --show-error "https://api.github.com/repos/securego/gosec/tags?per_page=20" | jq -r ".[0].name")"
version="${version#v}"

if [[ -z ${version} ]]; then
    echo "Could not determine the latest stable version" >&2
    exit 1
fi

version_old="$(sed -n "s/^%global gosec_version //p" "${spec_file}")"
if [[ "${version_old}" == "${version}" ]]; then
    echo "Already up-to-date"
    exit 0
fi

sed -i -E "s/^%global gosec_version .*/%global gosec_version ${version}/" "${spec_file}"
sed -i -E "s/^%global gosec_release .*/%global gosec_release 1/" "${spec_file}"
echo "Updated ${spec_file} to ${version}"

#!/bin/bash

set -ex

base_dir="$(dirname "${BASH_SOURCE[0]}" | xargs realpath | xargs dirname)"

pkg="$1"

if [ -z "$pkg" ]; then
    echo "Usage: $0 <package>"
    exit 1
fi

pushd "${base_dir}" > /dev/null

case "${pkg}" in
    golang)
        version="$(sed -n "s/^%global go_version //p" golang.spec)"
        release="$(sed -n "s/^%global go_release //p" golang.spec)"
        ;;
    golangci-lint)
        version="$(sed -n "s/^%global gocilint_version //p" golangci-lint.spec)"
        release="$(sed -n "s/^%global gocilint_release //p" golangci-lint.spec)"
        ;;
    *)
        echo "Unknown package: ${pkg}"
        exit 1
        ;;
esac

tag="${pkg}-${version}-${release}"

if git tag -l | grep -q "^${tag}$"; then
    echo "Tag already exists for ${pkg}"
    exit 0
fi

git tag "${tag}"
git push origin "${tag}"

popd > /dev/null

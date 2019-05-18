!# /usr/bin/env bash

if [[ -z "${TRAVIS}" ]]; then
    swiftformat .
fi

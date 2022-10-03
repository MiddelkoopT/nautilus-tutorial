#!/bin/bash

: ${SECRETS:=~/.secrets/nautilus}

echo "=== s3-list.sh"

for I in ${SECRETS}/s3cfg-* ; do
    echo "--- $(basename $I)"
    s3cmd --config=$I la
done
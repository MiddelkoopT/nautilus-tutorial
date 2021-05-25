#!/bin/bash

. ./environment.sh

# `envsubst` replaces envrionment variables with their values.
cat home/home.yaml | PROJECT=$(basename $PWD) envsubst | kubectl apply -f -

while [ $(kubectl get pod/home  -o template --template={{.status.phase}}) != "Running" ] ; do
    kubectl describe pod home
    echo "Waiting for pod/home: $(date)"
    sleep 5
done

scripts/setup-debian.sh

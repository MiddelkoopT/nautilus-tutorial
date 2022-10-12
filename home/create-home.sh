#!/bin/bash

# `envsubst` replaces envrionment variables with their values.
export PROJECT=nautilus-tutorial
cat container/home-template.yaml | envsubst | kubectl apply -f -

while [ $(kubectl get pod/home -o template --template={{.status.phase}}) != "Running" ] ; do
    kubectl describe pod home
    echo "Waiting for pod/home: $(date)"
    sleep 5
done

echo "Setup PV"
./ssh.sh 'sudo chown -v $USER: /home/$USER /scratch'

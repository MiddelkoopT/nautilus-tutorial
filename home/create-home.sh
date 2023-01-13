#!/bin/bash

# `envsubst` replaces envrionment variables with their values.
: ${REGION:=us-east}
: ${STORAGE_REGION:=-east} # '-central', '-east', or '' for west.
PROJECT=nautilus-tutorial
export PROJECT REGION
echo "=== create-home.sh $PROJECT $REGION"

echo "+++ Create Pod"
cat container/home-template.yaml | envsubst | kubectl apply -f -

while [ $(kubectl get pod/home -o template --template={{.status.phase}}) != "Running" ] ; do
    kubectl describe pod home
    echo "+++ Waiting for pod/home: $(date)"
    sleep 5
done

echo "+++ Setup PV"
./ssh.sh 'sudo chown -v $USER: /home/$USER /scratch'

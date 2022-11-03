#!/bin/bash

export PROJECT=nautilus-tutorial
envsubst < perfsonar-template.yaml | kubectl apply -f -
kubectl wait --for=condition=ready pod perfsonar

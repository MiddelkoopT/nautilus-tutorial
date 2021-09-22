#!/bin/bash

. ./environment.sh
cat app/app-deployment.yaml | PROJECT=$(basename $PWD) envsubst | kubectl apply -f -
kubectl apply -f app/app-service.yaml
cat app/app-ingress.yaml | PROJECT=$(basename $PWD) envsubst | kubectl apply -f -
kubectl get pod
kubectl get service
kubectl get ingress
kubectl get deployment

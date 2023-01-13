#!/bin/bash

export PROJECT=nautilus-tutorial
cat app-deployment.yaml | envsubst | kubectl apply -f -
kubectl apply -f app-service.yaml
cat app-ingress.yaml | envsubst | kubectl apply -f -

kubectl get pod
kubectl get service
kubectl get ingress
kubectl get deployment

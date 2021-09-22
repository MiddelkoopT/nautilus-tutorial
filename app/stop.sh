#!/bin/bash

. ./environment.sh
kubectl delete -f app/app-ingress.yaml
kubectl delete -f app/app-service.yaml
kubectl delete -f app/app-deployment.yaml

#!/bin/bash

kubectl delete -f app-ingress.yaml
kubectl delete -f app-service.yaml
kubectl delete -f app-deployment.yaml

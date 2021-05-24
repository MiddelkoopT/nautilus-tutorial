#!/bin/bash

. ./environment.sh
kubectl apply -f setup.yaml
kubectl apply -f home.yaml


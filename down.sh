#!/bin/bash

. ./environment.sh
kubectl delete -f home.yaml
kubectl delete -f setup.yaml


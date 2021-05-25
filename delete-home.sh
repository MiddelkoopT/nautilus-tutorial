#!/bin/bash

. ./environment.sh

kubectl delete pod/home
kubectl delete persistentvolumeclaims/home-data

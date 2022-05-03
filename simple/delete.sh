#!/bin/bash

kubectl delete pod/home
kubectl delete persistentvolumeclaims/home-data

#!/bin/bash

echo "+++ port forward"
kubectl port-forward service/app-service 8080:8080 &
sleep 2
curl http://localhost:8080
kill %1
wait
echo ""

echo "+++ ingress"
URL="https://$(kubectl get ingress app-ingress -o json |jq -r '.spec.rules[].host')"
echo $URL
curl ${URL}/v1/echo/string
curl -i -H "Content-Type: application/json" -H "Accept: application/json" -X POST --data '{"run": true}' ${URL}/v1/command

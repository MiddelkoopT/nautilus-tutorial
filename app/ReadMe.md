# Nautilus App

## Deploy App

Load sample API deployment and expose the port as a service. Note the environment substitution with envsubst (`app/start.sh`)
```bash
cat app/app-deployment.yaml | PROJECT=$(basename $PWD) envsubst | kubectl apply -f -
kubectl apply -f app/app-service.yaml
cat app/app-ingress.yaml | PROJECT=$(basename $PWD) envsubst | kubectl apply -f -
kubectl get pod
kubectl get service
kubectl get ingress
kubectl get deployment
```

Tunnel and test service (separate terminals)
```bash
kubectl port-forward service/app-service 8080:8080 &
curl http://localhost:8080
```

Test API - replace URL with actual URL
```
URL=http://localhost
curl ${URL}/
curl ${URL}/v1/echo/string
curl -i -H "Content-Type: application/json" -H "Accept: application/json" -X POST --data '{"run": true}' ${URL}/v1/command
```

Restart service (port-forward needs to be restarted)
```bash
kubectl rollout restart deployment app-deployment
```

Get a shell into a pod
```bash
kubectl get pod
kubectl exec -it app-deployment-HASH -- /bin/bash
```

Destroy environment
```bash
kubectl delete ingress app-ingress
kubectl delete service app-service
kubectl delete deployment app-deployment
kubectl get pod
kubectl get service
kubectl get secret
```

Optionally remove deploy token.
```
kubectl delete secret home-deploy-token
```

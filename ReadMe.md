# Nautilus Tutorial
*Copyright 2021 Internet2. Code licensed Apache License v2.0. Documentation licensed CC BY-SA 4.0*

Tutorial for Nautilus (https://nautilus.optiputer.net/).  Follow the tutorial to get access

Save the Nautilus credentials `config` file to this directory and source the `environment.sh` file to use `kubectl`.
```bash
. ./environment.sh
kubectl get pods
```

## Repository Setup

This is a one-time setup process for connecting a Nautilus gitlab project to the Nautilus build cluster.

Create a GitLab "deploy token" that has the `read_registry` (and optionally `read_repository`) flag set.  Note: use the "Username" not the "Name" field for `CI_DEPLOY_USER`.  The "Name" field is not used by the CI/CD process and clould be set to something like "Nautilus build deploy token".  To create the token navigate to Project -> Settings -> Repository -> Deploy tokens -> Create deploy token.  It is **NOT** a Project Access Token under Settings -> Access Tokens.

```bash
cat > token <<EOF
CI_REGISTRY=gitlab-registry.nautilus.optiputer.net
CI_DEPLOY_USER=<<Deploy Token username>>
CI_DEPLOY_PASSWORD=<<Token>>
EOF
```

Save the GitLab `token` as a K8 secret.
```bash
. ./environment.sh
. ./token
kubectl create secret docker-registry home-deploy-token --docker-server="$CI_REGISTRY" --docker-username="$CI_DEPLOY_USER" --docker-password="$CI_DEPLOY_PASSWORD" 
```

## Setup and Teardown

Setup and teardown for the "home" container including storage.
```bash
./up.sh
./setup.sh
kubectl describe pod/home
./down.sh
```

## Shell
```bash
./ssh.sh
```

## Deploy App
Setup `kubectl` credentials

```bash
. ./environment.sh
```

Load sample API deployment and expose the port as a service. Note the environment substitution with envsubst.
```bash
cat app/app-deployment.yaml | PROJECT=$(basename $PWD) envsubst | kubectl apply -f -
kubectl apply -f app/app-service.yaml
kubectl get pod
kubectl get service
kubectl get deployment
```

Tunnel and test service (separate terminals)
```bash
kubectl port-forward service/app-service 8080:8080
curl localhost:8080
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
kubectl delete service app-service
kubectl delete deployment app-deployment
kubectl get pod
kubectl get service
```

Optionally remove deploy token.
```
kubectl delete secret image-deploy-token
```

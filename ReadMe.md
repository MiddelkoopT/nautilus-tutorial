# Nautilus Tutorial
*Copyright 2021 Internet2. Code licensed Apache License v2.0. Documentation licensed CC BY-SA 4.0*

Tutorial for Nautilus (https://nautilus.optiputer.net/).  Follow the directions on the Nautilus website to get access Nautilus.

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

All use of `kubectl` must have the envrionment set and the `$PWD` must be the project root.
```bash
. ./environment.sh
```

## Simple Home Pod

To create a simple home pod without using a CI/CD pipleline. The home pod will terminate after 2 hours and is named the same as the home pod created by `./home.sh`.

Allocate storage and startup the pod:
```bash
. ./environment.sh
kubectl apply -f simple/data.yaml
kubectl apply -f simple/home.yaml
```

Alternatively, you an also apply the entire folder
```
. ./environment.sh
kubectl apply -f simple
```

You can now directy attach to the pod as root via:
```bash
kubectl exec -it home -- /bin/bash
```

To get a user, perform some script magic.  After this `./ssh.sh` will work. 
```bash
./scripts/setup-debian.sh
```

To destroy the pod and delete the storage
```bash
. ./environment.sh
kubectl delete -f simple/home.yaml
kubectl delete -f simple/data.yaml
```

## Shell
```bash
./ssh.sh
```

## Deploy App
Load sample API deployment and expose the port as a service. Note the environment substitution with envsubst.
```bash
. ./environment.sh
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
kubectl get secret
```

Optionally remove deploy token.
```
kubectl delete secret home-deploy-token
```

## Home Container

To build your own home container you must get the CI/CD pipeline working using the `app` pod.
```bash
./home.sh
```

To delete the pod and **delete** the data run the following.  This will **delete** your data and the pod.
```bash
./delete.sh
./list.sh
```

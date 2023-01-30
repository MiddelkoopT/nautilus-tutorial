# Nautilus Home

## Simple Home Pod

To create a simple home pod without using a CI/CD pipleline. The home pod is named the same as the home pod created by `./create-home.sh`.

Allocate storage and startup the pod:
```bash
kubectl apply -f simple/data.yaml
kubectl apply -f simple/home.yaml
```

Alternatively, you an also apply the entire folder
```
kubectl apply -f simple
```

You can now directly attach to the pod as root via:
```bash
kubectl exec -it home -- /bin/bash
```

To get a user, perform some script magic.  After this `./ssh.sh` will work. 
```bash
./simple/setup.sh
```

Get a shell into the pod.
```bash
./ssh.sh
```

To destroy the pod and delete the storage
```bash
kubectl delete -f simple/home.yaml
kubectl delete -f simple/data.yaml
```


## Home Container

To build your own home container you must get the CI/CD pipeline working using the `app` pod instructions.
```bash
./create-home.sh
```

To delete the pod and **delete** the data run the following.  This will **delete** your data and the pod.
```bash
./delete-home.sh
./list.sh
```

## Region Resources
```bash
kubectl get nodes -l topology.kubernetes.io/region=us-central
kubectl get nodes -l nautilus.io/ipv6=true
kubectl -o json get nodes -l nautilus.io/ipv6=true,topology.kubernetes.io/region=us-central
```

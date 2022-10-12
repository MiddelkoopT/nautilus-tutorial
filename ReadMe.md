# Nautilus Tutorial
*Copyright 2021, 2022 Internet2. Code licensed Apache License v2.0. Documentation licensed CC BY-SA 4.0*

Tutorial for Nautilus (https://portal.nrp-nautilus.io/).  Follow the directions on the Nautilus website to get access Nautilus.

Save the Nautilus credentials `config` file to `~/.kube/config` to use `kubectl`.
```bash
kubectl get pods
```

## Repository Setup

This is a one-time setup process for connecting a Nautilus (gitlab)[https://gitlab.nrp-nautilus.io/] project to the Nautilus build cluster.

Create a GitLab "deploy token" that has the `read_registry` (and optionally `read_repository`) flag set.  Note: use the "Username" not the "Name" field for `CI_DEPLOY_USER` in the token file below.  The "Name" field is not used by the CI/CD process and could be set to something like "Nautilus build deploy token".  To create the token navigate to Project -> Settings -> Repository -> Deploy tokens -> Create deploy token.  It is **NOT** a Project Access Token under Settings -> Access Tokens.

```bash
cat > token <<EOF
CI_REGISTRY=gitlab-registry.nrp-nautilus.io
CI_DEPLOY_USER=<<Deploy Token username>>
CI_DEPLOY_PASSWORD=<<Token>>
EOF
```

Save the GitLab `token` as a K8 secret.
```bash
. ./token
kubectl create secret docker-registry home-deploy-token --docker-server="$CI_REGISTRY" --docker-username="$CI_DEPLOY_USER" --docker-password="$CI_DEPLOY_PASSWORD"
```


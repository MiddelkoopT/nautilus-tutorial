# Nautilus PerfSONAR

Build and run Nautilus on Perfsonar.

  * Note: using patched docker build to fix for Docker version bug (https://github.com/MiddelkoopT/perfsonar-testpoint-docker/tree/tm-dev).


Create perfsonar pod
```bash
./create-perfsonar.sh
```

Grab a shell.
```bash
kubectl exec -it perfsonar -- /bin/bash
```

Basic Tests
```bash
pscheduler ping localhost
pscheduler task idle --duration PT2S
pscheduler task rtt --dest 127.0.0.1

pscheduler troubleshoot

pscheduler task trace --dest ps.ncsa.xsede.org
pscheduler task trace --dest kans.ps.greatplains.net

pscheduler task throughput --dest ps.ncsa.xsede.org
pscheduler task throughput --dest kans.ps.greatplains.net

```

#!/bin/bash

. ./environment.sh

# Wait for pod to be in the 'Running' state
while [ $(kubectl get pod/home  -o template --template={{.status.phase}}) != "Running" ] ; do
    echo "Waiting for pod home: $(date)"
    sleep 1
done

SSH="kubectl exec -i home -- /bin/bash"
SSH_USER="kubectl exec -i home -- /usr/bin/sudo -u $USER -i"

$SSH <<EOF
adduser --disabled-password --gecos $USER $USER
usermod -a -G sudo $USER

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get dist-upgrade -y

apt-get install -y sudo
if ! grep -q "^# local configuration" /etc/sudoers ; then
echo -e '\n# local configuration' >> /etc/sudoers
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
fi

EOF

$SSH_USER < scripts/setup-user.sh

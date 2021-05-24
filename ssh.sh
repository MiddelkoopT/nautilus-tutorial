#!/bin/bash

. ./environment.sh

## Check if stdin, stdout, and stderr are a terminal and if so use it.
if [ -t 0 -a -t 1 -a -t 2 ] ; then
    kubectl exec -it zero -- /usr/bin/sudo -u $USER -i $*
else
    kubectl exec -i zero -- /usr/bin/sudo -u $USER -i $*
fi

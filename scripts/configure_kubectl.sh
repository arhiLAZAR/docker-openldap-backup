#!/bin/bash

kubectl config set-cluster default --server=${K8S_API_URL}
kubectl config set-cluster default --insecure-skip-tls-verify=true
kubectl config set-credentials ${K8S_USER} --token=${K8S_TOKEN}
kubectl config set-context default --cluster default --user ${K8S_USER} --namespace ${K8S_NS}
kubectl config use-context default

#!/bin/bash

configure_kubectl

kubectl delete helmreleases.helm.toolkit.fluxcd.io ${K8S_HELMRELEASE}

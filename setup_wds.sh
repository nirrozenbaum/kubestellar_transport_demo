#!/bin/bash

cd $(dirname ${BASH_SOURCE})

set -e

wds="wds1"

MY_KUBECONFIGS="kubeconfigs"
export KUBECONFIG="${MY_KUBECONFIGS}/${wds}"

echo "Create Kind cluster for WDS\n"
kind create cluster --name "${wds}"

echo "Apply CRDs in WDS\n"
kubectl apply -f crds/control.kubestellar.io_bindingpolicies.yaml
kubectl apply -f crds/control.kubestellar.io_bindings.yaml
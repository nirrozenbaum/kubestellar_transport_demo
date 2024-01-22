#!/bin/bash

cd $(dirname ${BASH_SOURCE})

set -e

wds="wds1"
wdsctx="kind-${wds}"

MY_KUBECONFIGS="kubeconfigs"
export KUBECONFIG="${MY_KUBECONFIGS}/${wds}"

echo "Create Kind cluster for WDS\n"
kind create cluster --name "${wds}"

echo "Apply PlacementDecision CRD in WDS\n"
kubectl apply -f crds/edge.kubestellar.io_placementdecisions.yaml
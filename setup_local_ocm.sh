#!/bin/bash

cd $(dirname ${BASH_SOURCE})

set -e

hub="ocm-hub"
c1="cluster1"
c2="cluster2"

hubctx="kind-${hub}"
c1ctx="kind-${c1}"
c2ctx="kind-${c2}"

MY_KUBECONFIGS="kubeconfigs"

export KUBECONFIG="${MY_KUBECONFIGS}/${hub}"
kind create cluster --name "${hub}"
export KUBECONFIG="${MY_KUBECONFIGS}/${c1}"
kind create cluster --name "${c1}"
export KUBECONFIG="${MY_KUBECONFIGS}/${c2}"
kind create cluster --name "${c2}"

echo "Initialize the ocm hub cluster\n"
export KUBECONFIG="${MY_KUBECONFIGS}/${hub}"
clusteradm init --wait --context ${hubctx}
joincmd=$(clusteradm get token --context ${hubctx} | grep clusteradm)

echo "Join cluster1 to hub\n"
export KUBECONFIG="${MY_KUBECONFIGS}/${c1}"
$(echo ${joincmd} --force-internal-endpoint-lookup --wait --context ${c1ctx} | sed "s/<cluster_name>/$c1/g")

echo "Join cluster2 to hub\n"
export KUBECONFIG="${MY_KUBECONFIGS}/${c2}"
$(echo ${joincmd} --force-internal-endpoint-lookup --wait --context ${c2ctx} | sed "s/<cluster_name>/$c2/g")

echo "Accept join of cluster1 and cluster2"
export KUBECONFIG="${MY_KUBECONFIGS}/${hub}"
clusteradm accept --context ${hubctx} --clusters ${c1},${c2} --wait
kubectl get managedclusters --all-namespaces --context ${hubctx}
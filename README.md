# kubestellar_transport_demo
repo to demo kubestellar transport implementation 

## Pre-requisites
1. curl
1. bash
1. kind
1. git
1. kubectl

❗ Pay attention that the following instructions clone repos from git. In order to avoid overriding your work, please run the steps on a clean directory and do a cleanup once done.

## Setup the Space-Framework
1. Deploy kind cluster to host space-management using the following command:
```
bash <(curl -s https://raw.githubusercontent.com/kubestellar/kubestellar/main/space-framework/test/example/create_kind_cluster.sh)
```

2. Set KUBECONFIG as follows:
```
export KUBECONFIG=$HOME/.kube/config 
```

3. Build Space-Managment:
```
git clone git@github.com:kubestellar/kubestellar.git
cd kubestellar/space-framework
make 
cd ../../
```

4. Run Space-Management in the kind cluster:
```
kubectl apply -f kubestellar/space-framework/config/crds
kubestellar/space-framework/bin/space-manager --context kind-sm-mgt &> /tmp/space-manager.log &
```

5. Install KubeFlex Space-Provider:
```
git clone git@github.com:kubestellar/kubeflex.git
cd kubeflex
make
cd ..
kubeflex/bin/kflex init
```

6. Create KubeFlex secrets and service provider object:
```
kubectl create secret generic kfsec --from-file=kubeconfig=$HOME/.kube/config
kubectl apply -f "https://raw.githubusercontent.com/kubestellar/kubestellar/main/space-framework/test/example/kf-provider.yaml"
```

7. Deploy a test space and verify your space created successfully:
```
kubectl apply -f "https://raw.githubusercontent.com/kubestellar/kubestellar/main/space-framework/test/example/kf-space.yaml"
kubectl get spaces -A
```

8. Wait until your space is ready for use:
```
kubectl wait --for=jsonpath='{.status.Phase}'=Ready space/kfspace -n spaceprovider-kf --timeout=90s
```

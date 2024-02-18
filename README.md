# kubestellar_transport_demo
repo to demo kubestellar transport implementation 

## Pre-requisites
1. curl
1. bash
1. kind
1. git
1. kubectl
1. clusteradm


## Prepare the environment 

❗ Pay attention that the following instructions clone repos from git and remove the content of the dir `kubeconfigs`. In order to avoid overriding your work, please run the steps on a clean directory and do a cleanup once done.

1. Create a sub-directory for storing kubeconfig files of the different clusters:
```
MY_KUBECONFIGS=${PWD}/kubeconfigs
rm -rf "$MY_KUBECONFIGS"
mkdir -p "$MY_KUBECONFIGS"

```

## Deploy Kubestellar

### Deploy WECs

1.  Deploy ocm hub and two edge clusters:
    ```
    ./setup_local_ocm.sh 
    ```

1.  Deploy wds:
    ```
    ./setup_wds.sh
    ```

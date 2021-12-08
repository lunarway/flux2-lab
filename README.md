# Flux2-lab

A repo to experiment on Flux v2

## Generate services and Kustomize files

To create the files that mimic k8s-cluster-config services, run the following `shuttle` command

> To control the output, link number of services to generate, edit `shuttle.yaml`

```
shuttle run generate_config
```

This will create two folders in the `.shuttle` folder. First, `clusters` that has all the Kustomize files in clusters/dev/services-name and secondly the pod manifests in dev/releases/dev/service-name

Single kustomization:

- First reconciliation: 35s
- Second reconciliation: Added missing namespace: 23s
- Added label: 23s
- Added failure and new services: failed after 25. no new services were added.

Multiple Ksutomizations:

- First: 38s
- Second: 23s

Pod/dev/network-multitool-1 kustomization: 453.1251ms

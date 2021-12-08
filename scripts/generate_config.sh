#!/bin/bash

# Fail incase of error exit codes
set -e

NB_SERVICES=$(shuttle get service-count)
DOCKER_IMAGE=$(shuttle get docker.image)
DOCKER_TAG=$(shuttle get docker.tag)
ENV=$(shuttle get env)
SERVICE_NAME=$(shuttle get service)

multipleKustomizations="k8s-cluster-config-mulitple-kustomizations"
rm -rf ${multipleKustomizations}
echo "Creating ${multipleKustomizations}"
for i in $(seq ${NB_SERVICES})
do
    mkdir -p ${multipleKustomizations}/clusters/${ENV}/${SERVICE_NAME}-${i}
    shuttle template templates/flux-kustomize.tmpl nb=${i} > ${multipleKustomizations}/clusters/${ENV}/${SERVICE_NAME}-${i}/kustomize.yaml
    
    mkdir -p ${multipleKustomizations}/${ENV}/releases/${ENV}/${SERVICE_NAME}-${i}
    shuttle template templates/multitool-pod.tmpl nb=${i} > ${multipleKustomizations}/${ENV}/releases/${ENV}/${SERVICE_NAME}-${i}/pod-multitool.yaml
done

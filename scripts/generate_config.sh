#!/bin/bash

# Fail incase of error exit codes
set -e

NB_SERVICES=$(shuttle get service-count)
DOCKER_IMAGE=$(shuttle get docker.image)
DOCKER_TAG=$(shuttle get docker.tag)
ENV=$(shuttle get env)
SERVICE_NAME=$(shuttle get service)

echo "Creating $NB_SERVICES with ${DOCKER_IMAGE}${DOCKER_TAG}"

for i in $(seq ${NB_SERVICES})
do
  echo "Creating kustomize manifest in k8s-cluster-config/clusters/${ENV}/${SERVICE_NAME}-${i}"
  mkdir -p k8s-cluster-config/clusters/${ENV}/${SERVICE_NAME}-${i}
  shuttle template templates/flux-kustomize.tmpl nb=${i} > k8s-cluster-config/clusters/${ENV}/${SERVICE_NAME}-${i}/kustomize.yaml

  echo "Creating pod manifest in k8s-cluster-config/${ENV}/releases/${ENV}/${SERVICE_NAME}-${i}"
  mkdir -p k8s-cluster-config/${ENV}/releases/${ENV}/${SERVICE_NAME}-${i}
  shuttle template templates/multitool-pod.tmpl nb=${i} > k8s-cluster-config/${ENV}/releases/${ENV}/${SERVICE_NAME}-${i}/pod-multitool.yaml
done
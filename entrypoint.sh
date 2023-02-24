#!/usr/bin/env sh

set -e

mkdir -p /root/.kube

echo """apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: $CLUSTER_CA
    server: $CLUSTER_SERVER
  name: default
contexts:
- context:
    cluster: default
    user: default
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: default
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args: null
      command: /apps/google-cloud-sdk/bin/gke-gcloud-auth-plugin
      env: null
      installHint: Install gke-gcloud-auth-plugin for use with kubectl by following
        https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
      interactiveMode: IfAvailable
      provideClusterInfo: true
""" > /root/.kube/config

echo "$GCP_SA_KEY" | base64 -d > /tmp/gcp.json
/apps/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file=/tmp/gcp.json --project $GCP_PROJECT
/apps/google-cloud-sdk/bin/gcloud config set project $GCP_PROJECT
/apps/google-cloud-sdk/bin/gcloud container clusters get-credentials $GCP_CLUSTER --region $GCP_REGION


exec "$@"
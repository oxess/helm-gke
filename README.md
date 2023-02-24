# Image created for use in GitLab CI/CD

This image is based on the official Helm image and adds the Google Cloud SDK.

### Variables to set

| Variable       | Description                                    |
|----------------|------------------------------------------------|
| CLUSTER_CA     | Base64 encoded CA certificate for the cluster. |
| CLUSTER_SERVER | URL of the cluster.                            |
| GCP_SA_KEY     | Base64 encoded service account key.            |
| GCP_PROJECT    | ID of the GCP project.                         |
| GCP_REGION     | Region of the GCP project.                     |
| GCP_CLUSTER    | Name of the GCP cluster.                       |


### How to use

```yaml

Container build:
  ...

Deploy:
  stage: deploy
  image:
    name: oxess/helm-google-sdk:latest
  variables:
    CLUSTER_CA: $CLUSTER_CA
    CLUSTER_SERVER: $CLUSTER_ENDPOINT_ENDPOINT_URL
    GCP_SA_KEY: $GCP_SA_KEY
    GCP_PROJECT: $GCP_PROJECT
    GCP_REGION: $GCP_REGION
    GCP_CLUSTER: $GCP_CLUSTER
  script:
    - helm dep up
    - helm upgrade --install <name> .
  needs:
    - Container build


```

### Testing

```bash
docker run -it --rm \
  -e CLUSTER_CA="<CLUSTER_CA>" \
  -e CLUSTER_SERVER="https://<CLUSTER_IP>" \
  -e GCP_SA_KEY="<GCP_SA_KEY__BASE64>" \
  -e GCP_PROJECT="<PROJECT_ID>" \
  -e GCP_REGION="<GCP_PROJECT_REGION>" \
  -e GCP_CLUSTER="<GCP_CLUSTER_NAME>" \
  oxess/helm-google-sdk:latest /bin/sh
```

### Versions

| Helm  | Google Cloud SDK |
|-------|------------------|
| 3.7.0 | 418.0.0          |
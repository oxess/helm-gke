FROM alpine/helm:3.7.0

ENV USE_GKE_GCLOUD_AUTH_PLUGIN true
ENV PATH "/apps/google-cloud-sdk/bin:$PATH"

RUN apk update && apk add curl python3 py3-pip

RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-418.0.0-linux-x86_64.tar.gz \
    && tar -xvf google-cloud-cli-418.0.0-linux-x86_64.tar.gz \
    && ./google-cloud-sdk/install.sh \
    && rm google-cloud-cli-418.0.0-linux-x86_64.tar.gz

RUN ./google-cloud-sdk/bin/gcloud components install gke-gcloud-auth-plugin

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
FROM codeship/eks-kubectl

ENV HELM_LATEST_VERSION="v2.12.3"

RUN apt-get install -y gettext \
  && wget https://storage.googleapis.com/kubernetes-helm/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
  && tar -xvf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
  && mv linux-amd64/helm /usr/local/bin \
  && rm -f /helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz

ADD ensubstvars_helper.sh /usr/bin

ENTRYPOINT ["./env_var_helper_client.sh"]
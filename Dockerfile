FROM codeship/eks-kubectl

ARG AWS_CLI_VERSION="1.16.96"
ARG HELM_LATEST_VERSION="v2.12.3"

RUN  apt-get update \
  && apt-get install -y python2.7 \
  && apt-get install -y python-pip \
  && pip install awscli==${AWS_CLI_VERSION} \
  && mkdir -p "${HOME}/.aws" \
  && apt-get install -y gettext \
  && wget https://storage.googleapis.com/kubernetes-helm/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
  && tar -xvf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
  && mv linux-amd64/helm /usr/local/bin \
  && rm -f /helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz

ADD ensubstvars_helper.sh /usr/bin

ENTRYPOINT ["./env_var_helper_client.sh"]
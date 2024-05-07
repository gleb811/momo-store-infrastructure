FROM ubuntu:22.04
RUN apt update && apt install -y git curl 
# YC CLI
RUN (curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | \
    bash -s -- -i /opt/yandex-cloud -n && \
    ln -s /opt/yandex-cloud/bin/yc /usr/bin/yc && \
    yc version) || false

# Kubectl
RUN (curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    kubectl version --client) || false

# Helm
RUN (curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash && \
    helm plugin install https://github.com/chartmuseum/helm-push.git && \
    helm version) || false
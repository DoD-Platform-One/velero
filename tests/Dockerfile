FROM registry1.dso.mil/ironbank/redhat/ubi/ubi9:9.1.0

WORKDIR /tools

RUN curl -LO https://dl.min.io/client/mc/release/linux-amd64/mc && chmod +x mc && mv mc /usr/local/bin/
#RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x kubectl && mv kubectl /usr/local/bin/
RUN curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl" && chmod +x kubectl && mv kubectl /usr/local/bin/
RUN curl -LO "https://github.com/vmware-tanzu/velero/releases/download/v1.12.1/velero-v1.12.1-linux-amd64.tar.gz" && tar -xzf velero-v1.12.1-linux-amd64.tar.gz --strip-components=1 'velero-v1.12.1-linux-amd64/velero' && chmod +x velero && mv velero /usr/local/bin/

USER 1000

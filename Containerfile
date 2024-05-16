FROM alpine:latest

ARG buildArch=amd64
ARG toolboxUser=toolbox
ARG toolboxUserUid=1000
ARG toolboxUserGroup=toolbox

LABEL org.opencontainers.image.source="https://quay.io/repository/tlbueno/toolbox"

USER root

RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add \
        bash \
        bash-completion \
        bzip2 \
        coreutils \
        curl \
        gawk \
        gcompat \
        git \
        git-bash-completion \
        git-crypt \
        gzip \
        helm  \
        helm-bash-completion \
        iproute2 \
        iproute2-bash-completion \
        iputils \
        jq \
        kubectl \
        kubectl-bash-completion \
        less \
        make \
        musl-locales \
        musl-locales-lang \
        net-tools \
        procps-ng \
        sed \
        shadow \
        skopeo \
        skopeo-bash-completion \
        sudo \
        tar \
        unzip \
        vim \
        wget \
        xz \
        yq \
        yq-bash-completion \
        && \
    echo "Configuring sudo" && \
    echo "%toolbox  ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/toolbox && \
    echo "ocp client install" && \
    mkdir /opt/ocp-client && \
    curl -sSL https://mirror.openshift.com/pub/openshift-v4/${buildArch}/clients/ocp/latest/openshift-client-linux.tar.gz | \
    tar -zx -C /opt/ocp-client && \
    ln -s /opt/ocp-client/oc /usr/local/bin/oc && \
    echo "logcli install" && \
    curl -sSL https://github.com/grafana/loki/releases/download/v2.9.8/logcli-linux-amd64.zip -o /tmp/logcli.zip && \
    unzip /tmp/logcli.zip && \
    mv logcli-linux-amd64 /usr/local/bin/logcli && \
    rm -rf /tmp/logcli.zip

RUN useradd -s /bin/bash -u "${toolboxUserUid}" -m -U "${toolboxUser}"
COPY --chown=${toolboxUser}:${toolboxUser} .bashrc /home/toolbox/.bashrc
COPY --chown=${toolboxUser}:${toolboxUser} .bashrc.d /home/toolbox/.bashrc.d
COPY --chown=${toolboxUser}:${toolboxUser} .vimrc /home/toolbox/.vimrc
ENV LANG=en_US.utf8
USER ${toolboxUser}
ENTRYPOINT ["bash"]
WORKDIR /home/toolbox


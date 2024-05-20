FROM alpine:latest

ARG buildArch=amd64

ARG toolboxUser=toolbox
ARG toolboxUserUid=1000
ARG toolboxUserGroup=toolbox
ARG toolboxUserHome=/home/toolbox

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
        file \
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
        kustomize \
        less \
        make \
        musl-locales \
        musl-locales-lang \
        net-tools \
        openjdk21-jre-headless \
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
    echo "mqtt-cli install" && \
    curl -sSL $(curl -sSL "https://api.github.com/repos/hivemq/mqtt-cli/releases/latest" | jq -r '.assets[] | .browser_download_url | select(test(".jar$"))') -o /usr/local/bin/mqtt-cli.jar && \
    echo "logcli install" && \
    curl -sSL $(curl -sSL "https://api.github.com/repos/grafana/loki/releases/latest" | jq --arg regex "logcli-linux-$buildArch.zip" -r '.assets[] | .browser_download_url | select(test($regex))') -o /tmp/logcli.zip && \
    unzip /tmp/logcli.zip && \
    mv logcli-linux-amd64 /usr/local/bin/logcli && \
    rm -rf /tmp/logcli.zip

RUN useradd -s /bin/bash -d ${toolboxUserHome} -u "${toolboxUserUid}" -m -U "${toolboxUser}"
COPY --chown=${toolboxUser}:${toolboxUser} .bashrc ${toolboxUserHome}/.bashrc
COPY --chown=${toolboxUser}:${toolboxUser} .bashrc.d ${toolboxUserHome}/.bashrc.d
COPY --chown=${toolboxUser}:${toolboxUser} .vimrc ${toolboxUserHome}/.vimrc
COPY --chown=${toolboxUser}:${toolboxUser} entrypoint.sh ${toolboxUserHome}/entrypoint.sh
ENV LANG=en_US.utf8
USER ${toolboxUser}
WORKDIR ${toolboxUserHome}
ENTRYPOINT ["bash", "-c", "exec ./entrypoint.sh"]


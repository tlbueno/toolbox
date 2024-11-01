FROM alpine:3.20.3

ARG buildArch=amd64
ARG toolboxUser=toolbox
ARG toolboxUserUid=1000
ARG toolboxUserGroup=toolbox
ARG toolboxUserHome=/home/toolbox

LABEL org.opencontainers.image.source="https://github.com/tlbueno/toolbox"
LABEL org.opencontainers.image.description="An alpine linux container image with general tools to be used as a toolbox"

USER root

RUN apk update && \
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
        mariadb-client \
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
        yq-go \
        yq-go-bash-completion

RUN echo "ocp client install" && \
    mkdir /opt/ocp-client && \
    curl -sSL https://mirror.openshift.com/pub/openshift-v4/${buildArch}/clients/ocp/latest/openshift-client-linux.tar.gz | \
    tar -zx -C /opt/ocp-client && \
    ln -s /opt/ocp-client/oc /usr/local/bin/oc && \
    echo "mqtt-cli install" && \
    curl -sSL $(curl -sSL "https://api.github.com/repos/hivemq/mqtt-cli/releases/latest" | jq -r '.assets[] | .browser_download_url | select(test(".jar$"))') -o /usr/local/bin/mqtt-cli.jar && \
    echo "artemis install" && \
    export artemis_version=$(curl -sSL https://archive.apache.org/dist/activemq/activemq-artemis | grep "^<img" | sed -E -e 's#.*<a href="([0-9]+\.[0-9]+\.[0-9]+)/">.*#\1#' | sort -V | tail -1) && \
    curl -sSL https://archive.apache.org/dist/activemq/activemq-artemis/${artemis_version}/apache-artemis-${artemis_version}-bin.tar.gz -o /tmp/artemis.zip && \
    cd /tmp/ && \
    tar -zxf /tmp/artemis.zip && \
    rm /tmp/artemis.zip && \
    mv /tmp/apache-artemis-${artemis_version} /opt && \
    ln -s /opt/apache-artemis-${artemis_version}/bin/artemis /usr/local/bin/artemis

RUN echo "configuring sudo" && \
    echo "%toolbox  ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/toolbox

RUN useradd -s /bin/bash -d ${toolboxUserHome} -u "${toolboxUserUid}" -m -U "${toolboxUser}"
COPY --chown=${toolboxUser}:${toolboxUser} .bashrc ${toolboxUserHome}/.bashrc
COPY --chown=${toolboxUser}:${toolboxUser} .bashrc.d ${toolboxUserHome}/.bashrc.d
COPY --chown=${toolboxUser}:${toolboxUser} .vimrc ${toolboxUserHome}/.vimrc
COPY --chown=${toolboxUser}:${toolboxUser} entrypoint.sh ${toolboxUserHome}/entrypoint.sh
ENV LANG=en_US.utf8
USER ${toolboxUserUid}
WORKDIR ${toolboxUserHome}
ENTRYPOINT ["bash", "-c", "exec ./entrypoint.sh"]


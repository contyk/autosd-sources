FROM centos/centos:stream9
RUN rm /etc/yum.repos.d/*
ADD repos.repo /etc/yum.repos.d
ADD get_sources.sh /root
RUN yum install --nodocs --setopt=install_weak_deps=False --best --color=never -y \
    bash \
    bzip2 \
    coreutils-single \
    cpio \
    diffutils \
    'dnf-command(builddep)' \
    findutils \
    gawk \
    grep \
    gzip \
    info \
    koji \
    make \
    patch \
    redhat-rpm-config \
    rpm \
    rpm-build \
    sed \
    shadow-utils \
    tar \
    unzip \
    util-linux \
    which \
    xz && \
    yum clean all && \
    mkdir -p /etc/koji.conf.d /root/outputs
ADD buildsys.conf /etc/koji.conf.d
WORKDIR /root/outputs

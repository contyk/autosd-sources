#!/bin/sh
_path=~/outputs
_arch=$(arch)
_repo=https://autosd.sig.centos.org/AutoSD-9/latest/repos/cs9/${_arch}/os/

mkdir -p ${_path}/srpms ${_path}/sources
cd ${_path}/srpms

for _pkg in $(yum repoquery --repofrompath=autosd,${_repo} --disablerepo=\* --enablerepo=autosd --qf '%{sourcerpm}' | sort -fu); do
    _nvr=$(echo ${_pkg} | sed 's/\.src\.rpm$//')
    if echo ${_nvr} | grep -qE '^(kernel|linux-firmware)-automotive'; then
        _profile=cbs
    else
        _profile=stream
    fi
    koji -p ${_profile} download-build --arch src ${_nvr}
done

for _srpm in ${_path}/srpms/*.rpm; do
    echo Debug: Working on ${_srpm} ...
    yum builddep --skip-broken -y ${_srpm}
    rpm -i ${_srpm}
    rpmbuild -bp /root/rpmbuild/SPECS/*.spec
    mv /root/rpmbuild/BUILD/* ${_path}/sources/
    rm -rf /root/rpmbuild/*
done

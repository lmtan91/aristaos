#!/bin/bash

if grep -q CentOS /etc/*release; then
    INSTALL_CMD="yum -y install glibc-static"
    REMOVE_CMD="yum -y remove glibc-static"
elif grep -q Fedora /etc/*release; then
    INSTALL_CMD="dnf -y install glibc-static"
    REMOVE_CMD="dnf -y remove glibc-static"
elif grep -q Ubuntu /etc/*release || grep -q Debian /etc/*release; then
    INSTALL_CMD="apt-get install -y python3-pip"
    REMOVE_CMD="apt-get remove -y python3-pip"
elif grep -q openSUSE /etc/*release; then
    INSTALL_CMD="zypper --non-interactive install python3-pip glibc-devel-static"
    REMOVE_CMD="zypper --non-interactive remove python3-pip glibc-devel-static"
else
    exit 1
fi

wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64
chmod +x /usr/bin/dumb-init

# Really this should be an exit 1 as well if it fails, but for some reason
# on travis, for fedora it consistently says that it cannot acquire the
# the transaction lock.
$REMOVE_CMD || exit 0

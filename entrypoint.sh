#!/bin/sh -l
sudo amazon-linux-extras install -y epel &&\
sudo yum install -y https://repo.ius.io/ius-release-el7.rpm && \
sudo yum install dnsmasq python36 python36-pip python36-dbus && \
wget https://bin.appgate-sdp.com/5.3/client/appgate-sdp-headless-5.3.3-el7.x86_64.rpm && \
sudo rpm --install -y --nodeps ./appgate-sdp-headless-5.3.3-el7.x86_64.rpm

sudo tee /etc/appgate.conf <<EOF >/dev/null
[Settings]
LogLevel = Info

[Credentials]
ControllerUrl = ${1}
Username = ${2}
Password = ${3}
EOF
sudo appgate_service_configurator reload && \
sudo appgate_service_configurator status
echo "controllerURL $1"
echo "username $2"
echo "password $3"
time=sudo appgate_service_configurator status
echo "::set-output name=secret-value::$time"

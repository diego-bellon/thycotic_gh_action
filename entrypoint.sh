#!/bin/sh -l
tee /etc/appgate.conf <<EOF >/dev/null
[Settings]
LogLevel = Info
[Credentials]
ControllerUrl = ${1}
Username = ${2}
Password = ${3}
EOF
RUN appgate_service_configurator reload && \
    appgate_service_configurator status
echo "controllerURL $1"
echo "username $2"
echo "password $3"
time=$(appgate_service_configurator status)
echo "::set-output name=secret-value::$time"

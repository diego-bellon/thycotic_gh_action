FROM amazonlinux
RUN yum -y update; yum clean all
RUN yum -y install systemd; yum clean all;
RUN  amazon-linux-extras install -y epel && \
     yum install -y https://repo.ius.io/ius-release-el7.rpm && \
     yum install -y dnsmasq python36 python36-pip python36-dbus wget && \
     wget https://bin.appgate-sdp.com/5.3/client/appgate-sdp-headless-5.3.3-el7.x86_64.rpm && \
     rpm --install --nodeps ./appgate-sdp-headless-5.3.3-el7.x86_64.rpm
RUN tee /etc/appgate.conf <<EOF >/dev/null \
    [Settings] \
    LogLevel = Info \
    [Credentials] \
    ControllerUrl = ${INPUT_SDP-CONTROLLER-URL} \
    Username = ${INPUT_SDP-USERNAME} \
    Password = ${INPUT_SDP-PASSWORD} \
    EOF
RUN cat /etc/appgate.conf
RUN appgate_service_configurator reload
RUN appgate_service_configurator status
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM phusion/baseimage:latest

MAINTAINER Ryan Graham <ryangraham@gmail.com>

RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install postfix postfix-pcre libsasl2-modules

EXPOSE 25

RUN postconf -e 'relayhost = [smtp.mailgun.org]'
RUN postconf -e 'smtp_sasl_auth_enable = yes'
RUN postconf -e 'smtp_sasl_security_options = noanonymous'
RUN postconf -e 'smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd'
RUN postconf -e 'mynetworks = 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128'

ADD entrypoint.sh /tmp/entrypoint.sh
RUN chmod a+x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
EXPOSE 25

#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "[smtp.mailgun.org] ${MG_USER}:${MG_PASS}" > /etc/postfix/sasl_passwd
  chmod 600 /etc/postfix/sasl_passwd
  postmap /etc/postfix/sasl_passwd
  /etc/init.d/postfix start
  touch /var/log/mail
  tail -F /var/log/mail*
  # TODO: working logs
else
  exec "$@"
fi

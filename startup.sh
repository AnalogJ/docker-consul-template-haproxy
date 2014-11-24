#!/bin/bash

HAPROXY="/etc/haproxy"
PIDFILE="/var/run/haproxy.pid"
CONFIG_FILE=${HAPROXY}/haproxy.cfg

cd "$HAPROXY"

haproxy -f "$CONFIG_FILE" -p "$PIDFILE" -D -st $(cat $PIDFILE)

uname -m
uname -a

/usr/local/bin/consul-template -consul=${CONSUL_PORT_8500_TCP_ADDR}:${CONSUL_PORT_8500_TCP_PORT} \
  -template "/etc/haproxy/haproxy.template:/etc/haproxy/haproxy.cfg:/hap.sh"

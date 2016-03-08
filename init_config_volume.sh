#!/bin/bash

if [ ! -f /etc/opt/ripple/rippled.cfg ]; then
  chown -R rippled:rippled /etc/opt/ripple
  cp /opt/ripple/etc/rippled.cfg /etc/opt/ripple
fi

exit 0
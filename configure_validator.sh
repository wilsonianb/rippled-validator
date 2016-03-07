#!/bin/bash

# Wait for rippled to start up
while /opt/ripple/bin/rippled server_info | grep -q 'no response from server'; do sleep 1; done

# Check for validation key
VALIDATION_PUBLIC_KEY=`/opt/ripple/bin/rippled server_info -q | jq .result.info.pubkey_validator`

if [  "$VALIDATION_PUBLIC_KEY" == "\"none\"" ]; then

  # Generate validation key
  VALIDATION_SEED=`/opt/ripple/bin/rippled validation_create -q | jq .result.validation_seed`
  VALIDATION_SEED="${VALIDATION_SEED:1:-1}"

  echo "
[validation_seed]
$VALIDATION_SEED" >> /etc/opt/ripple/rippled.cfg

  supervisorctl -c /etc/supervisor/conf.d/supervisord.conf restart rippled

  # Wait for rippled to start up
  while /opt/ripple/bin/rippled server_info | grep -q 'no response from server'; do sleep 1; done

  /opt/ripple/bin/rippled server_info -q
fi

exit 0
# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

HISTORY=$(diff <( history | cut -c 8- ) ~/.bash_history | sed -n 's/^< //pg' | sed 's|$|\n|' )
echo "history $HISTORY"
HOSTNAME=$(hostname)
echo "hostname $HOSTNAME"
ORIGINUSER=$(who am i | awk '{print $1}')
if [ "$USER" != "$ORIGINUSER" ]
then
	  ORIGINUSER="${ORIGINUSER}(${USER})"
fi
echo "username: $ORIGINUSER"
if [ "${HOSTNAME:0:2}" == "vc" ] | [ "${HOSTNAME:0:1}" == "c" ]; then SERVER="syslog-ha.sos.kb.cz"; else SERVER="patchmonitor-test.sos.kb.cz"; fi
echo "webserver $SERVER"
if [ -z "$HISTORY" ]
then
      echo "\$HISTORY is empty"
else
      curl -d "hostname=${HOSTNAME}&username=${ORIGINUSER}&process=${HISTORY}" -X POST http://${SERVER}/servermon.php
fi

sleep 3


if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

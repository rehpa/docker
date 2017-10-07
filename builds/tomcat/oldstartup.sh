#!/bin/bash

COUNTER=0
while [ $(find /nfsmount -type f -iname "*.war" | wc -l) -le 0 ] ; do
	echo The counter is $COUNTER
	let COUNTER=COUNTER+1
	if [[ $COUNTER -ge 1000000 ]] ; then
		echo file never arrived
		exit 0
	fi

done
echo "WAR file(s) found in /nfsmount, starting copy and deploy"

cp /nfsmount/*.war /opt/tomcat/webapps/ROOT.war

exec /opt/tomcat/bin/catalina.sh run

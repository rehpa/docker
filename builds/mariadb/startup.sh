#!/bin/bash
set -e
ll /var/lib/mysql/
COUNTER=0
while [ $(find /var/lib/mysql/ -name donotremove.txt | wc -l) -eq 1 ] ; do
	echo The counter is $COUNTER
	let COUNTER=COUNTER+1
	if [[ $COUNTER -ge 1000000 ]] ; then
		echo "NFS share never mounted"
		exit 0
	fi

done

chown -R mysql:mysql /var/lib/mysql

if [[ $(ls /var/lib/mysql | wc -l) -le "2" ]] ; then
	/usr/bin/mysql_install_db --user=mysql --basedir=/usr/ --ldata=/var/lib/mysql/
fi

exec /usr/bin/mysqld_safe --syslog  --socket=/tmp/mysql1.sock --pid-file=/tmp/mysql1.pid




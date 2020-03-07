#! /bin/bash
if [ $# -eq 0 ] ; then
    /sbin/slapd -d0
    exit 0
fi

case $1 in
	'initdb')
		bash /opt/docker/install.sh;;
	'initdbedt')
		bash /opt/docker/installedt.sh;;
	'listdn')
		slapcat | grep dn;;
	'start')
		/sbin/slapd -d0;;
esac


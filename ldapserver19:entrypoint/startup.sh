#! /bin/bash
# startup.sh
#________________________________

case $1 in
	'initdb')
		bash /opt/docker/install.sh
    bash /opt/docker/service.sh;;
	'initdbedt')
		bash /opt/docker/installedt.sh
    bash /opt/docker/service.sh;;
	'listdn')
		slapcat | grep dn;;
	'start')
		 bash /opt/docker/service.sh;;
    *)
    eval $*;
esac

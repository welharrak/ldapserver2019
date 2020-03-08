#! /bin/bash
# Start service
#________________________________

ulimit -n 1024

if [ $# -eq 0 ] ; then
  echo "..."
fi

/sbin/slapd -d0

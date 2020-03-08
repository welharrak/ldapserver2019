#! /bin/bash
# Install ldap server
#________________________________
rm -rf /etc/openldap/slapd.d/*
rm -rf /var/lib/ldap/*

cp /opt/docker/DB_CONFIG /var/lib/ldap

slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d

chown -R ldap.ldap /etc/openldap/slapd.d
chown -R ldap.ldap /var/lib/ldap


cp /opt/docker/ldap.conf /etc/openldap

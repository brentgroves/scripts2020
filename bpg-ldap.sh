#!/bin/bash -e
docker run --name ldap-service \
--hostname ldap.buschecnc.com \
--env LDAP_ADMIN_PASSWORD="JesusLives1!" \
--volume /data/slapd/database:/var/lib/ldap \
--volume /data/slapd/config:/etc/ldap/slapd.d \
--env LDAP_ORGANISATION="Busche Performance Group" \
--env LDAP_DOMAIN="buschecnc.com" \
--detach osixia/openldap:1.1.8
docker run --name phpldapadmin-service \
--hostname phpldapadmin.buschecnc.com \
--link ldap-service:ldap-host \
--env PHPLDAPADMIN_LDAP_HOSTS=ldap-host \
--detach osixia/phpldapadmin:0.9.0

PHPLDAP_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" phpldapadmin-service)

echo "Go to: https://$PHPLDAP_IP"
echo "Login DN: cn=admin,dc=example,dc=org"
echo "Password: admin"
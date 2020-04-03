#!/bin/bash -e
sudo docker container start ldap-service
sudo docker container start phpldapadmin-service

PHPLDAP_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" phpldapadmin-service)

echo "Go to: https://$PHPLDAP_IP"
echo "Login DN: cn=admin,dc=buschecnc,dc=com"
echo "Password: JesusLives1!"


#!/bin/bash
read -p "Enter user name: " username
echo "Enter password: "
read -s pass
read -p "Enter the string to encrypt: " string
curl 'https://52.193.130.59:8154/go/api/admin/encrypt' \
-u "$username:$pass" \
-H 'Accept: application/vnd.go.cd.v1+json' \
-H 'Content-Type: application/json' \
-X POST -d "{ \"value\": \"$string\" }" --insecure

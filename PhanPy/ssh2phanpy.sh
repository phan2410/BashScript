#!/bin/bash

auth_token='xxx'

public_url=$(curl -s -X GET \
    -H "Authorization: Bearer $auth_token" \
    -H "Content-Type: application/json" \
    -H "Ngrok-Version: 2" \
    https://api.ngrok.com/endpoints | grep -o '"public_url":"[^"]*' | sed 's/"public_url":"//')
host=$(echo "$public_url" | sed 's#tcp://##' | awk -F: '{print $1}')
port=$(echo "$public_url" | awk -F: '{print $3}')

ssh -i $HOME/.ssh/phanpy fan@$host -p $port

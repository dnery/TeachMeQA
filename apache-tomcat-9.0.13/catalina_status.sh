#!/usr/bin/env bash

if [[ $(curl -X -GET -w "${respose_code}" -s -o /dev/null --no-keepalive http://localhost:8080) == "200" ]]; then
    echo "Catalina is Running"
else
    echo "Cataline is Down"
fi

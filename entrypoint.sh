#!/usr/bin/env bash

set -e

trap "echo 'SIGTERM received, exiting...'; exit" SIGTERM
trap "echo 'SIGTERM received, exiting...'; exit" SIGINT

while true; do 
    sleep 10 &
    wait $!
done
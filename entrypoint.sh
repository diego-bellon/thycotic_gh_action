#!/bin/sh -l
echo "username $1"
echo "password $2"
echo "secret-id $3"
time=$(date)
echo "::set-output name=secret-value::$time"

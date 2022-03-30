#!/bin/sh -l
echo "controllerURL $1"
echo "username $2"
echo "password $3"
time=$(appgate_service_configurator status)
echo "::set-output name=secret-value::$time"

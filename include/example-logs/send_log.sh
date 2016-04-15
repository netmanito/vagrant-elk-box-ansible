#!/bin/bash

#send messages to testlog and check if logstash works.

while true
do

message='{"@timestamp":"'`date -u "+%Y-%m-%dT%H:%M:%S.%s"`'+01:00","@fields":{"level":"INFO","logger":"queryLog","properties":{"log4net:HostName":"hostMachine"},"exception":null},"@message":{"documentTitle":"Proving that Android’s, Java’s and Python’s sorting algorithm is broken (and showing how to fix it)"}}'

echo $message >> testlog

sleep 15
done

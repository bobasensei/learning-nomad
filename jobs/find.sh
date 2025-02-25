#!/bin/sh

ID=$(curl -s --get http://pym:4646/v1/allocations --data-urlencode 'filter=TaskGroup matches "stores-server"' | jq .[].ID -r)

echo $ID

#ADDRESS=$(curl -s http://pym:4646/v1/allocation/$ID/services | jq .[].Address -r)
#PORT=$(curl -s http://pym:4646/v1/allocation/$ID/services | jq .[].Port -r)

#echo $ADDRESS $PORT

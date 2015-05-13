#!/bin/bash

key="ACSKEY_HERE"

curl -b cookies.txt -c cookies.txt -F "login=ACSUSERNAME_HERE" -F "password=ACSPASSWORD_HERE" "https://api.cloud.appcelerator.com/v1/users/login.json?key=$key"


INPUT=acs_geofences.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo “$INPUT file not found”; exit 99; }
while read name num id latitude longitude
do
	echo "Name : $name"
	echo "OSIS : $num"
	echo "ID : $id"
	echo "Latitude : $latitude"
	echo "Longitude : $longitude"

	payloadid=$num":"$id


curl -b cookies.txt -c cookies.txt -X POST -F 'geo_fence={"loc":{"coordinates":['$longitude','$latitude'], "radius":"170/6378137"}, "payload":{"name":"'$name'","id":"'$payloadid'"}}' "http://api.cloud.appcelerator.com/v1/geo_fences/create.json?key=$key&pretty_json=true"


done < $INPUT
IFS=$OLDIFS

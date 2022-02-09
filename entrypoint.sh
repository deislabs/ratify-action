#!/bin/sh -l
# exit on first error and prevent filename expansion
set -euf

[ -f certfile ] && rm certfile
for cert in $(echo $1 | tr "," "\n")
do
       echo  \"$cert\" >> certfile
done
jq --slurpfile cert certfile '.verifiers.plugins as $plugins | .verifiers.plugins[$plugins | map(.name == "notaryv2") | index(true)].verificationCerts |= $cert' /config.json > /.ratify/config.json
output=$(/app/ratify verify -s "$2")
echo "::set-output name=verification::$output"
success=$(echo $output | jq '.isSuccess')
if [ $success = 'true' ]
then
    exit 0
fi

exit 1
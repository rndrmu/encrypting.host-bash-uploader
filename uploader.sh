#!/bin/bash
#mkdir "${HOME}/Pictures/screenshots"
file=$RANDOM
file="${HOME}/Pictures/screenshots/${file}.png"

while [ -f $file ]; do # file exists already
        file=$RANDOM
        file="${HOME}/Pictures/screenshots/${file}.png"
done

flameshot gui -r >> $file

password="$(tr -dc A-Za-z0-9 </dev/urandom | head -c 45 ; echo '' )"
response="$(curl -XPOST -F'password="'$password'"' -F'userKey=blahblahblah' -F'urlStyle=embed' -F'title=based.host' -F'color=5865F2' -F'domains=[\"\"]' -F'file=@"'$file'"' https://encrypting.host/upload | jq -r '.data[0].Url')"

echo $response | clipboard

# Uncomment if you want to shorten the URLs
# requires waa.ai api key
#url=$response;

#jsonresponse="$(curl -X POST -H "Content-Type: application/json" -H "Authorization: API-Key " -d '{"url": "'$url'"}' https://api.waa.ai/v2/links | jq -r '.data.link')"

#echo $jsonresponse | clipboard

notify-send "Uploaded Successfully!"

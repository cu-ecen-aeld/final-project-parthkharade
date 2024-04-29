#!/bin/bash

source token.sh
OPERATION=$1
case $OPERATION in
  "previous")
    RESULT=$(curl -k --request POST \
  --url https://api.spotify.com/v1/me/player/previous \
  --header "Authorization: Bearer $ACCESS_TOKEN");;
  "next")
   RESULT=$(curl -k --request POST \
  --url https://api.spotify.com/v1/me/player/next \
  --header "Authorization: Bearer $ACCESS_TOKEN");;
  "pause")
    RESULT=$(curl -k --request PUT \
  --url https://api.spotify.com/v1/me/player/pause \
  --header "Authorization: Bearer $ACCESS_TOKEN");;
  "play")
    RESULT=$(curl -k --request PUT \
  --url https://api.spotify.com/v1/me/player/play \
  --header "Authorization: Bearer $ACCESS_TOKEN");;
    *)
    echo "Invalid operation";;
esac

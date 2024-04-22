#!/bin/bash

source token.sh
result=$(curl -s -k --request GET \
  --url https://api.spotify.com/v1/me/player/currently-playing \
  --header "Authorization: Bearer $ACCESS_TOKEN")

status_code=$(echo $result | jq -r '.error.status')
if [ "$status_code" == "401" ]; then
  source refresh_token.sh
  return 0
fi

if [ "$result" == "" ]; then
  clear
  echo "No song is currently playing."
  return 0
fi
song_name=$(echo $result | jq -r '.item.name')
album_name=$(echo $result | jq -r '.item.album.name')
artist_name=$(echo $result | jq -r '.item.artists[0].name')
progress_min=$(echo $result | jq -r '.progress_ms' | awk '{printf "%02d", int($1/60000)}')
progress_sec=$(echo $result | jq -r '.progress_ms' | awk '{printf "%02d", int($1/1000)%60}')
total_min=$(echo $result | jq -r '.item.duration_ms' | awk '{printf "%02d", int($1/60000)}')
total_sec=$(echo $result | jq -r '.item.duration_ms' | awk '{printf "%02d", int($1/1000)%60}')

clear
printf "Now Playing: %s by %s from %s\n" "$song_name" "$artist_name" "$album_name"
printf "Progress: %s:%s / %s:%s\n" "$progress_min" "$progress_sec" "$total_min" "$total_sec"
 

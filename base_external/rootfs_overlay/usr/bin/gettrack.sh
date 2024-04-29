#!/bin/bash


DEST_IP="10.0.0.211"
DEST_PORT=9000
LOG_FILE="log.txt"
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
  # echo "No song is currently playing."
  PACKET_DATA="No song is currently playing.$"
  echo -n "$PACKET_DATA" | nc -w1 $DEST_IP $DEST_PORT
  return 0
fi
song_name=$(echo $result | jq -r '.item.name')
album_name=$(echo $result | jq -r '.item.album.name')
artist_name=$(echo $result | jq -r '.item.artists[0].name')
progress_min=$(echo $result | jq -r '.progress_ms' | awk '{printf "%02d", int($1/60000)}')
progress_sec=$(echo $result | jq -r '.progress_ms' | awk '{printf "%02d", int($1/1000)%60}')
total_min=$(echo $result | jq -r '.item.duration_ms' | awk '{printf "%02d", int($1/60000)}')
total_sec=$(echo $result | jq -r '.item.duration_ms' | awk '{printf "%02d", int($1/1000)%60}')

PACKET_DATA="$song_name""#""$artist_name""#""$progress_min:$progress_sec / $total_min:$total_sec$"
REC=$(printf "%s" "$PACKET_DATA" | nc -w2 $DEST_IP $DEST_PORT)
if [ ! -z $REC ]; then
  source playback.sh $REC
fi
 

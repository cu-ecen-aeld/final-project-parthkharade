# Replace this with your actual refresh token
TOKEN_FILE=/usr/bin/token.sh
source $TOKEN_FILE

# Define the token URL
token_url="https://accounts.spotify.com/api/token"

# Construct the Authorization header value
auth_header="Basic $(echo -n "$CLIENT_ID:$CLIENT_SECRET" | base64)"
# Construct the payload for the POST request

# --header 'Cookie: __Host-device_id=AQD-AzulkO3m8X9mW1A0VNiv7NudwJLA_Bk_bogM2UZaAtZi09PPD7_QJ-OAsIU_aG3pmznz4Evg1_r2U8TnY0lISzSwkBkOBI8; sp_tr=false' \
response=$(curl -s -k --location 'https://accounts.spotify.com/api/token' \
--header 'content-type: application/x-www-form-urlencoded' \
--header "Authorization: Basic YTY4MWFkYzNiYWU4NDAwNzk1YmIxOTBiNWFkNmFlNDk6MzAyY2JiNzgyZGEwNDdkZTk4NmZmMGI1MWQ5ZTQxYjI=" \
--data-urlencode "refresh_token=$REFRESH_TOKEN" \
--data-urlencode 'grant_type=refresh_token')

# Extract the access token and refresh token from the response
access_token=$(echo "$response" | jq -r '.access_token')
# Print the access token and refresh token
if [[ ! access_token == "null" ]] && [[ ! -z $REFRESH_TOKEN ]]; then
echo "ACCESS_TOKEN=$access_token" > $TOKEN_FILE
echo "REFRESH_TOKEN=$REFRESH_TOKEN" >> $TOKEN_FILE 
echo "CLIENT_ID=$CLIENT_ID" >> $TOKEN_FILE 
echo "CLIENT_SECRET=$CLIENT_SECRET" >> $TOKEN_FILE 
fi

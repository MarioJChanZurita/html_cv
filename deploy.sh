#!/bin/bash

# Apagar NGINX y NGROK
sudo service nginx stop
pkill ngrok

# Bajar ultimos cambios
git pull origin main

# Encender NGINX
sudo service nginx start

# run ngrok in the background
ngrok http 8080 --log=stdout >/dev/null &

# Get NGROK dynamic URL from its own exposed local API
NGROK_REMOTE_URL=""
while [ -z "$NGROK_REMOTE_URL" ]; do
  NGROK_REMOTE_URL="$(curl -s http://localhost:4040/api/tunnels | jq ".tunnels[0].public_url")"
  sleep 1
done

echo $NGROK_REMOTE_URL

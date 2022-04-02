#! /bin/bash

# Port you want to listen on. If this host isn't publicly accessible you'll need to port forward. 
# If you change this, you need to update the port in htdocs/sample.html
PORT=8181

# Start docker. 
docker pull roverr/rtsp-stream:2 2>&1 > /dev/null
echo Starting Docker on listening port $PORT
docker run -d -e 'RTSP_STREAM_AUDIO_ENABLED=true' -e 'RTSP_STREAM_CORS_ENABLED=true' -e 'RTSP_STREAM_CORS_ALLOWED_ORIGIN=*' -v $PWD/rtsp-stream.yml:/app/rtsp-stream.yml --restart unless-stopped -p $PORT:8080 poptix/rtsp-stream:2


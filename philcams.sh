#! /bin/bash

# List of cameras. These URLs work for Dahua and similar cameras, a good way to discover the proper URL is by browsing with ONVIF Device Manager on desktop, or Onvier on Android. 
# Don't forget to enter your username/password, which is sometimes different for Onvif 
CAMS="
rtsp://admin:admin@192.168.1.14:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif
rtsp://admin:admin@192.168.1.15:554/cam/realmonitor?channel=1&subtype=0&unicast=true&proto=Onvif
"

# Port you want to listen on. If this host isn't publicly accessible you'll need to port forward. 
# If you change this, you need to update the port in htdocs/sample.html
PORT=8181

# Start docker. 
docker pull roverr/rtsp-stream:2 2>&1 > /dev/null
docker kill philcams 2>&1 > /dev/null
docker rm philcams 2>&1 > /dev/null
echo Starting Docker on listening port $PORT
docker run -d --name philcams --restart unless-stopped -p $PORT:8080 roverr/rtsp-stream:2

# Add the cameras to docker
COUNT=0
echo Starting Streams
for i in $CAMS; do 
	RESULT=`curl -s http://127.0.0.1:$PORT/start   -H 'Content-Type: application/json;charset=UTF-8' --data-raw "{\"uri\":\"$i\",\"alias\":\"$COUNT\"}"`
	if [ `echo ${RESULT} |grep -c '"running":true'` -le 0 ]; then
		echo Stream number $COUNT failed for some reason, usually a bad password.
		echo $RESULT
	else 
		echo Stream $COUNT started successfully.
	fi
	COUNT=$(expr $COUNT + 1)
done

# philcams

Stupid easy way to get your local security camera streams onto the Internet. 

- Edit rtsp-stream.yml to add your cameras. 

- Run philcams.sh 

- Drop the contents of htdocs/ on a publicly accessible url, adjust for your IP address, port, and number of cameras. 

- Load your modified sample.html in a web browser


Requirements: 

docker

A web server somewhere

The host running the docker container must be able to access your cameras (or DVR) and either have a public IP, or a port forwarded to it from your router. 


Gotchas: 

Do not use private IP addresses for the stream urls in sample.html, you'll get CORS violations. There are workarounds for different browsers if you absolutely must. 

Many security cameras and their whitelabels have different passwords for the web interface and ONVIF users. Beware that your login password may not be the stream password.  


Thanks to hls.min.js and rtsp-stream for making this easy: 

https://github.com/Roverr/rtsp-stream/

https://github.com/video-dev/hls.js/



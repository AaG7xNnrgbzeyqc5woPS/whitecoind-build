# build
 docker build -t whitecoind:v0.4 .

# run whitecoind deamon
docker run \
  -itd \
  --restart=always \
  --privileged \
  --name 0.4 \
  -P \
  -p 127.0.0.1:15815:15815 \
  whitecoind:v0.4 \
  /root/script/start_whitecoind
 

# run whitecoin client
docker exec -it xwc_0.4 /bin/bash


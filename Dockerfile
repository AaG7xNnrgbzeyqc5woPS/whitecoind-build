#!/bin/bash
# version 0.5
# date:  2020.2.1
# Last fixed: 2020.2.22
# by john

FROM ubuntu:16.04

WORKDIR /root

RUN   apt update && \
      apt install -y sudo tree pwgen \
                   man git tmux tree zip nano vim && \
      apt install -y build-essential \
                     libssl-dev  \
                     libdb++-dev  \
                     libboost-all-dev \
                     libqrencode-dev \
                     miniupnpc \
                     libminiupnpc-dev && \
      apt autoremove -y

RUN   git clone https://github.com/peterli360/whitecoin-1.git  whitecoin && \
      cd whitecoin/src && \
      make -f makefile.unix USE_UPNP=- && \
      cd /root/whitecoin/src && \
      strip whitecoind && \
      cp whitecoind /usr/local/bin

RUN   cd /root/whitecoin && \
      git pull && \
      cd /root/whitecoin/src && \
      make -f makefile.unix USE_UPNP=- && \
      cd /root/whitecoin/src && \
      strip whitecoind && \
      cp -f whitecoind /usr/local/bin

COPY  ./script/ ./script/

WORKDIR /root/script

CMD ["/bin/bash", "-c", "./start_whitecoind"]

EXPOSE 15814 15815


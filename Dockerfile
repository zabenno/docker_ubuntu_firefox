FROM ubuntu:20.04

LABEL maintainer="zabenno"

#Installing dependencies.
RUN apt update && DEBIAN_FRONTEND='noninteractive' apt upgrade -y && DEBIAN_FRONTEND='noninteractive' apt install -y --no-install-recommends \
    pulseaudio \
    firefox \
    xdg-utils \
    gnupg \
    fonts-dejavu-core fonts-freefont-ttf fonts-liberation fonts-lklug-sinhala \
    fonts-sil-abyssinica fonts-sil-padauk fonts-thai-tlwg fonts-tibetan-machine \
    fonts-indic fonts-kacst-one fonts-khmeros-core fonts-lao fonts-lyx \
    dmz-cursor-theme libavcodec58 && \
    apt-key adv --keyserver --keyserver.ubuntu.com --recv-keys BF36996C4E1F8A59 &&\
    echo "deb http://ppa.launchpad.net/elementary-os/stable/ubuntu bionic main" >> /etc/apt/sources.list && \
    apt update && \
    apt install -y --no-install-recommends pantheon-files && \
    rm -rf /var/lib/apt/lists/* 

#Creating firefox user and group.
RUN groupadd -r firefox && \
    useradd -r -m -g firefox -G audio,video firefox

#Creating and setting permissions for firefox policies to be loaded at runtime.
RUN mkdir -p /usr/lib/firefox/distribution/ && \
    touch /usr/lib/firefox/distribution/policies.json && \
    chmod 644 /usr/lib/firefox/distribution/policies.json && \
    chown firefox:firefox /usr/lib/firefox/distribution/policies.json

USER firefox

#Setting default app for file browser to pcmanfm.
RUN mkdir /home/firefox/.config && \
    xdg-mime default firefox.desktop audio/mp3

#Setting firefox to launch.
ENTRYPOINT ["firefox"]

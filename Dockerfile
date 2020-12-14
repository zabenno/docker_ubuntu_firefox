FROM ubuntu:18.04

LABEL maintainer="zabenno"

#Installing dependencies.
RUN apt update && DEBIAN_FRONTEND='noninteractive' apt upgrade -y && DEBIAN_FRONTEND='noninteractive' apt install -y --no-install-recommends \
    pulseaudio \
    firefox \
    xdg-utils \
    software-properties-common \
    libavcodec57 && \
    apt-add-repository ppa:elementary-os/os-patches && \
    apt-add-repository ppa:elementary-os/stable && \
    apt update && \
    DEBIAN_FRONTEND='noninteractive' apt install -y --no-install-recommends pantheon-files && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -r firefox && \
    useradd -r -m -g firefox -G audio,video firefox && \
    su -c "mkdir /home/firefox/.config" firefox && \
    DEBIAN_FRONTEND='noninteractive' apt remove software-properties-common xdg-utils -y && \
    DEBIAN_FRONTEND='noninteractive' apt autoremove -y

USER firefox

#Setting firefox to launch.
ENTRYPOINT ["firefox"]

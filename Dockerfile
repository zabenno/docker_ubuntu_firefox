FROM ubuntu:18.04

MAINTAINER zabenno

RUN apt update
RUN apt upgrade -y

##Installing firefox.
RUN apt install firefox -y
#Installing required packages for audio.
RUN apt install pulseaudio -y

#Creating a user so we don't have to run as root.
RUN useradd appuser --create-home --home-dir /home/appuser
#Adding the user to the audio group.
RUN gpasswd -a appuser audio

#Changing user to unprivileged user.
USER appuser

#Setting firefox to launch.
ENTRYPOINT ["firefox"]

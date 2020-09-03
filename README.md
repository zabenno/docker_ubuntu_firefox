# docker_ubuntu_firefox
## Overview
This container will launch a standard firefox browser with the ability to browse the file system of the container. The goal of this container is to provide a near native experience, therefore size is not a priority.

## Security
I chose Firefox for a containerised browser application as it's method of sandboxing allows for it to still be active when running in a non privileged container. This is in contrast to Chromium based browsers that either require the container to be give permissions or to run the browser with the `--no-sandbox` due to their use of Linux namespaces.

The following is a list of security considerations:
* Firefox runs within the container as a standard user. The user does not have sudo.
* An the container can be launched with an Apparmor profile to further restrict actions within the container.
* A connection to the hosts X11 and Pulseaudio servers are required.
* The container does not require any privileges.

## Running the container
You can run the container in it's default configuration by using the docker-compose file found in the github repo. If you get an error saying you are unable to connect to the display, it is most likely permissions on your X11 server, a quick and dirty hack for this is `xhost +`.
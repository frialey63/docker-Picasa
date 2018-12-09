# Dockerfile for Picasa
#
# Linux kabah 4.4.0-96-generic #119~14.04.1-Ubuntu SMP Wed Sep 13 08:40:48 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
# Docker version 17.05.0-ce, build 89658be
#
# docker build -t picasa .
# xhost +
# docker run -i --rm --net=host --ipc=host -v /home/paul:/home/paul -v /mnt/media/Pictures:/media picasa

FROM 32bit/debian

RUN	apt-get update && \
	apt-get upgrade -y && \

	apt-get install -y --no-install-recommends wget && \
	apt-get install -y --no-install-recommends ca-certificates && \
	apt-get install -y --no-install-recommends wine && \
	apt-get install -y --no-install-recommends cabextract && \

	wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && chmod +x winetricks && mv winetricks /usr/local/bin && \

	apt-get autoremove -y --purge wget && \
	apt-get autoremove -y --purge && \
	apt-get clean -y && \

	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd -g 1000 paul
RUN useradd -u 1000 -g paul -d /home/paul -s /bin/bash paul

ENV DISPLAY :0.0
ENV HOME /home/paul

USER paul
WORKDIR /home/paul
CMD wine "c:\Program Files\Google\Picasa3\Picasa3.exe"


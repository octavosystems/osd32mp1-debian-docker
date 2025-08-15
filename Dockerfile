FROM debian:buster

ARG PUID
ENV PUID=${PUID:-1000}

ARG PGID
ENV PGID=${PGID:-1000}

ENV ENTRYPOINT ${ENTRYPOINT:-/docker-entrypoint.sh}

RUN printf "deb http://archive.debian.org/debian buster main contrib non-free\n" > /etc/apt/sources.list && \
    printf "deb http://archive.debian.org/debian-security buster/updates main contrib non-free\n" >> /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get -y -q \
	upgrade \
	udev \
	sudo \
	locales \
	locales-all \
	git \
	build-essential \
	gcc-arm-linux-gnueabihf \
	gcc-arm-none-eabi \
	libssl-dev \
	device-tree-compiler \
	u-boot-tools \
	libncurses-dev \
	flex \
	bison \
	python \
	bc \
	multistrap \
	qemu-user-static \
	gdisk \
	unzip \
	openjdk-11-jre \
	libusb-1.0-0 \
	kmod \
	libguestfs-tools \
	&& apt-get clean

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

COPY ./docker-entrypoint.sh /

# Install STM32CubeProg
#COPY ./st-tools/en.stm32cubeprog_v2-4-0.zip /tmp/
#RUN unzip /tmp/en.stm32cubeprog_v2-4-0.zip -d /tmp/
#RUN printf "1\n1\n1\n\nO\n1\nY\nY\nY\n1\nN\nN\nN\n1\n" | ./tmp/SetupSTM32CubeProgrammer-2.4.0.linux
#RUN cp /usr/local/STMicroelectronics/STM32Cube/STM32CubeProgrammer/Drivers/rules/*.* /etc/udev/rules.d/

ENTRYPOINT ["./docker-entrypoint.sh"]

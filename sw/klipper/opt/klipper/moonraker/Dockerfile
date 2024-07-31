FROM debian:12
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get clean

RUN apt-get update && \
    apt-get install -y \
      python3 \
      python3-pip \
      python3-venv \
      && \
    apt-get clean

RUN apt-get update && \
    apt-get install -y \
      python3-virtualenv \
      python3-dev \
      libopenjp2-7 \
      libsodium-dev \
      zlib1g-dev \
      libjpeg-dev \
      packagekit \
      wireless-tools \
      curl \
      build-essential \
      && \
    apt-get clean

RUN python3 -m venv venv && \
    venv/bin/pip install moonraker

ENTRYPOINT ["python3", "moonraker" ]

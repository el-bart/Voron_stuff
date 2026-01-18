# pip's package has issues on Debian:13 - skipping for now
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
      iproute2 \
      && \
    apt-get clean

RUN python3 -m venv venv && \
    venv/bin/pip install moonraker==0.9.3

# needed for /opt/klipper/docs...
RUN apt-get update && \
    apt-get install -y \
      git \
      && \
    apt-get clean
RUN git clone \
          "https://github.com/Klipper3d/klipper" \
          "/opt/klipper" && \
    cd "/opt/klipper" && \
    git checkout --quiet "v0.13.0"

ENTRYPOINT ["venv/bin/moonraker", \
              "--configfile", "/mnt/config/moonraker.cfg", \
              "--datapath", "/mnt/data", \
              "--logfile", "/mnt/logs/moonraker.log", \
              "--unixsocket", "/mnt/run/moonraker.sock" ]

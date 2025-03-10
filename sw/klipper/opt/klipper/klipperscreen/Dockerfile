FROM debian:12
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get clean

RUN apt-get update && \
    apt-get install -y \
      git \
      && \
    apt-get clean

RUN apt-get update && \
    apt-get install -y \
      python3-venv \
      libgirepository1.0-dev \
      gcc \
      libcairo2-dev \
      pkg-config \
      python3-dev \
      gir1.2-gtk-3.0 \
      librsvg2-common \
      libopenjp2-7 \
      libdbus-glib-1-dev \
      autoconf \
      fonts-nanum \
      fonts-ipafont \
      libmpv-dev \
      && \
    apt-get clean

RUN git clone \
          "https://github.com/KlipperScreen/KlipperScreen.git" \
          "/opt/klipperscreen" && \
    cd "/opt/klipperscreen" && \
    git checkout --quiet "v0.4.5"

RUN python3 -m venv venv && \
    venv/bin/pip install -r "/opt/klipperscreen/scripts/KlipperScreen-requirements.txt"

RUN apt-get update && \
    apt-get install -y \
      x11-xserver-utils \
      && \
    apt-get clean

ENTRYPOINT ["venv/bin/python", "/opt/klipperscreen/screen.py", \
              "--configfile", "/mnt/config/klipperscreen.cfg", \
              "--logfile", "/mnt/logs/klipperscreen.log" ]

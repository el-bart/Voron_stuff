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
      python3 \
      python3-pip \
      python3-numpy \
      python3-venv \
      && \
    apt-get clean

RUN git clone \
          "https://github.com/Klipper3d/klipper" \
          "/opt/klipper" && \
    cd "/opt/klipper" && \
    git checkout "12cd1d9e81c32b26ccc319af1dfc3633438908f1"

RUN apt-get update && \
    apt-get install -y \
      libffi-dev \
      python3-greenlet \
      python3-cffi \
      python3-serial \
      python3-jinja2 \
      && \
    apt-get clean

RUN python3 -m venv venv && \
    venv/bin/pip install -r "/opt/klipper/scripts/klippy-requirements.txt" && \
    venv/bin/python -m compileall "/opt/klipper/klippy" && \
    venv/bin/python "/opt/klipper/klippy/chelper/__init__.py"

ENTRYPOINT ["python3", "/opt/klipper/klippy/klippy.py", \
              "--input-tty", "/mnt/run/klipper.tty", \
              "--api-server", "/mnt/run/klipper.sock", \
              "/mnt/config/printer.cfg" ]

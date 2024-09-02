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
      gcc \
      make \
      cmake \
      && \
    apt-get clean

RUN git clone \
          "https://github.com/Klipper3d/klipper" \
          "/opt/klipper" && \
    cd "/opt/klipper" && \
    git checkout --quiet "12cd1d9e81c32b26ccc319af1dfc3633438908f1"
COPY klipper_mcu_config /opt/klipper/.config
RUN cd "/opt/klipper" && \
    make -j$(nproc) && \
    cp -v "out/klipper.elf" "/usr/local/bin/klipper_mcu"

# helper debug tool
RUN apt-get update && \
    apt-get install -y \
      python3-spidev \
      && \
    apt-get clean
COPY adxl_test /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/klipper_mcu", \
              "-r", \
              "-I", "/mnt/run/klipper_host_mcu" ]

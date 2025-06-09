#
# build env
#
FROM debian:12 as server_builder
RUN apt-get update && apt-get dist-upgrade -y

RUN apt-get update && apt-get install -y \
    cmake \
    make \
    ninja-build \
    g++

RUN apt-get update && apt-get install -y \
    gdb \
    vim

RUN apt-get update && apt-get install -y \
    libopencv-dev

RUN apt-get update && apt-get install -y \
    libboost-program-options-dev

# BUT installation
RUN apt-get update && apt-get install -y \
    wget \
    nlohmann-json3-dev \
    catch2
ENV BUT_VER=2.1.0
RUN cd /usr/src/ && \
    wget "https://github.com/el-bart/but/archive/v${BUT_VER}.tar.gz" && \
    tar xzvf "v${BUT_VER}.tar.gz" && \
    cd "but-${BUT_VER}/" && \
    mkdir -p "build" && \
    cd "build" && \
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../src/cmake/toolchains/gcc.cmake .. && \
    ninja && \
    ninja install && \
    cd /usr/src/ && \
    rm "v${BUT_VER}.tar.gz" && \
    cd "but-${BUT_VER}"

#
# server compilation
#
RUN apt-get update && apt-get install -y \
    unzip
ENV MJPEG_SERVER_VER="v1.0.0"
ENV MJPEG_SERVER_SHA="ad9eff8a24bee5e3a29b732f7ceb9de07604c48397d2616f0bc7dc3bbb080521"
RUN cd /usr/src/ && \
    wget -O "$MJPEG_SERVER_VER.zip" "https://github.com/el-bart/mjpeg_cam_stream_server/archive/refs/tags/$MJPEG_SERVER_VER.zip" && \
    sha256sum "$MJPEG_SERVER_VER.zip" && \
    [ "$(sha256sum < "$MJPEG_SERVER_VER.zip")" = "$MJPEG_SERVER_SHA  -" ] && \
    unzip "$MJPEG_SERVER_VER.zip" && \
    mv mjpeg_cam_stream_server-* "mjpeg_cam_stream_server" && \
    cd "mjpeg_cam_stream_server" && \
    mkdir -p build/ && \
    cd build && \
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Release ../src/ && \
    ninja -j 2 mjpeg_cam_stream_server && \
    cp -v mjpeg_cam_stream_server /usr/local/bin/

#
# runtime
#
FROM debian:12
RUN apt-get update && apt-get dist-upgrade -y

RUN apt-get update && apt-get install -y \
    libopencv-videoio406 \
    libboost-program-options1.74.0

COPY --from=server_builder /usr/local/bin/mjpeg_cam_stream_server /usr/local/bin/
ENTRYPOINT ["mjpeg_cam_stream_server"]

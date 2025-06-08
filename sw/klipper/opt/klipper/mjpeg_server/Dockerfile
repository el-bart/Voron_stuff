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
ENV MJPEG_SERVER_VER="3a3aecac9c6a7f9f5405754af9ea8bd727789465"
ENV MJPEG_SERVER_SHA="dde3096da26489c5577ea814b1f7f25a7d8f98b2e01c9d94a51993d51330b12c"
RUN cd /usr/src/ && \
    wget "https://github.com/el-bart/mjpeg_cam_stream_server/archive/$MJPEG_SERVER_VER.zip" && \
    sha256sum "$MJPEG_SERVER_VER.zip" && \
    [ "$(sha256sum < "$MJPEG_SERVER_VER.zip")" = "$MJPEG_SERVER_SHA  -" ] && \
    unzip "$MJPEG_SERVER_VER.zip" && \
    mv "mjpeg_cam_stream_server-$MJPEG_SERVER_VER" "mjpeg_cam_stream_server" && \
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

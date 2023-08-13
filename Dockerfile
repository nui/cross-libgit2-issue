FROM rust:1.71-buster

RUN apt-get -yq update \
    && apt-get -yq install curl

RUN URL=https://github.com/rust-cross/cargo-zigbuild/releases/download/v0.17.0/cargo-zigbuild-v0.17.0.x86_64-unknown-linux-musl.tar.gz \
    && filename=$(basename $URL) \
    && curl -sSL -o $filename $URL \
    && tar -C /usr/local/bin --no-same-owner -xf $filename \
    && rm $filename

RUN URL=https://ziglang.org/builds/zig-linux-x86_64-0.12.0-dev.80+014d88ef6.tar.xz \
    && filename=$(basename $URL) \
    && curl -sSL -o $filename $URL \
    && tar -C /usr/local/bin --no-same-owner --strip-components=1 -xf $filename \
    && rm $filename

COPY / /workspace

WORKDIR /workspace

# This works
# RUN cargo zigbuild --release

# Doesn't work for some reason?
RUN cargo zigbuild --release --target x86_64-unknown-linux-gnu

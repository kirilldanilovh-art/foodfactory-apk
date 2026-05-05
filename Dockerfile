FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    git \
    zip \
    unzip \
    openjdk-17-jdk \
    autoconf \
    libtool \
    pkg-config \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libtinfo5 \
    cmake \
    libffi-dev \
    libssl-dev \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip
RUN pip3 install buildozer cython

# Патчим buildozer - убираем проверку root
RUN sed -i 's/def check_root(self):/def check_root(self):\n        return/' $(find /usr/local/lib -name "__init__.py" -path "*/buildozer/*") 2>/dev/null || true

WORKDIR /app

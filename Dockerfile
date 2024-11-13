# Gunakan image dasar Ubuntu untuk memulai
FROM ubuntu:20.04

# Install dependensi dasar yang dibutuhkan untuk build dan mining
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    python3 \
    python3-pip \
    libssl-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Install mining software (MRIG atau mining software lain yang mendukung rx/0 atau RandomX)
RUN curl -sSL https://github.com/some-mining-rig-setup/mrig/releases/download/latest/mrig.tar.gz | tar -xz -C /opt/

# Salin file konfigurasi rig mining dari lokal ke dalam container
COPY mrig-config.json /opt/mrig/config/

# Set direktori kerja
WORKDIR /opt/mrig

# Jalankan mining rig saat container dijalankan
CMD ["./mrig", "-c", "/opt/mrig/config/mrig-config.json"]

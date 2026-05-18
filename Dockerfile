FROM python:3.9-slim-bullseye

# Install system dependencies including build tools for picamera2
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    python3-dev \
    libffi-dev \
    libgpiod2 \
    libgnutls28-dev \
    python3-pip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install libcamera and python3-libcamera from official .deb packages
RUN wget http://archive.raspberrypi.org/debian/pool/main/libc/libcamera/libcamera0.5_0.5.0+rpt20250429-1_arm64.deb && \
    wget http://archive.raspberrypi.org/debian/pool/main/libc/libcamera/libcamera-dev_0.5.0+rpt20250429-1_arm64.deb && \
    wget http://archive.raspberrypi.org/debian/pool/main/libc/libcamera/python3-libcamera_0.5.0+rpt20250429-1_arm64.deb && \
    dpkg -i libcamera0.5_0.5.0+rpt20250429-1_arm64.deb && \
    dpkg -i libcamera-dev_0.5.0+rpt20250429-1_arm64.deb && \
    dpkg -i python3-libcamera_0.5.0+rpt20250429-1_arm64.deb && \
    apt-get install -f -y && \
    rm *.deb

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]

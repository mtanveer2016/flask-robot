
FROM arm32v7/debian:bullseye
# or for 64-bit Raspberry Pi:
# FROM arm64v8/debian:bullseye

COPY . /app
WORKDIR /app

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    gcc \
    make \
    python3-dev \
    libffi-dev \
    libgpiod2 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    libcamera-dev \
    python3-libcamera \
    python3-pyqt5 \
    python3-picamera2 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -r requirements.txt
CMD ["python3", "app.py"]

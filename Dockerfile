#FROM python:3.14-slim
FROM python:3.9-slim-bullseye
COPY . /app
WORKDIR /app

# Install system dependencies for GPIO, SPI, I2C, Camera (libcamera), and OpenCV
RUN apt-get update && apt-get install -y \
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
    # Camera and libcamera dependencies
    libcamera-dev \
    python3-libcamera \
    python3-pyqt5 \
    # Install picamera2 directly from the system repository
    python3-picamera2 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -r requirements.txt
CMD ["python", "app.py"]

FROM python:3.9-slim-bullseye

# Add the official Raspberry Pi repository
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg curl && \
    curl -sSL https://archive.raspberrypi.org/debian/raspberrypi.gpg.key | apt-key add - && \
    echo "deb http://archive.raspberrypi.org/debian/ bullseye main" > /etc/apt/sources.list.d/raspi.list && \
    apt-get update

# Install system dependencies including picamera2 requirements
RUN apt-get install -y \
    gcc \
    g++ \
    make \
    python3-dev \
    libffi-dev \
    libgpiod2 \
    libcamera-dev \
    python3-libcamera \
    python3-pyqt5 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]

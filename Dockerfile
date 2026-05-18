FROM python:3.9-slim-bullseye

# Install all system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
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
    python3-prctl \
    && rm -rf /var/lib/apt/lists/*

COPY . /app
WORKDIR /app

# Upgrade pip and install Python packages
RUN pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "app.py"]

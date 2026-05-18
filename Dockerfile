
FROM python:3.9-slim-bullseye

# Install system dependencies including picamera2 requirements
RUN apt-get update && apt-get install -y \
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

# Copy and install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]

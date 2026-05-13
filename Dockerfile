FROM python:3.9-slim-bullseye

COPY . /app
WORKDIR /app

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
    # picamera2 dependencies
    libcamera-dev \
    python3-libcamera \
    python3-pyqt5 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

CMD ["python", "app.py"]

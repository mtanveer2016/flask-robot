FROM python:3.9-slim-bullseye

# Install system dependencies including python-prctl
RUN for i in 1 2 3; do \
      apt-get update && \
      apt-get install -y \
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
        python3-prctl \
      && break \
      || sleep 5; \
    done && \
    rm -rf /var/lib/apt/lists/*

COPY . /app
WORKDIR /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

CMD ["python", "app.py"]

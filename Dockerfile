#FROM python:3.14-slim
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
    && rm -rf /var/lib/apt/lists/*

RUN pip install -r requirements.txt
CMD ["python", "app.py"]

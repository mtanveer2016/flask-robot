FROM python:3.14-slim
COPY . /app
WORKDIR /app
RUN apt-get update && apt-get install -y \
    gcc \
    make \
    python3-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*
RUN pip install -r requirements.txt
CMD ["python", "app.py"]

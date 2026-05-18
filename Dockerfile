FROM python:3.9-slim-bullseye

# Install all system build tools and dependencies in ONE layer
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    python3-dev \
    libffi-dev \
    libgpiod2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy and install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "app.py"]

# Use official Python slim image — no need to force platform inside Dockerfile
FROM python:3.11-slim

# Install essential system tools and libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    build-essential \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy dependencies first (for Docker layer caching)
COPY requirements.txt .

# Install Python dependencies, including gunicorn
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 8000

# Run the application with gunicorn (assumes your main file is app.py with `app` defined)
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]

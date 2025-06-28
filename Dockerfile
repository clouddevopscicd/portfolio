# Use appropriate Python slim image, no platform forcing
FROM python:3.11-slim

# Ensure essential tools are available
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    build-essential \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# Copy application code
COPY . .

# Expose app port
EXPOSE 8000

# Start Gunicorn server
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]

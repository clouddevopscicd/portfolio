# Use official Python ARM64-compatible slim image
FROM --platform=linux/arm64 python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies (optional but good for stability)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Ensure gunicorn is installed (safety net)
RUN pip install --no-cache-dir gunicorn

# Copy project files
COPY . .

# Expose port
EXPOSE 8000

# Run app using Gunicorn, compatible with ARM64
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]

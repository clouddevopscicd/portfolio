FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy requirement file and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Ensure gunicorn is installed, in case requirements.txt lacks it
RUN pip install gunicorn

# Copy entire project into container
COPY . .

# Expose port for app
EXPOSE 8000

# Start the app with gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]

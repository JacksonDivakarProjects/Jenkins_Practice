FROM python:3.11-slim

# Avoid writing .pyc files and ensure stdout/stderr are unbuffered
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install Python deps if a requirements.txt is provided. Using --no-cache-dir to reduce image size.
COPY requirements.txt /app/requirements.txt
RUN if [ -f /app/requirements.txt ]; then pip install --no-cache-dir -r /app/requirements.txt; fi

# Copy application code
COPY . /app

# Create a non-root user and make them own the application files
RUN useradd -m appuser || true
RUN chown -R appuser:appuser /app

USER appuser

# Default command
CMD ["python", "sample.py"]
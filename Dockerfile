# Dockerfile (at repo root)
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy all files
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose default Flask port (we can override per container)
EXPOSE 5000

# Default command
CMD ["python", "app.py"]

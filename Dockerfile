# Stage 1: Install dependencies
FROM python:3.12-slim AS builder


WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip --no-cache-dir --default-timeout=100 --retries=5 \
 && pip install --user --no-cache-dir -r requirements.txt --default-timeout=100 --retries=5

# Stage 2: Copy only necessary files
FROM python:3.12-slim

ENV PATH=/root/.local/bin:$PATH

WORKDIR /app

# Copy only installed packages from builder stage
COPY --from=builder /root/.local /root/.local
COPY app.py .

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

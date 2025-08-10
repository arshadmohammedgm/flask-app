# Stage 1: Install dependencies
FROM python:3.12-slim AS builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --user -r requirements.txt

# Stage 2: Copy only necessary files
FROM python:3.12-slim

ENV PATH=/root/.local/bin:$PATH
WORKDIR /app

COPY --from=builder /root/.local /root/.local
COPY app.py .

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]

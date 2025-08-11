# Flask Microservice — CI/CD + Kubernetes

A tiny Flask service with `/health` and `/data`, containerized and deployed via GitHub Actions to Kubernetes with probes, limits, and basic config.

## Endpoints
- `GET /health` → `200 OK`
- `GET /data` → `{"message": "Hello from DevOps!"}` (overridable via `APP_MESSAGE`)

---

## Run Locally
```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -r app/requirements.txt
export APP_ENV=development APP_MESSAGE="Hello local!"
python app/app.py
# http://localhost:5000/data

docker build -t app-flask  .
docker run -p 5000:5000 -e APP_ENV=local -e APP_MESSAGE="Hello from Devops!" app-flask:latest

from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/health')
def health():
    return '200 ok', 200

@app.route('/data')
def data():
    msg = os.getenv("APP_MESSAGE", "Hello from DevOps!")
    env = os.getenv("APP_ENV", "development")
    return jsonify({"message": msg, "env": env})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "Hello, World!"

@app.route("/error")
def error():
    app.logger.error("Error endpoint hit.")
    return jsonify({"error": "Bad Request"}), 400

if __name__ == "__main__":
    import logging
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    app.run(host="0.0.0.0", port=5000)
import logging
from logging.handlers import RotatingFileHandler

# Configure logging
handler = RotatingFileHandler("app.log", maxBytes=10000, backupCount=3)
logging.basicConfig(
    handlers=[handler],
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
)
app.logger.setLevel(logging.INFO)


from flask import Flask, jsonify, request
import requests

app = Flask(__name__)

SECRET_VALUE = '123e4567-e89b-12d3-a456-426614174000'
EXTERNAL_API_URL = 'http://api.openweathermap.org/data/2.5/weather'

@app.route('/get-weather')
def get_weather():
    city = request.args.get('city', 'London')
    response = requests.get(f'{EXTERNAL_API_URL}?q={city}&appid={SECRET_VALUE}')
    if response.status_code == 200:
        return jsonify(response.json())
    else:
        return jsonify({'error': 'Failed to fetch data'}), response.status_code

if __name__ == '__main__':
    app.run()
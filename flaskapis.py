from flask import Flask,jsonify,request
import json
import joblib


app = Flask(__name__)


@app.route('/<float:hour>/<float:temperature>/<float:temperature_min>/<float:temperature_max>/<float:pressure>/<float:humidity>/<float:wind_speed>/<float:wind_deg>/<float:aqi>/<float:co>/<float:no2>/<float:o3>/<float:so2>/<float:pm2_5>/<float:pm10>/<float:nh3>/<float:hr>/')
def model(hour, temperature, temperature_min, temperature_max, pressure, humidity, wind_speed, wind_deg, aqi, co, no2, o3, so2, pm2_5, pm10, nh3, hr):
    model = joblib.load('asthma_model.joblib')
    x_values=[hour, temperature, temperature_min, temperature_max, pressure, humidity, wind_speed, wind_deg, aqi, co, no2, o3, so2, pm2_5, pm10, nh3, hr]
    prediction = model.predict([x_values])
    return jsonify({"value" : prediction[0]})

# http://127.0.0.1:5000/22.0/2.54/0.77/4.84/1040.0/98.0/0.51/0.0/2.0/283.72/20.39/21.99/2.27/11.64/16.40/0.39/83.0 test url
# flask --app flaskapis run
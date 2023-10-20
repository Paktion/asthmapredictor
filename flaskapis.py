from flask import Flask
import json
import joblib
import pandas as pd
import joblib
import requests


app = Flask(__name__)


@app.route('/<int:hr>/<float:temp>/<float:temp_min>/<float:temp_max>/<float:pressure>/<float:humidity>/<float:wind_speed>/<float:aqi>')
def hello(hr,temp,temp_min,temp_max,pressure,humidity,wind_speed,aqi):
    model = joblib.load('asthma_model.joblib')

    prediction = model.predict([[temp,temp_min,temp_max,pressure,humidity,wind_speed,aqi,hr]])
    print(prediction)
    return json.dumps({"value" : prediction[0]})

requests.get("url")
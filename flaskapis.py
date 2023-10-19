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

    prediction = model.predict([[hr,temp,temp_min,temp_max,pressure,humidity,wind_speed,aqi]])
    print(prediction)
    return str(prediction[0])
from flask import Flask
import json
import joblib


app = Flask(__name__)


@app.route('/<int:hr>/<float:temp>/<float:temp_min>/<float:temp_max>/<float:humidity>/<float:wind_speed>/<float:wind_deg>/<float:aqi>')
def hello(temp,temp_min,temp_max,humidity,wind_speed,wind_deg,aqi,hr):
    model = joblib.load('asthma_model.joblib')

    prediction = model.predict([[temp,temp_min,temp_max,humidity,wind_speed,wind_deg,aqi,hr,0,0,0,0,0,0,0,0,0]])
    return json.dumps({"value" : prediction[0]})
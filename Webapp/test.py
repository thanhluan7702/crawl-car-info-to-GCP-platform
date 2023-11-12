from flask import Flask, redirect, url_for, render_template, request, jsonify
import pickle
import numpy as np
import pandas as pd


app = Flask(__name__)
model = pickle.load(open('../model_predict/model.pkl', 'rb'))

@app.route('/')
def home():
    return render_template('index.html',**locals())

@app.route('/predict',methods=['POST'])
def predict():
    int_features = [int(x) for x in request.form.values()]
    print(int_features)
    final_features = [np.array(int_features)]
    result = model.predict(final_features)
    output = round(result[0], 2)
    return render_template('index.html', prediction_text='Predicted Price {}'.format(output),**locals())

if __name__ == '__main__':
    app.run(debug=True)


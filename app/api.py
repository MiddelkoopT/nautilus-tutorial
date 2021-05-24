## Simple Flask server

import flask
import os

print("api.py")

api = flask.Flask(__name__)
api.config['DEBUG']=True

@api.route('/')
def root():
    return 'true'

@api.route('/v1/echo/<string>')
def echo(string):
    return {'echo': string}

@api.route('/v1/command', methods=['POST'])
def command():
    data = flask.request.get_json()
    return {'command': str(data)}

api.run(host='::', port=os.getenv('PORT',8080), debug=True)

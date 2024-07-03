from os import environ
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
   target = environ.get('TARGET', 'World')
   return f"Hello {target}!\n"

if __name__ == '__main__':
   app.run(debug=True, host='0.0.0.0', port=int(environ.get('PORT', 8080)))

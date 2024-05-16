from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy                         #new: Flask-SQLAlchemy

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///project.db"  #new: config

db = SQLAlchemy()												#new: create SQLAlchemy 'db'
db.init_app(app)												#new: init_app

    
@app.route("/")
def index():
    return render_template("index.html")   

if __name__ == '__main__':
    app.run(debug=True, port=8080)
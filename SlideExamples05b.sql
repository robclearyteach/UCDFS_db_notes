
-- ## Pre: No /instance folder (or remove if exists first)

from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy							#new: Flask-SQLAlchemy

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///project.db"  #new: config

db = SQLAlchemy()												#new: create SQLAlchemy 'db'
db.init_app(app)												#new: init_app

    
@app.route("/")
def index():
    return render_template("index.html")   




-- ##
    
@app.route("/")
def index():
    db.session.execute(text("CREATE TABLE user( id INT, username TEXT)"))			#add db.session.execute(SQL)
    return render_template("index.html")   



-- ##

CREATE TABLE user (
    id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO user (username, email, password) VALUES ('john_doe', 'john@example.com', 'password123');
INSERT INTO user (username, email, password) VALUES ('jane_smith', 'jane@example.com', 'p@$$w0rd');
INSERT INTO user (username, email, password) VALUES ('mike_jones', 'mike@example.com', 'securepassword');

-- ## Then:
    
@app.route("/")
def index():
    user_data = db.session.execute(text("SELECT * FROM user"))
    return render_template("index.html", users=user_data)  #pass 'user_data'
	
-- ## THEN @ index.html add jinja block
-- ## 		{% for user in users %}
-- ## 		    <p>{{ user }}</p>
-- ## 		{% endfor %}



-- ## pip install psycopg2
-- ## 
-- ## THEN


app = Flask(__name__)
#change to postgres
app.config["SQLALCHEMY_DATABASE_URI"] = "postgresql+psycopg2://testuser:test123@localhost/dvdrental"  

db = SQLAlchemy()												
db.init_app(app)												

    
@app.route("/")
def index():
	# change to variables (SQL, data) and db.session.execute(SQL, data)
    SQL = text( "SELECT first_name, last_name, email FROM customer WHERE first_name = :first_name")
    data = [{"first_name": "Mary"}]    
    user_data = db.session.execute( SQL, data)
    return render_template("index.html", users = user_data) 







-- ## eg.4
-- ## 
-- ## NOTE: For passwords
-- ##   should not be storing a password!
-- ##   typical:  a hash
-- ## @see Section 'Password Hashing' here
-- ## https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-v-user-logins
								

--# #Add a Flask-SQLAlchemy model class
from sqlalchemy import  Column, Integer, Text, TIMESTAMP
from datetime import datetime
class User(db.Model):
    id          = db.Column(db.Integer, primary_key=True)
    username    = db.Column(db.Text, nullable=False)
    email       = db.Column(db.Text, unique=True, nullable=False)
	##WARNING: SECURITY: Do NOT store a password like this: just for play here
    password    = db.Column(db.Text, nullable=False)
    created_at  = db.Column(db.TIMESTAMP, default=datetime.utcnow, nullable=False)

@app.route("/")
def index():
    user_data = User.query.all()                             #Flask-SQLAlchemy
    return render_template("index.html", users = user_data) 
	
	


-- ## See alternative:
@app.route("/")
def index():
    user_data = db.session.execute( db.select(User) ).scalars()
    return render_template("index.html", users = user_data) 
	
-- ## and
--     user_data = db.session.execute( db.select(User).order_by(User.username) ).scalars()

-- ## https://docs.sqlalchemy.org/en/20/tutorial/data_select.html
-- ## https://flask-sqlalchemy.palletsprojects.com/en/3.0.x/legacy-query/




-- ## add user_form.html
{% extends "base.html" %}

{% block content %}
    <form  >
        <label for="username">username</label>
        <input type="text" id="username" name="username">
        <label for="email">email</label>
        <input type="text" id="email" name="email">
        <label for="password">password</label>
        <input type="text" id="password" name="password">

        <button type="submit">Submit</button>
    </form>
{% endblock %}


-- ## app.py
@app.route("/user", methods=["GET"])
def user_form():
    return render_template("user_form.html")

@app.route("/user", methods=["POST"])
def user_insert():
    username = request.form["username"]
    email    = request.form["email"]
    password = request.form["password"]
    return f"<h2> Post Data Received: <h2> <p>{username}, {email}, {password} </p>"

-- ## 
    <form action="{{ url_for('user_insert') }}" method="POST">
       <label for="username">username</label>
        <input type="text" id="username" name="username">
        <label for="email">email</label>
        <input type="text" id="email" name="email">
        <label for="password">password</label>
        <input type="text" id="password" name="password">

        <button type="submit">Submit</button>
    </form>
{% endblock %}



	
-- ## 
	new_user = User(        
	   username = request.form["username"]
	 , email    = request.form["email"]
	 , password = request.form["password"]
	)
	db.session.add()
	db.session.commit()
	return redirect( url_for('index') )



-- ##

        <p>{{ user.username }} -- {{ user.email }}
			<a href="{{url_for('user_delete')}}">[Delete]</a>
		</p>


@app.route("/user_delete")
def user_delete():
    return f"<h2> Gone to user_delete end-point <h2>"
	
-- ## 
		  <a href="{{url_for('user_delete', user_id=user.id)}}">

-- ## 
@app.route("/user_delete/<int:user_id>")
def user_delete(user_id):
    user = User.query.get_or_404(user_id)
    db.session.delete(user)
    db.session.commit()
    return redirect( url_for('index'))


-- ##
    {% for user in users %}
        <p>{{ user.username }} -- {{ user.email }}
                <a href="{{url_for('user_delete', user_id=user.id)}}">[Delete]</a>
                <a href="{{url_for('user_edit', user_id=user.id)}}">[Edit]</a>
		</p>
    {% endfor %}
	
-- ## add the route
@app.route("/user_edit/<int:user_id>")
def user_edit(user_id):
    user_data = User.query.get_or_404(user_id)
    return render_template("user_edit.html", user=user_data)

-- ## add user_edit.html
    <form  action="{{ url_for('user_update', user_id=user.id) }}" method="POST">
        <label for="username">username</label>
        <input type="text" id="username" name="username" value="{{user.username}}">
        <label for="email">email</label>
        <input type="text" id="email" name="email" value="{{user.email}}">
        <label for="password">password</label>
        <input type="text" id="password" name="password" value="{{user.password}}">

        <button type="submit">Submit</button>
    </form>

-- ## 
@app.route("/user_update/<int:user_id>", methods=["POST"])
def user_update(user_id):
    user = User.query.get_or_404(user_id)
    new_username = request.form["username"]
    new_email    = request.form["email"]
    new_password = request.form["password"]
    user.username = new_username
    user.email    = new_email
    user.password = new_password
    db.session.commit()

    return redirect( url_for('index') )









-- ##
-- ## config.py 

import os

# For production: use secret key:
# To generate:
# python -c "import secrets;print(secrets.token_hex())"
SECRET_KEY = os.getenv('SECRET_KEY', 'replace with generated key here')

SQLALCHEMY_DATABASE_URI = "sqlite:///test.db"

"""
#WAY2:
SQLALCHEMY_DATABASE_URI = os.getenv('SQLALCHEMY_DATABASE_URI', "sqlite:///test.db")

## BETTER:
## Get from ENV variable or revert to connection string as default
"""


-- ## AND THEN
app.config.from_object('config')


-- ##								

with app.app_context():
    db.create_all()


-- ##
class User(db.Model):
    id       = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.Text, nullable=False)
    emails   = db.relationship('Email', backref='user', lazy=True)

class Email(db.Model):
    id      = db.Column(db.Integer, primary_key=True)
    email   = db.Column(db.String(120), unique=True, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)


-- ## app.py add import to Email
from models import db, User, Email

-- ## change the user_insert
	username = request.form["username"]
	password = request.form["password"]
	email = request.form["email"]
	new_user = User(        
		  username = request.form["username"]
		, password = request.form["password"]
	)
	new_email = Email(
		  email = email
		, user  = new_user  #associate email with user
	)
	db.session.add(new_user)
	db.session.add(new_email)





-- ## 
    user_id = db.Column(db.Integer, db.ForeignKey('user.id',ondelete='CASCADE'),  nullable=False)

    emails   = db.relationship('Email', backref='user', cascade="all, delete-orphan",lazy=True)




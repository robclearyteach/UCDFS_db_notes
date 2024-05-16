from flask import Flask, render_template, request, url_for, redirect
from sqlalchemy import text										
from models import db, User, Email

app = Flask(__name__)
app.config.from_object('config')
db.init_app(app)												

with app.app_context():
    db.create_all()


@app.route("/")
def index():
    user_data = User.query.all()                             #Flask-SQLAlchemy
    return render_template("index.html", users = user_data) 

@app.route("/user", methods=["GET"])
def user_form():
    return render_template("user_form.html")

@app.route("/user_edit/<int:user_id>")
def user_edit(user_id):
    user_data = User.query.get_or_404(user_id)
    return render_template("user_edit.html", user=user_data)

@app.route("/user", methods=["POST"])
def user_insert():
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
    db.session.commit()
    return redirect( url_for('index') )

@app.route("/user_delete/<int:user_id>")
def user_delete(user_id):
    user = User.query.get_or_404(user_id)
    db.session.delete(user)
    db.session.commit()
    return redirect( url_for('index'))


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



if __name__ == '__main__':
    app.run(debug=True, port=8080)


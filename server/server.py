from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///openclass.db'
db = SQLAlchemy(app)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/students")
def get_all_students():
    query = text("SELECT * FROM student")
    result = db.session.execute(query)
    
    students = []
    for row in result:
        student = {key: value for key, value in row._mapping.items()}
        students.append(student)
    
    return jsonify(students)
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///openclass.db'
db = SQLAlchemy(app)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/students")
def students():
    first_name = request.args.get('first_name')
    last_name = request.args.get('last_name')
    grade = request.args.get('grade')
    
    query = "SELECT * FROM student WHERE 1=1"
    params = {}
    
    if first_name:
        query += " AND first_name LIKE :first_name"
        params['first_name'] = f"%{first_name}%"
    
    if last_name:
        query += " AND last_name LIKE :last_name"
        params['last_name'] = f"%{last_name}%"
    
    if grade:
        query += " AND grade = :grade"
        params['grade'] = grade
    
    result = db.session.execute(text(query), params)
    
    students = []
    for row in result:
        student = {key: value for key, value in row._mapping.items()}
        students.append(student)
    
    return jsonify(students)
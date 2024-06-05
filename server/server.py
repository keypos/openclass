from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

app = Flask(__name__)
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///openclass.db'
db = SQLAlchemy(app)

@app.route("/")
def hello_world():
    return "<p>Server is running</p>"

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

@app.route("/subjects")
def subjects():
    subject_name = request.args.get('subject_name')
    coordinator = request.args.get('coordinator')
    
    query = "SELECT * FROM subject WHERE 1=1"
    params = {}
    
    if subject_name:
        query += " AND subject_name LIKE :subject_name"
        params['subject_name'] = f"%{subject_name}%"
    
    if coordinator:
        teacher = db.session.execute(text(f"SELECT teacher_id FROM teacher WHERE first_name LIKE :coordinator"), {"coordinator": f"%{coordinator}%"}).fetchone()
        if teacher:
            teacher_id = teacher[0]
        else:
            teacher_id = None

        query += " AND teacher_id = :teacher_id"
        params['teacher_id'] = teacher_id
    
    result = db.session.execute(text(query), params)
    
    subjects = []
    for row in result:
        subject = {key: value for key, value in row._mapping.items()}

        teacher = db.session.execute(text(f"SELECT first_name, last_name FROM teacher WHERE teacher_id = :teacher_id"), {"teacher_id": subject['teacher_id']}).fetchone()
        subject['coordinator'] = f"{teacher[0]} {teacher[1]}"

        subjects.append(subject)
    
    return jsonify(subjects)


@app.route("/students/<int:id>")
def student(id):
    result = db.session.execute(text(f"SELECT * FROM student WHERE student_id = :id"), {"id": id})
    row = result.fetchone()
    
    if row is None:
        return jsonify({"error": "Student not found"}), 404
    
    student = {key: value for key, value in row._mapping.items()}
    return jsonify(student)

@app.route("/subjects/<int:id>")
def subject(id):
    result = db.session.execute(text(f"SELECT * FROM subject WHERE subject_id = :id"), {"id": id})
    row = result.fetchone()
    
    if row is None:
        return jsonify({"error": "Subject not found"}), 404
    
    subject = {key: value for key, value in row._mapping.items()}
    
    teacher = db.session.execute(text(f"SELECT first_name, last_name FROM teacher WHERE teacher_id = :teacher_id"), {"teacher_id": subject['teacher_id']}).fetchone()
    subject['coordinator'] = f"{teacher[0]} {teacher[1]}"
    
    return jsonify(subject)


@app.route("/students/<int:id>", methods=["DELETE"])
def delete_student(id):
    db.session.execute(text(f"DELETE FROM student WHERE student_id = :id"), {"id": id})
    db.session.commit()
    
    return jsonify({"message": "Student deleted"})


@app.route("/students", methods=["POST"])
def create_student():
    student = request.json
    db.session.execute(text("INSERT INTO student (first_name, last_name, grade) VALUES (:first_name, :last_name, :grade)"), student)
    db.session.commit()
    
    return jsonify({"message": "Student created"})

@app.route("/subjects", methods=["POST"])
def create_subject():
    subject = request.json
    db.session.execute(text("INSERT INTO subject (subject_name, teacher_id) VALUES (:subject_name, :teacher_id)"), subject)
    db.session.commit()
    
    return jsonify({"message": "Subject created"})

@app.route("/students/<int:id>", methods=["PUT"])
def update_student(id):
    student = request.json
    db.session.execute(text("UPDATE student SET first_name = :first_name, last_name = :last_name, grade = :grade WHERE student_id = :id"), {**student, "id": id})
    db.session.commit()
    
    return jsonify({"message": "Student updated"})

@app.route("/subjects/<int:id>", methods=["PUT"])
def update_subject(id):
    subject = request.json
    db.session.execute(text("UPDATE subject SET subject_name = :subject_name, teacher_id = :teacher_id WHERE subject_id = :id"), {**subject, "id": id})
    db.session.commit()
    
    return jsonify({"message": "Subject updated"})

@app.route("/teachers")
def teachers():
    first_name = request.args.get('first_name')
    last_name = request.args.get('last_name')
    
    query = "SELECT * FROM teacher WHERE 1=1"
    params = {}
    
    if first_name:
        query += " AND first_name LIKE :first_name"
        params['first_name'] = f"%{first_name}%"
    
    if last_name:
        query += " AND last_name LIKE :last_name"
        params['last_name'] = f"%{last_name}%"
    
    result = db.session.execute(text(query), params)
    
    teachers = []
    for row in result:
        teacher = {key: value for key, value in row._mapping.items()}
        teachers.append(teacher)
    
    return jsonify(teachers)
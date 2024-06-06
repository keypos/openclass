from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from datetime import datetime

app = Flask(__name__)
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///openclass.db'
db = SQLAlchemy(app)


@app.route("/")
def hello_world():
    return "<p>Server is running</p>"

@app.route('/classes', methods=['GET'])
def get_teacher_periods():
    date_str = request.args.get('date')
    teacher_id = request.args.get('teacher_id')
    
    if not date_str or not teacher_id:
        return jsonify({'error': 'Please provide both date and teacher_id'}), 400
    
    try:
        date = datetime.strptime(date_str, '%Y-%m-%d').date()
    except ValueError:
        return jsonify({'error': 'Invalid date format. Use YYYY-MM-DD.'}), 400
    
    query = text('''
    SELECT p.period_id, p.room, s.subject_name
    FROM period p
    JOIN timetable t ON p.timetable_id = t.timetable_id
    JOIN subject s ON p.subject_id = s.subject_id
    WHERE t.teacher_id = :teacher_id AND t.timetable_date = :timetable_date
    ''')
    
    result = db.session.execute(query, {'teacher_id': teacher_id, 'timetable_date': date}).fetchall()
    
    periods = [{'period_id': row[0], 'room': row[1], 'subject_name': row[2]} for row in result]
    
    return jsonify(periods)


@app.route("/students")
def students():
    first_name = request.args.get('first_name')
    last_name = request.args.get('last_name')
    grade = request.args.get('grade')
    print(request.args.get("date"))
    print(request.args.get('first_name'))
    
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
        teacher = db.session.execute(text(f"SELECT teacher_id FROM teacher WHERE first_name LIKE :coordinator OR last_name LIKE :coordinator"), {"coordinator": f"%{coordinator}%"}).fetchone()
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

@app.route("/assessments")
def assessments():
    subject_id = request.args.get('subject_id')
    
    query = "SELECT * FROM assessment WHERE 1=1"
    params = {}
    
    if subject_id:
        query += " AND subject_id = :subject_id"
        params['subject_id'] = subject_id
    
    result = db.session.execute(text(query), params)
    
    assessments = []
    for row in result:
        assessment = {key: value for key, value in row._mapping.items()}
        assessments.append(assessment)
    
    return jsonify(assessments)


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

@app.route("/assessments/<int:id>")
def assessment(id):
    result = db.session.execute(text(f"SELECT * FROM assessment WHERE assessment_id = :id"), {"id": id})
    row = result.fetchone()
    
    if row is None:
        return jsonify({"error": "Assessment not found"}), 404
    
    assessment = {key: value for key, value in row._mapping.items()}
    return jsonify(assessment)


@app.route("/students/<int:id>", methods=["DELETE"])
def delete_student(id):
    db.session.execute(text(f"DELETE FROM student WHERE student_id = :id"), {"id": id})
    db.session.commit()
    
    return jsonify({"message": "Student deleted"})

@app.route("/subjects/<int:id>", methods=["DELETE"])
def delete_subject(id):
    db.session.execute(text(f"DELETE FROM subject WHERE subject_id = :id"), {"id": id})
    db.session.commit()
    
    return jsonify({"message": "Subject deleted"})

@app.route("/assessments/<int:id>", methods=["DELETE"])
def delete_assessment(id):
    db.session.execute(text(f"DELETE FROM assessment WHERE assessment_id = :id"), {"id": id})
    db.session.commit()
    
    return jsonify({"message": "Assessment deleted"})

@app.route("/students", methods=["POST"])
def create_student():
    student = request.json
    db.session.execute(text("INSERT INTO student (first_name, last_name, grade, email, phone, dob) VALUES (:first_name, :last_name, :grade, :email, :phone, :dob)"), student)
    db.session.commit()
    
    return jsonify({"message": "Student created"})

@app.route("/subjects", methods=["POST"])
def create_subject():
    subject = request.json
    db.session.execute(text("INSERT INTO subject (subject_name, teacher_id) VALUES (:subject_name, :teacher_id)"), subject)
    db.session.commit()
    
    return jsonify({"message": "Subject created"})

@app.route("/assessments", methods=["POST"])
def create_assessment():
    assessment = request.json
    db.session.execute(text("INSERT INTO assessment (assessment_name, max_mark, date_due, subject_id) VALUES (:assessment_name, :max_mark, :date_due, :subject_id)"), assessment)
    db.session.commit()
    
    return jsonify({"message": "Assessment created"})

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

@app.route("/assessments/<int:id>", methods=["PUT"])
def update_assessment(id):
    assessment = request.json
    db.session.execute(text("UPDATE assessment SET assessment_name = :assessment_name, subject_id = :subject_id WHERE assessment_id = :id"), {**assessment, "id": id})
    db.session.commit()
    
    return jsonify({"message": "Assessment updated"})

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
CREATE TABLE address (
    address_id INTEGER PRIMARY KEY AUTOINCREMENT,
    street VARCHAR(64) NOT NULL,
    postcode VARCHAR(64) NOT NULL,
    state VARCHAR(3) NOT NULL
);

CREATE TABLE guardian (
    guardian_id INTEGER PRIMARY KEY AUTOINCREMENT,
    address_id INT,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(64) NOT NULL,
    phone VARCHAR(64) NOT NULL,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE teacher (
    teacher_id INTEGER PRIMARY KEY AUTOINCREMENT,
    address_id INT,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(64) NOT NULL,
    phone VARCHAR(64) NOT NULL,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE student (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    grade INT,
    dob DATE NOT NULL,
    email VARCHAR(64) NOT NULL,
    phone VARCHAR(16) NOT NULL
);

CREATE TABLE timetable (
    timetable_id INTEGER PRIMARY KEY AUTOINCREMENT,
    teacher_id INT,
    timetable_date DATE NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);

CREATE TABLE relationship (
    relationship_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INT,
    guardian_id INT,
    relationship_type VARCHAR(32) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (guardian_id) REFERENCES guardian(guardian_id)
);

CREATE TABLE subject (
    subject_id INTEGER PRIMARY KEY AUTOINCREMENT,
    teacher_id INT,
    subject_name VARCHAR(64) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);

CREATE TABLE assessment (
    assessment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    subject_id INT,
    assessment_name VARCHAR(64) NOT NULL,
    max_mark INT NOT NULL,
    date_due DATE NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);

CREATE TABLE class (
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    subject_id INT,
    teacher_id INT,
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id),
    FOREIGN KEY (teacher_id) REFERENCES teacher(teacher_id)
);

CREATE TABLE behaviour (
    behaviour_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INT,
    comment TEXT NOT NULL,
    comment_date DATE NOT NULL,
    FOREIGN KEY (class_id) REFERENCES class(class_id)
);

CREATE TABLE period (
    period_id INTEGER PRIMARY KEY AUTOINCREMENT,
    timetable_id INT,
    class_id INT,
    period_number INT NOT NULL,
    room VARCHAR(64),
    FOREIGN KEY (timetable_id) REFERENCES timetable(timetable_id),
    FOREIGN KEY (class_id) REFERENCES class(class_id)
);

CREATE TABLE student_subjects (
    student_subjects_id INTEGER PRIMARY KEY AUTOINCREMENT,
    subject_id INT,
    student_id INT,
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

CREATE TABLE mark (
    mark_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INT,
    assessment_id INT,
    mark INT NOT NULL,
    comment TEXT,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (assessment_id) REFERENCES assessment(assessment_id)
);
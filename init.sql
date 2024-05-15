CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    grade INT,
    dob DATE NOT NULL,
    email VARCHAR(64) NOT NULL,
    phone VARCHAR(16) NOT NULL
);

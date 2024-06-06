-- Insert addresses
INSERT INTO address (address_id, street, postcode, state) VALUES
(1, '123 Main St', '2000', 'NSW'),
(2, '456 High St', '3000', 'VIC'),
(3, '789 Park Ave', '4000', 'QLD'),
(4, '101 Lake Rd', '5000', 'SA'),
(5, '202 Hill St', '6000', 'WA'),
(6, '303 River Dr', '7000', 'TAS'),
(7, '404 Ocean Blvd', '0800', 'NT'),
(8, '505 Valley Ln', '2600', 'ACT'),
(9, '606 Forest Dr', '2010', 'NSW'),
(10, '707 Sunset Blvd', '3010', 'VIC');

-- Insert guardians
INSERT INTO guardian (guardian_id, address_id, first_name, last_name, dob, email, phone) VALUES
(1, 1, 'John', 'Smith', '1980-01-01', 'john.smith@example.com', '0412345678'),
(2, 2, 'Mary', 'Johnson', '1975-05-15', 'mary.johnson@example.com', '0412345679'),
(3, 3, 'Robert', 'Brown', '1982-08-21', 'robert.brown@example.com', '0412345680'),
(4, 4, 'Linda', 'Jones', '1978-11-30', 'linda.jones@example.com', '0412345681'),
(5, 5, 'Michael', 'Garcia', '1979-03-25', 'michael.garcia@example.com', '0412345682'),
(6, 6, 'Sarah', 'Miller', '1981-07-10', 'sarah.miller@example.com', '0412345683'),
(7, 7, 'James', 'Martinez', '1983-09-05', 'james.martinez@example.com', '0412345684'),
(8, 8, 'Patricia', 'Davis', '1984-12-20', 'patricia.davis@example.com', '0412345685');

-- Insert teachers
INSERT INTO teacher (teacher_id, address_id, first_name, last_name, dob, email, phone) VALUES
(1, 9, 'Alice', 'Wilson', '1985-02-15', 'alice.wilson@example.com', '0412345686'),
(2, 10, 'David', 'Taylor', '1977-06-22', 'david.taylor@example.com', '0412345687'),
(3, 1, 'Chris', 'Anderson', '1980-11-30', 'chris.anderson@example.com', '0412345688'),
(4, 2, 'Emma', 'Thomas', '1982-03-14', 'emma.thomas@example.com', '0412345689'),
(5, 3, 'Daniel', 'Jackson', '1979-07-18', 'daniel.jackson@example.com', '0412345690'),
(6, 4, 'Sophia', 'White', '1983-09-24', 'sophia.white@example.com', '0412345691'),
(7, 5, 'Michael', 'Harris', '1981-01-05', 'michael.harris@example.com', '0412345692'),
(8, 6, 'Emily', 'Clark', '1976-04-09', 'emily.clark@example.com', '0412345693');

-- Insert students
INSERT INTO student (student_id, first_name, last_name, grade, dob, email, phone) VALUES
(1, 'Olivia', 'Martinez', 7, '2010-01-10', 'olivia.martinez@example.com', '0412345694'),
(2, 'Liam', 'Smith', 8, '2009-02-15', 'liam.smith@example.com', '0412345695'),
(3, 'Ava', 'Johnson', 7, '2010-03-20', 'ava.johnson@example.com', '0412345696'),
(4, 'Noah', 'Brown', 9, '2008-04-25', 'noah.brown@example.com', '0412345697'),
(5, 'Isabella', 'Garcia', 10, '2007-05-30', 'isabella.garcia@example.com', '0412345698'),
(6, 'Lucas', 'Miller', 11, '2006-06-05', 'lucas.miller@example.com', '0412345699'),
(7, 'Mia', 'Wilson', 8, '2009-07-10', 'mia.wilson@example.com', '0412345700'),
(8, 'Ethan', 'Taylor', 7, '2010-08-15', 'ethan.taylor@example.com', '0412345701'),
(9, 'Sophia', 'Anderson', 9, '2008-09-20', 'sophia.anderson@example.com', '0412345702'),
(10, 'Logan', 'Thomas', 10, '2007-10-25', 'logan.thomas@example.com', '0412345703'),
(11, 'Emma', 'Jackson', 11, '2006-11-30', 'emma.jackson@example.com', '0412345704'),
(12, 'Alexander', 'White', 7, '2010-12-05', 'alexander.white@example.com', '0412345705'),
(13, 'Charlotte', 'Harris', 8, '2009-01-10', 'charlotte.harris@example.com', '0412345706'),
(14, 'Benjamin', 'Clark', 9, '2008-02-15', 'benjamin.clark@example.com', '0412345707'),
(15, 'Amelia', 'Martinez', 10, '2007-03-20', 'amelia.martinez@example.com', '0412345708'),
(16, 'Elijah', 'Davis', 11, '2006-04-25', 'elijah.davis@example.com', '0412345709');

-- Insert timetable
INSERT INTO timetable (timetable_id, teacher_id, timetable_date) VALUES
(1, 1, '2024-06-01'),
(2, 2, '2024-06-01'),
(3, 3, '2024-06-01'),
(4, 4, '2024-06-01'),
(5, 5, '2024-06-01'),
(6, 6, '2024-06-01'),
(7, 7, '2024-06-01'),
(8, 8, '2024-06-01');

-- Insert relationships
INSERT INTO relationship (relationship_id, student_id, guardian_id, relationship_type) VALUES
(1, 1, 7, 'Parent'),
(2, 2, 1, 'Parent'),
(3, 3, 2, 'Parent'),
(4, 4, 3, 'Parent'),
(5, 5, 4, 'Parent'),
(6, 6, 5, 'Parent'),
(7, 7, 1, 'Parent'),
(8, 8, 2, 'Parent'),
(9, 9, 3, 'Parent'),
(10, 10, 4, 'Parent'),
(11, 11, 5, 'Parent'),
(12, 12, 6, 'Parent'),
(13, 13, 7, 'Parent'),
(14, 14, 8, 'Parent'),
(15, 15, 1, 'Parent'),
(16, 16, 2, 'Parent');

-- Insert subjects
INSERT INTO subject (subject_id, teacher_id, subject_name) VALUES
(1, 1, 'Mathematics Extension 2'),
(2, 1, 'Mathematics Extension 1'),
(3, 1, 'Mathematics Advanced'),
(4, 1, 'Mathematics Standard'),
(5, 2, 'Visual Arts'),
(6, 2, 'Music'),
(7, 3, 'English Advanced'),
(8, 3, 'English Standard'),
(9, 4, 'Studies of Religion 2'),
(10, 4, 'Studies of Religion 1'),
(11, 4, 'Studies in Catholic Thought'),
(12, 5, 'Software Design and Development'),
(13, 5, 'Information Processes and Technology'),
(14, 6, 'Physics'),
(15, 6, 'Chemistry'),
(16, 6, 'Biology'),
(17, 7, 'Modern History'),
(18, 7, 'Ancient History'),
(19, 7, 'Geography'),
(20, 8, 'Business'),
(21, 8, 'Commerce'),
(22, 8, 'Law');

-- Insert assessments
INSERT INTO assessment (assessment_id, subject_id, assessment_name, max_mark, date_due) VALUES
(1, 1, 'Algebra Test', 100, '2024-07-01'),
(2, 2, 'Essay', 50, '2024-07-05'),
(3, 3, 'Physics Exam', 100, '2024-07-10'),
(4, 4, 'History Project', 100, '2024-07-15'),
(5, 5, 'Geography Quiz', 50, '2024-07-20'),
(6, 6, 'Fitness Test', 100, '2024-07-25'),
(7, 7, 'Painting', 50, '2024-07-30'),
(8, 8, 'Music Performance', 100, '2024-08-01');

-- Insert behaviours
INSERT INTO behaviour (behaviour_id, subject_id, comment, comment_date) VALUES
('1', 1, 'Excellent participation', '2024-05-01'),
('2', 2, 'Needs improvement in writing skills', '2024-05-02'),
('3', 3, 'Great understanding of concepts', '2024-05-03'),
('4', 4, 'Good effort in project', '2024-05-04'),
('5', 5, 'Active subject participation', '2024-05-05'),
('6', 6, 'Outstanding performance', '2024-05-06'),
('7', 7, 'Creative artwork', '2024-05-07'),
('8', 8, 'Excellent musical skills', '2024-05-08');

INSERT INTO student_subjects (student_subjects_id, subject_id, student_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 1, 9),
(10, 2, 10),
(11, 3, 11),
(12, 4, 12),
(13, 5, 13),
(14, 6, 14),
(15, 7, 15),
(16, 8, 16);

INSERT INTO mark (mark_id, student_id, assessment_id, mark, comment) VALUES
(1, 1, 1, 85, 'Good understanding'),
(2, 2, 2, 70, 'Needs more examples'),
(3, 3, 3, 90, 'Excellent work'),
(4, 4, 4, 80, 'Well done'),
(5, 5, 5, 75, 'Good effort'),
(6, 6, 6, 95, 'Outstanding performance'),
(7, 7, 7, 85, 'Creative and original'),
(8, 8, 8, 90, 'Excellent skills'),
(9, 9, 1, 88, 'Well done'),
(10, 10, 2, 65, 'Needs improvement'),
(11, 11, 3, 92, 'Great understanding'),
(12, 12, 4, 83, 'Good work'),
(13, 13, 5, 77, 'Satisfactory'),
(14, 14, 6, 96, 'Excellent'),
(15, 15, 7, 89, 'Creative'),
(16, 16, 8, 91, 'Outstanding');
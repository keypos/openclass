WITH RECURSIVE DateRange AS (
    SELECT DATE('2023-05-07') AS date
    UNION ALL
    SELECT DATE(date, '+1 day')
    FROM DateRange
    WHERE date <= DATE('2025-07-06')
)
INSERT INTO timetable (teacher_id, timetable_date)
SELECT t.teacher_id, dr.date
FROM teacher t
CROSS JOIN DateRange dr;

WITH RandomPeriods AS (
    SELECT
        t.timetable_id,
        s.subject_id,
        'Room ' || (1 + ABS(RANDOM()) % 10) AS room,
        ROW_NUMBER() OVER (PARTITION BY t.teacher_id, t.timetable_date ORDER BY RANDOM()) AS period_num
    FROM timetable t
    JOIN subject s ON t.teacher_id = s.teacher_id
)
INSERT INTO period (timetable_id, subject_id, room)
SELECT timetable_id, subject_id, room
FROM RandomPeriods
WHERE period_num <= 6;
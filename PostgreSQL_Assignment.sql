-- Active: 1729880531693@@127.0.0.1@5432@university_db

-- create students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(200) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(255) NOT NULL,
    frontend_mark INT NOT NULL,
    backend_mark INT NOT NULL,
    status VARCHAR(50)
);

-- create courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    credits INT NOT NULL
);

-- create an enrollment table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students (student_id),
    course_id INT REFERENCES courses (course_id)
);

--  insert data into the students table
INSERT INTO
    students (
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark
    )
VALUES (
        'Sameer',
        21,
        'sameer@example.com',
        48,
        60
    ),
    (
        'Zoya',
        23,
        'zoya@example.com',
        52,
        58
    ),
    (
        'Nabil',
        22,
        'nabil@example.com',
        37,
        46
    ),
    (
        'Rafi',
        24,
        'rafi@example.com',
        41,
        40
    ),
    (
        'Sophia',
        22,
        'sophia@example.com',
        50,
        52
    ),
    (
        'Hasan',
        23,
        'hasan@gmail.com',
        43,
        39
    );

-- insert data into courses table
INSERT INTO
    courses (course_name, credits)
VALUES ('Next.js', 3),
    ('React.js', 4),
    ('Databases', 3),
    ('Prisma', 3);

-- insert data into enrollment table
INSERT INTO
    enrollment (student_id, course_id)
VALUES (1, 1),
    (1, 2),
    (2, 1),
    (3, 2);

-- Query 1: Insert a new student record into the students table.
-- Adds a student data into the 'students' table.
INSERT INTO
    students (
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        'Nahid',
        25,
        'nahid@example.com',
        60,
        55,
        NULL
    );

-- Query 2: Retrieve the names of all students enrolled in the 'Next.js' course.
-- Joins the students, enrollment, and courses tables to filter students enrolled in 'Next.js' course
SELECT s.student_name
FROM
    students s
    JOIN enrollment e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id
WHERE
    c.course_name = 'Next.js';

-- Query 3: Update the status of the student with the highest total marks (frontend_mark + backend_mark) to 'Awarded'.
-- Calculates the highest total score and updates the status of the student to 'Awarded'
UPDATE students
SET
    status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (
        SELECT MAX(frontend_mark + backend_mark)
        FROM students
    );

-- Query 4: Delete all courses that have no students enrolled.
-- Identifies courses without enrollments and deletes them from the courses table
DELETE FROM courses
WHERE
    course_id NOT IN (
        SELECT course_id
        FROM enrollment
    );

-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student.
-- Uses LIMIT and OFFSET to fetch the names of students in a paginated system, starting from the 3rd student
SELECT student_name FROM students LIMIT 2 OFFSET 2;

-- Query 6: Retrieve the course names and the number of students enrolled in each course.
-- Uses a sub-query to count enrollments for each course, and display the course name and enrollment count
SELECT c.course_name, (
        SELECT COUNT(*)
        FROM enrollment e
        WHERE
            e.course_id = c.course_id
    ) AS students_enrolled
FROM courses c;

-- Query 7: Calculate and display the average age of all students, rounded to two decimal places.
-- Uses TRUNC to show the average age to two decimal
SELECT TRUNC(AVG(age), 2) AS average_age FROM students;

-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'.
-- Uses the LIKE operator to filter students whose email addresses include 'example.com'.
SELECT student_name FROM students WHERE email LIKE '%example.com%';
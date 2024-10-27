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

-- insert data into the students table
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

-- insert new student record in the students table
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

-- retrieve the name of all students who enrolled in the 'Next.js' course
SELECT s.student_name
FROM
    students s
    JOIN enrollment e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id
WHERE
    c.course_name = 'Next.js';

-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students
SET
    status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (
        SELECT MAX(frontend_mark + backend_mark)
        FROM students
    );

-- Delete all courses that have no students enrolled.
DELETE FROM courses
WHERE
    course_id NOT IN (
        SELECT course_id
        FROM enrollment
    );

-- Retrieve the names of students using a limit of 2, starting from the 3rd student
SELECT student_name FROM students LIMIT 2 OFFSET 2;

-- Retrieve the course names and the number of students enrolled in each course.
SELECT c.course_name, (
        SELECT COUNT(*)
        FROM enrollment e
        WHERE
            e.course_id = c.course_id
    ) AS students_enrolled
FROM courses c;
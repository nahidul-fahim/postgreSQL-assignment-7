-- Active: 1729880531693@@127.0.0.1@5432@university_db

-- create students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(200),
    age INT,
    email VARCHAR(255) NOT null,
    frontend_mark INT NOT NULL,
    backend_mark INT NOT NULL,
    status VARCHAR(50)
);
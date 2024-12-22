drop database guvi_assignment;

create database guvi_assignment;
use guvi_assignment;

-- Users table: Stores details of users (both students and instructors)
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('student', 'instructor') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Courses table: Stores details of courses
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    description TEXT,
    instructor_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (instructor_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Classes table: Represents specific class sessions
CREATE TABLE Classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    class_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    topic VARCHAR(255),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- Enrollments table: Tracks student enrollments in courses
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- Assignments table: Tracks assignments for courses
CREATE TABLE Assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    due_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- Submissions table: Tracks student submissions for assignments
CREATE TABLE Submissions (
    submission_id INT AUTO_INCREMENT PRIMARY KEY,
    assignment_id INT NOT NULL,
    student_id INT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    submission_file VARCHAR(255),
    grade DECIMAL(5, 2),
    feedback TEXT,
    FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES Users(user_id) ON DELETE CASCADE
);


/*

Users Table:
Contains all users (students and instructors) with a role distinction.
Courses Table:
Each course is linked to an instructor.
Classes Table:
Tracks individual class sessions tied to a course.
Enrollments Table:
Tracks students enrolled in each course.
Assignments Table:
Contains assignment details for each course.
Submissions Table:
Tracks submissions, grades, and feedback for assignments.

*/


-- Insert sample users (students and instructors)
INSERT INTO Users (name, email, password_hash, role) VALUES
('John Doe', 'john.doe@example.com', 'hashed_password_1', 'student'),
('Jane Smith', 'jane.smith@example.com', 'hashed_password_2', 'student'),
('Alice Johnson', 'alice.johnson@example.com', 'hashed_password_3', 'instructor'),
('Bob Brown', 'bob.brown@example.com', 'hashed_password_4', 'instructor');

-- Insert sample courses
INSERT INTO Courses (course_name, description, instructor_id) VALUES
('Python Programming', 'Learn the basics of Python programming', 3),
('Data Science 101', 'Introduction to data science concepts', 4);

-- Insert sample classes
INSERT INTO Classes (course_id, class_date, start_time, end_time, topic) VALUES
(1, '2024-01-10', '10:00:00', '12:00:00', 'Introduction to Python'),
(1, '2024-01-12', '10:00:00', '12:00:00', 'Python Data Structures'),
(2, '2024-01-15', '14:00:00', '16:00:00', 'Overview of Data Science'),
(2, '2024-01-17', '14:00:00', '16:00:00', 'Exploratory Data Analysis');

-- Insert sample enrollments
INSERT INTO Enrollments (student_id, course_id) VALUES
(1, 1),
(2, 1),
(1, 2),
(2, 2);

-- Insert sample assignments
INSERT INTO Assignments (course_id, title, description, due_date) VALUES
(1, 'Python Basics Assignment', 'Complete exercises on Python basics', '2024-01-20'),
(1, 'Data Structures Assignment', 'Solve problems on Python data structures', '2024-01-25'),
(2, 'Data Science Project Proposal', 'Submit a proposal for the final project', '2024-01-22');

-- Insert sample submissions
INSERT INTO Submissions (assignment_id, student_id, submission_file, grade, feedback) VALUES
(1, 1, 'submission_1.pdf', 85.5, 'Good work!'),
(1, 2, 'submission_2.pdf', 90.0, 'Well done!'),
(2, 1, 'submission_3.pdf', NULL, 'Pending grading'),
(3, 1, 'submission_4.pdf', 88.0, 'Detailed and well-structured proposal');

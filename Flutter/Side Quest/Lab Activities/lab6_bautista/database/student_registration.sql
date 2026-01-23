-- Database: student_registration
-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS student_registration;
USE student_registration;

-- Table structure for students
CREATE TABLE IF NOT EXISTS students (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    student_number VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    birthday DATE NOT NULL,
    course ENUM('BSIT', 'BSCS') NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    cp_number VARCHAR(11) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_student_number (student_number),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Sample data (optional)
-- INSERT INTO students (student_number, name, birthday, course, email, cp_number, password) 
-- VALUES 
-- ('2021-0001', 'Juan dela Cruz', '2000-05-15', 'BSIT', 'juan.delacruz@example.com', '09123456789', MD5('password123')),
-- ('2021-0002', 'Maria Clara Head', '2001-08-20', 'BSCS', 'maria.head@example.com', '09987654321', MD5('password456'));

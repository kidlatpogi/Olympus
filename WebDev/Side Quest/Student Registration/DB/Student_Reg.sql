CREATE DATABASE student_registration;
USE student_registration;

CREATE TABLE student_info (
    info_id      INT PRIMARY KEY AUTO_INCREMENT,
    first_name   VARCHAR(50) NOT NULL,
    middle_name  VARCHAR(50),
    last_name    VARCHAR(50) NOT NULL,
    birthday     DATE NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE student (
    student_id      INT NOT NULL PRIMARY KEY,
    info_id         INT NOT NULL,
    student_section ENUM('INF231', 'INF232', 'INF233', 'INF234') NOT NULL,
    registered_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (info_id) REFERENCES student_info(info_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

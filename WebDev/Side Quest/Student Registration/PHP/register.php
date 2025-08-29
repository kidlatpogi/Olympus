<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "student_registration";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get POST data (matching names from your form)
$first_name = $_POST["fname"];
$middle_name = $_POST["mname"];
$last_name = $_POST["lname"];
$birthday = $_POST["birthdate"];
$student_section = $_POST["section"];

// Step 1: Insert into student_info
$sql_info = "INSERT INTO student_info (first_name, middle_name, last_name, birthday) 
             VALUES (?, ?, ?, ?)";
$stmt_info = $conn->prepare($sql_info);
$stmt_info->bind_param("ssss", $first_name, $middle_name, $last_name, $birthday);
$stmt_info->execute();
$info_id = $stmt_info->insert_id;
$stmt_info->close();

// Step 2: Find the smallest available student_id (gap filler)
$sql_gap = "SELECT t1.student_id + 1 AS next_id
            FROM student t1
            LEFT JOIN student t2 ON t1.student_id + 1 = t2.student_id
            WHERE t2.student_id IS NULL
            ORDER BY next_id ASC
            LIMIT 1";

$result = $conn->query($sql_gap);
if ($result && $row = $result->fetch_assoc()) {
    $next_id = $row["next_id"];
} else {
    // If no gaps, start from 1 or continue sequence
    $res_max = $conn->query("SELECT IFNULL(MAX(student_id), 0) + 1 AS next_id FROM student");
    $next_id = $res_max->fetch_assoc()["next_id"];
}

// Step 3: Insert into student with chosen student_id
$sql_student = "INSERT INTO student (student_id, info_id, student_section) VALUES (?, ?, ?)";
$stmt_student = $conn->prepare($sql_student);
$stmt_student->bind_param("iis", $next_id, $info_id, $student_section);
$stmt_student->execute();
$stmt_student->close();

$conn->close();

// Redirect after success
header("Location: ../HTML/completed.html");
exit();
?>
<?php
// register.php - Handle student registration
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

require_once 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get JSON input
    $input = file_get_contents('php://input');
    $data = json_decode($input, true);
    
    // Validate required fields
    if (!isset($data['student_number']) || !isset($data['name']) || 
        !isset($data['birthday']) || !isset($data['course']) || 
        !isset($data['email']) || !isset($data['cp_number']) || 
        !isset($data['password'])) {
        send_response(false, 'All fields are required');
    }
    
    $student_number = sanitize_input($data['student_number']);
    $name = sanitize_input($data['name']);
    $birthday = sanitize_input($data['birthday']);
    $course = sanitize_input($data['course']);
    $email = sanitize_input($data['email']);
    $cp_number = sanitize_input($data['cp_number']);
    $password = $data['password'];
    
    // Validate email format
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        send_response(false, 'Invalid email format');
    }
    
    // Validate CP number (11 digits)
    if (!preg_match('/^[0-9]{11}$/', $cp_number)) {
        send_response(false, 'CP Number must be exactly 11 digits');
    }
    
    // Validate password length
    if (strlen($password) < 8) {
        send_response(false, 'Password must be at least 8 characters');
    }
    
    // Validate course
    if (!in_array($course, ['BSIT', 'BSCS'])) {
        send_response(false, 'Invalid course selection');
    }
    
    // Check if student number already exists
    $check_student = $conn->prepare("SELECT id FROM students WHERE student_number = ?");
    $check_student->bind_param("s", $student_number);
    $check_student->execute();
    $check_student->store_result();
    
    if ($check_student->num_rows > 0) {
        send_response(false, 'Student number already exists');
    }
    $check_student->close();
    
    // Check if email already exists
    $check_email = $conn->prepare("SELECT id FROM students WHERE email = ?");
    $check_email->bind_param("s", $email);
    $check_email->execute();
    $check_email->store_result();
    
    if ($check_email->num_rows > 0) {
        send_response(false, 'Email already exists');
    }
    $check_email->close();
    
    // Hash password
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);
    
    // Insert student
    $stmt = $conn->prepare("INSERT INTO students (student_number, name, birthday, course, email, cp_number, password) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssss", $student_number, $name, $birthday, $course, $email, $cp_number, $hashed_password);
    
    if ($stmt->execute()) {
        send_response(true, 'Student registered successfully', ['id' => $stmt->insert_id]);
    } else {
        send_response(false, 'Registration failed: ' . $stmt->error);
    }
    
    $stmt->close();
    $conn->close();
} else {
    send_response(false, 'Invalid request method');
}
?>

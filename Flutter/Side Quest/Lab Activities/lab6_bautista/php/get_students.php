<?php
// get_students.php - Retrieve list of students
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

require_once 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Query to get all students
    $sql = "SELECT id, student_number, name, birthday, course, email, cp_number, created_at FROM students ORDER BY created_at DESC";
    $result = $conn->query($sql);
    
    if ($result) {
        $students = [];
        
        while ($row = $result->fetch_assoc()) {
            $students[] = [
                'id' => $row['id'],
                'student_number' => $row['student_number'],
                'name' => $row['name'],
                'birthday' => $row['birthday'],
                'course' => $row['course'],
                'email' => $row['email'],
                'cp_number' => $row['cp_number'],
                'created_at' => $row['created_at']
            ];
        }
        
        send_response(true, 'Students retrieved successfully', $students);
    } else {
        send_response(false, 'Failed to retrieve students: ' . $conn->error);
    }
    
    $conn->close();
} else {
    send_response(false, 'Invalid request method');
}
?>

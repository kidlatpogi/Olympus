<?php
require 'connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['student_id'])) {
    $student_id = intval($_POST['student_id']);

    // First delete from `student_info` using JOIN relation
    // But careful: your DB structure is `student` -> `info_id`
    // So we need to find info_id before deleting.
    $query = "SELECT info_id FROM student WHERE student_id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $student_id);
    $stmt->execute();
    $stmt->bind_result($info_id);
    $stmt->fetch();
    $stmt->close();

    if ($info_id) {
        // Delete student first (foreign key reference to info_id)
        $deleteStudent = $conn->prepare("DELETE FROM student WHERE student_id = ?");
        $deleteStudent->bind_param("i", $student_id);
        $deleteStudent->execute();
        $deleteStudent->close();

        // Delete info next (only if you want full cascade remove)
        $deleteInfo = $conn->prepare("DELETE FROM student_info WHERE info_id = ?");
        $deleteInfo->bind_param("i", $info_id);
        $deleteInfo->execute();
        $deleteInfo->close();
    }

    $conn->close();
}

// Redirect back to table
header("Location: ../HTML/dataTable.php"); 
exit;
?>

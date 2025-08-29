<?php
require 'connection.php';

$sql = "SELECT s.student_id, i.first_name, i.middle_name, i.last_name, i.birthday, s.student_section, s.registered_at
        FROM student s
        INNER JOIN student_info i ON s.info_id = i.info_id
        ORDER BY s.student_id DESC";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Student Data</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="p-4">
    <h2>Registered Students</h2>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>First</th>
                <th>Middle</th>
                <th>Last</th>
                <th>Birthday</th>
                <th>Section</th>
                <th>Registered At</th>
            </tr>
        </thead>
        <tbody>
            <?php if ($result->num_rows > 0): ?>
                <?php while($row = $result->fetch_assoc()): ?>
                    <tr>
                        <td><?= htmlspecialchars($row['student_id']); ?></td>
                        <td><?= htmlspecialchars($row['first_name']); ?></td>
                        <td><?= htmlspecialchars($row['middle_name']); ?></td>
                        <td><?= htmlspecialchars($row['last_name']); ?></td>
                        <td><?= htmlspecialchars($row['birthday']); ?></td>
                        <td><?= htmlspecialchars($row['student_section']); ?></td>
                        <td><?= htmlspecialchars($row['registered_at']); ?></td>
                    </tr>
                <?php endwhile; ?>
            <?php else: ?>
                <tr><td colspan="7" class="text-center">No records found</td></tr>
            <?php endif; ?>
        </tbody>
    </table>
</body>
</html>

<?php $conn->close(); ?>

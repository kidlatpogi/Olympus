<?php
require '../PHP/connection.php';
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Data Table</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <link rel="stylesheet" href="../CSS/dataTable.css">
</head>
<body>
<div class="noise-overlay"></div>
<div class="floating-shapes">
  <div></div><div></div><div></div><div></div>
</div>

<div class="container my-5">
  <div class="row justify-content-center">
    <div class="col-12">
      <div class="card registration-card">
        <div class="card-header d-flex justify-content-between align-items-center">
          <div>
            <h2><i class="bi bi-table me-2"></i>Registered Students</h2>
            <p class="mb-0 mt-2">View and manage all student records</p>
          </div>
          <!-- Register Another Student Button -->
          <a href="index.html" class="btn btn-primary">
            <i class="bi bi-person-plus"></i> Register Another Student
          </a>
        </div>
        <div class="card-body">
          <!-- Search -->
          <div class="search-container">
            <i class="bi bi-search search-icon"></i>
            <input type="text" class="search-input" placeholder="Search students...">
          </div>

          <!-- Table -->
          <div class="table-container">
            <div class="table-responsive">
              <table class="table" id="studentsTable">
                <thead>
                  <tr>
                    <th>#</th>
                    <th>First Name</th>
                    <th>Middle Name</th>
                    <th>Last Name</th>
                    <th>Birthdate</th>
                    <th>Section</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <?php
                  $sql = "SELECT s.student_id, i.first_name, i.middle_name, i.last_name, i.birthday, s.student_section
                          FROM student s
                          INNER JOIN student_info i ON s.info_id = i.info_id
                          ORDER BY s.student_id DESC";

                  $result = $conn->query($sql);

                  if ($result->num_rows > 0) {
                      while($row = $result->fetch_assoc()) {
                          echo "<tr>
                                  <td>{$row['student_id']}</td>
                                  <td>{$row['first_name']}</td>
                                  <td>{$row['middle_name']}</td>
                                  <td>{$row['last_name']}</td>
                                  <td>{$row['birthday']}</td>
                                  <td>{$row['student_section']}</td>
                                  <td>
                                    <form action='../PHP/delete.php' method='POST' onsubmit=\"return confirm('Are you sure you want to delete this student?');\">
                                      <input type='hidden' name='student_id' value='{$row['student_id']}'>
                                      <button type='submit' class='btn btn-sm btn-danger'>
                                        <i class='bi bi-trash'></i> Delete
                                      </button>
                                    </form>
                                  </td>
                                </tr>";
                      }
                  } else {
                      echo "<tr><td colspan='7' class='text-center'>No records found</td></tr>";
                  }

                  $conn->close();
                  ?>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="card-footer text-center">
          <small>© 2023 Student Registration System. All rights reserved.</small>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
  const searchInput = document.querySelector('.search-input');
  searchInput.addEventListener('input', function() {
    const searchText = this.value.toLowerCase();
    const rows = document.querySelectorAll('#studentsTable tbody tr');
    rows.forEach(row => {
      const cells = row.querySelectorAll('td');
      let found = false;
      cells.forEach(cell => {
        if(cell.textContent.toLowerCase().includes(searchText)) found = true;
      });
      row.style.display = found ? '' : 'none';
    });
  });
});
</script>
</body>
</html>
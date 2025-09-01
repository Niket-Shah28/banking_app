<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Details</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
  :root {
    --primary-blue: #007bff;
    --background-gradient: linear-gradient(135deg, #1f2833, #38404a);
    --card-bg: rgba(255, 255, 255, 0.1);
    --card-border: rgba(255, 255, 255, 0.2);
    --text-color: #f1f1f1;
    --secondary-text: #ddd;
  }
  body {
    background: var(--background-gradient);
    font-family: 'Poppins', sans-serif;
    margin: 0;
    min-height: 100vh;
  }
  .navbar-custom {
    background-color: var(--card-bg);
    backdrop-filter: blur(10px);
    border-bottom: 1px solid var(--card-border);
  }
  .navbar-custom .navbar-brand,
  .navbar-custom .nav-link { color: var(--text-color) !important; }

  .btn-profile {
    background: var(--primary-blue);
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 8px;
    color: #fff;
    font-weight: 600;
    transition: 0.2s;
  }
  .btn-profile:hover { background: #0069d9; transform: translateY(-2px); }

  .table-custom {
    background: var(--card-bg);
    border-radius: 12px;
    overflow: hidden;
    color: var(--text-color);
  }
  .table-custom th, .table-custom td {
    padding: 1.1rem;
    vertical-align: middle;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 250px;
    font-size: 0.95rem;
  }
  .table-custom td:last-child {
    white-space: nowrap;
    overflow: visible;
    text-overflow: unset;
    max-width: none;
  }

  .filter-card {
    background: var(--card-bg);
    border: 1px solid var(--card-border);
    border-radius: 12px;
    backdrop-filter: blur(10px);
    padding: 1rem;
    color: var(--text-color);
    margin-bottom: 1rem;
  }

  .no-results { color: var(--secondary-text); padding: 1rem; }
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom fixed-top px-3">
  <a class="navbar-brand fw-semibold" href="#">Customer Details</a>
  <button class="ms-auto btn btn-primary" onclick="window.location.href='AdminDashboardController'">BACK TO HOME PAGE</button>
</nav>

<div class="container-fluid" style="padding-top:100px;">

  <div class="filter-card">
    <div class="row g-3">
      <div class="col-md-3">
        <label for="filterPan">PAN Number</label>
        <input id="filterPan" type="text" class="form-control" placeholder="PAN Number" />
      </div>
      <div class="col-md-3">
        <label for="filterName">Name</label>
        <input id="filterName" type="text" class="form-control" placeholder="Name" />
      </div>
      <div class="col-md-3">
        <label for="filterPhone">Phone</label>
        <input id="filterPhone" type="text" class="form-control" placeholder="Phone" />
      </div>
      <div class="col-md-3">
        <label for="filterEmail">Email</label>
        <input id="filterEmail" type="text" class="form-control" placeholder="Email" />
      </div>
    </div>
  </div>

  <div class="table-responsive">
    <table id="customersTable" class="table table-custom text-center align-middle w-100">
      <thead>
        <tr>
          <th>Id</th>
          <th>Name</th>
          <th>Email</th>
          <th>Phone</th>
          <th>PAN Number</th>
          <th>Aadhar Number</th>
          <th>Date of Birth</th>
          <th>Address</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="customer" items="${customers}">
          <tr>
            <td></td>
            <td><c:out value="${customer.name}" /></td>
            <td><c:out value="${customer.email}" /></td>
            <td><c:out value="${customer.phone}" /></td>
            <td><c:out value="${customer.panNumber}" /></td>
            <td><c:out value="${customer.aadharNumber}" /></td>
            <td><fmt:formatDate value="${customer.dateOfBirth}" pattern="dd-MMM-yyyy" /></td>
            <td><c:out value="${customer.address}" /></td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

</div>

<script>
  (function () {
    function filterTable() {
      const panFilter = document.getElementById('filterPan').value.toLowerCase();
      const nameFilter = document.getElementById('filterName').value.toLowerCase();
      const phoneFilter = document.getElementById('filterPhone').value.toLowerCase();
      const emailFilter = document.getElementById('filterEmail').value.toLowerCase();

      const rows = Array.from(document.querySelectorAll('#customersTable tbody tr'));
      let visibleCount = 0;

      rows.forEach(row => {
        const cells = row.querySelectorAll('td');
        const name = cells[1].textContent.toLowerCase();
        const email = cells[2].textContent.toLowerCase();
        const phone = cells[3].textContent.toLowerCase();
        const pan = cells[4].textContent.toLowerCase();

        const matchesPan = pan.includes(panFilter);
        const matchesName = name.includes(nameFilter);
        const matchesPhone = phone.includes(phoneFilter);
        const matchesEmail = email.includes(emailFilter);

        const show = matchesPan && matchesName && matchesPhone && matchesEmail;

        row.style.display = show ? '' : 'none';

        if (show) {
          visibleCount++;
          cells[0].textContent = visibleCount;
        }
      });

      const tbody = document.querySelector('#customersTable tbody');
      let noRow = document.getElementById('noResultsRow');
      if (visibleCount === 0) {
        if (!noRow) {
          noRow = document.createElement('tr');
          noRow.id = 'noResultsRow';
          noRow.innerHTML = '<td colspan="8" class="text-center no-results">No customers found for selected filters.</td>';
          tbody.appendChild(noRow);
        }
      } else {
        if (noRow) noRow.remove();
      }
    }

    document.addEventListener('DOMContentLoaded', function () {
      document.getElementById('filterPan').addEventListener('input', filterTable);
      document.getElementById('filterName').addEventListener('input', filterTable);
      document.getElementById('filterPhone').addEventListener('input', filterTable);
      document.getElementById('filterEmail').addEventListener('input', filterTable);
      
      filterTable();
    });
  })();
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <title>Account Details</title>
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
    .navbar-custom .nav-link {
      color: var(--text-color) !important;
    }

    .btn-profile {
      background: var(--primary-blue);
      border: none;
      padding: 0.5rem 1rem;
      border-radius: 8px;
      color: #fff;
      font-weight: 600;
      transition: 0.2s;
    }
    .btn-profile:hover {
      background: #0069d9;
      transform: translateY(-2px);
    }

    .table-custom {
      background: var(--card-bg);
      border-radius: 12px;
      overflow: hidden;
      color: var(--text-color);
    }
    .table-custom th,
    .table-custom td {
      padding: 1.1rem;
      vertical-align: middle;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      max-width: 300px;
      font-size: 0.95rem;
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

    .no-results {
      color: var(--secondary-text);
      padding: 1rem;
    }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom fixed-top px-3">
  <a class="navbar-brand fw-semibold" href="#">Account Details</a>
  <button class="ms-auto btn btn-primary" onclick="window.location.href='AdminDashboardController'">BACK TO HOME PAGE</button>
</nav>

<div class="container-fluid" style="padding-top:100px;">

  <!-- Filters -->
  <div class="filter-card">
    <div class="row g-3 align-items-end">
      <div class="col-md-3">
        <label for="accountNumberFilter">Account Number</label>
        <input id="accountNumberFilter" type="text" class="form-control" placeholder="Enter account number">
      </div>

      <div class="col-md-3">
        <label for="ifscFilter">IFSC Code</label>
        <input id="ifscFilter" type="text" class="form-control" placeholder="Enter IFSC code">
      </div>

      <div class="col-md-3">
        <label for="balanceAmount">Balance</label>
        <div class="input-group">
          <select id="balanceCondition" class="form-select" style="max-width: 100px;">
            <option value="greater">></option>
            <option value="less"><</option>
          </select>
          <input id="balanceAmount" type="number" class="form-control" placeholder="Enter amount">
        </div>
      </div>

      <div class="col-md-3">
        <button id="resetBtn" class="btn-profile w-100" type="button" style="height:46px;">Reset</button>
      </div>
    </div>
  </div>

  <!-- Table -->
  <div class="table-responsive">
    <table id="accountsTable" class="table table-custom text-center align-middle w-100">
      <thead>
        <tr>
          <th>Id</th>
          <th>Customer ID</th>
          <th>Customer Name</th>
          <th>Account Number</th>
          <th>Account Type</th>
          <th>Balance</th>
          <th>Branch</th>
          <th>IFSC</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="acc" items="${accounts}">
          <tr
            data-account="${acc.accountNumber != null ? acc.accountNumber : ''}"
            data-ifsc="${acc.ifscCode != null ? acc.ifscCode : ''}"
            data-balance="${acc.balance != null ? acc.balance : 0}">
            <td></td>
            <td><c:out value="${acc.customerId}" /></td>
            <td><c:out value="${acc.customerName}" /></td>
            <td><c:out value="${acc.accountNumber}" /></td>
            <td><c:out value="${acc.accountType}" /></td>
            <td><fmt:formatNumber value="${acc.balance}" minFractionDigits="2" /></td>
            <td><c:out value="${acc.branchName}" /></td>
            <td><c:out value="${acc.ifscCode}" /></td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<script>
(function () {
  function filterTable() {
    const accFilter = document.getElementById('accountNumberFilter').value.toLowerCase();
    const ifscFilter = document.getElementById('ifscFilter').value.toLowerCase();
    const balCondition = document.getElementById('balanceCondition').value;
    const balAmount = parseFloat(document.getElementById('balanceAmount').value);

    const rows = Array.from(document.querySelectorAll('#accountsTable tbody tr'));
    let visibleCount = 0;

    rows.forEach(row => {
      const cells = row.querySelectorAll('td');
      const accNum = (row.dataset.account || '').toLowerCase();
      const ifsc = (row.dataset.ifsc || '').toLowerCase();
      const balance = parseFloat(row.dataset.balance || '0');

      let show = true;

      if (accFilter && !accNum.includes(accFilter)) show = false;
      if (ifscFilter && !ifsc.includes(ifscFilter)) show = false;

      if (!isNaN(balAmount)) {
        if (balCondition === 'greater' && balance <= balAmount) show = false;
        if (balCondition === 'less' && balance >= balAmount) show = false;
      }

      row.style.display = show ? '' : 'none';

      if (show) {
        visibleCount++;
        cells[0].textContent = visibleCount;
      }
    });

    const tbody = document.querySelector('#accountsTable tbody');
    let noRow = document.getElementById('noResultsRow');
    if (visibleCount === 0) {
      if (!noRow) {
        noRow = document.createElement('tr');
        noRow.id = 'noResultsRow';
        noRow.innerHTML = '<td colspan="8" class="text-center no-results">No accounts found for selected filters.</td>';
        tbody.appendChild(noRow);
      }
    } else {
      if (noRow) noRow.remove();
    }
  }

  function numberRows() {
    const rows = Array.from(document.querySelectorAll('#accountsTable tbody tr'));
    let count = 0;
    rows.forEach(row => {
      if (row.id !== 'noResultsRow') {
        row.querySelector('td').textContent = ++count;
        row.style.display = '';
      }
    });
    const noRow = document.getElementById('noResultsRow');
    if (noRow) noRow.remove();
  }

  document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('accountNumberFilter').addEventListener('input', filterTable);
    document.getElementById('ifscFilter').addEventListener('input', filterTable);
    document.getElementById('balanceAmount').addEventListener('input', filterTable);
    document.getElementById('balanceCondition').addEventListener('change', filterTable);

    document.getElementById('resetBtn').addEventListener('click', function () {
      document.getElementById('accountNumberFilter').value = '';
      document.getElementById('ifscFilter').value = '';
      document.getElementById('balanceAmount').value = '';
      document.getElementById('balanceCondition').value = 'greater';
      numberRows();
    });

    numberRows(); // initialize table without filtering
  });
})();
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

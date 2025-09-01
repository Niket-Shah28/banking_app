<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Transaction Details</title>
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
    max-width: 300px;
    font-size: 0.95rem;
  }
  .table-custom td:nth-child(7) { 
  	white-space: nowrap !important; 
  	overflow: visible !important; 
  	text-overflow: clip !important; 
  	max-width: none !important; 
  }

  .table-custom td:last-child, .table-custom td:nth-last-child(2) {
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
  <a class="navbar-brand fw-semibold" href="#">Transaction Details</a>
  <button class="ms-auto btn btn-primary" onclick="window.location.href='AdminDashboardController'">BACK TO HOME PAGE</button>
</nav>

<div class="container-fluid" style="padding-top:100px;">

  <!-- Filters: account number text input, reference id text input, start/end dates -->
  <div class="filter-card">
    <div class="row g-3 align-items-end">
      <div class="col-md-3">
        <label for="accountNumber">Account Number</label>
        <input id="accountNumber" type="text" class="form-control" placeholder="Enter account number" />
      </div>

      <div class="col-md-3">
        <label for="referenceId">Reference ID</label>
        <input id="referenceId" type="text" class="form-control" placeholder="Enter reference ID" />
      </div>

      <div class="col-md-3">
        <label for="startDate">Start Date</label>
        <input id="startDate" type="date" class="form-control" />
      </div>

      <div class="col-md-3">
        <label for="endDate">End Date</label>
        <input id="endDate" type="date" class="form-control" />
      </div>

      <div class="col-md-12 d-flex gap-2 mt-2">
        <button id="resetBtn" class="btn-profile" type="button" style="width: 150px;">Reset</button>
      </div>
    </div>
  </div>

  <!-- Transactions table -->
  <div class="table-responsive">
    <table id="transactionsTable" class="table table-custom text-center align-middle w-100">
      <thead>
        <tr>
          <th>Id</th>
          <th>Timestamp</th>
          <th>Transaction Type</th>
          <th>Mode</th>
          <th>Description</th>
          <th>Amount</th>
          <th>Reference Id</th>
          <th>Account No.</th>
          <th>Beneficiary</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="txn" items="${transactions}">
          <tr data-account="${txn.accountNumber}" data-reference="${txn.referenceId}" data-timestamp="${txn.timestamp.time}">
            <td></td>
            <td>
              <c:choose>
                <c:when test="${not empty txn.timestamp}">
                  <fmt:formatDate value="${txn.timestamp}" pattern="dd-MMM-yyyy HH:mm:ss"/>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>
            <td><c:out value="${txn.transactionType}" /></td>
            <td><c:out value="${txn.mode}" /></td>
            <td><c:out value="${not empty txn.description ? txn.description : '-'}" /></td>
            <td>
              <fmt:formatNumber value="${txn.amount}" minFractionDigits="2" />
            </td>
            <td><c:out value="${txn.referenceId}" /></td>
            <td><c:out value="${txn.accountNumber}" /></td>
            <td><c:out value="${not empty txn.beneficiary_name ? txn.beneficiary_name : '-'}" /></td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

</div>

<script>
  (function () {
    function parseYMDToDate(ymd) {
      if (!ymd) return null;
      const [y, m, d] = ymd.split('-');
      return new Date(Number(y), Number(m) - 1, Number(d));
    }

    function setEndOfDay(date) {
      if (!date) return date;
      date.setHours(23,59,59,999);
      return date;
    }

    function filterTable() {
      const acctInput = document.getElementById('accountNumber').value.trim().toLowerCase();
      const refInput = document.getElementById('referenceId').value.trim().toLowerCase();
      const startStr = document.getElementById('startDate').value;
      const endStr = document.getElementById('endDate').value;

      const startDate = parseYMDToDate(startStr);
      const endDate = setEndOfDay(parseYMDToDate(endStr));

      const rows = Array.from(document.querySelectorAll('#transactionsTable tbody tr'));
      let visibleCount = 0;

      rows.forEach(row => {
        let show = true;

        const rowAccount = (row.dataset.account || '').toLowerCase();
        const rowReference = (row.dataset.reference || '').toLowerCase();

        if (acctInput && !rowAccount.includes(acctInput)) show = false;
        if (refInput && !rowReference.includes(refInput)) show = false;

        const ts = row.dataset.timestamp;
        if ((startDate || endDate) && ts) {
          const txDate = new Date(Number(ts));
          if (startDate && txDate < startDate) show = false;
          if (endDate && txDate > endDate) show = false;
        } else if ((startDate || endDate) && !ts) {
          show = false;
        }

        row.style.display = show ? '' : 'none';
        if (show) {
          visibleCount++;
          const idCell = row.querySelector('td');
          if (idCell) idCell.textContent = visibleCount;
        }
      });

      const tbody = document.querySelector('#transactionsTable tbody');
      let noRow = document.getElementById('noResultsRow');
      if (visibleCount === 0) {
        if (!noRow) {
          noRow = document.createElement('tr');
          noRow.id = 'noResultsRow';
          noRow.innerHTML = '<td colspan="8" class="text-center no-results">No transactions found for selected filters.</td>';
          tbody.appendChild(noRow);
        }
      } else {
        if (noRow) noRow.remove();
      }
    }

    document.addEventListener('DOMContentLoaded', function () {
      document.getElementById('accountNumber').addEventListener('input', filterTable);
      document.getElementById('referenceId').addEventListener('input', filterTable);
      document.getElementById('startDate').addEventListener('change', filterTable);
      document.getElementById('endDate').addEventListener('change', filterTable);
      document.getElementById('resetBtn').addEventListener('click', function () {
        document.getElementById('accountNumber').value = '';
        document.getElementById('referenceId').value = '';
        document.getElementById('startDate').value = '';
        document.getElementById('endDate').value = '';
        filterTable();
      });

      filterTable();
    });
  })();
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

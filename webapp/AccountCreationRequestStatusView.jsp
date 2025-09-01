<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account Request Status</title>
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
    .btn-profile:hover { background: #0069d9; transform: translateY(-2px); }

    .table-custom {
      background: var(--card-bg);
      border-radius: 12px;
      overflow: hidden;
      color: var(--text-color);
      margin-bottom: 2rem;
    }
    .table-custom th, 
    .table-custom td {
      padding: 1.1rem;
      vertical-align: middle;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      max-width: 400px;
      font-size: 0.95rem;
    }

    .table-section {
      padding: 2rem;
    }

    .section-title {
      font-size: 1.6rem;
      font-weight: 600;
      color: var(--text-color);
      margin-bottom: 1rem;
    }

    .table-box {
      overflow-x: auto;
    }
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom fixed-top px-3">
  <a class="navbar-brand fw-semibold" href="#">Account Request Status</a>
  <button class="ms-auto btn btn-primary" onclick="window.location.href='CustomerDashboardController'">BACK TO HOME PAGE</button>
</nav>

<!-- Content -->
<div class="container-fluid" style="padding-top: 100px;">

  <!-- Pending Requests Section -->
  <div class="table-section">
    <div class="section-title">Pending Requests</div>
    <div class="table-box">
      <table class="table table-custom text-center align-middle w-100">
        <thead>
          <tr>
            <th>#</th>
            <th>Account Type</th>
            <th>Start Balance</th>
            <th>Status</th>
            <th>Created At</th>
            <th>Branch</th>
            <th>IFSC</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="req" items="${pendingRequests}" varStatus="loop">
            <tr>
              <td>${loop.index + 1}</td>
              <td>${req.accountType}</td>
              <td>${req.startBalance}</td>
              <td>${req.status}</td>
              <td>${req.createdAt}</td>
              <td>${req.branchName}</td>
              <td>${req.ifscCode}</td>
            </tr>
          </c:forEach>
          <c:if test="${empty pendingRequests}">
            <tr><td colspan="7" class="text-center text-secondary">No pending requests found.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Reviewed Requests Section -->
  <div class="table-section">
    <div class="section-title">Reviewed Requests</div>
    <div class="table-box">
      <table class="table table-custom text-center align-middle w-100">
        <thead>
          <tr>
            <th>#</th>
            <th>Account Type</th>
            <th>Start Balance</th>
            <th>Status</th>
            <th>Created At</th>
            <th>Branch</th>
            <th>IFSC</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="req" items="${reviewedRequests}" varStatus="loop">
            <tr>
              <td>${loop.index + 1}</td>
              <td>${req.accountType}</td>
              <td>${req.startBalance}</td>
              <td>${req.status}</td>
              <td>${req.createdAt}</td>
              <td>${req.branchName}</td>
              <td>${req.ifscCode}</td>
            </tr>
          </c:forEach>
          <c:if test="${empty reviewedRequests}">
            <tr><td colspan="7" class="text-center text-secondary">No reviewed requests found.</td></tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

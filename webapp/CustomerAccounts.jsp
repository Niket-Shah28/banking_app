<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Accounts</title>
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

  /* Glass navbar to match theme */
  .navbar-custom {
    background-color: var(--card-bg);
    border-bottom: 1px solid var(--card-border);
    backdrop-filter: blur(10px);
  }
  .navbar-custom .navbar-brand,
  .navbar-custom .nav-link {
    color: var(--text-color) !important;
  }

  /* Primary button (same feel as register page) */
  .btn-primary {
    background: var(--primary-blue);
    border: none;
    padding: 0.6rem 1rem;
    font-weight: 600;
    font-size: 0.95rem;
    border-radius: 8px;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    letter-spacing: 0.5px;
  }
  .btn-primary:hover {
    background: #0069d9;
    transform: translateY(-2px);
    box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
  }
  .btn-primary:active {
    transform: translateY(0);
    box-shadow: none;
  }

  /* Layout spacing to account for fixed navbar */
  .page-wrap {
    padding: 1.25rem;
    padding-top: 90px; /* space under fixed navbar */
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  /* Glass account cards – same visual language as register container */
  .account-card {
    width: 100%;
    max-width: 520px;
    padding: 1.5rem 1.75rem;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
    backdrop-filter: blur(10px);
    background-color: var(--card-bg);
    border: 1px solid var(--card-border);
    color: var(--text-color);
  }
  .account-card + .account-card { margin-top: 20px; }

  .card-title {
    font-size: 1.15rem;
    font-weight: 600;
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 1px solid var(--card-border);
  }

  .field-row {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    margin-bottom: 0.6rem;
    gap: 12px;
  }
  .field-label {
    color: var(--secondary-text);
    font-weight: 500;
  }
  .field-value {
    color: var(--text-color);
    font-weight: 600;
    text-align: right;
    word-break: break-word;
  }

  /* Empty state card */
  .empty-card {
    text-align: center;
  }
  .empty-card h5 {
    margin-bottom: 0.25rem;
    font-weight: 600;
  }
  .empty-card p {
    color: var(--secondary-text);
    margin: 0;
  }
</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom fixed-top px-3">
  <a class="navbar-brand fw-semibold" href="#">ACCOUNTS</a>
  <button class="ms-auto btn btn-primary w-auto" onclick="window.location.href='CustomerDashboard.jsp'">
    BACK TO HOME PAGE
  </button>
</nav>

<!-- Content -->
<div class="page-wrap">

  <c:choose>
    <c:when test="${empty accounts}">
      <div class="account-card empty-card">
        <h5>No Accounts To Show</h5>
        <p>Once an account is created, it will appear here.</p>
      </div>
    </c:when>
    <c:otherwise>
      <c:forEach var="account" items="${accounts}">
        <div class="account-card">
          <div class="card-title">Account Details</div>

          <div class="field-row">
            <div class="field-label">Account Number</div>
            <div class="field-value">${account.accountNumber}</div>
          </div>

          <div class="field-row">
            <div class="field-label">Account Type</div>
            <div class="field-value">${account.accountType}</div>
          </div>

          <div class="field-row">
            <div class="field-label">Balance</div>
            <div class="field-value">$ ${account.balance}</div>
          </div>

          <div class="field-row">
            <div class="field-label">Branch</div>
            <div class="field-value">${account.branchName}</div>
          </div>

          <div class="field-row">
            <div class="field-label">IFSC Code</div>
            <div class="field-value">${account.ifscCode}</div>
          </div>
        </div>
      </c:forEach>
    </c:otherwise>
  </c:choose>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Nominees</title>
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
      color: var(--text-color);
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 28px 16px;
    }

    .card-box {
      width: 100%;
      max-width: 620px;            
      padding: 2rem 2.25rem;
      border-radius: 20px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.3);
      backdrop-filter: blur(10px);
      background-color: var(--card-bg);
      border: 1px solid var(--card-border);
      color: var(--text-color);
      margin-bottom: 24px;
    }

    .table-box {
      width: 100%;
      max-width: 980px;
      padding: 1.25rem 1.5rem;
      border-radius: 20px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.3);
      backdrop-filter: blur(10px);
      background-color: var(--card-bg);
      border: 1px solid var(--card-border);
      color: var(--text-color);
      margin-top: 12px;
    }

    .card-header {
      font-size: 1.9rem;
      font-weight: 600;
      text-align: center;
      margin-bottom: 1.25rem;
      padding-bottom: 0.5rem;
      border-bottom: 2px solid var(--card-border);
    }

    .form-group {
      margin-bottom: 1.1rem;
    }

    .form-label {
      font-weight: 500;
      color: var(--secondary-text);
      margin-bottom: 0.45rem;
      font-size: 0.92rem;
      display: block;
    }

    .form-control, .form-select {
      background: rgba(255,255,255,0.08);
      border: 1px solid rgba(255,255,255,0.2);
      color: var(--text-color);
      border-radius: 8px;
      padding: 0.75rem 1rem;
      transition: all 0.25s ease;
    }
    .form-control:focus, .form-select:focus {
      background-color: rgba(255,255,255,0.15);
      border-color: var(--primary-blue);
      box-shadow: 0 0 0 0.25rem rgba(0,123,255,0.18);
      color: #fff;
      outline: none;
    }

    .btn-primary {
      background: var(--primary-blue);
      border: none;
      padding: 0.8rem 0;
      font-weight: 600;
      font-size: 1rem;
      border-radius: 8px;
      transition: transform 0.18s ease, box-shadow 0.18s ease;
      text-transform: uppercase;
      letter-spacing: 1px;
      width: 100%;
      margin-top: 8px;
    }
    .btn-primary:hover {
      background: #0069d9;
      transform: translateY(-2px);
      box-shadow: 0 6px 18px rgba(0,123,255,0.18);
    }

    .table {
      color: var(--text-color);
      border-collapse: separate;
      border-spacing: 0;
    }
    .table thead th {
      border-bottom: 1px solid var(--card-border);
      color: var(--text-color);
      font-weight: 600;
      background: rgba(255,255,255,0.03);
    }
    .table tbody td {
      border-top: 1px solid rgba(255,255,255,0.04);
    }
    .no-data {
      color: var(--secondary-text);
      text-align: center;
      padding: 18px 0;
    }

    @media (max-width: 760px) {
      .table-box { padding: 1rem; max-width: 100%; }
      .card-box { padding: 1.25rem; max-width: 100%; }
    }
</style>
</head>
<body>
<button class="btn btn-primary mb-3"
        style="display:inline-block; width:auto; padding:0.5rem 1.5rem;"
        onclick="window.location.href='CustomerDashboardController'">
    BACK TO HOME PAGE
</button>

<div class="card-box" role="region" aria-label="Add Nominee">
  <div class="card-header">ADD NOMINEE</div>

  <form action="NomineeController" method="post">
    <div class="form-group">
      <label for="nomineeName" class="form-label">Name</label>
      <input id="nomineeName" name="nomineeName" type="text" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="nomineeDob" class="form-label">Date of Birth</label>
      <input id="nomineeDob" name="nomineeDob" type="date" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="nomineeAddress" class="form-label">Address</label>
      <textarea id="nomineeAddress" name="nomineeAddress" class="form-control" rows="3" required></textarea>
    </div>

    <div class="form-group">
      <label for="nomineePan" class="form-label">PAN Number</label>
      <input id="nomineePan" name="nomineePan" type="text" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="nomineeRelation" class="form-label">Relation</label>
      <input id="nomineeRelation" name="nomineeRelation" type="text" class="form-control" required>
    </div>

    <div class="form-group">
      <label for="linkedAccount" class="form-label">Choose Account</label>
      <select id="linkedAccount" name="accountId" class="form-select" required>
        <option value="" style="color:black;">-- Select Account --</option>
        <c:forEach var="acc" items="${accounts}">
          <option value="${acc.accountId}" style="color:black;">${acc.accountNumber} - ${acc.branchName}</option>
        </c:forEach>
      </select>
    </div>

    <button type="submit" class="btn-primary" style="color:white;">ADD NOMINEE</button>
  </form>
</div>

<div class="table-box" role="region" aria-label="Nominee Table">
  <div class="card-header">NOMINEE TABLE</div>

  <c:choose>
    <c:when test="${empty nominees}">
      <div class="no-data">No Nominees Added Yet</div>
    </c:when>

    <c:otherwise>
      <div class="table-responsive">
        <table class="table w-100">
          <thead>
            <tr>
              <th class="text-start">Name</th>
              <th>Date of Birth</th>
              <th>Address</th>
              <th>PAN Number</th>
              <th>Relation</th>
              <th>Linked Account Number</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="n" items="${nominees}">
              <tr>
                <td class="text-start">${n.name}</td>
                <td>${n.dateOfBirth}</td>
                <td>${n.address}</td>
                <td>${n.panNumber}</td>
                <td>${n.relation}</td>
                <td>${n.linkedAccountNumber}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

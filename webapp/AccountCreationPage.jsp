<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Account</title>
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
  --error-color: #dc3545;
}

body {
  background: var(--background-gradient);
  font-family: 'Poppins', sans-serif;
  margin: 0;
  padding: 20px;
}

.navbar-container {
  width: 100%;
  padding: 1rem;
}

.account-container {
  width: 100%;
  max-width: 600px;
  padding: 2rem 2.5rem;
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(10px);
  background-color: var(--card-bg);
  border: 1px solid var(--card-border);
  color: var(--text-color);
  margin: auto;
}

.card-header {
  font-size: 2rem;
  font-weight: 600;
  text-align: center;
  margin-bottom: 2rem;
  padding-bottom: 0.5rem;
  border-bottom: 2px solid var(--card-border);
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-label {
  font-weight: 500;
  color: var(--secondary-text);
  margin-bottom: 0.5rem;
  font-size: 0.9rem;
}

.form-select {
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: var(--text-color);
  border-radius: 8px;
  padding: 0.75rem 1rem;
  transition: all 0.3s ease;
}

.form-select option {
  color: #000;
  background-color: #fff;
}
.form-select option:hover {
  background-color: var(--primary-blue);
  color: #fff;
}

.form-control {
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: var(--text-color);
  border-radius: 8px;
  padding: 0.75rem 1rem;
  transition: all 0.3s ease;
}

.form-control:focus, .form-select:focus {
  background-color: rgba(255, 255, 255, 0.15);
  border-color: var(--primary-blue);
  box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
  color: #fff;
}

.error-message {
  color: var(--error-color);
  font-size: 0.8rem;
  margin-top: 0.25rem;
  display: none; 
}

.btn-primary {
  background: var(--primary-blue);
  border: none;
  padding: 0.8rem 0;
  font-weight: 600;
  font-size: 1rem;
  border-radius: 8px;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  text-transform: uppercase;
  letter-spacing: 1px;
  width: 100%;
  margin-top: 1rem;
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
</style>
</head>
<body>
<div>
    <button class="btn btn-primary mt-0" id="backToHomeButton" 
        style="width: auto; padding: 0.5rem 1.5rem;" 
        onclick="window.location.href='CustomerDashboard.jsp'">
        BACK TO HOME PAGE
    </button>
</div>

<div class="d-flex justify-content-center align-items-start" style="min-height: calc(100vh - 80px);">
  <div class="account-container">
    <div class="card-header">CREATE ACCOUNT</div>
    <div class="card-body">
      <% String errorMessage = request.getParameter("errorMessage"); %>
      <% if (errorMessage != null) { %>
      <div class="alert alert-danger alert-dismissible fade show" role="alert"
           style="border-radius: 10px; font-weight: 500;">
        <%= errorMessage %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
      <% } %>

      <form action="AccountCreationController" method="post" onsubmit="return validateForm()">
        <div class="form-group">
          <label for="accountType" class="form-label">ACCOUNT TYPE:</label>
          <select class="form-select" id="accountType" name="accountType" required>
            <option value="">--Select Account Type--</option>
            <option value="SAVINGS">SAVINGS</option>
            <option value="CURRENT">CURRENT</option>
          </select>
        </div>

        <div class="form-group">
          <label for="startBalance" class="form-label">START BALANCE:</label>
          <input type="number" class="form-control" id="startBalance" name="startBalance" min="500" step="0.01" required>
          <span id="balanceError" class="error-message"></span>
        </div>

        <div class="form-group">
          <label for="branch" class="form-label">BRANCH:</label>
          <select class="form-select" id="branch" name="branchId" required>
            <option value="">--Select Branch--</option>
            <c:choose>
              <c:when test="${not empty branches}">
                <c:forEach var="branch" items="${branches}">
                  <option value="${branch.branchId}">${branch.branchNameWithIfsc}</option>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <option value="" disabled>No branches available</option>
              </c:otherwise>
            </c:choose>
          </select>
        </div>

        <button type="submit" class="btn btn-primary">CREATE ACCOUNT</button>
      </form>
    </div>
  </div>
</div>

<script>
function validateForm() {
    const balance = document.getElementById("startBalance").value;
    const balanceError = document.getElementById("balanceError");

    if (balance === "" || parseFloat(balance) < 500) {
        balanceError.textContent = "Start balance must be more than 500";
        balanceError.style.display = "block";
        return false;
    }

    balanceError.textContent = "";
    balanceError.style.display = "none";
    return true;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

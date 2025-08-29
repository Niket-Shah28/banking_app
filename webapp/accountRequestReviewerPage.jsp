<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account Requests</title>
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
    }
    .table-custom th, 
    .table-custom td {
      padding: 1.1rem;               /* taller rows */
      vertical-align: middle;
      white-space: nowrap;           /* keep in one line */
      overflow: hidden;
      text-overflow: ellipsis;       /* ... for long text */
      max-width: 400px;              /* more room per column */
      font-size: 0.95rem;
    }
    /* Action column flexible */
    .table-custom td:last-child {
      white-space: nowrap;
      overflow: visible;
      text-overflow: unset;
      max-width: none;
    }
    /* View Profile column flexible */
    .table-custom td:nth-last-child(2) {
      white-space: nowrap;
      overflow: visible;
      text-overflow: unset;
      max-width: none;
    }
    .btn-action {
      border: none;
      padding: 0.5rem 1rem;
      border-radius: 6px;
      font-weight: 500;
      transition: 0.2s;
    }
    .btn-approve { background: #28a745; color: #fff; }
    .btn-reject { background: #dc3545; color: #fff; }
    .btn-approve:hover { background: #218838; }
    .btn-reject:hover { background: #c82333; }
    /* Modal card */
    .modal-content-custom {
      background: var(--card-bg);
      color: var(--text-color);
      border-radius: 16px;
      border: 1px solid var(--card-border);
      backdrop-filter: blur(10px);
      padding: 1rem;
    }
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom fixed-top px-3">
  <a class="navbar-brand fw-semibold" href="#">Account Requests</a>
  <button class = "ms-auto btn btn-primary" onclick="window.location.href='AdminDashboard.jsp'">BACK TO HOME PAGE</button>
</nav>

<div class="container-fluid" style="padding-top:100px;">
  <div class="table-responsive">
    <table class="table table-custom text-center align-middle w-100">
      <thead>
        <tr>
          <th>Request ID</th>
          <th>Customer Id</th>
          <th>Account Type</th>
          <th>Start Balance</th>
          <th>Branch</th>
          <th>IFSC</th>
          <th>View Profile</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="entry" items="${requestAndCustomerDetails}">
          <c:set var="request" value="${entry.value.request_details}" />
          <c:set var="customer" value="${entry.value.customer_details}" />
          <tr>
            <td>${request.requestId}</td>
            <td>${request.customerId}</td>
            <td>${request.accountType}</td>
            <td>${request.startBalance}</td>
            <td>${request.branchName}</td>
            <td>${request.ifscCode}</td>
            <td>
              <button class="btn-profile btn-sm"
                      data-bs-toggle="modal"
                      data-bs-target="#customerModal${request.requestId}">
                View Profile
              </button>
            </td>
            <td>
              <form action = "" method = "post">
                  <input type = "hidden" value = "${request.requestId}" name = "requestId">
	              <button name = "action" type = "submit" class="btn-action btn-approve" value="APPROVED">APPROVE</button>
	              <button name = "action" type = "submit" class="btn-action btn-reject" value="REJECTED">REJECT</button>
              </form>
            </td>
          </tr>

          <!-- Modal for Customer -->
          <div class="modal fade" id="customerModal${request.requestId}" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content modal-content-custom">
                <div class="modal-header">
                  <h5 class="modal-title">Customer Profile</h5>
                  <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-start">
                  <p><strong>Name:</strong> ${customer.name}</p>
                  <p><strong>Email:</strong> ${customer.email}</p>
                  <p><strong>Phone:</strong> ${customer.phone}</p>
                  <p><strong>PAN:</strong> ${customer.panNumber}</p>
                  <p><strong>Aadhar:</strong> ${customer.aadharNumber}</p>
                  <p><strong>Date of Birth:</strong> ${customer.dateOfBirth}</p>
                  <p><strong>Address:</strong> ${customer.address}</p>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

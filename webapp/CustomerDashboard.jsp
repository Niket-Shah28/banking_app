<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dashboard</title>
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

    /* Top Navbar styled to match glass look */
    .navbar-custom {
      background-color: var(--card-bg);
      backdrop-filter: blur(10px);
      border-bottom: 1px solid var(--card-border);
    }
    .navbar-custom .navbar-brand,
    .navbar-custom .nav-link {
      color: var(--text-color) !important;
    }

    .menu-btn {
      border: 1px solid var(--card-border);
      color: var(--text-color);
      background: transparent;
      border-radius: 8px;
      padding: 6px 12px;
    }
    .menu-btn:hover {
      background: rgba(255,255,255,0.08);
    }

    /* View Profile button styled like your Register page primary button */
    .btn-profile {
      background: var(--primary-blue);
      border: none;
      padding: 0.6rem 1rem;
      font-weight: 600;
      font-size: 0.95rem;
      border-radius: 8px;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      color: #fff;
    }
    .btn-profile:hover {
      background: #0069d9;
      transform: translateY(-2px);
      box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3);
    }
    .btn-profile:active {
      transform: translateY(0);
      box-shadow: none;
    }
    
    /* Custom style to remove underline */
    .btn-profile.text-decoration-none {
        text-decoration: none;
    }

    /* Sidebar (offcanvas) — solid so it's not see-through */
    .offcanvas-custom {
      background-color: #1f2833;
      color: var(--text-color);
      border-right: 1px solid var(--card-border);
    }
    .offcanvas-custom .nav-link {
      color: var(--text-color);
      border-radius: 8px;
      padding: 0.6rem 0.9rem;
    }
    .offcanvas-custom .nav-link:hover {
      background: rgba(255,255,255,0.08);
    }

    /* Cards styled like your glass register container */
    .card-custom {
      background-color: var(--card-bg);
      border: 1px solid var(--card-border);
      color: var(--text-color);
      border-radius: 16px;
      backdrop-filter: blur(10px);
      padding: 1rem;
      box-shadow: 0 10px 30px rgba(0,0,0,0.3);
      height: 100%;
    }

    /* Page spacing and centering for fixed navbar */
    .page-wrap {
      padding: 1.25rem;
      padding-top: 90px;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
    }
</style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom fixed-top px-3">
  <button class="menu-btn me-2"
          type="button"
          data-bs-toggle="offcanvas"
          data-bs-target="#sidebarMenu"
          aria-controls="sidebarMenu"
          aria-label="Toggle menu">
    &#9776;
  </button>

  <a class="navbar-brand fw-semibold ms-3" href="#">Welcome, ${name}</a>

  <div class="ms-auto">
  	<form action = "LogoutController" method = "post">
    	<button type = "submit" class="btn btn-danger">Logout</button>
    </form>
  </div>
</nav>

<div class="offcanvas offcanvas-start offcanvas-custom" tabindex="-1" id="sidebarMenu" aria-labelledby="sidebarLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="sidebarLabel">Menu</h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
    <ul class="nav flex-column">
      <li class="nav-item"><a class="nav-link" href="AccountCreationController">CREATE AN ACCOUNT</a></li>
      <li class="nav-item"><a class="nav-link" href="CustomerAccountsController">ACCOUNTS</a></li>
      <li class="nav-item"><a class="nav-link" href="AddBeneficiaryController">ADD BENEFICIARY</a></li>
      <li class="nav-item"><a class="nav-link" href="NomineeController">ADD A NOMINEE</a></li>
      <li class="nav-item"><a class="nav-link" href="PaymentController">PAY</a></li>
      <li class="nav-item"><a class="nav-link" href="CustomerDepositWithdrawController?action=WITHDRAW">WITHDRAW</a></li>
      <li class="nav-item"><a class="nav-link" href="CustomerDepositWithdrawController?action=DEPOSIT">DEPOSIT</a></li>
      <li class="nav-item"><a class="nav-link" href="CustomerTransactionController">VIEW ALL TRANSACTIONS</a></li>
      <li class="nav-item"><a class="nav-link" href="AccountCreationRequestStatusController">ACCOUNT CREATION REQUESTS STATUS</a></li>
    </ul>
  </div>
</div>

<div class="container page-wrap">
  <div class="row g-4 justify-content-center text-center">
    <div class="col-md-4">
      <div class="card-custom">
        <h5 class="mb-2">ACCOUNTS</h5>
        <p class="mb-0">You have ${numberOfAccounts} accounts active currently</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card-custom">
        <h5 class="mb-2">BALANCE</h5>
        <p class="mb-0">Your Total Balance is $ ${totalBalance}</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="card-custom">
        <h5 class="mb-2">TRANSACTIONS</h5>
        <p class="mb-0">You have done ${numberOfTransactions} transactions in current month.</p>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
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
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    
    .login-container {
      width: 100%;
      max-width: 450px;
      padding: 2.5rem;
      border-radius: 20px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
      backdrop-filter: blur(10px);
      background-color: var(--card-bg);
      border: 1px solid var(--card-border);
      text-align: center;
      color: var(--text-color);
    }

    .card-header {
      display: flex;
      padding: 0;
      border-bottom: 2px solid var(--card-border);
      margin-bottom: 1.5rem;
    }

    .toggle-btn {
      flex: 1;
      padding: 1rem;
      background: transparent;
      border: none;
      color: var(--secondary-text);
      cursor: pointer;
      font-weight: 500;
      font-size: 1.1rem;
      transition: all 0.3s ease-in-out;
      border-radius: 12px 12px 0 0;
      text-transform: uppercase;
      letter-spacing: 1px;
    }

    .toggle-btn:hover {
      background-color: rgba(255, 255, 255, 0.1);
      color: var(--text-color);
    }
    
    .toggle-btn.active-admin, .toggle-btn.active-customer {
      background: var(--primary-blue);
      color: #fff;
      font-weight: 600;
      border-bottom: none;
    }
    
    .toggle-btn:focus {
      outline: none;
      box-shadow: none;
    }
    
    .form-group {
      margin-bottom: 1.5rem;
      text-align: left;
    }
    
    .form-label {
      font-weight: 500;
      color: var(--secondary-text);
      margin-bottom: 0.5rem;
      font-size: 0.9rem;
      display: block;
    }
    
    .form-control {
      background: rgba(255, 255, 255, 0.08);
      border: 1px solid rgba(255, 255, 255, 0.2);
      color: var(--text-color);
      border-radius: 8px;
      padding: 0.75rem 1rem;
      transition: all 0.3s ease;
    }
    
    .form-control:focus {
      background-color: rgba(255, 255, 255, 0.15);
      border-color: var(--primary-blue);
      box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
      color: #fff;
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
    
    .register-link {
      margin-top: 1.5rem;
      font-size: 0.9rem;
      color: var(--secondary-text);
    }
    
    .register-link a {
      color: var(--primary-blue);
      text-decoration: none;
      font-weight: 600;
      transition: color 0.2s ease;
    }
    
    .register-link a:hover {
      color: #fff;
      text-decoration: underline;
    }
</style>
</head>
<body>
  <div class="login-container">
    <div class="card-header">
      <button id="admin" class="toggle-btn active-admin">ADMIN</button>
      <button id="customer" class="toggle-btn">CUSTOMER</button>
    </div>
    
    <div class="card-body">
      <form action="LoginController" method="post">
        <div class="form-group">
          <label for="userId" class="form-label" id="userIdLabel">ADMIN ID:</label>
          <input type="number" class="form-control" id="userId" name="userId" required>
        </div>
        
        <input type="hidden" name="role" value="ADMIN" id="role">

        <div class="form-group">
          <label for="password" class="form-label">PASSWORD:</label>
          <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <button type="submit" class="btn btn-primary w-100">LOGIN</button>
      </form>
      
      <div id="register" class="register-link d-none">
        Don't have an account? <a href="Register.jsp">Register here</a>
      </div>
    </div>
  </div>
  
  <script>
    const adminBtn = document.getElementById("admin");
    const customerBtn = document.getElementById("customer");
    const registerDiv = document.getElementById("register");
    const userLabel = document.getElementById("userIdLabel");
    const role = document.getElementById("role");
    
    adminBtn.addEventListener("click", (e) => {
      e.preventDefault();
      adminBtn.classList.add("active-admin");
      customerBtn.classList.remove("active-customer");
      userLabel.innerHTML = "ADMIN ID:";
      role.value = "ADMIN";
      registerDiv.classList.add("d-none");
    });
    
    customerBtn.addEventListener("click", (e) => {
      e.preventDefault();
      customerBtn.classList.add("active-customer");
      adminBtn.classList.remove("active-admin");
      userLabel.innerHTML = "USER ID:";
      role.value = "CUSTOMER";
      registerDiv.classList.remove("d-none");
    });
  </script>
</body>
</html>
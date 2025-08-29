<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
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
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
      padding: 20px;
    }
    
    .register-container {
      width: 100%;
      max-width: 600px;
      padding: 2rem 2.5rem;
      border-radius: 20px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
      backdrop-filter: blur(10px);
      background-color: var(--card-bg);
      border: 1px solid var(--card-border);
      color: var(--text-color);
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

    .login-link {
      margin-top: 1.5rem;
      font-size: 0.9rem;
      color: var(--secondary-text);
      text-align: center;
    }
    
    .login-link a {
      color: var(--primary-blue);
      text-decoration: none;
      font-weight: 600;
      transition: color 0.2s ease;
    }
    
    .login-link a:hover {
      color: #fff;
      text-decoration: underline;
    }
</style>
</head>
<body>
  <div class="register-container">
  
    <div class="card-header">
      REGISTER
    </div>
  
    <div class="card-body">
	    <% String errorMessage = request.getParameter("errorMessage"); %>
		<% if (errorMessage != null) { %>
		<div class="alert alert-danger alert-dismissible fade show" role="alert"
		     style="border-radius: 10px; font-weight: 500;">
		  <%= errorMessage %>
		  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
		<% } %>
      <form action="RegisterController" method="post" onsubmit="return validateForm()">
      
        <div class="form-group">
          <label for="name" class="form-label">NAME:</label>
          <input type="text" class="form-control" id="name" name="name" required>
        </div>
        
        <div class="form-group">
          <label for="email" class="form-label">EMAIL:</label>
          <input type="email" class="form-control" id="email" name="email" required>
        </div>
        
        <div class="form-group">
          <label for="phone" class="form-label">PHONE NUMBER:</label>
          <input type="tel" class="form-control" id="phone" name="phone" pattern="[6-9]{1}[0-9]{9}" title="Phone number must be of 10 digits and starting with 6,7,8 or 9" required>
        </div>
        
        <div class="form-group">
          <label for="panNumber" class="form-label">PAN NUMBER:</label>
          <input type="text" class="form-control" id="panNumber" name="panNumber" pattern="[A-Z]{5}[0-9]{4}[A-Z]{1}" title="Invalid PAN format (e.g., ABCDE1234F)" required>
        </div>
        
        <div class="form-group">
          <label for="aadharNumber" class="form-label">AADHAR NUMBER:</label>
          <input type="text" class="form-control" id="aadharNumber" name="aadharNumber" pattern="[0-9]{12}" title="Aadhar number must be 12 digits" maxlength="12" required>
        </div>
        
        <div class="form-group">
          <label for="dateOfBirth" class="form-label">DATE OF BIRTH:</label>
          <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" required>
          <span id="dobError" class="error-message"></span>
        </div>
        
        <div class="form-group">
          <label for="address" class="form-label">ADDRESS:</label>
          <textarea class="form-control" name="address" rows="3" required></textarea>
        </div>
        
        <div class="form-group">
          <label for="password" class="form-label">PASSWORD:</label>
          <input type="password" class="form-control" id="password" name="password" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$" title="Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character." required>
        </div>
        
        <button type="submit" class="btn btn-primary">REGISTER</button>
      
      </form>
      <div class="login-link">
        Have an account? <a href="Login.jsp">Login here</a>
      </div>
    </div>
  </div>
  
<script>
    function validateForm() {
        const dobInput = document.getElementById("dateOfBirth").value;
        const dobError = document.getElementById("dobError");

        if (!dobInput) {
            dobError.textContent = "Please enter your date of birth.";
            dobError.style.display = "block";
            return false;
        }

        const dob = new Date(dobInput);
        const today = new Date();
        let age = today.getFullYear() - dob.getFullYear();
        const monthDiff = today.getMonth() - dob.getMonth();

        if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
            age--;
        }

        if (age < 18) {
            dobError.textContent = "You must be at least 18 years old to register.";
            dobError.style.display = "block";
            return false;
        }

        dobError.textContent = "";
        dobError.style.display = "none";

        return true;
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
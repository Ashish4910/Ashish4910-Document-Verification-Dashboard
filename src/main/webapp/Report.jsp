<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Side Navigation Bar</title>
<link rel="stylesheet" href="CSS/employee_dashboard.css"> 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/21195f8523.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="CSS/Report.css">
<script src="Javascript/Dashboard.js"></script>
<title>Batch Data</title>
</head>
<body>

<!-- ===================================Logo and Other Details========================================================-->
<nav>
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand" href="#">
            <img src="image/img.png" alt="ICICI Logo" class="logo-img">
        </a>
        <span class="dashboard-heading">Document Verification DashBoard</span>
    </div>
</nav>
<hr class="border border-danger border-2 opacity-100" style="width: 100%; margin: 0; padding: 0;"><br>

<!-- =========================================LOGOUT============================================================== -->
<%
        // Retrieve uemail from the session
        HttpSession currentsession = request.getSession();
        String uemail = (String) currentsession.getAttribute("uemail");
        // Check if uemail is not null before using it
        if (uemail != null) {
    %>

     <div class="login-container">
	    <span class="logged-in-as">Logged in as </span>
	    <div class="user-info">
	        <%= uemail %> |
	    </div>
	    <button type="button" class=" btn btn-primary logout-button" onclick="logout()">
	        <i class="fa-solid fa-right-from-bracket fa-lg logout-icon"></i> Logout
	    </button>
    </div>
	<p id="emailDisplay" class="button"></p>
    <%
        }
    %>
<br>

<!-- =========================================Search============================================================== -->
<div class="containers">
    <form action="ExcelDownloadServlet" method="get">
        <label for="batchId">Search Batch ID</label>
        <input type="text" id="batchId" name="batchId" required>
        <button type="submit">Search and Download</button>
    </form>
    
    <form action="LanguageSearchServlet" method="get">
        <label for="language">Search Language</label>
        <input type="text" id="language" name="language" required>
        <button type="submit">Search</button>
    </form>
    
    <form action="Java_Employee_Search.jsp" method="get">
	    <label for="searchEmpNo">Search Employee ID</label>
	    <input type="text" id="id" name="id" required>
	    <button type="submit">Search</button>
	 </form>
	
	<form action="Show_All_Batches.jsp" method="post"> 
    <label>Show All Batches</label>
    <button>Show</button>
    </form>

</div>

</body>
</html>
<%@page import="Dao.DatabaseUtil"%>
<%@page import="java.util.List"%>
<%@page import="Java.EmployeeData"%>
<%@page import="Util.Method_Util"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<title>Login Form</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Mulish+SemiBold' rel='stylesheet'>
<link rel="stylesheet" href="CSS/Java_Employee_Dashbord.css">
<script src="Javascript/Java_Employee_Dashboard.js"></script>
</head>
<style>
      .table td {
            padding: 10px;
            border: 1px solid #000;
            font-size: 14px;
            font-weight: lighter;
            background-color: #EEF5FF;
        }
</style>
<body>
				<%
				// Retrieve uemail from the session
				HttpSession currentsession = request.getSession();
				String uemail = (String) currentsession.getAttribute("uemail");
				String ntidFromDatabase = (String) currentsession.getAttribute("ntidFromDatabase");

				Method_Util method_Util = new Method_Util();
				String UserName = method_Util.getUserNameForDashboard(uemail);

				// Check if uemail is not null before using it
				if (uemail != null) {
				%>
          <nav class="">
		<div class="card shadow card-brand-name">
			<div
				class="card-body mb-3 mt-2 d-flex justify-content-between align-items-center ">
				<div class="container brand-image">
					<a class="navbar-brand" href="#"> <img src="image/img.png"
						alt="ICICI Logo" class="img-responsive">
					</a>
				</div>
				
				<div class="d-flex align-items-center gap-3">
					<i class="fas fa-user-circle custom-size"></i>
					<%
					if (UserName.length() <= 20) {
					%>
					<span class="text-muted mr-3"
						style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"
						title="<%=UserName%>"><%=UserName%> <br> <%=uemail%></span>
					<%
					} else {
					%>
					<span class="text-muted mr-3"
						style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"
						title="<%=UserName%>"><%=UserName%> <br><%=uemail%></span>
					<%
					}
					%>
					<button onclick="logout()" class="logout-button-color">
						<i class="fas fa-sign-out-alt fa-2x" style="color: maroon;"></i>
					</button>
				</div>

			</div>
		</div>
	</nav>

	<nav class="navbar navbar-expand-lg bg-maroon" style="background-color: maroon; padding: .5rem 0;">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center text-center" id="navbarNav">
            <ul class="navbar-nav" style="line-height: 1;">
                <li class="nav-item">
                    <a href="Dashboard.jsp" class="nav-link dashboard-button mx-2">Dashboard</a> <!-- Change the href to the appropriate URL -->
                </li>
                <li class="nav-item">
                    <a href="UserAccess.jsp" class="nav-link dashboard-button mx-2">Authorization</a> <!-- Change the href to the appropriate URL -->
                </li>
                <li class="nav-item">
                    <a href="UserAccessView.jsp" class="nav-link dashboard-button mx-2">Access</a> <!-- Change the href to the appropriate URL -->
                </li>
            </ul>
        </div>
    </div>
</nav>

	<%
	} else if (ntidFromDatabase != null) {
	%>
	
<nav class="">
		<div class="card shadow card-brand-name">
			<div
				class="card-body mb-3 mt-2 d-flex justify-content-between align-items-center ">
				<div class="container brand-image">
					<a class="navbar-brand" href="#"> <img src="image/img.png"
						alt="ICICI Logo" class="img-responsive">
					</a>
				</div>
				
<div class="d-flex align-items-center gap-3">
    <i class="fas fa-user-circle custom-size"></i>
    <span class="text-muted mr-3"><%=ntidFromDatabase%></span>
    <button onclick="logout()" class="logout-button-color">
        <i class="fas fa-sign-out-alt fa-2x" style="color: maroon;"></i>
    </button>
</div>

</div>
</div>
</nav>
	<%
	} else {
	// Handle the case where uemail is null (e.g., redirect to login)
	response.sendRedirect("Login.jsp"); // Replace with the actual login page
	}
	%>

<!-- =========================================TABLE============================================================== -->
<%
try {
// Load the MySQL JDBC driver

Connection con = DatabaseUtil.getConnection();

List<EmployeeData> uploadedData = (List<EmployeeData>) request.getSession().getAttribute("uploadedData");

if (uploadedData != null) {
    for (EmployeeData employee : uploadedData) {           
    }
}

// Display the data
%>

<div class="table-container">
    <div class="table-scroll">
        <table class="table">
            <thead>
                <tr>
                    <th class="text">Employee ID</th>
                    <th class="text">Employee Name</th>
                    <th class="text">Employee Location</th>  
                    <th class="text">Employee EMPNO.</th>
                    <th class="text">Employee HireDate</th>  
                    <th class="text">Employee DEPTNO.</th>
                    <th class="text">Employee Salary</th>
                    <th class="text">Employee DOB</th>
                    <th class="text">Employee Blood Group</th>
                    <th class="text">Employee Gender</th>
                </tr>
            </thead>
            <tbody>
                <% if (uploadedData != null) {
                    for (EmployeeData employee : uploadedData) { %>
                <tr>
                    <td class="text-center"><b><%= employee.getId() %></b></td>
                    <td class="text-center"><b><%= employee.getName() %></b></td>
                    <td class="text-center"><b><%= employee.getLocation() %></b></td>
                    <td class="text-center"><b><%= employee.getEmpno() %></b></td>
                    <td class="text-center"><b><%= employee.getHiredate() %></b></td>
                    <td class="text-center"><b><%= employee.getDeptno() %></b></td>
                    <td class="text-center"><b><%= employee.getSalary() %></b></td>
                    <td class="text-center"><b><%= employee.getDob() %></b></td>
                    <td class="text-center"><b><%= employee.getBlood_group() %></b></td>
                    <td class="text-center"><b><%= employee.getGender() %></b></td>
                </tr>
                <% } } %>
            </tbody>
        </table>
    </div>
</div>

<%
// Close the database connection
con.close();
} catch (Exception e) {
e.printStackTrace();
}
%>

<%
// Code for generating the Excel download link
try {
// Create a link to download the data as an Excel file
String downloadLink = "download-data.jsp"; // Change to the appropriate URL for download
%>
<div class="button-container">
    <button type="button" class="btn btn-primary btn-sm download-btn">
        <a href="<%=downloadLink %>">
        Download</a><i class="fas fa-download"></i>
    </button>
<%
} catch (Exception e) {
e.printStackTrace();
}
%>

<form method="post" action="Java_Final_Save">
    <button type="submit" class="btn btn-primary btn-sm save-btn" onclick="generateAndSetBatchId()">
        Final Save <i class="fas fa-upload"></i>
    </button>
    <input type="hidden" id="batchId" name="batchId">
</form>

<form method="post" action="Java_Reject_Batch">
    <button type="submit" class="btn btn-danger btn-sm reject-btn" onclick="confirmAndSubmit()">
        Reject Batch
    </button>
</form>
</div>

</body>
</html>
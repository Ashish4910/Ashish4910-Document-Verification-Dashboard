<%@page import="Util.Method_Util"%>
<%@page import="Dao.DatabaseUtil"%>
<%@page import="Java.EmployeeData"%>
<%@page import="java.util.List"%>
<%@page
	import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import="org.apache.poi.ss.usermodel.WorkbookFactory"%>
<%@ page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="java.io.FileInputStream, java.text.NumberFormat"%>
<%@page import="java.util.Random"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document Verification Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/21195f8523.js"
	crossorigin="anonymous"></script>
<script src="Javascript/Java_Employee_Dashboard.js"></script>
<script src="Javascript/Dashboard.js"></script>
<!-- <link rel="stylesheet" href="CSS/Java_Employee_Dashboard.css"> -->


<style>
body {
	background-color: #FEFBF6;
	font-family: "Mulish SemiBold";
	font-size: 16px;
}

.img-responsive {
	width: 250px;
}

.brand-image {
	margin-left: 0px;
}

.card {
	--bs-card-spacer-x: none;
}

.card-brand-name {
	border-radius: 0;
}

.card.shadow {
	background-color: #FFFFFF;
}

.nav-link {
	color: white;
	font-size: 20px;
}

.nav-link:hover {
	color: orange;
}

.custom-size {
	font-size: 2.5em;
}

.logout-button-color {
	border-color: coral;
}

.logout-button-color:hover {
	background-color: #FEFBF6;
	color: white;
}

/* Table styling starts from here */
.container {
	max-width: 1350px;
}

.table-wrapper {
	max-height: 300px; /* Adjust the max height as needed */
	overflow-y: auto;
	position: relative;
}

.table {
	--bs-table-bg: none;
	width: 120%;
}

.container table.table thead {
	background-color: #6c7ae0;
	position: sticky;
	top: 0;
	z-index: 1;
}

.custom-table, .custom-table tbody, .custom-table thead tr,
	.custom-table tbody tr {
	border: none !important;
}

.custom-table thead th {
	border: none !important;
	color: white;
}

.custom-table thead th {
	border: none !important;
	color: white;
	font-size: 16px;
}

.custom-table tbody td {
	border: none !important;
	font-size: 14px;
}

.custom-table {
	border-radius: 10px;
}

.custom-table thead th:first-child {
	border-top-left-radius: 10px;
}

.custom-table thead th:last-child {
	border-top-right-radius: 10px;
}

.custom-table tbody tr:nth-child(odd) {
	background-color: #EEEDED;
}

.custom-table tbody tr:nth-child(even) {
	background-color: #f8f6ff;
}

.custom-table tbody tr td {
	color: #333333;
	font-family: Mulish SemiBold;
}

.btn a {
	text-decoration: none;
	color: inherit;
}

.btn i {
	margin-left: 5px;
}

.btn-danger {
	background-color: #6c7ae0;
	border: 1px solid #dc3545;
	color: white;
}

.btn-danger:hover {
	background-color: #c82333;
}

.button-container {
	text-align: center;
	margin-top: 10px;
}

.download-btn {
	background-color: #6c7ae0;
	color: #fff;
	margin-left: 1230px;
	margin-top: 10px;
}

.save-btn {
	background-color: #6c7ae0;
	color: #fff;
	margin-left: 970px;
	margin-top: -53px;
}

.reject-btn {
	background-color: #6c7ae0;
	color: #fff;
	margin-top: -100px;
	margin-left: 710px;
	border: none;
}
</style>

</head>
<body>
	<nav class="mb-3 shadow">
		<div class="card shadow card-brand-name">
			<div
				class="card-body mb-3 mt-2 d-flex justify-content-between align-items-center ">
				<div class="container brand-image">
					<a class="navbar-brand" href="#"> <img src="image/img.png"
						alt="ICICI Logo" class="img-responsive">
					</a>
				</div>

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

				<div class="d-flex align-items-center gap-3">
					<!-- <a href="#" class="text-dark mr-1"> -->
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
					<%-- </a> <span class="text-muted mr-3"><%=UserName%> |<br><%=uemail%></span> --%>
					<button onclick="logout()" class="text-dark logout-button-color">
						<i class="fas fa-sign-out-alt fa-2x" style="color: maroon;"></i>
					</button>
				</div>
			</div>
		</div>
	</nav>

	<nav class="navbar navbar-expand-lg bg-maroon"
		style="background-color: maroon; padding: .5rem 0;">
		<div class="container-fluid ">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div
				class="collapse navbar-collapse justify-content-center text-center "
				id="navbarNav">
				<ul class="navbar-nav" style="line-height: 1;">
					<li class="nav-item"><a href="#"
						class="nav-link dashboard-button mx-2" onclick="buttonClicked()">Dashboard</a>
					</li>
					<li class="nav-item"><a href="#"
						class="nav-link dashboard-button mx-2" onclick="button1Clicked()">Authorization</a>
					</li>
					<li class="nav-item"><a href="#"
						class="nav-link dashboard-button mx-2" onclick="button2Clicked()">Access</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>


	<%
	} else if (ntidFromDatabase != null) {
	%>

	<div class="d-flex align-items-center">
		<a href="#" class="text-dark mr-1"> <i
			class="fas fa-user-circle custom-size"></i>
		</a> <span class="text-muted mr-3"><%=ntidFromDatabase%></span> <a
			href="Login.jsp" class="text-dark"> <i
			class="fas fa-sign-out-alt fa-2x" style="color: maroon;"></i>
		</a>
	</div>

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
	<div class="container p-4">
		<div class="table-wrapper">
			<table class="table custom-table table100-body">
				<thead>
					<tr>
						<th class="text-center">Employee ID</th>
						<th class="text-center">Employee Name</th>
						<th class="text-center">Employee Location</th>
						<th class="text-center">Employee EmpNo.</th>
						<th class="text-center">Employee HireDate</th>
						<th class="text-center">Employee DeptNo.</th>
						<th class="text-center">Employee Salary</th>
						<th class="text-center">Employee DOB</th>
						<th class="text-center">Employee Blood Group</th>
						<th class="text-center">Employee Gender</th>
					</tr>
				</thead>
				<tbody style="background-color: #FFFFFF;" class="text-center">
					<%
					if (uploadedData != null) {
						for (EmployeeData employee : uploadedData) {
					%>
					<tr>
						<td class="text-center"><b><%=employee.getId()%></b></td>
						<td class="text-center"><b><%=employee.getName()%></b></td>
						<td class="text-center"><b><%=employee.getLocation()%></b></td>
						<td class="text-center"><b><%=employee.getEmpno()%></b></td>
						<td class="text-center"><b><%=employee.getHiredate()%></b></td>
						<td class="text-center"><b><%=employee.getDeptno()%></b></td>
						<td class="text-center"><b><%=employee.getSalary()%></b></td>
						<td class="text-center"><b><%=employee.getDob()%></b></td>
						<td class="text-center"><b><%=employee.getBlood_group()%></b></td>
						<td class="text-center"><b><%=employee.getGender()%></b></td>
					</tr>
					<%
					}
					}
					%>
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
			<a href="<%=downloadLink%>"> Download</a><i class="fas fa-download"></i>
		</button>
		<%
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
		<form method="post" action="Java_Final_Save">
			<button type="submit" class="btn btn-primary btn-sm save-btn"
				onclick="generateAndSetBatchId()">
				Final Save <i class="fas fa-upload"></i>
			</button>
			<input type="hidden" id="batchId" name="batchId">
		</form>
		<form method="post" action="Java_Reject_Batch">
			<button type="submit" class="btn btn-danger btn-sm reject-btn"
				onclick="confirmAndSubmit()">Reject Batch</button>
		</form>
	</div>

</body>
</html>

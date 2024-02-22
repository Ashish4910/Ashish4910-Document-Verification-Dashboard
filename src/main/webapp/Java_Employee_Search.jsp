<%@page import="Util.Method_Util"%>
<%@page import="Dao.DatabaseUtil"%>
<%@page import="Dao.QueryUtil"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Employee Search Result</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/21195f8523.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- <link rel="stylesheet" href="CSS/Java_Employee_Search.css"> -->
<script src="Javascript/Dashboard.js"></script>
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
	max-width: 1140px;
	margin-left: 10px;
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

.download-link {
	text-decoration: none;
	color: white;
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

	<br>
	<br>

	<!-- =========================================TABLE============================================================== -->

	<%
	String employeeid = request.getParameter("id");
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	boolean hasRows = false; // Flag to check if there are rows
	try {

		con = DatabaseUtil.getConnection();
		pstmt = con.prepareStatement(QueryUtil.Java_Employee_Search_selectQuery);
		pstmt.setString(1, employeeid);
		rs = pstmt.executeQuery();
	%>
	<div class="container p-4">
		<table class="table custom-table table100-body">
			<%
			while (rs.next()) {
			%>
			<thead>
				<tr>
					<th class="text-center">Employee ID</th>
					<th class="text-center">Employee Name</th>
					<th class="text-center">Location</th>
					<th class="text-center">EMPNO</th>
					<th class="text-center">Hiredate</th>
					<th class="text-center">Deptno</th>
					<th class="text-center">Salary</th>
					<th class="text-center">DOB</th>
					<th class="text-center">Blood_Group</th>
					<th class="text-center">Gender</th>
					<th class="text-center">Download</th>
				</tr>
			</thead>
			<tbody style="background-color: #FFFFFF;" class="text-center">
				<%
				hasRows = true; // Set the flag to true if there are rows
				String id = rs.getString("id");
				String name = rs.getString("name");
				String location = rs.getString("location");
				String empno = rs.getString("empno");
				String hiredate = rs.getString("hiredate");
				String deptno = rs.getString("deptno");
				String salary = rs.getString("salary");
				String dob = rs.getString("dob");
				String blood_group = rs.getString("blood_group");
				String gender = rs.getString("gender");
				%>
				<tr>
					<td class="text-center"><%=id%></td>
					<td class="text-center"><%=name%></td>
					<td class="text-center"><%=location%></td>
					<td class="text-center"><%=empno%></td>
					<td class="text-center"><%=hiredate%></td>
					<td class="text-center"><%=deptno%></td>
					<td class="text-center"><%=salary%></td>
					<td class="text-center"><%=dob%></td>
					<td class="text-center"><%=blood_group%></td>
					<td class="text-center"><%=gender%></td>

					<td>
						<button type="button" class="btn btn-primary btn-sm">
							<a
								href='Java_EmployeeSearch_Download_Servlet?id=<%=rs.getString("id")%>'
								class="download-link">Download</a>
						</button>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<%
	// Check if there are no rows
	if (!hasRows) {
	%>
	<script>
		alert("This Employee ID is not existing in our database.");
		window.location.href = "Report.jsp";
	</script>
	<%
	}
	} catch (Exception e) {
	%>
	<h2>An error occurred:</h2>
	<p><%=e.getMessage()%></p>
	<%
	} finally {
	try {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (con != null)
			con.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
	}
	%>
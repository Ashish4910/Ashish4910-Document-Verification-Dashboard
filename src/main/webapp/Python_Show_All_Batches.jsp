<%@page import="java.sql.SQLException"%>
<%@page import="Util.Method_Util"%>
<%@page import="Dao.QueryUtil"%>
<%@page import="Dao.DatabaseUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Python Show all batches</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/21195f8523.js"
	crossorigin="anonymous"></script>
<!-- <link rel="stylesheet" href="CSS/Python_Show_All_Batches.css">-->
<script src="Javascript/Dashboard.js"></script>
</head>
<style>

/* ================ table font size ======= */
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

/* Table */
.container-table {
	margin-top: 20px;
}

.table th, .table td {
	text-align: center;
}

.upload-button {
	text-align: center;
}

.download-button {
	text-align: center;
}

.upload-label {
	cursor: pointer;
}

.upload-input {
	display: none;
}

.submit-link {
	text-decoration: none;
	color: white;
}

.submit-link:hover {
	text-decoration: underline;
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
.table-wrapper {
	max-height: 330px; /* Adjust the max height as needed */
	overflow-y: auto;
	margin-left: 300px;
	width: 50%;
}

.table {
	--bs-table-bg: none;
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
	font-family: Lato-Bold;
}
</style>
<body>

	<!-- ===================================Logo and Other Details========================================================-->
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
	<nav class="mb-3 shadow">
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

	<nav class="navbar navbar-expand-lg bg-maroon"
		style="background-color: maroon; padding: .5rem 0;">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div
				class="collapse navbar-collapse justify-content-center text-center"
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

	Connection conn = null;
	PreparedStatement selectUserPstmt = null;
	ResultSet resultSet = null;
	String username = null;

	try {
		// Get a connection from the DatabaseUtil class
		conn = DatabaseUtil.getConnection();

		// Prepare the SQL statement to retrieve the username based on ntid
		String sql = "SELECT name FROM [user] WHERE ntid = ?";
		selectUserPstmt = conn.prepareStatement(sql);
		selectUserPstmt.setString(1, ntidFromDatabase);

		// Execute the query
		resultSet = selectUserPstmt.executeQuery();

		// Check if a record is found
		if (resultSet.next()) {
			// Retrieve the username from the result set
			username = resultSet.getString("name");
		}
	} catch (Exception e) {
		// Handle SQL exceptions
		e.printStackTrace();
	} finally {
		// Close resources in the finally block
		// ...
	}
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
						title="<%=username%>"><%=username%> <br> <%=ntidFromDatabase%></span>
					<%
					} else {
					%>
					<span class="text-muted mr-3"
						style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"
						title="<%=username%>"><%=username%> <br><%=ntidFromDatabase%></span>
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
	<%
	} else {
	// Handle the case where uemail is null (e.g., redirect to login)
	response.sendRedirect("Login.jsp"); // Replace with the actual login page
	}
	%>
	<!-- =========================================TABLE============================================================== -->
	<%
	try {
		Connection con = DatabaseUtil.getConnection();
		PreparedStatement pstmt = con.prepareStatement(QueryUtil.Python_Show_All_Batches_selectQuery);
		ResultSet rs = pstmt.executeQuery();
	%>

	<div class="container p-4">
		<div class="table-wrapper">
			<div style="overflow-x: auto;">
				<table class="table custom-table table100-body">
					<thead>
						<tr>
							<th class="text-center">Id</th>
							<th class="text-center">Batches</th>
						</tr>
					</thead>
					<tbody style="background-color: #FFFFFF;" class="text-center">
						<%
						while (rs.next()) {
						%>
						<tr>
							<td class="text-center"><b><%=rs.getString("id")%></b></td>
							<td class="text-center"><b><%=rs.getString("batch_id")%></b></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%
	} catch (Exception e) {
	e.printStackTrace();
	}
	%>
</body>
</html>
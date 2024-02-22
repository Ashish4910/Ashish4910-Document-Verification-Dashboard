<%@page import="Dao.DatabaseUtil"%>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Mulish+SemiBold'
	rel='stylesheet'>
<!-- <link rel="stylesheet" href="CSS/Dashboard.css"> -->
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

table {
	border-collapse: collapse;
	width: 100%;
	margin: 20px auto;
}

th, td {
	border: 1px solid #333333;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
	font-size: 17px;
}

td {
	font-size: 16px;
}

.nav-link {
	color: white;
	font-size: 20px;
}

.nav-link:hover {
	color: orange;
}

.table {
	--bs-table-bg: none;
}

.container table.table thead {
	background-color: #6c7ae0;
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

.custom-table, .custom-table tbody, .custom-table thead tr,
	.custom-table tbody tr {
	border: none !important;
}

.custom-table thead th {
	border: none !important;
}

.custom-table tbody td, th {
	border: none !important;
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
</head>
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
	} catch (SQLException e) {
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


	<!-- ===================================Table========================================================-->
	<div class="container p-4">
		<table class="table custom-table table100-body">
			<thead>
				<tr>
					<th class="text-white">Id</th>
					<th class="text-white">Process</th>
					<th class="text-white">Upload</th>
					<th class="text-white">Download Template</th>
					<th class="text-white">Submit</th>
				</tr>
			</thead>
			<tbody style="background-color: #FFFFFF;">
				<tr>
					<td>1</td>
					<td>Process 1</td>
					<td class="upload-button">
						<form action="java_uploadFile" method="post"
							enctype="multipart/form-data">
							<input type="hidden" id="java" name="java">
							<button type="button" class="btn btn-danger btn-sm">
								<!-- Update the "Upload File" label with the new class -->
								<label class="upload-label">Upload File<input
									type="file" name="file" class="upload-input"
									onchange="uploadFile(this)"></label>
							</button>
						</form>
					</td>
					<td class="download-button">
						<div id="selectedFileName"></div>
						<button type="button" class="btn btn-primary btn-sm">
							<a href="Java_Download.jsp" class="submit-link">Download</a>
						</button>
					</td>
					<td>
						<button type="button" class="btn btn-primary btn-sm">
							<a href="Java_Insert_Data.jsp" class="submit-link">Submit</a>
						</button>
					</td>
				</tr>
				<tr>
					<td>2</td>
					<td>Process 2</td>
					<td class="upload-button">
						<form action="python_uploadFile" method="post"
							enctype="multipart/form-data">
							<button type="button" class="btn btn-danger btn-sm">
								<label class="upload-label">Upload File<input
									type="file" name="file" class="upload-input"
									onchange="uploadFile(this)"></label>
							</button>
						</form>
					</td>
					<td class="download-button">
						<button type="button" class="btn btn-primary btn-sm">
							<a href="Python_Download.jsp" class="submit-link">Download</a>
						</button>
					</td>
					<td>
						<button type="button" class="btn btn-primary btn-sm">
							<a href="Python_Insert_Data.jsp" class="submit-link">Submit</a>
						</button>
					</td>
				</tr>
				<tr>
					<td>3</td>
					<td>Process 3</td>
					<td class="upload-button">
						<form action="java_uploadFile" method="post"
							enctype="multipart/form-data">
							<button type="button" class="btn btn-danger btn-sm">
								<label class="upload-label ">Upload File<input
									type="file" name="file" class="upload-input"
									onchange="uploadFile(this)"></label>
							</button>
						</form>
					</td>

					<td class="download-button">
						<div id="selectedFileName"></div>
						<button type="button" class="btn btn-primary btn-sm">
							<a href="#" class="submit-link">Download</a>
						</button>
					</td>

					<td>
						<button type="button" class="btn btn-primary btn-sm">
							<a href="#" class="submit-link">Submit</a>
						</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>


</body>
</html>

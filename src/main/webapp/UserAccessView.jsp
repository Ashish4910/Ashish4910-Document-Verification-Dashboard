<%@page import="Util.Method_Util"%>
<%@page import="Dao.DatabaseUtil"%>
<%@page import="Dao.QueryUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
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
<!--  <link rel="stylesheet" href="CSS/UserAccessView.css"> -->
<script src="Javascript/Dashboard.js"></script>
<script data-require="jquery@*" data-semver="2.0.3"
	src="http://code.jquery.com/jquery-2.0.3.min.js"></script>

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

/* Disabled button styles */
.action-button:disabled {
	background-color: #000000;
	cursor: not-allowed;
}

/* Table styling starts from here */
table.scrolldown {
	width: 90%;
	border-spacing: 0;
	border: 2px solid black;
	margin-top: 60px;
	margin-left: 75px;
}

/* To display the block as level element */
table.scrolldown tbody, table.scrolldown thead {
	display: block;
}

thead tr th {
	height: 40px;
	line-height: 40px;
}

table.scrolldown tbody {
	/* Set the height of table body */
	height: 254px;
	overflow-y: auto;
	overflow-x: hidden;
}

th {
	padding: 5px;
	min-width: 200px;
	border-bottom: 1px solid black;
	background-color: #6c7ae0;
	color: white;
	font-size: 16px;
}

td {
	padding: 5px;
	min-width: 200px;
	border-bottom: 1px solid black;
	font-size: 14px;
}

tbody {
	border-top: 2px solid black;
}

tbody td, thead th {
	width: 200px;
	border-right: 2px solid black;
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
					<i class="fas fa-user-circle custom-size"></i> <span
						class="text-muted mr-3"><%=ntidFromDatabase%></span>
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

	<%
	String url = "jdbc:sqlserver://DESKTOP-T477JVJ;DatabaseName=ems;encrypt=false;user=root;password=dvd@123";
	Connection conn = null;
	PreparedStatement selectAllPstmt = null;
	PreparedStatement truncateUserPstmt = null;
	PreparedStatement truncateUserAccessPstmt = null; // New PreparedStatement for user_access
	try {
		conn = DatabaseUtil.getConnection();
		selectAllPstmt = conn.prepareStatement(QueryUtil.UserAccessView_selectAllQuery);
		ResultSet resultSetAll = selectAllPstmt.executeQuery();
		if (resultSetAll.next()) {
	%>


	<!-- HTML code using external CSS classes -->
	<table class="scrolldown">
		<thead>
			<tr>
				<th class="text-center">NT ID</th>
				<th class="text-center">Password</th>
				<th class="text-center">Job Title</th>
				<th class="text-center">Grant</th>
				<th class="text-center">Revoke</th>
				<th class="text-center">Action</th>
			</tr>
		</thead>
		<tbody style="background-color: #FFFFFF;" class="text-center">
			<%
			do {
				String ID = resultSetAll.getString("id");
				String fetchedNTID = resultSetAll.getString("ntid");
				String fetchedPassword = resultSetAll.getString("password");
				String fetchedJobTitle = resultSetAll.getString("job_title");
				String fetchedUserAccess = resultSetAll.getString("user_accesscol");
			%>

			<tr>
				<td><%=fetchedNTID%></td>
				<td><%=fetchedPassword%></td>
				<td><%=fetchedJobTitle%></td>

				<td>
					<form action='grantrecord' method="post">
						<input type="hidden" name="id" value="<%=ID%>">
						<button type="submit" name="action" value="grant"
							class="btn btn-danger btn-sm action-button"
							<%=fetchedUserAccess.equals("1") ? "disabled" : ""%>>Grant</button>
					</form>
				</td>

				<td>
					<form action='grantrecord' method="post">
						<input type="hidden" name="id" value="<%=ID%>">
						<button type="submit" name="action" value="revoke"
							class="btn btn-danger btn-sm action-button"
							<%=fetchedUserAccess.equals("0") ? "disabled" : ""%>>Revoke</button>
					</form>
				</td>

				<td>
					<form action='DeleteRecord' method="post">
						<input type="hidden" name="id" value="<%=ID%>">
						<button type="submit" name="delete"
							class="btn btn-danger btn-sm action-button">Delete</button>
					</form>
				</td>
			</tr>

			<%
			} while (resultSetAll.next());
			%>
		</tbody>
	</table>

	<%
	} else {
	// Truncate the user and user_access tables when no users are found
	truncateUserPstmt = conn.prepareStatement(QueryUtil.UserAccessView_truncateUserQuery);
	truncateUserAccessPstmt = conn.prepareStatement(QueryUtil.UserAccessView_truncateUserAccessQuery);
	truncateUserPstmt.executeUpdate();
	truncateUserAccessPstmt.executeUpdate();
	%>
	<div style="text-align: center; margin-top: 20px;">
		<div class="alert alert-warning alert-dismissible fade show"
			role="alert">
			<strong>Users Not Found</strong>
		</div>
	</div>
	<%
	}
	} catch (ClassNotFoundException | SQLException e) {
	e.printStackTrace();
	out.print(
			"<script>alert('Error fetching users! Please check logs for details.'); window.location.href='UserAccess.jsp';</script>");
	} finally {
	try {
	if (selectAllPstmt != null) {
		selectAllPstmt.close();
	}
	if (truncateUserPstmt != null) {
		truncateUserPstmt.close();
	}
	if (conn != null) {
		conn.close();
	}
	} catch (SQLException e) {
	e.printStackTrace();
	}
	}
	%>


</body>
</html>
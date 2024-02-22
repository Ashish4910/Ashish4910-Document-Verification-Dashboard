<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@page import="Util.Method_Util"%>
<%@page import="Dao.DatabaseUtil"%>
<%@page import="Dao.QueryUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Side Navigation Bar</title>
<link rel="stylesheet" href="CSS/employee_dashboard.css">
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
<!-- <link rel="stylesheet" href="CSS/Report.css"> -->
<script src="Javascript/Dashboard.js"></script>
<title>Batch Data</title>

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

.inline-block {
	display: inline-block;
}

.h5, h5 {
	font-size: 1.75rem;
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
				<%
				}
				%>
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




	<marquee class="text-danger fs-5">In This Page you can Search
		the Excel by the Id and you can Download the Excel</marquee>
	<br>

	<!-- =========================================Search============================================================== -->



	<div
		class="modal modal-sheet position-static d-block bg-body-secondary p-2 py-md-2"
		tabindex="-1" role="dialog" id="modalChoice">
		<div class="modal-dialog " role="document">
			<div class="modal-content rounded-3 shadow p-3">
				<div class="modal-body p-4 text-center">
					<div class="inline-block">
						<i class="fa-solid fa-magnifying-glass fa-2x"></i>
						<h5 class="mb-0 inline-block">Search the Excel Sheet</h5>
					</div>
				</div>



				<hr>


				<div class="containers  ">

					<form action="ExcelDownloadServlet" method="get">
						<!-- 	<label for="batchId">Search Batch ID</label>  -->
						<input type="text" id="batchId" name="batchId" required
							placeholder="Search Batch ID">
						<button class="btn btn-primary btn-sm " type="submit">Search
							and Download</button>
					</form>
					<hr>


					<form action="LanguageSearchServlet" method="get">
						<input type="text" id="language" name="language" required
							placeholder="Search Batch ID">
						<button class="btn btn-primary btn-sm " type="submit">Search</button>
					</form>
					<hr>

					<form action="Java_Employee_Search.jsp" method="get">
						<input type="text" id="id" name="id" required
							placeholder="Search Employee ID">
						<button class="btn btn-primary btn-sm " type="submit">Search</button>
					</form>
					<hr>

					<form action="Show_All_Batches.jsp" method="post">
						<label>Show All Batches</label>
						<button class="btn btn-primary btn-sm ">Show</button>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
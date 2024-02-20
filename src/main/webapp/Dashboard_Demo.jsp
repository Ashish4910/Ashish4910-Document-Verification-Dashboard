<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<title>Dashboard Demo</title>


<%@ include file="BootStrap/BootStrap_Link.jsp"%>

<link rel="stylesheet" href="CSS/Dashboard_Demo.css">

<script src="Javascript/Dashboard.js"></script>



</head>

<body>




	<!-- ===================================Logo and Other Details========================================================-->
	<nav class="">
		<div class="brand-container mt-3 mb-3">
			<div class="row">
				<div class="col-5 custom-div-brand-1">
					<div class="container brand-image">
						<a class="navbar-brand " href="#"> <img src="image/img.png"
							alt="ICICI Logo" class="img-responsive">
						</a> <span class="dashboard-heading">Document Verification
							Dashboard </span>
					</div>
				</div>
				<!-- ===================================Logout========================================================-->
				<%
				// Retrieve uemail from the session
				HttpSession currentsession = request.getSession();
				String uemail = (String) currentsession.getAttribute("uemail");
				String ntidFromDatabase = (String) currentsession.getAttribute("ntidFromDatabase");

				// Check if uemail is not null before using it
				if (uemail != null) {
				%>
				<div class="col-7 custom-div-brand-2 d-flex login-container">
					<!-- Added id to the second div -->
					<!-- ALL buttons are here -->
					<a href="Dashboard.jsp" class="btn logger-Dashboard">Dashboard</a>
					<a href="UserAccess.jsp" class="btn logger-Authorization">Authorization</a>
					<a href="UserAccessView.jsp" class="btn logger-Access">Access</a>

					<div class="logger d-flex">
						<span class="logged-in-as">Logged in as </span>
						<div class="user-info">
							<%=uemail%>

							|
						</div>
						<button type="button" class="btn  logout-button  sm-btn"
							onclick="logout()">
							<i class="fa-solid fa-right-from-bracket fa-lg logout-icon"></i>
							Logout
						</button>
					</div>
				</div>
			</div>
		</div>
	</nav>



	<hr class="border border-danger border-2 opacity-100"
		style="width: 100%; margin: 0; padding: 0;">
	<br>




	<%
	} else if (ntidFromDatabase != null) {
	%>

	<div class="login-container">
		<span class="logged-in-as">Logged in as </span>
		<div class="user-info">
			<%=ntidFromDatabase%>
			|
		</div>
		<button type="button" class="btn btn-primary logout-button"
			onclick="logout()">
			<i class="fa-solid fa-right-from-bracket fa-lg logout-icon"></i>
			Logout
		</button>
	</div>
	<br>
	<br>
	<br>
	<%
	} else {
	// Handle the case where uemail is null (e.g., redirect to login)
	response.sendRedirect("Login.jsp"); // Replace with the actual login page
	}
	%>
	<!-- ===================================Table========================================================-->

	<div class="container">
		<table class="table table-hover table-bordered ">
			<thead>
				<tr>
					<th>Id</th>
					<th>Process</th>
					<th>Upload</th>
					<th>Download Template</th>
					<th>Submit</th>
				</tr>
			</thead>
			<tbody class="table-group-divider">
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
							<a href="Java_Download.jsp" class="submit-link text-white">Download</a>
						</button>
					</td>
					<td>
						<button type="button" class="btn btn-primary btn-sm">
							<a href="Java_Insert_Data.jsp" class="submit-link text-white">Submit</a>
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
							<a href="Python_Download.jsp" class="submit-link text-white">Download</a>
						</button>
					</td>
					<td>
						<button type="button" class="btn btn-primary btn-sm">
							<a href="Python_Insert_Data.jsp" class="submit-link text-white">Submit</a>
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
									type="file" name="file" class="upload-input "
									onchange="uploadFile(this)"></label>
							</button>
						</form>
					</td>

					<td class="download-button">
						<div id="selectedFileName"></div>
						<button type="button" class="btn btn-primary btn-sm">
							<a href="#" class="submit-link text-white">Download</a>
						</button>
					</td>

					<td>
						<button type="button" class="btn btn-primary btn-sm">
							<a href="#" class="submit-link text-white">Submit</a>
						</button>
					</td>
				</tr>
			</tbody>
		</table>

	</div>




</body>
</html>
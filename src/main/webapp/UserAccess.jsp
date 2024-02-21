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
<title>UserAccess</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- <link rel="stylesheet" href="CSS/UserAccess.css"> -->
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

form {
	max-width: 500px;
	margin: 0 auto;
	padding: 30px;
	border: none;
	/* Remove border */
	background-color: #fff;
	border-radius: 15px;
	/* Add curved border */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	/* Add shadow */
	text-align: center;
}

.form-control {
	border-radius: 0;
}

.form-group.ntid {
	margin-bottom: 20px;
	/* Added margin bottom for NT ID input */
	width: 85%;
}

.form-group {
	width: 85%;
}

label {
	display: block;
	margin-bottom: 5px;
	text-align: left;
}

.input-group-text {
	display: flex;
	align-items: center;
	padding: 0.375rem 0.75rem;
	font-size: 1rem;
	font-weight: 400;
	line-height: 1.5;
	color: var(--bs-body-color);
	text-align: center;
	white-space: nowrap;
	background-color: var(--bs-tertiary-bg);
	border: none;
}

.input-group {
	margin-left: 20px;
}

.input-form-text {
	height: 32px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-left: 10px;
}

.text-center {
	width: 100%;
}

.btn {
	width: 25%;
}

.btn-primary {
	background-color: #000000;
}

.fa-white-bg {
	background-color: white;
	border: none;
	padding: 10px;
	border-radius: 4px 0 0 4px;
}

.input-group-text .fas {
	font-size: 1.3rem;
	margin-top: -5px;
}

*, ::after, ::before {
	box-sizing: content-box;
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
	<nav class="mb-3 shadow ">
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

	<!------------------------------------------------ HTML code using external CSS classes ---------------------------------------------->
	<!-- 	<form action="authorization" method="post" class="form-container">
		<h3 class="form-heading">Authorization</h3>
		<hr class="form-hr">

		<label for="ntid" class="form-label">NT ID</label> <input type="text"
			name="ntid" id="ntid" required="required" class="form-input">

		<label for="passwords" class="form-label">Password</label> <input
			type="password" name="passwords" id="passwords" required="required"
			class="form-input"> <label for="job_title" class="form-label">Job
			Title</label> <input type="text" name="job_title" id="job_title"
			required="required" class="form-input">

		<button type="submit" class="btn btn-primary form-button">Add</button>
	</form> -->


	<div class="card-body mt-5">
		<form action="authorization" method="post">
			<div class="center-title mb-4"
				style="flex-grow: 1; text-align: center;">
				<i class="fa-solid fa-user-plus fa-2x"></i>
				<h4 class="modal-title" id="exampleModalLabel"
					style="margin-right: 5px;">Authorization</h4>
			</div>


			<div class="form-group ntid">
				<div class="input-group d-flex">
					<div class="input-group-prepend mt-2">
						<span class="input-group-text fa-white-bg "><i
							class="fas fa-user fa-2x"></i></span>
					</div>
					<div>
						<input type="text" class="form-control input-form-text"
							name="name" placeholder="User Name" id="name"
							style="width: 150%; background-color: #EEF5FF;">
					</div>
				</div>
			</div>

			<div class="form-group passwords ">

				<div class="input-group d-flex">
					<div class="input-group-prepend mt-2">
						<span class="input-group-text fa-white-bg"><i
							class="fas fa-lock fa-2x"></i></span>
					</div>
					<div>
						<input type="password" class="form-control input-form-text"
							name="passwords" id="passwords" placeholder="Password"
							style="width: 150%; background-color: #EEF5FF;">
					</div>
				</div>
			</div>
			 
			 <div class="form-group passwords mt-3">
			    <div class="input-group d-flex">
					<div class="input-group-prepend mt-3">
						<span class="input-group-text fa-white-bg"><i
							class="fa-solid fa-briefcase fa-lg" style="color: #000000;"></i></span>
					</div>
					<div>
						<input type="text" class="form-control input-form-text"
							name="job_title" id="job_title" placeholder="Job Title"
							style="width: 150%; background-color: #EEF5FF;">
					</div>
				</div>
			</div>



						<input type="hidden" class="form-control input-form-text" name="ntid" id="ntid_input">
					
			<br>
			<div class="text-center">
				<button type="submit" class="btn text-white" onclick="generateAndShowID()"
					style="background-color: #000000;">Add</button>
			</div>
		</form>
	</div>
 <script>
    // Function to generate a random number
    function generateRandomNumber() {
        return Math.floor(Math.random() * 90000) + 10000; // Generate a 5-digit random number
    }

    // Function to generate a unique ID
    function generateUniqueID() {
        return "IPRU" + generateRandomNumber(); // Concatenate "IPRU" with the random number
    }

    // Function to generate and show the unique ID in an alert
    function generateAndShowID() {
        var uniqueID = generateUniqueID(); // Generate the unique ID
        alert("Generated Unique ID: " + uniqueID); // Show the unique ID in an alert
        document.getElementById("ntid_input").value = uniqueID; // Set the generated ID to the hidden input field
      
    }
</script>
</body>
</html>
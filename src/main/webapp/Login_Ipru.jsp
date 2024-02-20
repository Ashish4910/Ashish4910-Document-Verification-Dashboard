<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login Form</title>

<%@ include file="BootStrap/BootStrap_Link.jsp"%>

<link href="CSS/Login_page.css" rel="stylesheet">
<style>
form {
	max-width: 500px;
	margin: 0 auto;
	padding: 30px;
	border: none; /* Remove border */
	background-color: #fff;
	border-radius: 15px; /* Add curved border */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add shadow */
	text-align: center;
}

.form-control {
	border-radius: 0;
}

.form-group.ntid {
	margin-bottom: 20px; /* Added margin bottom for NT ID input */
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

.card shadow {
	background-color: #FFFFFF;
}
</style>
</head>
<body style="background-color: #EEF5FF;">

	<nav class="">
		<div class="card shadow">
			<div class="card-body mb-3 mt-2">
				<div class="container brand-image ">
					<a class="navbar-brand " href="#" style="margin-left: 0px;"> <img
						src="image/img.png" alt="ICICI Logo" class="img-responsive"
						style="width: 250px;">
					</a>
				</div>
			</div>
		</div>
	</nav>


	<br>
	<br>

	<div class="card-body">
		<form action="login" method="post">
			<div class="center-title mb-4"
				style="flex-grow: 1; text-align: center;">
				<i class="fa-solid fa-user-plus fa-2x"></i>
				<h4 class="modal-title" id="exampleModalLabel"
					style="margin-right: 5px;">Login</h4>
			</div>


			<div class="form-group ntid" style="width: 85%;">
				<div class="input-group" style="margin-left: 20px;">
					<div class="input-group-prepend">
						<span class="input-group-text fa-white-bg"><i
							class="fas fa-user"></i></span>
					</div>
					<input type="text" class="form-control input-form-text" name="ntid"
						id="ntid"
						style="height: 32px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); margin-left: 10px;">
				</div>
			</div>

			<div class="form-group" style="width: 85%;">
				<div class="input-group" style="margin-left: 20px;">
					<div class="input-group-prepend">
						<span class="input-group-text fa-white-bg"><i
							class="fas fa-lock"></i></span>
					</div>
					<input type="password" class="form-control input-form-text"
						name="passwords" id="passwords"
						style="height: 32px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); margin-left: 10px;">
				</div>
			</div>
			<br>
			<div class="text-center">
				<button type="submit" class="btn text-white"
					style="width: 25%; background-color: #000000;">Login</button>
			</div>
		</form>
	</div>


</body>
</html>


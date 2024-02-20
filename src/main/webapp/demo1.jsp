<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login Form</title>

<!-- CSS file from Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">

<link rel="stylesheet" href="CSS/test.css">
</head>
<body>

	<nav class="">
		<div class="container brand-image">
			<a class="navbar-brand " href="#"> <img src="image/img.png"
				alt="ICICI Logo" class="img-responsive">
			</a> <span class="dashboard-heading">Document Verification
				DashBoard Responsive</span>
		</div>
	</nav>

	<hr class="border border-danger border-2 opacity-100">
	<br>
	<br>

	<div class="card login-form d-flex justify-content-center shadow">
		<div class="card-body">

			<form action="login" method="post">
				<h3 class="text-center">Login</h3>
				<hr>

				<div class="form-group">
					<label for="ntid">NT ID</label> <input type="text"
						class="form-control" name="ntid" id="ntid">
				</div>

				<div class="form-group">
					<label for="passwords">Password</label> <input type="password"
						class="form-control" name="passwords" id="passwords">
				</div>
				<br> <br>
				<div class="text-center">
					<button type="submit" class="btn btn-primary ">Login</button>
				</div>

			</form>

		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
</body>
</html>

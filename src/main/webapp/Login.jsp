<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login Form</title>
<%@ include file="BootStrap/BootStrap_Link.jsp"%>
<!-- <link href="CSS/Login.css" rel="stylesheet">-->
<link href='https://fonts.googleapis.com/css?family=Mulish+SemiBold'
	rel='stylesheet'>

<style>
body {
	background-color: #EEF5FF;
	font-family: "Mulish SemiBold";
}

.card {
	--bs-card-spacer-x: none;
}

.card-brand-name {
	border-radius: 0;
}

.img-responsive {
	width: 250px;
}

.brand-image {
	margin-left: 0px;
}

.card.shadow {
	background-color: #FFFFFF;
}

.navbar-brand {
	margin-left: 0px;
}

.navbar-brand img {
	width: 250px;
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

nav {
	padding: 0;
}
</style>
</head>
<body>

	<nav class="">
		<div class="card shadow card-brand-name">
			<div class="card-body mb-3 mt-2">
				<div class="container brand-image ">
					<a class="navbar-brand " href="#"> <img src="image/img.png"
						alt="ICICI Logo" class="img-responsive">
					</a>
				</div>
			</div>
		</div>
	</nav>

	<br>
	<br>
	<div class="card-body mt-5">
		<form action="login" method="post">
			<div class="center-title mb-4"
				style="flex-grow: 1; text-align: center;">
				<i class="fa-solid fa-user-plus fa-2x"></i>
				<h4 class="modal-title" id="exampleModalLabel"
					style="margin-right: 5px;">Login</h4>
			</div>


			<div class="form-group ntid">
				<div class="input-group d-flex">
					<div class="input-group-prepend">
						<span class="input-group-text fa-white-bg"><i
							class="fas fa-user"></i></span>
					</div>
					<div>
						<input type="text" class="form-control input-form-text"
							name="ntid" placeholder="NT ID" id="ntid"
							style="width: 150%; background-color: #EEF5FF;">
					</div>
				</div>
			</div>

			<div class="form-group passwords">
				<div class="input-group d-flex">
					<div class="input-group-prepend">
						<span class="input-group-text fa-white-bg"><i
							class="fas fa-lock"></i></span>
					</div>
					<div>
						<input type="password" class="form-control input-form-text"
							name="passwords" id="passwords" placeholder="Password"
							style="width: 150%; background-color: #EEF5FF;">
					</div>
				</div>
			</div>
			<br>
			<div class="text-center">
				<button type="submit" class="btn text-white "
					style="background-color: #000000;">Login</button>
			</div>
		</form>
	</div>

</body>
</html>

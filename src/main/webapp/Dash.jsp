<%@page import="Util.Method_Util"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<title>Login Form</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Mulish+SemiBold' rel='stylesheet'>
<!-- <link rel="stylesheet" href="CSS/Dashboard.css"> -->
<script src="Javascript/Dashboard.js"></script>
<style>
body {
	background-color: #EEF5FF;
	font-family: "Mulish SemiBold";
	font-size: 16px;
}

.img-responsive {
	width: 250px;
}

.brand-image {
	margin-left: 0px;
}
.card 
{
   --bs-card-spacer-x: none;
}
.card-brand-name
{
   border-radius:0;
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
}

.nav-link {
  color: white;
}

.nav-link:hover {
  color: orange;
}

</style>
</head>
<body>

	 <nav class="">
	    <div class="card shadow card-brand-name">
	        <div class="card-body mb-3 mt-2 d-flex justify-content-between align-items-center">
	            <div class="container brand-image">
	                <a class="navbar-brand" href="#">
	                    <img src="image/img.png" alt="ICICI Logo" class="img-responsive">
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
	            
	            <div class="d-flex align-items-center">
	                <a href="#" class="text-dark mr-1">
	                    <i class="fas fa-user-circle fa-2x"></i>
	                </a>
	                <span class="text-muted mr-3"><%=UserName%>
			|<%=uemail%></span>
	                <a href="Login.jsp" class="text-dark">
	                    <i class="fas fa-sign-out-alt fa-2x" style="color: maroon;"></i>
	                </a>
	            </div>
	        
<nav class="navbar navbar-expand-lg bg-maroon" style="background-color: maroon;">
	  <div class="container-fluid">
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse justify-content-center" id="navbarNav" style="margin-right: 50px;">
	      <ul class="navbar-nav">
	        <li class="nav-item">
	          <a href="#" class="nav-link dashboard-button mx-2" onclick="buttonClicked()">Dashboard</a>
	        </li>
	        <li class="nav-item">
	          <a href="#" class="nav-link dashboard-button mx-2" onclick="button1Clicked()">Authorization</a>
	        </li>
	        <li class="nav-item">
	          <a href="#" class="nav-link dashboard-button mx-2" onclick="button2Clicked()">Access</a>
	        </li>
	      </ul>
	    </div>
	  </div>
	</nav>	        
	  <%
	} else if (ntidFromDatabase != null) {
	%>
	        
	          <div class="d-flex align-items-center">
	                <a href="#" class="text-dark mr-1">
	                    <i class="fas fa-user-circle fa-2x"></i>
	                </a>
	                <span class="text-muted mr-3"><%=ntidFromDatabase%></span>
	                <a href="Login.jsp" class="text-dark">
	                    <i class="fas fa-sign-out-alt fa-2x" style="color: maroon;"></i>
	                </a>
	            </div>
	        
	        	  <%
	} else {
	// Handle the case where uemail is null (e.g., redirect to login)
	response.sendRedirect("Login.jsp"); // Replace with the actual login page
	}
	%>
	            
	        </div>
	    </div>
	</nav>
		
	

<!-- ===================================Table========================================================-->

<div class ="container">	
  <table class="table" style="margin-top: 100px;">
    <thead>
       <tr>
            <th>Id</th>
            <th>Process</th>
            <th>Upload</th>
            <th>Download Template</th>
            <th>Submit</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>Process 1</td>
            <td class="upload-button">
                <form action="java_uploadFile" method="post" enctype="multipart/form-data">
                    <input type="hidden" id="java" name="java">
                    <button type="button" class="btn btn-danger btn-sm">
                       <!-- Update the "Upload File" label with the new class -->
                       <label class="upload-label">Upload File<input type="file" name="file" class="upload-input" onchange="uploadFile(this)"></label>
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
                <form action="python_uploadFile" method="post" enctype="multipart/form-data">
                    <button type="button" class="btn btn-danger btn-sm">
                     <label class="upload-label">Upload File<input type="file" name="file" class="upload-input" onchange="uploadFile(this)"></label>
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
           <form action="java_uploadFile" method="post" enctype="multipart/form-data">
            <button type="button" class="btn btn-danger btn-sm">
            <label class="upload-label">Upload File<input type="file" name="file" class="upload-input" onchange="uploadFile(this)"></label>
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
                 <a href="#"  class="submit-link">Submit</a>
               </button>
            </td>
        </tr>
    </tbody>
</table>

</div>
</body>
</html>

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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/21195f8523.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="CSS/Python_Show_All_Batches.css">
<script src="Javascript/Python_Report.js"></script>
</head>
<body>

<!-- ===================================Logo and Other Details========================================================-->
<nav>
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand" href="#">
            <img src="image/img.png" alt="ICICI Logo" class="logo-img">
        </a>
        <span class="dashboard-heading">Document Verification DashBoard</span>
    </div>
</nav>
<hr class="border border-danger border-2 opacity-100" style="width: 100%; margin: 0; padding: 0;"><br>

<!-- =========================================LOGOUT============================================================== -->
<%
 // Retrieve uemail from the session
 HttpSession currentsession = request.getSession();
 String uemail = (String) currentsession.getAttribute("uemail");
 // Check if uemail is not null before using it
 if (uemail != null) {
 %>
 <div class="login-container">
	    <span class="logged-in-as">Logged in as </span>
	    <div class="user-info">
	        <%= uemail %> |
	    </div>
	    <button type="button" class="btn btn-primary logout-button" onclick="logout()">
		    <i class="fa-solid fa-right-from-bracket fa-lg logout-icon"></i> Logout
		</button>

    </div>
 <%
 }
 %>
<%
 try {
 Connection con = DatabaseUtil.getConnection();
 PreparedStatement pstmt = con.prepareStatement(QueryUtil.Python_Show_All_Batches_selectQuery);
 ResultSet rs = pstmt.executeQuery();
 %>
<!-- =========================================TABLE============================================================== -->
<div class="table-container">
   <div class="table-scroll">
    <table class="table">
    <thead class="fixed-header">
         <tr>
            <th class="text">Id</th>
            <th class="text">Batches</th>
        </tr>
        </thead>
         <tbody>
        <% while (rs.next()){ %>
            <tr>
                <td class="text-center"><b><%=rs.getString("id")%></b></td>
                <td class="text-center"><b><%=rs.getString("batch_id")%></b></td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>
</div>
<%
} catch (Exception e) {
 e.printStackTrace();
 }
%>
</body>
</html>
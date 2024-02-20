<%@page import="Dao.DatabaseUtil"%>
<%@page import="Dao.QueryUtil"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Employee Search Result</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/21195f8523.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="CSS/Java_Employee_Search.css">
<script src="Javascript/Dashboard.js"></script>
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
	<p id="emailDisplay" class="button"></p>
    <%
        }
    %>
<!-- =========================================TABLE============================================================== -->

<%
    String employeeid = request.getParameter("id");
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean hasRows = false; // Flag to check if there are rows
    try {

        con = DatabaseUtil.getConnection();
        pstmt = con.prepareStatement(QueryUtil.Java_Employee_Search_selectQuery);
        pstmt.setString(1, employeeid);
        rs = pstmt.executeQuery();
%>
    <table class="table">
    <%
        while (rs.next()) {%>
        <thead>
            <tr>
                <th scope="col">Employee ID</th>
                <th scope="col">Employee Name</th>
                <th scope="col">Location</th>
                <th scope="col">EMPNO</th>
                <th scope="col">Hiredate</th>
                <th scope="col">Deptno</th>
                <th scope="col">Salary</th>
                <th scope="col">DOB</th>
                <th scope="col">Blood_Group</th>
                <th scope="col">Gender</th>
                <th scope="col">Download</th>
            </tr>
        </thead>
        <tbody>
<%
        hasRows = true; // Set the flag to true if there are rows
            String id = rs.getString("id");
            String name = rs.getString("name");
            String location = rs.getString("location");
            String empno = rs.getString("empno");
            String hiredate = rs.getString("hiredate");
            String deptno = rs.getString("deptno");
            String salary = rs.getString("salary");
            String dob = rs.getString("dob");
            String blood_group = rs.getString("blood_group");
            String gender = rs.getString("gender");
%>
            <tr>
                <td><%= id %></td>
                <td><%= name %></td>
                <td><%= location %></td>
                <td><%= empno %></td>
                <td><%= hiredate %></td>
                <td><%= deptno %></td>
                <td><%= salary %></td>
                <td><%= dob %></td>
                <td><%= blood_group %></td>
                <td><%= gender %></td>
  <td>
    <button type="button" class="btn btn-primary btn-sm">
    <a href='Java_EmployeeSearch_Download_Servlet?id=<%= rs.getString("id") %>' class="download-link">Download</a>
   </button>
 </td>
            </tr>
<%
        }
%>
        </tbody>
    </table>
<%
// Check if there are no rows
if (!hasRows) {
%>
       <script>
    alert("This Employee ID is not existing in our database.");
    window.location.href = "Report.jsp";
</script>
<%
}    } catch (Exception e) {

%>
    <h2>An error occurred:</h2>
    <p><%= e.getMessage() %></p>
<%
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
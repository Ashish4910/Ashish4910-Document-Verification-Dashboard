<%@page import="Dao.DatabaseUtil"%>
<%@page import="Python.PythonData"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="org.apache.poi.ss.usermodel.Workbook" %>
<%@ page import="org.apache.poi.ss.usermodel.WorkbookFactory" %>
<%@ page import="org.apache.poi.ss.usermodel.Sheet" %>
<%@ page import="org.apache.poi.ss.usermodel.Row" %>
<%@ page import="org.apache.poi.ss.usermodel.Cell" %>
<%@ page import="java.io.FileInputStream, java.text.NumberFormat" %>
<%@page import="java.util.Random"%>
	

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Side Navigation Bar</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/21195f8523.js" crossorigin="anonymous"></script> 
<link rel="stylesheet" href="CSS/Python_Employee_Dashboard.css">
<script src = "Javascript/Python_Employee_Dashboard.js"></script>
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
try {
    // Load the MySQL JDBC driver
    Connection con = DatabaseUtil.getConnection();
    
    List<PythonData> uploadedData_1 = (List<PythonData>) request.getSession().getAttribute("uploadedData_1");
    
    if (uploadedData_1 != null) {
        for (PythonData employee : uploadedData_1) {           
        }
    }
    
    // Display the data
%>

<div class="table-container">
    <div class="table-scroll">
        <table class="table">
            <tr>
                <th class="text">Employee ID</th>
                <th class="text">Employee Name</th>
                <th class="text">Employee Location</th>	
                <th class="text">Employee Gender</th>
            </tr>
            <%
            if (uploadedData_1 != null) {
                for (PythonData employee : uploadedData_1) {
            %>
            <tr>
                <td class="text-center"><b><%= employee.getId() %></b></td>
                <td class="text-center"><b><%= employee.getName() %></b></td>
                <td class="text-center"><b><%= employee.getLocation() %></b></td>
                <td class="text-center"><b><%= employee.getGender() %></b></td>
            </tr>
            <%
                }
            }
            %>
        </table>
    </div>
</div>
<%
    // Close the database connection
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
<%
// Code for generating the Excel download link
try {
    // Create a link to download the data as an Excel file
    String downloadLink = "download_1-data.jsp"; // Change to the appropriate URL for download
%>

<div class="button-container">
    <button type="button" class="btn btn-primary download-btn">
        <a href="<%=downloadLink %>">Download Sample File</a>
        <i class="fas fa-download"></i>
    </button>
<%
} catch (Exception e) {
    e.printStackTrace();
}
%>
   <form method="post" action="Python_Final_Save" class="form-save">
        <button type="submit" class="btn btn-primary save-btn" onclick="generateAndSetBatchId()">
            Final Save <i class="fas fa-upload"></i>
        </button>
        <input type="hidden" id="batchId" name="batchId">
    </form>
        
    
    <form method="post" action="Python_Reject_Batch" id="rejectForm" class="form-reject">
        <button type="submit" class="btn btn-danger reject-btn" onclick="confirmAndSubmit()">
            Reject Batch
        </button>
    </form>
</div>

</body>
</html>
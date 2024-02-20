<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Error</title>
</head>
<body>
<%
    // Retrieve the error message from the query parameter
    String errorMessage = request.getParameter("errorMessage");
    if (errorMessage != null && !errorMessage.isEmpty()) {
%>
    <script>
        // Display an alert with the error message
        alert('<%= errorMessage %>');
        // Redirect to a desired page (e.g., Report.jsp)
        window.location.href = "Report.jsp";
    </script>
<%
    }
%>
</body>
</html>
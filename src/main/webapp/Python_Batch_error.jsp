<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
       window.location.href="Python_Report.jsp";
    </script>
<%
    }
%>

</body>
</html>
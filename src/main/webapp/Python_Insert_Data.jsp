<%@page import="Dao.DatabaseUtil"%>
<%@page import="Dao.QueryUtil"%>
<%@page import="Python.PythonData"%>
<%@page import="Java.EmployeeData"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
try {
    Connection con = DatabaseUtil.getConnection();
    
    List<PythonData> uploadedData_1 = (List<PythonData>) request.getSession().getAttribute("uploadedData_1");
    
    if (uploadedData_1 != null) {
        for (PythonData employee : uploadedData_1) {
            PreparedStatement pstmtInsert = con.prepareStatement(QueryUtil.Python_Insert_Data_insertQuery);
            pstmtInsert.setString(1, employee.getName());
            pstmtInsert.setString(2, employee.getLocation());
            pstmtInsert.setString(3, employee.getGender());
            pstmtInsert.executeUpdate();	
            pstmtInsert.close();
            response.sendRedirect("Python_Employee_Dashboard.jsp");
        }
    }
    else{
        // Handle the case when uploadedData is null
        out.println("<script type='text/javascript'>");
        out.println("alert('No data to process. Please upload data first.');");
        out.println("window.location='Dashboard.jsp';");  // Redirect to the upload page or any other page
        out.println("</script>");
    }
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>

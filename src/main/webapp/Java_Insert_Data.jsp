<%@page import="Dao.DatabaseUtil"%>
<%@page import="Dao.QueryUtil"%>
<%@page import="Java.EmployeeData"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
Connection con = null;

try {
    con = DatabaseUtil.getConnection();
    List<EmployeeData> uploadedData = (List<EmployeeData>) request.getSession().getAttribute("uploadedData");

    if (uploadedData != null) {
        for (EmployeeData employee : uploadedData) {
            // Check if the record already exists based on some unique identifier like empno
            try (PreparedStatement pstmtSelect = con.prepareStatement(QueryUtil.Java_Insert_Data_selectQuery)) {
                pstmtSelect.setString(1, employee.getEmpno());
                ResultSet rs = pstmtSelect.executeQuery();

                if (rs.next()) {
                    // If the record exists, update it
                    try (PreparedStatement pstmtUpdate = con.prepareStatement(QueryUtil.Java_Insert_Data_updateQuery)) {
                        pstmtUpdate.setString(1, employee.getName());
                        pstmtUpdate.setString(2, employee.getLocation());
                        pstmtUpdate.setString(3, employee.getHiredate());
                        pstmtUpdate.setString(4, employee.getDeptno());
                        pstmtUpdate.setString(5, employee.getSalary());
                        pstmtUpdate.setString(6, employee.getDob());
                        pstmtUpdate.setString(7, employee.getBlood_group());
                        pstmtUpdate.setString(8, employee.getGender());
                        pstmtUpdate.setString(9, employee.getEmpno());
                        pstmtUpdate.executeUpdate();
                    }
                } else {
                    // If the record doesn't exist, insert it
                    try (PreparedStatement pstmtInsert = con.prepareStatement(QueryUtil.Java_Insert_Data_insertQuery)) {
                        pstmtInsert.setString(1, employee.getName());
                        pstmtInsert.setString(2, employee.getLocation());
                        pstmtInsert.setString(3, employee.getEmpno());
                        pstmtInsert.setString(4, employee.getHiredate());
                        pstmtInsert.setString(5, employee.getDeptno());
                        pstmtInsert.setString(6, employee.getSalary());
                        pstmtInsert.setString(7, employee.getDob());
                        pstmtInsert.setString(8, employee.getBlood_group());
                        pstmtInsert.setString(9, employee.getGender());
                        pstmtInsert.executeUpdate();
                    }
                }
            }
        }
        response.sendRedirect("Java_Employee_Dashboard.jsp");
    } else {
        // Handle the case when uploadedData is null
        out.println("<script type='text/javascript'>");
        out.println("alert('No data to process. Please upload data first.');");
        out.println("window.location='Dashboard.jsp';");  // Redirect to the upload page or any other page
        out.println("</script>");
    }
} catch (SQLException e) {
    e.printStackTrace();
} catch (Exception e) {
    e.printStackTrace();
} finally {
    DatabaseUtil.closeConnection(con);
}
%>

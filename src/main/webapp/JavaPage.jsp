<%@page import="Dao.DatabaseUtil"%>
<%@page import="Dao.QueryUtil"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="org.apache.poi.ss.usermodel.Workbook" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook" %>
<%@ page import="org.apache.poi.ss.usermodel.Sheet" %>
<%@ page import="org.apache.poi.ss.usermodel.Row" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
response.setHeader("Content-Disposition", "attachment; filename=EmployeeData.xlsx");
OutputStream outputStream = null;

try { 
	outputStream = response.getOutputStream();

try {
    Connection con = DatabaseUtil.getConnection();
    PreparedStatement pstmt = con.prepareStatement(QueryUtil.JavaPage_selectQuery);
    ResultSet rs = pstmt.executeQuery();

    // Generate Excel content using Apache POI
    Workbook workbook = new XSSFWorkbook();
    Sheet sheet = workbook.createSheet("Employee Data");
    // Create header row
    Row headerRow = sheet.createRow(0);	
    headerRow.createCell(0).setCellValue("Id");
    headerRow.createCell(1).setCellValue("Name");
    headerRow.createCell(2).setCellValue("Location");
    headerRow.createCell(3).setCellValue("Emp No");
    headerRow.createCell(4).setCellValue("Hire Date");
    headerRow.createCell(5).setCellValue("Dept No");
    headerRow.createCell(6).setCellValue("Salary");
    headerRow.createCell(7).setCellValue("Date of Birth");
    headerRow.createCell(8).setCellValue("Blood Group");
    headerRow.createCell(9).setCellValue("Gender");

    int rowNum = 1; // Start from the second row after header
    while (rs.next()) {
        Row row = sheet.createRow(rowNum++);
        row.createCell(0).setCellValue(rs.getString("id"));
        row.createCell(1).setCellValue(rs.getString("name"));
        row.createCell(2).setCellValue(rs.getString("location"));
        row.createCell(3).setCellValue(rs.getString("empno"));
        row.createCell(4).setCellValue(rs.getString("hiredate"));
        row.createCell(5).setCellValue(rs.getString("deptno"));
        row.createCell(6).setCellValue(rs.getString("salary"));
        row.createCell(7).setCellValue(rs.getString("dob"));
        row.createCell(8).setCellValue(rs.getString("blood_group"));
        row.createCell(9).setCellValue(rs.getString("gender"));
    }
    workbook.write(outputStream);
}
catch (Exception e) {
    e.printStackTrace();
} finally{
	if (outputStream != null) {
        outputStream.close();
    }
}
}catch (Exception e) {
    e.printStackTrace();
}
%>

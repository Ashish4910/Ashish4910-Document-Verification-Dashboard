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
try {
    Connection con = DatabaseUtil.getConnection();
    PreparedStatement pstmt = con.prepareStatement(QueryUtil.PythonPage_selectQuery);
    ResultSet rs = pstmt.executeQuery();

    // Generate Excel content using Apache POI
    Workbook workbook = new XSSFWorkbook();
    Sheet sheet = workbook.createSheet("Employee Data");

    // Create header row
    Row headerRow = sheet.createRow(0);	
    headerRow.createCell(0).setCellValue("Id");
    headerRow.createCell(1).setCellValue("Name");
    headerRow.createCell(2).setCellValue("Location");
    headerRow.createCell(3).setCellValue("Gender");

    int rowNum = 1; // Start from the second row after header
    while (rs.next()) {
        Row row = sheet.createRow(rowNum++);
        row.createCell(0).setCellValue(rs.getString("id"));
        row.createCell(1).setCellValue(rs.getString("name"));
        row.createCell(2).setCellValue(rs.getString("location"));
        row.createCell(3).setCellValue(rs.getString("gender"));
    }

    // Set response headers for Excel download
    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
    response.setHeader("Content-Disposition", "attachment; filename=EmployeeData.xlsx");

    // Write the Excel content to the response output stream
    try (OutputStream outputStream = response.getOutputStream()) {
        workbook.write(outputStream);
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>

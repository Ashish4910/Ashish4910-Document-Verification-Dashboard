<%@page import="Python.PythonData"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
<%@page import="org.apache.poi.ss.usermodel.Workbook" %>
<%@page import="org.apache.poi.ss.usermodel.Sheet" %>
<%@page import="org.apache.poi.ss.usermodel.Row" %>
<%@page import="org.apache.poi.ss.usermodel.Cell" %>
<%@page import="java.io.OutputStream" %>
<%@page contentType="application/vnd.ms-excel" pageEncoding="UTF-8" %>
<%@page import="Java.EmployeeData" %>
<%@page import="java.util.List" %>
<%@page import="javax.servlet.ServletOutputStream" %>
<%@page import="javax.servlet.http.HttpServletResponse" %>

<%
List<PythonData>uploadedData_1= (List<PythonData>) request.getSession().getAttribute("uploadedData_1");

Workbook workbook = new HSSFWorkbook();
Sheet sheet = workbook.createSheet("Employee Data");

Row headerRow = sheet.createRow(0);
headerRow.createCell(0).setCellValue("Employee ID");
headerRow.createCell(1).setCellValue("Employee Name");
headerRow.createCell(2).setCellValue("Employee Location");
headerRow.createCell(3).setCellValue("Employee Gender");

int rowIndex = 1;
for (PythonData employee : uploadedData_1) {
    Row dataRow = sheet.createRow(rowIndex);
    dataRow.createCell(0).setCellValue(employee.getId());
    dataRow.createCell(1).setCellValue(employee.getName());
    dataRow.createCell(2).setCellValue(employee.getLocation());
    dataRow.createCell(3).setCellValue(employee.getGender());
    rowIndex++;
}

response.setHeader("Content-disposition", "attachment; filename=employee_1_data.xls");
response.setContentType("application/vnd.ms-excel");

try (ServletOutputStream out1 = response.getOutputStream()) {
    workbook.write(out1);
}
%>

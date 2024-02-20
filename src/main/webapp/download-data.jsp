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
List<EmployeeData> uploadedData = (List<EmployeeData>) request.getSession().getAttribute("uploadedData");

Workbook workbook = new HSSFWorkbook();
Sheet sheet = workbook.createSheet("Employee Data");

Row headerRow = sheet.createRow(0);
headerRow.createCell(0).setCellValue("Employee ID");
headerRow.createCell(1).setCellValue("Employee Name");
headerRow.createCell(2).setCellValue("Employee Location");
headerRow.createCell(3).setCellValue("Employee EMPNO.");
headerRow.createCell(4).setCellValue("Employee HireDate");
headerRow.createCell(5).setCellValue("Employee DEPTNO.");
headerRow.createCell(6).setCellValue("Employee Salary");
headerRow.createCell(7).setCellValue("Employee DOB");
headerRow.createCell(8).setCellValue("Employee Blood Group");
headerRow.createCell(9).setCellValue("Employee Gender");

int rowIndex = 1;
for (EmployeeData employee : uploadedData) {
    Row dataRow = sheet.createRow(rowIndex);
    dataRow.createCell(0).setCellValue(employee.getId());
    dataRow.createCell(1).setCellValue(employee.getName());
    dataRow.createCell(2).setCellValue(employee.getLocation());
    dataRow.createCell(3).setCellValue(employee.getEmpno());
    dataRow.createCell(4).setCellValue(employee.getHiredate());   
    dataRow.createCell(5).setCellValue(employee.getDeptno());
    dataRow.createCell(6).setCellValue(employee.getSalary());
    dataRow.createCell(7).setCellValue(employee.getDob());
    dataRow.createCell(8).setCellValue(employee.getBlood_group());
    dataRow.createCell(9).setCellValue(employee.getGender());
    rowIndex++;
}

response.setHeader("Content-disposition", "attachment; filename=employee_data.xls");
response.setContentType("application/vnd.ms-excel");

try (ServletOutputStream out1 = response.getOutputStream()) {
    workbook.write(out1);
}
%>

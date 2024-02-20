<%@page import="Dao.QueryUtil"%>
<%@page import="Dao.DatabaseUtil"%>
<%@ page import="org.apache.poi.ss.usermodel.*" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"%>
<%@ page language="java"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page buffer="16kb"%>
<%
try {
    // Get the file name from the file path
    String fileName = "python.xlsx";
    session.setAttribute("fileName", fileName);

    // 1. Create sample Excel data with headers only
    Workbook workbook = new XSSFWorkbook();
    Sheet sheet = workbook.createSheet("Sheet2");

    // Create column headers
    Row headerRow = sheet.createRow(0);
    String[] headers = {"Id", "Name", "Location", "Gender"};
    for (int i = 0; i < headers.length; i++) {
        Cell cell = headerRow.createCell(i);
        cell.setCellValue(headers[i]);
    }

    // 2. Convert the Excel Data to Bytes
    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
    try {
        workbook.write(byteArrayOutputStream);
    } catch (IOException e) {
        e.printStackTrace();
    }
    byte[] excelBytes = byteArrayOutputStream.toByteArray();

    // 3. Store the Byte Array in the Database using JDBC
    try (Connection connection = DatabaseUtil.getConnection()) {
        PreparedStatement preparedStatement = connection.prepareStatement(QueryUtil.Python_Download_Insert);
        preparedStatement.setBytes(1, excelBytes);
        preparedStatement.executeUpdate();
    }

    // 4. Retrieve and Use the Data from the Database using JDBC
    try (Connection connection = DatabaseUtil.getConnection()) {
        int fileId = 1; // Replace with the actual file ID you want to retrieve

        PreparedStatement preparedStatement = connection.prepareStatement(QueryUtil.Python_Download_Select);
        preparedStatement.setInt(1, fileId);

        try (ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                byte[] retrievedExcelBytes = resultSet.getBytes("file_data");

                // 5. Set response headers for file download
                response.setHeader("Content-Disposition", "attachment; filename=python.xlsx");

                // Write the Excel data to the response output stream
                try (OutputStream outputStream = response.getOutputStream()) {
                    outputStream.write(retrievedExcelBytes);
                }
            }
        }
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>

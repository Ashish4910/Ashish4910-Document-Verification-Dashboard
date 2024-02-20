package Python;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import Dao.DatabaseUtil;
import Dao.QueryUtil;

@WebServlet("/Python_EmployeeSearch_Download_Servlet")
public class Python_Employee_Search_Download extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id = request.getParameter("id");
        
        try {
            Connection con = DatabaseUtil.getConnection();
            PreparedStatement pstmt = con.prepareStatement(QueryUtil.Python_Employee_Search_Download_Select_python);
            pstmt.setString(1, id);
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
            String Emp_ID = ""; // Variable to store empno
            
            while (rs.next()) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(rs.getString("id"));
                row.createCell(1).setCellValue(rs.getString("name"));
                row.createCell(2).setCellValue(rs.getString("location"));
                row.createCell(3).setCellValue(rs.getString("gender"));
                
                Emp_ID  = rs.getString("id"); // Store the empno for filename
            }

            // Set response headers for Excel download
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=EmployeeData_" + Emp_ID + ".xlsx");

            // Write the Excel content to the response output stream
            try (OutputStream outputStream = response.getOutputStream()) {
                workbook.write(outputStream);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
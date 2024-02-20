package Python;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
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
import Util.Method_Util;

@WebServlet("/python_search_batch_id_download")
public class Python_Search_Batch_Id_Download extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=EmployeeData.xlsx");

		try (OutputStream outputStream = response.getOutputStream()) {
			String batchId = request.getParameter("batchId");

			try {
				Connection sourceConn = DatabaseUtil.getConnection();
				PreparedStatement selectStmt = sourceConn
						.prepareStatement(QueryUtil.Python_Search_Batch_Id_Download_selectQuery);
				selectStmt.setString(1, batchId);

				ResultSet rs = selectStmt.executeQuery();

				boolean batchIdExists = Method_Util.python_checkIfBatchIdExists(sourceConn,
						QueryUtil.Python_Search_Batch_Id_Download_selectQuery, batchId);

				if (!batchIdExists) {
					// Assuming you want to pass an error message as a parameter
					String errorMessage = "No data found for the provided batch ID: " + batchId;

					// Redirect to the JSP page with the error message
					response.sendRedirect("Python_Batch_error.jsp?errorMessage=" + errorMessage);

				} else {
					Workbook workbook = new XSSFWorkbook();
					Sheet sheet = workbook.createSheet("Employee Data");
					Row headerRow = sheet.createRow(0);
					headerRow.createCell(0).setCellValue("Id");
					headerRow.createCell(1).setCellValue("Name");
					headerRow.createCell(2).setCellValue("Location");
					headerRow.createCell(3).setCellValue("Gender");

					int rowNum = 1;
					while (rs.next()) {
						Row row = sheet.createRow(rowNum++);
						row.createCell(0).setCellValue(rs.getString("id"));
						row.createCell(1).setCellValue(rs.getString("name"));
						row.createCell(2).setCellValue(rs.getString("location"));
						row.createCell(3).setCellValue(rs.getString("gender"));
					}
					workbook.write(outputStream);
					sourceConn.close();
				}
			} catch (Exception e) {
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				e.printStackTrace();
			}
		}
	}

}
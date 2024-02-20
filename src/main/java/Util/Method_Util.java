package Util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import Dao.QueryUtil;
import Java.EmployeeData;
import Python.PythonData;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import Dao.DatabaseUtil;

public class Method_Util {

//============================================LoginServlet===================================================================

	public static boolean isValidUser(String uemail, String upwd) {
		return ("IPRU11111".equals(uemail) && "Vinayak@123".equals(upwd))
				|| ("IPRU22222".equals(uemail) && "Sumit@123".equals(upwd))
				|| ("IPRU33333".equals(uemail) && "Ashish@123".equals(upwd));
	}

	public static String getUserNameForDashboard(String email) {
		String UserName = "";
		try {
			Connection conn = DatabaseUtil.getConnection();
			PreparedStatement psmt = conn.prepareStatement(QueryUtil.Dashboard_getUserNameForDashboard);
			psmt.setString(1, email);

			ResultSet rs = psmt.executeQuery();
			if (rs.next()) {
				UserName = rs.getString(4);

				return UserName;
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return UserName;

	}

	public static boolean isDuplicateEntry(Connection con, String email) {
		try {
			PreparedStatement pstmt = con.prepareStatement(QueryUtil.Method_Util_CHECK_DUPLICATE_USER_QUERY);
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				int count = rs.getInt(1);
				return count > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public static void showErrorMessage(HttpServletResponse response, String message, String redirectPage)
			throws IOException {
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('" + message + "');");
		out.println("window.location='" + redirectPage + "';");
		out.println("</script>");
	}

	public static void showSuccessMessage(HttpServletResponse response, String message, String redirectPage)
			throws IOException {
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('" + message + "');");
		out.println("window.location='" + redirectPage + "';");
		out.println("</script>");
	}

	public static void executeUpdateQuery(Connection con, String query, String... parameters) {
		PreparedStatement pstmt = null;
		try {
			pstmt = con.prepareStatement(query);
			for (int i = 0; i < parameters.length; i++) {
				pstmt.setString(i + 1, parameters[i]);
			}
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
//=============================================Java_Upload_File===============================================================

	public static String getFileName(final Part part) {
		final String partHeader = part.getHeader("content-disposition");
		for (String content : partHeader.split(";")) {
			if (content.trim().startsWith("filename")) {
				return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
			}
		}
		return null;
	}

	public static List<EmployeeData> processXlsx(String filePath) {
		List<EmployeeData> uploadedData = new ArrayList<>();
		try (FileInputStream fis = new FileInputStream(filePath); Workbook workbook = WorkbookFactory.create(fis)) {
			Sheet sheet = workbook.getSheetAt(0);

			for (Row row : sheet) {
				if (row.getRowNum() == 0) {
					continue; // Skip header row
				}

				EmployeeData employee = createEmployeeFromRow(row);
				uploadedData.add(employee);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return uploadedData;
	}

	private static EmployeeData createEmployeeFromRow(Row row) {
		String id = getStringValueFromCell(row.getCell(0));
		String name = getStringValueFromCell(row.getCell(1));
		String location = getStringValueFromCell(row.getCell(2));
		String empno = getStringValueFromCell(row.getCell(3));
		String hiredate = getFormattedDate(row.getCell(4));
		String deptno = getStringValueFromCell(row.getCell(5));
		String salary = getStringValueFromCell(row.getCell(6));
		String dob = getFormattedDate(row.getCell(7));
		String blood_group = getStringValueFromCell(row.getCell(8));
		String gender = getStringValueFromCell(row.getCell(9));

		EmployeeData employee = new EmployeeData();
		employee.setId(id);
		employee.setName(name);
		employee.setLocation(location);
		employee.setEmpno(empno);
		employee.setHiredate(hiredate);
		employee.setDeptno(deptno);
		employee.setSalary(salary);
		employee.setDob(dob);
		employee.setBlood_group(blood_group);
		employee.setGender(gender);

		return employee;
	}

	private static String getStringValueFromCell(Cell cell) {
		if (cell == null) {
			return "";
		}
		if (cell.getCellType() == CellType.STRING) {
			return cell.getStringCellValue();
		} else if (cell.getCellType() == CellType.NUMERIC) {
			return String.valueOf((long) cell.getNumericCellValue());
		}
		return "";
	}

	private static String getFormattedDate(Cell cell) {
		if (cell == null) {
			return "";
		}
		if (cell.getCellType() == CellType.NUMERIC) {
			Date date = cell.getDateCellValue();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			return sdf.format(date);
		}
		return "";
	}

//=============================================Python_Upload_File===============================================================

	public static String getFileNames(final Part part) {
		final String partHeader = part.getHeader("content-disposition");
		for (String content : partHeader.split(";")) {
			if (content.trim().startsWith("filename")) {
				return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
			}
		}
		return null;
	}

	public static List<PythonData> processXlsxs(String filePath) {
		List<PythonData> uploadedData_1 = new ArrayList<>();
		try (FileInputStream fis = new FileInputStream(filePath); Workbook workbook = WorkbookFactory.create(fis)) {
			Sheet sheet = workbook.getSheetAt(0);

			for (Row row : sheet) {
				if (row.getRowNum() == 0) {
					continue; // Skip header row
				}

				PythonData pythonData = createPythonDataFromRow(row);
				uploadedData_1.add(pythonData);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return uploadedData_1;
	}

	private static PythonData createPythonDataFromRow(Row row) {
		String id = getStringValueFromCell1(row.getCell(0));
		String name = getStringValueFromCell1(row.getCell(1));
		String location = getStringValueFromCell1(row.getCell(2));
		String gender = getStringValueFromCell1(row.getCell(3));

		PythonData pythonData = new PythonData();
		pythonData.setId(id);
		pythonData.setName(name);
		pythonData.setLocation(location);
		pythonData.setGender(gender);

		return pythonData;
	}

	private static String getStringValueFromCell1(Cell cell) {
		if (cell == null) {
			return "";
		}
		if (cell.getCellType() == CellType.STRING) {
			return cell.getStringCellValue();
		} else if (cell.getCellType() == CellType.NUMERIC) {
			return String.valueOf((long) cell.getNumericCellValue());
		}
		return "";
	}

//=============================================Java_ExcelDownloadServlet===============================================================

	public static void handleLanguageSearch(String searchLanguage, HttpServletResponse response) throws IOException {
		if ("Java".equalsIgnoreCase(searchLanguage)) {
			redirectToPage("JavaPage.jsp", response);
		} else if ("Python".equalsIgnoreCase(searchLanguage)) {
			redirectToPage("PythonPage.jsp", response);
		} else {
			redirectToPage("Not_Search_Java.jsp", response);
		}
	}

	private static void redirectToPage(String page, HttpServletResponse response) throws IOException {
		response.sendRedirect(page);
	}

// ===============================Python_Search_Batch_Id_Download=============================================================
	public static boolean python_checkIfBatchIdExists(Connection connection, String query, String batchId)
			throws Exception {
		try (PreparedStatement selectStmt = connection.prepareStatement(query)) {
			selectStmt.setString(1, batchId);
			try (ResultSet rs = selectStmt.executeQuery()) {
				return rs.next();
			}
		}
	}

// ====================Java_Search_Batch_Id_Download==========================================================================
	public static boolean java_checkIfBatchIdExists(Connection connection, String query, String batchId)
			throws Exception {
		try (PreparedStatement selectStmt = connection.prepareStatement(query)) {
			selectStmt.setString(1, batchId);
			try (ResultSet rs = selectStmt.executeQuery()) {
				return rs.next();
			}
		}
	}

}
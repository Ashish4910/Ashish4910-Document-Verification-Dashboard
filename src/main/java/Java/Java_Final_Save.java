package Java;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Dao.DatabaseUtil;
import Dao.QueryUtil;

@WebServlet("/Java_Final_Save")
public class Java_Final_Save extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String batchId = request.getParameter("batchId");
        HttpSession session = request.getSession();
        session.setAttribute("batchId", batchId);

        try (
            Connection sourceConn = DatabaseUtil.getConnection();
            Connection targetConn = DatabaseUtil.getConnection();
            PreparedStatement selectStmt = sourceConn.prepareStatement(QueryUtil.Java_Final_Save_selectQuery);
            ResultSet rs = selectStmt.executeQuery();
        ) {
            while (rs.next()) {
                String id = rs.getString("id");

                // Check if the record with the same ID already exists in the target database
                try (PreparedStatement checkDuplicateStmt = targetConn.prepareStatement(QueryUtil.Java_Final_Save_checkDuplicateQuery)) {
                    checkDuplicateStmt.setString(1, id);
                    ResultSet duplicateRs = checkDuplicateStmt.executeQuery();
                    duplicateRs.next();
                    int duplicateCount = duplicateRs.getInt(1);
                    duplicateRs.close();

                    if (duplicateCount == 0) {
                        // Get values from the source record
                        String name = rs.getString("name");
                        String location = rs.getString("location");
                        String empno = rs.getString("empno");
                        String hiredate = rs.getString("hiredate");
                        String deptno = rs.getString("deptno");
                        String salary = rs.getString("salary");
                        String dob = rs.getString("dob");
                        String bloodGroup = rs.getString("blood_group");
                        String gender = rs.getString("gender");

                        // Set values for the target insert statement
                        try (PreparedStatement insertStmt = targetConn.prepareStatement(QueryUtil.Java_Final_Save_insertQuery)) {
                            insertStmt.setString(1, name);
                            insertStmt.setString(2, location);
                            insertStmt.setString(3, empno);
                            insertStmt.setString(4, hiredate);
                            insertStmt.setString(5, deptno);
                            insertStmt.setString(6, salary);
                            insertStmt.setString(7, dob);
                            insertStmt.setString(8, bloodGroup);
                            insertStmt.setString(9, gender);
                            insertStmt.setString(10, batchId);
                            insertStmt.executeUpdate();
                        }
                    }
                  else {
                        // Get values from the source record
                        String name = rs.getString("name");
                        String location = rs.getString("location");
                        String empno = rs.getString("empno");
                        String hiredate = rs.getString("hiredate");
                        String deptno = rs.getString("deptno");
                        String salary = rs.getString("salary");
                        String dob = rs.getString("dob");
                        String bloodGroup = rs.getString("blood_group");
                        String gender = rs.getString("gender");

                        // Update values for the existing target record
                        try (PreparedStatement updateStmt = targetConn.prepareStatement(QueryUtil.Java_Final_Save_updateQuery)) {
                            updateStmt.setString(1, name);
                            updateStmt.setString(2, location);
                            updateStmt.setString(3, empno);
                            updateStmt.setString(4, hiredate);
                            updateStmt.setString(5, deptno);
                            updateStmt.setString(6, salary);
                            updateStmt.setString(7, dob);
                            updateStmt.setString(8, bloodGroup);
                            updateStmt.setString(9, gender);
                            updateStmt.setString(10, id);
                            updateStmt.executeUpdate();
                        }
                    }
                }
            }
            System.out.println("New records processed successfully...");
            System.out.println("Batch ID: " + batchId);
         // Generating the HTML form
            String excelServletURL = request.getContextPath() + "/Java_Batch_Id"; // Set the correct URL for the Excel servlet
            response.sendRedirect(excelServletURL);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
package Python;

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

@WebServlet("/Python_Final_Save")
public class Python_Final_Save extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sourceDbUrl = "jdbc:sqlserver://DESKTOP-97K28FP;databaseName=ems;encrypt=false;user=root;password=dvd@123";
        String targetDbUrl = "jdbc:sqlserver://DESKTOP-97K28FP;databaseName=ems;encrypt=false;user=root;password=dvd@123";

        
        String batchId = request.getParameter("batchId");
        HttpSession session = request.getSession();
        session.setAttribute("batchId", batchId);

        try (
            Connection sourceConn = DatabaseUtil.getConnection();
            Connection targetConn = DatabaseUtil.getConnection();
            PreparedStatement selectStmt = sourceConn.prepareStatement(QueryUtil.Python_Final_Save_selectQuery);
            ResultSet rs = selectStmt.executeQuery();
        ) {
            while (rs.next()) {
                String id = rs.getString("id");

                // Check if the record with the same ID already exists in the target database
                try (PreparedStatement checkDuplicateStmt = targetConn.prepareStatement(QueryUtil.Python_Final_Save_checkDuplicateQuery)) {
                    checkDuplicateStmt.setString(1, id);
                    ResultSet duplicateRs = checkDuplicateStmt.executeQuery();
                    duplicateRs.next();
                    int duplicateCount = duplicateRs.getInt(1);
                    duplicateRs.close();

                    if (duplicateCount == 0) {
                        // Get values from the source record
                        String name = rs.getString("name");
                        String location = rs.getString("location");
                        String gender = rs.getString("gender");

                        // Set values for the target insert statement
                        try (PreparedStatement insertStmt = targetConn.prepareStatement(QueryUtil.Python_Final_Save_insertQuery)) {
                            insertStmt.setString(1, name);
                            insertStmt.setString(2, location);
                            insertStmt.setString(3, gender);
                            insertStmt.setString(4, batchId);
                            insertStmt.executeUpdate();
                        }
                    }
                    else {
                        // Get values from the source record
                        String name = rs.getString("name");
                        String location = rs.getString("location");
                        String gender = rs.getString("gender");

                        // Update values for the existing target record
                        try (PreparedStatement updateStmt = targetConn.prepareStatement(QueryUtil.Python_Final_Save_updateQuery)) {
                            updateStmt.setString(1, name);
                            updateStmt.setString(2, location);
                            updateStmt.setString(3, gender);
                            updateStmt.setString(4, id);
                            updateStmt.executeUpdate();
                        }
                    }
                }
            } 
            System.out.println("New records processed successfully...");
            System.out.println("Batch ID: " + batchId);
         // Generating the HTML form
            String excelServletURL = request.getContextPath() + "/Python_Batch_Id"; // Set the correct URL for the Excel servlet
            response.sendRedirect(excelServletURL);


        } catch (Exception e) {
            // Handle the exception gracefully.
            e.printStackTrace();
            // You can also set an error message for the user or log the error.
        }
		   }
}
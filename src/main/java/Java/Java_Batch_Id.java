package Java;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.DatabaseUtil;
import Dao.QueryUtil;

@WebServlet("/Java_Batch_Id")
public class Java_Batch_Id extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Set<String> existingBatchIds = new HashSet<>(); // Keep track of existing batch IDs

        try (
            Connection sourceConn = DatabaseUtil.getConnection();
            Connection targetConn =DatabaseUtil.getConnection();
            PreparedStatement selectStmt = sourceConn.prepareStatement(QueryUtil.Java_Batch_Id_selectQuery);
            ResultSet rs = selectStmt.executeQuery();
            PreparedStatement insertStmt = targetConn.prepareStatement(QueryUtil.Java_Batch_Id_insertQuery);
        ) {
            // Retrieve existing batch IDs from the target table
            try (
                PreparedStatement existingBatchIdsStmt = targetConn.prepareStatement(QueryUtil.Java_Batch_Id_existingBatchIdsQuery);
                ResultSet existingBatchIdsRs = existingBatchIdsStmt.executeQuery();
            ) {
                while (existingBatchIdsRs.next()) {
                    existingBatchIds.add(existingBatchIdsRs.getString("batch_id"));
                }
            }

            while (rs.next()) {
                String batch = rs.getString("batch_id");

                // Only insert unique batch IDs into the target table
                if (!existingBatchIds.contains(batch)) {
                    insertStmt.setString(1, batch);
                    insertStmt.executeUpdate();
                    existingBatchIds.add(batch); // Add to the set of existing batch IDs
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
           
        }

        response.sendRedirect("Report.jsp");
    }
}

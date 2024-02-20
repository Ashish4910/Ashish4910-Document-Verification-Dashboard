package com_upload;

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

import Dao.DatabaseUtil;
import Dao.QueryUtil;

@WebServlet("/grantrecord")
public class GrantRecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("id");
        String grantAction = request.getParameter("action");

           
        try (Connection conn =DatabaseUtil.getConnection()) {
            if ("grant".equals(grantAction)) {
                // Check if a record already exists for the user ID
                
                try (PreparedStatement checkExistencePstmt = conn.prepareStatement(QueryUtil.GrantRecordServlet_SELECT_COUNT)) {
                    checkExistencePstmt.setString(1, userId);
                    try (ResultSet resultSet = checkExistencePstmt.executeQuery()) {
                        resultSet.next();
                        int rowCount = resultSet.getInt(1);

                        if (rowCount > 0) {
                            // Update existing record by setting "user_accesscol" to true
                            try (PreparedStatement updatePstmt = conn.prepareStatement(QueryUtil.GrantRecordServlet_Update_user_access1)) {
                                updatePstmt.setString(1, userId);
                                updatePstmt.executeUpdate();
                                System.out.println("Hello");
                            }
                        } else {
                            // Insert new record with "user_accesscol" set to true
                            
                            try (PreparedStatement insertPstmt = conn.prepareStatement(QueryUtil.GrantRecordServlet_Insert_user_access)) {
                                insertPstmt.setString(1, userId);
                                insertPstmt.executeUpdate();
                                System.out.println("Bye");
                            }
                        }
                    }
                }
            } else if ("revoke".equals(grantAction)) {
                // Revoke access by updating the "user_accesscol" column to false
                try (PreparedStatement updatePstmt = conn.prepareStatement(QueryUtil.GrantRecordServlet_Update_user_access2)) {
                    updatePstmt.setString(1, userId);
                    updatePstmt.executeUpdate();
                }
            }

            // Optionally, you may want to perform additional actions or redirect the user.
            response.sendRedirect("UserAccessView.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error updating access. Please check logs for details.");
        }
    }
}
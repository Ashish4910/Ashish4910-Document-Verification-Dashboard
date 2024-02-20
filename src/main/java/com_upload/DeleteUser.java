package com_upload;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dao.DatabaseUtil;
import Dao.QueryUtil;

@WebServlet("/DeleteRecord")
public class DeleteUser extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userId = request.getParameter("id");
        int userIdInt = Integer.parseInt(userId);

       
        try {

            try (Connection con = DatabaseUtil.getConnection();) {
                // Delete from user table
                try (PreparedStatement pstmtUser = con.prepareStatement(QueryUtil.DeleteUser_Delete_USER_QUERY)) {
                    pstmtUser.setInt(1, userIdInt);
                    pstmtUser.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                // Delete from user_access table
                try (PreparedStatement pstmtUserAccess = con.prepareStatement(QueryUtil.DeleteUser_Delete_USERACCESS_QUERY)) {
                    pstmtUserAccess.setInt(1, userIdInt);
                    pstmtUserAccess.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            response.sendRedirect("UserAccessView.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

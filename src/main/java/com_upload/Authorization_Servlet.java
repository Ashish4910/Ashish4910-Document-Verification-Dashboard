package com_upload;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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

@WebServlet("/authorization")
public class Authorization_Servlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String ntid = request.getParameter("ntid");
        String passwords = request.getParameter("passwords");
        String jobTitle = request.getParameter("job_title");

        Connection conn = null;
        PreparedStatement selectPstmt = null;
        PreparedStatement insertUserPstmt = null;
        PreparedStatement insertUserAccessPstmt = null;
        ResultSet resultSet = null; // Declare resultSet here to ensure it is accessible in the finally block

        try {
            // Get a connection from the DatabaseUtil class
            conn = DatabaseUtil.getConnection();

            // Check if the email ID already exists
            selectPstmt = conn.prepareStatement(QueryUtil.Authorization_Servlet_SELECT_USER_QUERY);
            selectPstmt.setString(1, ntid);
            resultSet = selectPstmt.executeQuery();

            if (resultSet.next() || "morevinayak1998@gmail.com".equals(ntid)
                    || "sumit123@gmail.com".equals(ntid) || "ashish2001@gmail.com".equals(ntid)) {
                // Email ID already exists
                out.print("<script>alert('Authorization Failed! Duplicate email ID.'); window.location.href='UserAccess.jsp';</script>");
            } else {
                // Email ID does not exist, proceed with the insertion into ems.user
                insertUserPstmt = conn.prepareStatement(QueryUtil.Authorization_Servlet_Insert_USER_QUERY);
                insertUserPstmt.setString(1, ntid);
                insertUserPstmt.setString(2, passwords);
                insertUserPstmt.setString(3, jobTitle);

                // Execute the insert query for ems.user
                int resultUser = insertUserPstmt.executeUpdate();

                if (resultUser > 0) {
                    // Insert into user_access table
                    insertUserAccessPstmt = conn.prepareStatement(QueryUtil.Authorization_Servlet_Insert_USERACCESS_QUERY);
                    insertUserAccessPstmt.setString(1, ntid);
                    insertUserAccessPstmt.setString(2, passwords);
                    insertUserAccessPstmt.setString(3, jobTitle);

                    // Execute the insert query for user_access
                    int resultUserAccess = insertUserAccessPstmt.executeUpdate();

                    if (resultUserAccess > 0) {
                        // Authorization Successful
                        out.print("<script>alert('Authorization Successful, New User is added from Admin!'); window.location.href='UserAccess.jsp';</script>");
                    } else {
                        // Authorization Failed
                        out.print("<script>alert('Authorization Failed! Please check logs for details.'); window.location.href='UserAccess.jsp';</script>");
                    }
                } else {
                    // Authorization Failed
                    out.print("<script>alert('Authorization Failed! Please check logs for details.'); window.location.href='UserAccess.jsp';</script>");
                }
            }
        } catch (SQLException e) {
            // Handle SQL exceptions (e.g., log or display an error message)
            e.printStackTrace();
            out.print("<script>alert('Authorization Failed! Please check logs for details.'); window.location.href='UserAccess.jsp';</script>");
        } catch (Exception e) {
            // Handle other exceptions
            e.printStackTrace();
            out.print("<script>alert('Authorization Failed! Please check logs for details.'); window.location.href='UserAccess.jsp';</script>");
        } finally {
            // Close resources in the finally block
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (selectPstmt != null) {
                    selectPstmt.close();
                }
                if (insertUserPstmt != null) {
                    insertUserPstmt.close();
                }
                if (insertUserAccessPstmt != null) {
                    insertUserAccessPstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
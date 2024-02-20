package com_upload;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Dao.DatabaseUtil;
import Dao.QueryUtil;
import Util.Method_Util;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uemail = request.getParameter("ntid");
		String upwd = request.getParameter("passwords");

		HttpSession session = request.getSession();
		if (uemail.isEmpty() || upwd.isEmpty()) {
			Method_Util.showErrorMessage(response, "Login failed. Please check your email and password.", "Login.jsp");
			return;
		}

		Connection con = null;
		try {
			con = DatabaseUtil.getConnection();

			PreparedStatement pstmt1 = con.prepareStatement(QueryUtil.LoginServlet_SELECT_USER_ACCESS_QUERY);
			pstmt1.setString(1, uemail);
			ResultSet rs = pstmt1.executeQuery();

			if (rs.next()) {
				String ntidFromDatabase = rs.getString("ntid");
				session.setAttribute("ntidFromDatabase", ntidFromDatabase);
				response.sendRedirect("Dashboard.jsp");
			}

			if (Method_Util.isValidUser(uemail, upwd)) {

				if (Method_Util.isDuplicateEntry(con, uemail)) {
					session.setAttribute("uemail", uemail);
					Method_Util.showSuccessMessage(response, "Login successful. Welcome! ", "Dashboard.jsp");
				} else {
					session.setAttribute("uemail", uemail);
					Method_Util.executeUpdateQuery(con, QueryUtil.LoginServlet_INSERT_USER_QUERY, uemail, upwd);

					Method_Util.showSuccessMessage(response, "Login successful. Welcome! ", "Dashboard.jsp");
				}
			} else {
				Method_Util.showErrorMessage(response, "Login failed. Please check your email and password.",
						"Login.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DatabaseUtil.closeConnection(con);
		}
	}
}

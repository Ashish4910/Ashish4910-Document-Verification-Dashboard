package com_upload;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Util.Method_Util;

@WebServlet("/LanguageSearchServlet")
public class Java_ExcelDownloadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchLanguage = request.getParameter("language");

        // Here you can perform your desired action based on the searchLanguage value
        // For example, you can forward to a specific page or perform database queries.
        Method_Util.handleLanguageSearch(searchLanguage, response);
    }
}

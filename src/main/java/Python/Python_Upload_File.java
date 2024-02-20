package Python;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import Util.Method_Util;

@WebServlet("/python_uploadFile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class Python_Upload_File extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String python = request.getParameter("python");
        HttpSession session = request.getSession();
        session.setAttribute("python", python);

        String downloadedFileName = "python.xlsx"; // This should be the name of your expected Excel file.
        Part filePart = request.getPart("file");
        String fileName = Method_Util.getFileNames(filePart);

        if (downloadedFileName.equals(fileName)) {
            String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;

            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String filePath = uploadPath + File.separator + uniqueFileName;
            filePart.write(filePath);

            List<PythonData> uploadedData_1 = Method_Util.processXlsxs(filePath);
            session.setAttribute("uploadedData_1", uploadedData_1);

            request.getRequestDispatcher("Dashboard.jsp").forward(request, response);
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("/Dashboard.jsp");
            rd.include(request, response);
            response.setContentType("text/html");
            response.getWriter().println("<script>alert('Please upload the correct Excel file');</script>");
        }
    }
}

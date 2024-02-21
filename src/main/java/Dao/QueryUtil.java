package Dao;

public class QueryUtil {
	
    //LoginServlet
	public static final String LoginServlet_INSERT_USER_QUERY = "INSERT INTO login (uemail, upwd) VALUES (?, ?)";
    public static final String LoginServlet_SELECT_USER_ACCESS_QUERY = "SELECT * FROM user_access WHERE ntid = ? AND user_accesscol = 1 AND password = ?";
    public static final String Method_Util_CHECK_DUPLICATE_USER_QUERY = "SELECT COUNT(*) FROM login WHERE uemail = ?";

 // Dashboard.jsp
    public static final String Dashboard_getUserNameForDashboard = "Select * from login where uemail=?";
    
    // Java-Download
    public static final String Java_Download_Insert = "INSERT INTO java_download (file_data) VALUES (?)";
    public static final String Java_Download_Select = "SELECT file_data FROM java_download WHERE id = ?";

    // Python-Download
    public static final String Python_Download_Insert = "INSERT INTO python_download (file_data) VALUES (?)";
    public static final String Python_Download_Select = "SELECT file_data FROM python_download WHERE id = ?";

    // Authorization_Servlet
    public static final String Authorization_Servlet_SELECT_USER_QUERY = "SELECT ntid FROM [user] WHERE ntid = ?";
    public static final String Authorization_Servlet_Insert_USER_QUERY = "INSERT INTO [user] (name, password, job_title,ntid) VALUES (?, ?, ?,?)";
    public static final String Authorization_Servlet_Insert_USERACCESS_QUERY = "INSERT INTO user_access (name, password, job_title, user_accesscol,ntid) VALUES (?, ?, ?, 0,?)";

    // DeleteUser
    public static final String DeleteUser_Delete_USER_QUERY = "DELETE FROM [user] WHERE id = ?";
    public static final String DeleteUser_Delete_USERACCESS_QUERY = "DELETE FROM user_access WHERE id = ?";

    // GrantRecordServlet
    public static final String GrantRecordServlet_SELECT_COUNT = "SELECT COUNT(*) FROM user_access WHERE id = ?";
	public static final String GrantRecordServlet_Update_user_access1 = "UPDATE user_access SET user_accesscol = 1 WHERE id = ?";
	public static final String GrantRecordServlet_Insert_user_access = "INSERT INTO user_access (id, ntid, password, job_title,name,user_accesscol)"+ "SELECT id, ntid, password, job_title,name, 1 FROM ems.user WHERE id = ?";
	public static final String GrantRecordServlet_Update_user_access2 = "UPDATE user_access SET user_accesscol = 0 WHERE id = ?";

    // Java_Insert_Data
    public static final String Java_Insert_Data_selectQuery = "SELECT * FROM dummy_1 WHERE empno = ?";
    public static final String Java_Insert_Data_updateQuery = "UPDATE dummy_1 SET name = ?, location = ?, hiredate = ?, deptno = ?, salary = ?, dob = ?, blood_group = ?, gender = ? WHERE empno = ?";
    public static final String Java_Insert_Data_insertQuery = "INSERT INTO dummy_1 (name, location, empno, hiredate, deptno, salary, dob, blood_group, gender) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

 // Python_Insert_Data
    public static final String Python_Insert_Data_insertQuery = "INSERT INTO dummy_2 (name, location, gender) VALUES (?, ?, ?)";
    
 // Java_Batch_Id
 	public static final String Java_Batch_Id_selectQuery = "SELECT DISTINCT batch_id FROM java";
 	public static final String Java_Batch_Id_insertQuery = "INSERT INTO batch_id (batch_id) VALUES (?)";
 	public static final String Java_Batch_Id_existingBatchIdsQuery = "SELECT batch_id FROM batch_id";

 	// Java_Employee_Search_Download
 	public static final String Java_Employee_Search_Download_Select_Query = "SELECT * FROM java WHERE id = ?";

 	// Java_Final_Save
 	public static final String Java_Final_Save_selectQuery = "SELECT * FROM dummy_1";
 	public static final String Java_Final_Save_insertQuery = "INSERT INTO java (name, location, empno, hiredate, deptno, salary, dob, blood_group, gender, batch_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
 	public static final String Java_Final_Save_updateQuery = "UPDATE java SET name = ?, location = ?, empno = ?, hiredate = ?, deptno = ?, salary = ?, dob = ?, blood_group = ?, gender = ? WHERE id = ?";
 	public static final String Java_Final_Save_checkDuplicateQuery = "SELECT COUNT(*) FROM java WHERE id = ?";

 	// Java_Search_Batch_Id_Download
 	public static final String Java_Search_Batch_Id_Download_selectQuery = "SELECT * FROM java WHERE batch_id=?";

 	// Python_Batch_Id
 	public static final String Python_Batch_Id_selectQuery = "SELECT DISTINCT batch_id FROM python";
 	public static final String Python_Batch_Id_insertQuery = "INSERT INTO python_batch_id (batch_id) VALUES (?)";
 	public static final String Python_Batch_Id_existingBatchIdsQuery = "SELECT batch_id FROM python_batch_id";

 	// Python_Employee_Search_Download
 	public static final String Python_Employee_Search_Download_Select_python = "SELECT * FROM python WHERE id = ?";

 	// Python_Final_Save
 	public static final String Python_Final_Save_selectQuery = "SELECT * FROM dummy_2";
 	public static final String Python_Final_Save_insertQuery = "INSERT INTO python (name, location, gender, batch_id) VALUES (?, ?, ?, ?)";
 	public static final String Python_Final_Save_updateQuery = "UPDATE python SET name = ?, location = ?, gender = ? WHERE id = ?";
 	public static final String Python_Final_Save_checkDuplicateQuery = "SELECT COUNT(*) FROM python WHERE id = ?";

 	// Python_Search_Batch_Id_Download
 	public static final String Python_Search_Batch_Id_Download_selectQuery = "SELECT * FROM python WHERE batch_id=?";
 	 	
 	//UserAccessView
 	public static final String UserAccessView_selectAllQuery= "SELECT * FROM user_access";
 	public static final String UserAccessView_truncateUserQuery= "TRUNCATE TABLE [user]";
 	public static final String UserAccessView_truncateUserAccessQuery= "TRUNCATE TABLE user_access";
 	
 	//PythonPage
 	public static final String PythonPage_selectQuery= "SELECT * FROM python";

 	//Python_Show_All_Batches
 	 public static final String Python_Show_All_Batches_selectQuery= "SELECT * FROM python_batch_id";

 	//Python_Employee_Search
     public static final String Python_Employee_Search_selectQuery= "SELECT * FROM python WHERE id = ?";

    //Java Show_All_Batches
  	public static final String Show_All_Batches_Select_Batch_Id= "SELECT * FROM batch_id";
  	
    //JavaPage
   	 public static final String JavaPage_selectQuery= "SELECT * FROM java";

    //Java_Employee_Search
     public static final String Java_Employee_Search_selectQuery= "SELECT * FROM java WHERE id = ?";
}

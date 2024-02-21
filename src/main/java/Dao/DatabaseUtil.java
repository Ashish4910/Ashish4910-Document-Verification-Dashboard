package Dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

	private static final String DATABASE_URL = "jdbc:sqlserver://DESKTOP-T477JVJ;databaseName=ems;encrypt=false;";
	private static final String DATABASE_USERNAME = "root";
	private static final String DATABASE_PASSWORD = "dvd@123";

	public static Connection getConnection() throws Exception {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		return DriverManager.getConnection(DATABASE_URL, DATABASE_USERNAME, DATABASE_PASSWORD);
	}

	public static void closeConnection(Connection connection) {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}